# Oplus_NandSwap_Tools

**License**：GPL-3.0  
**Version**：1.0  

---  

### 项目简介  
专为 ColorOS 定制的轻量级 Shell 脚本工具，通过动态配置 **zram** 实现第三方内存扩展，提升多任务处理能力。  

### 功能特性  
- **动态内存扩展**：支持 4GB/6GB/8GB/12GB/16GB zram 配置  
- **条件触发**：需 `persist.sys.oplus.nandswap=true` 启用  
- **状态反馈**：通过系统属性返回错误码（`err`）和运行状态（`condition`）  
- **轻量化**：精简自 ColorOS 原生机制，低资源占用  

### 使用说明  
1. **启用**：  
   ```bash
   su
   setprop persist.sys.oplus.nandswap true
   oplus_nandSwap_tools.sh
   ```  
2. **配置**：修改脚本内 `ZRAM_SIZE_GB` 调整大小。  

### 错误码  
| 错误码 | 原因           | 解决方案          |  
|--------|----------------|-------------------|  
| 1      | zram 未加载    | 检查内核支持      |  
| 2      | 内存分配失败   | 减小 ZRAM_SIZE    |  

### 许可证与贡献  
- ## License
   本项目采用 **GNU GPLv3**.  
   有关完整条款，参阅[LICENSE](LICENSE)
- **反馈**：提交 GitHub Issue 或邮件至 `huanying1194139625@gmail.com`  
