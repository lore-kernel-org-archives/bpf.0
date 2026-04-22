Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34811FBEBC
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900956; cv=none; b=WFrOwok1FYawgAfOLLZepyFVGugiCYiwb5eDnb+GNJmjJsrB4Z8DlL3WDUIVS3ZW787NJUOI9bobj9lHZDVnz1ke8LOcwsrqjwe0jM/tIxj4o4p1LC9LOfuebd2M33ltBvoFKtcpqsnwPnVu5tHxSqMJ/tbnGZSwyptIELXqG7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900956; c=relaxed/simple;
	bh=OJsKdnBA7iz0Xiqg8rEtquFGuaLZgCHkO1VWemUVEMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MNVvcDkIWPXwl7Ya9E7Cd1tsuTQmcViAFxsORiVNDlkkaAa/vJLUKiko6PoNPltGykAWgcYBLoW5eUWkmenySwNB/Aj2R4X0FbsYD7LAxiwvzKkXjKlDXVTY7qoSNFnpk2hstBSfrCmveS6FUrSA1jXhyW2tG/HH8nyTIOHzgGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h848h7wg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h848h7wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE5CC19425;
	Wed, 22 Apr 2026 23:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900956;
	bh=OJsKdnBA7iz0Xiqg8rEtquFGuaLZgCHkO1VWemUVEMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=h848h7wgJzNX5yIp0yVGZ4J7eg43vdC0hiP2A+i3TTf00i+R+jw/AkhG7z2LBf4wg
	 hc4TjCNdHBHo4rQag2WjCqGElS3qCO6iesr5jrTS0PH5CuFc7EkjU5w7ACzYQIBF2C
	 zfpLfdUnYgZ4LXJ61h7wOpM/3IqNY5fcB4BjqnDi88XMGvZOYeN3xbosoe3LiAqZTW
	 QPzIaNudFIxJXqGISGwo0PFwTmtmob00w5W7QHQvUrRGkUXkt0aEZ/WuPhnJq74fpk
	 H21Ur2XzmclbkfLwqhlf4l3lzpb7/YztCeLjJsPb7xRxqquEIt6QOHcT/U6Fmr20qf
	 OAjCc2J94doZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v13 3/6] bpf: Add sleepable support for classic
 tracepoint programs
Reply-To: sashiko@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260422-sleepable_tracepoints-v13-3-99005dff21ef@meta.com>
References: <20260422-sleepable_tracepoints-v13-3-99005dff21ef@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 23:35:55 +0000
Message-Id: <20260422233556.1AE5CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Uninitialized kernel stack memory leaked to BPF programs via `para=
m` structure.
- [High] Moving BPF program execution before `syscall_get_data()` breaks `b=
pf_probe_read_user()` for non-sleepable programs by removing implicit page =
faulting.
--

commit 6d42174eb2c9a4cc877bdf6b63e5b37b8017a109
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Add sleepable support for classic tracepoint programs

This commit adds support for sleepable BPF programs on syscall tracepoints
by moving the BPF program execution out of the non-preemptible ring buffer
allocation path. It introduces trace_call_bpf_faultable() and restructures
perf_syscall_enter() and perf_syscall_exit().

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

Could param be zero-initialized here?=20

Because param is allocated on the kernel stack without zero-initialization,
there is a 4-byte padding between syscall_nr and args. Additionally, only
sys_data->nb_args elements of the args array are initialized, leaving the
remaining elements uninitialized.

Since the BPF verifier allows tracing programs to read the full context siz=
e,
this padding and uninitialized array elements can be read by BPF programs,
leaking kernel stack memory. Zero-initializing param (e.g., param =3D {})
would prevent this.

[ ... ]

> @@ -1429,6 +1424,26 @@ static void perf_syscall_enter(void *ignore, struc=
t pt_regs *regs, long id)
> =20
>  	syscall_get_arguments(current, regs, args);
> =20
> +	/*
> +	 * Run BPF program in faultable context before per-cpu buffer
> +	 * allocation, allowing sleepable BPF programs to execute.
> +	 */
> +	valid_prog_array =3D bpf_prog_array_valid(sys_data->enter_event);
> +	if (valid_prog_array &&
> +	    !perf_call_bpf_enter(sys_data->enter_event, sys_data,
> +				 syscall_nr, args))
> +		return;
> +

Does moving BPF program execution here break bpf_probe_read_user() for
existing non-sleepable BPF programs?

Previously, BPF programs ran after syscall_get_data() was called, which
explicitly faulted in user memory for string arguments. Because the memory
became resident, non-sleepable BPF programs could use bpf_probe_read_user()
to reliably read those arguments without taking page faults.

Now that the BPF program runs before syscall_get_data(), if the user memory
is paged out, bpf_probe_read_user() in non-sleepable programs might fail
with -EFAULT.=20

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

Similarly to perf_call_bpf_enter(), could param be zero-initialized here
to avoid leaking kernel stack memory through the padding between syscall_nr
and ret?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260422-sleepable_=
tracepoints-v13-0-99005dff21ef@meta.com?part=3D3
