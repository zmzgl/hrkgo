package sys_service

import (
	"encoding/json"
	"hrkGo/app/model/sys_model"
	"hrkGo/utils/global/variable"
	"hrkGo/utils/redis/dict_redis"
)

var dictStore = dict_redis.DictStore{
	Client: variable.Redis,
}

type DictCurd struct {
}

// 定义返回结果的结构体
type DictWithData struct {
	DictId    int64                   `json:"dictId"`    // 字典主键
	DictName  string                  `json:"dictName"`  // 字典名称
	DictType  string                  `json:"dictType"`  // 字典类型
	Status    string                  `json:"status"`    // 状态
	Remark    string                  `json:"remark"`    // 备注
	DictDatas []sys_model.SysDictData `json:"dictDatas"` // 字典数据列表
}

// GetAllDictWithData 获取所有字典及其数据
func (d DictCurd) GetAllDictWithData() (err error) {
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

	err := DictCurd{}.GetAllDictWithData()
	if err != nil {
		return err
	}
	return nil
}
