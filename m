Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF673ACF0B
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822354; cv=none; b=DEKHRltboDae9A9hs8N6CqTjf+yAWWEFSmOQIn2nnCywiPQfl80x4a9qH/kFE7g3SLaaAKykU+J1QNS+V3OFrkNcMkwfDF6M7IKBKnJ69Up8JelkRXxw/NQSphzRPxIHg//R4YGLA9o02QXhIIL+5uVf7E7d4OqWC3A6707sE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822354; c=relaxed/simple;
	bh=cvYllD7eoYPExw+EYeo74W9hwOcQ72DgvlR2qNX7cME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsUW66XkMiWKZchcf5yxCl8Jdll6tvJnaYSrwWrrUnz8qrMw43IEDHckehvYELURUA3rWCqeYuGtvkUir4fObBhv9Ix4oNqOadEtPaA2HI+ArO/FJHqUDW50f2zHJDxRnWnj78ZGSD3hHk6Qfz3DRbnFxrLZif6NFsyYSiSmpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TZXhUi6N; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TZXhUi6N"
Message-ID: <f72ebb75-66e8-47ae-b1f0-e77d6a24f3e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782822341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxbpRPtc3V96hx23kGkgswvCUJxuCkTGojxcU3JwbNE=;
	b=TZXhUi6NcYnbEU22y9YRe/5m+hQAEKydU3G0LQACu1fCwyrs98RkNvyWEFa7y/1A5R0iSm
	MIl4/f5q4WoOHdxX6z5mrDAlA7a8UGIGG0m6nbLkps1NIsyqlhVT2zHFvH0KOBUe8pxeyH
	XSmHvltW2rhEdpJidr/bOEKrftER3Ks=
Date: Tue, 30 Jun 2026 20:25:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] bpf: Fix smp_processor_id() call trace for preemptible
 kernels
To: Edward Adam Davis <eadavis@qq.com>, sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260630094823.897BD1F00A3D@smtp.kernel.org>
 <tencent_94C3BFC44F9761376546C493608362896E05@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <tencent_94C3BFC44F9761376546C493608362896E05@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/30/26 7:14 PM, Edward Adam Davis wrote:
> On Tue, 30 Jun 2026 09:48:23 +0000, Sashiko wrote:
>> [Severity: High]
>> Does this fix the issue at the right layer? By adding the preemption
>> protection here, it masks the fact that the caller is running with migration
>> enabled, which leaves sibling APIs vulnerable.
>>
>> For example, in __rhtab_map_lookup_and_delete_batch() in
>> kernel/bpf/hashtab.c, the batch loop iterates and calls rhtab_delete_elem()
>> without disabling migration.
>>
>> If the map elements contain special fields (like BPF_KPTR),
>> rhtab_delete_elem() will first call rhtab_check_and_free_fields(), which
>> eventually calls bpf_mem_free().
>>
>> Since bpf_mem_free() also uses this_cpu_ptr() without get_cpu() protection:
>>
>> kernel/bpf/memalloc.c:bpf_mem_free() {
>>      ...
>>      unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
>>      ...
>> }
>>
>> Will this result in the exact same BUG being triggered on that path? Should
>> the missing migration protection be added to
>> __rhtab_map_lookup_and_delete_batch() instead of modifying the allocator
>> here?
> Like this?
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 9f394e1aa2e8..7b98c2eea685 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3345,8 +3345,10 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
>   	}
>   
>   	if (do_delete) {
> +		get_cpu();
>   		for (i = 0; i < total; i++)
>   			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
> +		put_cpu();
>   	}
>   
>   	rcu_read_unlock();


This splat is specific to rhash...

For HASH/PERCPU_HASH/..., most operations are performed under
bpf_disable_instrumentation(); see __htab_map_lookup_and_delete_batch().

But for rhash, bpf_mem_cache_free_rcu() is called outside the
bpf_disable_instrumentation() region; see 
__rhtab_map_lookup_and_delete_batch().

note: map_lookup_and_delete_batch() disable cpu migration


