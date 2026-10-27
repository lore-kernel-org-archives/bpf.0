Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130501;
	b=duOa/YqZTlGUjKoG3Eh4GRwUvUiFrpG1ew83HXwjsFNotcYssJnpailWi5nQisr7ga0U
	 jcfKVAFBblhfqiWpkpfIB6e6ex+JxJ6E3mhp2kkqSWFlWne0xyV99KiKc8lpSls0oJGV/
	 1/H/teKi71fzx1j2h+NSky8tzPHRY4WrOW/iMsFZFWMYcBI0DlaJkQsCsdDpSEceDggyH
	 LhSoVB3Cc2l44PZlU4pjhjADTqfVcqYdbUqT3UGd6zN7G6E39vbNy6s1D7js1F7IutHPD
	 lEB70vTB62cQsT8Q+59JuCfcShvi3d9kVAJWbkJSGIrtGRSnJ7JsSDf5DSRO6XZTeRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130501;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=aBRHu3eWVCfnywu+K9m9Cj2GvHZ0qjYnDZh9bp4S2lU=;
	b=VZOctjp8DVodkMrGcm1OfZbDeH4zMOsyuX7xG3FNLvaOaZ1966jyYKwkTrZfHndZtct0
	 1IB+NBFY9DcPyblL/Z8kgcEj/2DZpbQ6NqPKV7QIG6NUeLGv7b10nHUyfyzLiAWeU+wmJ
	 ybwUL0G/YP8D6dbFJBuew1yL2huumTCBZBMHGm2R9Pcml+cq8rAK0sB2MXqR4WS3x1sxm
	 yJivhBpA/saUN2NBiIrVt6JyQUjad3guC/5qPL0rasuw3bwJ68QKn0d0cR2DRe6kFNm3p
	 pnl+lzp8OLWlH35CxoGcmJXm36foNjGWELJhoUcZgPFkTBp2+17ZeVQ2YDv1SLR00ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9qz+9qo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FB606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9qz+9qo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340731F01829;
	Tue, 27 Oct 2026 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793130500;
	bh=aBRHu3eWVCfnywu+K9m9Cj2GvHZ0qjYnDZh9bp4S2lU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=S9qz+9qoA9CvX6/jfxNum2SuslyB0rYNTQyLfhdoaLXlG8kYQL5VWwMWiSngbNjgZ
	 GNrD4DAh3LJBF4ErL4gC0fq7oSO91nci3t3/Ar/YyOCGGQ/RVB+VUAyEllqy+SKg89
	 fGUXEpg95t2vI6HLxQP+V68IKZ7mxdDSFNaNsGNeFpIXbFKzKV5vxRstCmZ0xYe9UI
	 B//DJdvoOeB55gjeXb2XxFzcmIVRycA44t9ceWa0Vudxj32rz6zZWV2gt8vFrECoy8
	 B2dRMV7XvqFT9BK5zQ1BRVP4GiTpnlMU22xK3P33bCZECJhtw11dQb2ofc+jZ207uV
	 nOo9HbBDkRWmA==
Content-Type: multipart/mixed; boundary="===============9046954964654895513=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c889c8567595aadae63d644145f1dca5d1e8135d0aea98d82fb7fa1f2ba5953d@mail.kernel.org>
In-Reply-To: <20261027190314.1440199-19-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-19-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf 18/19] bpf: Keep stack arguments in arch_bpf_timed_may_goto()
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 19:48:20 +0000 (UTC)

--===============9046954964654895513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep stack arguments in arch_bpf_timed_may_goto()

TL;DR: The fix covers may_goto, but LD_ABS/LD_IND may have the same flaw: they
call C helpers that can clobber stack-argument registers while the verifier
trusts them. Should check_ld_abs() handle it too?

