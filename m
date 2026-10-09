Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A9336B910
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530773; cv=none; b=Y+0Wb59hLGcufIPIXYx4+3POSiisc8hhyQ4XkpGniTotzioNozbIbym5Jp29c2AK+5mTN+hhVVOxi+KumT8RPj/PG6FpSj1mNzzCfCLSPmYiDl4gvsbD+nv3X6T/6W9S/Er+bmuiJq5ID3ywxb8mkeULlFiDDVxHsLE08S8VKfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530773; c=relaxed/simple;
	bh=x/8sLxLxTmQROIfViL+Y4+aVHzJSyBM/xzKtw6fHwLo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VqQSHlTeU02l3TSNLEi729NEpsOvXVHQvZZS7VrQjObnkPTWitOvZc+ceQv+TPLrtVI/1HwkjkcipVTKykR8cICiZgHX5DFghw88xNdOXpF91VAygSh2gXp7togINPtmab2F0zcSKd3qRoJyHt9O4IU+5tbU+z8acCmj17I5gpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUPdx7pF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUPdx7pF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA34A1F000FF;
	Fri,  9 Oct 2026 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791530772;
	bh=H8xd8J5oLWOvNCLONCl8MfyY0ixYtuk2KCrmjlGGFC0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AUPdx7pFAcgPgEwxJUmGrG9tENMCUsLkDCecGjCEvGpvqMYg1JDQA7D8fOQJr3rSX
	 URjvka4cCvgvBfK/gi5FGuG+mscXxb7bb4/YKdiQStToxX9HfpsVEWleXCJq0CAzAK
	 Vc0AeVPcWXL1LT8gjsysxBItJMFCzPzteUYmhoQFmKCNuXTaYxjl+Hu8NuE9EKHNZ5
	 EAAsCFXSYBjdv1zE+qt5SY8tYXJQqIH5xB+tUm/7LdBpRgxwIbmEagWvseM2DO5Ds5
	 f2eRYw1wuh9WNGI9Eh7EPLmAqQT+O4FOXE7AKaLQs9LRK5ZWaHAlDigi6YFmY8KZiW
	 xHfvXuKdRJQNw==
Content-Type: multipart/mixed; boundary="===============0960394706747767756=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63a98d2d85f35e452858e2313b1c36b9d71dc124b0a9aa0f55ac67f382551818@mail.kernel.org>
In-Reply-To: <20261009064216.1239645-1-yonghong.song@linux.dev>
References: <20261009064216.1239645-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 2/5] bpf: Keep the BPF calling convention for a trampoline on a BPF function
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 07:26:10 +0000 (UTC)

--===============0960394706747767756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep the BPF calling convention for a trampoline on a BPF function

TL;DR: On arm64, the identity slot mapping for BPF targets may split a 16-byte
argument across x7 and the stack; fexit/fentry could then read x8 or
uninitialised stack, corrupting the traced function's values.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c

[ ... ]

> @@ -3342,6 +3342,18 @@ u32 bpf_jit_place_args(const struct bpf_jit_arg_abi *abi,
>  	u32 i, k, nslots, slot = 0, nregs_used = 0, stack_off = 0;
>  	bool on_stack = false;
>
> +	/*
> +	 * A BPF function is called by BPF code, which passes slot N where
> +	 * the kernel convention passes its Nth eightbyte, whatever the
> +	 * arguments: no hole, no split refused and no register backfilled.
> +	 */
> +	if (fm->bpf_tgt_prog) {
> +		for (i = 0; i < fm->nr_args; i++)
> +			for (k = btf_func_model_arg_slots(fm, i); k > 0; k--, slot++)
> +				pos_of_slot[slot] = slot;
> +		return slot;
> +	}
> +

Can this identity mapping split one 16-byte argument across the last
register and the stack on arm64, which is the only trampoline calling
bpf_jit_place_args() at this commit?

Before this patch, arm64_arg_abi has no split_at_boundary, so every slot of
an argument landed either in x0-x7 or on the stack.  calc_arg_aux() relies
on that and only checks the first slot of each argument:

    for (i = 0, slot = 0; i < m->nr_args; i++) {
        slots = (m->arg_size[i] + 7) / 8;
        if (a64_arg_on_stack(a->pos_of_slot[slot])) /* passed through register ? */
            break;
        slot += slots;
    }

save_args() then uses each pos_of_slot value of such an "in register"
argument as a register number:

    reg = a->pos_of_slot[slot++];
    if (for_call_origin) {
        emit(A64_LDR64I(reg, A64_SP, bargs_off), ctx);
    ...
    } else {
        emit(A64_STR64I(reg, A64_SP, bargs_off), ctx);
    }

With the identity mapping, a 16-byte argument at BPF slot 7 gets
pos_of_slot = {7, 8}.  This looks reachable: a static subprog can have up
to 12 argument slots (btf_check_arg_slots(), and
bpf_jit_supports_stack_args() is true on arm64), and btf_prepare_func_args()
accepts scalar-only structs up to 16 bytes.  The selftest added later in
this series (e5dd7e2f7244) has such a function:

    static __noinline __u64 callee_stack(__u64 a, __u64 b, __u64 c, __u64 d,
                                         __u64 e, __u64 f, __u64 g,
                                         struct int128_arg h, __u64 i)

The arm64 JIT passes h.lo in x7 (stack_arg_reg[2]) and h.hi at [SP+0]
(emit_stack_arg_store(), idx 3).  calc_arg_aux() then returns
args_in_regs = 8, regs_for_args = 9, bstack_for_args = 8 and
ostack_for_args = 16, so:

- fentry: save_args() stores A64_R(8) into ctx[8].  On arm64, x8 is
  BPF_REG_0 of the calling BPF code (bpf2a64[BPF_REG_0] = A64_R(8)), not
  h.hi, which is still at FP + 32 + 0.

- fexit (BPF_TRAMP_F_CALL_ORIG): save_args(..., true, ...) loads the saved
  value into x8 and never writes oargs_off + 0.  The original function then
  reads h.hi from uninitialised trampoline stack.  If the split argument is
  the last one, bstack_for_args and ostack_for_args are both 0, and the
  function reads [SP+0] of the trampoline frame, which is the
  bpf_tramp_run_ctx.

Attaching fexit would then change the values the traced BPF function
computes with, and what it returns.

The new comment says the BPF convention has "no split refused", and the x86
follow-up f5df67b558e5 ("bpf, x86: Place trampoline arguments by the x86-64
calling convention") handles a split per slot for x86.  But no commit in the
range updates arch/arm64/net/bpf_jit_comp.c.  The int128_tgt_prog selftest
in e5dd7e2f7244 also runs on __aarch64__, where it would expect ctx[8] == 9
but read x8.

Should calc_arg_aux(), save_args() and restore_args() on arm64 classify and
read each slot by its own position (register vs. FP + 32 +
a64_arg_stack_off()), the way the x86 follow-up does, so that a split
16-byte argument works?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37897160282
--===============0960394706747767756==--
