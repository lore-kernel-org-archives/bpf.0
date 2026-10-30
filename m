Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343317;
	b=mL90UidU76usuLceBGpkwvXlKmPuWQ4zMw51PEWvD80iqRgmnfxYhof7oH7Zi6iDmavT
	 AKyCmccENUdbFw8v8WTruszBj03ftn/o3ig7K7nQGCDo/fMa0TP9NxVHgTyA+S/1iECqn
	 4nzN3YogYJ69PKKuvPAH2X/w3ARhP+B+qzJaktL9Rdef1b99D+L3JAWgbraDBJnG8FrDe
	 VrEPID9vBG89tW87XfCIdtBLQR3WqPY8Z1g3cXCQwlBb/wPB1pVHCOpkUMV+ocEbUcwtK
	 JNVuQEbKNxZnljMxLWB01jraDQt3HSYVqq2Qi/iCFFJcqKmqbsz0LUjgLodAK+ZPyXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SwWlr6GPMP50W7gf4ONr3w4sczaPKoWRy2qSwNV3sOY=;
	b=Qy1+0pkdaJkbnvC6auxVC1qM03ykOHdfuXTbx2X9TzTfrSbHd6aFhFHsZV7mV4YDPmJf
	 KfbHlSFKLhaAulvukcQKqpijED22mI5bhritxX6VIUZtPM8Pgc1fDBKqUGnYmwxy5rNr1
	 g0NHrfZ4gmejpJBSENNMyLmh2vVdZM3GkmUYXbqb3Lvz3ZLOZq15JOXrY9hVrg153XfKA
	 2uJbHJSq6OTPSQFKMGWOsPNK25R5R+/UwR1m3xxTVZYcDxk6xztDZFUhBxyZ3hi69Lxrm
	 2zgOMlQ3RfPWP9MgsjAemNaOmOMgiZSBq+bSS75I9qLSnVbO5E0nFj89DiPWzzxww8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5t4bFXE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A04606A327
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5t4bFXE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB4F1F000C1;
	Fri, 30 Oct 2026 06:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793343316;
	bh=SwWlr6GPMP50W7gf4ONr3w4sczaPKoWRy2qSwNV3sOY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=W5t4bFXE1+dUIIO7/DCYfLA4IjeNNydWxvi6seC/oM+4rmSnueHtvYj2HMn5l1/iM
	 j87Xms0hT+DZ2Yx2ZZXG8ppSrCC9LHPQnwoXtv0EmTcZFzho12PLSv1WsnCZLY6dWw
	 baGVI4+fA4Qcd6A86gv02NDdZIFS463Nd9zkhifg/7DM2jSw97dJDznyniPUYcQMpC
	 VPqck0BpYOV/V6VReUQ1hXffruxu7kZd0t6aJK5cnnbYAuTi3OfQMwVgkKOgjNhGV0
	 CDULYFUWPG5G+bJwG6woLt9KjHZvMELLsCeGJzEeFhUN8b6W2qWRmGvs+DADx1b0MD
	 LaY58ByNC3mhw==
Message-ID: <sashiko-outbox-190619@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/seccomp: Add tests for syscall
 argument rewrite
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, bpf@vger.kernel.org
In-Reply-To: <20261030063630.1218302-3-ruanjinjie@huawei.com>
References: <20261030063630.1218302-1-ruanjinjie@huawei.com>
 <20261030063630.1218302-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:55:15 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] selftests/seccomp: broken non_syscall_stop_keeps_orig_arg() sync=
hronization
- [Medium] selftests/seccomp: SIGUSR1 suppressed at signal-delivery stop in=
 restart test
- [Medium] selftests/seccomp: commit message mismatch on arm32-only test gu=
ard
- [Medium] selftests/seccomp: seccomp_ptrace_args duplicates seccomp_bpf he=
lpers
--

commit a4698a2d9cf8e2f019613efd5e196f42fdab8a8c
Author: Jinjie Ruan <ruanjinjie@huawei.com>

