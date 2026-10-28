Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149731;
	b=YNfl70NxeJ/HmpxBWCn/1AdYhkvE35TBYU0K6ize55miW3Bjrq4M6tPoedkyKX0KDTZY
	 xMQ5uD8DGsXHQt3SLSo9xvF7WzV3SdXBWih1hwhWPNQN6OtPJr4AWGWmlPruJ0XPAi2ns
	 v4G4bSUbSu2yXhUM7xzpgRV0TCrkYDU2C9L2sSyzivEgY1DAXqdq6eLkBhWeOkxbxUFDJ
	 GEpXNwfOIw808sbfF3bm/CEf5vB7FX3mi1CsJWd6XL/+rFYHNzt1Dzdb6yEYJw8qqEM6R
	 GeesZY6mU67xCyC2piNHvUZ8oGXEPxJvcsAroSqI2/39ARfRwjuwrzPfJCiOmHWQMWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149731;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sqLa92RWf572fIfdy7hSe8FrupuKX6AcDIL3TEONmjI=;
	b=K6CV/VmZ5In7oGKSxOTAUkwtZPry7/W89NlEWAUhAbEyrqRK4GepihXp/UxwAZ8NWqof
	 Tg7WhBFk3khHcwQBZlgidFt2goHt5b2zNTceMp6IPRE9byOheE/VRpPRpFtS/Vc1ggy17
	 xKIS3ps/sp8mmOposbKH2pcaAVtNsqbiEG2T0G/5qYias5KgZSrvZfRI/T8CbSI/ONLC8
	 bPWrIWklZJv5gVteRERT1JCbao8c286rCQ0petRKrMWjCuilV3yebrtXY82qaUV9LkGMy
	 pTi68f+Hr/Z2mmUKkckZ/Lck5Y9XJJsgEMHaPqZ/X+6GgvJ8TE2la9VTY4MGSRxKmmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQQmsjzQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A76606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQQmsjzQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992B01F01825;
	Wed, 28 Oct 2026 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793149730;
	bh=sqLa92RWf572fIfdy7hSe8FrupuKX6AcDIL3TEONmjI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LQQmsjzQ/W8PTdGBjTS8+OP/tJnsS1tY7mEVCKK42kUpuM/E3QAk83mNCy1/w8tz6
	 T+o12AHUge1AYylcrvwuLumAU4kF3cW76f6XgZxl0vq2vRdUzt6qXbVZjqqK08Po8m
	 Xw890xUKLkkOEM7/gdfq3CJ0n2a5kUDmD20nRv25GK3x+syQhdDLdUVeNTdfT6mGgj
	 wAcbGHxE4CBxMx7wAwPrtTAHoQkbEFjgxXAak1FRicmfJKb+E1LtL41AkhZoyqQT2V
	 +JwqZMmFJR8ISxPL2q/tzmz4Zxz+Dw3AXbCndVg4wWmpcbYSwivxvJXzpGi707kaZB
	 xRSZ4LweQ/ZWQ==
Message-ID: <sashiko-outbox-187303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v1 07/11] bpf: Let the callback of
 bpf_find_vma unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <9b98417904ec1b27a1b6e2d6a37b897fe2494073.1793147364.git.memxor@gmail.com>
References: <cover.1793147364.git.memxor@gmail.com>
 <9b98417904ec1b27a1b6e2d6a37b897fe2494073.1793147364.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:08:50 +0000
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
- [High] bpf: bpf_find_vma() unwound pad unlocks mmap_lock with IRQs disabl=
ed
- [High] bpf: vma pointer escapes bpf_find_vma() lock scope via r0 on unwin=
d_exit
--

commit d84887aac74ddde9372c2538e6e860df21d923db
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Let the callback of bpf_find_vma unwind

This commit adds an unwind landing pad to bpf_find_vma() that releases the =
RCU
read lock, unlocks mmap_lock, drops any foreign mm reference, and returns t=
he
callback's r0 when the callback leaves via unwind_exit.

> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 2ee7b3b3c10be..ae67c97fe845e 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c

[ ... ]

