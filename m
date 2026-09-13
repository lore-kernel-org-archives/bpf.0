Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC353357D0E
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267238; cv=none; b=dHLuui0y2+gZ8jCRUzpfoDGmU+sDLhXPruQfnTHfCWmIKi5azGuDbdD8bpsZZkZobL5KNnPE9N8pRFGXRH6hAD2w3eXsuqzPxkyAZ+Bt8DFXikZMYGL83NzuIFJgOK0HHSkd2urf3tYAm32SPBwptd+B/D6kxOVwyAbpD06DmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267238; c=relaxed/simple;
	bh=1BQvtwfvNYQLhpVKCeAZcPnYo1Jhvrk4p1blC0/0h5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9+z2ZXViK49Zjyd9ItFhsdlAsneyW6KRTLmnP/vJV6xOvngaMWmvGrXhfeSKu7Tqtj0ujkZAZlWcOLqxZLUIoJzNLGzqyXv8aOP60Wg4DA/yoJ8ucCCPEuoEZ/GqDAjT4ExG4Z/0vhZN4mGSLCW48wfe3ApL3DoddGzaV83E3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tvhhw66i; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tvhhw66i"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1BQvtwfvNYQLhpVKCeAZcPnYo1Jhvrk4p1blC0/0h5Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789267233; v=1; x=1789872033;
 b=Tvhhw66i5RLaJlwtwuPPFyg7f+f7AAapaVoNxKluig7C+Mf6wX4xYJRWHP5zjHcgvHHNlIte
 sJ102fhFM0vL5puJ9KbMdM3rhZtZNuUyk+dMwcIGwa35WlpX7LkxpP+hiGrK4MNWvjHP6DZrMus
 M+TiL9je4EXioI3mDMUr1qG0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 494c0ba23b5337a7;
	Sun, 13 Sep 2026 02:40:26 +0000
X-Mizu-Trace-ID: 494c0ba23b5337a7
X-Migadu-Flow: FLOW_OUT
Message-ID: <ada7a330-6402-4993-8fda-36ef9333af2b@linux.dev>
Date: Sat, 12 Sep 2026 19:40:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 01/15] bpf: Read a kfunc's __sz argument only
 when it is in a register
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260912195156.980886-1-yonghong.song@linux.dev>
 <20260912195201.982215-1-yonghong.song@linux.dev>
 <20260912200645.208041F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260912200645.208041F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/12/26 1:06 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Missing negative bounds check for enum parameters in memcg kfuncs allows out-of-bounds array read
> --
>
> commit 5816e44e0d469f2be29753390131ba5c9f8fd073
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Read a kfunc's __sz argument only when it is in a register
>
> This commit fixes an issue where an out-of-bounds index could be used to read
> from const_reg_vals[] when a kfunc receives a stack argument pair of a
> pointer and size. It ensures size_reg is bounded by MAX_BPF_FUNC_REG_ARGS
> to prevent reading unrelated callee-saved registers.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 617a277c3558c..0c6a404167ca4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -13641,13 +13641,14 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
>>   		goto out;
>>   	}
>>   
>> -	/* ptr + __sz/__szk pair: size is in the next register */
>> +	/* ptr + __sz/__szk pair: the size follows the pointer */
>>   	if (arg + 1 < nargs &&
>>   	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
>>   	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
>>   		int size_reg = BPF_REG_1 + arg + 1;
>>   
>> -		if (aux->const_reg_mask & BIT(size_reg)) {
>> +		if (size_reg <= MAX_BPF_FUNC_REG_ARGS &&
>> +		    (aux->const_reg_mask & BIT(size_reg))) {
>>   			size = (s64)aux->const_reg_vals[size_reg];
>>   			goto out;
>>   		}
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential problem with how the
> verifier handles enum arguments for kfuncs, specifically in the memcg
> kfuncs.
>
> Since the BPF verifier treats enum types as plain signed integers and does not
> enforce enum ranges natively, BPF programs can pass negative scalar values
> to kfuncs.
>
> In mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events():
>
> 	if (unlikely(event >= MEMCG_NR_MEMORY_EVENTS))
> 		return (unsigned long)-1;
>
> 	return atomic_long_read(&memcg->memory_events[event]);
>
> Does this signed comparison without a negative bound allow a negative
> event value to bypass the check and cause an out-of-bounds read on the
> memory_events array?
>
> Similarly, in mm/bpf_memcontrol.c:bpf_mem_cgroup_vm_events():
>
> 	if (unlikely(!memcg_vm_event_item_valid(event)))
> 		return (unsigned long)-1;
>
> 	return memcg_events(memcg, event);
>
> And the check in mm/memcontrol.c:memcg_vm_event_item_valid():
>
> 	if (idx >= NR_VM_EVENT_ITEMS)
> 		return false;
>
> 	return !BAD_STAT_IDX(memcg_events_index(idx));
>
> Could a negative idx here bypass the bounds check and lead to an
> out-of-bounds access on the mem_cgroup_events_index array?

I think we should be okay here. The kfunc itself is responsible to do 
proper bound checking before doing other stuff, as examples in the above.

