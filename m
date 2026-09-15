Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554E3DA7D4
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509138; cv=none; b=QaV9rBmnkLcBsXO32blN0zDAx+m+z/yNffkFlhk6DWBCkQdXnhlLgR4XmlMnnxUnHDiTY8h0zXa22xr/DfKk9iiLu9CZbQEnyZ9OA87SYGt7mG8HWFj1h+nwjaZXbA49YCeVNoKk71BvqEinC0n6SI+ny76i7cx2CEPsRlOSJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509138; c=relaxed/simple;
	bh=C0L2/gLmKQenT3QxNIj0UgnPGegnPNzAg/I+FzCefrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDjEeYZmno4P37YzeNiJGPggA43Zhi8RyXNERL4yVV75OmutIH8qeviNDm7bIQGccvbFsx78t+uqobDXPZpD8kvypqoGNr/YnpM5drKFOwFpws20GQDQTAz55hSb4VaIdOD4QcZ+OqeDfRMXTsYhUhpYaXp8hMx1jozPqYOPzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qMsfBMaX; arc=none smtp.client-ip=91.218.175.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qMsfBMaX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C0L2/gLmKQenT3QxNIj0UgnPGegnPNzAg/I+FzCefrk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789509134; v=1; x=1790113934;
 b=qMsfBMaXD0eXxO83V23fN2edUOYTbcZqRZeijp7PLxONHBVGSIz04L83FVpT7AUvepqEPnlN
 Smy4PD3KGcKIWGvqq+ciFG+lm+9k/52DNGs9jelKlr2qZuHFXpRKLy1ZvAL97dq5SyetyLOXggU
 CgmU3oUleQaqn5r3ZC+FF8Jw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d67cf22761cb3baa;
	Tue, 15 Sep 2026 21:52:04 +0000
X-Mizu-Trace-ID: d67cf22761cb3baa
X-Migadu-Flow: FLOW_OUT
Message-ID: <d2f54ff4-436a-4513-90b7-d1c9e1f76298@linux.dev>
Date: Tue, 15 Sep 2026 14:52:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 05/13] bpf: keep the range across a sign
 extension that cannot change it
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-6-vineet.gupta@linux.dev>
 <20260910170830.DFC551F000FF@smtp.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260910170830.DFC551F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/26 10:08 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] Incomplete fix for bounds precision loss on zero-straddling sign extensions in the verifier.
>
> Pre-existing issues:
> - [High] Out-of-bounds array read in BPF memory cgroup kfuncs due to bypassable enum bounds check.
> --
>
> commit 971a50869c707d4ac0627b912bd2423344987acc
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> bpf: keep the range across a sign extension that cannot change it
>
> This commit improves the verifier's handling of sign extensions in
> coerce_reg_to_size_sx() by recognizing when a register's bounds already fit
> within the target field. This prevents unnecessary precision loss when a value
> range straddles zero, allowing valid programs to pass verification.
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 58e788f53ae58..eb093194e2a36 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -5773,6 +5774,27 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>>   		return;
>>   	}
>>   
>> +	if (size == 1) {
>> +		field_smin = S8_MIN;
>> +		field_smax = S8_MAX;
>> +	} else if (size == 2) {
>> +		field_smin = S16_MIN;
>> +		field_smax = S16_MAX;
>> +	} else {
>> +		/* size == 4 */
>> +		field_smin = S32_MIN;
>> +		field_smax = S32_MAX;
>> +	}
>> +
>> +	/*
>> +	 * The range already fits the field, so (sN)v == v for every value the
>> +	 * register can hold and the sign extension changes nothing. The tests
>> +	 * below cannot reach this case once smin is negative: a negative smin
>> +	 * and a non-negative smax never share their high bits.
>> +	 */
>> +	if (reg_smin(reg) >= field_smin && reg_smax(reg) <= field_smax)
>> +		return;
>> +
>>   	top_smax_value = ((u64)reg_smax(reg) >> num_bits) << num_bits;
>>   	top_smin_value = ((u64)reg_smin(reg) >> num_bits) << num_bits;
> [Severity: Medium]
> Does the 32-bit counterpart function coerce_subreg_to_size_sx() need the same
> fix?
>
> It seems to retain the same precision loss flaw when handling 32-bit sign
> extensions on ranges that straddle zero (e.g., [-4095, 0]). Valid BPF programs
> using 32-bit MOVSX on such ranges will needlessly lose bounds precision and
> might be incorrectly rejected by the verifier.

Good catch. Fixed now. It would only need to handle sizes 1 and 2 though.


> [Severity: High]
> This is a pre-existing issue, but I noticed a potential out-of-bounds array
> read in the BPF memory cgroup kfuncs.
>
> Enums are treated as scalars by the verifier and can be negative. The bounds
> checks in these functions use single-sided signed comparisons, which bypass
> negative values:
>
> mm/bpf_memcontrol.c:bpf_mem_cgroup_memory_events() {

True signature has enum type

   __bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct 
mem_cgroup *memcg,
                                                          enum 
memcg_memory_event event)

>      ...
> 	if (unlikely(event >= MEMCG_NR_MEMORY_EVENTS))
> 		return (unsigned long)-1;
>
> 	return atomic_long_read(&memcg->memory_events[event]);
> }
>
> If a BPF program passes -1, the check evaluates to false, leading to an
> out-of-bounds read on memcg->memory_events[-1].

Not an issue. enum doesn't have any negative values and with enum tye in 
signature above it will treated as unsigned int so -1 will come out as 
large number not -1.

> A similar issue exists in bpf_mem_cgroup_vm_events(), where the bounds check
> delegates to memcg_vm_event_item_valid():
>
> mm/memcontrol.c:memcg_vm_event_item_valid() {
>      ...
> 	if (idx >= NR_VM_EVENT_ITEMS)
> 		return false;
>      ...
> }
>
> This also performs a single-sided check and fails to catch negative indices.
> Should these be updated to explicitly check for negative values as well?

Same as above since this enum doesn't have negative entries either.

Thx,
-Vineet
