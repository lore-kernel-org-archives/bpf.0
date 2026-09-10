Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9515947FB;
	Thu, 10 Sep 2026 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067079; cv=none; b=Mf7mztdO1ZWMpPFHPQozjkovRHoFR11lkTW0D4ZAKSeXsqF+uN7JvlaUl44uwlyEL6/rLKJZs/r/yUXoGRNb7d2GUiOyozpftuogC/wp8oACMdx0OLU9LggWCG6i5/cnxM7rypS92A2sj96nodyU/aH/s5l72RundbkiGNX45Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067079; c=relaxed/simple;
	bh=go3hQTcWFCs3giPaNo3uUzjuXIYBl99zfl+jDc9JSXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I27whQTuDfiVtuNpG5JWy1EQRzRwoX0r416i1Xoh+AcIhitPCLcvDmj7CZdS4u0Gj4B6BRJHIk9teM//0GcYU3iqjCXxUT284+oSpqMK4DfCaC1pMmKNbHSS18iPFNagEq58KkzULFasFR7fv+Vc20L4QAXv5284S5C+RXJHHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMaz7riQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMaz7riQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE3A1F000FF;
	Thu, 10 Sep 2026 19:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067077;
	bh=0sGSuY/O5/hfetiJWu2/POwiCbJePGCgVd6aOiaksq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMaz7riQ394wOepYcOhcjqyl2l4aqWY1Vv5pm938f6dXhFvmN9p8fknsFNZ228Ec2
	 sg4l7c1xpe9GVMpl0EIDbOn5XKjPd74qFN/ZjGVQQjRLa7fuNDCEwnMS5bpB4OB4k8
	 in/S4gfEbl1FoL2PCGiiCuZFeTdOwUVUMhGO/xLWmhJGqZ6GgzH0hOWtJ10ii58WWJ
	 tjti4MEqR7JWXVEACaEAev11BRHPoqJTISE3oozREquEiLkoChBhLM3/sIWyRloE0y
	 WnG1EqU5xGz7bnNOtUZkWZjl6rSLuHMO9QIiL8/D1ZK+eflJpfcARXei/ko6OLxvWP
	 t/khrXbgKmJ0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/13] arm64: ftrace: Maintain Tasks RCU trampoline
 nesting in ftrace_caller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260910-b4-rcu-tasks-preempt-qs-v1-9-d4469f4cc101@toxicpanda.com>
References: <20260910-b4-rcu-tasks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com>
 <20260910-b4-rcu-tasks-preempt-qs-v1-9-d4469f4cc101@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:04:36 +0000
Message-Id: <20260910190436.EBE3A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Build failure due to missing `ftrace_static_tramp_end` symbol when =
`CONFIG_DYNAMIC_FTRACE_WITH_ARGS` is disabled.
--

commit 459a25e6b720c08167da420eb83180b2856610e3
Author: Josef Bacik <josef@toxicpanda.com>

    arm64: ftrace: Maintain Tasks RCU trampoline nesting in ftrace_caller
   =20
    Bracket the call out to the ftrace_ops callback in ftrace_caller with an
    increment/decrement of current->rcu_tramp_nesting, using x12/w13 which
    are scratch there.  The read-modify-write is not atomic, but only curre=
nt
    modifies the count and every interrupting user is balanced, so nothing =
is
    lost.

> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-f=
trace.S
> index 025140caafe74..46a102e7199ac 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -14,6 +14,33 @@
>  #include <asm/insn.h>
> =20
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS

[ ... ]

> @@ -178,6 +209,10 @@ SYM_CODE_START(ftrace_stub_direct_tramp)
>  SYM_CODE_END(ftrace_stub_direct_tramp)
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> =20
> +/* End of [ftrace_caller, ...) for arch_rcu_tasks_ip_in_trampoline(). */
> +SYM_CODE_START(ftrace_static_tramp_end)
> +SYM_CODE_END(ftrace_static_tramp_end)
> +
>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
> =20
>  /*

[Severity: Low]
Will this cause a linker error when compiling with
CONFIG_RCU_TASKS_PREEMPT_QS=3Dy but CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dn?

The ftrace_static_tramp_end label is defined here exclusively inside the
CONFIG_DYNAMIC_FTRACE_WITH_ARGS block. The legacy mcount-based ftrace path
in the #else block lacks this definition.

> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index e1a3c0b3a0514..1b7ac2afed0df 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -17,6 +17,22 @@
>  #include <asm/insn.h>
>  #include <asm/text-patching.h>
> =20
> +#ifdef CONFIG_RCU_TASKS_PREEMPT_QS
> +extern void ftrace_static_tramp_end(void);
> +
> +/*
> + * See rcu_tasks_ip_in_trampoline().  ftrace_caller and ftrace_stub_dire=
ct_tramp
> + * are core kernel text but must be treated as trampolines: a task preem=
pted in
> + * them may be carrying an ops pointer (x11) or a direct-call BPF trampo=
line
> + * address (x17) whose lifetime is guarded only by Tasks RCU.
> + */
> +bool arch_rcu_tasks_ip_in_trampoline(unsigned long ip)
> +{
> +	return ip >=3D (unsigned long)ftrace_caller &&
> +	       ip <  (unsigned long)ftrace_static_tramp_end;
> +}
> +#endif

[Severity: Low]
Since arch_rcu_tasks_ip_in_trampoline() unconditionally references
ftrace_static_tramp_end here under CONFIG_RCU_TASKS_PREEMPT_QS, this might
lead to an undefined reference at link time if CONFIG_DYNAMIC_FTRACE_WITH_A=
RGS
is disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-b4-rcu-tas=
ks-preempt-qs-v1-0-d4469f4cc101@toxicpanda.com?part=3D9
