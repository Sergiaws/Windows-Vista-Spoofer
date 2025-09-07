# Windows Vista Spoofer
This repository countains a script that will guide you through application spoofing on Windows Vista with Extended Kernel, so your programs will think that they are running on another version of Windows.
## How to use?
The usage is very simple. Firstly, you require a Windows Vista x64 system (obviously) and the Extended Kernel installed with the necesary updates.
<br>
<br>
If you want to run directly the source code you need to download AutoIt (latest version still works under Windows Vista) and then you can compile the source code yourself.
<br>
<br>
You will need to put the compiled version in your Windows directory, cause the osver.ini file is in the Windows folder. Then you can run the script. In the first prompt you just need to put the path of your application, but if the path is in the system path you just need the name of the application.
<br>
<br>
As an example, if you want to spoof the cmd.exe, you can put cmd instead of putting c:\Windows\System32\cmd.exe
<br>
<br>
Then, you need to choose the Windows that you want to spoof, I decided to put all versions, starting with Windows 2000 and ending with Windows 11. Then you can decide if you want to change the build nummber. I also included the extra strings such as Win7SuperVerFix=1 for people who may be using an older release of the extended Kernel.
