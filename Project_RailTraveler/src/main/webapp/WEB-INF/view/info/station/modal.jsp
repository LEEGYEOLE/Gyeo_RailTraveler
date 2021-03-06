<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">
function deleteStation(){
	var q = "staNum=${dto.staNum}&locNum=${dto.locNum}&page=${page}";
	var url = "<%=cp%>/station/delete?" + q;

	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")) {
		location.href=url;
	}
	
}

function updateStation(){
	var q = "staNum=${dto.staNum}&locNum=${dto.locNum}&page=${page}"
	var url = "<%=cp%>/station/update?"+ q;
	
	location.href = url;
}

$(function(){
	$("#remove").click(function(){
		var beneNum = $('input[name="choice"]:checked').val();
		if(beneNum==null){
			alert("삭제할 혜택을 먼저 선택해주세요.");
			return;
		}
		
		var query = "locNum=${dto.locNum}&page=${page}&beneNum="+beneNum;
		var url = "<%=cp%>/station/benefit/delete?"+query;
		
		location.href=url;
	});
});

$(function(){
	$("#edit").click(function(){
		var beneNum = $('input[name="choice"]:checked').val();
		if(beneNum==null){
			alert("수정할 혜택을 먼저 선택해주세요.");
			return;
		}
		var query = "staNum=${dto.staNum}&locNum=${dto.locNum}&page=${page}&beneNum="+beneNum;
		var url = "<%=cp%>/station/benefit/update?"+query;
		
		location.href=url;
	});
});

function showTour(){
	var locNum = ${dto.locNum};
	var subtitle = "";
	if(locNum ==1)
		subTitle = "sudo";
	else if(locNum ==2)
		subTitle = "chungcheong";
	else if(locNum ==3)
		subTitle = "gangwon";
	else if(locNum ==4)
		subTitle = "jeonla";
	else if(locNum ==5)
		subTitle = "gyeongsang";
 	
	var query = "?q=staNum:"+${dto.staNum}+",subTitle:"+subTitle;
	var url = "<%=cp%>/tour/"+subTitle+query;
	
	location.href=url;
	
}
</script>

	<!-- header title -->
	 <h4 style="text-align: center;font-weight: 900;margin:10px 0 25px 20px;">${dto.staName}역</h4>
	<div class="staImage">
		      		<img src="<%=cp%>/resource/images/station/${dto.imageFilename}" style="width: 90%; height:300px; margin-bottom: 20px;"> 
		      	</div>
		      	
		      	<div style="width: 90%; margin: 0 auto; line-height: 2.5;">
					<div style="text-align: left;">
						<span style="font-size: 18px; font-weight: 800;">
							<i class="fas fa-map-marker-alt" style="color:#e82b2b; font-size: 23px;"></i>&nbsp;&nbsp;위치&nbsp;&nbsp;</span>
						<span class="address" style="font-size: 15px; color: #636363;">${dto.staAddress}</span>
					</div>
				
					<div style="text-align: left;">
						<span style="font-size: 18px; font-weight: 800;">
							<i class="fas fa-phone-volume" style="color: #368416; font-size: 23px;"></i>&nbsp;&nbsp;전화번호&nbsp;&nbsp;</span>
						<span class="tel" style="font-size: 15px; color: #636363;">${dto.staTel}</span>
					</div>
					
					<div style="text-align: left;">
						<span style="font-size: 18px; font-weight: 800;">
							<i class="fas fa-gift" style="color: #1c549a; font-size: 23px;"></i>&nbsp;&nbsp;혜택&nbsp;&nbsp;</span>
						<div style="font-size: 15px; color: #636363;">
							<c:if test="${sessionScope.member.userId=='admin'}">
								<table style="margin-left:400px;">
									<tr>	
										<td style="text-align: right;" width="40">
											<a href="javascript:location.href='<%=cp%>/station/benefit/created?staNum=${dto.staNum}&locNum=${dto.locNum}&page=${page}';" id="plus"><i class="far fa-plus-square" style="color: green; font-size: 20px;"></i></a>
										</td>
										<td style="text-align: right;" width="40">
											<a href="#" id="remove"><i class="far fa-minus-square" style="color: red; font-size: 20px;"></i></a>
										</td>
										<td style="text-align: right;" width="40">
											<a href="#" id="edit"><i class="far fa-edit" style="color: blue; font-size: 20px;"></i></a>
										</td>
									</tr>
								</table>
							</c:if>
							
							<table style="margin-left:5px; text-align: center; font-size: 12px;">

								<tr style="background: #283164; color: white;">
									<c:if test="${sessionScope.member.userId=='admin'}">
										<td width="60">선택</td>
									</c:if>
									<td width="60">분류</td>
									<td width="200">이름</td>
									<td width="250">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</td>
									<td width="100">시작 날짜</td>
									<td width="100">종료 날짜</td>
								</tr>
								<c:forEach var="vo" items="${beneList}">
							 	<tr style="border-bottom: 1px solid #d4cbcb;">
							 		<c:if test="${sessionScope.member.userId=='admin'}">
							 			<td><input type="radio" name="choice" value="${vo.beneNum}"></td>	
							 		</c:if>						
									<td>${vo.cateName}</td>
									<td>${vo.subject}</td>
									<td>${vo.content}</td>
									<td>${vo.sDate}</td>
									<td>${vo.eDate}</td>
								</tr>
								</c:forEach>
								<c:if test="${count==0}">
									<tr>
										<td colspan="5">아직 등록된 이벤트가 없습니다.</td>
									</tr>
								</c:if>								
								<tr style="border-bottom: 1px solid #d4cbcb;" class="benefit">								

								</tr>
							</table>
							<div class="benefit">
															
							</div>
						</div>
					</div>
		        </div>