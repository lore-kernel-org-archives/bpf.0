Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134754;
	b=ttExpoJgIcOkuEcbquEnKVHKA04GcBsKqyHfvEHkdd06KhWXYd3v2/q6REKVS26ycTDK
	 wQI595nUCi5FCeWAmPXe+L88BPOIiWWvjGqkELte/6atvEymk0GUo+WtUdOZyXi9YwGCO
	 K3p+wjdpldA0xHXu9YjvauHGhCcaJLxH34j6s/QWW3VdRQ3bXlHLD1XQXiPHvDeF4nsXC
	 oGkxjNz8wE8Me6M6kpIrsskCSCripohVQ3UD/9InONPO59pF9lAX0qwCMG5uTqEubYjay
	 YnyYxNr/Jr2YF1TOnwIvVGB/gdihoxsnXpfjO7NyuB4QrQxq3g4XTJabZ3Qw0lVim7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134754;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ccqifl+tQF8bSoRFONwZ2nr2nNwYGVvTUOtloW9cxgE=;
	b=QB7NGyOrhv4fx2Uv4O03nM3zDdEecSLKO5xl89BBqs3QO7Q/L+XopSuP+1/XkT+f5pBr
	 sN290/hKEBoew5EWzCZKIZOO7uqnN5pqwkjOeF42x1aftY8FDcXYbzvOIYSX7WGweXrHx
	 APQ62EHGfEClEO8C8Wyqk+1c4ixKZ1Jc23xB3hl66YKnWlGJa5Mp+USJ5USH/FdmHhjud
	 YZTRII40WuFhlWIOzqrAb55qgIv4rW/2L2/WEPqouRrCPye9Lws139xeJxFeytTeGq9+x
	 OahxaLICsNl2Z5IkJ94I7cLmjotixu9CiqQXt3CbtdrP/HYQBeUy2c5bz2FgVe3kwbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWxWciux;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1F606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iWxWciux
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6CF1F01825;
	Tue, 27 Oct 2026 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134753;
	bh=ccqifl+tQF8bSoRFONwZ2nr2nNwYGVvTUOtloW9cxgE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iWxWciuxS5qZYbXQz0mt23JeCXMqBjuJVJqePQ8QiGuNUIH6IzUgnXCcCyMxizWl3
	 frjhKB1KOGSWSHJYQc3BWzQvXP6DOVTbCwjtFbNbA+khMsXPKfYoZEjx/dFXN4HSZB
	 m9AlwaDN+5Ebq/xFAHgsEeo1dHzvFGuqcNpPyCYul4Xy4vdHF0cqNrrgOJUYPXAA14
	 bR+9yRDRe/BK382DDRIzDtyhGiGr0EV8VoDJzMaa/X7XxQ2oE28VAQ4SOhMAH3sMqQ
	 0zqSiLauKRR9+aE21TdkzluJgce/te+oBRPxH3gh93kIToZ4V8uXfgSeId/AjsPk5+
	 MlPCgRlKtAoPw==
Content-Type: multipart/mixed; boundary="===============0785898696960445150=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c20a585e68b3f97c625c2c48e5d624af8f8ea8b2b459e6197d6f42839878353c@mail.kernel.org>
In-Reply-To: <20261027201436.3192716-2-alexei.starovoitov@gmail.com>
References: <20261027201436.3192716-2-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Keep the valid bytes of a packet pointer in scalar evolution
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 27 Oct 2026 20:59:13 +0000 (UTC)

--===============0785898696960445150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Keep the valid bytes of a packet pointer in scalar evolution

TL;DR:
- Back-edge clamp may overstate packet range, so verifier could accept an
  out-of-bounds packet read (not new)
