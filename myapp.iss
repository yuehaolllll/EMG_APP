; 脚本名称: EMG_Vision 企业级安装脚本
; 兼容性: Windows 10/11 x64

#define MyAppName "EMG_Vision"
#define MyAppVersion "1.1.0"
#define MyAppPublisher "EMG Analyser"
#define MyAppURL "https://www.emg-tech.com"
#define MyAppExeName "EMG_Vision.exe"

; 定义源文件路径 (请根据实际情况修改)
#define SourceFolder "F:\ESP32\Prj\EMG_APP\dist\EMG_Vision"
#define IconFilePath "F:\ESP32\Prj\EMG_APP\icons\logo.ico"
#define OutputFolder "F:\ESP32\Prj\EMG_APP\Output"

[Setup]
; --- 核心标识 ---
; AppId 是唯一的 GUID，用于识别程序以便升级。
; 可以在 Inno Setup 菜单 Tools -> Generate GUID 生成一个新的替换下面这个
AppId={{ED685582-923A-4B9F-AD47-9F911A2FB4DB}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}

; --- 安装目录设置 ---
; {autopf} 自动指向 Program Files (x86) 或 Program Files
DefaultDirName={autopf}\{#MyAppName}
; 禁止用户选择不能写入的根目录
DisableDirPage=no
; 默认组名
DefaultGroupName={#MyAppName}

; --- 界面与视觉 ---
; 使用现代样式
WizardStyle=modern
; 安装包图标 (Setup.exe 的图标)
SetupIconFile={#IconFilePath}
; 卸载程序图标
UninstallDisplayIcon={app}\{#MyAppExeName}
; 压缩算法 (LZMA2 Ultra64 提供极高压缩率)
Compression=lzma2/ultra64
SolidCompression=yes

; --- 系统架构与权限 ---
; 这是一个 64 位 Python 程序
ArchitecturesInstallIn64BitMode=x64
; 需要管理员权限才能写入 Program Files
PrivilegesRequired=admin

; --- 输出设置 ---
OutputDir={#OutputFolder}
OutputBaseFilename=WanFan_BioSignal_Setup_v{#MyAppVersion}

; --- 版本信息 (右键属性可见) ---
VersionInfoCompany={#MyAppPublisher}
VersionInfoVersion={#MyAppVersion}
VersionInfoDescription=EMG Acquisition and Analysis Software
VersionInfoCopyright=Copyright (C) 2025 WanFan Technology

[Languages]
; 包含英文和简体中文 (如果 Inno Setup 安装完整，应该有 ChineseSimplified.isl)
Name: "english"; MessagesFile: "compiler:Default.isl"
; 如果你的 Inno Setup 没有中文语言包，请注释掉下面这行，否则会报错
//Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"

[Tasks]
; 允许用户勾选创建桌面图标
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; --- 核心文件 ---
; 复制 dist 目录下的所有文件和子文件夹
; Flags: ignoreversion (升级时不检查版本号，直接覆盖)
; recursesubdirs (递归子目录)
; createallsubdirs (创建所有子目录结构)
Source: "{#SourceFolder}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
; --- 开始菜单图标 ---
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
; 卸载图标
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
; --- 桌面图标 ---
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
; --- 安装完成后运行 ---
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
// 这里可以添加 Pascal 脚本进行高级操作
// 例如：检查是否已经安装，或者清理旧的配置文件
// 目前保持为空即可