Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782625;
	b=otbQEIXVpcM334w9+Trk9V1LzPPs4OVn45CpJQS3ce2ssvg57Mvk+Sdj3gzhXi+HtxhS
	 si3iYQDMGq1aJIqM2F1fIjWCT/6ey5qiis8n+YQLiHEx/LC7wwTRFDmFs2aNLYxaDLzHJ
	 ScOAScJ9Ns373A0ZsvSN5B/R7SIMQ4VlJXhhQ85R51YVM7sCWgK4ZuPqmVh5gHIScjX/Y
	 c8m+eZBMLG0mn62s6AvDOAniDKJ4efVueSBCffChu8X359wZrnNKs0IpfltOKhohqCJqd
	 n+B4OWXWWB1XoczitWoH1DNLB4wwDCcR4Fxux61ohOS2+9sdij534tZ8rEcli9tBr1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782625;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HlALTijt5CRapJC/NolluYCFJC6FcDyvgnNPx8+9O8Q=;
	b=N487hteNYPfkiPivu7jAdEbffqlydxIThFK4mVLfE98pb9t+xIT4EvVDdV6eNDUIdbBu
	 YASmP00zwJaLXiI/3P+d2djySJZ94t4tXfXx1TpyozDgQeheuDab+Oql0QAeUJdYRQgjB
	 k+F93MFqE3NnaoFj0gjrd7wi3oNDFNlZiIjF6LfmgPgKy3igLp0PRikaoyZ1SsMOdtaTq
	 vbx4kPGcbosU74KTaEWWLAeVbY+8oJE0KzNOswzPsaaoTdJe3311ubBL2O+BLSv7HZRuD
	 kFXrWqER2DWJaQ23uH9SHOgJPNb2Y2zq62KGbe8m+ZQPllwfi/jzajxXEcCuSP7eGew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkDzc0YG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FBE606A31B;
	Wed,  4 Nov 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkDzc0YG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859421F000C1;
	Wed,  4 Nov 2026 08:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793782624;
	bh=HlALTijt5CRapJC/NolluYCFJC6FcDyvgnNPx8+9O8Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkDzc0YGaVlxHbugFKLbnuWK0745cupfb7jX+eTKrUvH3035K0+7pUi0/FkS6Z61L
	 2H8PmPUIJPAmrtApKGcxIVnhbgun6m8XARe9em1XEannlNPEiWF4BfyrIrUeHJi/60
	 Gbr4W0Y4RAoBBu07DL8ZwtBEOO8SH1634Oke05lDAWM7MGPiTGGed3vEEMNXKs09OX
	 JF+m6j3i8U7OpDGf8uD5iiVnJ1D83waL4Pl63FLnoKFYq4ELvWW4X1BhXdXub7Z/Fr
	 dc56o6vkNRfkp4CQtveqnvui46cVFoxAI2LQjJuN9v4xs6fXlX2M+XNmO1wvc/6xtc
	 k9iTUoXwdvj7w==
Message-ID: <sashiko-outbox-196902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Test faulting build IDs
 from a sleepable raw tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng Yang" <yangfeng59949@163.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261104083833.971911-2-yangfeng59949@163.com>
References: <20261104083833.971911-1-yangfeng59949@163.com>
 <20261104083833.971911-2-yangfeng59949@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:57:04 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: raise(SIGSTOP) in trigger_stop() overwrites recor=
ded stack
- [Medium] selftests/bpf: broken s390x unwind and missing IP check in subte=
st_raw_tp()
--

commit f32a6f825aa7edd03a124636be8381204465d887
Author: Feng Yang <yangfeng@kylinos.cn>

selftests/bpf: Test faulting build IDs from a sleepable raw tracepoint

This commit extends the build_id selftest with sleepable and non-sleepable
raw tracepoints on sys_enter to test faulting in build IDs when the build
ID page of uprobe_multi has been evicted.

> diff --git a/tools/testing/selftests/bpf/prog_tests/build_id.c b/tools/te=
sting/selftests/bpf/prog_tests/build_id.c
> index aec9c8d6bc96b..885dc3da5900b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/build_id.c
> +++ b/tools/testing/selftests/bpf/prog_tests/build_id.c

[ ... ]

> @@ -104,6 +106,138 @@ static void subtest_sleepable(void)
>  	test_build_id__destroy(skel);
>  }
> =20
> +static bool stack_has_build_id(const struct bpf_stack_build_id *stack, i=
nt frame_cnt,
> +			       const char *id, int id_sz)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < frame_cnt; i++)
> +		if (stack[i].status =3D=3D BPF_STACK_BUILD_ID_VALID &&
> +		    !memcmp(stack[i].build_id, id, id_sz))
> +			return true;
> +
> +	return false;
> +}

[ ... ]

