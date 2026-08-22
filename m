Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3449362B
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787440236; cv=none; b=fhacatKT6VN1kwelHXp6Rn5qtmMsAMn7fnOCR0GuqIj/uM4GDhZvM9ckydOQVuqvY0qkAp8PjZFISp9pmU5paLmQDh6dWYuPw64+fH/KlAP4iKLPfAMtTqhvJg+BiqOAyYcKGaQQysZ08w9lJtunogkbfw/69wyANnYmQ1klhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787440236; c=relaxed/simple;
	bh=bHb5OulxnxGaxGi8J32PFLEJAozWvIcxUlnfWQn9Urs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ojek642wUAWfxZYM/s7oIDzOzezPYQDMIV3tsCNVj67n1iQJLdsxSXRHBZPxyRvbRBr1GUfK9GfT2U41GXE+usF7xQbq3qT7F/748cge4se+B/f94ei00LqCke3OiaIyqcLiL9Oy6OAaoLg5opmwLcQkVwO/EIGZBcnGNe6K95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjDZ26Z4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjDZ26Z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852F01F000E9;
	Sat, 22 Aug 2026 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787440234;
	bh=LzAbnWU67PVR7/LJG2KBmjtjc2KjMSJ+cKGxBGJf6LQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EjDZ26Z4VMj6uoc4DHgWD4iurWPvzc6FzPbBfLTBN2U6K/MJqINQICPGLPK/I5PKA
	 xo9A8pcBMLPcikCmQ5CxeILmzlPFipiY091JXvdEQfA+wZXrEn4YrYKuGFumeYOVDZ
	 ds59yES37x0KKME+n9ccTQ+s5sQTb9x2+6Xj7KT8JACUVwY1m12DJiNOikNOE7TOIL
	 g7FPcuCWVr/Io8Effb8oZhxNd4QLIBQ2M1WHLRMXmVeHwLQLNo/AuLjI1VYl1E+uxs
	 h/ib0NqslwsZJ6Zyz+aVrFEjjNe7KvvtWJfUwHrzBpVw5wGV0gYXPISH668ve54Whf
	 MlSkqaIEt6SyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable
 programs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Simon" <simon@swine.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260822225444.2774461-2-simon@swine.de>
References: <20260822225444.2774461-1-simon@swine.de>
 <20260822225444.2774461-2-simon@swine.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 23:10:34 +0000
Message-Id: <20260822231034.852F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Non-sleepable BPF uprobe programs remain vulnerable to per-CPU pri=
vate stack corruption.
--

--- Patch [1]: [PATCH bpf v3 1/2] bpf: disable private stack for sleepable =
programs ---
commit 5b27c96c855b5a6df31f1d2543a92540c69a5d98
Author: Christian Simon <simon@swine.de>

bpf: disable private stack for sleepable programs

This commit disables the use of private stacks for sleepable BPF programs
since they can be preempted, which would allow a second invocation of the
program on the same CPU to corrupt the first invocation's stack. The fix
forces sleepable programs to use the regular kernel stack which handles
preemption correctly.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5e37ca75e5c4a..038753ef07a99 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5237,6 +5237,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(=
struct bpf_prog *prog)
>  	if (!bpf_jit_supports_private_stack())
>  		return NO_PRIV_STACK;
> =20
> +	/*
> +	 * Sleepable programs can be preempted, allowing another task to run
> +	 * the same program on the same CPU. Since private stack is per-CPU
> +	 * and per-program, the second invocation would corrupt the first's
> +	 * stack. Disable private stack for sleepable programs.
> +	 */
> +	if (prog->sleepable)
> +		return NO_PRIV_STACK;
> +
>  	/* bpf_prog_check_recur() checks all prog types that use bpf trampoline
>  	 * while kprobe/tp/perf_event/raw_tp don't use trampoline hence checked
>  	 * explicitly.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but does
this leave non-sleepable uprobes vulnerable to the same stack corruption?

The patch correctly fixes sleepable programs, but the commit message mentio=
ns
that preemptible non-sleepable dispatch paths require separate protection.
However, non-sleepable uprobes are granted private stacks because they fall
under BPF_PROG_TYPE_KPROBE in the switch statement immediately below this c=
ode.

If we look at bpf_prog_run_array_uprobe() in include/linux/bpf.h,
non-sleepable uprobes are executed with only rcu_read_lock():

    if (!prog->sleepable)
        rcu_read_lock();
       =20
    run_ctx.bpf_cookie =3D item->bpf_cookie;
    ret &=3D run_prog(prog, ctx);
    item++;
   =20
    if (!prog->sleepable)
        rcu_read_unlock();

Under CONFIG_PREEMPT_RCU and CONFIG_PREEMPT, rcu_read_lock() does not disab=
le
preemption. Could a task executing this non-sleepable uprobe be preempted,
allowing another task on the same CPU to trigger the same uprobe and overwr=
ite
its per-CPU private stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822225444.2774=
461-1-simon@swine.de?part=3D1
