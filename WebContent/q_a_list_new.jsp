<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en-US"> <![endif]-->
<!--[if IE 7]>    <html class="lt-ie9 lt-ie8" lang="en-US"> <![endif]-->
<!--[if IE 8]>    <html class="lt-ie9" lang="en-US"> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en-US">
<!--<![endif]-->
<head>
<!-- META TAGS -->
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>nullpointer</title>
<link rel="shortcut icon" href="${ctx}/images/favicon.png" />
<!-- Style Sheet-->
<link rel="stylesheet" type="text/css" href="${ctx}/css/searchKuang.css">
<link href="${ctx}/docs/css/zui.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctx}/css/zui.lite.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/zui-theme.css">
<link href="${ctx}/docs/css/doc.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${ctx}/css/style.css">
<link rel="stylesheet" type="text/css" href="${ctx}/css/main5152.css">
<style id="themeStyle"></style>
<style type="text/css">
#top .primary-color, a, #cancel-comment-reply-link, .blog-tags a:hover,
	.relThumb a:hover strong, .flex_column h1, .flex_column h2,
	.flex_column h3, .flex_column h4, .flex_column h5, .flex_column h6,
	#top #wrap_all .tweet-text a, #top #js_sort_items a.active_sort,
	.callout a:hover {
	color: #f0b70c;
}
</style>
</head>

<body>
	<%@ include file="nav.jsp" %>

	<!--导航栏完成-->
	<!--搜索框-->
	<%@include file="search-area.jsp"%>
	<!--搜索框完成-->
	<div class="container" style="padding-top: 20px; padding-bottom: 25px;">
		<div class="col-md-8 column"
			style="border: 1px solid #ddd; padding: 20px;">
			<ul class="nav nav-tabs">
				<li><a class="active" href="${ctx }/question/list_new"
					data-target="#tab2Content1">最新发布</a></li>
				<li><a href="${ctx }/question/list_answer"
					data-target="#tab2Content2">最多人回答</a></li>
				<li><a href="${ctx }/question/list_noone"
					data-target="#tab2Content3">尚未解决</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane fade active in" id="tab2Content1">
					<div class="items items-hover">
						<!--标签1内容开始-->
						<c:set var="questionList_theNew" value="${questionPage.list}"></c:set>
						<c:forEach var="question" items="${ questionList_theNew}">
							<div class="item">
								<div class="item-heading">
									<h2 class="post-title">
										<a
											href="${ctx }/question/findone?questionId=${question.questionId}">${question.questionTitle }</a>
									</h2>
								</div>
								<div class="item-content">
									<div class="text">${question.questionDescribe }</div>
								</div>
								<div class="item-footer">
									<a href="#" class="text-muted"><i class="icon-comments"></i>
										${fn:length(question.answers)}</a> &nbsp; <a href="#"
										class="text-muted"><i class="icon-thumbs-o-up"></i>
										${question.questionLikeNum } </a> &nbsp; <span class="text-muted">
										<fmt:formatDate value="${question.questionPublishTime }"
											pattern="yyyy-MM-dd HH:mm" />
									</span>
								</div>
							</div>
						</c:forEach>
						<!--分页实现-->
						<ul class="pager pager-loose">
							<li class="previous"><a
								href="${ctx}/question/list_new?currentPageNum=${questionPage.prePageNum}">«</a></li>
							<c:forEach begin="1" end="${questionPage.totalPageNum }"
								var="pageNum">
								<c:if test="${pageNum ==questionPage.currentPageNum }">
								<li class="active"><a
									href="${ctx }/question/list_new?currentPageNum=${pageNum }">${pageNum }</a></li>
								</c:if>
								<c:if test="${pageNum !=questionPage.currentPageNum }">
								<li><a
									href="${ctx }/question/list_new?currentPageNum=${pageNum }">${pageNum }</a></li>
								</c:if>
								
							</c:forEach>
							<li class="next"><a
								href="${ctx}/question/list_new?currentPageNum=${questionPage.nextPageNum}">»</a></li>
						</ul>
					</div>
					<!--标签1内容结束-->
				</div>
				<div class="tab-pane fade" id="tab2Content2">
					<!--<p>标签2的内容。</p>-->

					<!--标签2内容结束-->
				</div>
				<div class="tab-pane fade" id="tab2Content3">
					<!--<p>这是标签3的内容。</p>-->

					<!--标签3内容结束-->
				</div>
			</div>


		</div>
		<div class="col-md-4 column" style="margin-top: 30px;">
			<div class="col-md-12" style="margin-top: 20px;">
				<h2>
					<i class="icon icon-comments icon-2x"></i> 没有你想要的问题？
				</h2>
				<a href="${ctx }/question.jsp"><button class="btn btn-success btn-lg"
						type="button">向大哲们提问</button></a>

			</div>

			<div class="col-md-12" style="margin-top: 20px;">
				<h2>
					<i class="icon icon-align-left icon-2x"></i> Tag
				</h2>
				<div class="tagcloud">
					<c:set var="tag" value="${sessionScope.tagList}"></c:set>
					<c:forEach var="tt" items="${tag}">
						<c:if test="${tt.tagName =='C++'}">
							<a href="${ctx}/question/list_new?tagName=C%2B%2B"
								class="btn btn-primary">${tt.tagName}</a>
						</c:if>
						<c:if test="${tt.tagName !='C++'}">
							<a href="${ctx}/question/list_new?tagName=${tt.tagName}"
								class="btn btn-primary">${tt.tagName}</a>
						</c:if>

					</c:forEach>
				</div>

			</div>
		</div>

	</div>


	<!-- end of #footer -->

	<!-- Footer Bottom -->
	<div id="footer-bottom-wrapper">
		<div id="footer-bottom" class="container">
			<div class="row">
				<div class="col-md-6 column">
					<p class="copyright">
						Copyright © 2013. All Rights Reserved by KnowledgeBase.Collect
						from <a href="#" title="EXP小组" target="_blank">EXP小组</a>
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
<!-- script -->
<script src="${ctx}/assets/jquery.js"></script>
<script src="${ctx}/assets/clipboard/clipboard.min.js"></script>
<script src="${ctx}/assets/less/less.min.js"></script>

