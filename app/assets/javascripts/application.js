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
    // 注册页面

    
    // @评论者
		var commenter = [];
		// 循环遍历评论者
		$('.comment_commenter').each(function() {
			// 当找到的评论者没有包含到数组中时，就加入数组
			if($.inArray($(this).text(), commenter) < 0){
		      commenter.push($(this).text());
		    }
		});
		$(".textarea").atwho({at:"@", 'data':commenter});
});


