#include <iostream>
#include <string>
#include <sstream>
#include <fstream>
#include <memory.h>
#include<cstdlib>
using namespace std;

static void hex_to_str(char *ptr,unsigned char *buf,int len)
{
    for(int i = 0; i < len; i++)
    {
        sprintf(ptr, "%02x",buf[i]);
        ptr += 2;
    }
}

int main(){
	FILE* fp;
	string head="memory_initialization_radix=16;\nmemory_initialization_vector=\n00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\n00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\n";
	string line;
	int h,l;
	char ch,cl;
    char buffer[100];
    char s[3]="";
    int i,j;

    ifstream in("E:\\CppWorkspace\\PAT\\a.txt");
    if (! in.is_open())
    { cout << "Error opening file"; exit (1); }

    ofstream out("E:\\CppWorkspace\\PAT\\a.coe");
    if (out.is_open())
    {
        out << head;
    }

	for(i=0;i<32;i++)
	{
		out << "00,00,00,00,52,45,47,";
		h=i/10+48;
		l=i%10+48;
	//	ch=h/16+48;
	//	cl=h%16+48;
		sprintf(s, "%02X", h);
		out << s;
		out << ',';
		sprintf(s, "%02X", l);
		out << s;
		out << ',';
//		out << ch ;
//		out << cl ;
//		out << ',';
//		ch=l/16+48;
//		cl=l%16+48;
//		out << ch ;
//		out << cl ;
//		out << ',';

		for(j=0;j<21;j++)
		{
			out << "00," ;
		}

		memset(buffer,0,100);
		if(in.getline (buffer,100))
		{
			j=0;
			while(buffer[j]!=0)
			{
				int temp= buffer[j];
				sprintf(s, "%02X", temp);
				out << s ;
				out << "," ;
				j++;
			}
	        for(;j<50;j++)
			{
				out << "00," ;
			}
			out << "\n" ;
		}
		else
		{
		    for(j=0;j<50;j++)
			{
				out << "00," ;
			}
			out << "\n" ;
		}
	}
}

