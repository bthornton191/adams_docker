
-------------------------------------------------------------------------------
|                                                                             |
|                  ,                                                          |
|               ***,                    Hexagon                               |
|          ((((((,,,                    -------                               |
|      (((((((((,,,,            *                                             |
|      *((((((,,,,,,          **(                                             |
|      **((((,,,,,,,     ******((       A d a m s   C++   S o l v e r         |
|      ****,,,,,,,,, ********((((       Build:   2022.1.0-CL875404            |
|      ***  ,,,,,(((********(((((       Version: Adams 2022.1                 |
|      *.   **((((((******(((((((                                             |
|      ********(((((*****((((((((                                             |
|               ,,,,   .,,,,,,,                                               |
|                 ,,  ,,,,              http://www.mscsoftware.com            |
|                  , ,                                                        |
|                   ,                                                         |
|                                                                             |
|    *********************************************************************    |
|    *                                                                   *    |
|    *              Hexagon Manufacturing Intelligence, Inc.             *    |
|    *                                                                   *    |
|    *                             A d a m s                             *    |
|    *                                                                   *    |
|    *          Automatic Dynamic Analysis of Mechanical Systems         *    |
|    *                                                                   *    |
|    *********************************************************************    |
|    *                                                                   *    |
|    *                         LEGAL INFORMATION                         *    |
|    *                                                                   *    |
|    *  Warning:  This computer  program is protected  by copyright law  *    |
|    *  and  international  treaties.    Unauthorized  reproduction  or  *    |
|    *  distribution  of this  computer program, or any  portion of it,  *    |
|    *  may result in severe civil and criminal penalties.               *    |
|    *                                                                   *    |
|    *  Copyright (C) 2022 Hexagon AB and/or its subsidiaries.           *    |
|    *                        All rights reserved.                       *    |
|    *                                                                   *    |
|    *********************************************************************    |
|                                                                             |
|-----------------------------------------------------------------------------|
|                                                                             |
|    *********************************************************************    |
|    *                                                                   *    |
|    *   Local Time: 2023-07-28 13:58:56                                 *    |
|    *    Host Name: d634eefc6066                                        *    |
|    *        Uname: MS Windows NT                                       *    |
|    *      OS Info: 6.2                                                 *    |
|    *         User: ContainerAdministrator                              *    |
|    *  Customer ID: 042718AA-877D3AAG                                   *    |
|    *  Current dir: C:\app                                              *    |
|    *   Process ID: 1976                                                *    |
|    *                                                                   *    |
|    *********************************************************************    |
|                                                                             |
-------------------------------------------------------------------------------

 command: FILE/COMMAND=docker_test.acf
 command: 
 command: file/model=docker_test

-------------------------------------------------------------------------------
|                                 Model Title                                 |
|=============================================================================|
|                                                                             |
|                     Adams View model name: docker_test                      |
|                                                                             |
-------------------------------------------------------------------------------

 command: ! Insert ACF commands here:
 command: SIMULATE/DYNAMIC, END=1.0, DTOUT=0.01


  Begin Simulation

  ****** Performing Dynamic Simulation using Gstiff I3 Integrator ******
   The system is modelled with INDEX-3 DAEs.
   The integrator is GSTIFF, CORRECTOR = original
   Integration error =    1.000000E-03

   Simulation   Step          Function     Cumulative    Integration   Elapsed 
   Time         Size          Evaluations  Steps Taken   Order         Time    
   ___________  ___________   ___________  ___________   ___________   ________
   0.00000E+00  5.00000E-04            0            0             1       0.01 
   1.00000E-01  1.00000E-02           32           16             3       0.02 
   2.00000E-01  1.00000E-02           52           26             3       0.02 
   3.00000E-01  1.00000E-02           72           36             3       0.02 
   4.00000E-01  1.00000E-02           92           46             4       0.02 
   5.00000E-01  1.00000E-02          111           56             4       0.02 
   6.00000E-01  1.00000E-02          123           66             5       0.03 
   7.00000E-01  1.00000E-02          133           76             5       0.03 
   8.00000E-01  1.00000E-02          143           86             5       0.03 
   9.00000E-01  1.00000E-02          153           96             5       0.03 
   1.00000E+00  1.00000E-02          163          106             6       0.04 

  End Simulation
 command: stop


Finished -----
Elapsed time = 0.04s,  CPU time = 0.02s,  Average CPU load = 41.12%

