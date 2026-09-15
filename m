Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8C32B118
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435037; cv=none; b=UrjAZCPzMyLPmK8RYETReYrxMyaKcLCBqaaCnDFpA8zSpritrymeBzyT9p8ndPQaK9PkmjbvQ/GIc/c51LCcc0jJyHVXw+kUL+ysWkbezDjVRWVrJoByFxk+u9DvXCd+J5OLnO0BrZ9bVLUlxyRAD+rnxN9nxuGGOIESP5DW54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435037; c=relaxed/simple;
	bh=95Fd88mgzcRJSrzI94zDankhAZbYf4zlZR5muzZ95kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY7/exhlp0ruu4LQ/u98VzlZs9zEKwL9lYl+JzjRGLDr9rdS/UaCh+AgiQTETEvZN9hYWw9ZSzbB4Js8rmQUKOfvFEoBA2lhYH56n2bxe2zpTGNdJQ57DBaHHBOCmFyK24Q736DUumZRfzL40k2xHCFewEtS0ogAwbJMzsr5GYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wcU5Idf7; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wcU5Idf7"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=95Fd88mgzcRJSrzI94zDankhAZbYf4zlZR5muzZ95kQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789435033; v=1; x=1790039833;
 b=wcU5Idf7tw9DTeTIu9KnHAocOK/kzJ+WWyL8s/nrbowFDwYlhiy8dfQ0F66sqfcUb7vRGWVJ
 8/Kfqx9gymBzLPWU5dTj9BoYA6qqxeGFWUEWx/vPLf+MjeOpT2rNseh4L6cjg+iQlfA8BfMymUO
 FxqGmxBEvb9xSfzmqzfTxGPo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ee03bbdf7f0da47c;
	Tue, 15 Sep 2026 01:17:13 +0000
X-Mizu-Trace-ID: ee03bbdf7f0da47c
X-Migadu-Flow: FLOW_OUT
Message-ID: <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev>
Date: Mon, 14 Sep 2026 18:17:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-2-vineet.gupta@linux.dev>
 <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/12/26 11:50 AM, Alexei Starovoitov wrote:
