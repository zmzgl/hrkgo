package sys_service

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/app/repositories/sys_repositories"
)

type PostService struct {
}

// SelectPostList 获取部门树
func (u *PostService) SelectPostList(req sys_model.RoleListRequest) ([]*sys_model.SysPost, int64, error) {
	dept, total, err := sys_repositories.PostCrud.SelectPostList(req)
	return dept, total, err
}
