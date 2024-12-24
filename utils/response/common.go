package response

// 分页请求参数
type PaginationRequest struct {
	Page     int `form:"page"  json:"page" binding:"required"`         // 页码
	PageSize int `form:"page_size" json:"pageSize" binding:"required"` // 每页数量
}

func (pageInfo PaginationRequest) GetMessages() ValidatorMessages {
	return ValidatorMessages{
		"page.required":     "page不能为空",
		"pageSize.required": "pageSize不能为空",
	}
}

// 分页响应数据
type PaginationResponse struct {
	List     interface{} `json:"list"`     // 数据列表
	Total    int64       `json:"total"`    // 总数据量
	Page     int         `json:"page"`     // 当前页码
	PageSize int         `json:"pageSize"` // 每页数量
	Pages    int         `json:"pages"`    // 总页数
}
