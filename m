Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63550368282
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308760; cv=none; b=VfFW5k240uTqJuicDlpkoTurs6TKPGA4Kg0Rqr+EuULv0/Y9KNAC1QtzozH24Ex1UlL6GMmQQZwgGeuVc4NlTZcNNg/1CEp2bQekkNT7UYGw4zU+70hPTjzCSI8UvWP4Rc8ajKLvq6Nho9mac5fkE1U1WwBYs74skvrXYoNc54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308760; c=relaxed/simple;
	bh=TKtHiDEM3+ojLpS1LlBsQ+E5vj7Jz7XyAy/YlhOXOIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ikh9O2CCsmu00EKipvXLJtTpoWG14Ui5YRKeuMgUiQwYtmNemR4E5LvkG7SUdiXBYJwE4b8r7mfd0OHMHzaaGwv7+Rewrp2nT5hSreibB1lxye6V8TlZXheOsu6Gyc/9EUlWCpQ4RI0ofWXTRMtKgXlo191VKoHlpLOEcfycR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DHNXrwze; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DHNXrwze"
Message-ID: <86f85bd8-e950-401f-945a-b3cb8b3abc34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781308754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhn4cXdI0IFYsRlSTmznGsVfE3VZVRADNcJE+uCyJDc=;
	b=DHNXrwzeSDc2iXLLKvopu0cSyPG/k4QtmygafUi34mWSASKdrZz6/FW58szBeD36BnslrE
	SAQTXOjxfyDrA9apCFh8acYICOavyYEuX1CNNhcOARPp2BNNxChY6c1qcynhV+S0hAAvVO
	7fHjffgYiki2i+PmaBeXOI1i+sYVLM8=
Date: Fri, 12 Jun 2026 16:59:08 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Better build_id caching in
 stack_map_get_build_id_offset()
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org
Cc: bpf@vger.kernel.org, kernel-team@meta.com, martin.lau@kernel.org,
 yonghong.song@linux.dev, clm@meta.com
References: <20260612220651.2507843-1-ihor.solodrai@linux.dev>
 <f9a5887f90f678d4fbbb021bd603652762132041a16f93a84a99f3607195ebb1@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <f9a5887f90f678d4fbbb021bd603652762132041a16f93a84a99f3607195ebb1@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/12/26 3:37 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 77ba03216c09..822b5cb188ea 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
> 
> [ ... ]
> 
>> @@ -343,8 +410,8 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>  	struct mmap_unlock_irq_work *work = NULL;
>>  	bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
>>  	bool has_user_ctx = user && current && current->mm;
>> -	struct vm_area_struct *vma, *prev_vma = NULL;
>> -	const unsigned char *prev_build_id = NULL;
>> +	struct stack_map_build_id_cache cache = {};
>> +	struct vm_area_struct *vma;
>>  	int i;
>>
>>  	if (may_fault && has_user_ctx) {
> 
> [ ... ]
> 
>> @@ -365,27 +432,29 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>>
>>  	for (i = 0; i < trace_nr; i++) {
>>  		u64 ip = READ_ONCE(id_offs[i].ip);
>> -		u64 offset;
>>
>> -		if (prev_build_id && range_in_vma(prev_vma, ip, ip)) {
>> -			vma = prev_vma;
>> -			offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
>> -			stack_map_build_id_set_valid(&id_offs[i], offset, prev_build_id);
>> +		if (!stack_map_build_id_set_from_cache(&cache, &id_offs[i], ip))
>>  			continue;
>> -		}
>> +
>>  		vma = find_vma(current->mm, ip);
>>  		if (!vma || vma_is_anonymous(vma) ||
>>  		    fetch_build_id(vma, id_offs[i].build_id, may_fault)) {
>> -			/* per entry fall back to ips */
>> +			/* per entry fall back to ips; cache build-ID-less range */
>>  			stack_map_build_id_set_ip(&id_offs[i]);
>> -			prev_vma = vma;
>> -			prev_build_id = NULL;
>> +			if (vma)
>> +				stack_map_build_id_cache_set_unresolved(&cache,
>> +						vma->vm_start, vma->vm_end);
>>  			continue;
>>  		}
>> -		offset = stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip);
>> -		stack_map_build_id_set_valid(&id_offs[i], offset, id_offs[i].build_id);
>> -		prev_vma = vma;
>> -		prev_build_id = id_offs[i].build_id;
>> +		/* mmap_lock is held for the whole loop, so the cached VMA
>> +		 * fields stay valid; no file pinning is needed here.
>> +		 */
>                 ^^^^
> 
> This isn't a bug, but should the comment text start on the line after the
> opening /* to match the BPF multi-line comment style?

sigh... Looks like this also was present in v1, and I missed it.

I'll wait in case there is more feedback before making a v3.

> 
> The other multi-line comments added in this patch follow that convention,
> such as in the new stack_map_build_id_cache structure and the helper
> functions.
> 
>> +		stack_map_build_id_set_valid(&id_offs[i],
>> +			stack_map_build_id_offset(vma->vm_pgoff, vma->vm_start, ip),
>> +			id_offs[i].build_id);
>> +		stack_map_build_id_cache_set_resolved(&cache, NULL, id_offs[i].build_id,
>> +						      vma->vm_start, vma->vm_end,
>> +						      vma->vm_pgoff);
>>  	}
>>  	bpf_mmap_unlock_mm(work, current->mm);
>>  }
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27446103592

