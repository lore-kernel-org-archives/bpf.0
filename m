Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F5218E91
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143701; cv=none; b=YFUxV0Bo6ErFkDD95CYkGUFzn3zMW/4nn64d5CiNGikgy3UOHwDqC4kBeg0T8NXPRir3Mj6WJuOZyvwnp+pJ9vdnQGS/+z5VP5/rhtUQdenhwNJu/WYkt46o5sU2RX2f2E8MVkShP/jHH0WThnK936T8SombrtuAzAZMI3OqHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143701; c=relaxed/simple;
	bh=A6e70RyQh29Xltd2fv2XWy+4Pk7ezUgWfsvl9KrfmI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EjrdrmgCtT33MctrOddaps7b3NEEg4UF8ULXAvbje5O0shOjTPbP1EGgJIo5xzAQJyWHt/jor/Q/6yKv9i8YarULtu5wkrSyCu3oFzyW0I0qEvb58cS5X9yBbgyqeMmpqsh80FCfKSUKUtDaEgUEi/YzaNu56jxQuBUwWztH6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fODieRA7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fODieRA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F18B1F00893;
	Thu, 11 Jun 2026 02:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781143700;
	bh=No/1QB3np+ErhWhGVTRTPL3TvQbnINMD7nqkcBYpPB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fODieRA7+k6UNASUWLFNHhagDKzhcv5u9khxMCp8YCY6vGCXQ/P9EZKHEE9AEwPMI
	 8qAcCtnWCT+WNRq1dfgWuopTot2OayXN73ncq2DQaZFE+uAT249W0vguIpVftXV8Ey
	 IGxKPz7bu/nr5Nvq7jGykZF7CxckJlnoecwrppnh/xmlek+80cNXIn2aKddhPPNZiL
	 +OHOEtv8qN+tBeNP1qK4wqBqxdnKGhq+KQU8MAFYSvOMmMf9xdQhReIGSdw42BQgLv
	 KpfQob9G3kItUfKGyW8TS9u22n+uH217i4d+sMshxhpzNj9AlHmDD+e/kLIceIUSaR
	 yHNL9Gujk8GBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611015327.12108-2-yangtiezhu@loongson.cn>
References: <20260611015327.12108-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 02:08:19 +0000
Message-Id: <20260611020820.1F18B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] In 32-bit kernels, the `$tp` (current task pointer) holds a biased=
 pointer during `__switch_to()`, exposing the kernel to memory corruption o=
r crashes if a synchronous exception occurs.
- [High] Missing `try_get_task_stack()` in `show_stacktrace()` allows a use=
-after-free read of kernel stack memory, causing an information leak.
--

commit a68f9b2fc34ae06149cefb44ef7146643d52f85f
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK

Select THREAD_INFO_IN_TASK for LoongArch to move thread_info off the
stack into task_struct. Initialize a per-CPU cpu_tasks variable, update
assembly paths to restore the $tp register from it, and adjust stack
accesses and unwinding to account for the new configuration.

> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switc=
h.S
> index f377d8f5c51a6..d6e0d05d6fd39 100644
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S

[ ... ]

> @@ -33,11 +33,12 @@ SYM_FUNC_START(__switch_to)
>  	LONG_SPTR	t8, t7, 0
>  #endif
> =20
> -	move	tp, a2
> +	move		tp, a1
>  	cpu_restore_nonscratch a1
> =20
> -	li.w		t0, _THREAD_SIZE
> -	PTR_ADD		t0, t0, tp
> +	LONG_LPTR	t0, a1, (TASK_STACK - TASK_STRUCT_OFFSET)
> +	PTR_LI		t1, _THREAD_SIZE
> +	PTR_ADD		t0, t0, t1
>  	set_saved_sp	t0, t1, t2
> =20
>  	LONG_LPTR	t1, a1, (THREAD_CSRPRMD - TASK_STRUCT_OFFSET)
> @@ -45,6 +46,7 @@ SYM_FUNC_START(__switch_to)
> =20
>  #ifdef CONFIG_32BIT
>  	PTR_ADDI	a0, a0, -TASK_STRUCT_OFFSET
> +	PTR_ADDI	tp, tp, -TASK_STRUCT_OFFSET

[Severity: High]
Could the delayed removal of the bias from the thread pointer cause
issues if a synchronous exception occurs?

For 32-bit kernels, a1 is biased by TASK_STRUCT_OFFSET at the start
of __switch_to(). The code copies this biased pointer directly into tp
and only removes the bias at the end of the function.

While local interrupts are disabled during this window, synchronous
exceptions such as hardware data watchpoints might still trigger. If
do_watch() executes during this window, it would use the biased tp
(pointing to next_task + 2000), potentially causing out-of-bounds
memory accesses or kernel panics.

>  #endif
>  	jr	ra
>  SYM_FUNC_END(__switch_to)

> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index 5d49b742e3bf6..7e4206da4876b 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -90,6 +90,9 @@ static void show_backtrace(struct task_struct *task, co=
nst struct pt_regs *regs,
>  	if (!task)
>  		task =3D current;
> =20
> +	if (!try_get_task_stack(task))
> +		return;
> +

[Severity: High]
Is there a similar use-after-free risk in show_stacktrace() when
reading from the stack pointer?

While try_get_task_stack() correctly protects show_backtrace(),
show_stacktrace() appears to read directly from the task's stack
pointer via __get_addr() without acquiring a reference.

With THREAD_INFO_IN_TASK enabled, the stack can be freed before the
task_struct. If show_stacktrace() is called on an exiting task
(for example, via SysRq-T iterating over all tasks), could it read
from a freed and reallocated stack, leaking memory contents?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611015327.1210=
8-1-yangtiezhu@loongson.cn?part=3D1