selftests/seccomp: Add tests for syscall argument rewrite

This commit adds a standalone seccomp_ptrace_args selftest to verify that
seccomp filters observe syscall arguments rewritten by a ptrace tracer at
SECCOMP_RET_TRACE and PTRACE_SYSCALL entry stops, as well as testing
syscall restart argument preservation and non-syscall stops on arm32.

>     selftests/seccomp: Add tests for syscall argument rewrite
>    =20
>     A tracer can change a syscall argument at two stops:
>    =20
>      - at a SECCOMP_RET_TRACE stop, the tracer runs first and the kernel
>        checks the filters again after it;
>      - at a PTRACE_SYSCALL entry stop, the tracer runs first and seccomp
>        runs after it.
>    =20
>     In both cases seccomp must see the new argument, because the syscall =
is
>     executed with the new value.
>    =20
>     The seccomp selftests (TRACE_syscall) change the syscall number and t=
he
>     return value, but not the arguments.  arm64 has two architecture
>     specific tests for x0, seccomp_ptrace_x0_bypass.c for the
>     syscall-entry stop and seccomp_ret_trace_x0_bypass.c for the
>     SECCOMP_RET_TRACE stop, in tools/testing/selftests/arm64/abi/, but th=
ey
>     run on arm64 only.
>    =20
>     These tests call getpid() with a known first argument and install a
>     filter that rejects the value the tracer writes.  The return value of
>     getpid() shows which argument the filter saw.  They run on arm32, arm=
64,
>     x86-64 and i386, and they cover both stops above.
>    =20
>     riscv and loongarch skip: the kernel gives orig_a0, not a0, to both t=
he
>     syscall and seccomp, so a0 is not the argument register there.
>    =20
>     Two tests run on arm32 only:
>      - a syscall that returns -ERESTARTSYS and is restarted must run with=
 the
>        first argument from the entry, not with the error value;
>      - a stop outside a syscall must not change ARM_ORIG_r0, which is ~0
>        there.
>    =20
>     The first two tests catch the arm32 bug where seccomp sees the old
>     first argument.
>    =20
>     The tests were written with assistance from DeepSeek V4.1 Flash.
>    =20
>     Tested on QEMU for arm32 and arm64, and on hardware for x86-64 and i3=
86
>     (passed/total):
>      - arm32: 4/4
>      - arm64: 3/3
>      - x86-64: 3/3
>      - i386: 3/3
>    =20
>     No case runs on riscv64 or loongarch64: the test skips there for the
>     reason above.
>    =20
>     Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

[Severity: Medium]
The commit message states that two tests run on arm32 only (the
-ERESTARTSYS restart test and the stop outside a syscall test).

However, in seccomp_ptrace_args.c,
TEST(syscall_exit_stop_preserves_arg_for_restart) is defined under
HAVE_ARG0 rather than HAVE_ORIG_ARG0, so it is built and executed on
arm64, x86-64, and i386 as well (which matches the 3/3 counts reported in
the commit message for those architectures, whereas only
TEST(non_syscall_stop_keeps_orig_arg) is guarded by HAVE_ORIG_ARG0).

Should the commit message be updated to match the #ifdef guards in the
test, or was syscall_exit_stop_preserves_arg_for_restart intended to be
inside HAVE_ORIG_ARG0?

> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/sel=
ftests/seccomp/Makefile
> index 584fba4870372..4232068a9bd8e 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -3,5 +3,5 @@ CFLAGS +=3D -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>  LDFLAGS +=3D -lpthread
>  LDLIBS +=3D -lcap
> =20
> -TEST_GEN_PROGS :=3D seccomp_bpf seccomp_benchmark
> +TEST_GEN_PROGS :=3D seccomp_bpf seccomp_benchmark seccomp_ptrace_args
>  include ../lib.mk
> diff --git a/tools/testing/selftests/seccomp/seccomp_ptrace_args.c b/tool=
s/testing/selftests/seccomp/seccomp_ptrace_args.c
> new file mode 100644
> index 0000000000000..e2e6df54e9749
> --- /dev/null
> +++ b/tools/testing/selftests/seccomp/seccomp_ptrace_args.c
[ ... ]
> +#if __BYTE_ORDER__ =3D=3D __ORDER_LITTLE_ENDIAN__
> +#define syscall_arg0	offsetof(struct seccomp_data, args[0])
> +#else
> +#define syscall_arg0	(offsetof(struct seccomp_data, args[0]) + sizeof(__=
u32))
> +#endif
> +
> +#if defined(__arm__)
> +# define HAVE_ARG0		1
> +# define HAVE_ORIG_ARG0		1
> +# define ARCH_REGS		struct pt_regs
> +# define SYSCALL_ARG0(_regs)	((_regs).ARM_r0)
> +# define SYSCALL_ARG0_ORIG(_regs) ((_regs).ARM_ORIG_r0)
> +# define SYSCALL_RET_SET(_regs, _val) ((_regs).ARM_r0 =3D (_val))
> +#elif defined(__x86_64__)
> +# define HAVE_ARG0		1
> +# define ARCH_REGS		struct user_regs_struct
> +# define SYSCALL_ARG0(_regs)	((_regs).rdi)
> +# define SYSCALL_RET_SET(_regs, _val) ((_regs).rax =3D (_val))
> +#elif defined(__i386__)
> +# define HAVE_ARG0		1
> +# define ARCH_REGS		struct user_regs_struct
> +# define SYSCALL_ARG0(_regs)	((_regs).ebx)
> +# define SYSCALL_RET_SET(_regs, _val) ((_regs).eax =3D (_val))
> +#elif defined(__aarch64__)
> +# define HAVE_ARG0		1
> +# define USE_REGSET		1
> +# define ARCH_REGS		struct user_pt_regs
> +# define SYSCALL_ARG0(_regs)	((_regs).regs[0])
> +# define SYSCALL_RET_SET(_regs, _val) ((_regs).regs[0] =3D (_val))

[Severity: Medium]
This isn't a bug, but tools/testing/selftests/seccomp/seccomp_bpf.c
already defines syscall_arg(), ARCH_REGS, SYSCALL_NUM, SYSCALL_RET,
SYSCALL_RET_SET, get_syscall(), change_syscall(), and FIXTURE(TRACE_syscall)
with ptrace and seccomp variants across more than a dozen architectures.

Could these test cases be added to seccomp_bpf.c (or share its register
and ptrace helpers) instead of introducing a separate seccomp_ptrace_args
binary that duplicates syscall_arg0, ARCH_REGS, SYSCALL_RET_SET, and
get_regs()/set_regs() for four architectures?

