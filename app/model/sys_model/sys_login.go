package sys_model

import "hrkGo/utils/response"

type Login struct {
	Username string `form:"username" json:"username" binding:"required"`
	Password string `form:"password" json:"password" binding:"required"`
	Code     string `form:"code" json:"code" binding:"required"`
	Uuid     string `form:"uuid" json:"uuid" binding:"required"`
}

func (login Login) GetMessages() response.ValidatorMessages {
	return response.ValidatorMessages{
		"Username.required": "账号不能为空",
		"Password.required": "密码不能为空",
		"Code.required":     "验证码不能为空",
		"Uuid.required":     "验证码id不能为空",
	}
}
