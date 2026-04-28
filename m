Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213B1DF736
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408732; cv=none; b=YIMkem3tDid37BSAFez6rqHUqothKP8FszH9nTbiCp5W/kcwgnNJ27HE4SnMIY0PZFpp8ezdXsMJ732BXvzrDnC5dHemepzsMJxKd0u3Gc4aURytPIHMjTJojj+0Q5QOlLJs6HRp3bpe5T31Ltoa68U2wzoS+7xLPc5FjXKkMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408732; c=relaxed/simple;
	bh=ITVNdG9gZIvltgKfKqF4elHNX8/p8CIuQzUMtBg9414=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dCt19PrUK+D9lZDVvNv/RS620cl2DxzJpXDdtHppKrXVR8hJtOo5QO3yz1PeMwqHgEFpSnkdCecviKDuGSwhaASPeRhbn+/G1l+EpCQwqNCiJcrwS+NO9OYZQGEFXvfv6l51QU6NeiFKc+etYXcN/vQW6JYKWa6s+RIjEXgZLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0515q2f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0515q2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5D8C2BCAF;
	Tue, 28 Apr 2026 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408731;
	bh=ITVNdG9gZIvltgKfKqF4elHNX8/p8CIuQzUMtBg9414=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=e0515q2fUSeGSUtGlBvL550h3EUPz/dVdIW27/24tsZRVKEauVe41k83Ssfy9CFTR
	 ZmWxtfAq1JA93TNz3CX3+QrqNj8FJ/RpJvpnoysZm1jJROLe3hIUDUYqlFv0B+FiSW
	 a0JCC/dzEUGCj/6Lm2chYpVV5H2GvNoRqnYRYc98XnWSAG2luSS5g4IK7L6XWbWNTa
	 wdyO5Uy1voUNDcasG8Te+tsR/wpDkEVnfhSjz9KYUhzRSS71reAG/4DhNwZl8EW3Dd
	 Ar/X6pHY2SDSyvC3h/LTvY2aUunv+mLJ7ER8FFNtiNw6Sw2cxpdE2BfkGfcbqZwJhU
	 XLRZTLB54+jnQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
Reply-To: sashiko@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428072021.7289-2-yangtiezhu@loongson.cn>
References: <20260428072021.7289-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 20:38:51 +0000
Message-Id: <20260428203851.CD5D8C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The default thread flags initialization drops `_TIF_FIXADE`, s=
ilently disabling unaligned memory access software fixups by default.
- [High] The `__switch_to` assembly function incorrectly saves the `sched_r=
a` and `sched_cfa` arguments due to a shifted parameter list, corrupting th=
e saved stack unwinding information.
- [Low] The `reg02` field added to `thread_struct` is dead code, never read=
 or restored, and left uninitialized for kernel threads.
--

commit 40aa85795dd4ee444da3115a1909cec1be7bed8d
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK

This commit selects THREAD_INFO_IN_TASK for LoongArch to move thread_info
off the stack into task_struct. It introduces a per-CPU variable __entry_ta=
sk
to store the current task_struct pointer and updates the context switch path
and exception entry to use it.

>     Additionally, add reg02 ($tp) to thread_struct and initialize it in
>     both INIT_THREAD and copy_thread() to ensure that the "current" task
>     pointer is correctly set up for the initial idle task and all future
>     child processes. While __switch_to() directly updates $tp from a1 for
>     efficiency, storing it in thread_struct ensures correct restoration
>     for new processes and in non-standard switch paths.

Is this description accurate? Looking at the code, the reg02 field does not
appear to be read during restoration. New threads restore their user tp from
pt_regs, and cpu_restore_nonscratch does not seem to restore it.=20

> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/incl=
ude/asm/processor.h
> index ce8b953f8c79..df927a4318cc 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
[ ... ]
> @@ -109,7 +109,7 @@ struct loongarch_vdso_info;
>   */
>  struct thread_struct {
>  	/* Main processor registers. */
> -	unsigned long reg01, reg03, reg22; /* ra sp fp */
> +	unsigned long reg01, reg02, reg03, reg22; /* ra tp sp fp */
>  	unsigned long reg23, reg24, reg25, reg26; /* s0-s3 */
>  	unsigned long reg27, reg28, reg29, reg30, reg31; /* s4-s8 */

Could this reg02 field be dead code? If it is never read back out of the
thread_struct, is it needed here?

> diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/incl=
ude/asm/switch_to.h
> index 5b225aff3ba2..9932429cfe17 100644
> --- a/arch/loongarch/include/asm/switch_to.h
> +++ b/arch/loongarch/include/asm/switch_to.h
[ ... ]
> @@ -23,7 +31,7 @@ struct task_struct;
>   * the context of next. Returns prev.
>   */
>  extern asmlinkage struct task_struct *__switch_to(struct task_struct *pr=
ev,
> -			struct task_struct *next, struct thread_info *next_ti,
> +			struct task_struct *next,
>  			void *sched_ra, void *sched_cfa);

When the next_ti argument is removed here, sched_ra and sched_cfa shift to=
=20
registers a2 and a3 under the LoongArch C calling convention.

Does the assembly implementation of __switch_to() in switch.S also need to =
be=20
updated? If it still reads from a3 and a4, could this corrupt the saved sta=
ck=20
unwinding information by storing the stack pointer into THREAD_SCHED_RA
instead? This might break stack unwinding for parked tasks.

> diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/in=
clude/asm/thread_info.h
> index 4d7117fcdc78..2c95a5134976 100644
> --- a/arch/loongarch/include/asm/thread_info.h
> +++ b/arch/loongarch/include/asm/thread_info.h
[ ... ]
> @@ -37,20 +35,11 @@ struct thread_info {
>   */
>  #define INIT_THREAD_INFO(tsk)			\
>  {						\
> -	.task		=3D &tsk,			\
> -	.flags		=3D _TIF_FIXADE,		\
> +	.flags		=3D 0,			\
>  	.cpu		=3D 0,			\
>  	.preempt_count	=3D INIT_PREEMPT_COUNT,	\
>  }

Does removing _TIF_FIXADE here globally disable the unaligned memory access=
=20
software fixups?=20

Since all newly created tasks inherit their initial thread info flags from=
=20
init_task, could this cause user-space applications performing unaligned=20
accesses to crash with a bus error?

> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/proc=
ess.c
> index 5505fc355e1b..71c9c6468e60 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
[ ... ]
> @@ -223,6 +226,9 @@ int copy_thread(struct task_struct *p, const struct k=
ernel_clone_args *args)
>  	if (clone_flags & CLONE_SETTLS)
>  		childregs->regs[2] =3D tls;
> =20
> +	/* Set tp to the new task structure for context switching */
> +	p->thread.reg02 =3D (unsigned long)p;
> +
>  out:
>  	ptrace_hw_copy_thread(p);

For kernel threads, copy_thread() jumps to the out label before reaching th=
is=20
initialization. Does this leave p->thread.reg02 uninitialized for kernel
threads, potentially retaining a stale task pointer from the parent process?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428072021.7289=
-1-yangtiezhu@loongson.cn?part=3D1
