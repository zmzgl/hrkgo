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
			authRouter.Use(middleware.PermissionMiddleware("system:user:list")).GET("/deptTree", UserController.DeptTree)
			authRouter.Use(middleware.PermissionMiddleware("system:user:list")).GET("/list", UserController.SelectUserList)
			authRouter.Use(middleware.PermissionMiddleware("system:user:add")).POST("", UserController.InsertUser)
			authRouter.Use(middleware.PermissionMiddleware("system:user:resetPwd")).PUT("/resetPwd", UserController.ResetPwd)

		}
	}
}
