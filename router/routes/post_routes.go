package routes

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/c_system"
	"hrkGo/app/middleware"
)

func RegisterPostRoutes(r *gin.RouterGroup) {
	PostController := c_system.PostController{}
	post := r.Group("/post")
	{
		authRouter := post.Use(middleware.JWTAuth())
		{
			authRouter.Use(middleware.PermissionMiddleware("system:post:query")).GET("/list", PostController.SelectPostList)
		}
	}
}
