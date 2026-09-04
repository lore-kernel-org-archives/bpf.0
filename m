Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982D37F75D
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490603; cv=none; b=d7FRxjxjWKoe6YDUTPOuYI64L1xWpO2bG8mWw+Ytbhx/9yPtBAKpZ5VxP7p91cieB476DTgrZqc3tI9FA394qpvOEN2/5WYLHYcUCSohP89MZlG1nYczM71WhvYqdnwGXD8hqViEAjYD1DQKC2q9Wq94QkIii7ExEM387PBr8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490603; c=relaxed/simple;
	bh=nSzqfJSBCSwrKQ/jS51poE/QdTOWtDV+k/vaE+ph314=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iv1MUCp6WFtgfSxckaC1y/eV4iek+/4qdj29oNk0Yewt9ewHN7UIdQGzsKDFHaK/5XBKOKYA2n5l8bq7FM/Quz63hmimSU4k3RXeqL4WlXRvGTVD7SI4IbznRIBrIU4FrH5G2Jpjqf4K3fzDA6BRlcOouR56fPZCms7bj9Bs0Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nUgcWUHN; arc=none smtp.client-ip=95.215.58.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nUgcWUHN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nSzqfJSBCSwrKQ/jS51poE/QdTOWtDV+k/vaE+ph314=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788490598; v=1; x=1789095398;
 b=nUgcWUHNvmxW/IzC8SpIh+Kbd/Orfg6ebbhHFa5jZijvvnnj5pKZoql9e7PyjBmhfy3r+PFI
 HNwUpWdiLVLUqIJvd6QG8lG2XKRF95nhm/3+bKWl3GcdOo9p2yYv7V8JJu/MZoY19fQsU9Vdgdm
 scjGf+f0cLbp56j77/wwxTKQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7befaa3222e40484;
	Fri, 04 Sep 2026 02:56:37 +0000
X-Mizu-Trace-ID: 7befaa3222e40484
X-Migadu-Flow: FLOW_OUT
Message-ID: <df9fedbd-51ae-47ad-9b09-fcd7d31d0640@linux.dev>
Date: Fri, 4 Sep 2026 08:26:33 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vineet Gupta <vineet.gupta@linux.dev>
Subject: Re: [RFC bpf-next 2/6] bpf: move the linked-scalar flags into
 bpf_reg_state->flags [NFC]
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-3-vineet.gupta@linux.dev>
 <82363647cb12b75398e34c7d66a9f0c527940c8d.camel@gmail.com>
Content-Language: en-US
In-Reply-To: <82363647cb12b75398e34c7d66a9f0c527940c8d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/26 4:21 AM, Eduard Zingerman wrote:
> On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:
>
> +#define BPF_FLAG_ADD_CONST32	(1U << 0)
> +#define BPF_FLAG_ADD_CONST64	(1U << 1)
> +#define BPF_FLAG_ADD_CONST	(BPF_FLAG_ADD_CONST32 | BPF_FLAG_ADD_CONST64)
>   #define BPF_FLAG_PRECISE	(1U << 7)
> I'd still suggest to use bitfields.

Done.

FWIW I've used enum bitfields which guarantees type safety for mutual 
exclusions of 32 and 64 flags.

>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index f7a0314fa106..d3105b9a9965 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
>> @@ -370,12 +370,12 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>    * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
>>    * X->temp2, but X is already mapped to temp1, so the check fails correctly.
>>    *
>> - * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
>> - * base id (flag stripped) must both map consistently. Example: old has
>> - * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
>> - * (r3 derived from unrelated r4). Without the base check, idmap gets two
>> - * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
>> - * with A->B. The base ID cross-check catches this.
>> + * ->id is a plain identifier -- the ADD_CONST relationship lives in
>> + * ->flags -- so there is no compound (base | flag) key to unpack here.
>> + * Registers sharing a base id go through one idmap entry, which is what
>> + * catches e.g. old r2.id=A, r3.id=A (r3 = r2 + delta) against cur r2.id=B,
>> + * r3.id=C: A->B and A->C conflict. Matching ->flags and ->delta are checked
>> + * by the caller in regsafe().
> Nit: the above paragraph can be dropped altogether now.

Done.

