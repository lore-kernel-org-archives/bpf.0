Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4E3B19D1;
	Mon,  6 Jul 2026 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783312202; cv=none; b=tf+mHbf4YmjuzHosqUfsM4sXkdzBzqMv4QOcl3VM/J+LLHhgPWkMS0f17ny2922uu3f/ZcX4NngLEz/bGkLzZnGi/7VBObVdsTsjAQS8rT0jPLg3Fmt8fdV9OaGL+4A7M7OOLhn9m6zs3nORbEsbpw3/gN+1JdpV5MzbZQkgQ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783312202; c=relaxed/simple;
	bh=8l3pjxENnPX5PxLq/aprvImypyKDHqinaWL39AMXl8Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IdpVQAanrB4/JGncwbwXI2BDNfYkVklFaCVy9pMG3GGNxXhYK+CSDYSs7Q2jwXaSvnn1TGgX9TpueYY2zguHyUiGSrMSqVQBS8JHGhgj9ijlnHBsE4IHeGGIZmATViSYAkwshRJVhD4WzwDae6CreenI3X++iy5eKTr8NJ6XVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf63MJb7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf63MJb7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9141F00A3A;
	Mon,  6 Jul 2026 04:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783312201;
	bh=6xFCMTKfHRvf2Fmx9UWjcpeh9zpKDrEMnuvUvz6cOec=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hf63MJb7B82FLCO/hswD2ghRvr7LWCdW1H0NkmdmHarnOalY0OvByGmSjtBKA0HFH
	 KjXY0nFyezgkBV+sdcLDMVk32Ezf3zPBklLhCcS8k2RAMEnHA7i6d8Pj7CG0hBJFi1
	 nnjfTPel8JZBSyF31jxZAhrwa1AKaXElqhGwvptlS9h9Fw/Ldx8/FAIj1VRzhx1qsQ
	 YmrRl/CJ4rBFRPEeVT6BFrEWz6ib/vcvmXR3odrMkyugumyYo8JHlnG7ycNzJCOSYL
	 YGCTo5c2msgjnOmYczCdknxre6q23HKISTW4aiMQT6KicUx5cRu+nMXXqVrEV5h9K3
	 9UzhxGj+Dfr6A==
Content-Type: multipart/mixed; boundary="===============6493546250624737669=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <70c1acef9c4cb9c5e5374487db3f7ab57a10946dace0845097f3cc66863a83c9@mail.kernel.org>
In-Reply-To: <20260706033906.1988-5-yangtiezhu@loongson.cn>
References: <20260706033906.1988-5-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v2 4/4] LoongArch: BPF: Implement branchless conditional move for TCC
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Jul 2026 04:30:01 +0000 (UTC)

--===============6493546250624737669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> The current implementation handles combined bpf2bpf and tail calls by
> checking at runtime whether REG_TCC holds a count or an address via a
> conditional jump (BPF_JGT against 33). This adds non-negligible branch
> prediction overhead in the hot path of tail call execution.
> To eliminate this runtime conditional branch in prologue, refactor the
> logic of prepare_bpf_tail_call_cnt() with a branchless conditional move
> mechanism using unsigned comparison and mask instructions.
> When the program is a main program (is_main_prog), the branchless logic
> classifies and blends the incoming REG_TCC based on its physical content
> according to three possible entrance statuses:
> 1) Initial Entry (Scalar): Enter via a standard event, where REG_TCC is
>    initialized to a pure scalar 0.
> 2) Inherited Entry (Scalar): Enter via a flat main-to-main tail call,
>    where REG_TCC carries an accumulated scalar count (1 to 33) reloaded
>    from the prior stack frame.
> 3) Inherited Entry (Pointer): Enter via a tail call from a subprogram,
>    where REG_TCC inherits and carries a massive kernel pointer address
>    reloaded from the prior stack frame.
> To handle these cases seamlessly without branching:
> - sltui identifies the type of REG_TCC. For cases 1 and 2 (scalar count),
>   it sets the temporary register T8 to 1. For case 3 (kernel pointer), it
>   sets T8 to 0.
> - maskeqz handles the local stack pointer (T7). If T8 == 1, it keeps T7
>   intact. If T8 == 0, it clears T7 to 0.
> - masknez handles the incoming REG_TCC to prevent register pollution.
>   If T8 == 1, it clears REG_TCC to 0 (erasing 1~33 scalars). If T8 == 0,
>   it keeps the massive kernel pointer intact.
> - or combines the results. The scalar cases yield a clean local stack
>   pointer by evaluating REG_TCC (0) | T7, while the pointer case leaves
>   the inherited global pointer intact by evaluating REG_TCC | T7 (0).
> For subprograms, the logic directly backs up the verified TCC pointer
> inherited via REG_TCC into its own local "tcc" slot, ensuring the global
> counter reference remains safely propagated across function frames.
> Finally, the finalized REG_TCC pointer is unconditionally backed up into
> the adjacent "tcc_ptr" slot, completing the expected dual-slot stack
> layout identically across all entry paths.
> This optimization refactors the inner logic of the helper function,
> unifies the offset decrement at the function entry, and uses safe
> internal temporary registers (T7 and T8) to prevent any JIT register
> conflicts, completely removing all runtime branching from the prologue
> hot path.
> When exposed to complex bpf2bpf + tailcall interleaved control flows,
> where inputs shuffle dynamically between a scalar count (0 to 33) and
> a massive kernel pointer address, clear improvements are demonstrated.
> Furthermore, the optimization significantly eliminated uncertainty in
> the execution path, making the performance more stable and predictable.
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This isn't a bug, but the closing lines:

