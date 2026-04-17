Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E2296BD2
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776401029; cv=none; b=ai54I4wmZPjail7E2YCb5T+mk0NRxyxnUepV2lYoqPHz8RbkrC+Xa4K201Ay6pSydCmJxIuHax41pGNvAwqpQLuRpGMEeBB+PAP0smQBL3p5YtuBFt6W0gUTJv3ndXZxWwhzb1FwfAZsuhKj95WT4by6n6GAv5cgK8laSiCTSWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776401029; c=relaxed/simple;
	bh=1j1G8Hdbxnmi10x/cgsvuHC3Oz8MKzelMtihasj37A4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SwEjZ9FHfLtk2wUh/Uy6yHbHD3vKvdoYB2kwvK2BXPJBNIV5LWLjJoh9t8oQuqowHgbliAo4Wkvm27CuqtxBeA9RFd+xhETM2A5WgwPd3GJbkPEOJ/HwH6OexeohDCpMREeEj5gKRI0KHiwMO1THXwL3Cysy0v20vvbGoaIwrtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNtbUj32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNtbUj32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19C8C19425;
	Fri, 17 Apr 2026 04:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776401029;
	bh=1j1G8Hdbxnmi10x/cgsvuHC3Oz8MKzelMtihasj37A4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KNtbUj32p+uhZuOiquKq5nEKPkbmoH5gVgPV7fNEEn+6o0aQl359sIm8Eaves5abB
	 FuL4p0/wn6s2y2f1dlyI1Ve+CdPVwEvlvpqrs7DV4S8nzY107YyGtGPhBuLFHJUgTK
	 CB+93TFWnUWH9Wdl9nOjUKWx61J8tN1rDlscT2yU60DB2fRMKVcji4AAnA+5tDudZ7
	 6Jy0ImtDpqChBq0zYMBJELqtZL2u8daG9CyyrI6TP+upDXHNGDvfiPpGhTwoio0kDd
	 GHsZhq6ApZtyP4hw9EdDmfxnlEYpnzIx5vlTKJhHueuSrP8eM5QGDiDP9K1PdPmvrB
	 Mz+Qz0HYk+K0w==
Content-Type: multipart/mixed; boundary="===============1555013306100240523=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c0706191c8a93441ee218ba6e6f277e4172f2dd8e4e44c6ff722640ed3a45bbe@mail.kernel.org>
In-Reply-To: <20260417034739.2629927-1-yonghong.song@linux.dev>
References: <20260417034739.2629927-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 08/16] bpf: Support stack arguments for bpf functions
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 04:43:48 +0000 (UTC)

--===============1555013306100240523==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 7bbd62c51bb5c..e0341fa0b0f7c 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -508,6 +513,17 @@ struct bpf_func_state {
>  	u32 callback_depth;
>  	u32 async_entry_cnt;
>
> +	/* Stack argument tracking for current function. */
> +	struct bpf_reg_state *stack_arg_regs;	/* Stack arg register states */
> +	u32 stack_arg_depth;			/* Depth of stack_arg_regs array */
> +	u32 incoming_stack_arg_depth;		/* Incoming stack arg count (callee) */
> +	u64 out_stack_arg_mask;			/* Outgoing stack arg mask (caller) */
> +};
> +
> +#define bpf_get_spilled_stack_arg(slot, frame, mask)			\
> +	(((slot < frame->stack_arg_depth / BPF_REG_SIZE) &&		\
> +	  ((1 << frame->stack_arg_regs[slot].type) & (mask)))	\
> +	 ? &frame->stack_arg_regs[slot] : NULL)

Does this macro work correctly? The existing bpf_get_spilled_reg macro
filters on frame->stack[slot].slot_type[], which is drawn from the
STACK_* enum (STACK_SPILL, STACK_ITER, etc.) and callers pass masks
like (1 << STACK_SPILL) | (1 << STACK_ITER).

This new macro filters on bpf_reg_state.type which is from a completely
different enum bpf_reg_type (SCALAR_VALUE, PTR_TO_BTF_ID, etc.) with
type modifier bits (PTR_MAYBE_NULL = BIT(8), PTR_TRUSTED = BIT(20),
etc.).

For example, check_kfunc_call() in the rcu_unlock path uses:

    u32 clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER);
    ...
    bpf_for_each_reg_in_vstate_mask(env->cur_state, state, reg,
                                    clear_mask, ...);

A stack-arg slot holding a MEM_RCU-tagged register would have
reg->type including MEM_RCU (BIT(13)). Then (1 << 13) = 0x2000, and
0x2000 & clear_mask (0x22) = 0, so the slot is skipped and MEM_RCU is
not cleared on rcu_unlock.

Additionally, when n >= 32 (for modifier bits like PTR_TRUSTED at
BIT(20)), the shift (1 << n) invokes undefined behavior in C.

Should this use a different approach to filter stack arg slots, perhaps
based on initialization status (type != NOT_INIT)?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 32cc59810e14d..30f2d1f06a988 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -1340,6 +1340,20 @@ static int copy_stack_state(struct bpf_func_state *dst,
>  			goto out_free_stack;
>  	}
>
> +	n = src->stack_arg_depth / BPF_REG_SIZE;
> +	if (n) {
> +		dst->stack_arg_regs = copy_array(dst->stack_arg_regs, src->stack_arg_regs, n,
> +						 sizeof(struct bpf_reg_state),
> +						 GFP_KERNEL_ACCOUNT);
> +		if (!dst->stack_arg_regs)
> +			return -ENOMEM;
> +
> +		dst->stack_arg_depth = src->stack_arg_depth;
> +		dst->incoming_stack_arg_depth = src->incoming_stack_arg_depth;
> +		dst->out_stack_arg_mask = src->out_stack_arg_mask;
> +	}
> +
> +	return 0;

What happens when src->stack_arg_depth == 0 but dst has non-zero
values from prior work?

The stack_arg_depth, incoming_stack_arg_depth, out_stack_arg_mask, and
stack_arg_regs fields come after the 'stack' field in struct
bpf_func_state, so the preceding memcpy(dst, src, offsetof(..., stack))
in copy_func_state does not overwrite them.

When n == 0, the assignments to dst->stack_arg_depth,
dst->incoming_stack_arg_depth, and dst->out_stack_arg_mask are skipped,
leaving stale values in dst.

This can be triggered via:

1. Frame starts with stack_arg_depth = 0, out_stack_arg_mask = 0
2. check_cond_jmp_op calls push_stack which saves this state
3. Verifier continues on one branch; BPF_ST/BPF_STX writes to r11-8,
   r11-16 cause check_stack_arg_write to call grow_stack_arg_slots,
   setting stack_arg_depth = 16 and out_stack_arg_mask = BIT(0)|BIT(1)
4. Branch ends; pop_stack calls bpf_copy_verifier_state which calls
   copy_stack_state with src->stack_arg_depth == 0
5. Because n == 0, the assignment block is skipped, and dst retains
   stack_arg_depth = 16 and out_stack_arg_mask = BIT(0)|BIT(1)
6. The other branch never writes r11-8 or r11-16, but when it calls a
   subprog, set_callee_state checks:
   if ((caller->out_stack_arg_mask & req_mask) != req_mask)
   The stale mask makes this check pass incorrectly

Would the verifier accept a call with uninitialized stack args on that
second branch? Should these fields be assigned unconditionally, similar
to how allocated_stack is handled earlier in this function?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24546989054
--===============1555013306100240523==--
