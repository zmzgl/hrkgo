package sys_service

import (
	"encoding/json"
	"errors"
	"fmt"
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/redis/dict_redis"
	"time"
)

var dictStore = dict_redis.DictStore{
	Client: variable.Redis,
}

type DictService struct {
}

// DictWithData 定义返回结果的结构体
type DictWithData struct {
	DictId    int64                   `json:"dictId"`    // 字典主键
	DictName  string                  `json:"dictName"`  // 字典名称
	DictType  string                  `json:"dictType"`  // 字典类型
	Status    string                  `json:"status"`    // 状态
	Remark    string                  `json:"remark"`    // 备注
	DictDatas []sys_model.SysDictData `json:"dictDatas"` // 字典数据列表
}

// GetDictList 获取字典分页
func (d DictService) GetDictList(req sys_model.DictListRequest) (list []sys_model.SysDictType, total int64, err error) {

	// 初始化数据库查询
	db := variable.GormDbMysql.Model(&sys_model.SysDictType{})

	// 根据请求参数应用过滤条件
	if req.DictName != "" {
		db = db.Where("dict_name LIKE ?", "%"+req.DictName+"%")
	}

	if req.DictType != "" {
		db = db.Where("dict_type LIKE ?", "%"+req.DictType+"%")
	}

	if req.Status != "" {
		db = db.Where("status = ?", req.Status)
	}

	// 添加时间范围查询
	if req.BeginTime != "" && req.EndTime != "" {

		start, _ := time.Parse("2006-01-02", req.BeginTime)

		end, _ := time.Parse("2006-01-02", req.EndTime)

		// 将结束日期调整到当天的最后一刻
		end = end.Add(24 * time.Hour).Add(-time.Second)

		db = db.Where("create_time BETWEEN ? AND ?",
			start,
			end)
	}

	// 统计符合条件的总记录数
	if err = db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	// 计算分页偏移量
	offset := (req.PageNum - 1) * req.PageSize

	// 查询字典列表并分页
	err = db.Offset(offset).Limit(req.PageSize).Find(&list).Error

	return list, total, err
}

// GetDictDataList 获取字典数据分页
func (d DictService) GetDictDataList(req sys_model.DictListDataRequest) (list []sys_model.SysDictData, total int64, err error) {

	db := variable.GormDbMysql.Model(&sys_model.SysDictData{})

	if req.DictType != "" {
		db = db.Where("dict_type LIKE ?", "%"+req.DictType+"%")
	}

	if req.Status != "" {
		db = db.Where("status = ?", req.Status)
	}

	if req.DictLabel != "" {
		db = db.Where("dict_label = ?", req.DictLabel)
	}

	// 统计符合条件的总记录数
	if err = db.Count(&total).Error; err != nil {
		return nil, 0, err
	}

	// 计算分页偏移量
	offset := (req.PageNum - 1) * req.PageSize

	// 查询字典列表并分页
	err = db.Offset(offset).Limit(req.PageSize).Find(&list).Error

	return list, total, err
}

// InsertDictData 获取所有字典及其数据
func (d DictService) InsertDictData(dict *sys_model.SysDictType) (err error) {

	// 同时检查字典名称和字典类型
	var count int64
	err = variable.GormDbMysql.Model(&sys_model.SysDictType{}).
		Where("dict_type = ? OR dict_name = ?", dict.DictType, dict.DictName).
		Count(&count).Error

	if err != nil {
		return err
	}

	if count > 0 {
		return errors.New("字典名称或字典类型已存在")
	}

	return variable.GormDbMysql.Create(dict).Error
}

// InsertDictDataValue 添加字典数据
func (d DictService) InsertDictDataValue(dict *sys_model.SysDictData) (err error) {

	// 同时检查字典名称和字典类型
	var count int64
	err = variable.GormDbMysql.Model(&sys_model.SysDictData{}).
		Where("dict_type = ? AND (dict_label = ? OR dict_value = ?)",
			dict.DictType,
			dict.DictLabel,
			dict.DictValue).Count(&count).Error

	if err != nil {
		return err
	}

	if count > 0 {
		return errors.New("数据标签或数据键值已存在")
	}

	return variable.GormDbMysql.Create(dict).Error
}

// UpdateDictDataValue 更新字典数据
func (d DictService) UpdateDictDataValue(dict sys_model.SysDictData) (err error) {

	// 准备更新的数据
	updates := map[string]interface{}{
		"update_time": time.Now(),
	}

	if dict.DictSort != 0 {
		updates["dict_sort"] = dict.DictSort
	}
	if dict.DictLabel != "" {
		updates["dict_label"] = dict.DictLabel
	}
	if dict.DictValue != "" {
		updates["dict_value"] = dict.DictValue
	}
	if dict.DictType != "" {
		updates["dict_type"] = dict.DictType
	}
	if dict.CssClass != "" {
		updates["css_class"] = dict.CssClass
	}
	if dict.ListClass != "" {
		updates["list_class"] = dict.ListClass
	}
	if dict.IsDefault != "" {
		updates["is_default"] = dict.IsDefault
	}
	if dict.Status != "" {
		updates["status"] = dict.Status
	}
	if dict.UpdateBy != "" {
		updates["update_by"] = dict.UpdateBy
		updates["update_time"] = dict.UpdateTime
	}
	if dict.Remark != "" {
		updates["remark"] = dict.Remark
	}

	result := variable.GormDbMysql.Model(&sys_model.SysDictData{}).
		Where("dict_code = ?", dict.DictCode).
		Updates(updates)

	if result.Error != nil {
		return result.Error
	}

	if result.RowsAffected == 0 {
		return errors.New("记录不存在")
	}

	return nil
}

