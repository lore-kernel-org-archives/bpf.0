Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052093;
	b=yQDHhQtL62dpRlzlDYrPtnEfEOP0GhT/VN0uRFTzidXX/CoNFps3AQBFs5jJ9+g5t5M3
	 UTSNag3NPYE0pq6myF//UxyushzRMWiJIS5PWlwycJUeF36PxovkbfBW1VTv9eZUqkgBd
	 tvENlcQxYwbFYfuUS9fgHxtmpsZy8QBQmgcZlRwKjzMTR3zd30NqFIgTwzGlXlYc2sBiO
	 /68Lz+hV1iQR9uIflHZYmsGN8bnsFwEF/E1kVz1Ga6wgdOzJqXk0doGorjBLixyvyRGDw
	 4YiQyhMi65ChruOnSVHfaTlewSOoblaVi7EigjbRdv9ANpkX1+M3lST9fKpAqyKUlyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052093;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=JfoDqe96Kwk1JhgIOwUU/4TvSCsIa9add42yravEH04=;
	b=v4saDl2+tbKNLyAl8o1YomfGmgd5l4WspzSmK/XP2k3U9yw0pO7H+RJr8jgaRmyclq/3
	 T0Jfvf15NRD16rjsn2eu5/sHJeZ6VKH0/X/9QAlDqOLKiwNYkwvYFkeDq2q2haDS7nOlI
	 aXkarbTUeV/yskDc9UKsT/38Mg3y6+4ND5+J5WOa8n5ivze0zX7ap8wBYmzHNjiN5X/QQ
	 Nb9YsZfGQnTzeV4i+K34ddlZbffZ/fIrWqOa9OZ7i/ScVd/ync94syT8OOOTWKc2lCcUd
	 bU/ZOdwBpf3+90nXd4v9EfsUAsMUkodzyChUGTLfjlTvdRVkZ9Pns19m+I/cLZPUJuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K2DGESd1;
	arc=none smtp.remote-ip=95.215.58.221
Received: from mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0628606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 22:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0628606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K2DGESd1
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d/XH3OknxfPjStHsj+pXLKFQsWfu7QdbdcYVcusQH88=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793052090; v=1; x=1793656890;
 b=K2DGESd1ORM+nfGVKFRn1bNSIcfkuCoHPjkJGL4Z/8dhPAxUPA9s5NpdIN9r4nwCdGBhDekk
 d3fN9p1kyWhnhDOZFxz59mJXu96m6aV1Ba6GycMUNuHfDLXxYWAsgsTBzfZ2VlR788evjAE0Ejl
 lDvVTJ4S4DHmvNrPZAzoZ9gA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 313bf9c5a9775fab;
	Mon, 26 Oct 2026 22:01:30 +0000
X-Mizu-Trace-ID: 313bf9c5a9775fab
X-Migadu-Flow: FLOW_OUT
Message-ID: <c6955dac-49bd-4b9a-9313-49f7b9753eb1@linux.dev>
Date: Mon, 26 Oct 2026 15:01:28 -0700
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
Subject: Re: [PATCH bpf-next v3 12/12] [do not merge] selftests/bpf: Cover the
 low-32 link for narrowing stack spills
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261020161907.2115379-1-vineet.gupta@linux.dev>
 <20261020161907.2115379-13-vineet.gupta@linux.dev>
 <sashiko-outbox-179354@kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-179354@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/26 9:32 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] selftests/bpf: fill before narrow in zext_narrowing_spill_byte_no_link()
