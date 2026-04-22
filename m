Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDDB2BFC60
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899185; cv=none; b=W+M5Zhbe5+ch2KjP5+sSGySsIFI0PnaRkGwSs8MJThDyJmKZuKWjpgAjUyvKE5UwxQHFp/qjZj8BnD0iQYWxYXioACcLKet4HeLgSSDIlhkk7ktGpJjpooFuAqfbXCPB7DGXCbBAOWTM5NLbKYFw+urIiJvxWYhqI7ZeBJZakR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899185; c=relaxed/simple;
	bh=xh9tNDX1+cGV7BvcgBn6La5mY3jw9j10i2DGBt2woak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bT/R5s4zdVfukjzOlkr1kxP1909emIxseUSaA9h/C7lBmdlCCzpGuSZKgKg/OrFoYtDeS/ca8/lMWd+qmfZSZHpjm3NavIQYhXae4f/YYAxDXP+uxx46/xg5PZtr6NIFqCh0LZGCSDSeGgHp4qrlEixfEbtqiuKc2dGpHQaq4SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvrlGJEj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvrlGJEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641B2C19425;
	Wed, 22 Apr 2026 23:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776899185;
	bh=xh9tNDX1+cGV7BvcgBn6La5mY3jw9j10i2DGBt2woak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HvrlGJEj27CpWMRdEBPS2BmGc4p3FpzxtzY38W/zyyKGHqeMm6qLbW5Zphf49X9KH
	 0NK4MnUP9vDMIYrO1OltKewk4Go+wOKJU/G8MGTIsmznk0HaY7kqz4JAnU9Ji11HvV
	 EZeZLRa5AbR8TKoiQLsijBXorwHT1aq7h8pq/n4V27fZNbh7a4WsCbrKeJbUJ9r3SC
	 5Qv4RJcAaEHLsO9ZC+P7x/I0gRvTGNSObeV03607CGoCVpXwYwW4lZNsr31b00k2tW
	 QwewB12fbBEZb6rXq8pTld+y9+vxph4wwWYrQFXSpksY3217c8riVtnHIV0EPZTcjH
	 UgFhoFPZDoOsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v12 3/6] bpf: Add sleepable support for classic
 tracepoint programs
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422-sleepable_tracepoints-v12-3-744bf0e3b311@meta.com>
References: <20260422-sleepable_tracepoints-v12-3-744bf0e3b311@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 23:06:24 +0000
Message-Id: <20260422230625.641B2C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Critical] Inverted RCU lock logic in `bpf_prog_run_array_sleepable()` ca=
uses sleepable programs to run under `rcu_read_lock()` and non-sleepable pr=
ograms to run without it.
- [High] Uninitialized kernel stack memory is leaked to BPF programs via th=
e `param` struct in `perf_call_bpf_enter()` and `perf_call_bpf_exit()`.
--

commit 37b318a3f61844cb76121bebc8014d8031e06996
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Add sleepable support for classic tracepoint programs

This commit adds trace_call_bpf_faultable() for faultable tracepoints,
supporting sleepable bpf programs. It also restructures perf syscall hooks
to run bpf before preempt_disable.

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 4e763dd2aa2bb..bbc0710615014 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> +unsigned int trace_call_bpf_faultable(struct trace_event_call *call, voi=
d *ctx)
> +{
> +	struct bpf_prog_array *prog_array;
> +
> +	might_fault();
> +	guard(rcu_tasks_trace)();
> +
> +	prog_array =3D rcu_dereference_check(call->prog_array,
> +					   rcu_read_lock_trace_held());
> +	return bpf_prog_run_array_sleepable(prog_array, ctx, bpf_prog_run);
> +}

Does bpf_prog_run_array_sleepable() properly handle rcu locks for sleepable
programs?

A preceding patch introduced bpf_prog_run_array_sleepable() which appears
to have an inverted logic check:

if (prog->sleepable) {
    guard(rcu)();
    ...
}

This causes sleepable programs to execute with the rcu read lock held,
preventing them from sleeping. Conversely, non-sleepable bpf programs run
without the rcu read lock, which could lead to regressions when accessing
rcu-protected data.

> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 8ad72e17d8eb9..e98ee7e1e66f4 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -1371,33 +1371,33 @@ static DECLARE_BITMAP(enabled_perf_exit_syscalls,=
 NR_syscalls);
>  static int sys_perf_refcount_enter;
>  static int sys_perf_refcount_exit;
> =20
> -static int perf_call_bpf_enter(struct trace_event_call *call, struct pt_=
regs *regs,
> +static int perf_call_bpf_enter(struct trace_event_call *call,
>  			       struct syscall_metadata *sys_data,
> -			       struct syscall_trace_enter *rec)
> +			       int syscall_nr, unsigned long *args)
>  {
>  	struct syscall_tp_t {
>  		struct trace_entry ent;
>  		int syscall_nr;
>  		unsigned long args[SYSCALL_DEFINE_MAXARGS];
>  	} __aligned(8) param;
> +	struct pt_regs regs =3D {};

Is it possible for this code to leak uninitialized kernel stack memory to
bpf programs?

The param struct is allocated on the stack but not fully initialized. On
32-bit systems, overwriting the first few bytes only partially covers ent,
leaving ent.pid uninitialized.=20

Additionally, if the system call has fewer than 6 arguments, the trailing
elements of param.args remain uninitialized and could be read by bpf
tracepoint programs.

[ ... ]

> -static int perf_call_bpf_exit(struct trace_event_call *call, struct pt_r=
egs *regs,
> -			      struct syscall_trace_exit *rec)
> +static int perf_call_bpf_exit(struct trace_event_call *call,
> +			      int syscall_nr, long ret_val)
>  {
>  	struct syscall_tp_t {
>  		struct trace_entry ent;
>  		int syscall_nr;
>  		unsigned long ret;
>  	} __aligned(8) param;
> -
> -	/* bpf prog requires 'regs' to be the first member in the ctx (a.k.a. &=
param) */
> -	perf_fetch_caller_regs(regs);
> -	*(struct pt_regs **)&param =3D regs;
> -	param.syscall_nr =3D rec->nr;
> -	param.ret =3D rec->ret;
> -	return trace_call_bpf(call, &param);
> +	struct pt_regs regs =3D {};

Could this also leak uninitialized padding to bpf programs?

Similar to perf_call_bpf_enter(), param is not zero-initialized here.
On 64-bit systems, compiler-inserted padding between syscall_nr (4 bytes)
and ret (8 bytes) is left uninitialized and could also be read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422-sleepable_=
tracepoints-v12-0-744bf0e3b311@meta.com?part=3D3
