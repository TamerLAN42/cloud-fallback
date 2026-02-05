# Terraform модуль для создания ВМ в Yandex Cloud
Здесь описано непосредственное создание ВМ с указанными параметрами.

## Зависимости
- Terraform >= 1.5
- Провайдер Yandex Cloud >= 0.87.0

## Провайдер
`yandex-cloud/yandex` — для работы с ресурсами Yandex Cloud

## Настраиваемые параметры
Все переменные определяются (или переназначаются) в основном модуле. Подробнее про методы настройки в [../../../README.md](../../../README.md)

| Параметр | Описание | Тип | По умолчанию |
|----------|----------|-----|--------------|
| `instance_name` | Имя ВМ | string | `"phoenix_vm"` |
| `instance_zone` | Зона доступности | string | `"ru-central1-a"` |
| `platform_id` | Тип процессора | string | `"standard-v3"` |
| `scheduling_preemptible` | Прерываемая ВМ | bool | `true` |
| `disk_size` | Размер диска в ГБ | number | `30` |
| `nat` | Необходимость внешнего IP | bool | `true` |
| `subnet_id` | ID подсети ВМ | string | Определяется автом. на основе `instance_zone` |


## Выходные значения (outputs)
- `internal_ip_address` — внутренний IP-адрес ВМ
- `external_ip_address` — внешний IP-адрес (если включен NAT)