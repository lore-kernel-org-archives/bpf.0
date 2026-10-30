Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343186;
	b=rHFF6Ki6YMCjE+Ag/Rg/h6ZatWDEm8Uw2/LlYFlduvt9ai/1anuaoVMYebUlJLfeedgr
	 AspaHYDexYl0oSnSVrPICHIyYz2wlvAkj3hU1IrC62AA2QvyVs60ch2zTa8sToNYfDclG
	 VoXriHZejp0qUP71QfiUrFQSEVpvjssqzTp0rb0FHowbyjbVpqkxCTiX/rjdtTZ2B8zoX
	 IAfTNk2PJOwFize/1MdpGNt7GiyXd0hdp8Bi8ChZnnZllQQMeRRyuqC6kgX45fKQWTc5y
	 qpzGk1NS/ENo0R/JBRpDX526JpqwY55J1FRatY+etAGWq5G8qV2LUunsc2YdRm26PBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343186;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G86OfIfSWUYGqNlWHMufdYX05PB/nkQogV9X6l2QsbI=;
	b=zar6/4IhgLz9EfFeHPH8givlohZCRaMSOZfXCwCDmUNAYFlXiQNyzSnZav7Utta6zGid
	 4KMp/C4tRjRFvBNhmqQ/bPaqlLEvhfxJkRWH23I5LcnNsdl1bkPIUw2pIYCZEQAygs6/2
	 zt70vghYPgnoWrUfZlnNLwZ6KjbWpXskMg8TDF8pOGTZfiEPlgEfXzPEdgF78lT8U6v9k
	 dWCc9OZpLSS1+N4rfls3v/9krFU2VnGspUQ3QY3QBysNL86Kj0oODrvkgGjtxgj1f/pPI
	 5RE0VEsW971PReAyII/9JZ8mGR7yA8x5VCqbqngcz8zOvAlOxb6LKvMSAMJJ5q0dq0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVMaLoi5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98651606A325
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVMaLoi5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F691F0093A;
	Fri, 30 Oct 2026 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793343185;
	bh=G86OfIfSWUYGqNlWHMufdYX05PB/nkQogV9X6l2QsbI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=mVMaLoi5RJiT+MavJzI5kzj0s+mCRwjivdTvJkdk6edDTQetVLTnHgAaTpRqpZrrU
	 LNPuxboUbxISV7NEr7HBrljE4lAtjHbxSfFlqLuLfAexw09MtqZIs3yC3RRWHB1KtS
	 yq3RUuTjxojQCG5jLOzO5XAyWtLlx89YKrI4/Ymlsqn/8Ulkjq1j+th4eDrpL9xsV5
	 UJfe6jVU5cFeh/IUBCOLj9ypy9fy42U+jTBMlbljrfmRLSLH6Fieq250x1vVd9i6xH
	 InIeSuuLWobtLzb4iLj9E84zCIn4Oj/43jnjenT7dfLl0bf8Dgd+Pafmb26QTRecsu
	 AkA8o5+YitHew==
Message-ID: <sashiko-outbox-190616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] ARM: ptrace: Fix seccomp seeing stale syscall
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, bpf@vger.kernel.org
In-Reply-To: <20261030063630.1218302-2-ruanjinjie@huawei.com>
References: <20261030063630.1218302-1-ruanjinjie@huawei.com>
 <20261030063630.1218302-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:53:04 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] ARM: ptrace: missing syscall-entry match in stopped_in_syscall_ent=
ry()
- [High] ARM: ptrace: ARM_ORIG_r0 desync in put_user_reg() via PTRACE_POKEU=
SR
- [High] ARM: ptrace: ARM_ORIG_r0 clobbered in update_syscall_orig_r0_after=
_ptrace()
--

commit 83d7d1ba6dcc0fb6cba778b5030dfb3da61a6531
Author: Jinjie Ruan <ruanjinjie@huawei.com>

ARM: ptrace: Fix seccomp seeing stale syscall arguments

This commit synchronizes ARM_ORIG_r0 with ARM_r0 after ptrace register writ=
es
when the tracee is stopped in syscall entry or SECCOMP_RET_TRACE, and updat=
es
audit_syscall_entry() to read ARM_ORIG_r0.

Link: https://lore.kernel.org/all/al98jdcleu-6tMDL@willie-the-truck/
Link: https://lkml.org/lkml/2020/9/11/1282

> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ed7a2a87a6707..6ec81e5a205e7 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -163,6 +163,42 @@ static inline long get_user_reg(struct task_struct *=
task, int offset)
>  	return task_pt_regs(task)->uregs[offset];
>  }
> =20
> +/*
> + * Is @target stopped after entering a syscall, but before it has been
> + * dispatched?  This is the same classification that
> + * ptrace_get_syscall_info_op() performs for PTRACE_GET_SYSCALL_INFO.
> + */
> +static bool stopped_in_syscall_entry(struct task_struct *target)
> +{
> +	struct kernel_siginfo *info =3D target->last_siginfo;
> +
> +	if (!info)
> +		return false;
> +
> +	if (info->si_code =3D=3D (SIGTRAP | 0x80))
> +		return target->ptrace_message =3D=3D PTRACE_EVENTMSG_SYSCALL_ENTRY;

[Severity: High]
What happens when a tracer stops a tracee at syscall entry via PTRACE_SYSCA=
LL
without enabling PTRACE_O_TRACESYSGOOD?

In include/linux/ptrace.h:ptrace_report_syscall(), bit 0x80 is only set in
si_code when PT_TRACESYSGOOD is enabled:

	signr =3D ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0),
			      message);

