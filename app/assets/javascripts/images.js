
	$(document).ready(function()
{
    $('#uploadBtn').live('change', function ()
    {
		$('#output').empty();
		console.log(this.files);
        for (var i = 0; i < this.files.length; i++)
        {

			$('<li />', {text: this.files[i].name}).appendTo('#output');

        }
		if (this.files.length > 0){
			$("label span").text(this.files.length + " bestanden geselecteerd.");
		} else {
			$("label span").text("Sleep hier bestanden naartoe of klik om te bladeren.");
		}
    });
});
	  