> @@ -827,6 +828,20 @@ BPF_CALL_5(bpf_find_vma, struct task_struct *, task,=
 u64, start,
>  		mmput_async(mm);
>  #endif
>  	return ret;
> +
> +unwound:
> +	/*
> +	 * The callback left with unwind_exit, under the mmap lock and in the
> +	 * RCU section. The way out is the same as after a return.
> +	 */
> +	rcu_read_unlock();
> +	bpf_mmap_unlock_mm(work, mm);
> +#ifdef CONFIG_MMU
> +	if (mmput_needed)
> +		mmput_async(mm);
> +#endif

[Severity: High]
Can the unwound pad end up calling mmap_read_unlock() and mmput_async() with
hardware interrupts disabled?

When bpf_find_vma() is entered with interrupts enabled for a foreign task, =
the
irqs_disabled() check passes, mmput_needed is set to true, and
bpf_mmap_unlock_guard_get() returns NULL because !irqs_disabled():

kernel/bpf/mmap_unlock_work.h:bpf_mmap_unlock_guard_get() {
	struct mmap_unlock_irq_work *work;

	if (!irqs_disabled())
		return NULL;
    ...
}

Inside the callback, callback_ctx (R3) can point to a stack slot in the
caller's frame. If the callback calls bpf_local_irq_save() on that caller
stack slot and then executes unwind_exit, process_bpf_exit_full() calls
check_resource_leak() with check_lock set to false because curframe > 0:

kernel/bpf/verifier.c:process_bpf_exit_full() {
	int err =3D check_resource_leak(env, exception_exit,
				      exception_exit || !env->cur_state->curframe,
				      exception_exit ? "bpf_throw" :
				      "BPF_EXIT instruction in main prog");
    ...
}

Unlike a normal callback return, unwind_exit sets state->unwound =3D true in
prepare_func_exit(), so push_callback_call() returns 0 on revisit without
verifying a second callback round and jumps via unwind_goto to the caller's
pad where bpf_local_irq_restore() restores the caller's stack slot.

At runtime, execution enters the unwound label in bpf_find_vma() with hardw=
are
interrupts disabled while work is NULL and mmput_needed is true.
bpf_mmap_unlock_mm(NULL, mm) then calls mmap_read_unlock(mm) directly with
IRQs disabled instead of deferring via irq_work, and mmput_async(mm) is also
called with IRQs disabled, risking a deadlock on rq_lock during reader wake=
up
and triggering an invalid wait context under CONFIG_PREEMPT_RT.

> +	bpf_unwind_leave();
> +	return r0;
>  }

[Severity: High]
What prevents the callback from escaping the vma pointer (or pointers walked
from it, such as vma->vm_file, &vma->vm_file->f_path, or
vma->vm_file->f_inode) in r0 via unwind_exit after mmap_lock, rcu_read_lock=
(),
and the foreign mm reference have been dropped?

In set_find_vma_callback_state(), R2 (struct vm_area_struct *vma) is marked=
 as
a plain PTR_TO_BTF_ID:

kernel/bpf/verifier.c:set_find_vma_callback_state() {
    ...
	callee->regs[BPF_REG_2].type =3D PTR_TO_BTF_ID;
	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
	callee->regs[BPF_REG_2].btf =3D  btf_vmlinux;
	callee->regs[BPF_REG_2].btf_id =3D btf_tracing_ids[BTF_TRACING_TYPE_VMA];
    ...
}

When the callback leaves via unwind_exit, prepare_func_exit() skips the
SCALAR_VALUE check on R0 and copies callee->regs[BPF_REG_0] into
caller->regs[BPF_REG_0]:

kernel/bpf/verifier.c:prepare_func_exit() {
    ...
	if (callee->in_callback_fn && !unwinds) {
		if (r0->type !=3D SCALAR_VALUE) {
			verbose(env, "R0 not a scalar value\n");
			return -EACCES;
		}
    ...
	} else {
		for (i =3D 0; i < nregs; i++) {
			u32 regno =3D ret_regs[i];

			bpf_diag_mod_begin(env, &caller->regs[regno], &callee->regs[regno],
					   BPF_DIAG_MOD_WRITE);
			caller->regs[regno] =3D callee->regs[regno];
			bpf_diag_mod_end(env);
		}
	}
    ...
}

Once the unwound pad in bpf_find_vma() runs rcu_read_unlock(),
bpf_mmap_unlock_mm(work, mm), and mmput_async(mm), the caller's unwind pad
receives the plain PTR_TO_BTF_ID in R0 outside the lock and RCU scope. If t=
he
VMA and its backing file or inode are concurrently unmapped and freed, pass=
ing
that dangling R0 pointer to helpers accepting ARG_PTR_TO_BTF_ID (such as
bpf_ima_file_hash(), bpf_ima_inode_hash(), bpf_d_path(), or
bpf_inode_storage_get()) can trigger a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793147364.gi=
t.memxor@gmail.com?part=3D7
