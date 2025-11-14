<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
// 检查用户是否已登录，如果已登录则跳转到个人信息页面
if (session.getAttribute("user") != null) {
    response.sendRedirect("profile");
    return;
}
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.bootcdn.net/ajax/libs/normalize/8.0.1/normalize.min.css" rel="stylesheet">
    <link href="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <title>医疗云系统 - 智慧医疗，便捷服务</title>
    <style>
        /* 蓝色主色调样式 */
        body {
            font-family: 'Microsoft YaHei', Arial, sans-serif;
            background-color: #f8f9fa;
            line-height: 1.6;
        }
        
        .header {
            background: linear-gradient(135deg, #1e66d9, #0c57c2);
            color: white;
            padding: 30px 0;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }
        
        .header h1 {
            margin: 0;
            font-size: 2.8em;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .header p {
            margin: 10px 0 0 0;
            font-size: 1.2em;
            opacity: 0.9;
        }
        
        .navbar {
            background-color: #0d5fc9 !important;
            border: none;
            border-radius: 0;
            margin-bottom: 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar-default .navbar-brand,
        .navbar-default .navbar-nav > li > a {
            color: white !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .navbar-default .navbar-nav > li > a:hover,
        .navbar-default .navbar-nav > li > a:focus {
            background-color: #0a4eaa !important;
            color: white !important;
            transform: translateY(-1px);
        }
        
        .navbar-default .navbar-nav > .active > a,
        .navbar-default .navbar-nav > .active > a:hover,
        .navbar-default .navbar-nav > .active > a:focus {
            background-color: #0a4eaa !important;
            color: white !important;
            box-shadow: inset 0 -3px 0 #fff;
        }
        
        .feature-card {
            background: white;
            border-radius: 12px;
            padding: 35px 30px;
            margin: 20px 0;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            cursor: pointer;
            height: 320px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border: 1px solid #f0f0f0;
            position: relative;
            overflow: hidden;
        }
        
        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, #0d5fc9, #0a4eaa);
        }
        
        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }
        
        .feature-card h3 {
            color: #0d5fc9;
            margin-bottom: 20px;
            font-weight: 600;
            font-size: 1.5em;
        }
        
        .feature-icon {
            font-size: 56px;
            color: #0d5fc9;
            margin-bottom: 20px;
            display: block;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #0d5fc9, #0a4eaa);
            border: none;
            border-radius: 6px;
            padding: 12px 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(13, 95, 201, 0.3);
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #0a4eaa, #084191);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(13, 95, 201, 0.4);
        }
        
        .welcome-section {
            background: linear-gradient(135deg, #e3f2fd, #f0f7ff);
            padding: 60px 0;
            margin-bottom: 40px;
            border-bottom: 1px solid #d1e3f8;
        }
        
        .welcome-section h2 {
            color: #0d5fc9;
            margin-bottom: 20px;
            font-weight: 600;
            font-size: 2.2em;
        }
        
        .welcome-section p {
            color: #666;
            font-size: 1.2em;
            margin-bottom: 30px;
        }
        
        .footer {
            background: linear-gradient(135deg, #0d5fc9, #0a4eaa);
            color: white;
            padding: 30px 0;
            margin-top: 60px;
            text-align: center;
        }
        
        .login-prompt {
            text-align: center;
            margin: 40px 0;
            padding: 30px;
            background: linear-gradient(135deg, #fff9e6, #fff3cd);
            border: 1px solid #ffeaa7;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        
        .login-prompt h3 {
            color: #856404;
            margin-bottom: 15px;
            font-weight: 600;
        }
        
        .login-prompt p {
            color: #856404;
            font-size: 1.1em;
            margin-bottom: 20px;
        }
        
        .stats-section {
            background: white;
            padding: 50px 0;
            margin: 40px 0;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
        }
        
        .stat-number {
            font-size: 2.5em;
            font-weight: bold;
            color: #0d5fc9;
            display: block;
        }
        
        .stat-label {
            color: #666;
            font-size: 1.1em;
        }
        
        .feature-highlight {
            background: linear-gradient(135deg, #f8f9ff, #f0f7ff);
            border-left: 4px solid #0d5fc9;
            padding: 20px;
            margin: 20px 0;
            border-radius: 0 8px 8px 0;
        }
        
        .system-features {
            background: white;
            padding: 50px 0;
            border-radius: 12px;
            margin: 40px 0;
        }
    </style>
</head>
<body>
    <!-- 系统头部 -->
    <div class="header">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h1>🏥 医疗云系统</h1>
                    <p>智慧医疗，便捷服务 - 让健康触手可及</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 导航菜单 -->
    <nav class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
                        data-target="#navbar-collapse" aria-expanded="false">
                    <span class="sr-only">切换导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp">
                    <strong>医疗云首页</strong>
                </a>
            </div>
            
            <div class="collapse navbar-collapse" id="navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="index.jsp">首页</a></li>
                    <li><a href="#" id="nav-registration">预约挂号</a></li>
                    <li><a href="medicalHistory.jsp" id="nav-history">看病历史</a></li>
                    <li><a href="login.jsp">我的信息</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="login.jsp">🔐 登录</a></li>
                    <li><a href="register.jsp">📝 注册</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- 欢迎区域 -->
    <div class="welcome-section">
        <div class="container text-center">
            <h2>欢迎使用医疗云系统</h2>
            <p>我们致力于为您提供便捷、高效、安全的医疗服务体验</p>
            <div style="margin-top: 30px;">
                <a href="login.jsp" class="btn btn-primary btn-lg" style="padding: 15px 40px; font-size: 1.2em;">
                    🚀 立即登录体验
                </a>
                <a href="register.jsp" class="btn btn-default btn-lg" style="padding: 15px 40px; font-size: 1.2em; margin-left: 15px;">
                    📝 免费注册
                </a>
            </div>
        </div>
    </div>

    <!-- 登录提示 -->
    <div class="container">
        <div class="login-prompt">
            <h3>🔐 请先登录系统</h3>
            <p>登录后即可享受完整的医疗服务，包括预约挂号、电子病历、健康管理等全方位功能</p>
            <div>
                <a href="login.jsp" class="btn btn-primary" style="margin-right: 10px;">立即登录</a>
                <a href="register.jsp" class="btn btn-success">免费注册</a>
            </div>
        </div>
    </div>

    <!-- 数据统计 -->
    <div class="container stats-section">
        <div class="row">
            <div class="col-md-3 col-sm-6">
                <div class="stat-item">
                    <span class="stat-number">10,000+</span>
                    <span class="stat-label">注册用户</span>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-item">
                    <span class="stat-number">500+</span>
                    <span class="stat-label">合作医生</span>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-item">
                    <span class="stat-number">50+</span>
                    <span class="stat-label">合作医院</span>
                </div>
            </div>
            <div class="col-md-3 col-sm-6">
                <div class="stat-item">
                    <span class="stat-number">99.8%</span>
                    <span class="stat-label">用户满意度</span>
                </div>
            </div>
        </div>
    </div>

    <!-- 主要功能区域 -->
    <div class="container">
        <div class="row">
            <!-- 预约挂号功能卡片 -->
            <div class="col-md-4">
                <div class="feature-card text-center" id="registration-card">
                    <div class="feature-icon">📅</div>
                    <h3>智能预约挂号</h3>
                    <p>在线预约各大医院专家号源，智能推荐合适时间，无需排队等待，轻松就诊</p>
                    <a href="login.jsp" class="btn btn-primary">立即预约</a>
                </div>
            </div>
            
            <!-- 看病历史功能卡片 -->
            <div class="col-md-4">
                <div class="feature-card text-center" id="history-card">
                    <div class="feature-icon">📋</div>
                    <h3>电子病历管理</h3>
                    <p>完整记录就诊历史、检查报告、用药记录，建立个人健康档案，方便随时查阅</p>
                    <a href="login.jsp" class="btn btn-primary">查看历史</a>
                </div>
            </div>
            
            <!-- 我的信息功能卡片 -->
            <div class="col-md-4">
                <div class="feature-card text-center" id="profile-card">
                    <div class="feature-icon">👤</div>
                    <h3>个人中心</h3>
                    <p>管理个人资料、家庭成员信息、医保信息，个性化设置您的医疗服务偏好</p>
                    <a href="login.jsp" class="btn btn-primary">管理信息</a>
                </div>
            </div>
        </div>

        <!-- 系统介绍 -->
        <div class="row" style="margin-top: 50px;">
            <div class="col-md-12">
                <div class="feature-card">
                    <h3 class="text-center" style="color: #0d5fc9; margin-bottom: 30px;">关于医疗云系统</h3>
                    <p style="font-size: 1.1em; line-height: 1.8; text-align: center;">
                        医疗云系统是一个集预约挂号、电子病历、健康管理、在线咨询于一体的综合性医疗服务平台。<br>
                        我们致力于通过技术创新，为患者和医生提供更便捷、高效、安全的医疗服务体验。
                    </p>
                    
                    <div class="row" style="margin-top: 40px;">
                        <div class="col-md-6">
                            <div class="feature-highlight">
                                <h4 style="color: #0d5fc9; margin-bottom: 15px;">👥 患者服务</h4>
                                <ul style="line-height: 1.8;">
                                    <li><strong>智能预约挂号</strong> - 在线预约，减少排队时间</li>
                                    <li><strong>个人健康档案</strong> - 完整的电子病历管理</li>
                                    <li><strong>检查报告查询</strong> - 随时随地查看报告结果</li>
                                    <li><strong>在线健康咨询</strong> - 专业医生在线解答</li>
                                    <li><strong>用药提醒服务</strong> - 智能提醒服药时间</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="feature-highlight">
                                <h4 style="color: #0d5fc9; margin-bottom: 15px;">👨‍⚕️ 医生服务</h4>
                                <ul style="line-height: 1.8;">
                                    <li><strong>患者信息管理</strong> - 完整的患者档案管理</li>
                                    <li><strong>电子处方开具</strong> - 在线开具电子处方</li>
                                    <li><strong>智能排班管理</strong> - 灵活的排班和预约管理</li>
                                    <li><strong>医疗数据分析</strong> - 患者数据统计分析</li>
                                    <li><strong>在线咨询服务</strong> - 为患者提供在线指导</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 系统特色 -->
        <div class="row" style="margin-top: 40px;">
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">⚡</div>
                    <h3>高效便捷</h3>
                    <p>简化传统就医流程，智能推荐最优方案，大幅节省您的宝贵时间</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">🔒</div>
                    <h3>安全可靠</h3>
                    <p>采用银行级数据加密技术，严格保护患者隐私，确保医疗数据安全</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card text-center">
                    <div class="feature-icon">🌐</div>
                    <h3>全面覆盖</h3>
                    <p>连接全国多家三甲医院和专科诊所，提供全方位的医疗服务网络</p>
                </div>
            </div>
        </div>

        <!-- 使用流程 -->
        <div class="row" style="margin-top: 50px;">
            <div class="col-md-12">
                <div class="feature-card">
                    <h3 class="text-center" style="color: #0d5fc9; margin-bottom: 40px;">📝 使用流程</h3>
                    <div class="row text-center">
                        <div class="col-md-3">
                            <div style="font-size: 48px; color: #0d5fc9; margin-bottom: 15px;">1️⃣</div>
                            <h5>注册账号</h5>
                            <p>快速注册，完善个人信息</p>
                        </div>
                        <div class="col-md-3">
                            <div style="font-size: 48px; color: #0d5fc9; margin-bottom: 15px;">2️⃣</div>
                            <h5>选择服务</h5>
                            <p>预约挂号或在线咨询</p>
                        </div>
                        <div class="col-md-3">
                            <div style="font-size: 48px; color: #0d5fc9; margin-bottom: 15px;">3️⃣</div>
                            <h5>完成就诊</h5>
                            <p>线下就诊或在线问诊</p>
                        </div>
                        <div class="col-md-3">
                            <div style="font-size: 48px; color: #0d5fc9; margin-bottom: 15px;">4️⃣</div>
                            <h5>管理记录</h5>
                            <p>查看病历和管理健康</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
    <div class="footer">
        <div class="container">
            <p>&copy; 2025 医疗云系统. 版权所有.</p>
            <p style="margin-top: 10px; font-size: 0.9em; opacity: 0.8;">
                京ICP备xxxxxxxx号 | 联系电话：400-123-4567 | 服务邮箱：service@medicalcloud.com
            </p>
        </div>
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
    <script>
        // 首页特定的JavaScript代码
        $(document).ready(function() {
            console.log('医疗云系统首页加载完成');
            
            // 功能卡片点击事件
            $('.feature-card').on('click', function(e) {
                // 如果点击的是卡片内的按钮或链接，不触发卡片点击事件
                if ($(e.target).is('button') || $(e.target).is('a') || $(e.target).parent().is('a')) {
                    return;
                }
                
                var cardTitle = $(this).find('h3').text();
                showLoginPrompt('请先登录系统以使用 ' + cardTitle + ' 功能');
            });
            
            // 导航菜单点击事件
            // 导航菜单点击事件（仅保留预约挂号的阻止跳转，看病历史改为直接跳转）
            $('#nav-registration').on('click', function(e) {
                e.preventDefault();
                showLoginPrompt('请先登录系统');
            });
            
            // 显示登录提示
            function showLoginPrompt(message) {
                if (confirm(message + '\n\n是否立即跳转到登录页面？')) {
                    window.location.href = 'login.jsp';
                }
            }
            
            // 更新导航菜单激活状态
            $('.navbar-nav li').removeClass('active');
            $('.navbar-nav li:first-child').addClass('active');
            
            // 添加滚动动画效果
            $(window).scroll(function() {
                var scrolled = $(this).scrollTop();
                $('.feature-card').each(function() {
                    var position = $(this).offset().top;
                    var windowHeight = $(window).height();
                    if (position < scrolled + windowHeight - 100) {
                        $(this).addClass('animated');
                    }
                });
            });
            
            // 触发滚动事件以初始化动画
            $(window).scroll();
        });
    </script>
</body>
</html>