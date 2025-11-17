# ProjectSpringMVC
spring mvc don't need internet

✅ HƯỚNG DẪN CHẠY DỰ ÁN SPRING MVC (KHÔNG MAVEN) – DÀNH CHO NGƯỜI MỚI
1. Cài JDK
Bước 1: Tải JDK

Vào trang:

https://jdk.java.net

Chọn file:

jdk-xx_windows-x64_bin.zip

(tuỳ phiên bản, 17 hoặc 22 đều được)

Giải nén vào một thư mục dễ nhớ, ví dụ:

C:\Java\jdk-22

Bước 2: Thiết lập biến môi trường

Mở Edit the system environment variables → nút Environment Variables…

Trong phần System variables hoặc User variables, tạo:

JAVA_HOME = C:\Java\jdk-22
JRE_HOME  = C:\Java\jdk-22
PATH     += %JAVA_HOME%\bin


(Trong Path: Edit → New → nhập %JAVA_HOME%\bin)

Bước 3: Kiểm tra

Mở CMD mới:

java -version
javac -version


Nếu hiện version (không báo lỗi) → OK.

2. Cài Tomcat 10
Bước 1: Tải Tomcat

Vào:

https://tomcat.apache.org/download-10.cgi

Ở phần Core → Binary Distributions, tải:

apache-tomcat-10.x.x-windows-x64.zip

Bước 2: Giải nén

Giải nén vào một thư mục, ví dụ:

D:\Tomcat\apache-tomcat-10.1.46


Gọi thư mục này là:

<TOMCAT_HOME>

Bước 3: Test Tomcat

Mở PowerShell/CMD:

cd <TOMCAT_HOME>\bin
.\startup.bat


Mở trình duyệt:

http://localhost:8080


Nếu thấy trang chào mừng Tomcat → cài xong.

Muốn tắt Tomcat:

cd <TOMCAT_HOME>\bin
.\shutdown.bat

3. Cài Git

Tải tại:

https://git-scm.com/download/win

Cài đặt mặc định (Next → Next → Finish).

4. Clone project từ GitHub (nhánh TheFirst)

Mở CMD / PowerShell ở thư mục bạn muốn chứa code, chạy:

git clone https://github.com/levandaicntt/ProjectSpringMVC.git
cd ProjectSpringMVC
git checkout TheFirst


Thư mục ProjectSpringMVC chính là <PROJECT_ROOT>.

5. Mở dự án bằng VS Code (khuyến khích)
Bước 1: Cài VS Code

https://code.visualstudio.com/

Bước 2: Cài Extension Pack for Java

Trong VS Code → Extensions → tìm và cài:

Extension Pack for Java

Bước 3: Mở project

File → Open Folder…

Chọn thư mục: ProjectSpringMVC vừa clone.

Repo đã có sẵn cấu hình .vscode/settings.json, VS Code sẽ tự nhận:

Source: src

Output .class: WebContent/WEB-INF/classes

Thư viện: WebContent/WEB-INF/lib/...

Người dùng không cần cấu hình thêm.

6. Chỉnh file run.bat (chỉ 1 lần)

Trong thư mục ProjectSpringMVC, mở file:

run.bat


Ở đầu file, sửa 3 dòng này cho đúng máy:

set PROJECT_DIR=<đường_dẫn_tới_ProjectSpringMVC>
set TOMCAT_DIR=<đường_dẫn_tới_Tomcat_10>
set WEBAPP_NAME=ProjectSpringMVC


Ví dụ:

set PROJECT_DIR=D:\Code\ProjectSpringMVC
set TOMCAT_DIR=D:\Tomcat\apache-tomcat-10.1.46
set WEBAPP_NAME=ProjectSpringMVC


PROJECT_DIR: đường dẫn tới thư mục bạn đã clone (ProjectSpringMVC).

TOMCAT_DIR: thư mục gốc Tomcat (chứa bin, webapps, …).

WEBAPP_NAME: tên app sẽ deploy trên Tomcat (dùng luôn ProjectSpringMVC).

Lưu file lại.

7. Chạy dự án
Cách chạy nhanh: double-click run.bat

Đảm bảo Tomcat đang tắt (nếu đang chạy, dùng shutdown.bat).

Trong Explorer, vào thư mục ProjectSpringMVC, double-click:

run.bat


Script sẽ tự động:

Biên dịch code Java.

Copy nội dung web vào:

<TOMCAT_DIR>\webapps\ProjectSpringMVC\


Restart Tomcat.

Khi cửa sổ run.bat báo xong, mở trình duyệt:

http://localhost:8080/ProjectSpringMVC/


