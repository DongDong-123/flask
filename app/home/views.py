from . import home
from flask import request,render_template,session,abort
from app.models import *
import hashlib,os,json,time,random,re


# 限制登录
@home.before_request
def check_login():
    # 判断跳转的页面是否需要登录
    urllist = ['/write/']
    if request.path in urllist:
        # 判断是否登录
        if not session.get('VipUsers',None):
            # 跳转到登录页面
            return '<script>alert("请先登录");location.href="/login"</script>'

# 首页
@home.route("/")
def index():
    arts = db.session.query(Article,Types,Users)\
    .filter(Article.type_id == Types.id)\
    .filter(Article.uid == Users.id)\
    .filter(Article.status == 1)\
    .order_by(Article.addtime.desc()).all()
    # print(arts)

    return render_template('home/index.html',arts=arts)


#注册
@home.route("/register",methods=['GET',"POST"])
def register():
    if request.method=='GET':
        # 返回注册页面
        return render_template('home/login/register.html')
    else:
        u = Users()
        u.name = request.form['username']
        u.pwd = u.md5password(request.form['password'])
        u.email = request.form['email']
        u.phone = request.form['phone']
        # 执行添加
        db.session.add(u)
        db.session.commit()
       
        # 执行注册
        return '<script>alert("注册成功,请登录");location.href="/login"</script>'

# 登录
@home.route("/login",methods=['GET',"POST"])
def login():
    if request.method == 'GET':
        return render_template('home/login/login.html')

    else:
        # 获取用户名
        u = Users.query.filter_by(name=request.form['username']).first()
        if u:
            # 验证密码
            # if u.pwd ==request.form['password']:
            if u.checkpassword(request.form['password']):
                # 写入session
                session['VipUsers'] = {'uid':u.id,'uname':u.name}

                return '<script>alert("登录成功");location.href="/"</script>'


# 个人中心
@home.route("/personal/<uid>")
def personal(uid):
    # print('11')
    # uinfo = db.session.query(Users).get(id=uid)
    uinfo = db.session.query(Users).filter_by(id=int(uid)).first()
    # print('uinfo',uinfo)

    return render_template("home/personal.html",uinfo=uinfo )

# 修改个人信息
@home.route("/infoedit/<uid>")
def infoedit(uid):
    uedit = db.session.query(Users).filter_by(id=uid).first()

    return render_template("home/infoedit.html",uedit=uedit)

#执行修改
@home.route("/infoupdate/<uid>",methods=['GET',"POST"])
def infoupdate(uid):
    up = db.session.query(Users).filter_by(id=uid).first()
    up.email = request.form['email']
    up.phone = request.form['phone']

    db.session.add(up)
    db.session.commit()

    return '<script>alert("资料修改成功");location.href="/personal/'+uid+'"</script>'

# 发布博文
@home.route("/write/",methods=['GET',"POST"])
def write():
    if request.method == "GET":
        return render_template('home/myblog/add.html')

    else:
        # 发布文章
        try:
            a = Article()
            a.title = request.form['title']    
            a.context = request.form['content']
            a.type_id = request.form['pid']
            a.uid = session['VipUsers']['uid']
            db.session.add(a)
            db.session.commit()
        except:
            db.session.rollback()

            return '文章发布失败'
        # 创建标签
        try:
            ts = request.form['tags'].split(',')
            tagsarr = []
            for x in ts:
                tags = Tags.query.filter_by(tagname=x,uid=session['VipUsers']['uid']).first()
                if tags:
                    tagsarr.append(tags.id)
                else:
                    t= Tags()
                    t.uid = session['VipUsers']['uid']
                    t.tagname = x
                    db.session.add(t)
                    db.session.commit()
                    tagsarr.append(t.id)
        except:
            db.session.rollback()
            return '标签创建失败'
        # 标签关联文章
        try:
            for x in tagsarr:
                at = Ats()
                at.article_id = a.id
                at.tags_id = x
                db.session.add(at)
                db.session.commit()
        except:
            db.session.rollback()
            return '标签和文章关系创建失败'

        uname = session['VipUsers']['uname']
        return '<script>alert("文章发布成功");location.href="/'+uname+'/"</script>'

# 获取分类
@home.route('/gettypes/<pid>')
def gettypes(pid):
    ts = Types.query.filter_by(pid=pid).all()

    arr = []
    for x in ts:
        data = {'id':x.id,'tname':x.tname,'pid':x.pid}
        arr.append(data)

    jsts = json.dumps(arr)
    return jsts


