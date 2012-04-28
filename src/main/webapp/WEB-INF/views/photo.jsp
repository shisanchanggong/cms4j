<%--
  User: Deng Xiaolan (824688439@qq.com)
  Date: 12-3-19
  Time: 下午5:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>画廊</title>
    <!-- Add mousewheel plugin (this is optional) -->
    <script type="text/javascript" src="${ctx}/static/jquery/jquery.mousewheel-3.0.6.pack.js"></script>

    <!-- Add fancyBox -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/jquery.fancybox.css?v=2.0.5" type="text/css" media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/jquery.fancybox.pack.js?v=2.0.5"></script>

    <!-- Optionally add button and/or thumbnail helpers -->
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.css?v=2.0.5" type="text/css" media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-buttons.js?v=2.0.5"></script>
    <link rel="stylesheet" href="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.css?v=2.0.5" type="text/css" media="screen"/>
    <script type="text/javascript" src="${ctx}/static/js/fancyBox/helpers/jquery.fancybox-thumbs.js?v=2.0.5"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".fancybox-thumb").fancybox({
                prevEffect:'none',
                nextEffect:'none',
                helpers:{
                    title:{
                        type:'outside'
                    },
                    overlay:{
                        opacity:0.8,
                        css:{
                            'background-color':'#000'
                        }
                    },
                    thumbs:{
                        width:50,
                        height:50
                    }
                }
            });
        });
    </script>
</head>
<body>
<!-- BEGIN PAGE TITLE -->
<div id="page-title">
    <div class="title"><!-- your title page -->
        <h1>画廊</h1>
    </div>
    <div class="desc">一花一世界，一叶一春秋</div>
</div>
<!-- END OF PAGE TITLE -->
<!-- BEGIN CONTENT -->
<div id="content-inner-full">
    <h2><a href="${ctx}/gallery/album">相册模式</a> | <a href="${ctx}/gallery/photo">画廊模式</a></h2>
    <div id="album_load">
        <c:forEach items="${images}" var="image" begin="0" step="1" varStatus="var">
            <div class="span-6">
        <div class="pf-gall"><!-- portfolio 1 -->
            <a href="${ctx}/static/uploads/gallery/gallery-big/${image.imageUrl}" rel="fancybox-thumb" class="fancybox-thumb" title="${image.title}"><img
                    src="${ctx}/static/uploads/gallery/thumb-200x122/${image.imageUrl}" alt="" class="pf-img"/></a>
        </div>
            </div>
            <c:if test="${var.count%3==0}">
                <div class="span-6 last">
                <div class="pf-gall">
                    <a href="${ctx}/static/uploads/gallery/gallery-big/${image.imageUrl}" rel="fancybox-thumb" class="fancybox-thumb" title="${image.title}"><img
                            src="${ctx}/static/uploads/gallery/thumb-200x122/${image.imageUrl}" alt="" class="pf-img"/></a>
                </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
        <div class="blog-pagination"><!-- page pagination -->
            页码 &nbsp;:&nbsp;
            <c:choose>
                <c:when test="${total <= 132}">
                    <c:forEach begin="1" end="${pageCount>1?pageCount:1}" step="1" varStatus="var"><span class="blog-button-page pagination">${var.index}</span>&nbsp;</c:forEach>
                </c:when>
                <c:otherwise>
                    <c:forEach begin="1" end="11" step="1" varStatus="var"><span class="blog-button-page pagination">${var.index}</span>&nbsp;</c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
</div>
<!-- END OF CONTENT -->
<script type="text/javascript">
    $(function () {
        var albums = $("#album_load");
        var pager = $(".blog-pagination");
        pager.find("span:first").css('background-color','#e4e4e4').css('color','#ff4e00').css('cursor','default');
        PageClick = function (pageIndex, total, spanInterval) {
            //索引从1开始
            //将当前页索引转为int类型
            var intPageIndex = parseInt(pageIndex);
            var limit = 12;//每页显示文章数量

            $.ajax({
                url:"${ctx}/gallery/photo/ajax?offset=" + (intPageIndex - 1) * limit + "&limit=" + limit,
                timeout:3000,
                success:function (data) {
                    albums.html("");

                    //加载文章
                    $.each(data, function (index, content) {
                        albums.append($("<div class='pf-gall'><!-- portfolio 1 -->" +
                                "<a href='${ctx}/static/uploads/gallery/gallery-big/" + content.imageUrl + "' rel='fancybox-thumb'" +
                                " class='fancybox-thumb' title='" + content.title + "'>" +
                                "<img src='${ctx}/static/uploads/gallery/thumb-200x122/" + content.imageUrl + "' width='200' height='122'" +
                                "alt='' class='pf-img'/></a></div>"));
                    });

                    $(".blog-pagination").html("页码&nbsp;:&nbsp;");

                    //将总记录数结果 得到 总页码数
                    var pageS = total;
                    if (pageS % limit == 0) pageS = pageS / limit;
                    else pageS = parseInt(total / limit) + 1;

                    //设置分页的格式  这里可以根据需求完成自己想要的结果
                    var interval = parseInt(spanInterval); //设置间隔
                    var start = Math.max(1, intPageIndex - interval); //设置起始页
                    var end = Math.min(intPageIndex + interval, pageS);//设置末页

                    if (intPageIndex < interval + 1) {
                        end = (2 * interval + 1) > pageS ? pageS : (2 * interval + 1);
                    }

                    if ((intPageIndex + interval) > pageS) {
                        start = (pageS - 2 * interval) < 1 ? 1 : (pageS - 2 * interval);
                    }

                    //生成页码
                    for (var j = start; j < end + 1; j++) {
                        if (j == intPageIndex) {
                            var spanSelectd = $("<span class='blog-button-page-selected pagination'>" + j + "</span>&nbsp;");
                            pager.append(spanSelectd);
                        } else {
                            var a = $("<span class='blog-button-page pagination'>" + j + "</span>&nbsp;").click(function () {
                                PageClick($(this).text(), total, spanInterval);
                            });
                            pager.append(a);
                        } //else
                    } //for
                }
            });
        };
        $(".pagination").click(function () {
            PageClick($(this).text(), ${total}, 5);
        });
    });
</script>
</body>
</html>