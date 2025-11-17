# ProjectSpringMVC
spring mvc don't need internet

Yêu cầu
JAVA JDK 17+
Tomcat 10+

✅ HƯỚNG DẪN CHẠY DỰ ÁN SPRING MVC (KHÔNG MAVEN) – BẢN HIỆN TẠI
👉 JDK 17, Tomcat 9

1. Cài JDK 17
Bước 1: Tải JDK
Vào 1 trong 2 trang (chọn bản 17):


Oracle: https://www.oracle.com/java/technologies/downloads/


Adoptium: https://adoptium.net/


Tải installer (đuôi .msi / .exe) hoặc file zip.
Ví dụ cài xong sẽ nằm ở:
C:\Program Files\Java\jdk-17.0.0.1

Bước 2: Thiết lập biến môi trường
Mở Edit the system environment variables → Environment Variables…
Ở System variables (khung dưới):


JAVA_HOME


New…


Name: JAVA_HOME


Value: C:\Program Files\Java\jdk-17.0.0.1




JRE_HOME (tuỳ chọn nhưng nên có)


Name: JRE_HOME


Value: C:\Program Files\Java\jdk-17.0.0.1




PATH


Chọn Path → Edit…


New 1 dòng:
%JAVA_HOME%\bin



Move Up cho dòng này lên tương đối cao.




Bấm OK hết tất cả cửa sổ.
Bước 3: Kiểm tra
Mở CMD mới (không dùng cửa sổ cũ):
java -version
javac -version

Nếu hiện Java 17 (không báo lỗi) → OK.

2. Cài Tomcat 9
Bước 1: Tải Tomcat
Vào:
https://tomcat.apache.org/download-90.cgi
Ở mục Core → Binary Distributions chọn:
32-bit/64-bit Windows zip

(hoặc 64-bit Windows zip nếu có).
Bước 2: Giải nén
Giải nén, ví dụ:
D:\apache-tomcat-9.0.112

Gọi thư mục này là:
<TOMCAT9_HOME>

Bước 3: Test Tomcat
Mở CMD:
cd <TOMCAT9_HOME>\bin
startup.bat

Mở trình duyệt:
http://localhost:8080

Thấy trang chào mừng Tomcat 9 → OK.
Tắt Tomcat:
cd <TOMCAT9_HOME>\bin
shutdown.bat


3. Cài Git
Tải tại: https://git-scm.com/download/win
Cài đặt mặc định (Next → Next → Finish).

4. Clone project từ GitHub (nhánh TheFirst)
Mở CMD / PowerShell ở thư mục muốn chứa code, chạy:
git clone https://github.com/levandaicntt/ProjectSpringMVC.git
cd ProjectSpringMVC
git checkout TheFirst

Thư mục này gọi là:
<PROJECT_ROOT>


5. Mở dự án bằng VS Code


Cài VS Code: https://code.visualstudio.com/


Trong VS Code → Extensions → cài:


Extension Pack for Java




File → Open Folder…
Chọn thư mục <PROJECT_ROOT> (ProjectSpringMVC).


Trong repo đã có sẵn .vscode/settings.json nên:


Source: src


Output .class: WebContent/WEB-INF/classes


Lib: WebContent/WEB-INF/lib/*.jar


→ Không cần cấu hình thêm.

6. Sửa file run.bat (Tomcat 9 + JDK 17)
Trong <PROJECT_ROOT> mở run.bat (hoặc run-tomcat9.bat nếu bạn tách file).
Chỉnh 3 biến ở đầu file:
set PROJECT_DIR=<đường_dẫn_tới_ProjectSpringMVC>
set TOMCAT_DIR=<đường_dẫn_tới_Tomcat9>
set WEBAPP_NAME=ProjectSpringMVC

Ví dụ trên máy bạn:
set PROJECT_DIR=D:\ProjectSpringMVC
set TOMCAT_DIR=D:\apache-tomcat-9.0.112
set WEBAPP_NAME=ProjectSpringMVC


Chỉ cần sửa cho đúng đường dẫn thư mục thật trên máy.


7. Chạy dự án


Đảm bảo Tomcat đang tắt (nếu đang chạy thì shutdown.bat trước).


Vào <PROJECT_ROOT> trong Explorer, double-click:
run.bat



Script sẽ:


Biên dịch toàn bộ Java trong src bằng JDK 17;


Copy WebContent vào:
<TOMCAT_DIR>\webapps\ProjectSpringMVC\



Khởi động lại Tomcat 9.


Khi cửa sổ run.bat báo xong, mở trình duyệt:
http://localhost:8080/ProjectSpringMVC/

Nếu thấy trang home hiện lên → bạn đã chạy thành công dự án Spring MVC với JDK 17 + Tomcat 9.



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