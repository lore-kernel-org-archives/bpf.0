Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315BE3C1D4F
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790541779; cv=none; b=BoAjWP69uE9w+37r6gl0Ww8xZA7nm4sWfJE3gEWvCV+uUOkNxsvlJXDQ5vJ7sQoPHUhcHaxFWZDReCGSIwlvFryWS9hgBBrYg9JflLuvAxwqBEZqKkLBzSxveqjqgwKVutlOZg9txzjr+MFTvMKc2aLlPtKmoQ0jECmjpgQhcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790541779; c=relaxed/simple;
	bh=eHdetxA6Arp/qN6uOg3ayLqLwTQ5Vm+DHgdmXDw5rDQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Jp2IEQEyrCSuH6m4pUpWQodacpNDJwbTnqtN0fkbm6AzOyQBvd3l6Pl/jlbYXue906G/7R4XUIGAV1MWV1opurTOJ80UTBINTkRSGcZkgPwgPdTUjLKHtGJYReT65EoH9tzQ9lurWwc46frLbaKNJ/I1dNVZ47OjnkbjwdSUhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0g6ghw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0g6ghw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DA21F000FF;
	Sun, 27 Sep 2026 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790541777;
	bh=u8p8OJ8Z+VVCuUh0syPq7hH2WpUlBj5cJSxpOH/fokQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=o0g6ghw/+roodUy7MhLjwZIecylJgDWjPUcPQqnD1E6xVlL/MUggf1n5te53dF3F3
	 hGEdiUyot0WoQZxhzD0ypctCBgPtY7t7CdctKEfmxrZZdXuWCO9TaGsAJke3OIpOOS
	 l4xeMSJ51iKEBqbtkLUylveKmI1qny5gzqvgh1OhxaWomWBzuGJcIEeW2EqshhoVNE
	 iUuIDsvnFgYgcMqbvjj4CYTv/k1aQESYn5GukPEfs5xUYAMmHfeG7Is8/JQ336II1r
	 frtbKfYFrac1vvkPG8YYNpIURK6LxyC8+p34kAlIP4rJXAsfiBDnT0SvLdiOLhWP2Q
	 wZG7Yx805InTQ==
Content-Type: multipart/mixed; boundary="===============4556172115429374183=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1692b3d86d6e638b631ec33d7b0cf37dee3601423768161bdeaf8331b48973b7@mail.kernel.org>
In-Reply-To: <20260926-scev-minimal-rebase-v1-1-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-1-c8e5ab5ba79f@gmail.com>
Subject: Re: [PATCH bpf-next 01/36] bpf: track may_write flags in liveness
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 27 Sep 2026 20:42:57 +0000 (UTC)

--===============4556172115429374183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index cd9523f69298..cc3ad75aa1e2 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> @@ -1590,7 +1635,7 @@ static int record_load_store_access(struct bpf_verifier_env *env,
>  	if (ptr->frame >= 0 && ptr->frame <= depth)
>  		return record_stack_access(env, instance, ptr, sz, ptr->frame, insn_idx);
>  	if (ptr->frame == ARG_IMPRECISE)
> -		return record_imprecise(env, instance, ptr->mask, insn_idx);
> +		return record_imprecise(env, instance, sz, ptr->mask, insn_idx);
>  	/* ARG_NONE: not derived from any frame pointer, skip */
>  	return 0;
>  }

For atomic read-modify-write instructions (BPF_ADD/AND/OR/XOR with or
without BPF_FETCH, BPF_XCHG, BPF_CMPXCHG), the size sz stays positive,
so record_imprecise() records them as reads only and never sets
FM_MAY_WRITE for the stack slot they modify.

Looking at the code path:

  record_load_store_access()
    case BPF_STX:
      if (BPF_MODE(insn->code) == BPF_ATOMIC) {
          if (insn->imm == BPF_STORE_REL)
              sz = -sz;
          ...
      }

Atomic RMW operations don't hit the BPF_STORE_REL path, so sz remains
positive and record_imprecise() marks only FM_MAY_READ.

Does this contradict the commit message's statement that may_write
includes "any possibly modified slot"?  A later commit in the series
(0428816ca270) fixes this, but at this commit the gap exists.

> @@ -1618,6 +1663,9 @@ static int record_arg_access(struct bpf_verifier_env *env,
>  			err = mark_stack_read_all(env, instance, f, insn_idx);
>  			if (err)
>  				return err;
> +			err = mark_stack_may_write_all(env, instance, f, insn_idx);
> +			if (err)
> +				return err;
>  		}
>  		return 0;
>  	}
> @@ -1627,7 +1675,7 @@ static int record_arg_access(struct bpf_verifier_env *env,
>  	if (frame >= 0 && frame <= depth)
>  		err = record_stack_access(env, instance, at, bytes, frame, insn_idx);
>  	else if (frame == ARG_IMPRECISE)
> -		err = record_imprecise(env, instance, at->mask, insn_idx);
> +		err = record_imprecise(env, instance, bytes, at->mask, insn_idx);
>  	return err;
>  }