// UpdateDictData 更新字典
func (d DictService) UpdateDictData(dict sys_model.SysDictType) (err error) {

	var count int64
	err = variable.GormDbMysql.Model(&sys_model.SysDictType{}).
		Where("(dict_type = ? OR dict_name = ?) AND dict_id != ?",
			dict.DictType, dict.DictName, dict.DictId).
		Count(&count).Error

	if err != nil {
		return err
	}

	if count > 0 {
		return errors.New("已存在相同的字典类型或字典名称")
	}

	// 创建一个map来存储需要更新的字段
	updates := make(map[string]interface{})

	// 只更新非空字段
	if dict.DictName != "" {
		updates["dict_name"] = dict.DictName
	}
	if dict.DictType != "" {
		updates["dict_type"] = dict.DictType
	}
	if dict.Status != "" {
		updates["status"] = dict.Status
	}
	if dict.UpdateBy != "" {
		updates["update_by"] = dict.UpdateBy
		updates["UpdateTime"] = dict.UpdateTime
	}

	if dict.Remark != "" {
		updates["remark"] = dict.Remark
	}

	// 更新时间总是会更新
	now := time.Now()
	updates["update_time"] = &now // 修改这里，传入时间指针

	// 执行更新操作，只更新非零值字段
	result := variable.GormDbMysql.Model(&sys_model.SysDictType{}).
		Where("dict_id = ?", dict.DictId).
		Updates(updates)

	if result.Error != nil {
		return result.Error
	}

	// 如果没有记录被更新
	if result.RowsAffected == 0 {
		return errors.New("record not found")
	}

	return nil
}

// DeleteDictDataByIds 获取所有字典及其数据
func (d DictService) DeleteDictDataByIds(dictIds []int64) (err error) {
	return variable.GormDbMysql.Where("dict_id IN ?", dictIds).Delete(&sys_model.SysDictType{}).Error
}

// DeleteDictDataByCodes 获取所有字典及其数据
func (d DictService) DeleteDictDataByCodes(codeList []int64) (err error) {
	return variable.GormDbMysql.Where("dict_code IN ?", codeList).Delete(&sys_model.SysDictData{}).Error
}

// SelectDictDataByType 获取所有字典及其数据
func (d DictService) SelectDictDataByType(dictType string) (jsonData []sys_model.SysDictData, err error) {
	dictJson := dictStore.Get("sys_dict:"+dictType, false)
	// 正确的写法
	var dictData []sys_model.SysDictData
	err = json.Unmarshal([]byte(dictJson), &dictData)
	return dictData, err
}

// SelectDictDataById 获取字典详情
func (d DictService) SelectDictDataById(dictType string) (dictTypeData sys_model.SysDictType, err error) {
	err = variable.GormDbMysql.Where("dict_id = ?", dictType).First(&dictTypeData).Error
	return dictTypeData, err
}

// SelectDictDataByCode 获取字典数据详情
func (d DictService) SelectDictDataByCode(dictCode string) (DictData sys_model.SysDictData, err error) {
	err = variable.GormDbMysql.Where("dict_code = ?", dictCode).First(&DictData).Error
	return DictData, err
}

// OptionSelect 获取字典选择框列表
func (d DictService) OptionSelect() (dictData []sys_model.SysDictType, err error) {
	err = variable.GormDbMysql.Find(&dictData).Error
	return dictData, err
}

// RefreshCache 获取所有字典及其数据
func (d DictService) RefreshCache() (err error) {
	var result []sys_model.SysDictRedis
	err = variable.GormDbMysql.Model(&sys_model.SysDictRedis{}).
		Preload("Child", "status = ?", "0").
		Find(&result).Error
	_, err = dictStore.DeleteByPrefixBatch("sys_dict", 100)
	if err != nil {

	}
	for _, dict := range result {

		err := d.setRedis(dict)
		if err != nil {
			return err
		}
	}
	return err
}

// RefreshCache 获取所有字典及其数据
func (d DictService) setRedis(dict sys_model.SysDictRedis) (err error) {

	// 将每个字典类型转换为 JSON
	jsonData, err := json.Marshal(dict.Child)
	if err != nil {
		return fmt.Errorf("marshal dict failed: %v", err)
	}
	jsonString := string(jsonData)

	// 使用 dictType 作为 key，存储到 Redis
	key := "sys_dict:" + dict.DictType
	err = dictStore.Set(key, jsonString)
	if err != nil {
		return fmt.Errorf("save to redis failed: %v", err)
	}

	return err
}

// InitDict 初始化字典数据
func InitDict() error {

	err := DictService{}.RefreshCache()
	if err != nil {
		return err
	}
	return nil
}
