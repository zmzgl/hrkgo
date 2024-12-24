package handler

import "github.com/gin-gonic/gin"

type UserHandler struct {
	// 依赖注入
}

func NewUserHandler() *UserHandler {
	return &UserHandler{}
}

func (h *UserHandler) Login(c *gin.Context) {
	// 实现登录逻辑
}

func (h *UserHandler) Register(c *gin.Context) {
	// 实现注册逻辑
}

// ... 实现其他接口方法
