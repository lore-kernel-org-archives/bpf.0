Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648603C10B5
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541770; cv=none; b=GIMoM6caDgW36nB+2jC9Fdpk8HwXMLn/u3I5dBQBaoDVlM6eVF84YMbwCEma43d4FQ++BKWGJmH2HIpNHFHE3/zqcRzzkAnAG6GRUYtbVKzJJYf5DQ0AB+N1SaZQuvcK5AkAIhtPPiYzlf7GI7vL3kDnBgDSBWgBhLyPVmmS5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541770; c=relaxed/simple;
	bh=u+hjepPT6NK6fAOyYooIaXYsq04qoxoykWOMzHMKdR4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZN3oBhpjt0RqTeXTaiDiH8VUN8jLJBdmL3vhmnHzHILaj01SaW83L3nRkEQi5usM22xK7qcEVM0AkeLg61v1r4YBcdKjx7YchDltGgfmkYHrPj8C6h1oubJbVvGfc0wmAWxoP/p6gBZ/zghzOSl/RyrLeC7hUBbVBDm4BAWoj+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIgP8uIU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIgP8uIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9385A1F000FF;
	Sun, 27 Sep 2026 20:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541769;
	bh=F0uXcsdETb9Tu1UXdRXH2I2Ndr8cSiP5HcnrkUaSW3I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KIgP8uIUBxluZ6KyJCmNbozNV0CZQlBSTFQ60DnewUFiwWN80+0rHEv5u9L1c471B
	 72ChuJGpN5J/7l/pprLM7rA/knQLT8TJUnd7I6sr8Wx5zVRPCrDbr6D/2bbollR0ht
	 Vwlp5/+DIZOUWYTw8utwsin31M7Qm9/A7Ry5m1AnRi+UG+4giYsELZaRWWmnkN5xN4
	 UZykUI20d2nVYmCdZAdvH3x3O8LRMLDdfiI6atDRjmT7ceSPnT3CI/vFLjP4NNLnnL
	 ZRGE7U+bJOZaMo/bTBD66IAzfV/ZaG5kiFJsYZzNyc0BeL7zDdAicim6qnUsnMlAad
	 LCUbVtY7dJGRw==
Content-Type: multipart/mixed; boundary="===============4271042771192856100=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e179f726ade68c29a7ca9530746bee1473aa7f1b18b3886c777537831375ad7@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-2-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-2-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 02/36] bpf: summarize may write stack slots in insn_aux_data
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:42:48 +0000 (UTC)

--===============4271042771192856100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c775bd757706..c6d617581e84 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -662,6 +662,11 @@ struct bpf_insn_aux_data {
>  	};
>  	struct btf_struct_meta *kptr_struct_meta;
>  	u64 map_key_state; /* constant (32 bit) key tracking for maps */
> +	/*
> +	 * Per-instruction summary of stack slots in the current frame
> +	 * that this instruction may write to.
> +	 */
> +	DECLARE_BITMAP(may_write_mask, MAX_BPF_STACK_SLOTS);

Is the comment accurate that this covers every write? Looking at how the
mask is populated in compute_may_write_masks(), it only ORs in FM_MAY_WRITE
bits from liveness. When a bpf_loop()/for_each_map_elem()/find_vma()/
user_ringbuf_drain() call passes a frame pointer as ctx but the callback is
not a constant (R2 could be cb_a or cb_b on different branches), liveness
handles this case specially in analyze_subprog():

    if (callee == -2) {
        /*
         * same bpf_loop() calls two different callbacks and passes
         * stack pointer to them
         */
        if (info[subprog].at_in[j][caller_reg].frame == ARG_NONE)
            continue;
        for (int f = 0; f <= depth; f++) {
            err = mark_stack_read_all(env, instance, f, idx);
            ...
        }
        continue;
    }

That code calls mark_stack_read_all() but nothing marks may_write. The
callbacks themselves are analyzed standalone with R1-R5 as ARG_NONE, so a
store like `*(u64 *)(r2 + 0) = 0` in the callback is never attributed to
the caller's frame. This means FM_MAY_WRITE stays empty at the call site,
and compute_may_write_masks() stores an empty may_write_mask even when the
callback writes through ctx.

The verifier accepts this pattern: bpf_loop_two_callbacks in
tools/testing/selftests/bpf/progs/verifier_live_stack.c exercises the
callee == -2 branch (it passes fp but with two possible callbacks). If its
callbacks wrote through ctx instead of reading, aux[call].may_write_mask
would stay empty for those slots.

This matters because reset_scevs_at_indirect_writes() in
60fc0594170e ("bpf: compute scalar evolution expressions for loops") uses
bpf_may_write_mask() as the only way to invalidate stack-slot expressions
at a call. A stack-slot SCEV expression could survive a bpf_loop() whose
callback overwrites that slot, and then bpf_clamp_scev_regs() would
intersect the slot's range with bounds derived from that stale expression.

