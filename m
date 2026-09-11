Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A74287518
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789101097; cv=none; b=s8+okDUvYKjp52SZoMKUZvdMwEsg6AL7dzmejDYjL1mMy+XHnQloMw805CwfVue5sw1mqN+lOKywpD0Tx7Skwt3W3Pl+Nf6BKOVtQIc/YunviyU2ZIUtCvfJe/wN1DDyHOK99h7EG5aRqcQ5KQaWAhPcpXwpy09YRv/gWf2p4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789101097; c=relaxed/simple;
	bh=49+fXp8HAJ/oeMWxjcITITOpfTZZUcA5bozm756fYyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OHXxBRZsqsA87Shw4oJXbsuJd0QcWoiGHUdDQj2Q0WBkoPK9+axHqnKcFFyyOOcT3wz73gK4EF6jSgk+RUoi4rYeb7sCxspZ9+qT7mZnOw4UYItV+cAKtqh8wFq0YhvC9+iPEf56X6SnAFtSO5UAaPUymlnKp1/89DdO2yb/F+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=na27CaW3; arc=none smtp.client-ip=91.218.175.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="na27CaW3"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=49+fXp8HAJ/oeMWxjcITITOpfTZZUcA5bozm756fYyk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789101092; v=1; x=1789705892;
 b=na27CaW3DUJoakpEEyRnveDZP9B9CJSaaZNQUSTxObp4hpZ9qpFGaX2NHJqw2ZzgR+ASiTRD
 ZrFPmZG8tIsgtXrVW3QKWcL3q+LLF6w/6i725Eq0B8vy1VCBbzmSY3uTsTpDw3QjUKX+JVxXLWz
 xYGWpiGUm627TT4ORBzRcTcs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b6697cd5c2ae9746;
	Fri, 11 Sep 2026 04:31:32 +0000
X-Mizu-Trace-ID: b6697cd5c2ae9746
X-Migadu-Flow: FLOW_OUT
Message-ID: <1720a0f5-5eaf-45e0-9cf1-6cdd3995ce66@linux.dev>
Date: Thu, 10 Sep 2026 21:31:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 06/12] bpf: Recognize by-value struct and
 __int128 kfunc arguments
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260909062522.4001896-1-yonghong.song@linux.dev>
 <20260909062554.4007131-1-yonghong.song@linux.dev>
 <20260909064638.AA26D1F00A3A@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260909064638.AA26D1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/26 11:46 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] bpf_kfunc_stack_access_bytes incorrectly maps stack slots to BPF_REG_6 through BPF_REG_9 (or higher), causing an out-of-bounds read and bypassing uninitialized memory checks.
> --
>
> commit 7f4b25d0dad6ba6fed374b3111fcc89d67434d87
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Recognize by-value struct and __int128 kfunc arguments
>
> This commit modifies the BPF verifier to support kfuncs taking structs or
> int128 by value. It updates argument tracking to walk slots rather than just
> registers, rejecting multi-slot arguments until JIT support is fully added.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index cf526f28f3e5b..94c359351bb69 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -13765,23 +13850,32 @@ s64 bpf_kfunc_stack_access_bytes(struct bpf_verifier_env *env, struct bpf_insn *
>>   	btf = meta.btf;
>>   	args = btf_params(meta.func_proto);
>>   	nargs = btf_type_vlen(meta.func_proto);
>> -	if (arg >= nargs)
>> +
>> +	/*
>> +	 * @arg is an argument slot and a 16-byte parameter takes two of them,
>> +	 * so walk the parameters to find the one that starts at this slot. A
>> +	 * slot holding the upper eightbyte of such a parameter belongs to no
>> +	 * pointer, and neither does a slot past the last parameter.
>> +	 */
>> +	for (i = 0, slot = 0; i < nargs && slot < arg; i++)
>> +		slot += kfunc_arg_slots(btf_type_skip_modifiers(btf, args[i].type, NULL));
>> +	if (i >= nargs || slot != arg)
>>   		return 0;
>>   
>> -	t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
>> +	t = btf_type_skip_modifiers(btf, args[i].type, NULL);
>>   	if (!btf_type_is_ptr(t))
>>   		return 0;
>>   
>>   	/* dynptr: fixed 16-byte on-stack representation */
>> -	if (is_kfunc_arg_dynptr(btf, &args[arg])) {
>> +	if (is_kfunc_arg_dynptr(btf, &args[i])) {
>>   		size = BPF_DYNPTR_SIZE;
>>   		goto out;
>>   	}
>>   
>>   	/* ptr + __sz/__szk pair: size is in the next register */
>> -	if (arg + 1 < nargs &&
>> -	    (btf_param_match_suffix(btf, &args[arg + 1], "__sz") ||
>> -	     btf_param_match_suffix(btf, &args[arg + 1], "__szk"))) {
>> +	if (i + 1 < nargs &&
>> +	    (btf_param_match_suffix(btf, &args[i + 1], "__sz") ||
>> +	     btf_param_match_suffix(btf, &args[i + 1], "__szk"))) {
>>   		int size_reg = BPF_REG_1 + arg + 1;
>>   
>>   		if (aux->const_reg_mask & BIT(size_reg)) {
>>   			size = (s64)aux->const_reg_vals[size_reg];
> [Severity: High]
> This is a pre-existing issue, but does this code lead to an out-of-bounds
> read or bypass uninitialized memory checks when the pointer argument is
> passed on the stack?
>
> The size_reg calculation inherently assumes the size argument is always passed
> in a register. If the pointer argument slot is 4 or higher (which might be
> more common now that large by-value structs consume multiple slots), the size
> argument lands on the stack.
>
> In that scenario, size_reg maps to BPF_REG_6 or higher, which are
> callee-saved registers. A BPF program could place a fake constant in one of
> these registers to trick the verifier into thinking 0 bytes are read, while
> the runtime stack argument is non-zero. This could bypass stack
> initialization checks and potentially leak uninitialized kernel memory.
>
> Furthermore, if the pointer argument slot is 8 or higher, size_reg becomes
> greater than or equal to 10. Checking BIT(size_reg) and reading from
> aux->const_reg_vals[size_reg] would result in an out-of-bounds array read,
> since const_reg_vals is sized for 10 registers. Should this logic be updated
> to correctly query the BPF stack when the size argument is passed there?

You are right. Will fix.

>

