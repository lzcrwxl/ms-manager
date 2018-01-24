<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>${fns:getConfig('productName')}-学员信息管理</title>
  <meta name="decorator" content="default" />
  <link rel="stylesheet" href="${ctxStatic}/plugins/date-time/css/global.css" />
  <style>
	#layer_s {
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		z-index: 19891015;
		background-color: #000;
		opacity: 0.3;
		filter: alpha(opacity = 30);
	}
	.btnBox .btnBase {
		cursor: pointer;
	}

	.pay_orcode {
		display: none;
		background-color: #fff;
		position: absolute;
		z-index: 19891016;
		padding: 30px 50px;
		top: 200px;
		left: 50%;
		margin-left: -240px;
	}

	.close {
		position: absolute;
		width: 18px;
		height: 18px;
		top: 8px;
		right: 8px;
		cursor: pointer;
	}
	
	.orcode {
		text-align: center;
	}
	
	.orcode img {
		width: 301px;
		height: 301px;
	}
	
	.orcode p {
		text-align: center;
		font-size: 14px;
		line-height: 22px;
		margin: 16px 0 8px;
		background-position: 48px center;
	}
	
	
 </style>
 <script>
     function getPayUrl() {
      return "${fns:getConfig('pay.url')}";
         }
  </script>
</head>

