Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297EC2FF
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776474257; cv=none; b=LBVZtLo/slk9KukmUbmZJcQtc3Oh5k4qseD7Ouejf/Sf/6umVhHn+kqEjJ9eL/ybeR9QNlpC4FMf23TitVwcYIhJ+X2+TuJxZPPYvZT6bQ66Py+g5m8xfSmI4/zusgrmL37PCwzUL2AWwWp9Wo3QpTfCT+aH1X3Qpq0mWn6CWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776474257; c=relaxed/simple;
	bh=ozUINJiHHIv/IPLzMyZuNWH4CxxkFy8sY3ULRzjzT9k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=P0lwpoJA6SyVLDaRCIMXGu+4yR+r2vhlbj9HYbmkF6+6CTzc+IgxXx/0+coQyXFWeGojaMm3ZzceByxuarv7wEKM8ThEcUyqYji8cnJ/2KmIBqQ1KxH2zMEGJhT50lRibT0faI2pZffqM6kNxJ1EKNevkrX48bqboU4pb9kWBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbj77NCf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbj77NCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F841C19425;
	Sat, 18 Apr 2026 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776474257;
	bh=ozUINJiHHIv/IPLzMyZuNWH4CxxkFy8sY3ULRzjzT9k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=hbj77NCfT/v91CPW+gn6cRVUJMGOd1ndD8MLGyEmMquD68z/1mhmhUyD3OQScFZe1
	 dMgas7D4K271T4LQXFIk6ULiZzhCSVXZNLXTo8GsIjJBlL4U1dV540ZJB9NdmnToem
	 U354OlvAtURIQr56Z5KrfRw8jduLaAR2eEpglpQ1cVd7obHbozffRnaiWZEuNFCDD5
	 w9ULLNnlNA3r6DBMyCiJ3AzbTykXllBq/HwQrCmHe+xPVW0ykyaF1+d1pd2e9ejxTp
	 ORnzhy5nUzAspIIcBJBEDVFb+C2TXR7rf6ZQcLce0++JzKDJv575LDwu9LX/648Kbo
	 lD2cXe+IpzEfA==
Content-Type: multipart/mixed; boundary="===============6176010912244472272=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4e043142e762bd75ea79bfa102289ed4a5a52f4f671da48d7cb6508bad58488c@mail.kernel.org>
In-Reply-To: <20260417034739.2629927-1-yonghong.song@linux.dev>
References: <20260417034739.2629927-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v5 08/16] bpf: Support stack arguments for bpf functions
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 01:04:17 +0000 (UTC)

--===============6176010912244472272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 29a8a2605a12..6223c055b028 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -508,6 +513,17 @@ struct bpf_verifier_state {
>  	     iter < frame->allocated_stack / BPF_REG_SIZE;		\
>  	     iter++, reg = bpf_get_spilled_reg(iter, frame, mask))
>
> +#define bpf_get_spilled_stack_arg(slot, frame, mask)                   \
> +	(((slot < frame->stack_arg_depth / BPF_REG_SIZE) &&             \
> +	  ((1 << frame->stack_arg_regs[slot].type) & (mask))) \
> +	 ? &frame->stack_arg_regs[slot] : NULL)
                                                      ^^^^

The shift count in this macro appears to be incorrect. The macro uses
`1 << frame->stack_arg_regs[slot].type` where type is an `enum bpf_reg_type`.

Looking at bpf_get_spilled_reg (which this macro is modeled after), it uses
`1 << frame->stack[slot].slot_type[BPF_REG_SIZE - 1]` where slot_type is an
`enum bpf_stack_slot_type` with values in the range 0..7.

However, `enum bpf_reg_type` values frequently carry high bit flags like
PTR_MAYBE_NULL (BIT(8)), PTR_UNTRUSTED (BIT(14)), PTR_TRUSTED (BIT(20)),
and MEM_RCU (BIT(21)):

include/linux/bpf.h:
    enum bpf_type_flag {
        PTR_MAYBE_NULL    = BIT(8),
        ...
        PTR_UNTRUSTED     = BIT(14),
        ...
        PTR_TRUSTED       = BIT(20),
        MEM_RCU           = BIT(21),
        ...
    };

When a stack arg has type PTR_TO_BTF_ID | MEM_RCU, the value is around
0x200010, and `1 << 0x200010` is undefined behavior (shift count >= width
of int).

The concrete impact occurs where bpf_for_each_reg_in_vstate (line 541-554)
walks all registers including stack args:

include/linux/bpf_verifier.h:
    #define bpf_for_each_reg_in_vstate_mask(...)
        bpf_for_each_spilled_reg(___j, __state, __reg, __mask) {
            ...
        }
        bpf_for_each_spilled_stack_arg(___j, __state, __reg, __mask) {
            if (!__reg)
                continue;
            (void)(__expr);
        }