> - [Medium] selftests/bpf: tautological test in sext_fill_of_narrowing_spill_drops_zext()
> - [Low] selftests/bpf: stale inline comment in zext_narrowing_spill_drops_link()
> --
>
> commit a341902044eb0b749136bbae6f269759e4c0ffcd
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> selftests/bpf: Cover the low-32 link for narrowing stack spills
>
> This patch adds six verifier selftests to verifier_linked_scalars.c to test
> low-32 register linking behavior across narrowing stack spills and subsequent
> fills.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> index ab78285153fb1..8ade4836e1b2f 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> @@ -1217,6 +1217,128 @@ __naked void zext_fill_byte_forms_no_link(void)
>>   	: __clobber_all);
>>   }
>>   
> [ ... ]
>
>> +/*
>> + * A narrowing spill stores only the source's low 32 bits, so the slot is their
>> + * zero-extension. Filling it back is a mov, though, and that drops the link
>> + * for the same reason zext_chain_drops_link does, so a later narrowing of the
>> + * source does not reach the filled register.
>> + */
>> +SEC("socket")
>> +__failure
>> +__msg("div by zero")
>> +__naked void zext_narrowing_spill_drops_link(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
>> +	*(u32 *)(r10 - 8) = r6;	/* narrowing spill, forms the link */ \
>> +	r2 = *(u32 *)(r10 - 8);	/* fill it back */		\
>> +	if w6 != 0 goto 1f;	/* narrows r6, propagates to r2 */ \
> [Severity: Low]
> This isn't a bug, but is this inline comment in
> zext_narrowing_spill_drops_link() left over from the earlier version of the
> test? Since the preceding fill into r2 drops BPF_REG_LINK_ZEXT, narrowing w6
> here does not propagate to r2.

Yes. It said the narrowing propagates to r2, which is the opposite of what
the test is named for. Fixed.


>> +	if r2 == 0 goto 1f;					\
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
> [ ... ]
>
>> +/*
>> + * A sub-word spill is below the low-32 model, so no link is formed there.
>> + * The fill is a byte load too, so this pins the spill-side and fill-side
>> + * size gates together rather than either on its own.
>> + */
>> +SEC("socket")
>> +__failure __msg("div by zero")
>> +__naked void zext_narrowing_spill_byte_no_link(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;						\
>> +	*(u8 *)(r10 - 8) = r6;	/* 1-byte spill: no link */	\
>> +	r2 = *(u8 *)(r10 - 8);					\
>> +	if w6 != 0 goto 1f;					\
>> +	if r2 == 0 goto 1f;	/* not deduced */		\
> [Severity: Medium]
> Does zext_narrowing_spill_byte_no_link() actually test the size gate in
> check_stack_write_fixed_off()?

No, fixed in v4.

The narrowing now happens while the value is still on the stack, before 
the fill, as you suggest and as zext_narrowing_spill_reaches_fill 
already does. As written, the fill had already dropped any link, so the 
test would have passed even if the 1-byte spill had formed one.


> Here, r2 is filled from fp-8 before w6 is narrowed:
>
> 	*(u8 *)(r10 - 8) = r6;	/* 1-byte spill: no link */
> 	r2 = *(u8 *)(r10 - 8);
> 	if w6 != 0 goto 1f;
>
> As demonstrated by zext_narrowing_spill_drops_link() above, filling a
> BPF_REG_LINK_ZEXT slot into r2 before narrowing w6 drops the zero-extending
> link on the fill, so narrowing w6 afterwards would not propagate to r2 even if
> the 1-byte spill had formed a link.
>
> Should the narrowing branch "if w6 != 0 goto 1f" happen while the value is
> still on the stack before filling r2, matching the instruction order in
> zext_narrowing_spill_reaches_fill()?
>
>> +	r0 /= 0;						\
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>>   #ifdef CAN_USE_MOVSX
> [ ... ]
>
>> @@ -1800,6 +1952,35 @@ __naked void sext_byte_fill_drops_sext_link(void)
>>   }
>>   #endif /* CAN_USE_MOVSX */
>>   
>> +/*
>> + * The same, with the zero-extending link coming from a narrowing spill rather
>> + * than a mov. The spill truncated the slot to 32 bits, so the fill is not
>> + * narrowing and assigns no link kind of its own; the slot's zero-extending
>> + * one must not survive the sign-extending load.
>> + */
>> +SEC("socket")
>> +__failure __msg("div by zero")
>> +__naked void sext_fill_of_narrowing_spill_drops_zext(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;		/* r6 = full 64-bit unknown */	\
>> +	*(u32 *)(r10 - 8) = r6;	/* narrowing spill: slot is ZEXT */ \
>> +	r2 = *(s32 *)(r10 - 8);	/* sign-extending, not narrowing */ \
>> +	if w6 != -1 goto 1f;	/* slot low 32 bits are all ones */ \
>> +	if r2 s>= 0 goto 1f;	/* taken only if r2 was rebuilt zext */ \
>> +	r0 /= 0;						\
> [Severity: Medium]
> Can sext_fill_of_narrowing_spill_drops_zext() ever reach the is_ldsx link
> clearing in check_mem_access() with BPF_REG_LINK_ZEXT still intact?

nope it can't: v4 drops the test.

Thx,
-Vineet

> In check_stack_write_fixed_off(), the 4-byte narrowing spill
> "*(u32 *)(r10 - 8) = r6" truncates fp-8 to 32 bits via
> zext_32_to_64(&ss->spilled_ptr) and sets BPF_REG_LINK_ZEXT.
>
> When "r2 = *(s32 *)(r10 - 8)" then runs in check_stack_read_fixed_off(),
> get_reg_width(reg) is at most 32, so narrowing is false. Because size == 4,
> spill_size == 4, and !narrowing all hold, check_stack_read_fixed_off() calls
> assign_scalar_id_before_mov(env, reg) before copying *reg to
> state->regs[dst_regno]:
>
> kernel/bpf/verifier.c:check_stack_read_fixed_off() {
>      ...
> 	if (env->bpf_capable && size == 4 &&
> 	    (subreg_link || (spill_size == 4 && !narrowing)))
> 		assign_scalar_id_before_mov(env, reg);
> 	state->regs[dst_regno] = *reg;
>      ...
> }
>
> And assign_scalar_id_before_mov() immediately clears BPF_REG_LINK_ZEXT and
> assigns a fresh scalar ID unlinked from r6:
>
> kernel/bpf/verifier.c:assign_scalar_id_before_mov() {
> 	if (src_reg->link_kind && src_reg->link_kind != BPF_REG_LINK_SEXT)
> 		bpf_clear_scalar_id(src_reg);
> 	if (!src_reg->id && !tnum_is_const(src_reg->var_off))
> 		src_reg->id = ++env->id_gen;
> }
>
> So BPF_REG_LINK_ZEXT is already cleared by the normal 4-byte fill path (the
> same path tested by zext_narrowing_spill_drops_link()) before the is_ldsx
> handling in check_mem_access() runs.
>
> Additionally, even if r2 kept r6's ID and BPF_REG_LINK_ZEXT past
> check_mem_access(), coerce_reg_to_size_sx() restricts r2's 64-bit bounds to
> [S32_MIN, S32_MAX]. When "if w6 != -1 goto 1f" calls sync_linked_regs(),
> rebuilding r2 with zext_32_to_64() yields 0xffffffff, which is disjoint from
> [S32_MIN, S32_MAX], causing range_bounds_violation() to revert r2 to its prior
> bounds and still hit "r0 /= 0".
>
>> +1:								\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
>> +
>>   #endif /* CAN_USE_LDSX */
>>   
>>   char _license[] SEC("license") = "GPL";

