<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-gb" dir="ltr" class="uk-notouch">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>nullpointer</title>
<link rel="shortcut icon" href="${ctx}/images/favicon.png" />
<!-- Style Sheet-->
<link href="${ctx}/docs/css/zui.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctx}/css/zui.lite.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/zui-theme.css">
<link href="${ctx}/docs/css/doc.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/main5152.css">
<style id="themeStyle"></style>

</head>
<body>
	<!-- Start of Header -->
	<nav class="navbar navbar-inverse" role="navigation"
		style="margin-bottom: 0px;">
	<div class="center-block">
		<div class="container">
			<!-- 导航头部 -->
			<div class="navbar-header">
				<!-- 移动设备上的导航切换按钮 -->
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse-example">
					<span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<!-- 品牌名称或logo -->
				<img src="${ctx}/images/logo.png" alt="nullpointer"
					style="margin-top: 3px;">
			</div>
			<!-- 导航项目 -->
			<div class="collapse navbar-collapse navbar-collapse-example">

				<ul class="nav navbar-nav navbar-right">
					<li class="current-menu-item"><a href="${ctx}/index.jsp">主页</a></li>
					<li><a href="${ctx}/bug/listadmin">BUGS</a></li>
					<li><a href="${ctx}/q_a_list.jsp">技术问答</a></li>
					<li><a href="${ctx}/contact">帮助</a></li>
					<c:if test="${loginUser==null}">
						<li><a href="${ctx}/login.jsp">登陆/注册</a></li>
					</c:if>
					<c:if test="${loginUser!=null}">
						<li><a href="${ctx}/loginUser/logOut">退出</a></li>
					</c:if>
					<!-- 导航中的下拉菜单 -->
					<li class="dropdown"><a href="your/nice/url"
						class="dropdown-toggle" data-toggle="dropdown"><img
							src="${ctx}/imgUp/${loginUser.userInfo.userInfoHeadPortrait}"
							width="20px" height="20px" class="img-circle" /><b class="caret"></b></a>
						<ul class="dropdown-menu" role="menu" style="text-align: center;">
							<li><a href="${ctx}/home.jsp">我的主页</a></li>
							<li><a href="${ctx}/home-question.jsp">信息管理</a></li>
							<li><a href="${ctx}/accountSetting.jsp">账号设置</a></li>
							<li><a href="${ctx}/contact">建议反馈</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</div>
	</nav>
	<!--导航栏完成-->
	<!-- End of Header -->
	<div class="container" style="padding-top: 20px;">
		<div class="col-md-3 column">

			<div class="col-md-11 column">
				<div class="example"
					style="text-align: center; background-color: #fafafa;">
					<div class="container">
						<img class="img-circle" width="100" height="100"
							src="${ctx}/imgUp/${loginUser.userInfo.userInfoHeadPortrait}"
							alt="头像">

					</div>

					<h3>${loginUser.loginName}</h3>
					<c:if
						test="${ loginUser.userInfo.userInfoDescribe == null || loginUser.userInfo.userInfoDescribe == ''}">
						<p>这家伙很懒 什么都没有留下</p>
					</c:if>
					<p>${loginUser.userInfo.userInfoDescribe}</p>
				</div>
				<div class="col-md-12">


					<nav class="menu" data-toggle="menu"
						style="width: 200px;margin-top:20px;margin-bottom: 20px;">
					<ul class="nav nav-primary">
						<li class="nav-heading">个人中心</li>
						<li><a href="${ctx}/home.jsp"><i class="icon icon-home"></i>
								我的主页</a></li>
						<li><a href="${ctx}/accountSetting.jsp"><i
								class="icon-user"></i> 账号设置</a></li>
						<li><a href="${ctx }/question/findQuestionByTime?userInfoId=${loginUser.loginUserId}"><i
								class="icon icon-question-sign"></i> 我的问题<span
								class="label label-badge label-success">4</span></a></li>
						<li><a href="${ctx }/answer/findAnswerByTime?userInfoId=${loginUser.loginUserId}"><i
								class="icon icon-reply"></i> 我的回答<span
								class="label label-badge label-success">4</span></a></li>
						<li><a href="${ctx }/comment/findCommentByTime?userInfoId=${loginUser.loginUserId}"><i
								class="icon icon-comments"></i> 我的评论<span
								class="label label-badge label-success">4</span></a></li>
						<li><a href="${ctx }/share/shareByTime?userInfoId=${loginUser.loginUserId}"><i
								class="icon icon-share"></i> 我的分享<span
								class="label label-badge label-success">4</span></a></li>
					</ul>
					</nav>
				</div>
			</div>

		</div>
		<div class="col-md-9 column">
			<div class="alert alert-success with-icon alert-dismissable">
				<i class="icon-user"></i>
				<div class="content">
					hi!&nbsp;&nbsp;&nbsp;${loginUser.loginName}&nbsp;&nbsp;&nbsp;你已经在这里度过了${day}天${hour}小时${min}分${second }秒
				</div>
				<button type="button" class="close" data-dismiss="alert"
					aria-hidden="true">×</button>
			</div>

			<div class="items">
				<h2 class="header-dividing">我的分享</h2>
				<c:forEach items="${pagesShare.list}" var="p">
					<div class="item">
						<div class="item-heading">
							<c:set var="tags" value="${p.tags}"></c:set>
							<c:forEach var="t" items="${tags}">
								<div class="pull-right label label-success">${t.tagName}</div>
							</c:forEach>
							<h4>
								<a href="${ctx }/bug/findone?bugId=${p.bugId}">${p.bugTitle}</a>
							</h4>
						</div>
						<div class="item-content">
							<div class="text">${p.bugDescribe}</div>
						</div>
						<div class="item-footer">
							<a href="${ctx }/bug/findone?bugId=${p.bugId}" class="text-muted"><i class="icon-comments"></i>
								${fn:length(question.comments)} <!-- 汤文茹将此处bug的点赞数修改为评论数 --></a>
							&nbsp; <span class="text-muted"> <fmt:formatDate
									value="${p.bugPublishTime }" pattern="yyyy-MM-dd HH:mm" /> <!-- 汤文茹规范了bug的发表时间 -->
							</span>
						</div>
					</div>
				</c:forEach>

				<ul class="pager">
						<li class="previous"><a
						href="${ctx}/share/shareByTime?currentPageNum=${pagesShare.prePageNum}">«</a></li>
					<c:forEach begin="1" end="${pagesShare.totalPageNum }" var="pageNum">
						<c:if test="${pageNum ==pagesShare.currentPageNum}">
						<li class="active"><a name="pagen"
							href="${ctx }/share/shareByTime?pageNum=${pageNum }">${pageNum }</a></li>
						</c:if>
						<c:if test="${pageNum !=pagesShare.currentPageNum}">
						<li><a name="pagen"
							href="${ctx }/share/shareByTime?pageNum=${pageNum }">${pageNum }</a></li>
						</c:if>
					</c:forEach>

					<li class="next"><a
						href="${ctx}/share/shareByTime?currentPageNum=${pagesShare.nextPageNum}">»</a></li>
				</ul>
			</div>

		</div>

	</div>


	<!-- Footer Bottom -->
	<div id="footer-bottom-wrapper">
		<div id="footer-bottom" class="container">
			<div class="row">
				<div class="col-md-6 column">
					<p class="copyright">
						Copyright © 2013. All Rights Reserved by KnowledgeBase.Collect
						from <a href="#" title="EXP" target="_blank">EXP小组</a>
					</p>
				</div>
				<div class="col-md-6 column">
					<!-- Social Navigation -->
					<ul class="social-nav clearfix">
						<li class="linkedin"><a target="_blank" href="#"></a></li>
						<li class="stumble"><a target="_blank" href="#"></a></li>
						<li class="google"><a target="_blank" href="#"></a></li>
						<li class="deviantart"><a target="_blank" href="#"></a></li>
						<li class="flickr"><a target="_blank" href="#"></a></li>
						<li class="skype"><a target="_blank" href="skype:#?call"></a></li>
						<li class="rss"><a target="_blank" href="#"></a></li>
						<li class="twitter"><a target="_blank" href="#"></a></li>
						<li class="facebook"><a target="_blank" href="#"></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

</body>
<script src="${ctx}/assets/jquery.js"></script>
<script src="${ctx}/assets/clipboard/clipboard.min.js"></script>
<script src="${ctx}/assets/less/less.min.js"></script>

<!-- ZUI Javascript组件 -->
<script src="${ctx}/docs/js/zui.min.js"></script>
<script src="${ctx}/docs/js/doc.min.js"></script>
<!-- 增强文档插件 -->
<script async src="${ctx}/assets/prettify/prettify.js"></script>
<script src="${ctx}/assets/marked/marked.min.js"></script>

</script>

</html>