/******************************************************************


*   file:     cmds.c
*   author:   betty o'neil
*   date:     ?
*
*   semantic actions for commands called by tutor (cs341, mp1)
*
*   revisions:
*      9/90  eb   cleanup, convert function declarations to ansi
*      9/91  eb   changes so that this can be used for hw1
*      9/02  re   minor changes to quit command
*/
/* the Makefile arranges that #include <..> searches in the right
   places for these headers-- 200920*/

#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
#include "slex.h"

/*===================================================================*
*
*   Command table for tutor program -- an array of structures of type
*   cmd -- for each command provide the token, the function to call when
*   that token is found, and the help message.
*
*   slex.h contains the typdef for struct cmd, and declares the
*   cmds array as extern to all the other parts of the program.
*   Code in slex.c parses user input command line and calls the
*   requested semantic action, passing a pointer to the cmd struct
*   and any arguments the user may have entered.
*
*===================================================================*/

PROTOTYPE int stop(Cmd *cp, char *arguments);
PROTOTYPE int mem_display(Cmd *cp, char *arguments);
PROTOTYPE int memory_set(Cmd *cp, char *arguments);
PROTOTYPE int help(Cmd *cp, char *arguments);

/* command table */

Cmd cmds[] = {{"md",  mem_display, "Memory display: MD <addr>"},
              {"s",   stop,        "Stop" },
              {"h", help,      "Help: h <cmd>"},
              {"ms", memory_set, "Memory set: MS <hex_addr> <new_val>"},
              {NULL,  NULL,        NULL}};  /* null cmd to flag end of table */

char xyz = 6;  /* test global variable  */
char *pxyz = &xyz;  /* test pointer to xyz */
/*===================================================================*
*		command			routines
*
*   Each command routine is called with 2 args, the remaining
*   part of the line to parse and a pointer to the struct cmd for this
*   command. Each returns 0 for continue or 1 for all-done.
*
*===================================================================*/

int stop(Cmd *cp, char *arguments)
{
  return 1;			/* all done flag */
}

/*===================================================================*
*
*   mem_display: display contents of 16 bytes in hex
*
*/

int mem_display(Cmd *cp, char *arguments)
{
  //pointers
  //treat address as hexidecimal number
    unsigned int hex_address = 0;
   // hex_digits = malloc(17 * sizeof(int));
   // char name[12] = "Paul" ;
   // printf("%p", name);
   //we only want to move one bit char*  
    unsigned char* hex_add_ptr;
    sscanf(arguments, "%x", &hex_address);
    hex_add_ptr =(unsigned char*)hex_address;
 //   printf("%x\n", *hex_add_ptr);
  //  printf("%x", hex_address);
 // printf("%p", hex_digits_add);
 // printf("%x", hex_digits);
    for(int i = 0; i < 16; i++){
        printf("%02x ", *(hex_add_ptr + i));
    }
    printf("\n");
    for(char i = 0; i<16; i++){
	if(*(hex_add_ptr + i) > 0x20){
	   if(*(hex_add_ptr + i) < 0x7E){
		printf("%c ",(char) *(hex_add_ptr + i));
           }
       }
       else {
            printf(" . ");
      }
    }
   //  printf("Reached mem_display, passed argument string: |%s|\n", arguments);
  //
//  printf("        help message: %s\n", cp->help);
    printf("\n");
    return 0;	
		/* not done */
}

int memory_set(Cmd *cp, char* arguments){
    unsigned int hex_content = 0;
    unsigned int value = 0;
   //we only want to move 1 byte so char*
    unsigned char* hex_content_ptr;
   // sscanf(arguments, "%d %d", & hex_content, &value):
    sscanf(arguments, "%x %x", &hex_content, &value);
    hex_content_ptr = (unsigned char*) hex_content;
    *(hex_content_ptr) =(int) value;
    return 0;

}

int help(Cmd *cp, char* arguments){
   // char* commands;
   //  commands = malloc(3 * sizeof(char));
   // sscanf(arguments, "%s", commands);
   // printf("%s", commands);    
   //be sure to change the number of commands
   //if we are going to add more to this
   //  int num_of_cmds = 4;
   // while(num_of_cmds >= 0){
   //	num_of_cmds--;
   //	//where is my struct?
   //	if((strcmp(cmds[num_of_cmds].cmdtoken, arguments)) == 0){
   //	  printf("%s", cmds[num_of_cmds].help);
   //	  break;
   
   if(strcmp(" ms", arguments) == 0) printf("Memory Set: ms <addrs> <val>\n");     if(strcmp(" md", arguments) == 0) printf("Memory Display: md <addrs>\n");
   if(strcmp("", arguments) == 0) printf("Memory Display: md <addrs>\nMemory Set: <addrs> <val>\ns: Stop\nHelp: h <cmd>\n");
   if(strcmp(" s", arguments) == 0) printf("Stop\n");

      return 0;

}