>>    */
>>   static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>   {
>> @@ -384,15 +384,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>
>>   	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
>>
>> -	if (!check_ids(old_id, cur_id, idmap))
>> -		return false;
>> -	if (old_id & BPF_ADD_CONST) {
>> -		old_id &= ~BPF_ADD_CONST;
>> -		cur_id &= ~BPF_ADD_CONST;
>> -		if (!check_ids(old_id, cur_id, idmap))
>> -			return false;
>> -	}
>> -	return true;
>> +	return check_ids(old_id, cur_id, idmap);
>>   }
> I think sashiko is correct when it comments about:
>
>> Does the explore_alu_limits verification path also need a similar update?
> Both check_scalar_ids() call sites need an update.
> That being said, I'd say that the following case in regsafe()
>
> 		if (env->explore_alu_limits) {
> 			/* explore_alu_limits disables tnum_in() and range_within()
> 			 * logic and requires everything to be strict
> 			 */
> 			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
> 			       check_scalar_ids(rold->id, rcur->id, idmap);
> 		}
>
>
> can be replaced with `if (...) return regs_exact(rold, rcur, idmap)`,
> parent_id should be zero for SCALAR_VALUE.

And actually this can be moved out to the NFC patch (fwiw i dropped the 
helper link_flags_check).

Re. the next instance of check_scalar_ids () call - there is no direct 
change - the check for flags above it (existing for add_const, new for  
sugreg) provide the coverage.

One thing that did came up out of this deliberations and closely related 
albeit not to directly here.

The NFC patch 1 moved the flags out but didn't update regs_exact() for 
checking the add_const flag explicitly which was happening implicitly 
before the series. That causes the NFC to accept the following incorrectly.
       old {r1.id=A, r2.id=A+delta}  vs cur {r1.id=B, r2.id=B}

If regs_exact () is updated in the NFC, it fixes above but it also 
starts rejecting (correctly) something that pre-series was not.
       old {r2.id=A+delta32}         vs cur {r2.id=B+delta64}

That's fine except it is no longer NFC.

So what would your preference be: NFC + addon patch to introduce or 
remove the NFC label.
The scenario is apparently hard to hit in real life but possible 
theoritically.

>>   static void __clean_func_state(struct bpf_verifier_env *env,
>> @@ -488,11 +480,32 @@ static int clean_verifier_state(struct bpf_verifier_env *env,
>>   	return 0;
>>   }
>>
>> +/*
>> + * Do rold and rcur describe the same relationship to their ->id set?
>> + *
>> + * The link flags live in ->flags, which sits past the end of every memcmp()
>> + * window used for state comparison.
> --- 8< ----------------------------
>                                          and check_ids() only ever sees the plain
>> + * ->id. So unlike when these bits rode along in the top of ->id, they have to
>> + * be compared explicitly everywhere ->id is.
> ---------------------------- >8 ---
>
> Nit: let's drop this sentence.

The actual helper below is gone in v2 so this is gone too.

>> + *
>> + * Only meaningful when rold carries an id: the flags are only ever set
>> + * together with one, so rold->id == 0 implies none of them is set.
>> + */
>> +static bool link_flags_match(const struct bpf_reg_state *rold,
>> +			     const struct bpf_reg_state *rcur)
>> +{
>> +	if (!rold->id)
>> +		return true;
>> +
>> +	return (rold->flags & BPF_FLAG_ADD_CONST) == (rcur->flags & BPF_FLAG_ADD_CONST);
>> +}
>> +
> ...
>
>> @@ -590,17 +603,24 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>>   		 */
>>
>>   		/*
>> -		 * ADD_CONST flags must match exactly: BPF_ADD_CONST32 and
>> -		 * BPF_ADD_CONST64 have different linking semantics in
>> +		 * ADD_CONST flags must match exactly: BPF_FLAG_ADD_CONST32 and
>> +		 * BPF_FLAG_ADD_CONST64 have different linking semantics in
>>   		 * sync_linked_regs() (alu32 zero-extends, alu64 does not),
>>   		 * so pruning across different flag types is unsafe.
>>   		 */
>> -		if (rold->id &&
>> -		    (rold->id & BPF_ADD_CONST) != (rcur->id & BPF_ADD_CONST))
>> +		if (!link_flags_match(rold, rcur))
>>   			return false;
>>
>> -		/* Both have offset linkage: offsets must match */
>> -		if ((rold->id & BPF_ADD_CONST) && rold->delta != rcur->delta)
>> +		/*
>> +		 * Both have offset linkage: offsets must match. The rold->id
>> +		 * test is redundant today -- BPF_FLAG_ADD_CONST is only ever set
>> +		 * together with an id -- but it used to be structural, because
>> +		 * the flag lived in the id itself. Keep it explicit so the
>> +		 * invariant does not rest on every ->id = 0 site remembering to
>> +		 * clear ->flags too.
>> +		 */
> Nit: Let's shorten this comment to it's original form.
>       A comment on ->flags field saying that "->flags != 0 iff ->id != 0" should suffice.
>       Let's also drop the 'rold->id && ' part.

Done.

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8925749d636e..93e69116ca9e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1806,6 +1806,7 @@ static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>>   	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
>>   	reg->id = 0;
>>   	reg->parent_id = 0;
>> +	reg->flags &= ~BPF_FLAG_ADD_CONST;
>>   	___mark_reg_known(reg, imm);
>>   }
>>
>> @@ -3308,6 +3309,7 @@ static void clear_scalar_id(struct bpf_reg_state *reg)
>>   {
>>   	reg->id = 0;
>>   	reg->delta = 0;
>> +	reg->flags &= ~BPF_FLAG_ADD_CONST;
>>   }
> sashiko is correct about the following branch in the
> check_stack_write_fixed_off():
>
> 		if (!reg_value_fits)
> 			state->stack[spi].spilled_ptr.id = 0;
>
> this seem to be the only missing location, the rest deals with
> pointers, where ->flags should already be zero.

