<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<meta property="og:url"
	content="http://172.16.100.193:8080/Project_RailTraveler/notice/article?page=1&noticeNum=52" />
<meta property="og:type" content="website" />
<meta property="og:title" content="Your Website Title" />
<meta property="og:description" content="Your description" />
<meta property="og:image"
	content="http://www.rail-ro.com/kor/images/content/pass-1-new.png" />

<div id="fb-root"></div>
<script async defer crossorigin="anonymous"
	src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v5.0"></script>
<div class="fb-share-button"
	data-href="http://172.16.100.193:8080/Project_RailTraveler/notice/article?page=1&amp;noticeNum=52"
	data-layout="button_count" data-size="large">
	<a target="_blank"
		href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2F172.16.100.193%3A8080%2FProject_RailTraveler%2Fnotice%2Farticle%3Fpage%3D1%26noticeNum%3D52&amp;src=sdkpreparse"
		class="fb-xfbml-parse-ignore">공유하기</a>
</div>

<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link href="<%=cp%>/resource/css/modal.css" rel="stylesheet">
<script src="<%=cp%>/resource/js/commu.js"></script>
<script type="text/javascript">

function deleteNotice() {
	var q="noticeNum=${dto.noticeNum}&${query}";
	var url="<%=cp%>/notice/delete?"+q;
	
	if(confirm("게시물을 삭제 하시겠습니까 ?")) {
<%-- 		var url="<%=cp%>/notice/delete?num="+num+"&${query}"; --%>
		location.href=url;
	}
}
function updateNotice() {
	var q="noticeNum=${dto.noticeNum}&${query}";
	var url="<%=cp%>/notice/update?"+q;
	
	location.href=url;
}

function modalOn() {
	$('#myModal').modal('toggle');
}

// http://www.libertypage.net/myblog/post/18/
</script>
<style type="text/css">
.tb-row span {
	display: inline-block;
	float: left;
	margin-right: 5px;
	color: #b2b2b2;
}

.tb-row {
	height: 35px;
}

#boardLikeCount {
	width: 41px;
	font-size: 13px;
	display: block;
	color: #888888;
	margin: 0 auto;
}

a#MOVE_TOP_BTN {
	padding: 7px 0;
	position: fixed;
	right: 3%;
	bottom: 100px;
	display: none;
	z-index: 999;
	width: 60px;
	height: 60px;
	border-radius: 50px;
	text-align: center;
	background: gray;
	color: white;
}

.modal-content ul {
	padding: 0;
	list-style: none;
}

.modal-content li {
	padding: 10px 5px;
	margin-bottom: 1px;
}

.modal-content a {
	color: black;
}

.modal-content a:hover {
	font-weight: bold;
	color: #0b0bf1;
}

.btnSendBoardLike:active, .btnSendBoardLike:hover {
	background: none;
}

#fileDownTb {
	width: 100%;
	margin: 0px auto 0px;
	border-spacing: 0px;
	border-collapse: collapse;
	border-top: 2px solid #000;
	border-bottom: 2px solid #000;
}
</style>

<div id="snsModal" role="dialog" tabindex="-1"
	aria-labelledby="mySmallModalLabel" aria-hidden="true"
	data-backdrop="true" data-keyboard="true"
	class="modal1 modal_post_social" style="display: none;">
	<div class="modal-dialog"
		style="width: 315px; position: absolute; right: 37%; top: 25%;">
		<div class="modal-content">
			<div class="text-basic">
				<div class="social-btn">
					<ul>
						<li role="" class="kakao"><a href="javascript:;"
							onclick="SNS.setSnsApi('kakaotalk')">카카오톡</a></li>
						<li role="" class="story"><a href="javascript:;"
							onclick="SNS.setSnsApi('kakaostory')">카카오스토리</a></li>
						<li role="" class="line"><a href="javascript:;"
							onclick="SNS.setSnsApi('line')">라인</a></li>
						<li role="" class="band"><a href="javascript:;"
							onclick="SNS.setSnsApi('band')">밴드</a></li>
						<li role="" class="naver"><a href="javascript:;"
							onclick="SNS.setSnsApi('naver')">네이버</a></li>
						<li role="" class="face"><a href="javascript:;"
							onclick="SNS.setSnsApi('facebook')">페이스북</a></li>
						<li role="" class="twitter"><a href="javascript:;"
							onclick="SNS.setSnsApi('twitter')">트위터</a></li>
						<li role="" class="googleplus"><a href="javascript:;"
							onclick="SNS.setSnsApi('googleplus')">Google+</a></li>
					</ul>
				</div>
				<div class="url-copy holder">
					<div class="form-control-line">
						<input type="text" id="sns_copy_url"
							class="_sns_copy_url form-control"
							value="https://hiconnectpeople.com/30/?q=YToxOntzOjEyOiJrZXl3b3JkX3R5cGUiO3M6MzoiYWxsIjt9&amp;bmode=view&amp;idx=2828226&amp;t=board"
							readonly="readonly">
						<button type="button"
							class="_sns_copy_btn sns_copy_btn btn btn-default"
							onclick="SNS.copyToClipboard()"
							data-clipboard-target="._sns_copy_url">복사</button>
					</div>
				</div>
				<div id="copy_complete" class="text-center"></div>
			</div>
		</div>
	</div>
