Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515239;
	b=1iAWhjaFGJuo9A7uzBSG5UaM5NW9wR9Q4Xsl8ARIKv5m5Emc3XqYYPFvepnwog625c5M
	 r+79MpGbKTAIPhq6Izwg1dHTkv7ZlYaI/v5yfUHGjtTKvFVF1etj1YDx77tWPFuSoBJzD
	 fCgLKrAjLBuEgCBqePq0FEDdMBuQxisN60Q20stbhNZWVPzrPOjvCaAMKSECkNpJtwpJ1
	 4juLtFSIu77mN3Hzda5YDdOsYTtIr3iPA/1LHkbAOvbfjsheKHZPvziEBtFe9TeAg1Zws
	 msSBnSKI+NcNezfIRPu7WJqB0yKeIdR7MCkeGRPUxNXqvY66Jeh3Pl81EbNfbwJZQ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515239;
	h=Received:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date;
	bh=TbMs2ngW89eX+bAbrmsJu7YdbOM/lyawGAQV6NPa8GY=;
	b=1POufMM5Vm44/+YFs5m5FEQlYi96O0RDFDf82gNOS4boSK12yFZMJVhP0kOTTCse9HZP
	 I2U9M+OYKJBYtpTiaCK7vXONkKfP/br184+VyP8HeOofUiB/DuQtghUn0grtZ21854FsG
	 t0sWXfasS3dlkHwd0qx1ghvBdsA1bjzuZ1AZ3ahM9ov27CYgl7h5Xv/8QQcZghtIJcPJj
	 WmS3R8HC2f79kxiHkSzPmeHjURCdq8PmiRr8OYJ3U5yQc5FoS2fpSsekTl7k1lVirc3dU
	 +yAhHB+dcQPP3+RzbXHLrQ0vBpO3ndBp+vhxKQxd3/7Sqh+mv9LJZVoU81+jnbU2LqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3EC606A31B;
	Tue, 20 Oct 2026 16:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC4D1F000D3;
	Tue, 20 Oct 2026 16:53:58 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============8247120795320158940=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <df21389eff01ccc8739c2baa97fe5832fb09da46617cb05d6337bc9ef0968adc@mail.kernel.org>
In-Reply-To: <20261020161907.2115379-9-vineet.gupta@linux.dev>
References: <20261020161907.2115379-9-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v3 08/12] bpf: Recover the low 32 bits on the reverse link direction
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 16:53:58 +0000 (UTC)

--===============8247120795320158940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Recover the low 32 bits on the reverse link direction

TL;DR:
- New sync_linked_regs() arm may intersect contradictory 32-bit ranges to
  empty, triggering verifier bug WARN or -EFAULT on valid programs; no prev
  restore
- Comment on width split is inaccurate (nit)

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18785,29 +18785,54 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>  		if (reg->id != known_reg->id)
>  			continue;
>  		/*
> -		 * The reverse direction does not work for a narrow known_reg:
> -		 * it knows only its low 32 bits, which say nothing about a
> -		 * wider reg's high half. Neither (u32)(base + delta) nor
> -		 * (s32)(base + delta) inverts once the base is wider than 32
> -		 * bits.
> +		 * The reverse direction, from a narrow known_reg to a wider
> +		 * reg, does not invert: neither (u32)(base + delta) nor
> +		 * (s32)(base + delta) says anything about the base's high
> +		 * half. It does still pin the low half, though -- both sides
> +		 * are (base + delta) mod 2^32, differing only by their deltas
> +		 * -- so recover that much and leave the high half alone.
>  		 */
>  		if ((known_reg->link_kind == BPF_REG_LINK_ZEXT ||
>  		     known_reg->link_kind == BPF_REG_LINK_SEXT) &&
>  		    reg->link_kind != BPF_REG_LINK_ZEXT &&
>  		    reg->link_kind != BPF_REG_LINK_SEXT &&
> -		    get_reg_width(reg) > 32)
> -			continue;
> +		    get_reg_width(reg) > 32) {
> +			/*
> +			 * Only @low's 32-bit half is meaningful: its var_off
> +			 * is advanced over all 64 bits while r64 and the
> +			 * base/step line are not, and nothing below reads
> +			 * either. It is a scratch value, not a register state.
> +			 */
> +			struct bpf_reg_state low = *known_reg;
> +			struct tnum low32;
> +
> +			fake_reg.type = SCALAR_VALUE;
> +			__mark_reg_known(&fake_reg,
> +					 (s64)reg->delta - (s64)known_reg->delta);
> +			scalar32_min_max_add(&low, &fake_reg);
> +			low.var_off = tnum_add(low.var_off, fake_reg.var_off);
> +
> +			cnum32_intersect_with(&reg->r32, low.r32);
> +			low32 = tnum_intersect(tnum_subreg(reg->var_off),
> +					       tnum_subreg(low.var_off));
> +			reg->var_off = tnum_with_subreg(reg->var_off, low32);
> +			reg_bounds_sync(reg);
> +			goto scratched;
> +		}

Can the cnum32_intersect_with(&reg->r32, low.r32) above produce an empty
range here?

The differencing arm further down in sync_linked_regs() saves prev and
guards against exactly that:

    struct bpf_reg_state prev = *reg;
    ...
    if (range_bounds_violation(reg))
            *reg = prev;
    reg_bounds_sync(reg);

