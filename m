Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044676;
	b=tLMjMN9l9kgZj0s7pygB2kDRzH4T9jVIHJAQl0dWzI9neHXXoVBEVXQBWLiT+3k9Tgq0
	 pATkeL5RAb99zeFiF3tmkQWmGsYFDHDf/CkfqxZOmSE8Y+6jUEMgvbLYn5ubR/izuK+ZT
	 /v/o4xOq1panlY7eLU75ZxSAB8EnFG9oWcoAV93ia6W5p2VVLjTtejQpG+4O/mr4ygUKb
	 2tRlKKXw3l+3Uny3ldw45nMV3fOpLfA4wpJOCReaXdDLh46ZZrZeIOEaM7kVtjhEvDsei
	 6juZp4bRuxGIBXGhIrewYHBYvRxr9MogDEBT3DlCsZL+NEJE3U0+hV0269Ocu7zxVww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044676;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=g3XwBSXQoA0qPzZFtFCqB7EoEajnNaPSrIUH0dzjbVo=;
	b=2NkQFnCzVQF8Xq+QvWlTQ/1esT/liPuWgwNjenom+E0129R5b/aAUwI+mNOa7+TFk2/g
	 PyNCwy+jQ7RGW78iAReigxQOvljEogHo89L239FCEg/D1m9t07adzj6PI/5DC4ri1HjRi
	 BgjVRgX4cInro5DYZSpfrwi0egS21kFpoXbXY8uT2kRmBmh28AL0u0Cah3Jy87N40+UTF
	 jLfLPeeYFRs8c0zZELNyCmzu+7PGhDGT9t8y2N8WUMr8Qv0mWamOMumDftysa7/8hTYME
	 3e4ijCODQLl0Od8FxRWSvJ7ehzWTx4ViiedV8hcWaBhKXGtVHhCc0/nHFDrgYMwbGVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="dA+f/wTO";
	arc=none smtp.remote-ip=95.215.58.240
Received: from mta1.migadu.com (out-240.mta1.migadu.com [95.215.58.240])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B569606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 19:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B569606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dA+f/wTO
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NMx3N0v6PsNxCVDUZYyaWdpJfoRbxbLnwXsxe0hfnqQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793044672; v=1; x=1793649472;
 b=dA+f/wTOrtzqBPSZpBAFnioww+g9gWqKYD9ghEa2fsX4+aNDREEsrqMx+64xOmIviPbuQloW
 W74VOr3bMOpm/v2jrMBjODrnU06Rj2BpLL7q21sSP4f+QgMEioDs0le2h2Q/1gL9szG77D0dSxI
 +9W+Ut1NCz6Jl4eOjYTceut0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 75bb7fa52e467f2c;
	Mon, 26 Oct 2026 19:57:52 +0000
X-Mizu-Trace-ID: 75bb7fa52e467f2c
X-Migadu-Flow: FLOW_OUT
Message-ID: <4708ef0d-ac09-43a4-86dd-fd60686bba71@linux.dev>
Date: Mon, 26 Oct 2026 12:57:43 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 08/12] bpf: Recover the low 32 bits on the
 reverse link direction
To: bot+bpf-ci@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261020161907.2115379-9-vineet.gupta@linux.dev>
 <df21389eff01ccc8739c2baa97fe5832fb09da46617cb05d6337bc9ef0968adc@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <df21389eff01ccc8739c2baa97fe5832fb09da46617cb05d6337bc9ef0968adc@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/26 9:53 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Recover the low 32 bits on the reverse link direction