- Range may be lowered twice on clamp, possibly rejecting safe programs
- bpf_reg_union() may hit "union of incompatible registers" verifier bug on
  valid programs

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17768,6 +17768,20 @@ bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
>  	}
>  }
>
> +/*
> + * 'range - umax' bytes from a packet pointer are in the packet. reg_bounds_sync() can make umax
> + * smaller: with a step of 8, or with 3 zero bits in var_off, 58 becomes 56. Make the range
> + * smaller by the same number, so that the number of bytes does not grow.
> + */
> +static void sync_widened_reg(struct bpf_reg_state *reg)
> +{
> +	u64 umax = reg_umax(reg);
> +
> +	reg_bounds_sync(reg);
> +	if (type_is_pkt_pointer(reg->type) && reg->range > 0)
> +		reg->range = max_t(s64, reg->range - (s64)(umax - reg_umax(reg)), 0);
> +}
> +

Does this cover the back-edge clamp path?  The commit message says "Make
the range smaller by the same number as umax", but when this is reached
through bpf_clamp_scev_regs()->bpf_set_reg_range(), the umax captured here is
read after bpf_set_reg_range() has already overwritten r64.

In bpf_clamp_scev_regs() umax drops twice:

  1. from the register's post-body umax to the widened bound, when
     bpf_set_reg_range() overwrites r64
  2. by the delta from reg_bounds_sync()

Only the second drop is taken off reg->range.  That is harmless when the
loop body only adds constants, because the range then matches the widened
state (but see the double lowering below).  It is not harmless when the body
raises the range with a new compare against pkt_end, because that range
refers to the post-body umax.

Take the clamp_pkt_pointer_step_lowers_umax shape (access only after the
clamp) with a re-check added to the loop body.  PKT_PLUS_R4(0, 8): r6 is
[0,50] with range 58, and the real value is x0 <= 48 with
pkt_len >= x0 + 8:

  - widening: r6 becomes [0,56], range 56
  - body: r6 += 8 gives [8,64]; then r5 = r6; r5 += 8;
    if r5 > pkt_end goto out.  find_good_pkt_pointers() gives
    r6.range = max(56, 72) = 72
  - clamp: [0,58] becomes [0,56], and range becomes 72 - 2 = 70, so the
    verifier counts 14 valid bytes

Really r6 = x0 + 8 and pkt_len can be x0 + 16, so only 8 bytes are valid.  A
*(u32 *)(r6 + 10) in the second iteration passes 56 + 10 + 4 <= 70 and reads
up to 6 bytes past the packet.  Before the patch the range was 72, or 16
valid bytes, so this problem is not new, but the change does not cover it.  A
kernel without scalar evolution rejects the access: 58 + 10 + 4 > 66.

Should the delta be measured from the register's umax before
bpf_set_reg_range() overwrites r64, or should the range be rebuilt from the
widened state?

>  int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  		      struct cnum64 r64, struct cnum32 r32, u16 base, u16 step)
>  {
> @@ -17776,7 +17790,7 @@ int bpf_set_reg_range(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>  	reg->step = step;
>  	reg->base = base;
>  	reg->var_off = tnum_unknown;
> -	reg_bounds_sync(reg); /* this should infer the tnum alignment */
> +	sync_widened_reg(reg); /* this should infer the tnum alignment */
>  	return reg_bounds_sanity_check(env, reg, "bpf_set_reg_range");
>  }

bpf_clamp_scev_regs() also calls bpf_set_reg_range().  Doesn't that lower
the range a second time by the same delta on every back edge?

In the widening path the range comes from the loop entry and goes with the
entry bounds, so lowering it by (58 - 56) is correct.  In the clamp path,
reg is the register at the back edge.  Its range is the widened range,
already lowered and carried through the body by constant adds, which keep
range.  bpf_clamp_scev_regs() computes linear_bounds(entry_reg, ...) from the
same loop-entry register, so it installs the same pre-sync r64, and
sync_widened_reg() then subtracts the same delta again.

Take the selftest widen_pkt_pointer_keeps_valid_bytes from the follow-up
commit 7c4d9d4f7f26, PKT_PLUS_R4(0, 16): r6 is [0,50] with range 66.

  - widening: r64 [0,58] is synced to [0,56] and range becomes 66 - 2 = 64.
    Checkpoint W is created, and the u64 load passes (56 + 8 <= 64)
  - body: r6 += 8 gives [8,64], range 64
  - back edge, clamp: r64 [0,58] is synced to [0,56] and range becomes
    64 - 2 = 62
  - bpf_is_state_visited(): regsafe() for PTR_TO_PACKET has

        else if (rold->range > rcur->range)
                return false;

    and 64 > 62, so there is no hit
  - the clamped state runs the body again: 56 + 8 > 62, giving "invalid
    access to packet, off=56 size=8, R6(id=3,off=56,r=62)"

That program is safe.  It loads before this patch, where the widened and
clamped ranges are both 66 and the state is pruned, and it loads on a kernel
without scalar evolution.  The follow-up commit 7c4d9d4f7f26 expects
__success for it.

By the same steps, clamp_pkt_pointer_step_lowers_umax gives r=54, not the
r=56 its __msg expects.

Can the range be lowered only once for a given widened register, so that the
clamped state matches the widened checkpoint?

[ ... ]

> @@ -17821,7 +17835,7 @@ int bpf_reg_union(struct bpf_verifier_env *env, struct bpf_reg_state *acc,
>  		acc->base = base;
>  		acc->step = step;
>  	}
> -	reg_bounds_sync(acc);
> +	sync_widened_reg(acc);
>  	return reg_bounds_sanity_check(env, acc, "bpf_reg_union");
>  }

