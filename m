Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056027;
	b=AgkjpxUV4MLQC9fFCckB9VgPZFWeYYGx95foBpefGSYZIMHtjFDxKaVyOXp86ZnuQIuF
	 999ewL0cUv9xO39k7EVkv2WrBo7Br7XEY9O4tkzdQBVf3aKvX4n1sfT/AfgCwtQvmcxIz
	 0rTD/uTsG+uipVdmAgfrFsACHCtztou1ub39mAypVDX1xsKhvA2Ien8XJjOUiRC7EUl1q
	 fqxi7/Q+3y8ZrvF0fj8Ysuf5Ut+zd6mHO+dZKgf0ApkuYGYl/CftEEMqVlCgxM4Xwh8oA
	 exFv7DFhftZtq8MqPGcDA4XEXJ2JE72dc9hmOfGgFyM1iwx4fi4TT6m+sN2Qsl68SvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056027;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MmCr4GWGRh0uwYsGnfv+lbVyfI96m/7W5/i1rwe1uaI=;
	b=O6NRbJ/KJUyUqbMN6Ls3lvVl6d1XgYp26grkcfS80YzyPTfprTYI1u1ewFBOmdZubPrT
	 rQ854r/ORA7eso77e/hYcMGs+fsroK/3TkIohvLy3qUWUSllJwcdIrHTulPkmAFnt8eon
	 ZEYeU1j4M0r9wBPi07QQzbIttaOLd2vL1Gmwb0ZUR7zVOvhN3bPc7BDv6eEHJwlIWfPW7
	 z1cY3FU+wiYdoBXmBQs6EJUEjAt2+swca/RvpkNqJl88bNH7ye7BdIXwryb9yLDGVD++Q
	 N1LqcHisiOQYkkivNydtESo9O6+oq5lnIstIZpluoiCTDb98vedJZQ5jF1HoWIfgXoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.108
Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A58606A327
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05A58606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RoUshqVKi1ljNDPmLDkiOgHJlgJjpKr22TIGJgZYagU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793056024; v=1; x=1793660824;
 b=xucMTRbVYDG8qDBLS7ajm2GWJpoPOY2Ie12+9+C1fcatgQO2pSh0hOreVUl3W8NJB/Zvje1e
 W7iw+2mfUOnYVDpFjpVptBUXPnq1wjelciFdhUa0cFF0ZSr0pyhPFjITXvj1xQZMDoYDl7XDh4a
 kRPX3wH/S+PViI/dgYgXcsKw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e482058481cc1443;
	Mon, 26 Oct 2026 23:07:03 +0000
X-Mizu-Trace-ID: e482058481cc1443
X-Migadu-Flow: FLOW_OUT
Message-ID: <a298b36d-25a9-42db-a044-177bdd7610fc@linux.dev>
Date: Mon, 26 Oct 2026 16:06:57 -0700
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
Subject: Re: [PATCH bpf-next v3 04/12] bpf: Track low-32 scalar equality
 across zero-extending movs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-5-vineet.gupta@linux.dev>
 <sashiko-outbox-179367@kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-179367@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 9:39 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: empty or corrupted range after intersection in sync_linked_regs()
> --
>
> commit 05d23d7192de1c6009703f8fbe1537ad78dda89e
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> bpf: Track low-32 scalar equality across zero-extending movs
>
> This commit extends linked-scalar tracking across zero-extending 32-bit moves
> from wide 64-bit source registers using BPF_REG_LINK_ZEXT. Because a wide base
> cannot be inverted across all 64 bits, sync_linked_regs() propagates bounds
> forward only and intersects the derived bounds with the destination register's
> existing state.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b9c20a5cc6d6f..6afd718ede647 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -18749,6 +18798,27 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>>   			if (reg->link_kind == BPF_REG_LINK_ZEXT ||
>>   			    known_reg->link_kind == BPF_REG_LINK_ZEXT)
>>   				zext_32_to_64(reg);
>> +			/*
>> +			 * Intersect rather than overwrite. A BPF_REG_LINK_ZEXT
>> +			 * link over a wide base does not propagate back, so the
>> +			 * base can be wider than what @reg has already proved
>> +			 * about itself; replacing it would lose that.
>> +			 */
>> +			cnum64_intersect_with(&reg->r64, prev.r64);
>> +			cnum32_intersect_with(&reg->r32, prev.r32);
>> +			reg->var_off = tnum_intersect(reg->var_off, prev.var_off);
>> +			/*
>> +			 * An empty intersection means the two sides contradict,
>> +			 * so this path is unreachable. Say nothing rather than
>> +			 * say it with an empty range: reg_bounds_sync() below
>> +			 * refuses to touch one, and the first later
>> +			 * reg_bounds_sanity_check() would report it as a
>> +			 * verifier bug, which it is not. Keeping the wider
>> +			 * pre-intersect state only costs precision on a path
>> +			 * that cannot be taken.
>> +			 */
>> +			if (range_bounds_violation(reg))
>> +				*reg = prev;
>>   			reg_bounds_sync(reg);
>>   		}
>>   		if (e->is_reg)
> [Severity: Medium]
> Can a contradiction in var_off or linear step still leave an empty range on
> reg, or corrupt reg into a bogus constant, after sync_linked_regs() finishes?