> TL;DR:
> - New sync_linked_regs() arm may intersect contradictory 32-bit ranges to
>    empty, triggering verifier bug WARN or -EFAULT on valid programs; no prev
>    restore
> - Comment on width split is inaccurate (nit)
>
>> @@ -18785,29 +18785,54 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>>   		if (reg->id != known_reg->id)
>>   			continue;
>>   		/*
>> -		 * The reverse direction does not work for a narrow known_reg:
>> -		 * it knows only its low 32 bits, which say nothing about a
>> -		 * wider reg's high half. Neither (u32)(base + delta) nor
>> -		 * (s32)(base + delta) inverts once the base is wider than 32
>> -		 * bits.
>> +		 * The reverse direction, from a narrow known_reg to a wider
>> +		 * reg, does not invert: neither (u32)(base + delta) nor
>> +		 * (s32)(base + delta) says anything about the base's high
>> +		 * half. It does still pin the low half, though -- both sides
>> +		 * are (base + delta) mod 2^32, differing only by their deltas
>> +		 * -- so recover that much and leave the high half alone.
>>   		 */
>>   		if ((known_reg->link_kind == BPF_REG_LINK_ZEXT ||
>>   		     known_reg->link_kind == BPF_REG_LINK_SEXT) &&
>>   		    reg->link_kind != BPF_REG_LINK_ZEXT &&
>>   		    reg->link_kind != BPF_REG_LINK_SEXT &&
>> -		    get_reg_width(reg) > 32)
>> -			continue;
>> +		    get_reg_width(reg) > 32) {
>> +			/*
>> +			 * Only @low's 32-bit half is meaningful: its var_off
>> +			 * is advanced over all 64 bits while r64 and the
>> +			 * base/step line are not, and nothing below reads
>> +			 * either. It is a scratch value, not a register state.
>> +			 */
>> +			struct bpf_reg_state low = *known_reg;
>> +			struct tnum low32;
>> +
>> +			fake_reg.type = SCALAR_VALUE;
>> +			__mark_reg_known(&fake_reg,
>> +					 (s64)reg->delta - (s64)known_reg->delta);
>> +			scalar32_min_max_add(&low, &fake_reg);
>> +			low.var_off = tnum_add(low.var_off, fake_reg.var_off);
>> +
>> +			cnum32_intersect_with(&reg->r32, low.r32);
>> +			low32 = tnum_intersect(tnum_subreg(reg->var_off),
>> +					       tnum_subreg(low.var_off));
>> +			reg->var_off = tnum_with_subreg(reg->var_off, low32);
>> +			reg_bounds_sync(reg);
>> +			goto scratched;
>> +		}
> Can the cnum32_intersect_with(&reg->r32, low.r32) above produce an empty
> range here?

Yes, good catch.

Following test loads successfully and then prints the empty range warning.

     call bpf_get_prandom_u32
     r6 = r0
     r6 <<= 32
     call bpf_get_prandom_u32
     r6 |= r0        /* r6 = full 64-bit unknown */
     w7 = w6            /* r7 is the zero extension */
     r8 = (s32)r6        /* r8 is the sign extension */
     if w7 != 5 goto 1f    /* new arm pins (u32)r6 to 5 */
     if w8 != 6 goto 1f    /* would pin it to 6 as well */
     r9 = 0
     r6 %= r9
     1:    r0 = 0
     exit


> The differencing arm further down in sync_linked_regs() saves prev and
> guards against exactly that:
>
>      struct bpf_reg_state prev = *reg;
>      ...
>      if (range_bounds_violation(reg))
>              *reg = prev;
>      reg_bounds_sync(reg);
>
> Its comment explains that an empty intersection means the two sides
> contradict, that reg_bounds_sync() refuses to touch an empty range, and that
> the first later reg_bounds_sanity_check() would report it as a verifier bug.
> The new arm has no such fallback, so reg_bounds_sync() returns early on the
> empty r32, and tnum_intersect() of two contradicting constants gives an
> arbitrary const subreg.

v4 will give the new arm same prev/restore this code has.

> A contradiction looks reachable because the wide base can know more about
> its low half than a ZEXT/SEXT member does.  FULL against ZEXT/SEXT and ZEXT
> against SEXT pairs are skipped by the link_kind check:
>
>      if (reg->link_kind && known_reg->link_kind &&
>          reg->link_kind != known_reg->link_kind)
>              continue;
>
> but the base learns from every member: from a FULL one through the
> differencing arm, and now from a ZEXT or SEXT one through this arm.  For
> example (cpuv4, no CAP_BPF delta needed):
>
>      call bpf_get_prandom_u32
>      r6 = r0              /* wide, id N */
>      w7 = w6              /* r7 ZEXT d0 */
>      r8 = (s32)r6         /* r8 SEXT d0 */
>      if w7 != 5 goto 1f   /* new arm: r6.r32 = {5}; r8 skipped (SEXT/ZEXT) */
>      if w8 != 6 goto 1f   /* r8 low half unknown -> both paths explored */
>      r0 = r6              /* fallthrough: new arm r6.r32 = {5} & {6} = EMPTY */
>    1: r0 = 0; exit
>
> On the fallthrough of "if w8 != 6", r8.r32 is {6}.  r6 is still wide, since
> after the first sync its r64 is [5, 0xffffffff00000005] and get_reg_width()
> returns 64.  cnum32_intersect({5,0},{6,0}) returns CNUM32_EMPTY.  The
> "r0 = r6" mov then reaches reg_bounds_sanity_check(env, ..., "alu") at the
> end of check_alu_op() with "range bounds violation", and verifier_bug()
> fires BPF_WARN_ONCE.  That is a real WARN_ONCE under CONFIG_DEBUG_KERNEL (and
> a panic with panic_on_warn), and it logs "verifier bug: REG INVARIANTS
> VIOLATION".  With BPF_F_TEST_REG_INVARIANTS, which test_loader sets by
> default, the load fails with -EFAULT.
>
> The same thing happens with a FULL member in place of the SEXT one
> (r8 = r6; r8 += 3; if w8 != 8 ...; if w7 != 6 ...), where both r6 and r8
> end up with an empty r32.  Before this patch the guard simply did continue
> for these pairs, so the program verified cleanly.