> +static void subtest_raw_tp(bool sleepable)
> +{

[ ... ]

> +	ASSERT_GT(frame_cnt, 0, "frames");
> +	if (sleepable)
> +		ASSERT_TRUE(stack_has_build_id(stack, frame_cnt, build_id, build_id_sz=
),
> +			    "sleepable_build_id");
> +	else
> +		ASSERT_FALSE(stack_has_build_id(stack, frame_cnt, build_id, build_id_s=
z),
> +			     "nofault_build_id");

[Severity: Medium]
In trigger_stop(), uprobe_multi invokes the syscall via libc's syscall()
wrapper:

    subtest_raw_tp()
      -> run_uprobe_multi_stopped()
        -> trigger_stop()
          -> syscall(SYS_getpid)

When rawtp_nofault or rawtp_sleepable fires on sys_enter and calls
bpf_get_stack() with BPF_F_USER_STACK | BPF_F_USER_BUILD_ID, stack[0] is
inside libc.so rather than uprobe_multi, so reaching uprobe_multi requires
perf_callchain_user() to unwind user stack frames past libc.so.

On s390x, arch_stack_walk_user_common() in arch/s390/kernel/stacktrace.c
unwinds user stacks via sf->back_chain. Because uprobe_multi is built with
-fno-omit-frame-pointer but without -mbackchain in
tools/testing/selftests/bpf/Makefile, sf->back_chain is 0 and unwinding
stops after stack[0] in libc.so. Will raw-tp-sleepable-paged-out fail on
s390x because stack_has_build_id() never sees a frame from uprobe_multi?

Also, the commit message states that for the non-sleepable control:

    the same frame must be reported as IP, which also proves that the page
    was really evicted.

However, the non-sleepable branch in subtest_raw_tp() only asserts that
stack_has_build_id() is false without checking that any frame has status
BPF_STACK_BUILD_ID_IP. If unwinding stops at stack[0] in libc.so (whose
build ID is resident and valid), won't the non-sleepable subtest pass even
though uprobe_multi was never reached and no frame was reported with
BPF_STACK_BUILD_ID_IP?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_build_id.c b/tools/te=
sting/selftests/bpf/progs/test_build_id.c
> index 32ce59f9aa27b..a6d6712888dc9 100644
> --- a/tools/testing/selftests/bpf/progs/test_build_id.c
> +++ b/tools/testing/selftests/bpf/progs/test_build_id.c
> @@ -3,6 +3,7 @@
> =20
>  #include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> =20
>  struct bpf_stack_build_id stack_sleepable[128];
>  int res_sleepable;
> @@ -28,4 +29,41 @@ int uprobe_sleepable(struct pt_regs *ctx)
>  	return 0;
>  }
> =20
> +struct bpf_stack_build_id stack_rawtp_sleepable[128];
> +int res_rawtp_sleepable;
> +
> +struct bpf_stack_build_id stack_rawtp_nofault[128];
> +int res_rawtp_nofault;
> +
> +int target_tgid;
> +int target_syscall;
> +
> +SEC("raw_tp/sys_enter")
> +int BPF_PROG(rawtp_nofault, struct pt_regs *regs, long id)
> +{
> +	if ((u32)(bpf_get_current_pid_tgid() >> 32) !=3D (u32)target_tgid ||
> +	    id !=3D target_syscall)
> +		return 0;
> +
> +	res_rawtp_nofault =3D bpf_get_stack(ctx, stack_rawtp_nofault,
> +					  sizeof(stack_rawtp_nofault),
> +					  BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
> +
> +	return 0;
> +}
> +
> +SEC("raw_tp.s/sys_enter")
> +int BPF_PROG(rawtp_sleepable, struct pt_regs *regs, long id)
> +{
> +	if ((u32)(bpf_get_current_pid_tgid() >> 32) !=3D (u32)target_tgid ||
> +	    id !=3D target_syscall)
> +		return 0;
> +
> +	res_rawtp_sleepable =3D bpf_get_stack(ctx, stack_rawtp_sleepable,
> +					    sizeof(stack_rawtp_sleepable),
> +					    BPF_F_USER_STACK | BPF_F_USER_BUILD_ID);
> +
> +	return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/uprobe_multi.c b/tools/testing/s=
elftests/bpf/uprobe_multi.c
> index 0af330b6c3646..ef44d86962c13 100644
> --- a/tools/testing/selftests/bpf/uprobe_multi.c
> +++ b/tools/testing/selftests/bpf/uprobe_multi.c

[ ... ]

> @@ -123,12 +125,39 @@ int __attribute__((weak)) trigger_uprobe(bool build=
_id_resident)

[ ... ]

> +int __attribute__((weak)) trigger_stop(void)
> +{
> +	int err =3D prep_build_id_page(false /* page-out build ID */);
> +
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * Make one syscall that the BPF program under test filters on, then
> +	 * stop this process so that the recorded stack cannot be overwritten
> +	 * by another syscall while the caller inspects it.
> +	 */
> +	(void)syscall(SYS_getpid);
> +	raise(SIGSTOP);

[Severity: Medium]
Does raise(SIGSTOP) here end up issuing a second SYS_getpid syscall that
overwrites stack_rawtp_nofault and stack_rawtp_sleepable?

In glibc, raise(SIGSTOP) calls __pthread_kill_implementation(), which calls
__getpid() and executes SYS_getpid before invoking tgkill(). Because
rawtp_nofault and rawtp_sleepable in
tools/testing/selftests/bpf/progs/test_build_id.c only filter on
target_tgid and target_syscall without disarming after the first hit, the
SYS_getpid inside raise(SIGSTOP) will trigger the BPF program a second
time.

In raw-tp-sleepable-paged-out, the first syscall(SYS_getpid) has already
faulted in uprobe_multi's build ID page, so the second call records the
stack when the page is already resident. Furthermore, when libc.so is built
with -fomit-frame-pointer, unwinding out of __pthread_kill_implementation()
during the second SYS_getpid can fail to reach uprobe_multi, overwriting
the valid trace captured during syscall(SYS_getpid) and causing the
sleepable_build_id assertion in subtest_raw_tp() to fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104083833.9719=
11-1-yangfeng59949@163.com?part=3D2
