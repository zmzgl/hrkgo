package routes

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/c_system"
	"hrkGo/app/middleware"
)

func RegisterUserRoutes(r *gin.RouterGroup) {
	UserController := c_system.UserController{}
	user := r.Group("/user")
	{
		authRouter := user.Use(middleware.JWTAuth())
		{
			authRouter.GET("/deptTree", UserController.DeptTree)
		}
	}
}
