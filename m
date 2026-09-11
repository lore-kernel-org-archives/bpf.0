Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040C943BDBD
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109028; cv=none; b=qtDsD5aJ5FcOrhovYK2sPVJVErvkIqmmTQvow7o71nwH/XTsMmtP3n3DEJkNk0dnuTER/deOlBma0gR04xr+g1nSIygKxQF4CSw7o6CtQcjv10GGp4du4D8WtUq8U78zDoYH6NrUNSqUVWOizxq55WUAaUOIMoQIe0vzjV/fH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109028; c=relaxed/simple;
	bh=TmZY6BcQ0xEisxRZNCEF4PqxPS0KlLd6mp1NcqPQr7k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EIAJyJOxwjLgQXWkW4fqsywfs9PK7e3JyH7oMAmBjC72GddWydtG+F2BBI922/zx9g5dBo0ZFLApK8YqbjltEd/0USGGamWQq2p1veyN43ZAhtunIOxlUYzaljhkr5IXM5chwjLQlfDel1Qkf5vFvN28Z6ITnPcXFoYLpRgY/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RJkrEqJk; arc=none smtp.client-ip=91.218.175.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RJkrEqJk"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TmZY6BcQ0xEisxRZNCEF4PqxPS0KlLd6mp1NcqPQr7k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789109019; v=1; x=1789713819;
 b=RJkrEqJkYhpR1SDaLjsRsbhUNV/WgAlg6o0F5pPk9JDztPuUQSVvyWr4cJIMskcP4iUz+7Os
 47XkwG1XtPn+g9ZjJK+ZiAJl5R3JORHAIaoZ2WYPmKdjd9pUpH37zlDis2YQ7WWa2cBidTpPydO
 SaLSAbgG+5VPuKYrAtTGbKmQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9fa0cc3ea997953c;
	Fri, 11 Sep 2026 06:43:39 +0000
X-Mizu-Trace-ID: 9fa0cc3ea997953c
X-Migadu-Flow: FLOW_OUT
Message-ID: <1a84bd17-f673-4230-811b-e417ca58d62e@linux.dev>
Date: Fri, 11 Sep 2026 12:13:33 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 09/13] bpf: track low-32 scalar equality
 across narrowing stack fills
From: Vineet Gupta <vineet.gupta@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-10-vineet.gupta@linux.dev>
 <20260910170419.4C8601F000FF@smtp.kernel.org>
 <3f3e5658-4393-4530-8b3b-987fe20ddc95@linux.dev>
