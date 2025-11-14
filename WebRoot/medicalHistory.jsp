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
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>医疗云系统 - 看病历史</title>
    <style>
        /* 继承蓝色主色调，保持风格统一 */
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
        
        .page-title {
            background-color: #e3f2fd;
            padding: 25px 0;
            margin-bottom: 30px;
            border-bottom: 1px solid #d1e3f8;
        }
        
        .page-title h2 {
            color: #0d5fc9;
            margin: 0;
            font-weight: 600;
        }
        
        .filter-panel {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .history-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 25px;
            margin-bottom: 30px;
            border-left: 4px solid #0d5fc9;
        }
        
        .history-header {
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }
        
        .history-header h3 {
            color: #0d5fc9;
            margin: 0 0 10px 0;
            font-weight: 600;
        }
        
        .history-meta {
            color: #6c757d;
            font-size: 14px;
        }
        
        .history-meta span {
            margin-right: 20px;
        }
        
        /* 横向时间轴样式 */
        .timeline {
    position: relative;
    margin: 30px 0;
    padding: 0;
    display: flex;
    width: 100%;
    overflow-x: auto; /* 横向滚动（可选） */
    padding-bottom: 10px; /* 滚动条预留空间 */
}
        
        .timeline::before {
    content: '';
    position: absolute;
    top: 30px;
    left: 0;
    width: 100%;
    height: 4px;
    background: #e3f2fd;
    border-radius: 2px;
}
        
        .timeline-item {
    position: relative;
    flex: 1; /* 所有节点均分宽度 */
    text-align: center;
    padding-top: 60px;
    box-sizing: border-box;
    min-width: 120px; /* 最小宽度，防止节点过挤（可选） */
}
        
        .timeline-dot {
    position: absolute;
    top: 30px;
    left: 50%;
    transform: translateX(-50%);
    width: 24px;
    height: 24px;
    border-radius: 50%;
    background: #0d5fc9;
    border: 4px solid #e3f2fd;
    z-index: 1;
}
        
        .timeline-dot.completed {
            background: #36b37e;
        }
        
        .timeline-dot.pending {
            background: #ffab00;
        }
        
        .timeline-dot.canceled {
            background: #e53e3e;
        }
        
        .timeline-label {
            font-weight: 500;
            color: #2d3748;
            margin-bottom: 5px;
            display: block;
        }
        
        .timeline-time {
            font-size: 13px;
            color: #6c757d;
        }
        
        .timeline-content {
            margin-top: 10px;
            font-size: 14px;
            color: #495057;
            background: #f8f9fa;
            padding: 8px 12px;
            border-radius: 4px;
            display: inline-block;
            max-width: 100%;
            word-wrap: break-word;
        }
        
        .no-data {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .no-data i {
            font-size: 60px;
            color: #e3f2fd;
            margin-bottom: 20px;
            display: block;
        }
        
        .no-data p {
            color: #6c757d;
            font-size: 16px;
            margin: 0;
        }
        
        .btn-primary {
            background-color: #0d5fc9 !important;
            border-color: #0d5fc9 !important;
            border-radius: 6px;
            padding: 8px 20px;
            font-weight: 500;
        }
        
        .btn-primary:hover {
            background-color: #0a4eaa !important;
            border-color: #0a4eaa !important;
        }
        
        .form-control {
            border: 1px solid #ced4da;
            border-radius: 6px;
            padding: 8px 12px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #0d5fc9;
            box-shadow: 0 0 0 3px rgba(13, 95, 201, 0.1);
        }
        
        .footer {
            background-color: #2d3748;
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-top: 60px;
            font-size: 14px;
        }
        
        /* 响应式适配 */
        
        
        
    </style>
</head>
<body>
    <%
        // 检查用户是否登录，未登录跳转到登录页
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        // 模拟用户信息
        com.medical.model.User user = new com.medical.model.User();
        user.setRealName("张三");
        user.setUserType("PATIENT");
    %>
    
    <!-- 系统头部 -->
    <div class="header">
        <div class="container">
            <h1>医疗云系统</h1>
            <p>智慧医疗，便捷服务</p>
        </div>
    </div>

    <!-- 导航菜单 -->
    <div class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
                        data-target="#history-nav" aria-expanded="false">
                    <span class="sr-only">切换导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="index.jsp" class="navbar-brand">医疗云首页</a>
            </div>
            <div class="collapse navbar-collapse" id="history-nav">
                <ul class="nav navbar-nav">
                    <li><a href="index.jsp"><i class="fa fa-home mr-1"></i>首页</a></li>
                    <li><a href="#" id="nav-registration"><i class="fa fa-calendar-check-o mr-1"></i>预约挂号</a></li>
                    <li class="active"><a href="medicalHistory.jsp"><i class="fa fa-file-text-o mr-1"></i>看病历史</a></li>
                    <li><a href="profile.jsp"><i class="fa fa-user-circle mr-1"></i>我的信息</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#" style="color: #ffeb3b !important;">
                        <i class="fa fa-user mr-1"></i>欢迎，${user.realName}
                    </a></li>
                    <li><a href="login?action=logout"><i class="fa fa-sign-out mr-1"></i>退出登录</a></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 页面标题 -->
    <div class="page-title">
        <div class="container">
            <h2><i class="fa fa-history mr-2"></i>我的看病历史</h2>
        </div>
    </div>

    <!-- 主要内容区域 -->
    <div class="container">
        <!-- 筛选面板 -->
        <div class="filter-panel">
            <form action="medicalHistory" method="get" class="form-horizontal">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">选择日期</label>
                            <div class="col-sm-9">
                                <input type="date" class="form-control" name="visitDate">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">疾病名称</label>
                            <div class="col-sm-9">
                                <select class="form-control" name="diseaseId">
                                    <option value="">全部疾病</option>
                                    <option value="1">感冒发烧</option>
                                    <option value="2">高血压</option>
                                    <option value="3">腰椎间盘突出</option>
                                    <option value="4">急性肠胃炎</option>
                                    <option value="5">过敏性鼻炎</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-search mr-1"></i>查询</button>
                        <a href="medicalHistory.jsp" class="btn btn-default" style="margin-left: 10px;"><i class="fa fa-refresh mr-1"></i>重置</a>
                    </div>
                </div>
            </form>
        </div>

        <!-- 模拟就医记录数据 -->
        <div class="history-card">
            <div class="history-header">
                <h3>感冒发烧 - 就医记录 #20250510001</h3>
                <div class="history-meta">
                    <span><i class="fa fa-calendar mr-1"></i>就医日期：2025年05月10日</span>
                    <span><i class="fa fa-hospital-o mr-1"></i>就诊医院：北京协和医院</span>
                    <span><i class="fa fa-user-md mr-1"></i>主治医生：李医生</span>
                </div>
            </div>

            <!-- 横向时间轴 -->
            <div class="timeline" style="--item-count: 5">
                <div class="timeline-item">
                    <div class="timeline-dot completed"></div>
                    <span class="timeline-label">在线挂号</span>
                    <span class="timeline-time">08:30</span>
                    <div class="timeline-content">通过医疗云系统预约呼吸内科普通门诊，挂号费50元</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot completed"></div>
                    <span class="timeline-label">门诊就诊</span>
                    <span class="timeline-time">09:15</span>
                    <div class="timeline-content">主诉发烧3天，体温38.5℃，咳嗽流涕。医生诊断为病毒性感冒，开具血常规检查单</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot completed"></div>
                    <span class="timeline-label">检查缴费</span>
                    <span class="timeline-time">09:40</span>
                    <div class="timeline-content">缴纳血常规检查费80元，前往检验科采血</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot completed"></div>
                    <span class="timeline-label">取药缴费</span>
                    <span class="timeline-time">10:20</span>
                    <div class="timeline-content">医生根据检查结果开具感冒药（布洛芬、连花清瘟），缴费120元后取药</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot pending"></div>
                    <span class="timeline-label">复诊提醒</span>
                    <span class="timeline-time">--</span>
                    <div class="timeline-content">医生建议3天后若症状未缓解需复诊</div>
                </div>
            </div>

            <div class="text-right">
                <button type="button" class="btn btn-primary btn-sm">
                    <i class="fa fa-eye mr-1"></i>查看完整详情
                </button>
            </div>
        </div>

        <div class="history-card">
            <div class="history-header">
                <h3>急性肠胃炎 - 就医记录 #20250315002</h3>
                <div class="history-meta">
                    <span><i class="fa fa-calendar mr-1"></i>就医日期：2025年03月15日</span>
                    <span><i class="fa fa-hospital-o mr-1"></i>就诊医院：北京大学第三医院</span>
                    <span><i class="fa fa-user-md mr-1"></i>主治医生：王医生</span>
                </div>
            </div>

            <!-- 横向时间轴 -->
            <div class="timeline" style="--item-count: 4">
                <div class="timeline-item">
                    <div class="timeline-dot completed"></div>
                    <span class="timeline-label">急诊挂号</span>
                    <span class="timeline-time">14:20</span>
                    <div class="timeline-content">因上吐下泻4小时前往急诊，挂号费80元</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot completed"></div>
                    <span class="timeline-label">急诊就诊</span>
                    <span class="timeline-time">14:45</span>
                    <div class="timeline-content">诊断为急性肠胃炎，开具补液和抗生素治疗方案</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot completed"></div>
                    <span class="timeline-label">缴费治疗</span>
                    <span class="timeline-time">15:10</span>
                    <div class="timeline-content">缴纳治疗费320元，进行静脉补液和药物治疗</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-dot completed"></div>
                    <span class="timeline-label">离院医嘱</span>
                    <span class="timeline-time">16:30</span>
                    <div class="timeline-content">症状缓解后离院，医嘱清淡饮食，按时服药，不适随诊</div>
                </div>
            </div>

            <div class="text-right">
                <button type="button" class="btn btn-primary btn-sm">
                    <i class="fa fa-eye mr-1"></i>查看完整详情
                </button>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
    <div class="footer">
        &copy; 2025 医疗云系统. 版权所有. | 就医记录安全加密存储
    </div>

    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            // 导航菜单点击事件（预约挂号功能跳转）
            $('#nav-registration').click(function(e) {
                e.preventDefault();
                if (confirm('是否跳转到预约挂号页面？')) {
                    alert('模拟跳转至预约挂号页面');
                    // 实际项目中可替换为 window.location.href = 'registration.jsp';
                }
            });

            // 时间轴响应式调整（避免节点溢出）
            adjustTimeline();
            $(window).resize(adjustTimeline);

            function adjustTimeline() {
                $('.timeline').each(function() {
                    var itemCount = $(this).find('.timeline-item').length;
                    var windowWidth = $(window).width();
                    
                    if (windowWidth <= 768) {
                        $(this).css('--item-count', '1'); // 移动端单行显示
                    } else if (windowWidth <= 992 && itemCount > 2) {
                        $(this).css('--item-count', '2'); // 平板端双列显示
                    } else {
                        $(this).css('--item-count', itemCount); // 桌面端按节点数量均分
                    }
                });
            }
        });

        // 查看就医详情（模拟弹窗）
        $('button:contains("查看完整详情")').click(function() {
            var visitId = $(this).closest('.history-card').find('h3').text().match(/#(\d+)/)[1];
            alert('正在加载就医记录 #' + visitId + ' 的完整详情...');
            // 实际项目中可跳转至详情页，如：window.location.href = 'medicalDetail.jsp?visitId=' + visitId;
        });
    </script>
</body>
</html>