# ueditor读取配置文件
@home.route('/ueditconfig/', methods=['GET', 'POST'])
def ueditconfig():
    # 导入地址
    from app import BASE_DIR
    # 获取请求动作
    action = request.args.get('action')
    result = {}
    # 读取配置文件
    if action == 'config':
    # 初始化时，返回配置文件给客户端
        with open(os.path.join(BASE_DIR,'static', 'ueditor', 'php',
                               'config.json')) as fp:
            try:
                # 删除 `/**/` 之间的注释
                CONFIG = json.loads(re.sub(r'\/\*.*\*\/', '', fp.read()))
            except:
                CONFIG = {}
        result = CONFIG

    # 文件上传
    if action  == 'uploadimage':
        upfile = request.files['upfile']  # 这个表单名称以配置文件为准
        # upfile 为 FileStorage 对象
        # 这里保存文件并返回相应的URL

        Suffix = upfile.filename.split('.').pop()
        filename = str(time.time())+str(random.randint(10000,99999))+'.'+Suffix
        imgurl = '/static/uploads/'+filename
        upfile.save(BASE_DIR+imgurl)

        result = {
            "state": "SUCCESS",
            "url": imgurl,
            "title": filename,
            "original":filename
        }


    return json.dumps(result)



# 博文编辑
@home.route("/edit/<aid>/")
def edit(aid):
    infos = db.session.query(Article,Tags)\
    .filter(Article.uid == Users.id)\
    .filter(Article.id == aid)\
    .first()
    # print('infos',infos)
    # print('infos.Tags.tagname',infos.Tags.tagname)
    # print('infos.Article.title',infos.Article.title)
    # print('infos.Article.context',infos.Article.context)

    return render_template("home/myblog/edit.html",infos=infos)

# 执行更改
@home.route("/Aupdate/<aid>",methods=['GET',"POST"])
def Aupdate(aid):
    # 发布修改文章
    try:
        a = db.session.query(Article).filter(Article.id == aid).first()
        a.title = request.form['title']    
        a.context = request.form['content']
        a.type_id = request.form['pid']
        a.uid = session['VipUsers']['uid']
        db.session.add(a)
        db.session.commit()
    except:
        db.session.rollback()

        return '文章修改失败'
    # 创建标签
    try:
        ts = request.form['tags'].split(',')
        tagsarr = []
        for x in ts:
            tags = Tags.query.filter_by(tagname=x,uid=session['VipUsers']['uid']).first()
            if tags:
                tagsarr.append(tags.id)
            else:
                t= Tags()
                t.uid = session['VipUsers']['uid']
                t.tagname = x
                db.session.add(t)
                db.session.commit()
                tagsarr.append(t.id)
    except:
        db.session.rollback()
        return '标签创建失败'
    # 标签关联文章
    try:
        for x in tagsarr:
            at = Ats()
            at.article_id = a.id
            at.tags_id = x
            db.session.add(at)
            db.session.commit()
    except:
        db.session.rollback()
        return '标签和文章关系创建失败'

    uname = session['VipUsers']['uname']
    return '<script>alert("文章修改成功");location.href="/'+uname+'/"</script>'


# 博文详情,
@home.route("/<name>/p/<aid>",methods=['GET','POST'])
def bloginfo(name,aid):
    if request.method == "GET":
        # 根据id查数据 
        info = db.session.query(Article,Users,Types)\
        .filter(Types.id == Article.type_id)\
        .filter(Article.uid == Users.id)\
        .filter(Article.id == aid)\
        .first()
    
        # 获取所有标签
        ts = db.session.query(Ats,Tags)\
        .filter(Ats.article_id == aid)\
        .filter(Ats.tags_id == Tags.id)\
        .all()
    
        # 获取当前文章的评论
        cons = db.session.query(Comment,Users)\
        .filter(Comment.user_id == Users.id)\
        .filter(Comment.article_id == aid)\
        .all()

        # 生成评论序号
        cons = enumerate(cons,start=1)
    
        return render_template("home/myblog/bloginfos.html",Ainfo=info,ts=ts,cons=cons)
    else:
        # 接受评论并显示
        c = Comment()
        c.article_id = aid
        c.user_id = session['VipUsers']['uid']
        c.con = request.form['con']
        c.to_id = request.form['toid']
        db.session.add(c)
        db.session.commit()

        return '<script>alert("评论成功");location.href="";</script>'

# 删除文章
@home.route('/delatricle/<aid>/',methods=['GET',"POST"])
def delatricle(aid):
    dels = Article.query.filter_by(id=aid).first()
    # 更改状态，实现逻辑删除
    dels.status=2
    db.session.add(dels)
    db.session.commit()

    return "<script>alert('删除成功');location.href='/'</script>"

# 我的微博页面
@home.route("/<name>/")
def myblog(name):

    u = Users.query.filter_by(name=name).first()

    if u:
        arts = db.session.query(Article,Types)\
        .filter(Article.type_id == Types.id)\
        .filter(Article.uid ==u.id)\
        .filter(Article.status == 1)\
        .all()

        return render_template("home/myblog/index.html",uinfo=u,arts=arts)
        
    abort(404)

# 退出登录
@home.route('/logout')
def logout():
    session['VipUsers'] = {}
    return "<script>alert('已退出登录');location.href='/'</script>"