Should the callee == -2 branch also call mark_stack_may_write_all() for
frames 0..depth so the summary is conservative?

Alexei Starovoitov raised a concern about memory usage in the v1 thread
(https://lore.kernel.org/bpf/DLPD9Q4H9C62.2QMD510XIOOJR@gmail.com/):

> That's 32 bytes per insn and the next patch adds 32 more,
> for every prog whether it has loops or not.
> FM_MAY_WRITE in patch 1 makes every frame_masks a third bigger too.
> commit 481ceda77aeb sized the liveness masks by the stack the frame
> uses to avoid exactly that.
>
> bpf_may_write_mask() is the only accessor.
> Can the summary stay in liveness.c, as wide as the subprog's stack,
> and only for insns with scc != 0 ?

Could the summary be stored in liveness.c instead, sized by the subprog's
actual stack usage and only for instructions with scc != 0, to avoid the
fixed 32-byte overhead for every instruction?

>  	int ctx_field_size; /* the ctx field size for load insn, maybe 0 */
>  	u32 seen; /* this insn was processed by the verifier at env->pass_cnt */
>  	bool nospec; /* do not execute this instruction speculatively */
> @@ -1728,6 +1733,7 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env);
>  int bpf_stack_liveness_init(struct bpf_verifier_env *env);
>  void bpf_stack_liveness_free(struct bpf_verifier_env *env);
>  int bpf_live_stack_query_init(struct bpf_verifier_env *env, struct bpf_verifier_state *st);
> +const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx);
>  bool bpf_stack_slot_alive(struct bpf_verifier_env *env, u32 frameno, u32 spi);
>  int bpf_compute_live_registers(struct bpf_verifier_env *env);

[ ... ]

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index cc3ad75aa1e2..c871744ca5a8 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
> @@ -718,6 +718,45 @@ static int cmp_instances(const void *pa, const void *pb)
>  	return 0;
>  }

[ ... ]

> +/*
> + * Precompute, for each instruction, the OR of may_write masks over its top
> + * frame across all func_instances reaching it, stash it in the insn_aux_data.
> + */
> +static void compute_may_write_masks(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux = env->insn_aux_data;
> +	struct bpf_liveness *liveness = env->liveness;
> +	struct func_instance *instance;
> +	struct frame_masks *fm;
> +	u32 nbits;
> +	int bkt, i;
> +
> +	hash_for_each(liveness->func_instances, bkt, instance, hl_node) {
> +		fm = instance->frames[instance->depth];
> +		if (!fm)
> +			continue;
> +		nbits = frame_mask_bits(fm);
> +		for (i = 0; i < instance->insn_cnt; i++)
> +			half_spis_to_slots(aux[instance->subprog_start + i].may_write_mask,
> +					   rel_mask(fm, i, FM_MAY_WRITE), nbits);
> +	}
> +}

This function reads FM_MAY_WRITE from liveness and summarizes it into
may_write_mask. Does this capture all writes that the instruction might
perform?

As noted above for the header comment, when analyze_subprog() encounters
callee == -2 (same bpf_loop() or similar can invoke different callbacks),
it only marks reads and skips recording writes:

    if (callee == -2) {
        ...
        for (int f = 0; f <= depth; f++) {
            err = mark_stack_read_all(env, instance, f, idx);
            ...
        }
        continue;
    }

No callee instance is created for this case, so merge_may_write() never
runs. The helper's ARG_PTR_TO_STACK argument doesn't help either:
bpf_helper_stack_access_bytes() returns 0 for it, with the comment "The
callback subprog does and it's analyzed separately". But in the -2 case the
callbacks are analyzed only at depth 0 with ctx == ARG_NONE, so their
stores through ctx are never attributed to the caller's frame.

This means FM_MAY_WRITE stays empty at that call instruction even when a
callback writes through ctx into the caller's frame. Since this function
only ORs in FM_MAY_WRITE bits, it will produce an empty may_write_mask for
those slots.

This gap is still present at the end of the series at 4a6395b27755 - the
callee == -2 branch still has only mark_stack_read_all(). Should it also
call mark_stack_may_write_all() for frames 0..depth to keep the summary
conservative?

> +
> +const unsigned long *bpf_may_write_mask(struct bpf_verifier_env *env, u32 insn_idx)
> +{
> +	return env->insn_aux_data[insn_idx].may_write_mask;
> +}

[ ... ]

> @@ -2352,6 +2391,8 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
>  			goto out;
>  	}
>
> +	compute_may_write_masks(env);
> +
>  	if (env->log.level & BPF_LOG_LEVEL2)
>  		err = print_instances(env);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============4271042771192856100==--
