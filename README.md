# README

* User

|  Name  |  culumn  |
| ---- | ---- |
|  id  |  integer  |
|  name  |  string  |
|  email  |  string  |
|  password_digest  |  string  |

* Task

|  Name  |  culumn  |
| ---- | ---- |
|  user_id  |  bigint  |
|  title  |  string  |
|  content  |  text  |
|  status  |  integer  |
|  deadline  |  date  |
|  priority  |  integer  |

* Session

|  Name  |  culumn  |
| ---- | ---- |
|  user_id  |  bigint  |
|  email  |  string  |
|  password_digest  |  string  |

* Label

|  Name  |  culumn  |
| ---- | ---- |
|  task_id  |  bigint  |
|  name  |  string  |


|  Herokuへのデプロイ方法  |
| ---- |
|  1.アセットプリコンパイルをする  |
|  :$ rails assets:precompile RAILS_ENV=production  |
|  2.コミットする  |
|  :$ git add .  |
|  :$ git commit -m "init"  |
|  3.Herokuに新しいアプリケーションを作成  |
|  :$ heroku create  |
|  4.Herokuにデプロイをする  |
|  :$ git push heroku master  |