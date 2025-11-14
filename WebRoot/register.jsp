<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>医疗云系统 - 用户注册</title>
    <style>
        body { 
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background: linear-gradient(135deg, #e3f2fd 0%, #f8f9fa 100%);
            margin: 0; padding: 20px; min-height: 100vh;
        }
        .register-container {
            max-width: 500px; margin: 30px auto; background: white;
            padding: 40px; border-radius: 10px; box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .register-header { text-align: center; margin-bottom: 30px; }
        .register-header h2 { color: #0d5fc9; margin-bottom: 10px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        .required:after { content: " *"; color: red; }
        input, select { 
            width: 100%; padding: 12px; border: 2px solid #e1e5e9;
            border-radius: 5px; font-size: 14px; box-sizing: border-box;
        }
        input:focus, select:focus { 
            border-color: #0d5fc9; outline: none; 
            box-shadow: 0 0 0 2px rgba(13, 95, 201, 0.1);
        }
        .btn-register {
            width: 100%; padding: 12px; background: #28a745; color: white;
            border: none; border-radius: 5px; font-size: 16px; cursor: pointer;
            margin-top: 10px; font-weight: bold;
        }
        .btn-register:hover { background: #218838; }
        .btn-back {
            width: 100%; padding: 10px; background: #6c757d; color: white;
            border: none; border-radius: 5px; margin-top: 10px; cursor: pointer;
        }
        .btn-back:hover { background: #545b62; }
        .alert {
            padding: 12px; border-radius: 5px; margin-bottom: 20px;
            border-left: 4px solid;
        }
        .alert-error {
            background: #fee; color: #c33; border-color: #c33;
        }
        .alert-success {
            background: #efe; color: #363; border-color: #363;
        }
        .form-row {
            display: flex; gap: 15px;
        }
        .form-row .form-group {
            flex: 1;
        }
        .password-strength {
            margin-top: 5px; font-size: 12px;
        }
        .strength-weak { color: #dc3545; }
        .strength-medium { color: #fd7e14; }
        .strength-strong { color: #28a745; }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h2>用户注册</h2>
            <p>创建您的医疗云系统账号</p>
        </div>
        
        <!-- 错误信息显示 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-error">
                <strong>注册失败：</strong> ${errorMessage}
            </div>
        </c:if>
        
        <!-- 成功信息显示 -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                ${successMessage}
            </div>
        </c:if>
        
        <form action="register" method="post" id="registerForm">
            <!-- 基本信息 -->
            <div class="form-row">
                <div class="form-group">
                    <label for="username" class="required">用户名</label>
                    <input type="text" id="username" name="username" 
                           placeholder="3-20位字母、数字或下划线" 
                           value="${param.username}" required
                           pattern="^[a-zA-Z0-9_]{3,20}$">
                </div>
                <div class="form-group">
                    <label for="userType" class="required">用户类型</label>
                    <select id="userType" name="userType" required>
                        <option value="">请选择用户类型</option>
                        <option value="PATIENT" ${param.userType == 'PATIENT' ? 'selected' : ''}>患者</option>
                        <option value="DOCTOR" ${param.userType == 'DOCTOR' ? 'selected' : ''}>医生</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="password" class="required">密码</label>
                    <input type="password" id="password" name="password" 
                           placeholder="至少6位密码" required minlength="6">
                    <div id="passwordStrength" class="password-strength"></div>
                </div>
                <div class="form-group">
                    <label for="confirmPassword" class="required">确认密码</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" 
                           placeholder="再次输入密码" required>
                    <div id="passwordMatch" class="password-strength"></div>
                </div>
            </div>
            
            <!-- 个人信息 -->
            <div class="form-row">
                <div class="form-group">
                    <label for="realName" class="required">真实姓名</label>
                    <input type="text" id="realName" name="realName" 
                           placeholder="请输入真实姓名" 
                           value="${param.realName}" required>
                </div>
                <div class="form-group">
                    <label for="gender" class="required">性别</label>
                    <select id="gender" name="gender" required>
                        <option value="">请选择性别</option>
                        <option value="男" ${param.gender == '男' ? 'selected' : ''}>男</option>
                        <option value="女" ${param.gender == '女' ? 'selected' : ''}>女</option>
                    </select>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="phone" class="required">手机号码</label>
                    <input type="tel" id="phone" name="phone" 
                           placeholder="11位手机号码" 
                           value="${param.phone}" required
                           pattern="^1[3-9]\d{9}$">
                </div>
                <div class="form-group">
                    <label for="email">电子邮箱</label>
                    <input type="email" id="email" name="email" 
                           placeholder="选填，用于找回密码" 
                           value="${param.email}">
                </div>
            </div>
            
            <button type="submit" class="btn-register" id="registerBtn">立即注册</button>
            <button type="button" class="btn-back" onclick="window.location.href='login.jsp'">
                返回登录
            </button>
        </form>
        
        <div style="text-align: center; margin-top: 20px; color: #666;">
            <p>已有账号？ <a href="login.jsp">立即登录</a></p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            const passwordStrength = document.getElementById('passwordStrength');
            const passwordMatch = document.getElementById('passwordMatch');
            const registerForm = document.getElementById('registerForm');
            const registerBtn = document.getElementById('registerBtn');
            
            // 密码强度检测
            password.addEventListener('input', function() {
                const pwd = this.value;
                let strength = '';
                let strengthText = '';
                
                if (pwd.length === 0) {
                    strength = '';
                    strengthText = '';
                } else if (pwd.length < 6) {
                    strength = 'strength-weak';
                    strengthText = '密码太短';
                } else if (pwd.length < 8) {
                    strength = 'strength-medium';
                    strengthText = '密码强度中等';
                } else {
                    // 检查是否包含数字、字母、特殊字符
                    const hasNumber = /\d/.test(pwd);
                    const hasLetter = /[a-zA-Z]/.test(pwd);
                    const hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(pwd);
                    
                    if (hasNumber && hasLetter && hasSpecial) {
                        strength = 'strength-strong';
                        strengthText = '密码强度强';
                    } else if ((hasNumber && hasLetter) || (hasLetter && hasSpecial) || (hasNumber && hasSpecial)) {
                        strength = 'strength-medium';
                        strengthText = '密码强度中等';
                    } else {
                        strength = 'strength-weak';
                        strengthText = '密码强度弱';
                    }
                }
                
                passwordStrength.className = 'password-strength ' + strength;
                passwordStrength.textContent = strengthText;
            });
            
            // 密码匹配检测
            confirmPassword.addEventListener('input', function() {
                if (password.value !== this.value) {
                    passwordMatch.className = 'password-strength strength-weak';
                    passwordMatch.textContent = '密码不匹配';
                } else {
                    passwordMatch.className = 'password-strength strength-strong';
                    passwordMatch.textContent = '密码匹配';
                }
            });
            
            // 表单提交验证
            registerForm.addEventListener('submit', function(e) {
                let isValid = true;
                let errorMessage = '';
                
                // 检查密码匹配
                if (password.value !== confirmPassword.value) {
                    isValid = false;
                    errorMessage = '两次输入的密码不一致';
                }
                
                // 检查手机格式
                const phone = document.getElementById('phone').value;
                const phoneRegex = /^1[3-9]\d{9}$/;
                if (!phoneRegex.test(phone)) {
                    isValid = false;
                    errorMessage = '请输入正确的手机号码';
                }
                
                if (!isValid) {
                    e.preventDefault();
                    alert(errorMessage);
                    return false;
                }
                
                // 显示加载状态
                registerBtn.disabled = true;
                registerBtn.innerHTML = '注册中...';
                return true;
            });
            
            // 用户名实时验证
            const usernameInput = document.getElementById('username');
            usernameInput.addEventListener('blur', function() {
                const username = this.value;
                const usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
                
                if (username && !usernameRegex.test(username)) {
                    this.style.borderColor = '#dc3545';
                } else {
                    this.style.borderColor = '#e1e5e9';
                }
            });
        });
    </script>
</body>
</html>