> When exposed to complex bpf2bpf + tailcall interleaved control flows,
> where inputs shuffle dynamically between a scalar count (0 to 33) and
> a massive kernel pointer address, clear improvements are demonstrated.
> Furthermore, the optimization significantly eliminated uncertainty in
> the execution path, making the performance more stable and predictable.

state performance improvements without any number or benchmark behind them,
and the rationale (removing the runtime branch from the prologue hot path)
is already covered earlier in the message.  Could these closing claims be
backed by a concrete measurement, or trimmed?

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 8d6738103f59..b5419cafc984 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -52,50 +52,56 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)

[ ... ]

> +		/*
> +		 * Branchless classification and blending:
> +		 *
> +		 * In combined bpf2bpf and tailcall scenarios, REG_TCC can carry
> +		 * either a scalar count (0 to 33) or an inherited kernel pointer address.
> +		 *
> +		 * Entrance status for a main program based on REG_TCC physical content:
> +		 * 1) Initial Entry (Scalar): Enter via a standard event, where REG_TCC
> +		 *    is initialized to a pure scalar 0.
> +		 * 2) Inherited Entry (Scalar): Enter via a flat main-to-main tail call,
> +		 *    where REG_TCC carries an accumulated scalar count (1 to 33) reloaded
> +		 *    from the prior stack frame.
> +		 * 3) Inherited Entry (Pointer): Enter via a tail call from a subprogram,
> +		 *    where REG_TCC inherits and carries a massive kernel pointer address
> +		 *    reloaded from the prior stack frame.
> +		 *
> +		 * sltui:   Identify the type of REG_TCC.
> +		 *          If REG_TCC < MAX_TAIL_CALL_CNT + 1 (scalar 0~33), sets T8 = 1.
> +		 *          If REG_TCC >= MAX_TAIL_CALL_CNT + 1 (kernel pointer), sets T8 = 0.
> +		 *
> +		 * maskeqz: Handle the local stack pointer (T7).
> +		 *          If T8 == 1, keeps T7 intact.
> +		 *          If T8 == 0, clears T7 to 0.
> +		 *
> +		 * masknez: Handle the incoming REG_TCC to prevent register pollution.
> +		 *          If T8 == 1, clears REG_TCC to 0 (erasing 1~33 scalars).
> +		 *          If T8 == 0, keeps the massive kernel pointer intact.
> +		 *
> +		 * or:      Combine the results.
> +		 *          Scalar Case:  REG_TCC = 0 | T7       -> Clean local stack pointer.
> +		 *          Pointer Case: REG_TCC = REG_TCC | 0  -> Clean inherited global pointer.
>  		 */
> +		emit_insn(ctx, sltui, LOONGARCH_GPR_T8, REG_TCC, MAX_TAIL_CALL_CNT + 1);
> +		emit_insn(ctx, maskeqz, LOONGARCH_GPR_T7, LOONGARCH_GPR_T7, LOONGARCH_GPR_T8);
> +		emit_insn(ctx, masknez, REG_TCC, REG_TCC, LOONGARCH_GPR_T8);
> +		emit_insn(ctx, or, REG_TCC, REG_TCC, LOONGARCH_GPR_T7);

This isn't a bug, but the comment narrates each of the four emitted
instructions line by line, and the sltui/maskeqz/masknez/or walk-through
largely restates the entrance-status text already present in the commit
message as well as the code right below it.  Could this be condensed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28766636714
--===============6493546250624737669==--
