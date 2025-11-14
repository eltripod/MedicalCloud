<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.bootcdn.net/ajax/libs/normalize/8.0.1/normalize.min.css" rel="stylesheet">
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <title>医疗云系统 - 管理后台</title>
    <style>
        /* 管理员专属样式 */
        .admin-header {
            background: linear-gradient(135deg, #d9534f, #c9302c);
            color: white;
            padding: 20px 0;
        }
        
        .admin-nav {
            background-color: #d9534f !important;
        }
        
        .stat-card {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #d9534f;
        }
        
        .stat-label {
            color: #666;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
    <%
        // 检查用户是否登录且为管理员
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        com.medical.model.User user = (com.medical.model.User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getUserType())) {
            response.sendRedirect("profile.jsp");
            return;
        }
    %>
    
    <!-- 系统头部 -->
    <div class="admin-header">
        <div class="container">
            <h1>医疗云系统 - 管理后台</h1>
            <p>系统管理与监控</p>
        </div>
    </div>

    <!-- 导航菜单 -->
    <div class="servicePortfolio">
        <div class="navbar navbar-default admin-nav">
            <div class="container">
                <div class="navbar-header">
                    <a href="dashboard.jsp" class="navbar-brand">管理首页</a>
                </div>
                <ul class="nav navbar-nav">
                    <li class="active"><a href="dashboard.jsp">仪表板</a></li>
                    <li><a href="#">用户管理</a></li>
                    <li><a href="#">医生管理</a></li>
                    <li><a href="#">预约管理</a></li>
                    <li><a href="#">系统设置</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" style="color: #ffeb3b !important;">
                        管理员：${user.realName}
                    </a></li>
                    <li><a href="login?action=logout">退出登录</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 统计信息 -->
    <div class="container" style="margin-top: 20px;">
        <div class="row">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-number">156</div>
                    <div class="stat-label">总用户数</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-number">42</div>
                    <div class="stat-label">医生数量</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-number">89</div>
                    <div class="stat-label">今日预约</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-number">96%</div>
                    <div class="stat-label">系统可用性</div>
                </div>
            </div>
        </div>

        <!-- 用户列表 -->
        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">用户列表</h3>
                    </div>
                    <div class="panel-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>用户ID</th>
                                    <th>用户名</th>
                                    <th>真实姓名</th>
                                    <th>用户类型</th>
                                    <th>手机号</th>
                                    <th>注册时间</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="u" items="<%= new com.medical.dao.UserDAO().getAllUsers() %>">
                                    <tr>
                                        <td>${u.userId}</td>
                                        <td>${u.username}</td>
                                        <td>${u.realName}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${u.userType == 'PATIENT'}">患者</c:when>
                                                <c:when test="${u.userType == 'DOCTOR'}">医生</c:when>
                                                <c:when test="${u.userType == 'ADMIN'}">管理员</c:when>
                                                <c:otherwise>${u.userType}</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${u.phone}</td>
                                        <td>${u.createTime}</td>
                                        <td>
                                            <button class="btn btn-xs btn-info">查看</button>
                                            <button class="btn btn-xs btn-warning">编辑</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer text-center">
        &copy; 2025 医疗云系统. 版权所有.
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</body>
</html>