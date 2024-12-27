package sys_service

import (
	"encoding/json"
	"fmt"
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/redis/dict_redis"
	"time"
)

var dictStore = dict_redis.DictStore{
	Client: variable.Redis,
}

type DictCurd struct {
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
func (d DictCurd) GetDictList(req sys_model.DictListRequest) (list []sys_model.SysDictType, total int64, err error) {

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

		fmt.Println("err", start, end)

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

// RefreshCache 获取所有字典及其数据
func (d DictCurd) RefreshCache() (err error) {
	var result []sys_model.SysDictRedis
	err = variable.GormDbMysql.Model(&sys_model.SysDictRedis{}).
		Preload("Child", "status = ?", "0").
		Find(&result).Error
	_, err = dictStore.DeleteByPrefixBatch("sys_dict", 100)
	if err != nil {

	}
	for _, dict := range result {
		// 将每个字典类型转换为 JSON
		jsonData, err := json.Marshal(dict.Child)
		if err != nil {
			//return fmt.Errorf("marshal dict failed: %v", err)
		}
		jsonString := string(jsonData)

		// 使用 dictType 作为 key，存储到 Redis
		key := "sys_dict:" + dict.DictType
		err = dictStore.Set(key, jsonString)
		if err != nil {
			//return fmt.Errorf("save to redis failed: %v", err)
		}
	}
	return err
}

// InitDict 初始化字典数据
func InitDict() error {

	err := DictCurd{}.RefreshCache()
	if err != nil {
		return err
	}
	return nil
}
