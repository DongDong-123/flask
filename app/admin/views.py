from . import admin
from flask import request,render_template,session,abort
from app.models import *

# 限制登录
@admin.before_request
def check_login():
    # 判断跳转的页面是否需要登录
    urllist = ['/admin/login/']
    if not request.path in urllist:
        # 判断是否登录
        if not session.get('AdminUsers',None):
            # 跳转到登录页面
            return '<script>alert("请先登录");location.href="/admin/login"</script>'

# 后台首页
@admin.route("/index")
def index():
	return render_template('admin/index.html')

# 博文管理
@admin.route("/blogs/")
def blogs():
	arts = db.session.query(Article,Types,Users)\
	.filter(Article.type_id == Types.id)\
	.filter(Article.uid == Users.id)\
	.order_by(Article.addtime.desc()).all()
	# print('arts',arts)
	return render_template('admin/blogs.html',arts=arts)

# 屏蔽博文
@admin.route("/prohibit/<id>/")
def prohibit(id):
	try:
		pr = db.session.query(Article).get(id)
		pr.status = 2
		db.session.add(pr)
		db.session.commit()
		return '<script>alert("屏蔽成功");location.href="/admin/blogs/"</script>'
	except:
		return '<script>alert("屏蔽失败");location.href="/admin/blogs/"</script>'

# 解除屏蔽
@admin.route("/recover/<id>/")
def recover(id):
	try:
		pr = db.session.query(Article).get(id)
		pr.status = 1
		db.session.add(pr)
		db.session.commit()
		return '<script>alert("恢复成功");location.href="/admin/blogs/"</script>'
	except:
		return '<script>alert("恢复失败");location.href="/admin/blogs/"</script>'

# 分类列表
@admin.route("/typemanage/")
def typemanage():
	ty = db.session.query(Types).all()

	return render_template("admin/typemanage.html",ty=ty)

# 分类管理
# 添加
@admin.route("/typeadd/<tid>")
def typeadd(tid):
	# tadd = Types()
	ty = db.session.query(Types).filter_by(id=tid).first()

	return render_template("admin/typeadd.html",ty=ty)
# 执行添加
@admin.route("/addupdate/<tid>",methods=['GET','POST'])
def addupdate(tid):
	adds = Types()
	adds.tname = request.form['addname']
	adds.pid = tid

	db.session.add(adds)
	db.session.commit()
	return '<script>alert("添加成功");location.href="/admin/typemanage/"</script>'


# 编辑
@admin.route("/typeedit/<tid>")
def typeedit(tid):
	ty = db.session.query(Types).filter_by(id=tid).first()
	return render_template('admin/typechange.html',ty=ty)

# 修改
@admin.route("/typechange/<tid>",methods=['GET','POST'])
def typechange(tid):
	ty = db.session.query(Types).filter_by(id=tid).first()
	ty.tname = request.form['name']
	db.session.add(ty)
	db.session.commit()
	return '<script>alert("修改成功");location.href="/admin/typemanage/"</script>'

# 分类删除
@admin.route("/deltype/<tid>")
def deltype(tid):
	com = db.session.query(Types).filter_by(id=tid).first()
	db.session.delete(com)
	db.session.commit()
	return '<script>alert("删除成功");location.href="/admin/typemanage/"</script>'


# 评论列表
@admin.route("/comment/")
def comment():
	cominfo = db.session.query(Comment,Article,Users)\
	.filter(Comment.article_id == Article.id)\
	.filter(Comment.user_id == Users.id)\
	.all()

	return render_template('admin/comment.html',cominfo=cominfo)


# 评论管理
@admin.route("/delcomment/<cid>")
def delcomment(cid):
	com = db.session.query(Comment).filter_by(id=cid).first()
	db.session.delete(com)
	db.session.commit()
	return '<script>alert("删除成功");location.href="/admin/comment/"</script>'


# 后台登录
@admin.route("/login/",methods=['GET','POST'])
def login():
    if request.method == 'GET':
        return render_template('admin/login.html')

    else:
        if request.form['password']=='superadmin.com':
            # 写入session
            session['AdminUsers'] = {'name':'超级管理员'}

            return '<script>alert("登录成功");location.href="/admin/index"</script>'

        return '<script>alert("账号或密码错误");location.href="/admin/index"</script>'

# 后台退出
@admin.route('/logout/')
def logout():
	session['AdminUsers'] = {}
	return '<script>alert("已退出登录");location.href="/admin/login/"</script>'

