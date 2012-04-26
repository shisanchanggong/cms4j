<%--
  研究所.
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-4-21
  Time: 下午9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sitemesh-page" uri="http://www.opensymphony.com/sitemesh/page" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>${agency.title}</title>
</head>
<body>
<img id="banner" src="${ctx}/static/images/${agency.imageUrl}" class="span-24"/>

<div class="span-19">
    <div class="span-7">
        <div class="container_index">
            <p class="title_index span-7 last">
                <strong>发展定位</strong>
            </p>

            <p class="researchDesc">${fn:substring(agency.introduction,0,215)}</p>
        </div>
    </div>
    <!---left_l end----->
    <div class="span-12 last">
        <div class="container_index span-12 last">
            <p class="title_index span-12"><a href="#"><strong>咨询服务</strong></a></p>
            <ul class="content span-6">
                <li><a href="">风险管理组织架构</a></li>
                <li><a href="">风险管理组织架构</a></li>
                <li><a href="">信用风险内部评级体系</a></li>
            </ul>
            <ul class="content span-6">
                <li><a href="">Basel新资本协议</a></li>
                <li><a href="">全面风险管理规划</a></li>
                <li><a href="">金融风险监控体系</a></li>
            </ul>
        </div>
        <div class="container_index">
            <p class="title_index span-12"><a href="#"><strong>解决方案</strong></a></p>
            <ul class="content span-12">
                <li><a href="#">农村金融机构全面风险管理方案</a></li>
                <li><a href="#">中小银行信用风险内部评级解决方案</a></li>
                <li><a href="#">战略规划落地实施解决方案</a></li>
            </ul>
        </div>
    </div>
    <!---- left_r end---->
    <div id="left_b" class="span-19 last">
        <%@ include file="/WEB-INF/layouts/teacher.jsp" %>
    </div>
    <!---教师风采---->
</div>
<div class="span-5 last">
    <div class="container_index">
        <p class="title_index span-5"><strong>教育培训</strong><%--<a href="#" class="more">更多>></a>--%></p>
            <span class="span-2"><a href="#" class="institution">证书培训</a></span>
            <span class="span-2"><a href="#" class="institution">高管培训</a></span>
            <span class="span-2"><a href="#" class="institution">学历培训</a></span>
            <span class="span-2"><a href="#" class="institution">学历培训</a></span>
    </div>
    <div class="container_index">
        <p class="title_index span-5"><strong>IT支持系统</strong><span class="more"> <a href="${ctx}/article/list/" class="more">更多>></a></span></p>
        <ul class="content span-5">
            <li><a href="#">风险及内控管理系统</a></li>
            <li><a href="#">流动性风险管理系统</a></li>

        </ul>
    </div>
    <div class="container_index">
        <p class="title_index span-5"><strong>合作伙伴</strong><%--<a href="#" class="more">更多>></a>--%></p>
        <ul class="content span-5">
            <c:forEach items="${companies}" var="company" begin="0" step="1">
                <li><a href="${ctx}/article/content/${company.id}">${fn:substring(company.title,0,14)}</a></li>
            </c:forEach>
        </ul>
    </div>

</div>
<ul id="friLnk" class="span-24">
    <li class="friLnkT cufon"><strong>友情链接</strong></li>
    <c:forEach items="${links}" var="link" begin="0" step="1">
        <li class="fri"><a href="${link.url}">${fn:substring(link.title,0,13)}</a></li>
    </c:forEach>
</ul>
</body>
</html>