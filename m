Received: from mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65071377EA7
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788414613; cv=none; b=OYNnNuR1atic2H0JKCO+xMBRQReRnlHZHae3B/2yM3L3gCvJj8/4Cd4V2TgTG80HcO/INkwaSCJFlP+D64Z7QEQgw4cqmzQFcKNJaYUpX3/NL1Mx3bEpZ2jYrD+CP9ASVGvRPuPMy/JAPbqCOHP91zt1vcqWVGMk9csaz6Qfe7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788414613; c=relaxed/simple;
	bh=vwsI4xrmCPVAXuAeAWHDjRAm31lnhYTLSK/fGKkYjQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/lNX3D+7+hAhRm6yw6fNAJFJ2oJR97+HN30zUI2e56AVJCdNNueSMowFe55ETTEQMuRfMINS/mUljKlTOwyEWOqsoOUCYSAnf+b1/Q8l9GVI/JxyhRaxPADPxwW12u5UrsCZ7xUk+LDMIdslLf4QhUfBJu8SWxEkz9EgXoZAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZHdj3scz; arc=none smtp.client-ip=95.215.58.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZHdj3scz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vwsI4xrmCPVAXuAeAWHDjRAm31lnhYTLSK/fGKkYjQY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788414607; v=1; x=1789019407;
 b=ZHdj3sczXoCJrqMuepnw47qFJux0ZIy2CdWNA9+ZW8MQDDk0im2yRsncj225GG4UrGB4nz++
 +MTnqHzZdVmXUjCQkqkL9NpnEW3XyzpUSxykVha0T/nijgIof0k+rgE3LLzYjnmncCabaDm9YVa
 Qp88CueW1z8CEI4BwJqF3v9U=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7f2efeb0647b6d66;
	Thu, 03 Sep 2026 05:50:02 +0000
X-Mizu-Trace-ID: 7f2efeb0647b6d66
X-Migadu-Flow: FLOW_OUT
Message-ID: <df3644d0-8915-4a04-94d9-cd7fbe5cb1cc@linux.dev>
Date: Thu, 3 Sep 2026 11:19:57 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 4/6] selftests/bpf: cover low-32 subreg-equal link
 for zero-extending movs
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-5-vineet.gupta@linux.dev>
 <54bed44859f9de519c56ed0fb9366160f625fce7.camel@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <54bed44859f9de519c56ed0fb9366160f625fce7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/26 10:35 AM, Eduard Zingerman wrote:
> On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:
>
> Nit: let's keep all tests for this feature under verifier_linked_scalars.c.

yes that was a spurious __msg fix, dropped now.

>> +/*
>> + * w3 = w0 forms a low-32 BPF_FLAG_SUBREG_ZEXT link, so R3 carries an id here
>> + * where it did not before; the bounds are unchanged. The id is deterministic
>> + * (raw asm, same bytecode in every flavour) so require it rather than making
>> + * it optional -- otherwise the assertion would still pass if the link were
>> + * dropped again. The delta suffix is left general: log.c prints ->delta
>> + * directly after the id with no separator when BPF_FLAG_ADD_CONST is set.
>> + */
> Please cleanup LLM generated comments. All that changed here is 'id' for R3.
> Is it important for this specific test to match the exact regex?

Not really.

> Given the intended purpose of the test I think that the above comment is not warranted.

Yes, now removed

