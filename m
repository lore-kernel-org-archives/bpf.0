Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A128C037
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292163; cv=none; b=se9CVFLGOJeTjFB97WeL60rzLJEyKX8NDun9MVs4Q43NE3sxgcj5pM7oxdl9CjJIBvPsktNhNTuTF2NjdgPwN1jO9zKKD6t+dVnoBIBeXY7ZlF9gLU9DhfguK1lg5xTDWyY+1U+lpXExnsiu9IJqZrUy2ahpyXtaUiEMYrk/X1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292163; c=relaxed/simple;
	bh=UJ18lo+bvxWt+TSWPHYWhMXn9bN9EuK4xtcDTlKp3ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kQjBW4j4XzyKQns5wplgBYHStFVQoczWuOHz/nKLAdC9vpF4qlxKlVAml3uTfladjN197mYLeWrwkVe5BPpSKJjsNzhUk+wxzOF7iriOXJUGg5sxeiJQLngudKkfnJ/DrfuHED9n9Kh78Co5HVn0FkLXlr4mH2Y9KXCQGbAqAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNfKAjl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNfKAjl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223B1C2BCB0;
	Sat,  9 May 2026 02:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778292163;
	bh=UJ18lo+bvxWt+TSWPHYWhMXn9bN9EuK4xtcDTlKp3ek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bNfKAjl42LF5+GCkKA647qLnuFq4wQC9uZHTfgmJeUISuyjlMyVPgmMb4AuVmfjBn
	 zimTmLUt5Vzi0mGPHo726R+fLXGFpKD+LzsigEnEMrbbq4kfkcFlmprFt/XtGo6e90
	 4f2TQ0ZHRCcGMOzW0b2AUjngKXF8/JVE5TxwDrcVt2N1HutHdSCHEh4NgvEeCrkE9d
	 pnu992D9SrP+WYNqXNlAqYnQ/S7/YuXcVQTg7Ad4nUoXBX2TK6w5Vw6wStL8+9lbMK
	 lDPPr+qrXjzoUxoYiOAuUgXZ6tkLD+3M1f0hXxlPGp/yZOjyOqXQDhF4MZNw3Lqymy
	 lr1at1IsixqGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5
 optimization
Reply-To: sashiko@lists.linux.dev
To: "Andrii Nakryiko" <andrii@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260509003146.976844-1-andrii@kernel.org>
References: <20260509003146.976844-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 02:02:42 +0000
Message-Id: <20260509020243.223B1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] `resolve_uprobe_addr()` unconditionally uses `current->mm`, ca=
using `is_optimized()` to fail when called from tracer context, which leads=
 to target instruction stream corruption and potential kernel panics.
- [High] Exhausting a process's trampoline page slots permanently disables =
nop5 optimization for that uprobe across the entire system.
--

commit 2c63c19710be8b050bc0e126d84e52c24209e062
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Sat May 9 00:30:56 2026 +0000

uprobes/x86: Fix red zone clobbering in nop5 optimization

The x86 uprobe nop5 optimization currently replaces a 5-byte NOP at the
probe site with a CALL into a uprobe trampoline. This commit changes the
optimization to use JMP instead, introducing a trampoline page with slots
to handle register state saving and jumping to the syscall.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index ebb1baf1eb1d0..7e1f14200bbbf 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c

[ ... ]

> @@ -761,147 +785,153 @@ void arch_uprobe_clear_state(struct mm_struct *mm)
[ ... ]
> +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *probe_a=
ddr)
>  {
> -	struct vm_area_struct *vma =3D vma_lookup(current->mm, ip);
> +	struct uprobes_state *state =3D &current->mm->uprobes_state;

Can this cause a NULL pointer dereference or instruction corruption when
executed outside the target task's context?

resolve_uprobe_addr() unconditionally uses current->mm. However, it is
called by __is_optimized() via is_optimized() during uprobe registration
and unregistration.

If a tracer closes a BPF link file descriptor, triggering uprobe_unregister=
()
in the tracer's context, current->mm will point to the tracer rather than t=
he
target. This causes resolve_uprobe_addr() to fail, making is_optimized()
return false. As a result, set_orig_insn() might write only 1 byte over
the 5-byte JMP instruction, leaving 4 garbage bytes in the target's
instruction stream.

Furthermore, if unregistration runs from a kernel workqueue, current->mm
is NULL, and dereferencing current->mm->uprobes_state will cause a kernel
panic.

Could we pass the correct mm struct down from is_optimized() to
resolve_uprobe_addr() instead of relying on current->mm?

[ ... ]

> @@ -1113,8 +1149,9 @@ static int __arch_uprobe_optimize(struct arch_uprob=
e *auprobe, struct mm_struct
>  {
>  	struct uprobe_trampoline *tramp;
>  	struct vm_area_struct *vma;
> +	unsigned long slot_vaddr;
>  	bool new =3D false;
> -	int err =3D 0;
> +	int slot, err;
> =20
>  	vma =3D find_vma(mm, vaddr);
>  	if (!vma)
> @@ -1122,8 +1159,17 @@ static int __arch_uprobe_optimize(struct arch_upro=
be *auprobe, struct mm_struct
>  	tramp =3D get_uprobe_trampoline(vaddr, &new);
>  	if (!tramp)
>  		return -EINVAL;
> -	err =3D swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
> -	if (WARN_ON_ONCE(err) && new)
> +
> +	slot =3D tramp_alloc_slot(tramp, vaddr);
> +	if (slot < 0) {
> +		if (new)
> +			destroy_uprobe_trampoline(tramp);
> +		return slot;
> +	}

If a process exhausts its trampoline page slots, will this permanently
disable the nop5 optimization for this uprobe across the entire system?

If get_uprobe_trampoline() returns a reachable trampoline that is completely
full (all 256 slots used), tramp_alloc_slot() returns -ENOSPC. This error
propagates up to arch_uprobe_optimize(), which handles failures by setting
the ARCH_UPROBE_FLAG_OPTIMIZE_FAIL bit on auprobe->flags.

Since struct arch_uprobe is shared across all processes tracing the same
inode and offset, hitting the 256-slot limit in any single process seems
to permanently blacklist the probe from being optimized system-wide for
all other processes, even if those processes have completely empty
trampolines.

Should get_uprobe_trampoline() also check if the trampoline has available
slots before returning it, or can the failure be handled without setting
the global failure flag?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509003146.9768=
44-1-andrii@kernel.org?part=3D1
