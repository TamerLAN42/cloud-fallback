## Terraform  
Это конфиги для гибкой настройки виртуальной машины через terraform с провайдером Yandex Cloud  
p.s. документация модулей терраформа сделана лучше основной документации проекта потому-что мне лень было изобретать велосипед, и я украл большую часть конфигов из своего учебного проекта.
### Быстрый старт  
```bash
git clone https://github.com/TamerLAN42/cloud-fallback.git
cd cloud-fallback/backup-host/terraform/workspace
terraform init
terraform apply
```

Перед использованием не забудьте указать:
- Путь к .json авторизованного ключа в переменную окружения `YC_SERVICE_ACCOUNT_KEY_FILE` или IAM-токен в `YC_TOKEN`.  
- ID облака и фолдера в переменные окружения `TF_VAR_cloud_id` и `TF_VAR_folder_id` соответственно, либо указать их в файле terraform.tfvars.

### Настраиваемые параметры  
Настройку можно осуществлять через файл terraform.tfvars или через переменные окружения.

| Параметр | Описание | Тип | По умолчанию |
|----------|----------|-----|--------------|
| instance_name | Имя ВМ | string | "phoenix-vm" |
| instance_zone | Зона доступности | string | "ru-central1-a" |
| platform_id | Тип процессора | string | "standard-v3" |
| scheduling_preemptible | Прерываемая ВМ | bool | true |
| disk_size | Размер диска в ГБ | number | 30 |
| nat | Необходимость внешнего IP | bool | true |
| image_id | Образ для ВМ | string | fd80qm01ah03dkqb14lc |