When PTRACE_O_TRACESYSGOOD is not set, info->si_code is plain SIGTRAP while
target->ptrace_message is PTRACE_EVENTMSG_SYSCALL_ENTRY. Checking for
info->si_code =3D=3D (SIGTRAP | 0x80) causes stopped_in_syscall_entry() to =
return
false in that case, leaving regs->ARM_ORIG_r0 unsynchronized when the tracer
updates ARM_r0.

When the tracee resumes in syscall_trace_enter(), seccomp_permit_syscall(),
trace_sys_enter(), and audit_syscall_entry() (which this patch switches from
regs->ARM_r0 to regs->ARM_ORIG_r0) will all observe the stale
regs->ARM_ORIG_r0 while invoke_syscall runs with the modified regs->ARM_r0.

Should this check (info->si_code & ~0x80) =3D=3D SIGTRAP, matching arm64's
stopped_in_syscall_entry()?

> +
> +	return info->si_code =3D=3D (SIGTRAP | (PTRACE_EVENT_SECCOMP << 8));
> +}
> +
> +static void update_syscall_orig_r0_after_ptrace(struct task_struct *targ=
et)
> +{
> +	struct pt_regs *regs =3D task_pt_regs(target);
> +
> +	/*
> +	 * ARM_r0 holds the first syscall argument only before the syscall is
> +	 * dispatched; seccomp, the syscall tracepoints and the syscall restart
> +	 * code all read that argument from ARM_ORIG_r0 instead.  At a syscall
> +	 * exit stop ARM_r0 holds the return value and must not be copied, and
> +	 * for other exceptions ARM_ORIG_r0 is set to ~0 and carries no
> +	 * meaning.
> +	 */
> +	if (!stopped_in_syscall_entry(target))
> +		return;
> +
> +	regs->ARM_ORIG_r0 =3D regs->ARM_r0;
> +}

[Severity: High]
Can update_syscall_orig_r0_after_ptrace() clobber the saved first argument
when a tracer skips a syscall?

On 32-bit ARM, skipping a syscall at a syscall-entry or PTRACE_EVENT_SECCOMP
stop sets task_thread_info(target)->abi_syscall to -1 via PTRACE_SET_SYSCALL
in arch_ptrace() or via syscall_set_nr():

	if (nr =3D=3D -1) {
		task_thread_info(task)->abi_syscall =3D -1;
		syscall_set_return_value(task, regs, -ENOSYS, 0);
		return;
	}

Once the syscall number is -1, regs->ARM_r0 holds the return value (such as
-ENOSYS or a tracer-supplied return value), while regs->ARM_ORIG_r0 preserv=
es
the original first argument. Because update_syscall_orig_r0_after_ptrace()
does not check whether syscall_get_nr(target, regs) =3D=3D -1 (unlike arm64,
which returns early when regs->syscallno =3D=3D NO_SYSCALL), any subsequent
GPR write via put_user_reg() or gpr_set() overwrites regs->ARM_ORIG_r0 with
the return value.

That corrupts the first argument reported by syscall_get_arguments() (used =
by
PTRACE_GET_SYSCALL_INFO, trace_sys_enter(), and seccomp) and
audit_syscall_entry(), breaks syscall_rollback() if a later seccomp filter
triggers SECCOMP_RET_TRAP or SECCOMP_RET_KILL_PROCESS, and causes do_signal=
()
on the __sys_trace_return_nosave -> ret_slow_syscall path to copy an inject=
ed
-ERESTART* return value into ARM_r0 as the restarted syscall's first argume=
nt.

Conversely, in arch_ptrace(), PTRACE_SET_SYSCALL does not call
update_syscall_orig_r0_after_ptrace(child) when changing abi_syscall from -1
to a valid syscall number, leaving ARM_ORIG_r0 and ARM_r0 out of sync if
syscall_set_nr() had previously set ARM_r0 to -ENOSYS.

Should update_syscall_orig_r0_after_ptrace() return early when
syscall_get_nr(target, regs) =3D=3D -1, and should PTRACE_SET_SYSCALL call
update_syscall_orig_r0_after_ptrace(child)?

> +
>  /*
>   * this routine will put a word on the processes privileged stack.
>   * the offset is how far from the base addr as stored in the THREAD.
> @@ -180,6 +216,8 @@ put_user_reg(struct task_struct *task, int offset, lo=
ng data)
> =20
>  	if (valid_user_regs(&newregs)) {
>  		regs->uregs[offset] =3D data;
> +		if (offset =3D=3D 0)
> +			update_syscall_orig_r0_after_ptrace(task);
>  		ret =3D 0;
>  	}

[Severity: High]
Could a tracer still desynchronize regs->ARM_ORIG_r0 and regs->ARM_r0 via
PTRACE_POKEUSR in put_user_reg()?

On 32-bit ARM, struct pt_regs exposes all 18 words (uregs[0..17]) to
ptrace_write_user() -> put_user_reg(), where offset 0 is ARM_r0 and offset =
17
is ARM_ORIG_r0. At the same time, invoke_syscall in
arch/arm/kernel/entry-header.S dispatches the syscall by reloading r0-r6 fr=
om
regs->ARM_r0:

	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
	ldmiacc	r1, {r0 - r6}			@ reload r0-r6

Because put_user_reg() only calls update_syscall_orig_r0_after_ptrace(task)
when offset =3D=3D 0, a tracer stopped at syscall entry or PTRACE_EVENT_SEC=
COMP
can poke offset 17 (ARM_ORIG_r0) directly (or modify
target->last_siginfo->si_code via PTRACE_SETSIGINFO before writing ARM_r0).
In that case, seccomp_permit_syscall(), trace_sys_enter(), and now
audit_syscall_entry() all inspect the value written to regs->ARM_ORIG_r0,
while invoke_syscall executes the syscall with regs->ARM_r0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030063630.1218=
302-1-ruanjinjie@huawei.com?part=3D1