Nếu thấy trang web lên (trang home) → chạy thành công.


1️⃣ .vscode/settings.json – để VS Code hiểu project & tự compile
Giải thích từng dòng

"java.project.sourcePaths": ["src"]
👉 Nói với VS Code: “code Java của tao nằm trong thư mục src đó”
→ Nhờ vậy file src/com/demo/controller/HomeController.java mới được coi là source, không bị lỗi package.

"java.project.outputPath": "WebContent/WEB-INF/classes"
👉 Nơi VS Code sẽ đặt các file .class sau khi compile.
→ Khớp với cấu trúc WAR chuẩn: WEB-INF/classes/... để Tomcat load.

"java.project.referencedLibraries": ["WebContent/WEB-INF/lib/**/*.jar"]
👉 Cho VS Code biết: “tất cả .jar trong WEB-INF/lib là thư viện (Spring, Jakarta, MySQL, Micrometer, Jackson, ...)”
→ Import org.springframework... không còn đỏ.

"java.autobuild.enabled": true
👉 Bật auto build: mỗi lần bạn Ctrl+S file .java, VS Code tự compile lại .class.

"java.configuration.updateBuildConfiguration": "automatic"
👉 Cho Java extension tự đọc lại cấu hình (sourcePaths, libs) khi bạn sửa settings, tránh phải chỉnh tay.

Sau khi sửa settings.json, nhớ:
Ctrl+Shift+P → Java: Clean Java Language Server Workspace → VS Code reload 1 lần.

2️⃣ run.bat – file “1 cú click: compile + copy + start Tomcat”
Giải thích các phần trong run.bat

set PROJECT_DIR=...
👉 Nơi chứa project Spring MVC (src, WebContent).

set TOMCAT_DIR=...
👉 Thư mục gốc Tomcat (nơi có bin, webapps, conf...).

set WEBAPP_NAME=ProjectSpringMVC
👉 Tên thư mục webapp trong webapps.
→ URL sẽ là http://localhost:8080/ProjectSpringMVC/.

Khối javac ...
👉 Compile Java:

-cp "WebContent\WEB-INF\lib\*;.": dùng toàn bộ jar làm classpath.

-d WebContent\WEB-INF\classes: xuất .class vào đúng chỗ Tomcat cần.

src\com\demo\controller\HomeController.java: file cần compile (sau này muốn compile hết thì dùng src\com\demo\**\*.java nếu cần).

Khối xcopy WebContent ...
👉 Xoá webapp cũ → copy nguyên WebContent (có WEB-INF/lib, WEB-INF/classes, JSP, …) vào webapps/ProjectSpringMVC.

Khối shutdown.bat + startup.bat
👉 Dừng Tomcat cũ (nếu đang chạy) rồi start lại, để load jar và class mới.

3️⃣ Tự cài PATH / JAVA_HOME / JRE_HOME vĩnh viễn trên máy
Để khỏi gõ $Env:JAVA_HOME = ... nữa, làm 1 lần:

Bước 1 – Mở cửa sổ Environment Variables

- Bấm Start → gõ: Environment Variables

- Chọn: “Edit the system environment variables”

- Trong cửa sổ mới → bấm nút Environment Variables…

Bước 2 – Tạo JAVA_HOME

- Ở User variables (cho user hiện tại) hoặc System variables (cho toàn máy): → Bấm New…

- Variable name: JAVA_HOME

- Variable value: C:\Program Files\Java\jdk-xx (xx là phiên bản của jdk, của tôi là jdk-22)

- Bấm OK

Bước 3 – Tạo JRE_HOME (Tomcat rất thích cái này)

- Bấm New… → tiếp

- Variable name: JRE_HOME

- Variable value: C:\Program Files\Java\jdk-xx

- Bấm OK

* Nhớ: KHÔNG thêm \bin vào JAVA_HOME / JRE_HOME.

Bước 4 – Thêm JDK vào PATH (nếu chưa có)

- Trong cùng cửa sổ:

- Ở User variables, chọn biến Path → Edit… → Bấm New

- Thêm dòng: %JAVA_HOME%\bin

- OK hết để lưu.

Bước 5 – Kiểm tra

- Mở CMD mới (bắt buộc phải mở cửa sổ mới):

echo %JAVA_HOME%
echo %JRE_HOME%
java -version
javac -version


- Nếu in ra: C:\Program Files\Java\jdk-22

thông tin Java/Javac đúng version

→ Xong. Sau này bạn chỉ cần:

cd D:\apache-tomcat-10.1.46-windows-x64\apache-tomcat-10.1.46\bin
.\startup.bat


không cần set $Env:JAVA_HOME nữa.