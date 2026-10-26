Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.166
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793050092;
	b=UsJ5L3gLkQKSnTF4GM7P3FbDAEvYAU18x//uBfTzhvfI9BDil3FwpFQyNkjo1CYOafCZ
	 s4aV13MRY9c0Q1slCVAj1dgC8HiNq1AqFG6qE7sIQsVRk5yYhONMEEaXJjbj+s/UNJqH6
	 oDd7VnmRGDQlfcupF2IiJATYH1iEQ3wdQz5WneFBQDx6Cf423bRx0hg847n4Dmd9Au4RW
	 47SZAQtUdd3rl2/C+x0qZA6NlPYpM67+DsCCxJYwRoTYkoRn9eFP6GvfptVVjsp2hP8AT
	 B0hKce/w4WBJ4xoTBz84jLp5TCp5js+sFgvCyo+UEq/aloZKYkdv5JIa8oBtxCOnjCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793050092;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MbEaTxg11MNpI/ay9Hge0y4ZrafbNUjG76SIqaDfh/A=;
	b=ZDE2/a4b4Rdw2h2bHBNwg1pNmZS2BIYzGCnTU1zSxnGvg6WN72b+dt25V2rHSuEWNJfH
	 ocSsbR8x6M/8zAfGi8kwfCUDIjVOhDCcUW3IYrFF+xvYMH8qKTk6Hzrks/kkorX/jqzsL
	 byvcWESOJ0FcWB7XilNiFwkMDvdi4VgSLT6/E6s4Vhpkx2IsS9X/txbzEDMTE444sKkQk
	 E9uy10ks1vbxDjlDlK6t/d2L1G0+/YDwilD7zilfatIja9eOfLIlhBJOqpVuH9P3yRzZp
	 2zhrYy2Kah6ck5vfDK2Ym8/bK6s2liOnq2y1GjOowvmSoqGoz9ahSSDBL/RyYSC40FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OLp2xCQv;
	arc=none smtp.remote-ip=91.218.175.166