Confirmed, that variant reaches empty range too. It exercises the two 
arms in sequence rather than this one twice.

FWIW, guarding only the new arm would have been enough for my first 
reproducer; it is this variant that shows both sites need the same 
post-condition. v4 routes both through one helper, which also takes the 
two gaps sashiko raised on 4/12 and 6/12: tnum_overlap() before 
tnum_intersect(), and a second range_bounds_violation() after 
reg_bounds_sync() rather than only before.


> This is the case zext_contradiction_keeps_range_sane was written to pin for
> the differencing arm.  Would saving prev = *reg before the intersection and
> restoring it on range_bounds_violation(), as the differencing arm does, work
> here?
>
> No later commit in bbd86cb1eea3..73fbac05c8bd touches sync_linked_regs().
> The following narrowing fill and spill patches (48dc0496cddb "bpf: Track
> low-32 scalar equality across narrowing stack fills" and 3649346488fc "bpf:
> Track low-32 scalar equality across narrowing stack spills") only add more
> ZEXT/SEXT links that can reach this arm.
>
>>   		/*
>>   		 * Skip a pair of differing kinds. Where BPF_REG_LINK_FULL meets
>> -		 * a 32-bit kind the delta relationship genuinely does not hold:
>> -		 * the deltas were added at different ALU widths.
>> -		 * BPF_REG_LINK_ZEXT against BPF_REG_LINK_SEXT is not that case
>> -		 * -- both are base + delta in the low 32 bits, so narrowing one
>> -		 * really does narrow the other -- but that deduction is
>> -		 * declined on purpose. It makes an int loop counter a fresh
>> -		 * constant on every iteration, so no two iterations prune
>> -		 * against each other and the program runs to the instruction
>> -		 * limit. See sext_no_sync_from_zext_sibling.
>> +		 * a 32-bit kind the delta relationship does not hold over all
>> +		 * 64 bits: the deltas were added at different ALU widths. For a
>> +		 * wide member the low half still relates and the arm above has
>> +		 * already recovered it; a member that fits 32 bits does not
>> +		 * reach that arm and is skipped outright. BPF_REG_LINK_ZEXT
>> +		 * against BPF_REG_LINK_SEXT is not that case -- both are base +
>> +		 * delta in the low 32 bits, so narrowing one really does narrow
>> +		 * the other -- but that deduction is declined on purpose. It
>> +		 * makes an int loop counter a fresh constant on every
>> +		 * iteration, so no two iterations prune against each other and
>> +		 * the program runs to the instruction limit. See
>> +		 * sext_no_sync_from_zext_sibling.
>>   		 */
>>   		if (reg->link_kind && known_reg->link_kind &&
>>   		    reg->link_kind != known_reg->link_kind)
> This comment says that when BPF_REG_LINK_FULL meets a 32-bit kind, a wide
> member has already been handled by the arm above and only a member that fits
> 32 bits is skipped.  Is that split by member width accurate?

Nope. The arm is gated on which side carries the 32-bit kind:

     if ((known_reg->link_kind == BPF_REG_LINK_ZEXT ||
          known_reg->link_kind == BPF_REG_LINK_SEXT) && ...

so a BPF_REG_LINK_FULL known_reg never reaches it.

> The arm above only runs when known_reg is the ZEXT/SEXT side and reg is the
> NONE/FULL side.  In the other direction, known_reg FULL and reg SEXT, the
> pair always reaches this continue, and a SEXT member can be wide in the
> get_reg_width() sense, since negative (s32) values give a umax up to
> U64_MAX.
>
> sext_no_sync_when_base_has_delta is exactly this case: r8 = r6 + 3 is FULL,
> r7 = (s32)r6 is SEXT, and "if r8 != 3" narrows nothing in r7.  The code
> splits by which side is narrow (direction), not by member width.
>
> Could the comment describe it by direction instead, i.e. only a narrow
> known_reg reaches the arm above, and a FULL known_reg is skipped against any
> 32-bit member?

The comment now describes it by direction, and names that test.

Thx,
-Vineet

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39458500836

