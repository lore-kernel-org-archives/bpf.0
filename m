Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E730FC16
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371906; cv=none; b=P9XHhgJslFuDGKfLT+lO8ECXkDgzp2Ys8gpLndBoP+j1OvALMuouufqYFf7HwsvuqQR/5poDSzr5h7uYELDCpSMVy2BgK6YvbUhd/wY76ksjteIn89HziVg6jBY2IUJ+/ZFLSxZgP+HgYLZ45FTkWJkibMnhjFElps9vS7nNSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371906; c=relaxed/simple;
	bh=yC1Z0TiOPMAgvivg3lt3qH73cqNAstQvk7XGTySsvXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwsPJXwxEW9Kep0LsJmY1pN7dW/OwLU/KhcmvAuoSCLRtQOLaEHTnyZAY8J89ajFD2SeEIpFmYZpKW9a9qKM+jddGK3OVT6xlVj1eOIRdbdsKRqVjTFeeRzNjv9vo5QJCZo5bqr2Gr21FCtUNlhPOn1fdfku+O/7YWcW+lLxTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RUcebRQG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RUcebRQG"
Message-ID: <9da8a837-697b-4753-bdd7-e0e766c9221e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770371893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wBbLEIsP6u5g6AHc6pziE1QfBxFt8JeGrlPDHoJXqg=;
	b=RUcebRQGCcLlHWq5lcWWonnxD7Ium5rsaXUgMz8e6RsKBGMAixp5bb3RqmYqFamMDrg1Ne
	0F+2BW3/HoBDVWapgXuhWZZdF5In0oT3La7wDAZCeKyliTNp7GrHy6F4XkzE0gPVjBbhZp
	EIceeRHJNPckL1bnZz21WHesSDGZbMQ=
Date: Fri, 6 Feb 2026 17:58:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add preempt disable for
 bpf_get_stackid
To: bot+bpf-ci@kernel.org, song@kernel.org, jolsa@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260206090653.1336687-2-chen.dylane@linux.dev>
 <0062e81b59efb3839bd4f9a3459cc54730dbbfb9dd2f688df72d3b4669cab90e@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <0062e81b59efb3839bd4f9a3459cc54730dbbfb9dd2f688df72d3b4669cab90e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/2/6 17:34, bot+bpf-ci@kernel.org 写道:
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index 1b100a03ef2e..d263f851f084 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
> 
> [ ... ]
> 
>> @@ -280,12 +297,22 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>   		/* for build_id+offset, pop a bucket before slow cmp */
>>   		new_bucket = (struct stack_map_bucket *)
>>   			pcpu_freelist_pop(&smap->freelist);
>> -		if (unlikely(!new_bucket))
>> -			return -ENOMEM;
>> +		if (unlikely(!new_bucket)) {
>> +			ret = -ENOMEM;
>> +			goto go_out;
>> +		}
>>   		new_bucket->nr = trace_nr;
>>   		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
>>   		for (i = 0; i < trace_nr; i++)
>>   			id_offs[i].ip = ips[i];
>> +
>> +		/*
>> +		 * It is safe after perf callchain ips copied to bucket buffer
>> +		 * to reduce the length of preempt section, we can enable preempt here.
>> +		 */
>> +		if (!trace_in)
>> +			preempt_enable();
>> +
> 
> When the stack_map_use_build_id() path falls through to insert a new entry
> (neither the hash_matches early return nor the -EEXIST early return is
> taken), this preempt_enable() is called here, and then the code continues
> to go_out where preempt_enable() is called again.
> 
> The sequence when trace_in == NULL:
> 
>      preempt_disable()                   // entering __bpf_get_stackid
>      ...
>      if (!trace_in)
>          preempt_enable();               // here, after copying IPs
>      ...
>      // fall through to insert new entry
>      new_bucket->hash = hash;
>      ...
>      xchg(&smap->buckets[id], new_bucket);
>      ...
> go_out:
>      if (!trace_in)
>          preempt_enable();               // second enable - imbalanced
> 
> The two direct returns (return id and return -EEXIST) after the early
> preempt_enable() correctly bypass go_out. However, when inserting a new
> stack trace (the normal case when no exact match exists and the bucket
> can be reused), the code falls through to go_out and calls preempt_enable()
> a second time.
> 

will fix it in v3, and wait for other comments from matainers.

> Could this cause preempt_count underflow when using BPF_F_STACK_BUILD_ID
> maps with bpf_get_stackid()?
> 
>> @@ -317,31 +349,21 @@ static long __bpf_get_stackid(struct bpf_map *map,
>>   	old_bucket = xchg(&smap->buckets[id], new_bucket);
>>   	if (old_bucket)
>>   		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
>> -	return id;
>> +
>> +go_out:
>> +	if (!trace_in)
>> +		preempt_enable();
>> +	return ret;
>>   }
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21745231308
> 
> AI-authorship-score: low
> AI-authorship-explanation: The commit shows typical human patterns including a control-flow bug from manual refactoring that AI would likely catch, combined with natural but slightly awkward phrasing in comments.
> issues-found: 1
> issue-severity-score: high
> issue-severity-explanation: Preempt count underflow in the build_id path causes kernel warnings and potential system instability when inserting new stack traces.


-- 
Best Regards
Tao Chen