<body>
	<div id="layer_s" style="display: none;"></div>
	<div class="pay_orcode" style="display: none;">
		<img class="close" src="${ctxStatic}/loginImg/alertclose.png">
		<div class="orcode">
			<img id="img" src="">
			<p>
				打开手机<span id="type"></span><br>扫描二维码支付
			</p>
		</div>
	</div>
	<form class="form-horizontal">
		<ul id="breadcrumb" style="display: none">
			<li>教务管理>学员管理>学员信息</li>
		</ul>
		<div class="frame">
			<div class="content">
				<div class="content-area">
					   <c:if test="${fns:isHasRole('jwgl_edit')}" >
						<span id="kaitong" class="top_button">开通在线学堂</span>
					   </c:if>
					<div class="infoBlock" id="idInfoBox">
						<h1 class="title">身份信息</h1>
						<div class="ib-content clearfix">
							<div id="idPhoto">
								<ul>
									<li><img
										src="${stuUserInfo.headImage == ''||stuUserInfo.headImage == null ? '/jiacerconsole/static/loginImg/avatar.png' : stuUserInfo.headImage }"
										class="idImage" /></li>
								</ul>
							</div>
							<table style="width: 38%;">
								<tbody>
									<tr>
										<td>姓名：</td>
										<td class="secTd">${stuUserInfo.userName}</td>
									</tr>
									<tr>
										<td>身份证号：</td>
										<td class="secTd">${stuUserInfo.certNo}</td>
									</tr>
									<tr>
										<td>年龄：</td>
										<td class="secTd">${stuUserInfo.age}</td>
									</tr>
									<tr>
										<td>籍贯：</td>
										<td class="secTd">${stuUserInfo.birthplace}</td>
									</tr>
									<tr>
										<td>发证机构：</td>
										<td class="secTd">${stuUserInfo.issueOrg}</td>
									</tr>
								</tbody>
							</table>
							<table style="width: 38%;">
								<tbody>
									<tr>
										<td></td>
										<td class="secTd"></td>
									</tr>
									<tr>
										<td>性别：</td>
										<td class="secTd">${stuUserInfo.sex=='1'?"男":"女"}</td>
									</tr>
									<tr>
										<td>民族：</td>
										<td class="secTd">${fns:getText(6,0 ,stuUserInfo.nation)}
										</td>
									</tr>
									<tr>
										<td>户籍地址：</td>
										<td class="secTd">${stuUserInfo.address}</td>
									</tr>
									<tr>
										<td>有效期至：</td>
										<td class="secTd">${stuUserInfo.expiredTime}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="infoBlock">
						<h1 class="title">基本信息</h1>
						<div class="ib-content clearfix">
							<table>
								<tr>
									<td>手机号码：</td>
									<td class="secTd">${stuUserInfo.mobile}</td>
								</tr>
								<tr>
									<td>学历：</td>
									<td class="secTd"><select
										class="chosen-select form-control" id="education">
											<option value="">--请选择--</option>
											<c:forEach items="${fns:getParams(3,0)}" var="obj"
												varStatus="item">
												<option value="${obj.value}"
													<c:if test="${obj.value==stuUserInfo.education}">selected="selected"</c:if>>${obj.text}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<td>联系地址：</td>
									<td class="secTd"><input type="text" id="contactAddress"
										name="" value="${stuUserInfo.contactAddress}"></td>
								</tr>
								<tr>
									<td>紧急联系人：</td>
									<td class="secTd"><input type="text" id="contacts" name=""
										value="${stuUserInfo.contacts}"></td>
								</tr>
							</table>
							<table>
								<tr></tr>
								<tr>
								</tr>
								<tr></tr>
								<tr>
									<td>紧急联系电话：</td>
									<td class="secTd"><input type="text" id="contactPhone"
										name="" value="${stuUserInfo.contactPhone}"></td>
								</tr>
							</table>
						</div>
					</div>

					<div class="infoBlock">
						<h1 class="title">报考信息</h1>
						<div class="ib-content clearfix">
							<c:forEach items="${stuUserInfo.orderList}" var="obj"
								varStatus="item">
								<ul class="certificate">
									<li class="clearfix">
										<table>
											<tr>
												<td>课程名称：</td>
												<td class="secTd">${obj.typeName}</td>
											</tr>
											<tr>
												<td>是否考试：</td>
												<td class="secTd">${obj.isExam=="1"?"是":"否"}</td>
											</tr>
											<tr>
												<td>考试状态：</td>
												<td class="secTd"><c:if
														test="${not empty obj.examClass}">
                                                                    ${fns:getText(32,0,obj.examClass.examStatus)}
                                                                </c:if></td>
											</tr>
											<tr>
												<td>鉴定等级：</td>
												<td class="secTd">${obj.authenticateGrade }</td>
											</tr>
											<tr>
												<td>理论成绩：</td>
												<td class="secTd"><c:if
														test="${not empty obj.userScores}">
                                                                    ${obj.userScores.theoryScores}
                                                                </c:if></td>
											</tr>
											<tr>
												<td>技能成绩：</td>
												<td class="secTd"><c:if
														test="${not empty obj.userScores}">
                                                                    ${obj.userScores.poScores}
                                                                </c:if></td>
											</tr>
											<tr>
												<td>发证日期：</td>
												<td class="secTd">${obj.userScores.issuingDateTxt}</td>
											</tr>
											<tr>
												<td>证书编号：</td>
												<td class="secTd"><c:if test="${not empty obj.userScores}">
                                                                    ${obj.userScores.certificateNo}
                                                                </c:if>
                                                                </td>
											</tr>
											<tr>
												<td>发证机构：</td>
												<td class="secTd">${obj.userScores.certAuthorityName}</td>
											</tr>
											<tr>
												<td>来源信息：</td>
												<td class="secTd">${obj.sourceWholeText}</td>
											</tr>
										</table>
										<table>
											<tr>
												<td>审核时间：</td>
												<td class="secTd"><fmt:formatDate
														value="${obj.handleTime}" type="both" /></td>
											</tr>
											<tr>
												<td>是否交金：</td>
												<td class="secTd">${obj.isHasPf == '1' ? '是' : '否'}</td>
											</tr>
											<tr>
												<td>班级标号：</td>
												<td class="secTd"><c:if
														test="${not empty obj.examClass}">
                                                                    ${obj.examClass.classNumber}
                                                                </c:if></td>
											</tr>
											<tr>
												<td></td>
												<td></td>
											</tr>
											<tr>
												<td>综合成绩：</td>
												<td class="secTd"><c:if
														test="${not empty obj.userScores}">
                                                                    ${obj.userScores.comprehensiveScores}
                                                                </c:if></td>
											</tr>
											<tr>
												<td>能力成绩：</td>
												<td class="secTd">${obj.userScores.abilityScores}</td>
											</tr>
											<tr>
												<td>评定结果：</td>
												<td class="secTd"><c:if
														test="${not empty obj.userScores}">
                                                                    ${fns:getText(12,0,obj.userScores.examResult)}
                                                                </c:if></td>
											</tr>
											<tr>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <td>分期首付</td>
                                                           	<c:if test="${obj.isStaging=='0'}">
																<td class="secTd">否</td>
															</c:if>
															<c:if test="${obj.isStaging=='1'}">
																<td class="secTd">${obj.firstPay}
																  <c:if test="${obj.isClear=='0'}">		
																     <!-- <button class="btnBase confirm" id="noClear" type="button" onclick="">待结清</button> -->		
																  </c:if> 
																  <c:if test="${obj.isClear=='1'}">
																	  <!-- <button  id="isClear" type="button" disabled="disabled" onclick="">已结清</button> -->
																	  <span>${obj.stagingClearName} 退还 <fmt:formatDate value="${obj.stagingClearTime }" type="both" /></span>
																  </c:if>
																  <button  id="isClear2" style="display:none;" type="button" disabled="disabled" onclick="">已结清</button>	
																</td>		
															</c:if>
                                                        </tr>
                                                        <tr>
                                                            <td>押金费</td>
                                                           	<c:if test="${obj.isDeposit=='0'}">
																<td class="secTd">否</td>
															</c:if>
															<c:if test="${obj.isDeposit=='1'}">
																<td class="secTd">${obj.deposit}
																  <c:if test="${obj.isDepositClear=='0'}">		
																     <!-- <button class="btnBase confirm" id="noClear" type="button" onclick="">待结清</button> -->		
																  </c:if> 
																  <c:if test="${obj.isDepositClear=='1'}">
																	  <!-- <button  id="isClear" type="button" disabled="disabled" onclick="">已结清</button> -->
																	  <span>${obj.depositClearName} 退还 <fmt:formatDate value="${obj.depositClearTime }" type="both" /></span>
																  </c:if>
																  <button  id="isClear2" style="display:none;" type="button" disabled="disabled" onclick="">已结清</button>	
																</td>		
															</c:if>
                                                        </tr>
										</table>
									</li>
								</ul>
							</c:forEach>
						</div>
					</div>

					<div class="btnCase clearfix">
						<button class="bc-cancel" id="goBack"  type="button">取消</button>
						<c:if test="${fns:isHasRole('jwgl_edit')}" >
						<button class="bc-confirm" id="modifyBtn" type="button">保存</button>
					   </c:if>

					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="module">
		<!--弹窗代理开通-->
		<div class="popup" id="proxy">
			<h3>代理开通</h3>
			<ul class="iptList">
				<li class="iptItem"><span class="iptTitle"> 视频课程&nbsp;:
				</span>
					<div class="iptContent">
						<select name="course" id="course" onchange="isClick()">
							<option value="">----请选择---</option>
							<c:forEach items="${courseInfoList}" var="obj" varStatus="item">
								<option value="${obj.courseId}">${obj.courseName}</option>
							</c:forEach>
						</select>
					</div></li>
				<li class="iptItem mt20"><span class="iptTitle">
						支付金额&nbsp;: </span>
					<div id="showDiv" class="iptContent pl5">0.0 元/永久</div></li>
				<li class="iptItem  mt20"><span class="iptTitle">
						支付方式&nbsp;: </span></li>
				<li class="iptItem  mt10 radio_box_box">
					<%-- <span class="iptTitle">
          <input type="radio" id="alipay" name="payment">
          </span> --%>
					<div class="radio_box" style="float: left; margin-top: 6px">
						<input type="radio" checked="checked" id="alipay" name="payment"
							value="01">
						<div class="circle-box active">
							<span class="circle"></span>
						</div>
					</div>
					<div class="iptContent">
						<label for="alipay">
							<div class="btnWrapper btnAlipay"></div>
						</label>
					</div>
				</li>
				<li class="iptItem  mt15 radio_box_box">
					<%-- <span class="iptTitle">
          <input type="radio" id="wechat" name="payment">
          </span> --%>
					<div class="radio_box" style="float: left; margin-top: 6px">
						<input type="radio" id="wechat" name="payment" value="02">
						<div class="circle-box">
							<span class="circle"></span>
						</div>
					</div>
					<div class="iptContent">
						<label for="wechat">
							<div class="btnWrapper btnWechat"></div>
						</label>
					</div>
				</li>
			</ul>
			<div class="btnBox">
				<a href="#" class="btnBase cancel">取消</a><a id="payMentBtn"
					class="btnBase confirm">确认支付</a>
			</div>
		</div>
	</div>
	<c:forEach items="${courseInfoList}" var="obj" varStatus="item">
		<input id="T_${obj.courseId}" value="${obj.price}" type="hidden" />
	</c:forEach>
	<input id="userId" value="${stuUserInfo.id} " type="hidden" />
	<input id="baseUserId" value="${stuUserInfo.userId} " type="hidden" />
	<input id="tradeNo" value="" type="hidden" />
	<script src="${ctxStatic}/modules/users/form.js"></script>
	<script src="${ctxStatic}/modules/help.js"></script>
	<script type="text/javascript">
                    $(function() {
                        $(".secTd").on("click", ".radio_box input", function() {
                            $(this).siblings(".circle-box").addClass("active");
                            $(this).parent().siblings(".radio_box").children(".circle-box").removeClass("active");
                        })
                        $(".iptItem").on("click", ".radio_box input", function() {
                            $(this).siblings(".circle-box").addClass("active");
                            $(this).parents(".radio_box_box").siblings(".radio_box_box").find(".circle-box").removeClass("active");
                        })
                        $(".top_button").click(function() {
                            $("#course").val("");
                            $("#showDiv").text("0.0 元/永久");
                            $(".module").show();
                        })
                        $(".cancel").click(function() {
                            $(".module").hide();
                        })
                        $(".close").click(function() {
                            $("#layer_s,.pay_orcode").hide();
                        })
                        $(".radio_box input").each(function() {
                            if ($(this).is(":checked")) {
                                $(this).siblings(".circle-box").addClass("active");
                                $(this).parent().siblings(".radio_box").children(".circle-box").removeClass("active");
                            }
                        })

                    });

                    function isClick() {
                        var hiddenId = "T_" + document.getElementById("course").value;
                        $("#showDiv").text(document.getElementById(hiddenId).value + " 元/永久");
                    }
                </script>
</body>

</html>