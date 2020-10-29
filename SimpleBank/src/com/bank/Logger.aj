package com.bank;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter

public aspect Logger {
	long millis = System.currentTimeMillis();
	java.util.Date date = new java.util.Date(millis);
	File f = new File("Log.txt");
	
	pointcut success() : call(* create*(..) );
    after() : success() {
    //Aspecto ejemplo: solo muestra este mensaje después de haber creado un usuario 
    	System.out.println("**** User created ****");
    }
    
    pointcut transaccion(): call(* moneyMakeTransaction());
    after() : transaccion(){
    	FileWriter w;
		try {

			w = new FileWriter(f);
			BufferedWriter bw = new BufferedWriter(w);
			bw.write("Transaccion hecha a las " + date);
			bw.close();
			w.close();

		} catch (IOException e) {

			e.printStackTrace();
		}
    	System.out.println("****Transaccion realizada****");
    }
    
    pointcut retiro(): call(* moneyWithdrawal());
    after() : retiro(){
    	System.out.println("*Retiro realizado*");
    }
}
