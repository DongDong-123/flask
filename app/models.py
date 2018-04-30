from flask import Flask
from flask_sqlalchemy import SQLAlchemy
import datetime,hashlib

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+pymysql://root:123456@localhost/blog"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True

db = SQLAlchemy(app)


#会员数据模型
class Users(db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer,primary_key=True)
    name = db.Column(db.String(100),unique=True)
    pwd= db.Column(db.String(100))
    email= db.Column(db.String(100))
    phone= db.Column(db.String(11))
    face = db.Column(db.String(255),default='user.jpg')
    # 1 正常,2,禁用
    status = db.Column(db.Integer,default=1)
    addtime = db.Column(db.DateTime,index=True,default=datetime.datetime.now)

    # 密码加密
    def md5password(self, pwd):
        h1 = hashlib.md5()
        h1.update(pwd.encode(encoding='utf-8'))
        return h1.hexdigest()

    # 登录密码验证
    def checkpassword(self,pwd):
        if self.md5password(pwd) == self.pwd:
            return True
        else:
            return False

# 分类模型
class Types(db.Model):
    __tablename__ = 'types'
    id = db.Column(db.Integer,primary_key=True)
    tname = db.Column(db.String(50),index=True)
    pid = db.Column(db.Integer)

# 文章模型
class Article(db.Model):
    __tablename__ = 'article'
    id = db.Column(db.Integer,primary_key=True)
    title = db.Column(db.String(255),index=True)
    context = db.Column(db.Text)
    type_id = db.Column(db.Integer)
    uid = db.Column(db.Integer)
    # 1 正常， 2 禁用
    status = db.Column(db.Integer,default=1)
    addtime = db.Column(db.DateTime,index=True,default=datetime.datetime.now)

# 标签模型
class Tags(db.Model):
    __tablename__ = 'tags'
    id = db.Column(db.Integer,primary_key=True)
    uid = db.Column(db.Integer,index=True)
    tagname = db.Column(db.String(50),index=True)

    def __repr(self):
        return '<Tags:{}>'.format(self.tagname)

# 文章标签关联
class Ats(db.Model):
    __tablename__ = 'ats'
    id = db.Column(db.Integer,primary_key=True)
    article_id = db.Column(db.Integer)
    tags_id = db.Column(db.Integer)


# 评论模型
class Comment(db.Model):
    __tablename__ = 'comment'
    id = db.Column(db.Integer,primary_key=True)
    article_id = db.Column(db.Integer)
    user_id = db.Column(db.Integer)
    con = db.Column(db.Text)
    to_id = db.Column(db.Integer)
    addtime = db.Column(db.DateTime,index=True,default=datetime.datetime.now)

    
# if __name__ == '__main__':
#     # db.drop_all()
#     db.create_all()