from flask import Flask,render_template
import os

app = Flask(__name__)
app.debug = True



from app.home import home as home_blueprint
from app.admin import admin as admin_blueprint

app.register_blueprint(home_blueprint)
app.register_blueprint(admin_blueprint,url_prefix="/admin")


# 密钥
app.secret_key = 'abcdef'

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
