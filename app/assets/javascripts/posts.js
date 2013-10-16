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
});