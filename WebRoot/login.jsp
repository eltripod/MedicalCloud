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
    <title>医疗云系统 - 登录</title>
    <style>
        /* 蓝色主色调样式 */
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background-color: #f8f9fa;
            background: linear-gradient(135deg, #e3f2fd 0%, #f8f9fa 100%);
            min-height: 100vh;
        }
        
        .login-header {
            background: linear-gradient(135deg, #1e66d9, #0c57c2);
            color: white;
            padding: 30px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 40px;
        }
        
        .login-header h1 {
            margin: 0;
            font-size: 2.5em;
            font-weight: 600;
        }
        
        .login-container {
            max-width: 400px;
            margin: 0 auto 60px;
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
            border: 1px solid #e1e5e9;
        }
        
        .login-form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-form-header h2 {
            color: #0d5fc9;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .login-form-header p {
            color: #666;
            font-size: 16px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control {
            border: 2px solid #e1e5e9;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 15px;
            transition: all 0.3s ease;
            height: 48px;
        }
        
        .form-control:focus {
            border-color: #0d5fc9;
            box-shadow: 0 0 0 3px rgba(13, 95, 201, 0.1);
        }
        
        .btn-login {
            background: linear-gradient(135deg, #0d5fc9, #0a4eaa);
            border: none;
            color: white;
            width: 100%;
            padding: 14px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .btn-login:hover {
            background: linear-gradient(135deg, #0a4eaa, #084191);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(13, 95, 201, 0.3);
        }
        
        .btn-login:active {
            transform: translateY(0);
        }
        
        .alert {
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 25px;
            border: none;
            font-weight: 500;
        }
        
        .alert-error {
            background-color: #fee;
            color: #c33;
            border-left: 4px solid #c33;
        }
        
        .alert-success {
            background-color: #efe;
            color: #363;
            border-left: 4px solid #363;
        }
        
        .test-accounts {
            margin-top: 30px;
            padding: 20px;
            background-color: #f0f7ff;
            border-radius: 8px;
            font-size: 14px;
            border: 1px solid #d1e3f8;
        }
        
        .test-accounts h4 {
            margin-top: 0;
            color: #0d5fc9;
            font-size: 16px;
            margin-bottom: 15px;
        }
        
        .test-account-item {
            margin-bottom: 8px;
            padding: 8px 0;
            border-bottom: 1px solid #e1e5e9;
        }
        
        .test-account-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        
        .test-account-item strong {
            color: #333;
        }
        
        .login-footer {
            text-align: center;
            margin-top: 25px;
            color: #666;
        }
        
        .login-footer a {
            color: #0d5fc9;
            text-decoration: none;
            font-weight: 500;
        }
        
        .login-footer a:hover {
            text-decoration: underline;
        }
        
        .footer {
            background-color: #0d5fc9;
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-top: 40px;
        }
        
        .brand-logo {
            text-align: center;
            margin-bottom: 10px;
        }
        
        .logo-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }
        
        .form-control-icon {
            position: relative;
        }
        
        .form-control-icon input {
            padding-left: 45px;
        }
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <%
        // 检查用户是否已登录，如果已登录则跳转到个人信息页面
        if (session.getAttribute("user") != null) {
            response.sendRedirect("profile");
            return;
        }
    %>
    
    <!-- 系统头部 -->
    <div class="login-header">
        <div class="container text-center">
            <div class="brand-logo">
                <div class="logo-icon">🏥</div>
            </div>
            <h1>医疗云系统</h1>
            <p>智慧医疗，便捷服务</p>
        </div>
    </div>

    <!-- 登录表单 -->
    <div class="container">
        <div class="login-container">
            <div class="login-form-header">
                <h2>用户登录</h2>
                <p>请输入您的账号和密码</p>
            </div>
            
            <!-- 错误信息显示 -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <strong>登录失败：</strong> ${errorMessage}
                </div>
            </c:if>
            
            <!-- 成功消息显示（例如退出登录后） -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    ${successMessage}
                </div>
            </c:if>
            
            <form action="login" method="post" id="loginForm">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <div class="form-control-icon">
                        <span class="input-icon">👤</span>
                        <input type="text" class="form-control" id="username" name="username" 
                               placeholder="请输入用户名" required value="${param.username}">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">密码</label>
                    <div class="form-control-icon">
                        <span class="input-icon">🔒</span>
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="请输入密码" required>
                    </div>
                </div>
                
                <button type="submit" class="btn-login" id="loginBtn">
                    <span class="btn-text">登录系统</span>
                    <span class="btn-loading" style="display:none;">登录中...</span>
                </button>
            </form>
            
            <!-- 测试账号区域 -->
            <div class="test-accounts">
                <h4>📋 测试账号</h4>
                <div class="test-account-item">
                    <strong>管理员账号：</strong> admin / 123456
                </div>
                <div class="test-account-item">
                    <strong>患者账号：</strong> patient01 / 123456
                </div>
                <div class="test-account-item">
                    <strong>医生账号：</strong> doctor01 / 123456
                </div>
            </div>
            
            <div class="login-footer">
                <p>还没有账号？ <a href="#">联系管理员注册</a></p>
                <p><a href="index.jsp">← 返回首页</a></p>
            </div>
        </div>
    </div>

    <div class="footer">
        <div class="container">
            &copy; 2025 医疗云系统. 版权所有.
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            console.log('登录页面加载完成');
            
            // 自动聚焦用户名输入框
            $('#username').focus();
            
            // 表单提交处理
            $('#loginForm').on('submit', function(e) {
                var username = $('#username').val().trim();
                var password = $('#password').val().trim();
                var loginBtn = $('#loginBtn');
                var btnText = $('.btn-text');
                var btnLoading = $('.btn-loading');
                
                // 基本验证
                if (!username) {
                    alert('请输入用户名');
                    $('#username').focus();
                    return false;
                }
                
                if (!password) {
                    alert('请输入密码');
                    $('#password').focus();
                    return false;
                }
                
                // 显示加载状态
                btnText.hide();
                btnLoading.show();
                loginBtn.prop('disabled', true);
                
                // 防止重复提交
                e.preventDefault();
                
                // 延迟提交以显示加载效果
                setTimeout(function() {
                    $('#loginForm')[0].submit();
                }, 500);
                
                return true;
            });
            
            // 回车键提交表单
            $(document).on('keypress', function(e) {
                if (e.which === 13) { // 回车键
                    $('#loginForm').submit();
                }
            });
            
            // 输入框内容变化时移除错误状态
            $('input').on('input', function() {
                $(this).removeClass('error');
                $('.alert-error').slideUp();
            });
            
            // 测试账号快速填充
            $('.test-account-item').on('click', function() {
                var text = $(this).text();
                var matches = text.match(/(\w+)\s*\/\s*(\w+)/);
                
                if (matches && matches.length >= 3) {
                    var username = matches[1];
                    var password = matches[2];
                    
                    $('#username').val(username);
                    $('#password').val(password);
                    
                    // 高亮显示已填充的测试账号
                    $('.test-account-item').removeClass('active');
                    $(this).addClass('active');
                    
                    // 自动提交表单
                    setTimeout(function() {
                        $('#loginForm').submit();
                    }, 300);
                }
            });
        });
    </script>
</body>
</html>