</div>

<div id="declarationModal" role="dialog" tabindex="-1"
	aria-labelledby="mySmallModalLabel" aria-hidden="true"
	data-backdrop="true" data-keyboard="true"
	class="modal1 modal_post_social" style="display: none;">
	<div class="modal-dialog"
		style="width: 35%; position: absolute; right: 30%; top: 25%;">
		<div class="modal-content"
			style="background: aliceblue; text-align: center; border: 10px solid;">
			<div class="text-basic">
				<div>
					<h2>신고하기</h2>
					<div style="padding: 10px 20px;">
						<span>*신고 사유*</span>
						<textarea class='boxTA'
							style='width: 100%; height: 150px; resize: none; border-radius: 7px;'></textarea>
						<button type='button' class='btn btnSendReply btn-default'
							data-num='10'
							style='width: 100%; height: 60px; margin-top: 20px; font-size: 20px; padding: 0px 0px;'>등록</button>
					</div>
				</div>
				<div id="copy_complete" class="text-center"></div>
			</div>
		</div>
	</div>
</div>


<!-- 첨부파일 관리 모달 -->
<div class="modal fade bs-example-modal-sm" id="myModal" tabindex="-1"
	role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content" style="margin: 0 auto; width: 500px;">
			<h3
				style="margin: 0; padding: 10px; color: white; background: #141832f2; text-align: center; font-weight: 900;">첨부파일</h3>
			<div style="padding: 10px;">
				<table id="fileDownTb" style="
    width: 100%;
">
					<tbody><tr style="border-bottom: 1px solid;    height: 35px;">
						<th style="
    width: 10%;
">다운</th>
						<th style="    text-align: center;
    width: 50%;
">파일명</th>
						<th style="
    width: 10%;
">파일크기</th>
					</tr>
					<c:forEach var="file" items="${files}">
					<tr style="    height: 35px;border-bottom: 1px solid #ccc;">
					<td>
					 <a href="<%=cp%>/notice/download?noticeFileNum=${file.noticeFileNum}">${file.noticeFileNum}
					<i
								class="far fa-arrow-alt-circle-down"></i></a></td>
								<td>${file.originalFilename}</td>
								
								<td>
					(<fmt:formatNumber
							value="${file.fileSize/1024}" pattern="0.00" />KByte)</td>
					</tr>
						
				</c:forEach>
					<tr>
						<td colspan="3"><a class="btn"
							href="<%=cp%>/notice/zipDownload?noticeNum=${dto.noticeNum}" style="    width: 100%;
    height: 45px;
    padding: 10px;
    font-size: 15px;
    background: #eee;">
								zip 파일로 받기</a></td>
					</tr>
					
				</tbody></table>
					
					
			</div>
		</div>
	</div>
</div>