<!-- ZUI Javascript组件 -->
<script src="${ctx}/docs/js/zui.min.js"></script>
<script src="${ctx}/docs/js/doc.min.js"></script>
<!-- 增强文档插件 -->
<script async src="${ctx}/assets/prettify/prettify.js"></script>
<script src="${ctx}/assets/marked/marked.min.js"></script>
<script type="text/javascript">
	// 搜索框js @author Ray
	//修改
	$("#bugSearch").click(function() {
		//	alert("点击事件");
		var s = $("#s").val();
		window.location = "${ctx}/findBugByPage?s=" + s;

	})
	$("#questionSearch").click(function() {
		//	alert("点击事件");
		var s = $("#s").val();
		window.location = "${ctx}/findQuestionByPage?s=" + s;

	})
	// 显示搜索内容
	$(document).ready($("#s").keypress(function(e) {
		if (e.keyCode == 13 || e.keyCode == 32) {
			var title = $("#s").val();
			//3.获取到输入的内容之后，就要通过ajax传给后台
			$.post("${ctx}/findBugAndQuestionByValue", {
				"title" : title
			}, function(data) {
				if (title == "") {
					$("#dtitles").hide();
				} else {
					//显示展示div,把它清空
					$("#dtitles").show().html("");
					if (data == "") {
						$("#dtitles").hide();
					} else {
						$("#dtitles").append(data);
						//4.鼠标移上去之后，加一个背景
						$("li").hover(function() {
							//alert("鼠标移上去");
							$(this).addClass("li1");
						}, function() {
							$(this).removeClass("li1");
						});
						// 点击后显示在框里
						$("li").click(function() {
							$("#s").val($(this).text());
							$("#dtitles").hide();
							if ($("#s").val() != "" || $("#s").val() == null) {
								$("#clear").show();
							}
						});
					}
				}
			});

		}
	})

	);

	// 搜索框js @author Ray
	//修改 红叉
	$(document).ready(
	//1.页面加载之后，找到文本框的内容对它触发一个事件
	$("#s").keyup(function() {
		if ($("#s").val() != "" || $("#s").val() != null) {
			$("#clear").show();
		}
		if ($("#s").val() == "" || $("#s").val() == null) {
			$("#clear").hide();
			$("#dtitles").hide();
		}
		$("#clear").click(function() {
			$("#s").val("");
			$("#clear").hide();
		})
	}));
</script>
</html>