Yes to both. I answered the shared half on 6/12 report: v4 route both 
arms with one helper which checks range bound both before and after the 
sync.


> First, tnum_intersect() in kernel/bpf/tnum.c assumes its arguments overlap:
>
> /* Note that if a and b disagree - i.e. one has a 'known 1' where the other has
>   * a 'known 0' - this will return a 'known 1' for that bit.
>   */
> struct tnum tnum_intersect(struct tnum a, struct tnum b)
> {
> 	u64 v, mu;
>
> 	v = a.value | b.value;
> 	mu = a.mask & b.mask;
> 	return TNUM(v & ~mu, mu);
> }
>
> When reg->var_off and prev.var_off disagree on a known bit without
> tnum_overlap(reg->var_off, prev.var_off) being checked first, tnum_intersect()
> turns the conflicting bit into a known 1.
>
> Second, range_bounds_violation(reg) only checks cnum32_is_empty(reg->r32) ||
> cnum64_is_empty(reg->r64), and is only called before reg_bounds_sync(reg). Any
> contradiction between the intersected r64/r32 ranges and var_off (via
> __update_reg_bounds()) or base/step (via __update_bounds_from_step()) happens
> inside reg_bounds_sync(reg), after the range_bounds_violation(reg) check has
> already passed.
>
> For example, in a socket filter:
>
>    w7 = w6;                /* r6 is unknown 64-bit; r7 gets BPF_REG_LINK_ZEXT */
>    if w7 < 4 goto out;
>    if w7 > 5 goto out;
>    if w7 & 2 goto out;     /* r7: r64=[4, 5], var_off=(0x4; 0x1) */
>    if r6 & 2 goto l1;
>
> At l1, r6 has var_off=(0x2; ~2ULL), so after zext_32_to_64(reg), reg has
> r64=[2, U32_MAX] and var_off=(0x2; 0xfffffffd). Intersecting r64 and r32 with
> prev produces [4, 5], which is non-empty, so range_bounds_violation(reg) is
> false. However, tnum_intersect() produces (0x6; 0x1) ([6, 7]), and
> reg_bounds_sync(reg) then intersects [4, 5] with [6, 7], leaving reg->r64 and
> reg->r32 empty and triggering a verifier warning on a subsequent r7 %= r9 (with
> r9 = 0).
>
> Worse, if w7 was narrowed to a single constant 4 (r64=[4, 4],
> var_off=(0x4; 0x0)) before "if r6 & 2 goto l1", tnum_intersect() fabricates
> the constant var_off=(0x6; 0x0)... calls ___mark_reg_known(reg, 6), overwriting
> r7 == 4 with the contradicted constant r7 == 6.

This is not empty range, but wrong value.

> Even when tnum_overlap(reg->var_off, prev.var_off) holds, reg_bounds_sync(reg)
> can still empty r64/r32 if the intersected cnum range and intersected tnum (or
> base/step in __update_bounds_from_step()) have no common points.
>
> Should sync_linked_regs() verify tnum_overlap(reg->var_off, prev.var_off)
> before calling tnum_intersect(), and also check range_bounds_violation(reg)
> after reg_bounds_sync(reg) to restore *reg = prev?

Yes to both.

Thx,
-Vineet
