Parse.Cloud.define("getMedia", function(request, response) {
	
  var query = new Parse.Query("Media");
  //query.equalTo("Picture", "type");
  query.find({
    success: function(results) {
		
		var objects = [];
		
		for (var i = 0; i < results.length; ++i) {
		
		var media = {};
        media = {
		  caption:results[i].get("caption"),
		  category:results[i].get("category"),
		  location:results[i].get("location")
		  };
		  
		  objects.push(media);
    
		}
      response.success(objects);
    },
    error: function() {
      response.error("caption not retrieved");
    }
  });
  
});


Parse.Cloud.define("searchMedia", function(request, response) {
	
	var string = "3rd";
	var search_string = string.charAt(0).toUpperCase() + string.slice(1);
	
	var query = new Parse.Query("Media");
	query.startsWith("location",search_string);
	
	query.find({
    success: function(results) {
		
		var objects = [];
		
		for (var i = 0; i < results.length; ++i) {
		
		var media = {};
        media = {
		  caption:results[i].get("caption"),
		  category:results[i].get("category"),
		  location:results[i].get("location")
		  };
		  
		  console.log(media + " yup");
		  
		  objects.push(media);
    
		}
      response.success(objects);
    },
    error: function() {
      response.error("caption not retrieved");
    }
  });
})


Parse.Cloud.define("sendEmail",function(req,res){
	
	var mandrill = require('mandrill');
    mandrill.initialize('18qUE3M6FABa5FZ2Lk_qcQ');
	
	mandrill.sendEmail({
    message: {
    text: "Hello World!",
    subject: "Using Cloud Code and Mandrill is great!",
    from_email: "youngskrilla@hotmail.com",
    from_name: "CodeBender",
    to: [
      {
        email: "geek@idmgh.com",
        name: "Evans Attafuah"
      }
    ]
  },
  async: true
},{
  success: function(httpResponse) {
    console.log(httpResponse);
    res.success("Email sent!");
  },
  error: function(httpResponse) {
    console.error(httpResponse);
    res.error("Uh oh, something went wrong");
  }
});
	
	});