[ ... ]
> +TEST(syscall_exit_stop_preserves_arg_for_restart)
> +{
> +	int pipefd[2];
> +	struct sigaction sa =3D {
> +		.sa_handler =3D sighandler,
> +		.sa_flags =3D SA_RESTART,
> +	};
> +	pid_t tracee;
> +	long last_nr =3D -1;
> +	int status, poked =3D 0;
> +
> +	ASSERT_EQ(0, pipe(pipefd));
> +
> +	tracee =3D fork();
> +	ASSERT_GE(tracee, 0);
> +	if (tracee =3D=3D 0) {
> +		close(pipefd[0]);
> +		sigaction(SIGUSR1, &sa, NULL);
> +		ptrace(PTRACE_TRACEME, 0, NULL, NULL);
> +		raise(SIGSTOP);
> +		_exit(write(pipefd[1], "x", 1) =3D=3D 1 ? 0 : 1);
> +	}
> +	close(pipefd[1]);
> +
> +	attach(_metadata, tracee, PTRACE_O_TRACESYSGOOD);
> +	ASSERT_EQ(0, ptrace(PTRACE_SYSCALL, tracee, NULL, NULL));
> +
> +	for (;;) {
> +		struct ptrace_syscall_info info;
> +		long len;
> +
> +		ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
> +			kill(tracee, SIGKILL);
> +		}
> +		if (WIFEXITED(status))
> +			break;
> +		ASSERT_FALSE(WIFSIGNALED(status));
> +
> +		len =3D get_syscall_info(tracee, &info);
> +		if (len < 0) {
> +			kill(tracee, SIGKILL);
> +			SKIP(return, "PTRACE_GET_SYSCALL_INFO unsupported");
> +		}
> +		if (info.op =3D=3D PTRACE_SYSCALL_INFO_ENTRY)
> +			last_nr =3D info.entry.nr;
> +		if (!poked && info.op =3D=3D PTRACE_SYSCALL_INFO_EXIT &&
> +		    last_nr =3D=3D __NR_write) {
> +			ARCH_REGS regs;
> +
> +			ASSERT_EQ(0, get_regs(tracee, &regs));
> +			SYSCALL_RET_SET(regs, -ERESTARTSYS);
> +			ASSERT_EQ(0, set_regs(tracee, &regs));
> +			poked =3D 1;
> +			/* resume into the restart path */
> +			ASSERT_EQ(0, ptrace(PTRACE_CONT, tracee, NULL,
> +					    SIGUSR1));
> +			continue;
> +		}
> +		ASSERT_EQ(0, ptrace(PTRACE_SYSCALL, tracee, NULL, NULL));
> +	}

[Severity: Medium]
Does SIGUSR1 actually get delivered to sighandler() in
syscall_exit_stop_preserves_arg_for_restart?

When ptrace(PTRACE_CONT, tracee, NULL, SIGUSR1) is called at the
PTRACE_SYSCALL_INFO_EXIT stop, ptrace_report_syscall() queues SIGUSR1 via
send_sig(). As the tracee exits the syscall into get_signal(),
ptrace_signal() stops the tracee in a ptrace signal-delivery stop for
SIGUSR1.

On the next iteration of the loop, get_syscall_info() returns
info.op =3D=3D PTRACE_SYSCALL_INFO_NONE and poked is already 1, so the loop
calls:

    ptrace(PTRACE_SYSCALL, tracee, NULL, NULL);

Passing NULL (0) as the signal at the signal-delivery stop cancels
SIGUSR1 in ptrace_signal(), so get_signal() returns false and sighandler()
and the SA_RESTART signal-delivery path are bypassed. Should the
signal-delivery stop forward WSTOPSIG(status) when resuming the tracee?