The commit message says may_write covers "any possibly modified slot,
including partial writes", but for helper and kfunc calls, may_write
is derived only from the sign of bytes returned by
bpf_helper_stack_access_bytes() or bpf_kfunc_stack_access_bytes().

Looking at bpf_helper_stack_access_bytes() in verifier.c:

    full_write = (at & MEM_UNINIT) &&
                 (!arg_type_is_raw_mem(at) || env->allow_uninit_stack);
    if (full_write)
        return -size;
    return size;

It returns a negative value only for guaranteed full writes (MEM_UNINIT
with allow_uninit_stack).  Arguments that write to the stack but don't
meet the full_write condition return +size and are recorded as reads
only.

Some examples that write caller stack but never get FM_MAY_WRITE:

- Helper arguments with ARG_PTR_TO_MEM | MEM_WRITE (like
  bpf_fib_lookup params, bpf_skb_load_bytes buffer) when
  !env->allow_uninit_stack (CAP_BPF without CAP_PERFMON)

- Helper arguments with ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE |
  MEM_ALIGNED (like bpf_skb_check_mtu mtu_len), regardless of
  capabilities

- Kfunc output arguments that are not __uninit (like
  bpf_dynptr_slice buffer__szk)

Later in the series, fad299f2d710 exports the mask as
bpf_may_write_mask(), and 60fc0594170e uses it in
reset_scevs_at_indirect_writes() as the only way to invalidate
stack-spill SCEVs across calls.  A stale SCEV for a slot overwritten by
one of these helpers can produce wrong loop reasoning in
1987b0e52b34 (loop widening).

Should the may_write side be derived from the argument's
MEM_WRITE/MEM_UNINIT (and non-const kfunc mem args) rather than from
full_write, keeping the full_write distinction only for must_write?

> @@ -1444,10 +1465,12 @@ static void arg_track_xfer(struct bpf_verifier_env *env, struct bpf_insn *insn,
>   *   access_bytes == 0:      no access
>   *
>   */
> -static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
> -				   s64 access_bytes, u32 frame, u32 insn_idx)
> +static int record_stack_access_off(struct func_instance *instance, const struct arg_track *arg,
> +				   u32 off_idx, s64 access_bytes, u32 frame, u32 insn_idx)
>  {
> +	s64 fp_off = arg->off[off_idx];
>  	s32 slot_hi, slot_lo;
> +	int err;
>
>  	if (fp_off >= 0)
>  		/*

[ ... ]

> @@ -1471,7 +1495,15 @@ static int record_stack_access_off(struct func_instance *instance, s64 fp_off,
>  		access_bytes = -access_bytes;
>  		slot_hi = (-fp_off) / STACK_SLOT_SZ - 1;
>  		slot_lo = max_t(s32, (-fp_off - access_bytes + STACK_SLOT_SZ - 1) / STACK_SLOT_SZ, 0);
> -		return mark_stack_write(instance, frame, insn_idx, slot_lo, slot_hi);
> +		if (arg->off_cnt == 1) {
> +			err = mark_stack_write(instance, frame, insn_idx, slot_lo, slot_hi);
> +			if (err)
> +				return err;
> +		}
> +		/* Mark partially covered slots as may_def */
> +		slot_hi = (-fp_off - 1) / STACK_SLOT_SZ;
> +		slot_lo = max_t(s32, (-fp_off - access_bytes) / STACK_SLOT_SZ, 0);
> +		return mark_stack_may_write(instance, frame, insn_idx, slot_lo, slot_hi);
>  	}
>  	return 0;
>  }

record_stack_access_off() derives may_write purely from the sign of
access_bytes.  For helper and kfunc stack arguments, access_bytes comes
from bpf_helper_stack_access_bytes() or bpf_kfunc_stack_access_bytes(),
which return negative values only for guaranteed full writes:

    full_write = (at & MEM_UNINIT) &&
                 (!arg_type_is_raw_mem(at) || env->allow_uninit_stack);

Any other written argument is returned as +size and takes the
`access_bytes > 0` branch which marks only FM_MAY_READ.

Examples that write caller stack but never get FM_MAY_WRITE:

- ARG_PTR_TO_FIXED_SIZE_MEM | MEM_WRITE | MEM_ALIGNED (like
  bpf_skb_check_mtu mtu_len and bpf_xdp_check_mtu mtu_len)

- ARG_PTR_TO_MEM | MEM_WRITE (like bpf_skb_fib_lookup params,
  bpf_xdp_fib_lookup params, bpf_sock_ops_load_hdr_opt)

- ARG_PTR_TO_UNINIT_MEM raw buffers (like bpf_skb_load_bytes,
  bpf_map_pop_elem) when !env->allow_uninit_stack (CAP_BPF without
  CAP_PERFMON)

- Kfunc mem args that are written but not __uninit (like
  bpf_dynptr_slice buffer__opt)

The consumer introduced later in the series makes the omission matter.
scev.c:reset_scevs_at_indirect_writes() only invalidates stack-slot
SCEVs through bpf_may_write_mask(env, idx) for calls;
forget_call_regs() clears only R0-R5.

