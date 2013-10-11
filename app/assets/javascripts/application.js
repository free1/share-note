// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.atwho 
//= require jquery_ujs
//= require bootstrap
//= require_tree .


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

    // 注册页面

    
    // @评论者
	// var commenter = [];
	// var commenter_exist= [];
	// $('.comment-header-author').each(function() {
	// 	if($.inArray($(this).text(), commenter_exist) < 0){
	// 		  commenter.push($(this).text());
	// 		  commenter_exist.push($(this).text());
	// 	}
	// });

	data = ['tom','john'];
	$(".textarea").atwho({at:"@", 'data':data});

});