At kernel/bpf/verifier.c:13438, this iterator is used with
clear_mask = (1 << STACK_SPILL) | (1 << STACK_ITER) to strip MEM_RCU
from all surviving pointers after rcu_read_unlock. For a stack arg with
PTR_TO_BTF_ID | MEM_RCU, the mask test becomes
`(1 << (type & 31)) & 130` which does not match 130, so the macro returns
NULL and the MEM_RCU stripping code never runs. MEM_RCU pointers passed
as arguments 6+ remain tagged MEM_RCU across rcu_read_unlock, allowing
later dereferences without PTR_UNTRUSTED semantics.

Could the mask test be rewritten to avoid bit-shifting an enum bpf_reg_type
value?  Perhaps using is_spillable_regtype() or a similar type predicate
rather than a bit pattern?


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f25a56cfabac..7a65b532e84a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1340,6 +1340,20 @@ static int copy_stack_state(struct bpf_func_state *dst, const struct bpf_func_st
>  		return -ENOMEM;
>
>  	dst->allocated_stack = src->allocated_stack;
> +
> +	/* copy stack args state */
> +	n = src->stack_arg_depth / BPF_REG_SIZE;
> +	if (n) {
> +		dst->stack_arg_regs = copy_array(dst->stack_arg_regs, src->stack_arg_regs, n,
> +					     sizeof(struct bpf_reg_state),
> +					     GFP_KERNEL_ACCOUNT);
> +		if (!dst->stack_arg_regs)
> +			return -ENOMEM;
> +
> +		dst->stack_arg_depth = src->stack_arg_depth;
> +		dst->incoming_stack_arg_depth = src->incoming_stack_arg_depth;
> +		dst->out_stack_arg_mask = src->out_stack_arg_mask;
> +	}
>  	return 0;
>  }

Are dst->stack_arg_depth, dst->incoming_stack_arg_depth, and
dst->out_stack_arg_mask updated when src->stack_arg_depth is 0?

copy_stack_state only updates those fields when n != 0. When src has no
stack args, dst retains stale values from a prior copy.

This differs from the unconditional update of dst->allocated_stack a few
lines above, and from copy_reference_state which always updates
active_locks and acquired_refs.

The function copy_func_state() calls memcpy up to offsetof(struct
bpf_func_state, stack). Since stack_arg_depth, incoming_stack_arg_depth,
out_stack_arg_mask, and stack_arg_regs are all declared AFTER stack,
memcpy does not copy them. copy_stack_state is the only place those
fields are updated from src to dst.

The staleness is visible through pop_stack:

  pop_stack() calls bpf_copy_verifier_state(cur, &head->st).
  cur->frame[i] may have out_stack_arg_mask/stack_arg_depth populated
  from a previously explored branch that called a stack-arg function.
  head->st is the saved state from before the branch, with mask=0 and
  stack_arg_depth=0.
  For that frame, src->stack_arg_depth==0 so the copy is skipped, and
  cur keeps the prior branch's mask and stack_arg_regs.

The commit message promises "A per-state bitmask out_stack_arg_mask
tracks which outgoing stack arg slots have been written on the current
path... if one branch of a conditional writes arg6 but another does not,
the mask correctly reflects the difference and the verifier rejects the
uninitialized path."

After pop_stack, the other branch is processed on top of cur, where the
mask still carries bits set by the taken branch.

Consequences in set_callee_state:

kernel/bpf/verifier.c:set_callee_state() {
    ...
    if ((caller->out_stack_arg_mask & req_mask) != req_mask) {
        for (i = 0; i < callee_incoming_slots; i++) {
            if (caller->out_stack_arg_mask & BIT(i))
                continue;
            verbose(env, "stack arg#%d not properly initialized\n", ...);
            return -EINVAL;
        }
    }
    ...
}

With stale bits, this check can pass on a path where the current branch
never wrote the required r11 offsets. The verifier then copies stale
caller->stack_arg_regs[caller_spi] into the callee's incoming slot.

Similarly in btf_check_func_arg_match:

kernel/bpf/verifier.c:btf_check_func_arg_match() {
    ...
    if (spi >= (caller->stack_arg_depth / BPF_REG_SIZE)) {
        verbose(env, "stack %s not found in caller state\n", ...);
        return -EINVAL;
    }
    ...
}

With stale caller->stack_arg_depth, this bound check can pass on paths
where the actual live stack_arg_depth is 0.

Should these fields be updated unconditionally, even when n==0?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564
--===============6176010912244472272==--