>> +__success
>> +__naked void subreg_eq_zext_mov_narrow(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;		/* r6 = 64-bit unknown (helper ret is unbounded) */ \
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;		/* r0 = unknown high bits */	\
>> +	r6 |= r0;		/* still 64-bit unknown; makes it explicit */ \
> Why the second bpf_get_prandom_u32() call is necessary?
> LLM got confused by the _u32() in the function name?

Probably ! Now removed.

>> +	w7 = w6;		/* 32-bit zero-extend mov, wide src */	\
>> +	if w6 != 0 goto l_out_%=;	/* w6 low == 0 on fall-through */ \
>> +	/* w7 = zext32(w6 low) must be 0 here */		\
> All three comments above can be dropped. What should be commented on
> is that `w7 = w6' forms a link and `w6 != 0` propagates ranges through
> this link.

OK.

>> +	if w7 == 0 goto l_out_%=;	/* provably 0 iff linked */	\
>> +	r0 /= 0;		/* reached only if w7 not deduced 0 */	\
>> +l_out_%=:							\
> Nit: please prefer `2: goto 1f; 1: goto 2b;' style labels.

Will do; there's a mix up of  the two styles in the file.

>> +/*
>> + * A 32-bit zero-extending mov (w7 = w5) whose SOURCE is a wide ADD_CONST-linked
>> + * register (r5 = base + K) must NOT disturb that source. Forming the low-32
>> + * BPF_FLAG_SUBREG_ZEXT link on the destination would need assign_scalar_id_before_mov()
>> + * on the source, which clears its base+delta link -- and a combined
>> + * subreg+delta link isn't modeled anyway (sync_linked_regs() skips it). So for a
>> + * wide ADD_CONST src the mov leaves the source's link intact and just clears the
>> + * destination.
>> + *
>> + * Here r5 = r6 + 3 (ADD_CONST, wide). After the mov, narrowing the base r6 must
>> + * still reach r5 through the preserved link: r6 in [0, 10] => r5 in [3, 13], so
>> + * the guarded div-by-zero is unreachable. Had the mov cleared r5's link (calling
>> + * assign_scalar_id_before_mov() unconditionally), r5 would stay unbounded and the
>> + * div would be reachable (rejected).
>> + *
>> + * Note this is a no-regression guard rather than coverage of the new link:
>> + * before this feature the wide-source path also left the source untouched, so
>> + * the test passes either way. What it pins is the choice not to call
>> + * assign_scalar_id_before_mov() unconditionally.
>> + *
>> + * Written in asm so the bytecode is identical regardless of the host BPF compiler.
> Please try to make the comments less verbose.

Sorry - it is indeed exhausting.

>> + */
>> +SEC("socket")
>> +__success
>> +__naked void zext_mov_keeps_add_const_src(void)
>> +{
>> +	asm volatile ("						\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r6 = r0;		/* r6 low = unknown u32 */	\
>> +	call %[bpf_get_prandom_u32];				\
>> +	r0 <<= 32;						\
>> +	r6 |= r0;		/* r6 = full 64-bit unknown (base) */ \
>> +	r5 = r6;		/* r5, r6 linked (shared id) */	\
>> +	r5 += 3;		/* r5 = base + 3: ADD_CONST, still wide */ \
>> +	w7 = w5;		/* 32-bit zext mov, wide ADD_CONST src */ \
>> +	if r6 > 10 goto l_out_%=;/* r6 in [0, 10] */		\
>> +	/* r5 = r6 + 3 must be in [3, 13] here (needs the kept link) */ \
>> +	if r5 > 13 goto l_err_%=;/* taken only if r5 not narrowed */ \
>> +	goto l_out_%=;						\
>> +l_err_%=:							\
>> +	r0 /= 0;		/* reachable iff r5's link was cleared */ \
>> +l_out_%=:							\
>> +	r0 = 0;							\
>> +	exit;							\
>> +"	:
>> +	: __imm(bpf_get_prandom_u32)
>> +	: __clobber_all);
>> +}
> ...
>
> Given the changes in regsafe/check_alu_op/sync_linked_regs,
> I think the following cases are not covered:

Added now.

> - regsafe: a state whose register carries BPF_FLAG_SUBREG_ZEXT must
>    not be deemed safe against one without it.

zext_link_mismatch_blocks_pruning

> - check_alu_op: a provably-u32 source takes the full-equality path and
>    must not be flagged ZEXT.

zext_u32_src_is_full_link

> - check_alu_op: a self-mov w6 = w6 must not generate a self-link and
>    should clear dst's id.

zext_self_mov_no_link

> - check_alu_op: a ZEXT-linked source must survive
>    assign_scalar_id_before_mov(), so a chain of 32-bit assignments
>    should preserve the id and the flag.

zext_chain_keeps_link

> - sync_linked_regs: no propagation when reg has ZEXT and known_reg has ADD_CONST.

zext_no_sync_when_base_has_delta

> - sync_linked_regs: no propagation when known_reg has ZEXT and reg has ADD_CONST.

zext_no_sync_from_subreg_base

> - sync_linked_regs: low-32 reconstruction must still propagate when
>    both reg and known_reg have ZEXT.

zext_sync_between_two_subregs

Thx,
-Vineet
