package cSystem

import (
	"fmt"
	"github.com/gin-gonic/gin"
	servicesystem "hrkGo/app/service/system"
	"hrkGo/utils/global/consts"
	"hrkGo/utils/response"
)

// Response 响应结构体
type Response struct {
	Code    int         `json:"code"`    // 自定义错误码
	Data    interface{} `json:"data"`    // 数据
	Message string      `json:"message"` // 信息
}

// CaptchaImage 获取验证码
func CaptchaImage(c *gin.Context) {
	id, b64s, err := servicesystem.CaptMake()
	if err != nil {
		fmt.Println(err)
	}
	res := gin.H{
		"uuid": id, "img": b64s,
	}
	response.Success(c, consts.CurdStatusOkMsg, res)
}
