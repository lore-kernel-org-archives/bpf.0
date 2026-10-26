Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793047614;
	b=SnFpA4tIJh9+YVdTj9v6HkeCrY9X/XrFRCaEucuuX7qWqaWbFuOhE4BOWDSJz6Qo+KHl
	 q19VNidJiq3RA8AXmPPKSip8wrXWWRwHJ3INVopuJnTlLoY75ehlg831ypIQzpO3+ZorM
	 T7+YIimnBps5DaJXxZQGfwZ+493qQT46r5fzEclyWjGJcpGBLDBmD1I0LCk0ICb0e8J36
	 Y8YzfnW6rUVhoxTZdH5+6NNtwVjqKaRZxGlPM6LEWU/hcDEwb9YyPJT16qZ09ejSAD60t
	 dGfgz8nM40mFnn3TJua3Cntkh5vmF0mdu2CX4U1uFmlh1zUQPEvcTw8gIDpme+TqeUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047614;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kh5e2W/fnEYGpxBeGCaqV9/JbXLam61+Dk9J7TB/zlA=;
	b=w0EVj8m2qsMMEWndkStUjqgEt8U2Gg0y6xYGB3pkIH4n5MwgaO3u0GCxUL8+ookcGRr2
	 2naJrbcNccZ1JBqaZgsk5k4ZJ++aPrSWlZzA4gcITT4HkuYQdDjtVbcJY79Q/d6e1q1D0
	 3sFWCldrpXk77aEZly0S4PjeV5/xVn4fm783ghBdaVOpEQ7Xtr01aGS3saH4MSf1hEhPr
	 AdKVTCk6dQrxS7KHw5XgIel/q0NmsUEd5mBKIWCJ31rCU7UZz0/T++OiSuTdGvlc/qm4B
	 vTLIX4Sg6+HFNUy76vrpS2bO0ki8tcCgH0cefOGhosjaorNRSeu5dLIogdhRpWtKxkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=onB49kUt;
	arc=none smtp.remote-ip=91.218.175.77
Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925E606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 20:46:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2925E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=onB49kUt
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C4Y13M+jrENBRCet6RI0EFW34E6acTeziluGPaYgzMg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793047610; v=1; x=1793652410;
 b=onB49kUt0BJOzdc8ukrKdL3OTPSXIiiEx2fxGvUojzpSnnFjRCP92hfR8Vmy5gjiTtuWRFPz
 Qr9DbGybS6JyS4cguMls/Baql4WYbtsacKY0yAXdGO08864Sp0/+/2v+2HXZNYnQtLbnkGC0Yf1
 hh8TaGBPS5zKpDW6W/3W6ouY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 415063d7dbed8587;
	Mon, 26 Oct 2026 20:46:50 +0000
X-Mizu-Trace-ID: 415063d7dbed8587
X-Migadu-Flow: FLOW_OUT
Message-ID: <8653c48c-8bdb-40be-adf7-8ea2db8f4298@linux.dev>
Date: Mon, 26 Oct 2026 13:46:45 -0700
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
Subject: Re: [PATCH bpf-next v3 06/12] bpf: Track low-32 scalar equality
 across sign-extending movs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-7-vineet.gupta@linux.dev>
 <sashiko-outbox-179390@kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-179390@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/20/26 9:57 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: empty range after reg_bounds_sync() in sync_linked_regs()
