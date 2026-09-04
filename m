Received: from mta1.migadu.com (out-235.mta1.migadu.com [95.215.58.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A23B895A
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 03:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492606; cv=none; b=D93k9npvHh1wt3yB477ArW0v7/tTpnbXS3QBF09ALTgoUih7C396mW2bUKjpiMbLllh8Ol18YtfI0BiBIZf9mNzpAFc9UPtcus7w26D2P82T11p0EQJnRpMBRRxJgn/HdUNmxjYcmJO7sLz3ml4FV5jHH9rS/anBFkCq5KQzgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492606; c=relaxed/simple;
	bh=lZmF6FSfA1n6pdWrXCfyfsF9NyL9Pw+BjcH4o2a8BLY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OzEzVVdhC4YXc1xiBKcqAk/IqSutEv+mvWIvPrRkOn4hQg0rRLUWv7f0aEkU2Cteozko9fqeMxaHHW+W7gCE8Vrb2JKS6/UpObkNzKj2Boq964YAamEIiI2d1McsIs0sLTbeWb0J9TygCe9PvlJPaBBx+MEjMdQ7JFPyLyt9ST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lzP9Aftu; arc=none smtp.client-ip=95.215.58.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lzP9Aftu"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lZmF6FSfA1n6pdWrXCfyfsF9NyL9Pw+BjcH4o2a8BLY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788492602; v=1; x=1789097402;
 b=lzP9AfturZOYlo2xaz05c445cnrjFr5JbSlk0QNCYb1N5oaW0qJleVdW6CQI2Ydua3NMjeSE
 UM59U0DLpOcxRmdf95cLdWfQczMUUgJYHb2yYeOE552+YzJhAQu1adQ9Y+ISkjFEcIs79Hk+8i8
 Vsduzkg8Je3/Nqht5Nrnm3C4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 28152c226d8c5285;
	Fri, 04 Sep 2026 03:30:02 +0000
X-Mizu-Trace-ID: 28152c226d8c5285
X-Migadu-Flow: FLOW_OUT
Message-ID: <b51d5356-ecc4-4b17-a01e-bf4077d02751@linux.dev>
Date: Fri, 4 Sep 2026 09:00:00 +0530
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
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
 <20260814231945.3884596-3-vineet.gupta@linux.dev>
 <20260814233412.57FF61F000E9@smtp.kernel.org>
Content-Language: en-US
In-Reply-To: <20260814233412.57FF61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/26 5:04 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing BPF_FLAG_ADD_CONST check in the explore_alu_limits verification path allows incorrect pruning of incompatible linked scalars.
> - [Medium] Narrowing spills of scalar registers fail to clear BPF_FLAG_ADD_CONST linkage flags, leading to stale flags on unlinked registers and subsequent pruning failures in regsafe().
> --
>
> --- Patch [2]: [RFC bpf-next 2/6] bpf: move the linked-scalar flags into bpf_reg_state->flags [NFC] ---
> commit 19636caada7b86a42b8056f18241af3d2e662845
> Author: Vineet Gupta <vineet.gupta@linux.dev>
> Subject: bpf: move the linked-scalar flags into bpf_reg_state->flags [NFC]
>
> This patch moves the linked-scalar flags from the bpf_reg_state->id field
> into a dedicated bpf_reg_state->flags field. It also updates the verification
> logic to explicitly check these new flags using the link_flags_match helper
> where appropriate.
>
>> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
>> index f7a0314fa1064..d3105b9a9965f 100644
>> --- a/kernel/bpf/states.c
>> +++ b/kernel/bpf/states.c
>> @@ -488,11 +480,32 @@ static int clean_verifier_state(struct bpf_verifier_env *env,
> [ ... ]
>
>> +static bool link_flags_match(const struct bpf_reg_state *rold,
>> +			     const struct bpf_reg_state *rcur)
>> +{
>> +	if (!rold->id)
>> +		return true;
>> +
>> +	return (rold->flags & BPF_FLAG_ADD_CONST) == (rcur->flags & BPF_FLAG_ADD_CONST);
>> +}
>> +
>>   static bool regs_exact(const struct bpf_reg_state *rold,
>>   		       const struct bpf_reg_state *rcur,
>>   		       struct bpf_idmap *idmap)
>>   {
>>   	return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
>> +	       link_flags_match(rold, rcur) &&
>>   	       check_ids(rold->id, rcur->id, idmap) &&
>>   	       check_ids(rold->parent_id, rcur->parent_id, idmap);
>>   }
> [Severity: High]
> Does the explore_alu_limits verification path also need a similar update?
>
> In regsafe(), when env->explore_alu_limits is true, the verifier uses a
> strict comparison:
>
> regsafe() {
>          if (env->explore_alu_limits) {
>                  return memcmp(rold, rcur, offsetof(struct bpf_reg_state, id)) == 0 &&
>                         check_scalar_ids(rold->id, rcur->id, idmap);
>          }
> }
>
> Since memcmp() stops at the id field, it misses the newly added flags
> field. Without calling link_flags_match(), states with the same base
> scalar IDs but different linkage flags (such as BPF_FLAG_ADD_CONST32 vs
> BPF_FLAG_ADD_CONST64) might be incorrectly deemed equivalent, bypassing
> the strict bounds checking intended by this mode.

Agree.

> [Severity: Medium]
> Can narrowing spills leave stale flags on unlinked registers?
>
> When a linked scalar register is spilled with a smaller size,
> check_stack_write_fixed_off() copies the register and manually breaks
> the relation by setting the id to 0:
>
> check_stack_write_fixed_off() {
>          save_register_state(env, state, spi, reg, size);
>          if (!reg_value_fits)
>                  state->stack[spi].spilled_ptr.id = 0;
> }
>
> Since the linkage flags were moved out of the id field, setting id to 0
> no longer clears the BPF_FLAG_ADD_CONST bits.
>
> If this state is later compared in regsafe(), link_flags_match() will see
> rold->id != 0, but rcur->id == 0 with a stale BPF_FLAG_ADD_CONST flag.
> Because the rold->id check does not short-circuit for rcur, the helper
> will evaluate to false, incorrectly rejecting a state that is safe to
> prune.
>
> Would it be safer to use clear_scalar_id() or otherwise clear the flags
> when breaking the relation?

Agree.

Thx,
-Vineet
