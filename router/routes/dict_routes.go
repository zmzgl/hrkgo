package routes

import (
	"github.com/gin-gonic/gin"
	"hrkGo/app/controllers/c_system"
	"hrkGo/app/middleware"
)

func RegisterDictRoutes(r *gin.RouterGroup) {

	DictController := c_system.DictController{}

	dict := r.Group("/dict")
	{
		authRouter := dict.Use(middleware.JWTAuth())
		{
			authRouter.GET("/type/list", DictController.DictList)
			authRouter.GET("/type/:dictId", DictController.SelectDictDataById)
			authRouter.GET("/type/optionselect", DictController.OptionSelect)
			authRouter.POST("/type", DictController.InsertDictData)
			authRouter.PUT("/type", DictController.UpdateDictData)
			authRouter.DELETE("/type/:dictIds", DictController.DeleteDictDataByIds)
			authRouter.DELETE("/type/refreshCache", DictController.RefreshCache)

			authRouter.GET("/data/list", DictController.DictDataList)
			authRouter.GET("/data/:dictCode", DictController.SelectDictDataByCode)
			authRouter.POST("/data", DictController.InsertDictDataValue)
			authRouter.PUT("/data", DictController.UpdateDictDataValue)
			authRouter.GET("/data/type/:dictType", DictController.SelectDictDataByType)
			authRouter.DELETE("/data/:dictCodes", DictController.DeleteDictDataByCodes)

		}
	}

}