> On Thu Sep 10, 2026 at 9:46 AM PDT, Vineet Gupta wrote:
>> bpf_reg_state->id doubles as a linked-register id and, in its top two
>> bits, as a record of how the register relates to that set:
>>
>>    #define BPF_ADD_CONST64 (1U << 31)
>>    #define BPF_ADD_CONST32 (1U << 30)
>>
>> Every user of ->id therefore has to mask, and more link kinds are coming.
>> Move the two bits into a bitfield next to ->precise, which is the last
>> field of the struct and outside every memcmp() window used for state
>> comparison, so the layout and all byte-wise comparisons are unchanged. The
>> two kinds are mutually exclusive, so a 2-bit enum captures them and makes
>> ADD_CONST_32 vs ADD_CONST_64 explicit at each use.
>>
>> ->id becomes a plain 32-bit identifier: no masking anywhere, and
>> check_scalar_ids() loses its two-level "check the compound id, then the
>> base id" dance in favour of a single check_ids().
>>
>> While here, use regs_exact() for the explore_alu_limits case in regsafe():
>> it is what that open-coded memcmp+check_scalar_ids pair amounts to, and it
>> picks up the add_const comparison for free (parent_id is 0 for
>> SCALAR_VALUE).
>>
>> check_stack_write_fixed_off() cleared ->id directly on a narrowing spill,
>> which would now leave ->add_const set without an id; use
>> clear_scalar_id().
>>
>> Moving the kind out of ->id also drops an incidental comparison in
>> regs_exact(), which used to see it as part of the idmap key; the next
>> patch restores it. Otherwise no functional change intended.
>>
>> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>> ---
>> v2: was RFC 2/6.
>>   - kinds are a 2-bit enum bitfield, not a byte of flags; RFC 1/6, which
>>     turned ->precise into that byte, is dropped (Eduard)
>>   - use regs_exact() for the explore_alu_limits case
>>   - clear_scalar_id() on the narrowing spill, which would otherwise leave
>>     ->add_const set without an id
>>
>>   include/linux/bpf_verifier.h                  | 25 ++++++++-----
>>   kernel/bpf/log.c                              |  4 +--
>>   kernel/bpf/states.c                           | 35 +++++--------------
>>   kernel/bpf/verifier.c                         | 35 +++++++++++--------
>>   .../bpf/progs/verifier_linked_scalars.c       | 34 +++++++++---------
>>   5 files changed, 65 insertions(+), 68 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 9727df5af83a..afb1e5628698 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -35,6 +35,17 @@ enum bpf_iter_state {
>>   	BPF_ITER_STATE_DRAINED,
>>   };
>>   
>> +/*
>> + * Records that a register is (base + ->delta) within its ->id set:
>> + * r1 += 10;   r1 gets ADD_CONST_64 delta
>> + * w3 += 10;   r3 gets ADD_CONST_32 delta
> w3 gets ?

OK.

>> + */
>> +enum bpf_add_const {
>> +	ADD_CONST_NONE = 0,
>> +	ADD_CONST_32,		/* delta was added with a 32-bit ALU op */
>> +	ADD_CONST_64,		/* ... with a 64-bit ALU op */
>> +};
>> +
>>   struct bpf_reg_state {
>>   	/* Ordering of fields matters.  See states_equal() */
>>   	enum bpf_reg_type type;
>> @@ -136,16 +147,9 @@ struct bpf_reg_state {
>>   	 * to a specific instance of bpf_iter.
>>   	 */
>>   	/*
>> -	 * Upper bit of ID is used to remember relationship between "linked"
>> -	 * registers. Example:
>> +	 * Registers sharing an ->id are "linked":
>>   	 * r1 = r2;    both will have r1->id == r2->id == N
>> -	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->delta == 10
>> -	 * r3 = r2;    both will have r3->id == r2->id == N
>> -	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->delta == 10
>>   	 */
>> -#define BPF_ADD_CONST64 (1U << 31)
>> -#define BPF_ADD_CONST32 (1U << 30)
>> -#define BPF_ADD_CONST (BPF_ADD_CONST64 | BPF_ADD_CONST32)
>>   	u32 id;
>>   	/*
>>   	 * Tracks the parent object this register was derived from.
>> @@ -164,6 +168,11 @@ struct bpf_reg_state {
>>   	u32 frameno;
>>   	/* if (!precise && SCALAR_VALUE) min/max/tnum don't affect safety */
>>   	bool precise;
>> +	/*
>> +	 * How this register relates to the others sharing its ->id.
>> +	 * Non-zero only if ->id is.
>> +	 */
>> +	enum bpf_add_const add_const:2;
>>   };
>>   
>>   static inline s64 reg_smin(const struct bpf_reg_state *reg)
>> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
>> index fb032dfdc0de..f8d7a5c8052f 100644
>> --- a/kernel/bpf/log.c
>> +++ b/kernel/bpf/log.c
>> @@ -651,8 +651,8 @@ static void print_reg_state(struct bpf_verifier_env *env,
>>   		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
>>   	verbose(env, "(");
>>   	if (reg->id)
>> -		verbose_a("id=%d", reg->id & ~BPF_ADD_CONST);
>> -	if (reg->id & BPF_ADD_CONST)
>> +		verbose_a("id=%d", reg->id);
>> +	if (reg->add_const)
>>   		verbose(env, "%+d", reg->delta);
>>   	if (reg->parent_id)
>>   		verbose_a("parent_id=%d", reg->parent_id);
>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index 66fb11b6c6a7..d974baad37ee 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
>> @@ -369,13 +369,6 @@ static bool check_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>    * and r7.id=0 (both independent), without temp IDs both would map old_id=X
>>    * to cur_id=0 and pass. With temp IDs: r6 maps X->temp1, r7 tries to map
>>    * X->temp2, but X is already mapped to temp1, so the check fails correctly.
>> - *
>> - * When old_id has BPF_ADD_CONST set, the compound id (base | flag) and the
>> - * base id (flag stripped) must both map consistently. Example: old has
>> - * r2.id=A, r3.id=A|flag (r3 = r2 + delta), cur has r2.id=B, r3.id=C|flag
>> - * (r3 derived from unrelated r4). Without the base check, idmap gets two
>> - * independent entries A->B and A|flag->C|flag, missing that A->C conflicts
>> - * with A->B. The base ID cross-check catches this.
>>    */
>>   static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>   {
>> @@ -384,15 +377,7 @@ static bool check_scalar_ids(u32 old_id, u32 cur_id, struct bpf_idmap *idmap)
>>   
>>   	cur_id = cur_id ? cur_id : ++idmap->tmp_id_gen;
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
>>   }
>>   
>>   static void __clean_func_state(struct bpf_verifier_env *env,
>> @@ -542,8 +527,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>>   			/* explore_alu_limits disables tnum_in() and range_within()
>>   			 * logic and requires everything to be strict
>>   			 */
>> -			return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
>> -			       check_scalar_ids(rold->id, rcur->id, idmap);
>> +			return regs_exact(rold, rcur, idmap);
> Why drop memcmp() ? Doesn't look correct.

regs_exact has the exact same memcmp so I don't think we are dropping 
it, but .....

|  static bool regs_exact(const struct bpf_reg_state *rold,
|                 const struct bpf_reg_state *rcur,
|                 struct bpf_idmap *idmap)
|  {
|      return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
|             check_ids(rold->id, rcur->id, idmap) &&
|             check_ids(rold->parent_id, rcur->parent_id, idmap);
|  }

> Also even after above change to check_scalar_ids() the check_scalar_ids() is still
> no equivalent to check_ids() that regs_exact() is doing.

... Right: reverting back to what we had before.
FWIW Eduard had suggested to use regs_exact; I'm not sure if he had 
something else in mind which we might be overlooking.

> This patch should have been refactoring, if so, this change looks
> unrelated and dubious.

Back when I started, keeping it NFC made more sense. But with all the 
nuances discovered in the process, I'm inclined to drop the NFC stance 
and make functional changes - there's at least one which is the 
following accepted pre-series and now rejected.

       old {r2.id=A+delta32}         vs cur {r2.id=B+delta64}

> The rest looks fine.

Thanks for taking a look.

-Vineet
