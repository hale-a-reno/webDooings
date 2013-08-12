
$(document).ready(function(){
        
            $('#openBtn').click(function(){
        					
						$('#myModal').modal({show:true})});
        	$('#getDbtn').click(fillTable);
	


        });


function fillTable() {

			$.ajax({
				type: "GET",
				url: "http://10.65.30.75/db.php",
				success: function(html){	
							$("#tCont").html(html);
							}
				});

			}			 
