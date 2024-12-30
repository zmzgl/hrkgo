package routes

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/c_system"
	"hrkGo/app/middleware"
)

func RegisterDictRoutes(r *gin.RouterGroup) {

	DictController := c_system.DictController{}

	role := r.Group("/dict")
	{
		authTypeRouter := role.Use(middleware.JWTAuth())
		{
			authTypeRouter.GET("/type/list", DictController.DictList)
			authTypeRouter.GET("/type/:dictId", DictController.SelectDictDataById)
			authTypeRouter.POST("/type", DictController.InsertDictData)
			authTypeRouter.PUT("/type", DictController.UpdateDictData)

			authTypeRouter.DELETE("/type/:dictIds", DictController.DeleteDictDataByIds)

			authTypeRouter.DELETE("/type/refreshCache", DictController.RefreshCache)

			authTypeRouter.GET("/data/type/:dictType", DictController.SelectDictDataByType)

		}
	}

}
