# Kubernetes Module

Create 2 EC2 with Kubernetes installed

## Varaibles

| Name | Description |
| --- | --- |
| name | 建立的 instance 名稱與 tag 名稱 |
| ami | 指定要採用的 AMI 目前只測試過 ami-0705fe1e9a50e0d57 (RHEL 9) 與 ami-0ba8d27d35e9915fb (Ubuntu 24.04) |
| os_version | 指定作業系統版本，以便腳本識別要採用哪個，目前只支援 rhel9 與 ubuntu2404，此參數要與上述 AMI 對應 |
| instance_type | EC2 instance type |
| ssh_public_key | 使用者 public key 方便後續登入系統使用 |
| region | 指定地區 |
| counts | 指定 instance 數量 |
