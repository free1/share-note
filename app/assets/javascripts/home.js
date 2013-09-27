window.onload = function()
{
	// 点击div 选中checkbox
	var oRemember = document.getElementById('remember');
	var oCheckBox = document.getElementById('checkbox');
	var oEmail = document.getElementById('email');
	var oEmailVerify = document.getElementById('email_verify');
	var oPass = document.getElementById('password');
	var oPassVerify = document.getElementById('pass_verify');

	oRemember.onclick = function()
	{
		oCheckBox.checked = !oCheckBox.checked;
	}

	oEmail.onblur = function()
	{
		if(oEmail.value == "")
		{
			oEmailVerify.style.display = inline;
			alert("a");
		}
	}
	
}