<div class="body-content-container">
	<div class="page-three-title mt40">
		<h3 class="fs26">
			<span style="padding: 10px 0px; display: block;"> 공지게시판</span>
		</h3>
	</div>

	<div id="sir_lbo" class="sir_lbo"
		style="padding: 0; margin: 0; font-size: 1.025em;">
		<div style="padding-bottom: 10px;"></div>
		<table style="width: 100%; border-spacing: 0px;">
			<tr height="45">
				<td width="300" align="left">
					<button type="button" class="btn btn-default"
						onclick="javascript:location.href='<%=cp%>/notice/notice?${query}';">목록</button>
				</td>

				<td align="right"><c:if
						test="${sessionScope.member.userId==dto.userId}">
						<button type="button" class="btn btn-default"
							onclick="updateBoard();">수정</button>
					</c:if> <c:if
						test="${sessionScope.member.userId==dto.userId || sessionScope.member.userId=='admin'}">
						<button type="button" class="btn btn-default"
							onclick="deleteBoard();">삭제</button>
					</c:if>
					<button type="button" class="btn btn-danger" onclick="declare();">
						<i class="far fa-bell" style="color: white"></i>신고
					</button></td>
			</tr>
		</table>
		<table
			style="width: 100%; margin: 0px auto 0px; border-spacing: 0px; border-collapse: collapse; border-top: 2px solid #000; border-bottom: 2px solid #000;">
			<tr style="border-bottom: 1px solid #cccccc;">
				<td colspan="3" style="padding: 15px 0;">
					<h3 style="margin: 10px 0 2px; font-size: 25px; float: left;">${dto.subject}</h3>
					<span
					style="display: inline-block; float: right; color: gray; margin: 10px 10px 0 0;">${dto.created}</span>
				</td>
			</tr>
			<tr>
				<td colspan="3" style="padding: 20px 5px;" valign="top" height="200">
					${dto.content}</td>
			</tr>
			<tr class="tb-row" style="border-bottom: 0;">
				<td colspan="3" height="40" align="center">
					<button type="button" class="btn btnSendBoardLike btn-default"
						title="공유하기"
						style="padding: 6px 8px; width: 60px; height: 60px; border-radius: 50%; margin-bottom: 5px;"
						onclick="snsShare();">
						<i class="far fa-share-square"
							style="font-size: 20px; display: block; margin: 0 auto; color: #555555;"></i><span
							id="noticeLikeCount">공유</span>
					</button>
				</td>
			</tr>
			<tr class="tb-row">
				<td colspan="3" align="left" style="padding-left: 5px; color: blue;">
					<c:if test="${not empty files}">
						<a onclick="modalOn();" style="cursor: pointer;"> 첨부된 파일
							(${dto.fileCount})</a>
					</c:if>
				</td>
			</tr>
			<tfoot>
				<tr class="tb-row">
					<td align="left" style="padding-left: 5px;" width="100">이전글<i
						class="fas fa-caret-up" style="margin: 5px;"></i> :
					</td>
					<c:if test="${empty preReadDto}">
						<td colspan="2"><span style="color: #bbb;">이전글이 존재하지
								않습니다.</span></td>
					</c:if>
					<c:if test="${not empty preReadDto}">
						<td><a
							href="<%=cp%>/notice/article?${query}&noticeNum=${preReadDto.noticeNum}"
							style="color: #737373;">${preReadDto.subject}</a></td>
						<td width="90">${preReadDto.created}</td>
					</c:if>
				</tr>

				<tr class="tb-row">
					<td align="left" style="padding-left: 5px;" width="100">다음글<i
						class="fas fa-caret-up" style="margin: 5px;"></i> :
					</td>
					<c:if test="${empty nextReadDto}">
						<td colspan="2"><span style="color: #bbb;">다음글이 존재하지
								않습니다.</span></td>
					</c:if>
					<c:if test="${not empty nextReadDto}">
						<td><a
							href="<%=cp%>/notice/article?${query}&noticeNum=${nextReadDto.noticeNum}"
							style="color: #737373;">${nextReadDto.subject}</a></td>
						<td width="90">${nextReadDto.created}</td>
					</c:if>
				</tr>
			</tfoot>
		</table>
		<table
			style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
			<tr height="45">
				<td width="300" align="left">
					<button type="button" class="btn btn-default"
						onclick="javascript:location.href='<%=cp%>/bbs/list?${query}';">목록</button>
				</td>
			</tr>
		</table>
	</div>
</div>

<script>
Kakao.init('43fed4f22c437dfe99e213d8555c56e0');
function sendLinkKakao(){
    Kakao.Link.sendDefault({
      objectType: 'feed',
      content: {
        title: '{{ post.title }}',
        description: '{{ post.content }}',
        imageUrl: '{{ post.content }}',
        link: {
          mobileWebUrl: '{{ request.build_absolute_uri }}',
          webUrl: '{{ request.build_absolute_uri }}'
        }
      },
      buttons: [       
        {
          title: '링크 열기',
          link: {
            mobileWebUrl: '{{ request.build_absolute_uri }}',
            webUrl: '{{ request.build_absolute_uri }}'
          }
        }
      ]
    }); 
}
</script>