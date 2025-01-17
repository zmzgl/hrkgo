package sys_service

import (
	"hrkGo/app/model/sys_model"
	"hrkGo/app/repositories/sys_repositories"
)

type UserService struct {
}

// SelectUserList 获取用户列表
func (u *UserService) SelectUserList(req sys_model.UserListRequest) (users []sys_model.SysUserInfo, total int64, err error) {
	users, total, err = sys_repositories.UserCrud.SelectUserList(req)
	return users, total, err
}

// ResetPwd 修改密码
func (u *UserService) ResetPwd(req sys_model.SysUser) (err error) {
	return nil
}

// InsertUser 修改密码
func (u *UserService) InsertUser(req sys_model.SysUser) (err error) {
	err = sys_repositories.UserCrud.InsertUser(req)
	return err
}