Can this make a valid program fail with "union of incompatible registers"?

sync_widened_reg() now changes acc->range inside the union loop.
union_any_reg() calls bpf_reg_union(env, acc, leaf_reg) once per leaf of the
union expression, and its comment says "bpf_compute_loop_iters() checked that
every leaf can be unioned into acc".  That check is
is_widenable_any()->bpf_reg_union_compatible().  It runs once, on the
loop-entry registers, and it does:

    return !memcmp(a, b, offsetof(struct bpf_reg_state, var_off)) && ...

The memcmp() covers the union that holds range.  Before this patch
bpf_reg_union() never wrote range, so the check stayed true for the whole
loop.  Now sync_widened_reg(acc) lowers acc->range whenever
reg_bounds_sync() lowers umax, while the leaves that follow still carry the
loop-entry range.  bpf_reg_union_compatible(acc, leaf) then fails, and
bpf_reg_union() does verifier_bug(env, "union of incompatible registers")
and returns -EFAULT.  With CONFIG_DEBUG_KERNEL, verifier_bug() also fires
WARN_ONCE.

mk_any() puts the register itself first, so the leaves are visited in the
order (r, latch leaves...).  The failure is hit when the bounds narrow on any
union that is not the last one.  One way to get there is a packet pointer
whose bounds were never synced.  adjust_ptr_min_max_vals() skips
reg_bounds_sync() for a known addend (see b88822d2584f), so a constant add
after a variable add leaves them unsynced:

    r4 &= 0x38
    if r4 > 50 goto 9f
    r6 = pkt
    r6 += r4                  ; [0,50] var_off (0;0x38), synced
    r6 += 8                   ; [8,58] var_off (0;0x78), not synced
    r5 = r6
    r5 += 8
    if r5 > pkt_end goto 9f   ; r5.range = r6.range = 66
    r9 = 0
 1: if r6 > pkt_end goto 9f
    r6 = r5                   ; header SCEV of r6: ANY(r6, r5)
    r9 += 1
    if r9 < 2 goto 1b
 9: r0 = 0; exit

The first union is acc with itself.  reg_bounds_sync() turns var_off
(0;0x78) into (0;0x38), so umax goes from 58 to 56 and acc->range from 66 to
64.  The second leaf r5 still has range 66, so bpf_reg_union_compatible() is
false and the load fails with "verifier bug: union of incompatible
registers".  Before the patch this program loads.

A phi with three leaves fails the same way when the second union narrows, as
it does in the follow-up test union_pkt_pointer_var_off_lowers_umax with one
more leaf.

Would it work to adjust the range once, in union_any_reg() after the last
leaf, rather than in each bpf_reg_union() call?  Alternatively, could range
be left out of the compatibility test inside the loop?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40578692597
--===============0785898696960445150==--