> --
>
> commit ad01f18c15eb8cfa9a97b984758db9dd254aace2
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> bpf: Track low-32 scalar equality across sign-extending movs
>
> This commit adds BPF_REG_LINK_SEXT to track low-32 scalar equality across
> 32-bit sign-extending moves, using sext_32_to_64() and tnum_sext() to
> propagate bounds in sync_linked_regs().
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6afd718ede647..4621b476b206e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -6090,6 +6090,25 @@ static void zext_32_to_64(struct bpf_reg_state *reg)
>>   	reg_set_urange64(reg, reg_u32_min(reg), reg_u32_max(reg));
>>   }
>>   
>> +/*
>> + * The sign-extending counterpart. Signed bounds carry over directly because
>> + * sign extension is monotonic over the signed 32-bit range.
>> + */
>> +static void sext_32_to_64(struct bpf_reg_state *reg)
>> +{
>> +	/*
>> +	 * See comment at reg_step_check_unsigned(). Sign extension subtracts
>> +	 * 2^32 from every value with bit 31 set, which preserves a residue
>> +	 * mod step only when step divides 2^32, so the line cannot be kept.
>> +	 * The zero-extending twin calls reg_step_check_unsigned(reg, 32) for
>> +	 * the same reason; the unsigned form does not apply here because the
>> +	 * result is not the low 32 bits but the low 32 bits moved.
>> +	 */
>> +	reg_step_reset(reg);
>> +	reg->var_off = tnum_sext(reg->var_off, 4);
>> +	reg_set_srange64(reg, reg_s32_min(reg), reg_s32_max(reg));
>> +}
> [ ... ]
>> @@ -18795,9 +18843,26 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>>   			scalar32_min_max_add(reg, &fake_reg);
>>   			scalar_min_max_add(reg, &fake_reg);
>>   			reg->var_off = tnum_add(reg->var_off, fake_reg.var_off);
>> -			if (reg->link_kind == BPF_REG_LINK_ZEXT ||
>> -			    known_reg->link_kind == BPF_REG_LINK_ZEXT)
>> +			if (reg->link_kind == BPF_REG_LINK_SEXT) {
>> +				sext_32_to_64(reg);
>> +			} else if (reg->link_kind == BPF_REG_LINK_ZEXT ||
>> +				   known_reg->link_kind == BPF_REG_LINK_ZEXT ||
>> +				   known_reg->link_kind == BPF_REG_LINK_SEXT) {
>> +				/*
>> +				 * Either @reg is itself the zero extension, or
>> +				 * @reg has no 32-bit kind and @known_reg does
>> +				 * -- the reverse direction, where the guard
>> +				 * above has already proved @reg fits 32 bits.
>> +				 * Then @reg is @known_reg's low half with
>> +				 * nothing above it, whichever way @known_reg
>> +				 * filled its own high half, so the zero
>> +				 * extension is the reconstruction for both
>> +				 * kinds. BPF_REG_LINK_FULL is not here on
>> +				 * purpose: it relates all 64 bits and must not
>> +				 * be truncated.
>> +				 */
>>   				zext_32_to_64(reg);
>> +			}
>>   			/*
>>   			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
>>   			 * link over a wide base does not propagate back, so the
> [Severity: Medium]
> Can sync_linked_regs() leave reg with CNUM64_EMPTY and CNUM32_EMPTY after
> reg_bounds_sync(), triggering a register invariants violation on the next
> instruction that inspects the register?

Yes and actually two things:

  - tnum_intersect() has no tnum_overlap() precheck, so two disagreeing 
known bits become a known 1 rather than a detected contradiction.
  - range_bounds_violation() tests only cnum32/64_is_empty, and it runs 
*before* reg_bounds_sync(). A contradiction that only materialises 
inside the sync through __update_reg_bounds() or 
deduce_bounds_32_from_64() is therefore not caught by the restore that 
4/12 added.

So the guard added in 4/12 is narrower than the problem it is named for.

The reproducer in your 4/12 report does not fire, though, and the log 
says why. Built as a socket filter on a patch-10 kernel it verifies 
clean, and the walk goes 0..7 then straight to 10:

       5: R7=scalar(id=1+0,...,var_off=(0x4; 0x1))
       6: (45) if r6 & 0x2 goto pc+1
       6: R6=scalar(id=1,...,var_off=(0x4; 0xffffffff00000001))
       7: (05) goto pc+2
      10: (b7) r0 = 0

The "r9 = 0; r7 %= r9" pair at 8 and 9 is never walked. r6's var_off has 
bit 1 known zero: value 0x4, and bit 1 is not in the mask, so "if r6 & 
2" is resolved statically and the contradicting path is pruned.

r6 knows that because of 8/12 itself: its reverse arm pinned the base's 
low half from r7, which is why R6 carries smin32/umin32=4, 
smax32/umax32=5 and the low var_off (0x4; 0x1) by instruction 6. The 
same issue hid the original 4/12 bug, 8/12 keeps masking things rather 
than fixing them.

Rather than keep on chasing which reproducers survives patch 8's 
masking, v4 does what you suggested at the end of the 4/12 report: ask 
tnum_overlap() before tnum_intersect(), and check 
range_bounds_violation() after reg_bounds_sync() as well as before. Both 
arms now go through one helper:

     static void sync_bounds_or_revert(struct bpf_reg_state *reg,
                       const struct bpf_reg_state *prev)
     {
         if (range_bounds_violation(reg)) {
             *reg = *prev;
             return;
         }
         reg_bounds_sync(reg);
         if (range_bounds_violation(reg))
             *reg = *prev;
     }

Thx,
-Vineet



> At the end of the differencing block in sync_linked_regs():
>
> 	cnum64_intersect_with(&reg->r64, prev.r64);
> 	cnum32_intersect_with(&reg->r32, prev.r32);
> 	reg->var_off = tnum_intersect(reg->var_off, prev.var_off);
> 	if (range_bounds_violation(reg))
> 		*reg = prev;
> 	reg_bounds_sync(reg);
>
> range_bounds_violation(reg) is only checked before reg_bounds_sync(reg),
> and tnum_intersect() is called without checking tnum_overlap(). When a
> contradiction occurs across domains (between r64, r32, and var_off) rather
> than within r64 or r32 individually, the pre-sync range_bounds_violation()
> check passes, and reg_bounds_sync(reg) then turns the cross-domain
> disjointness into CNUM64_EMPTY / CNUM32_EMPTY without restoring prev.
>
> This can be triggered in two ways with BPF_REG_LINK_SEXT:
>
> 1. Cross-domain contradiction between r64 and r32 via sext_32_to_64():
>
>     Suppose r6 is a 64-bit unknown scalar and r7 = (s32)r6 links r7 to r6
>     with BPF_REG_LINK_SEXT.
>
>     - Narrow r7 with signed 64-bit jumps to [-0x7ffffff0, 0x7ffffff0], so
>       r7.r64 is [-0x7ffffff0, 0x7ffffff0] and r7.r32 is the arc
>       [0x80000010, 0x7ffffff0].
>     - Execute if w6 < 0x7ffffff0 goto out. Because [0x7ffffff0, 0xffffffff]
>       and [0x80000010, 0x7ffffff0] overlap in two disjoint arcs,
>       cnum32_intersect() over-approximates by keeping the smaller arc
>       [0x7ffffff0, 0xffffffff] for r6.r32 and r7.r32, while r7.r64 remains
>       [-0x7ffffff0, 0x7ffffff0].
>     - Execute if w6 != w8 goto out where w8 has r32 = [0x7ffffff8, 0x80000007].
>     - In sync_linked_regs() for r7, reg->r32 is [0x7ffffff8, 0x80000007],
>       which straddles S32_MAX / S32_MIN. sext_32_to_64(reg) sets reg->r64 to
>       [S32_MIN, S32_MAX].
>     - Intersecting reg->r64 with prev.r64 gives [-0x7ffffff0, 0x7ffffff0]
>       (non-empty) and intersecting reg->r32 with prev.r32 gives
>       [0x7ffffff8, 0x80000007] (non-empty).
>     - range_bounds_violation(reg) is false, so *reg = prev is skipped.
>     - reg_bounds_sync(reg) calls deduce_bounds_32_from_64(reg), which
>       intersects [0x7ffffff8, 0x80000007] with [0x80000010, 0x7ffffff0] and
>       leaves reg->r32 = CNUM32_EMPTY and reg->r64 = CNUM64_EMPTY.
>
> 2. Contradiction between var_off and r64/r32 via tnum_intersect():
>
>     Suppose r6 is a 64-bit unknown scalar, r7 = (s32)r6, and r7 is narrowed
>     to [-4, 3].
>
>     - Execute if w6 & 8 goto out. On the fallthrough branch,
>       regs_refine_cond_op() calls __mark_reg_unbounded(&r6) and clears bit 3
>       in var_off; sync_linked_regs() narrows r7 to [0, 3] with
>       var_off = TNUM(0, 3).
>     - Execute if w6 & 4 goto target. On the taken branch, r6 gets low-32
>       var_off = TNUM(4, 0xfffffff3) and r32 = [-0x7ffffffc, 0x7ffffff7].
>     - In sync_linked_regs() on r7, cnum64_intersect_with() and
>       cnum32_intersect_with() both produce [0, 3] (non-empty), while
>       tnum_intersect() without a tnum_overlap() check combines
>       TNUM(4, 0xfffffffffffffff3) and TNUM(0, 3) into TNUM(4, 3) ([4, 7]).
>     - range_bounds_violation(reg) is false before reg_bounds_sync(reg), and
>       __update_reg_bounds() inside reg_bounds_sync(reg) then intersects
>       [0, 3] with [4, 7], leaving r7 with CNUM32_EMPTY and CNUM64_EMPTY.
>
> Should sync_linked_regs() check !tnum_overlap(reg->var_off, prev.var_off)
> and also check range_bounds_violation(reg) after reg_bounds_sync(reg) before
> committing the updated state?
>
>>   			/*
>>   			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
>>   			 * link over a wide base does not propagate back, so the
> [ ... ]
>

