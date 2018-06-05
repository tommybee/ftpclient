# https://www.codeproject.com/Articles/8667/FTP-Client-Class
HOME=C:/DEV/COMP/msys32/home/win_lib/FtpClient

FTP_CLINET_DLL = ftpcli.dll
FTP_CLINET_TEST = ftpcli_test.exe

ECHO=echo 
SHARED=-shared

CXX=i686-w64-mingw32-g++
CC=i686-w64-mingw32-gcc
PEXPORTS=pexports
RM=rm
DLLTOOL=dlltool

CFLAGS = -O3 -static -pthread \
    -Wl,--whole-archive -lpthread -Wl,--no-whole-archive
 
CXXFLAGS= -static -pthread -D_WINSOCK2API_

LIBS = -L.
	
FILE_CXXFLAGS = -I.

FILE_CXXLIBS = $(LIBS) 

STATIC_GCC=-static-libstdc++ -static-libgcc

FCLI_CXXLINKING = $(FILE_CXXLIBS) -LC:/DEV/COMP/msys32/mingw32/lib -lws2_32 -lz $(STATIC_GCC)

all: ftpcli

ftpcli:
	$(CXX) $(CXXFLAGS) $(SHARED) -o $(FTP_CLINET_DLL) FTPClient.cpp BlockingSocket.cpp FTPDataTypes.cpp FTPFileStatus.cpp FTPListParse.cpp $(FILE_CXXFLAGS) $(FCLI_CXXLINKING) 
	$(PEXPORTS) -o $(HOME)/$@.dll > $(HOME)/$@.def
#	$(RM) $(HOME)/lib/lib$@.a
	$(DLLTOOL) --def $(HOME)/$@.def --dllname $(HOME)/$@.dll   --output-lib $(HOME)/lib$@.a


	
clean:
	$(RM) *.dll