Content-Language: en-US
In-Reply-To: <3f3e5658-4393-4530-8b3b-987fe20ddc95@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/26 11:37 AM, Vineet Gupta wrote:
> On 9/10/26 10:34 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Critical] Sign-extending loads incorrectly preserve conflicting SUBREG_ZEXT metadata.
>> --
>>
>> commit f939550a777ae3d2a7392dec744bffdc9fabcdda
>> Author: Vineet Gupta <vineet.gupta@linux.dev>
>>
>> bpf: track low-32 scalar equality across narrowing stack fills
>>
>> This commit records a low-32 link for stack fills narrower than the wider
>> source, allowing the verifier to deduce relations between 32-bit narrows
>> and their wider origins. It also adjusts check_mem_access() to not clear
>> the id of a ->subreg register on a sign-extending load.
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 308ff53232f06..89be1240c99ae 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>> [ ... ]
>>
>>> @@ -3968,18 +3969,34 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
>>>    
>>>    			if (size <= spill_size &&
>>>    			    bpf_stack_narrow_access_ok(off, size, spill_size)) {
>>> -				if (env->bpf_capable && size == 4 && spill_size == 4 &&
>>> -				    get_reg_width(reg) <= 32)
>>> +				bool narrowing = get_reg_width(reg) > size * BITS_PER_BYTE;
>>> +				/*
>>> +				 * A narrowing fill keeps only the slot's low 32 bits,
>>> +				 * so record a low-32 link rather than dropping the
>>> +				 * relation, as a 32-bit mov from a wide source does.
>>> +				 * Which kind depends on how the load fills the high
>>> +				 * half, hence is_ldsx.
>>> +				 */
>>> +				bool subreg_link = narrowing && size == 4;
>>> +
>>> +				if (env->bpf_capable && size == 4 &&
>>> +				    (subreg_link || (spill_size == 4 && !narrowing)))
>>>    					/* Ensure stack slot has an ID to build a relation
>>>    					 * with the destination register on fill.
>>>    					 */
>>>    					assign_scalar_id_before_mov(env, reg);
>>>    				state->regs[dst_regno] = *reg;
>>>    
>>> -				/* Break the relation on a narrowing fill.
>>> -				 * coerce_reg_to_size will adjust the boundaries.
>>> -				 */
>>> -				if (get_reg_width(reg) > size * BITS_PER_BYTE)
>>> +				if (subreg_link && reg->id)
>>> +					state->regs[dst_regno].subreg =
>>> +						is_ldsx ? SUBREG_SEXT : SUBREG_ZEXT;
>>> +				else if (narrowing)
>>> +					/*
>>> +					 * Nothing to relate: either the slot has
>>> +					 * no id to share, or the fill is narrower
>>> +					 * than the 32 bits a link can describe.
>>> +					 * coerce_reg_to_size adjusts the bounds.
>>> +					 */
>>>    					clear_scalar_id(&state->regs[dst_regno]);
>> [Severity: Critical]
>> When narrowing is false, does this preserve a stale SUBREG_ZEXT property for
>> a sign-extending load?
>>
>> If a register with SUBREG_ZEXT is spilled to the stack and then read back
>> via a 4-byte sign-extending load, narrowing evaluates to false. This allows
>> the destination register to inherit the SUBREG_ZEXT property directly from
>> the stack slot, even though it is being sign-extended.
>>
>> [ ... ]
> Indeed if narrowing is false, wrong metadata can potentially be
> introduced, a comment to that effect is added here.
>
>      /*
>        * A fill that is not narrowing copies the slot's
>        * kind verbatim, which a sign-extending load can
>        * contradict. check_mem_access() runs after this
>        * and drops any kind but SUBREG_SEXT once it knows
>        * the extension was not a no-op.
>        */
>
>
> See the second site below for actual fix...
>
>>> @@ -6736,13 +6753,15 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
>>>    			 * Sign-extension can change the register value relative
>>>    			 * to a scalar it is linked with by id (e.g. a zero-
>>>    			 * extending fill of the same spilled stack slot), thus
>>> -			 * drop the shared id in that case.
>>> +			 * drop the shared id in that case. A ->subreg link is
>>> +			 * the exception: it already records that only the low
>>> +			 * 32 bits are shared, and how the high half follows.
>>>    			 */
>>>    			bool no_sext = reg_umax(&regs[value_regno]) <
>>>    					(1ULL << (size * BITS_PER_BYTE - 1));
>>>    
>>>    			coerce_reg_to_size_sx(&regs[value_regno], size);
>>> -			if (!no_sext)
>>> +			if (!no_sext && !regs[value_regno].subreg)
>>>    				clear_scalar_id(&regs[value_regno]);
>> [Severity: Critical]
>> Does this check wrongly preserve the ID for SUBREG_ZEXT registers that
>> have just been sign-extended?
>>
>> Because SUBREG_ZEXT is non-zero, !regs[value_regno].subreg evaluates to
>> false, skipping the clear_scalar_id() call for a register that might hold
>> a sign-extended negative value.
>>
>> Later, if a conditional branch triggers sync_linked_regs(), it will see
>> SUBREG_ZEXT and invoke reconstruct_zext32(). This would forcefully set the
>> bounds to a zero-extended positive value.
>>
>> At runtime, the discrepancy between the verifier's zero-extended positive
>> bounds and the actual sign-extended negative value could bypass bounds checks,
>> potentially leading to out-of-bounds memory reads or writes.
>>
>> Should this explicitly check for SUBREG_SEXT rather than just allowing any
>> non-zero ->subreg value?
> Exactly that. And the first path leads here so the comment above suffices.

What I meant was first site has comment, and this site has the exact fix 
which sashiko identified.
They are both part of the same bug.

Thx