So a loop like this:

    r1 = *(u64 *)(r10 - 8); r1 += 1; *(u64 *)(r10 - 8) = r1;
    r1 = r6; r2 = 0; r3 = r10; r3 += -8; r4 = 8;
    call bpf_skb_load_bytes;
    r1 = *(u64 *)(r10 - 8); if r1 < 100 goto loop;

keeps fp-8 as a linear recurrence even though the helper overwrites it
with packet data each iteration.

bpf_compute_loop_iters() can then declare the loop terminating, and
states.c:is_state_visited() prunes such loops with RANGE_WITHIN and
skips the "infinite loop detected" check.  A loop that never terminates
at runtime could then be accepted.

This is not fixed in the range 2d21f2c85cb4..4a6395b27755.

Should the may_write side be derived from the argument's
MEM_WRITE/MEM_UNINIT (and non-const kfunc mem args) rather than from
full_write, keeping the full_write distinction only for must_write?

[ ... ]

> @@ -2025,18 +2074,50 @@ static int merge_instances(struct func_instance *dst, struct func_instance *src)
>  		for (i = 0; i < dst->insn_cnt; i++) {
>  			unsigned long *dst_read = rel_mask(d, i, FM_MAY_READ);
>  			unsigned long *dst_write = rel_mask(d, i, FM_MUST_WRITE);
> +			unsigned long *dst_may_write = rel_mask(d, i, FM_MAY_WRITE);
>  			unsigned long *src_read = rel_mask(s, i, FM_MAY_READ);
>  			unsigned long *src_write = rel_mask(s, i, FM_MUST_WRITE);
> +			unsigned long *src_may_write = rel_mask(s, i, FM_MAY_WRITE);
>
>  			for (w = 0; w < d->words; w++) {
>  				dst_read[w] |= w < s->words ? src_read[w] : 0;
>  				dst_write[w] &= w < s->words ? src_write[w] : 0;
> +				dst_may_write[w] |= w < s->words ? src_may_write[w] : 0;
>  			}
>  		}
>  	}
>  	return 0;
>  }
>
> +/*
> + * Fold a fully analyzed callee instance writes to upper frames as
> + * may_write marks at callsite in caller's frames.
> + */
> +static int merge_may_write(struct func_instance *caller, struct func_instance *callee)
> +{
> +	DECLARE_BITMAP(acc, FRAME_HALF_SPIS);
> +	u32 call_idx = callee->callsite;
> +	struct frame_masks *fm;
> +	u32 f, i, nbits;
> +	int err;
> +
> +	for (f = 0; f < callee->depth; f++) {
> +		fm = callee->frames[f];
> +		if (!fm)
> +			continue;
> +		nbits = frame_mask_bits(fm);
> +		bitmap_zero(acc, nbits);
> +		for (i = 0; i < callee->insn_cnt; i++)
> +			bitmap_or(acc, acc, rel_mask(fm, i, FM_MAY_WRITE), nbits);
> +		if (bitmap_empty(acc, nbits))
> +			continue;
> +		err = mark_stack_mask(caller, f, call_idx, FM_MAY_WRITE, acc, fm->words);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
>  static struct func_instance *fresh_instance(struct func_instance *src)
>  {
>  	struct func_instance *f;

[ ... ]

> @@ -2204,6 +2285,11 @@ static int analyze_subprog(struct bpf_verifier_env *env,
>  					goto out_free;
>  			}
>  		}
> +
> +		/* Summarize callee's writes to ancestor frames onto the callsite */
> +		err = merge_may_write(instance, callee_instance);
> +		if (err)
> +			goto out_free;
>  	}
>
>  	if (prev_instance) {

The commit adds merge_may_write() for known callees, but there is a
path earlier in analyze_subprog() that handles callback-calling helpers
(bpf_loop, bpf_for_each_map_elem, bpf_find_vma,
bpf_user_ringbuf_drain) whose callback is not a constant subprog.

When find_callback_subprog() returns -2 and the ctx argument points to
the stack, the code has this:

    if (callee == -2) {
        /*
         * same bpf_loop() calls two different callbacks and passes
         * stack pointer to them
         */
        if (info[subprog].at_in[j][caller_reg].frame == ARG_NONE)
            continue;
        for (int f = 0; f <= depth; f++) {
            err = mark_stack_read_all(env, instance, f, idx);
            if (err)
                goto out_free;
        }
        continue;
    }

This marks only mark_stack_read_all() for every frame and then does
`continue`, so merge_may_write() never runs and no
mark_stack_may_write_all() is recorded either.

The helper's ARG_PTR_TO_STACK ctx argument gets 0 from
bpf_helper_stack_access_bytes(), so record_arg_access() adds nothing
for it.

As a result, the call insn's may_write mask omits every caller slot the
unknown callback may write through ctx, even though the callback can do
'*(u64 *)ctx += 1' on a caller stack slot.

The unknown-callee path in record_arg_access() was updated in this
commit to add mark_stack_may_write_all().

The same stale-SCEV issue follows through
reset_scevs_at_indirect_writes()/bpf_may_write_mask().

This is still present at 4a6395b27755.

Should this loop also call mark_stack_may_write_all(env, instance, f,
idx)?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346543957
--===============4556172115429374183==--
