package model

import "hrkGo/utils/response"

// PageInfo Paging common input parameter structure
type PageInfo struct {
	PageNum  int `json:"pageNum" form:"pageNum" binding:"required"`
	PageSize int `json:"pageSize" form:"pageSize" binding:"required"`
}

func (pageInfo PageInfo) GetMessages() response.ValidatorMessages {
	return response.ValidatorMessages{
		"PageNum.required":  "pageNum不能为空",
		"PageSize.required": "pageSize不能为空",
	}
}