Received: from mta0.migadu.com (out-166.mta0.migadu.com [91.218.175.166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95363606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 21:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95363606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OLp2xCQv
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xag79DefdHu/FlBZqmao+1OOuX1ZrSpqdMrWWzice7g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793050088; v=1; x=1793654888;
 b=OLp2xCQvPwCmAgCgVxWUkbddLH48pz6J+b+va5WD2psuKlbmXLvWAmlwWFWDAygDgCX8x99b
 s+1OG4bkKT9ANCr/q1THf2CFe1LjxqJ7OnUiMiSMCgvDnMW72VjiHBMIocRcFfgw3nq0LMaNR3F
 efZhjqsVbGVRXwY2KRrLtthg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3867c78bff9a6584;
	Mon, 26 Oct 2026 21:28:07 +0000
X-Mizu-Trace-ID: 3867c78bff9a6584
X-Migadu-Flow: FLOW_OUT
Message-ID: <287906ad-ddca-4f6e-9c25-e709f2b00393@linux.dev>
Date: Mon, 26 Oct 2026 14:28:05 -0700
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
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-9-vineet.gupta@linux.dev>
 <sashiko-outbox-179412@kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-179412@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/26 10:20 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: missing contradiction check in sync_linked_regs() reverse-direction arm
> --
>
> commit 651910c4895680e635057947cc88b56f4edbf401
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> bpf: Recover the low 32 bits on the reverse link direction
>
> This commit updates sync_linked_regs() in the BPF verifier to recover the low
> 32-bit bounds and subreg tnum when propagating from a narrow linked register
> (BPF_REG_LINK_ZEXT or BPF_REG_LINK_SEXT) back to a linked register wider than
> 32 bits.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4621b476b206e..ac50252cec1f7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
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
> [Severity: Medium]
> Can this reverse-direction arm leave reg with an empty range (CNUM32_EMPTY or
> CNUM64_EMPTY) or conflicting constant subreg bits when the low-32 bounds,
> var_off, or step progression of reg and known_reg contradict on an
> unreachable path?

Yeah bpf-ci bot asked the same and that is answered separately. What you 
mentioned is 4 ways, let me reply each below.

> In the sibling differencing arm further down in sync_linked_regs(), the code
> saves prev = *reg before intersecting and restores *reg = prev if
> range_bounds_violation(reg) holds:
>
> kernel/bpf/verifier.c:sync_linked_regs() {
> 	...
> 	cnum64_intersect_with(&reg->r64, prev.r64);
> 	cnum32_intersect_with(&reg->r32, prev.r32);
> 	reg->var_off = tnum_intersect(reg->var_off, prev.var_off);
> 	if (range_bounds_violation(reg))
> 		*reg = prev;
> 	reg_bounds_sync(reg);
> }
>
> In the new arm above, cnum32_intersect_with(&reg->r32, low.r32) and
> tnum_intersect() are applied directly without saving prev or checking for
> contradictions. If reg->r32 becomes CNUM32_EMPTY, reg_bounds_sync() exits
> early on range_bounds_violation(reg), and even when cnum32_intersect_with()
> is non-empty, reg_bounds_sync() can still empty reg->r32 or reg->r64 via
> __update_reg_bounds(), __reg_deduce_bounds(), or __update_bounds_from_step()
> when the narrowed low 32 bits contradict reg's 64-bit bounds, subreg tnum, or
> base/step progression. Similarly, if tnum_subreg(reg->var_off) and
> tnum_subreg(low.var_off) do not overlap (!tnum_overlap()), tnum_intersect()
> ORs conflicting constant bits together.
>
> Contradictions can reach this arm in several ways during check_cond_jmp_op()
> -> sync_linked_regs():
>
> 1. Mixed link kinds: if r6 is a wide unknown scalar (BPF_REG_LINK_NONE),
>     w7 = w6 (BPF_REG_LINK_ZEXT), and r8 = r6; r8 += 2 (BPF_REG_LINK_FULL),
>     narrowing r8 with if w8 != 7 goto out syncs r6->r32 to [5, 5] while
>     skipping r7 because r7->link_kind != r8->link_kind. A subsequent
>     if w7 != 9 goto out then enters the new arm for r6 and r8, intersecting
>     [5, 5] with [9, 9] and [7, 7] with [11, 11] to leave r6->r32 and r8->r32
>     as CNUM32_EMPTY.

Confirmed and this was the same as bpf-ci bot report.

> 2. Sign-extending mov (BPF_REG_LINK_SEXT): if a wide r6 has its low 32 bits
>     pinned by if w6 != 5 goto out (so r6->r32 is [5, 5]), r7 = (s32)r6 links
>     r7 with BPF_REG_LINK_SEXT while coerce_reg_to_size_sx() resets r7->r32 to
>     [S32_MIN, S32_MAX]. A following if w7 != 8 goto out enters the new arm
>     and intersects r6->r32 ([5, 5]) with [8, 8].

Confirmed.

     if w6 != 5 goto out    /* wide r6 gets r32 = [5, 5] */
     r7 = (s32)r6        /* SEXT */
     if w7 != 8 goto out    /* the new arm intersects [5,5] with [8,8] */

Note that since w6 is known to const 5, one would expect w7 to be a 
constant 5 as well:
coerce_reg_to_size_sx() decides whether the extension is a no-op from 
reg_smin()/reg_smax(), the 64-bit pair, which is wide here. So it takes 
set_sext64_default_val() and r7 comes out [S32_MIN, S32_MAX], unknown, 
and both branches are walked.

>
> 3. BPF_JSET fallthrough: in regs_refine_cond_op(), the BPF_JSET | BPF_X
>     fallthrough path calls __mark_reg_unbounded() before masking var_off.
>     After w7 = w6; if w6 == 0 goto out; (where r6->r32 is [1, U32_MAX]),
>     if w7 & -1 goto out refines r7 to 0 on fallthrough and syncs back to r6,
>     intersecting [1, U32_MAX] with [0, 0].

Confirmed.

     w7 = w6
     if w6 == 0 goto out    /* r6.r32 becomes [1, U32_MAX] */
     if w7 & -1 goto out    /* fallthrough refines r7 to 0 */
     r9 = 0
     r6 %= r9

All the 3 above are caught by the pre-sync check.

> 4. Step or tnum conflict inside reg_bounds_sync(): if a wide r6 has step > 1
>     (for example step == 3) and w7 = w6 resets r7->step to 1 via
>     zext_32_to_64(), narrowing w7 to a value in r6->r32 that is not a
>     multiple of 3 passes cnum32_intersect_with() and then becomes empty in
>     __update_bounds_from_step(r6) at the end of reg_bounds_sync().

This one is special as this is the only route where the contradiction is 
not visible at the point of intersection: cnum32_intersect_with() 
passes, and the range only empties later in __update_bounds_from_step().
This led to the final fix in v4: check both before and after sync.

Thx,
-Vineet

> When reg is left in this state, any subsequent instruction that checks it via
> reg_bounds_sanity_check() triggers verifier_bug() ("range bounds violation"),
> emitting a BPF_WARN_ONCE() and returning -EFAULT when
> BPF_F_TEST_REG_INVARIANTS is enabled.
>
> Should this arm save struct bpf_reg_state prev = *reg and restore *reg = prev
> if !tnum_overlap(tnum_subreg(reg->var_off), tnum_subreg(low.var_off)) or if
> range_bounds_violation(reg) is true after reg_bounds_sync(reg)?
>
> [ ... ]
>

