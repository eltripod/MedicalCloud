<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.bootcdn.net/ajax/libs/normalize/8.0.1/normalize.min.css" rel="stylesheet">
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>医疗云系统 - 个人信息</title>
    <style>
        /* 蓝色主色调样式，与 medicalHistory.jsp 保持一致 */
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background-color: #f8f9fa;
            line-height: 1.8;
        }
        
        .header {
            background: linear-gradient(135deg, #1e66d9, #0c57c2);
            color: white;
            padding: 20px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        /* 导航栏样式（与 medicalHistory.jsp 完全一致） */
        .navbar {
            background-color: #0d5fc9 !important;
            border: none;
            border-radius: 0;
            margin-bottom: 0;
        }
        
        .navbar-default .navbar-brand,
        .navbar-default .navbar-nav > li > a {
            color: white !important;
            padding: 15px 20px;
            transition: all 0.3s ease;
        }
        
        .navbar-default .navbar-nav > li > a:hover {
            background-color: #0a4eaa !important;
        }
        
        .navbar-default .navbar-nav > .active > a {
            background-color: #0a4eaa !important;
            box-shadow: inset 0 -3px 0 #fff;
        }
        
        .user-welcome {
            background-color: #e3f2fd;
            padding: 20px 0;
            margin-bottom: 20px;
        }
        
        .profile-panel {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        
        .panel-heading {
            background-color: #0d5fc9 !important;
            color: white !important;
            border-bottom: none;
        }
        
        .btn-primary {
            background-color: #0d5fc9 !important;
            border-color: #0d5fc9 !important;
        }
        
        .alert {
            border-radius: 4px;
            padding: 12px;
            margin: 15px 0;
        }
        
        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .alert-error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .user-avatar {
            text-align: center;
            margin-bottom: 20px;
        }
        
        .avatar-icon {
            font-size: 80px;
            color: #0d5fc9;
        }
    </style>
</head>
<body>
    <%
        // 检查用户是否登录
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>
    
    <!-- 系统头部 -->
    <div class="header">
        <div class="container">
            <h1>医疗云系统</h1>
            <p>智慧医疗，便捷服务</p>
        </div>
    </div>

    <!-- 导航菜单（与 medicalHistory.jsp 完全一致） -->
    <nav class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
                        data-target="#profile-nav" aria-expanded="false">
                    <span class="sr-only">切换导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="index.jsp" class="navbar-brand">医疗云首页</a>
            </div>
            <div class="collapse navbar-collapse" id="profile-nav">
                <ul class="nav navbar-nav">
                    <li><a href="index.jsp"><i class="fa fa-home mr-1"></i>首页</a></li>
                    <li><a href="#" id="nav-registration"><i class="fa fa-calendar-check-o mr-1"></i>预约挂号</a></li>
                    <li><a href="medicalHistory.jsp"><i class="fa fa-file-text-o mr-1"></i>看病历史</a></li>
                    <li class="active"><a href="profile.jsp"><i class="fa fa-user-circle mr-1"></i>我的信息</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" style="color: #ffeb3b !important;">
                        <i class="fa fa-user mr-1"></i>欢迎，${user.realName}
                    </a></li>
                    <li><a href="login?action=logout"><i class="fa fa-sign-out mr-1"></i>退出登录</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 用户欢迎区域 -->
    <div class="user-welcome">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h3>欢迎回来，${user.realName}！</h3>
                    <p>用户类型: 
                        <c:choose>
                            <c:when test="${user.userType == 'PATIENT'}">患者</c:when>
                            <c:when test="${user.userType == 'DOCTOR'}">医生</c:when>
                            <c:when test="${user.userType == 'ADMIN'}">管理员</c:when>
                            <c:otherwise>${user.userType}</c:otherwise>
                        </c:choose>
                    </p>
                    <p>注册时间: <fmt:formatDate value="${user.createTime}" pattern="yyyy年MM月dd日" /></p>
                </div>
                <div class="col-md-4 text-right">
                    <div class="user-avatar">
                        <div class="avatar-icon">👤</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 主要功能区域 -->
    <div class="container">
        <!-- 操作结果提示 -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">${successMessage}</div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">${errorMessage}</div>
        </c:if>

        <div class="row">
            <div class="col-md-8 col-md-offset-2">
                <div class="profile-panel panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">个人基本信息</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal" action="profile" method="post">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户ID</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" value="${user.userId}" readonly>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" value="${user.username}" readonly>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">真实姓名</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" name="realName" 
                                           value="${user.realName}" required>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">性别</label>
                                <div class="col-sm-9">
                                    <select class="form-control" name="gender">
                                        <option value="男" ${user.gender == '男' ? 'selected' : ''}>男</option>
                                        <option value="女" ${user.gender == '女' ? 'selected' : ''}>女</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">出生日期</label>
                                <div class="col-sm-9">
                                    <input type="date" class="form-control" name="birthDate" 
                                           value="<fmt:formatDate value='${user.birthDate}' pattern='yyyy-MM-dd' />">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">手机号</label>
                                <div class="col-sm-9">
                                    <input type="tel" class="form-control" name="phone" 
                                           value="${user.phone}" required>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">电子邮箱</label>
                                <div class="col-sm-9">
                                    <input type="email" class="form-control" name="email" 
                                           value="${user.email}">
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">联系地址</label>
                                <div class="col-sm-9">
                                    <textarea class="form-control" name="address" rows="3">${user.address}</textarea>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-3 control-label">用户类型</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" 
                                           value='<c:choose>
                                                 <c:when test="${user.userType == 'PATIENT'}">患者</c:when>
                                                 <c:when test="${user.userType == 'DOCTOR'}">医生</c:when>
                                                 <c:when test="${user.userType == 'ADMIN'}">管理员</c:when>
                                                 <c:otherwise>${user.userType}</c:otherwise>
                                               </c:choose>' readonly>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-9">
                                    <button type="submit" class="btn btn-primary">保存修改</button>
                                    <a href="index.jsp" class="btn btn-default">返回首页</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="footer text-center">
        &copy; 2025 医疗云系统. 版权所有.
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script>
        // 页面加载完成后的操作
        $(document).ready(function() {
            // 表单验证
            $('form').on('submit', function() {
                var phone = $('input[name="phone"]').val();
                var email = $('input[name="email"]').val();
                
                // 手机号验证
                if (!/^1[3-9]\d{9}$/.test(phone)) {
                    alert('请输入正确的手机号码');
                    return false;
                }
                
                // 邮箱验证（如果填写了邮箱）
                if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                    alert('请输入正确的邮箱地址');
                    return false;
                }
                
                return true;
            });
            
            // 导航菜单点击事件（仅保留预约挂号的提示）
            $('#nav-registration').click(function(e) {
                e.preventDefault();
                alert('功能开发中，敬请期待！');
            });
        });
    </script>
</body>
</html>