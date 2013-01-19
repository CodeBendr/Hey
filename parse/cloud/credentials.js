exports.credentials = function(opt) {
	
	Parse.User.logIn(opt.username,opt.password,{
				success:function(user){
					
					opt.success(user);
					
					},
				error:function(user, error){
					
					opt.error(error);
					
					}
			    })
             }

