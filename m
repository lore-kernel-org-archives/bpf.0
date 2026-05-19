Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDA39282C
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231058; cv=none; b=PsBXgS6AKsYB9m+ibXAAaDIdO0axOCmyAeBl0RC6uV05rRNAw0w+BDezC3CDGynYRC1HdZHQGCKQcsc5ihS9x3bK7w9K/IpUtgurLuRPCZulQKkaa8OwCSACkBGCTlpHMzbVgzmmsLCBc98OaI8dl2A1dZ+RYHr9XdiDAtYjy6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231058; c=relaxed/simple;
	bh=qvunAzYom6U7kpS/NXewRpm05Vb+irFPzTHjhYYV2zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odt1PSlCwPff+mCYyAdbwT/ZLVOTRHK3Mk7S1puDFn9d+tYiemgnZ8LTUHVmI7/PSxcV5ChdYepLfVOhaxXwSuA+yQAZCtDaacYi0sL8l3qKnk3B2eIBohaRdCA9EJuYFeVZu1hPBiRayk8vA1zR/SIMhKAPIXdok85zpXHlG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K7ZJOBx2; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K7ZJOBx2"
Message-ID: <b239e40b-8065-4ebd-a275-d4e4528e187b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779231044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pg2m1U+9WYeCEE25g9gd/+MPxvr2fLvjle/mkoWv1io=;
	b=K7ZJOBx2UOrOqe75wO3wWadIyzaGZk7lPo1BmHqsd9/AzHNoQpMZSjvcB+jvmTFzMwkUP5
	FzLuPx8eUXCbTpQ1AJvEhqfXTOiVxERWNGYMXqtSIPU2HN+ja8f3nkfrH6ppf6+IHuyKzt
	ABNhgciVVVW+ZTdgR1IvqjOXnRzY2s0=
Date: Tue, 19 May 2026 15:50:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 08/12] bpf: Add a few bpf_cgroup_array_*
 helper functions
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>
References: <20260519215841.2984970-9-martin.lau@linux.dev>
 <20260519224522.6B0941F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260519224522.6B0941F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/19/26 3:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] bpf_cgroup_array_copy_to_user() incorrectly returns -ENOSPC when the requested count is zero.
> 
> Pre-existing issues:
> - [Critical] purge_effective_progs() calculates linear indices that do not account for BPF_F_PREORDER physical reordering, leading to Use-After-Free.
> --
> 
> commit 23e774d89cf8101cef3b2e8789a63f7fb930be02
> Author: Martin KaFai Lau <martin.lau@kernel.org>
> 
> bpf: Add a few bpf_cgroup_array_* helper functions
> 
> This patch adds bpf_cgroup_array_*() helper functions to prepare for
> supporting struct_ops maps in the cgroup bpf array. These helpers currently
> skip the dummy_bpf_prog, which is the same as the existing behavior.
> The callers are changed to use these new helpers as a no-op change.
> 
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index b5769f5401e64..a033aa479ab6e 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
> 
> [ ... ]
> 
>> +static int bpf_cgroup_array_copy_to_user(struct bpf_prog_array *array,
>> +					 __u32 __user *prog_ids, int cnt,
>> +					 enum cgroup_bpf_attach_type atype)
>> +{
>> +	struct bpf_prog_array_item *item;
>> +	int i = 0;
>> +	u32 id;
>> +
>> +	for (item = array->items; item->prog && i < cnt; item++) {
>> +		if (item->prog == bpf_cgroup_array_dummy(atype))
>> +			continue;
>> +		id = item->prog->aux->id;
>> +		if (copy_to_user(prog_ids + i, &id, sizeof(id)))
>> +			return -EFAULT;
>> +		i++;
>> +	}
>> +	return item->prog ? -ENOSPC : 0;
>> +}
> 
> [Severity: High]
> If cnt is 0 (which happens if the attach type only has dummy programs,
> causing bpf_cgroup_array_length() to return 0), the loop condition i < cnt
> will fail immediately. At this point, item->prog still points to a dummy
> program (which is not NULL).
> 
> Does this incorrectly return -ENOSPC instead of 0?
> 
> If this occurs during __cgroup_bpf_query(), it looks like the entire
> syscall could fail with -ENOSPC even when the user provided a large enough
> buffer.
> 
> [ ... ]
> 
>> @@ -1124,7 +1185,7 @@ static void purge_effective_progs(struct cgroup *cgrp, struct bpf_prog *prog,
>>   				lockdep_is_held(&cgroup_mutex));
>>   
>>   		/* Remove the program from the array */
>> -		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
>> +		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),
> 
> [Severity: Critical]
> This is a pre-existing issue, but does pos correctly reflect the program's
> physical index in the effective array?
> 
> When building the effective program array, compute_effective_progs() places
> programs with BPF_F_PREORDER at the beginning of the array. However,
> purge_effective_progs() calculates pos by sequentially iterating through
> the hierarchy's hlists, which does not account for this reordering.

It is a question I have also raised in the commit message of patch 9 also.
> 
> If update_effective_progs() fails (for example, due to OOM) during detach,
> purge_effective_progs() is called as a fallback.
> 
> With the incorrect pos, could bpf_cgroup_array_delete_safe_at() overwrite
> the wrong program with a dummy, leaving the intended program in the
> effective array?
> 
> Since __cgroup_bpf_detach() subsequently calls bpf_prog_put() on the
> detached program, the effective array would be left holding a dangling
> pointer to a freed bpf_prog, which could result in a use-after-free when
> the cgroup hook runs.
> 
>>   			  "Failed to purge a prog from array at index %d", pos);
>>   	}
>>   }
> 

