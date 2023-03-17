import std.stdio;
import core.thread.osthread;
import core.time;
import std.traits;

enum Signals
{
	/// hangup
	SIGHUP = 1,
	/// interrupt
	SIGINT = 2,
	/// quit
	SIGQUIT = 3,
	/// illegal instruction (not reset when caught)
	SIGILL = 4,
	/// trace trap (not reset when caught)
	SIGTRAP = 5,
	/// abort()
	SIGABRT = 6,
	/// = SIGABRT for compatibility
	SIGIOT = SIGABRT,
	/// EMT instruction
	SIGEMT = 7,
	/// floating point exception
	SIGFPE = 8,
	/// kill (cannot be caught or ignored)
	SIGKILL = 9,
	/// bus error
	SIGBUS = 10,
	/// segmentation violation
	SIGSEGV = 11,
	/// bad argument to system call
	SIGSYS = 12,
	/// write on a pipe with no one to read it
	SIGPIPE = 13,
	/// alarm clock
	SIGALRM = 14,
	/// software termination signal from kill
	SIGTERM = 15,
	/// urgent condition on IO channel
	SIGURG = 16,
	/// sendable stop signal not from tty
	SIGSTOP = 17,
	/// stop signal from tty
	SIGTSTP = 18,
	/// continue a stopped process
	SIGCONT = 19,
	/// to parent on child stop or exit
	SIGCHLD = 20,
	/// to readers pgrp upon background tty read
	SIGTTIN = 21,
	/// like TTIN for output if (tp->t_local&LTOSTOP)
	SIGTTOU = 22,
	/// input/output possible signal
	SIGIO = 23,
	/// exceeded CPU time limit
	SIGXCPU = 24,
	/// exceeded file size limit
	SIGXFSZ = 25,
	/// virtual time alarm
	SIGVTALRM = 26,
	/// profiling time alarm
	SIGPROF = 27,
	/// window size changes
	SIGWINCH = 28,
	/// information request
	SIGINFO = 29,
	/// user defined signal 1
	SIGUSR1 = 30,
	/// user defined signal 2
	SIGUSR2 = 31,
	/// thread library AST
	SIGTHR = 32
};

void main()
{
	version(linux)
	{
		import etc.linux.memoryerror;

		//assert(registerMemoryErrorHandler);
	//	registerMemoryErrorHandler();

		//disableDefaultSignalHandlers();

		import core.sys.posix.signal;
	 sigset(Signals.SIGABRT, &on_signal);
		sigset(Signals.SIGINT, &on_signal);
		sigset(Signals.SIGTERM, &on_signal);
		sigset(Signals.SIGSEGV, &on_signal);
		sigset(Signals.SIGKILL, &on_signal);
	}

	write("wait signal  ...");
	while(true)
	{
	 write(".");
		stdout.flush();
  Thread.sleep(1.seconds);
	}
}



extern (C) void on_signal(int value)
{
	writeln();
	writeln("-- Signal: ", value, " (", cast(Signals)value , ") ---");
	stdout.flush();

	static import core.stdc.stdlib;
	static import core.runtime;
	core.runtime.Runtime.terminate();
	core.stdc.stdlib.exit(0);
}