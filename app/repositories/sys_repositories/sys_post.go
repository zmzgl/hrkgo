package sys_repositories

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
)

type postCrud struct{}

var PostCrud = new(postCrud)

// SelectPostList 实现接口方法
func (m *postCrud) SelectPostList(req sys_model.RoleListRequest) (list []*sys_model.SysPost, total int64, err error) {
	// 构建查询条件
	db := variable.GormDbMysql.Model(&sys_model.SysPost{})

	err = db.Count(&total).Error
	if err != nil {
		return nil, 0, err
	}

	// 查询列表
	offset := (req.PageNum - 1) * req.PageSize

	err = db.
		Offset(offset).
		Limit(req.PageSize).
		Find(&list).Error
	return list, total, err
}
