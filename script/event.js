var imageslider_current = 0;
var imageslider_last_index;

window.onload = function() {
	
	$(window).resize(function() {
		imageslider_last_index = $(".imageslider .image").length - 1;
		
		var width = $(window).width(); if(width < 1024) width = 1024;
		var height = $(".imageslider").height() * (width / $(".imageslider").width());
		$(".imageslider").width(width);
		$(".imageslider").height(height);
		$(".imageslider .images").width(width);
		$(".imageslider .images").height(height);
		
		var total_width = 0;
		$(".imageslider .image").each(function(index, item) {
			$(this).css("left", total_width);
			total_width += width;
		
			$(".imageslider .navigator").append(
				$(this).clone().find("img").addClass("thumbnail").click(function() {
					imageslider_current = index;
					imageslider_slideTo(index);
				})
			);
		});
		
		$(".imageslider .image img").each(function() {
			$(this).width(width);
			$(this).height(height);
		});
	});
	$(window).resize();
	
	$(".imageslider .imageslider_left").click(function() {
		imageslider_current--;
		imageslider_slideTo(imageslider_current);
	});
	
	$(".imageslider .imageslider_right").click(function() {
		imageslider_current++;
		imageslider_slideTo(imageslider_current);
	});
	
	imageslider_updateLayout();
	
	function imageslider_slideTo(index) {
		imageslider_current = index;
		
		imageslider_updateLayout();
		
		var left = $(".imageslider .image").eq(index).css("left");
		$(".imageslider .images").animate({
			scrollLeft: left
		}, 400);
	}
	
	function imageslider_updateLayout() {
		if(imageslider_current == 0) {
			$(".imageslider .imageslider_left").hide();
			$(".imageslider .imageslider_right").show();
		}
		else if(imageslider_current == imageslider_last_index) {
			$(".imageslider .imageslider_left").show();
			$(".imageslider .imageslider_right").hide();
		}
		else {
			$(".imageslider .imageslider_left").show();
			$(".imageslider .imageslider_right").show();
		}
		
		$(".imageslider .navigator .thumbnail").each(function(index) {
			if(index == imageslider_current) {
				$(this).addClass("current");
			}
			else {
				$(this).removeClass("current");
			}
		});
	}
	
};
	
var selected_item;

function selectItem(index) {
	selected_item = index;
	
	$("#popup_detail .sub").css("background-image", "url('./image/popup_detail/image_" + index + ".png')");
	$("#popup_vote .top").css("background-image", "url('./image/popup_vote/image_" + index + ".png')");
}

function validateInput() {
	var name = $("#popup_input_name").val();
	var phone1 = $("#popup_input_phone1").val();
	var phone2 = $("#popup_input_phone2").val();
	var phone3 = $("#popup_input_phone3").val();
	var email = $("#popup_input_email").val();
	var agree = $("#popup_input input[name='agree']:checked").val();
	
	if(name == "") {
		alert("이름을 입력해주세요.");
		return;
	}
	
	if(phone1 == "" || phone2 == "" | phone3 == "") {
		alert("휴대폰 번호를 입력해주세요.");
		return;
	}
	
	if(email == "") {
		alert("이메일을 입력해주세요.");
		return;
	}
	
	var emailRegExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	
	if(!emailRegExp.test(email)) {
		alert("이메일 형식이 올바르지 않습니다.");
		return;
	}
	
	if(agree == undefined) {
		alert("개인정보수집 동의 여부에 체크해주세요.");
		return;
	}
	
	if(agree == "0") {
		alert("개인정보수집에 동의하시지 않으시면 경품을 받으실 수 없습니다.");
		return;
	}
	
	if(confirm("이 정보로 경품 이벤트에 참가하시겠습니까?")) {
		$("#popup_input").submit();
	}
}