Its comment explains that an empty intersection means the two sides
contradict, that reg_bounds_sync() refuses to touch an empty range, and that
the first later reg_bounds_sanity_check() would report it as a verifier bug.
The new arm has no such fallback, so reg_bounds_sync() returns early on the
empty r32, and tnum_intersect() of two contradicting constants gives an
arbitrary const subreg.

A contradiction looks reachable because the wide base can know more about
its low half than a ZEXT/SEXT member does.  FULL against ZEXT/SEXT and ZEXT
against SEXT pairs are skipped by the link_kind check:

    if (reg->link_kind && known_reg->link_kind &&
        reg->link_kind != known_reg->link_kind)
            continue;

but the base learns from every member: from a FULL one through the
differencing arm, and now from a ZEXT or SEXT one through this arm.  For
example (cpuv4, no CAP_BPF delta needed):

    call bpf_get_prandom_u32
    r6 = r0              /* wide, id N */
    w7 = w6              /* r7 ZEXT d0 */
    r8 = (s32)r6         /* r8 SEXT d0 */
    if w7 != 5 goto 1f   /* new arm: r6.r32 = {5}; r8 skipped (SEXT/ZEXT) */
    if w8 != 6 goto 1f   /* r8 low half unknown -> both paths explored */
    r0 = r6              /* fallthrough: new arm r6.r32 = {5} & {6} = EMPTY */
  1: r0 = 0; exit

On the fallthrough of "if w8 != 6", r8.r32 is {6}.  r6 is still wide, since
after the first sync its r64 is [5, 0xffffffff00000005] and get_reg_width()
returns 64.  cnum32_intersect({5,0},{6,0}) returns CNUM32_EMPTY.  The
"r0 = r6" mov then reaches reg_bounds_sanity_check(env, ..., "alu") at the
end of check_alu_op() with "range bounds violation", and verifier_bug()
fires BPF_WARN_ONCE.  That is a real WARN_ONCE under CONFIG_DEBUG_KERNEL (and
a panic with panic_on_warn), and it logs "verifier bug: REG INVARIANTS
VIOLATION".  With BPF_F_TEST_REG_INVARIANTS, which test_loader sets by
default, the load fails with -EFAULT.

The same thing happens with a FULL member in place of the SEXT one
(r8 = r6; r8 += 3; if w8 != 8 ...; if w7 != 6 ...), where both r6 and r8
end up with an empty r32.  Before this patch the guard simply did continue
for these pairs, so the program verified cleanly.

This is the case zext_contradiction_keeps_range_sane was written to pin for
the differencing arm.  Would saving prev = *reg before the intersection and
restoring it on range_bounds_violation(), as the differencing arm does, work
here?

No later commit in bbd86cb1eea3..73fbac05c8bd touches sync_linked_regs().
The following narrowing fill and spill patches (48dc0496cddb "bpf: Track
low-32 scalar equality across narrowing stack fills" and 3649346488fc "bpf:
Track low-32 scalar equality across narrowing stack spills") only add more
ZEXT/SEXT links that can reach this arm.

>  		/*
>  		 * Skip a pair of differing kinds. Where BPF_REG_LINK_FULL meets
> -		 * a 32-bit kind the delta relationship genuinely does not hold:
> -		 * the deltas were added at different ALU widths.
> -		 * BPF_REG_LINK_ZEXT against BPF_REG_LINK_SEXT is not that case
> -		 * -- both are base + delta in the low 32 bits, so narrowing one
> -		 * really does narrow the other -- but that deduction is
> -		 * declined on purpose. It makes an int loop counter a fresh
> -		 * constant on every iteration, so no two iterations prune
> -		 * against each other and the program runs to the instruction
> -		 * limit. See sext_no_sync_from_zext_sibling.
> +		 * a 32-bit kind the delta relationship does not hold over all
> +		 * 64 bits: the deltas were added at different ALU widths. For a
> +		 * wide member the low half still relates and the arm above has
> +		 * already recovered it; a member that fits 32 bits does not
> +		 * reach that arm and is skipped outright. BPF_REG_LINK_ZEXT
> +		 * against BPF_REG_LINK_SEXT is not that case -- both are base +
> +		 * delta in the low 32 bits, so narrowing one really does narrow
> +		 * the other -- but that deduction is declined on purpose. It
> +		 * makes an int loop counter a fresh constant on every
> +		 * iteration, so no two iterations prune against each other and
> +		 * the program runs to the instruction limit. See
> +		 * sext_no_sync_from_zext_sibling.
>  		 */
>  		if (reg->link_kind && known_reg->link_kind &&
>  		    reg->link_kind != known_reg->link_kind)

This comment says that when BPF_REG_LINK_FULL meets a 32-bit kind, a wide
member has already been handled by the arm above and only a member that fits
32 bits is skipped.  Is that split by member width accurate?

The arm above only runs when known_reg is the ZEXT/SEXT side and reg is the
NONE/FULL side.  In the other direction, known_reg FULL and reg SEXT, the
pair always reaches this continue, and a SEXT member can be wide in the
get_reg_width() sense, since negative (s32) values give a umax up to
U64_MAX.

sext_no_sync_when_base_has_delta is exactly this case: r8 = r6 + 3 is FULL,
r7 = (s32)r6 is SEXT, and "if r8 != 3" narrows nothing in r7.  The code
splits by which side is narrow (direction), not by member width.

Could the comment describe it by direction instead, i.e. only a narrow
known_reg reaches the arm above, and a FULL known_reg is skipped against any
32-bit member?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39458500836
--===============8247120795320158940==--
