<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

		<div id="sir_lbo" class="sir_lbo"
			style="padding: 0; margin: 0; font-size: 1.025em;">
			<div style="padding-top: 5px;"></div>

		<div id="listCommu">
			<table class="table table-hover tb-board"
				style="padding: 0; margin: 0; font-size: 1.025em;">
				<thead>
					<tr>
						<td width="200" colspan="5"
							style="background: #fbfbfb; text-align: left; vertical-align: bottom; font-size: 14px; border-radius: 5px;">
 							<c:if test="${search=='search'}">
							<span id="searchCount" style="float: left; font-size: 16px; padding-top: 9px; vertical-align: bottom;">검색결과
								<span style="color: #ca4a0d;">${dataCount}건 </span> 
								<img alt="" src="/Project_RailTraveler/resource/images/close_icon.png" onclick="resetList()"
								style="background: #dadada; width: 20px; padding: 3px; cursor: pointer; border: 1px solid #cacaca; border-radius: 50%; margin-bottom: 2px;">
							</span>
							</c:if>
						
							<form name="searchForm" action="<%=cp%>/bookmark/commu?${query}&commuNum=${commuNum}&page=${page}"
								method="post"
								style="border: 1px solid #cccccc; height: 36px; border-radius: 3px; float: right;">
								<select name="condition" class="boxTF"
									style="border-radius: 3px; width: 30%; height: 100%; border-left: 0;">
									<option value="all"
										${condition=="all"?"selected='selected'":""}>모두</option>
									<option value="subject"
										${condition=="subject"?"selected='selected'":""}>제목</option>
									<option value="content"
										${condition=="content"?"selected='selected'":""}>내용</option>
									<option value="created"
										${condition=="created"?"selected='selected'":""}>작성일</option>
								</select> <input type="text" name="keyword" value="${keyword}"
									class="boxTF"
									style="display: inline-block; height: 100%; width: 58%;">
								<img src="<%=cp%>/resource/images/magnifying-glass.png" class="searchBtn"
									onclick="searchList();"
									style="padding: 6px; cursor: pointer; opacity: 0.6; height: 100%; float: left; border-left: 1px solid #cccccc;">
								
								
							</form>
						</td>
					</tr>
					<tr class="lbo_li lbo_legend lbo_legend_like">
						<th width="75" style="padding-left: 1.5%;">번호</th>
						<th><span style="padding-left: 10px;">제목</span></th>
						<th width="100"><span>작성일</span></th>
						<th width="80"><span>조회수</span></th>
					</tr>
				</thead>
				<tbody style="border-bottom: 2px solid black;" id="commuList">
					<c:forEach var="vo" items="${list}">
						<tr onclick="javascript:location.href='${articleUrl}${commuNum==1? vo.qnaNum:commuNum==2? vo.boardNum:vo.friendNum}'">
							<td>${vo.listNum}</td>
							<c:if test="${commuNum==1}">
								<td style="text-align: left; padding-left: 20px;">${vo.subject}</td>
							</c:if>
							
							<c:if test="${commuNum==2}">
								<td style="text-align: left; padding-left: 20px;">${vo.subject}
									<span style="margin-left: 7px; font-size: 14px;"> <i
										class="far fa-heart" style="margin-right: 2px; color: #969696;"></i>${vo.bookmarkCount}
										<i class="far fa-comment-alt"
										style="margin-right: 2px; color: #969696; margin-left: 5px;"></i>${vo.replyCount}
										<c:if test="${vo.fileCount>0}"><i class="far fa-save" style="margin-left: 5px; margin-right: 2px; color: #969696;"></i>${vo.fileCount}</c:if>
									</span>
								</td>
							</c:if>
							
							<c:if test="${commuNum==3}">
								<td style="text-align: left; padding-left: 20px;">${vo.subject}
									<span style="margin-left: 7px; font-size: 14px;"> <i
										class="far fa-heart" style="margin-right: 2px; color: #969696;"></i>${vo.bookmarkCount}
										<i class="far fa-comment-alt"
										style="margin-right: 2px; color: #969696; margin-left: 5px;"></i>${vo.replyCount}
										<c:if test="${vo.fileCount>0}"><i class="far fa-save" style="margin-left: 5px; margin-right: 2px; color: #969696;"></i>${vo.fileCount}</c:if>
									</span>
									<c:if test="${vo.validate==1 || vo.enable==1}">
										<span
											style="border-radius: 5px; font-size: 13px; font-weight: 900; display: inline-block; padding: 1px 3px; background: #ccc; color: #FFFFFF; margin-left: 10px;">모집완료</span>
									</c:if>
									
									<c:if test="${vo.validate!=1 && vo.enable!=1}">
										<span
											style="border-radius: 5px; font-size: 13px; font-weight: 900; display: inline-block; padding: 1px 3px; background: #f97509; color: #FFFFFF; margin-left: 10px;">모집중</span>
									</c:if>
									<span style="background: #aaa;color: white;border-radius: 5px;padding: 2px 5px;font-size: 12px;">
									기간 : ${vo.sDate}  ~  ${vo.eDate}</span>
								</td>
							</c:if>
							<td>${vo.created}</td>
							<td>${vo.hitCount}</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
			
			<div>
				<nav style="text-align: center;">
					<ul class="pagination">
						<li>${dataCount==0?"등록한 게시물이 없습니다.":paging}</li>
					</ul>
				</nav>
			</div>
		
		</div>
		




		</div>