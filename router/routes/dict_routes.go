package routes

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/c_system"
	"hrkGo/app/middleware"
)

func RegisterDictRoutes(r *gin.RouterGroup) {

	DictController := c_system.DictController{}

	role := r.Group("/dict/type")
	{
		authRouter := role.Group("").Use(middleware.JWTAuth())
		{
			authRouter.GET("/list", DictController.DictList)
			//authRouter.GET("/refreshCache", DictController.refreshCache)

		}
	}

}
