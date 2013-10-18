// jquery
$(document).ready(function(){
	// 主页文章显示
	$(".one_post").hover(
		function(){
			$(this).css("box-shadow", "0 1px 8px #aaaaaa");
		},
		function(){
			$(this).css("box-shadow", "0 0 0 white");
		}
	);

	// 发表文章时选择类型
	$(".kind a").hover(
		function(){
			$(this).css("opacity", "1");
		},
		function(){
			$(this).css("opacity", "0.6")
		}
	);
});