> bpf: Keep stack arguments in arch_bpf_timed_may_goto()
>
> The JITs pass the first stack arguments of a call in registers:
>
>   x86-64    r9       argument 6
>   arm64     x5-x7    arguments 6-8
>   riscv64   a5-a7    arguments 6-8
>
> '*(u64 *)(r11 - 8) = rX' writes such a register in the caller.
> 'rX = *(u64 *)(r11 + 8)' reads it in the callee. A call changes these
> registers. Thus the verifier accepts no call between the write and the call
> of the callee, and no call in the callee before the read.
>
> may_goto is not a call for the verifier. But one time in 65535 iterations
> it calls arch_bpf_timed_may_goto(), and this function calls C code. It
> saves R0-R5 only.
>
>        *(u64 *)(r11 - 8) = 0      ; the verifier: argument 6 is 0
>        call sub
>   sub:
>     1: may_goto 2f                ; C code changes r9
>        goto 1b
>     2: r2 = *(u64 *)(r11 + 8)     ; r2 is a kernel address
>        r1 = map_value
>        r1 += r2
>        *(u64 *)(r1 + 0) = 0
>
> On x86-64 the C code changes r9 when the time of may_goto is up. With the
> hpet clocksource a look at the clock changes r9 too. The prog above crashes
> the kernel. LLVM does not emit such code: it reads stack arguments at the
> entry of a function, and it writes them immediately before the call.
>
> Save and restore these registers too. The cost is 2 insns on x86-64, 4 on
> arm64 and 6 on riscv64, one time in 65535 iterations.
>
> Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments")
> Fixes: 235b2fe772f5 ("bpf, arm64: Add JIT support for stack arguments")
> Fixes: ba754185f902 ("riscv, bpf: Add BPF stack arguments support for RV64 JIT")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The commit message says "the verifier accepts no call between the write and
the call of the callee, and no call in the callee before the read", and
treats may_goto as the instruction that is not a call for the verifier but
still reaches C code.

Is may_goto the only such case?  LD_ABS/LD_IND look like they have the same
problem, and nothing in this series covers them.

The comment above check_ld_abs() in kernel/bpf/verifier.c calls them
"wrappers of function calls", and bpf_gen_ld_abs() in net/core/filter.c
rewrites them into a real call:

    *insn++ = BPF_EMIT_CALL(bpf_skb_load_helper_8_no_cache);  /* or _16 / _32 */

But check_ld_abs() only scratches R1-R5:

    for (i = 0; i < CALLER_SAVED_REGS; i++) {
        bpf_mark_reg_not_init(env, &regs[caller_saved[i]]);
        check_reg_arg(env, caller_saved[i], DST_OP_NO_MARK);
    }

It does not set cur_func(env)->no_stack_arg_load, which the call path in
do_check() sets so that check_stack_arg_read() refuses a later r11 load.  It
also does not call invalidate_outgoing_stack_args(), which
check_helper_call(), check_kfunc_call() and check_func_call() do.

This looks reachable.  may_access_skb() allows LD_ABS in SOCKET_FILTER,
SCHED_CLS and SCHED_ACT, and a static subprog with BTF can use it through
has_ld_abs.  btf_check_arg_slots() rejects stack args only for global
functions.  So a tc program could have:

    sub(a1..a6):                  ; a6 is stack arg 6
        r6 = r1
        r0 = *(u8 *)skb[0]        ; LD_ABS -> call bpf_skb_load_helper_8_no_cache()
        r2 = *(u64 *)(r11 + 8)    ; verifier still trusts the caller's value

The same applies on the caller side:

    *(u64 *)(r11 - 8) = 0
    LD_ABS
    call sub

On x86-64, r9 is not saved around a helper call when a program has stack
args, because priv_frame_ptr is NULL in that case.  arm64 does not save
x5-x7 and riscv64 does not save a5-a7 around a helper call either.  The C
helper can change these registers, for example on the
skb_header_pointer()/skb_copy_bits() path.  That is the same kind of
verifier/runtime mismatch as in the may_goto example above.

This patch does not introduce the gap, since it goes back to the same three
Fixes: commits, and the later commits in the series do not touch
check_ld_abs() or no_stack_arg_load.

Should LD_ABS/LD_IND be handled as well, for example by setting
no_stack_arg_load and calling invalidate_outgoing_stack_args() in
check_ld_abs()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40568443226
--===============9046954964654895513==--