> +
> +	close(pipefd[0]);
> +	EXPECT_EQ(1, poked);
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +}
> +
> +#ifdef HAVE_ORIG_ARG0
> +
> +/*
> + * The tracer rewrites r0 while the tracee is stopped on a signal delive=
red
> + * outside of a syscall, where ARM_ORIG_r0 holds the ~0 "no syscall" mar=
ker.
> + * The marker must not be replaced by the value the tracer wrote.
> + */
> +TEST(non_syscall_stop_keeps_orig_arg)
> +{
> +	sig_atomic_t *got_signal =3D mmap(NULL, sizeof(*got_signal),
> +					PROT_READ | PROT_WRITE,
> +					MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	struct sigaction sa =3D {
> +		.sa_handler =3D sighandler,
> +	};
> +	pid_t tracee;
> +	int status;
> +	ARCH_REGS regs;
> +	unsigned long before;
> +
> +	ASSERT_TRUE(got_signal !=3D MAP_FAILED);
> +	ASSERT_EQ(0, sigaction(SIGUSR1, &sa, NULL));
> +
> +	tracee =3D fork();
> +	ASSERT_GE(tracee, 0);
> +	if (tracee =3D=3D 0) {
> +		ptrace(PTRACE_TRACEME, 0, NULL, NULL);
> +		raise(SIGSTOP);
> +		/*
> +		 * Spin in user mode so that the signal is not delivered on
> +		 * the return path of a syscall.
> +		 */
> +		while (!__atomic_load_n(got_signal, __ATOMIC_RELAXED))
> +			;
> +		_exit(0);
> +	}
> +
> +	__atomic_store_n(got_signal, 0, __ATOMIC_RELAXED);
> +	attach(_metadata, tracee, 0);
> +	ASSERT_EQ(0, ptrace(PTRACE_CONT, tracee, NULL, NULL));
> +	usleep(200000);
> +	ASSERT_EQ(0, kill(tracee, SIGUSR1));
> +
> +	ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
> +		kill(tracee, SIGKILL);
> +	}
> +	ASSERT_TRUE(WIFSTOPPED(status));
> +	ASSERT_EQ(SIGUSR1, WSTOPSIG(status));
> +
> +	ASSERT_EQ(0, get_regs(tracee, &regs));
> +	before =3D SYSCALL_ARG0_ORIG(regs);
> +	SYSCALL_ARG0(regs) =3D 0xdeadbeefUL;
> +	ASSERT_EQ(0, set_regs(tracee, &regs));
> +	ASSERT_EQ(0, get_regs(tracee, &regs));
> +
> +	if (before =3D=3D 0xffffffffUL)
> +		EXPECT_EQ(before, (unsigned long)SYSCALL_ARG0_ORIG(regs));
> +
> +	__atomic_store_n(got_signal, 1, __ATOMIC_RELAXED);
> +	ASSERT_EQ(0, ptrace(PTRACE_CONT, tracee, NULL, SIGUSR1));
> +	ASSERT_EQ(tracee, wait_for_stop(tracee, &status, 10000)) {
> +		kill(tracee, SIGKILL);
> +	}
> +}

[Severity: Medium]
Can non_syscall_stop_keeps_orig_arg silently skip its assertion or fault
in the tracee when resuming?

First, after ptrace(PTRACE_CONT, tracee, NULL, NULL), the parent waits
with an unsynchronized usleep(200000) before sending SIGUSR1. If the
tracee has not yet returned from raise(SIGSTOP) (tgkill) and taken a
user-mode exception under load or slow emulation, before
(SYSCALL_ARG0_ORIG(regs)) will still hold the tgkill argument rather than
0xffffffffUL. Because EXPECT_EQ is guarded by:

    if (before =3D=3D 0xffffffffUL)
        EXPECT_EQ(before, (unsigned long)SYSCALL_ARG0_ORIG(regs));

the test will silently skip its only assertion and pass. Since got_signal
is already in a MAP_SHARED page, could the tracee write a ready state in
user mode after raise(SIGSTOP) returns so the test can wait for it and
unconditionally assert that before =3D=3D 0xffffffffUL?

Second, while the tracee is stopped in the middle of the C spin loop:

    while (!__atomic_load_n(got_signal, __ATOMIC_RELAXED))
        ;

the tracer sets SYSCALL_ARG0(regs) (ARM_r0) to 0xdeadbeefUL and resumes
the tracee with SIGUSR1 without restoring r0. Because r0 is a
caller-saved general-purpose register that the compiler may use to hold
the got_signal pointer across the loop, corrupting r0 to 0xdeadbeefUL can
cause the tracee to fault with SIGSEGV upon returning from sighandler().
The final wait_for_stop() also does not check WIFEXITED(status) or
WEXITSTATUS(status) =3D=3D 0, so a crash in the tracee goes unnoticed.

Finally, got_signal is not unmapped with munmap(), and the earlier SKIP()
paths in syscall_entry_stop_sees_rewritten_arg and
syscall_exit_stop_preserves_arg_for_restart return after
kill(tracee, SIGKILL) without reaping tracee via waitpid() or closing
pipefd[0].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030063630.1218=
302-1-ruanjinjie@huawei.com?part=3D2
