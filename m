Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E52FC00D
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881678; cv=none; b=jCIlTCkZ5C0EDfn8Y87MgxUQ8EmmtJkxIPNHtOmwdCR5n0sIsSk6jteoX/FzEVY7Mi/cW+byrk+4DuMB4INhVYjAfdYCG7TvhIDscFcf3zFGGpNzp9iIu7dF1dRuLwv/11iFKTciuMNNKTi0Dk9OcqLYEdUJPI0tvQVcBex5Kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881678; c=relaxed/simple;
	bh=/b+myYYhB8jzOrjcVz6JmjvgnFszRZARbcMB/w5G2pU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UMJkEY0N9nP/Jmv4ZhBJcIMNG2KdZa8ejuXqGmQPQoCyDIl7xPLcZ0eMML9eOXfF5+rb0Wqbsc5zqR12X+E9noGExxjChd0oC+3wjTAb/gBu6UFxJywxaCq2uDyy+8ScZs94wtP/o56mfKehm7iCsyFGO5HKG/zWF/UIbOAzQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpESy+ok; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpESy+ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B7CC19423;
	Mon, 30 Mar 2026 14:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774881678;
	bh=/b+myYYhB8jzOrjcVz6JmjvgnFszRZARbcMB/w5G2pU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LpESy+okWjGORd+j/B5v4tjLLOcpp3A77bnVBRmGGUnSx/0+iuV7LmlgeorIfrBJO
	 spta8sy7qgBz6E81PmnrnArJDoqj8sVnPx8h53yeF4AWyZ87VsNBMYafg6ONMAuUCo
	 6pU1ulyaQg0glZSxvNY2E21bgvrar7qI1DAOiaGgdQpX3Q2uSMt0nYJDWPXSxSSEIA
	 LdMM98E4j31WWormnX+ieF0CzR8hGOXK2p+J3Btf5gugdHqkbIn72S5le6yhPRYcCC
	 1DJsgAV/gpKAH2P9Zccpi9JvAcQPyN3XeM4L8vhwFP7xMLois3Y8qncwk1rI8Pngq3
	 iSzSjAtiaLAZA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, eddyz87@gmail.com
Cc: ast@kernel.org, bpf@vger.kernel.org, STAR Labs SG <info@starlabs.sg>
Subject: Re: [PATCH bpf 1/2] bpf: Fix incorrect pruning due to atomic fetch
 precision tracking
In-Reply-To: <20260330132750.377862-1-daniel@iogearbox.net>
References: <20260330132750.377862-1-daniel@iogearbox.net>
Date: Mon, 30 Mar 2026 15:41:14 +0100
Message-ID: <m2o6k5z8fp.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel Borkmann <daniel@iogearbox.net> writes:

> When backtrack_insn encounters a BPF_STX instruction with BPF_ATOMIC
> and BPF_FETCH, the src register (or r0 for BPF_CMPXCHG) also acts as
> a destination, thus receiving the old value from the memory location.
>
> The current backtracking logic does not account for this. It treats
> atomic fetch operations the same as regular stores where the src
> register is only an input. This leads the backtrack_insn to fail to
> propagate precision to the stack location, which is then not marked
> as precise!
>
> Later, the verifier's path pruning can incorrectly consider two states
> equivalent when they differ in terms of stack state. Meaning, two
> branches can be treated as equivalent and thus get pruned when they
> should not be seen as such.
>
> Fix it as follows: When the fetch dst register is being tracked for
> precision, clear it and propagate precision over to the stack slot.
> This is similar to how BPF_LDX handles loads from the stack.
>
> Before:
>
>   0: (b7) r1 = 8                        ; R1=8
>   1: (7b) *(u64 *)(r10 -8) = r1         ; R1=8 R10=fp0 fp-8=8
>   2: (b7) r2 = 0                        ; R2=0
>   3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=8 R10=fp0 fp-8=mmmmmmmm
>   4: (bf) r3 = r10                      ; R3=fp0 R10=fp0
>   5: (0f) r3 += r2
>   mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
>   mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10
>   mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)
>   mark_precise: frame0: regs=r2 stack= before 2: (b7) r2 = 0
>   6: R2=8 R3=fp8
>   6: (b7) r0 = 0                        ; R0=0
>   7: (95) exit
>
> After:
>
>   0: (b7) r1 = 8                        ; R1=8
>   1: (7b) *(u64 *)(r10 -8) = r1         ; R1=8 R10=fp0 fp-8=8
>   2: (b7) r2 = 0                        ; R2=0
>   3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)          ; R2=8 R10=fp0 fp-8=mmmmmmmm
>   4: (bf) r3 = r10                      ; R3=fp0 R10=fp0
>   5: (0f) r3 += r2
>   mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
>   mark_precise: frame0: regs=r2 stack= before 4: (bf) r3 = r10
>   mark_precise: frame0: regs=r2 stack= before 3: (db) r2 = atomic64_fetch_add((u64 *)(r10 -8), r2)
>   mark_precise: frame0: regs= stack=-8 before 2: (b7) r2 = 0
>   mark_precise: frame0: regs= stack=-8 before 1: (7b) *(u64 *)(r10 -8) = r1
>   mark_precise: frame0: regs=r1 stack= before 0: (b7) r1 = 8
>   6: R2=8 R3=fp8
>   6: (b7) r0 = 0                        ; R0=0
>   7: (95) exit
>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Fixes: 5ca419f2864a ("bpf: Add BPF_FETCH field / create atomic_fetch_add instruction")
> Reported-by: STAR Labs SG <info@starlabs.sg>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Athough not related to this patch but it made me think about how the
conditional semantics of CMPXCHG could interact with precision tracking,
because the CMPXCHG could write to a stack slot or not depending on the
comparison and that slot could later be used for precision tracking. But
I found that although check_atomic_rmw() set's INSN_F_STACK_ACCESS in
the flags, it also makes the stack slot STACK_MISC, therefore
instruction reading from it will not have INSN_F_STACK_ACCESS so the
precision tracking will stop there.

This patch looks correct to me.

Reviewed-by: Puranjay Mohan <puranjay@kernel.org>


> ---
>  kernel/bpf/verifier.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f108c01ff6d0..293aa957a5ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4474,6 +4474,31 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>  			 * encountered a case of pointer subtraction.
>  			 */
>  			return -ENOTSUPP;
> +
> +		/* atomic fetch operation writes the old value into a
> +		 * register (sreg or r0) and if it was tracked for
> +		 * precision, propagate to the stack slot like we do
> +		 * in ldx.
> +		 */
> +		if (class == BPF_STX && mode == BPF_ATOMIC &&
> +		    (insn->imm & BPF_FETCH)) {
> +			u32 load_reg = insn->imm == BPF_CMPXCHG ?
> +				       BPF_REG_0 : sreg;
> +
> +			if (bt_is_reg_set(bt, load_reg)) {
> +				bt_clear_reg(bt, load_reg);
> +				/* atomic fetch from non-stack memory
> +				 * can't be further backtracked, same
> +				 * as for ldx.
> +				 */
> +				if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
> +					return 0;
> +				spi = insn_stack_access_spi(hist->flags);
> +				fr = insn_stack_access_frameno(hist->flags);
> +				bt_set_frame_slot(bt, fr, spi);
> +				return 0;
> +			}
> +		}
>  		/* scalars can only be spilled into stack */
>  		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
>  			return 0;
> -- 
> 2.43.0
