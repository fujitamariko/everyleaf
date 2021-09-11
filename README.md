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
|  content  |  string  |
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