Now clear_scalar_id(&state->stack[spi].spilled_ptr)

>> @@ -15950,18 +15951,19 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>>   				: &vstate->frame[e->frameno]->stack[e->spi].spilled_ptr;
>>   		if (reg->type != SCALAR_VALUE || reg == known_reg)
>>   			continue;
>> -		if ((reg->id & ~BPF_ADD_CONST) != (known_reg->id & ~BPF_ADD_CONST))
>> +		if (reg->id != known_reg->id)
>>   			continue;
>>   		/*
>>   		 * Skip mixed 32/64-bit links: the delta relationship doesn't
>>   		 * hold across different ALU widths.
>>   		 */
>> -		if (((reg->id ^ known_reg->id) & BPF_ADD_CONST) == BPF_ADD_CONST)
>> +		if (((reg->flags ^ known_reg->flags) & BPF_FLAG_ADD_CONST) == BPF_FLAG_ADD_CONST)
>>   			continue;
>> -		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
>> +		if ((!(reg->flags & BPF_FLAG_ADD_CONST) && !(known_reg->flags & BPF_FLAG_ADD_CONST)) ||
>>   		    reg->delta == known_reg->delta) {
>>   			*reg = *known_reg;
>>   		} else {
>> +			u8 saved_add_const = reg->flags & BPF_FLAG_ADD_CONST;
>        ---------------------^
>>      |         	s32 saved_off = reg->delta;
>>      | 		u32 saved_id = reg->id;
>>      |
>> @@ -|5976,11 +15978,12 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
>>      | 		 */
>>      | 		reg->delta = saved_off;
>>      | 	        reg->id = saved_id;
>> +   | 		reg->flags = (reg->flags & ~BPF_FLAG_ADD_CONST) | saved_add_const;
>>      -----------------------^
>        I'm not sure we need to inherit flags from known_reg here.
>        Let's avoid that and go with just saved_flags.

Done.

>> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
>> @@ -349,8 +349,9 @@ l0_%=:							\
>>   }
>>
>>   /*
>> - * Test that sync_linked_regs() checks reg->id (the linked target register)
>> - * for BPF_ADD_CONST32 rather than known_reg->id (the branch register).
>> + * Test that sync_linked_regs() consults reg->flags (the linked target
>                                     ^^^^^^^^
>                                 nit: checks
>> + * register) for BPF_FLAG_ADD_CONST32, not just known_reg->flags (the branch
>> + * register): the gate is (reg->flags | known_reg->flags).
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                 nit: please drop.

Fixed.

Thx,
-Vineet
