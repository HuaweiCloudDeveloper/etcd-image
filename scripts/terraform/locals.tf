locals {
  // you need to specify a unique name under a tenant according to the business, which will be used as part of the resource name
  app_id = format("%s-%s", "app", formatdate("hhmm", timestamp()))

  name_suffix = "mkp"

  // Tags of HUAWEI CLOUD resources. You can add tags to resources to classify resources.
  // for more details, please refer to https://support.huaweicloud.com/usermanual-tms/zh-cn_topic_0056266263.html
  tags = { Purpose = "MkpApplication" }



  # Configuration of the ECS memory size and number of cores
  # instance_flavor_cpu    = 4
  # instance_flavor_memory = 16
  #  通用计算增强型
  instance_performance_type = "kunpeng_computing"
  # 系统盘: 通用SSD
  ecs_volume_type = "GPSSD"

  # 规格：通用入门型
  #ecs_flavor = "kc1.xlarge.4"

  // Billing model for cloud resources, You need to modify it according to your actual situation.
  // In the development and testing phase, pay-per-use billing is recommended.
  // You can also set these three parameters as variables, allowing users to select at deployment time.
  charging_mode = var.charging_mode
  period_unit   = var.period_unit
  period        = var.period

  // The billing model for bandwidth, You need to modify it according to your actual situation.
  publicip_type         = "5_bgp"     # 全动态
  bandwidth_share_type  = "PER"       # 独享带宽
  bandwidth_charge_mode = "bandwidth" # 按带宽计费
  bandwidth_size        = 10          # 带宽大小

  # Image information in different regions, you need to enter your own image ID or add another region.
  # For Marketplace Image Id,you can log in to Seller Console, view the marketplace image id on Product Specifications section of My Products detail page.
  # 镜像版本：
  #etcd3.6.0-HCE2.0
  instance_image_id_maps_v1 = {
#     北京4
    cn-north-4     = "ba540f39-f19d-40ff-9cab-438fc3cad053"
#     广州
    cn-south-1     = "4ec1d58b-f1c4-4af6-966f-e0b48fcd1d55"
#     上海一
    cn-east-3      = "f2755f36-0aab-47b5-b285-18cd1810707a"
#     乌兰察布一
    cn-north-9     = "1a9250dd-8bbd-4068-8847-e4c33823a018"
#     贵阳一
    cn-southwest-2 = "c1e88198-08dd-4f9f-b0a4-488ad3a2c3a5"

  }
  #etcd3.6.0-Ubuntu24.04
  instance_image_id_maps_v2 = {
#     北京4
    cn-north-4     = "70c6462a-b25a-4aed-a221-1f6b1352434e"
#     广州
    cn-south-1     = "5763fe20-ed03-41eb-8442-fab0b7db7e8b"
#     上海一
    cn-east-3      = "7d5c967b-16e1-408b-b9f6-a554b5869f39"
#     乌兰察布一
    cn-north-9     = "bc16ed74-3174-4b4d-8ec1-6b28b4104405"
#     贵阳一
    cn-southwest-2 = "2907f29d-c16d-471d-b6e3-0f53c3527f2b"

  }  
  # # 其他版本增加（注意修改var参数和镜像的版本的判断部分）
  #  instance_image_id_maps = {
  #   #     北京4
  #   cn-north-4 = ""
  #  }  

  # Specifies the DNS server address list of a subnet. For details about the private DNS address, see https://support.huaweicloud.com/dns_faq/dns_faq_002.html#?
  subnet_dns_list_maps = {
    cn-north-4     = ["100.125.1.250", "100.125.129.250"]
    cn-south-1     = ["100.125.1.250", "100.125.136.29"]
    cn-east-3      = ["100.125.1.250", "100.125.64.250"]
    cn-north-9     = ["100.125.1.250", "100.125.107.250"]
    cn-southwest-2 = ["100.125.1.250", "100.125.129.250"]
  }


}