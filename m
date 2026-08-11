Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD93AE6E2
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463373; cv=none; b=rzuodRd5n6aa64m7w0OU7nvWIUZFjSe04qp/Jj7ED/RWypKaE8ATpkawgqxWHKz/9LksolyQ2LE+32WP1PX7gL34lde2JJxwBFUPXQvU5M4Mci9lWnvmv8zYNddo/rRjjcsl9MIJhsUUS+Rqaax/++bXy4N2fnfB4DIY7fKHonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463373; c=relaxed/simple;
	bh=2TBgIGFaZcLFf0adHF2NzDQrdTb4TQBADdkN/nbdRAo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EOQqUNUHLb4HT4dyx4R81dYGXa7kaly2l9Ogr7AVxB2j6ML44bu1DtVfGH/cvl6XC5FLoubDJy3LvQfQyHrM+2ZOdMuLyP11pKtnzcuPzQkNFe1wwYac37wUYZV/C88xzLyjb/XrOgK7UgIROB048ISQeT6z2vjxTTaWqpjBEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K6JJ+azc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K6JJ+azc"
Message-ID: <28c25566-3b96-4dad-9bae-086b26ddc91b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786463359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4myHVt6WMndOiFoyVNH+J8GydWaaM3knLz8HpNqyZQ=;
	b=K6JJ+azcJVlariZisdWGrP5jvRYBEue37gcxLStTTNygVOTKRw9UtCfjS/QpWZTnSRdcle
	Gapcz6aOf/6G7tDkuNmFL0XNNk0brb0kn2QON/zzzdSIGT0czRVQjxI0IuY0CJ4aoxZrOE
	kAPMVe42si4+4mU+j4GhYVib58VqwJ4=
Date: Tue, 11 Aug 2026 23:49:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 05/10] libbpf: Add support for global percpu
 data
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260806163125.11172-1-leon.hwang@linux.dev>
 <20260806163125.11172-6-leon.hwang@linux.dev>
 <20260806165754.B77971F000E9@smtp.kernel.org>
 <2b16a129-1329-436e-b796-ce83ba4d608b@linux.dev>
Content-Language: en-US
In-Reply-To: <2b16a129-1329-436e-b796-ce83ba4d608b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/8/7 10:36, Leon Hwang wrote:
> On 7/8/26 00:57, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Low] Dead code in percpu global data feature check
>> --
>>
>> --- Patch [5]: [PATCH bpf-next v11 05/10] libbpf: Add support for global percpu data ---
>> commit ee97f8a8e25b5e9337024df3dd6f3a1aae4f6cdc
>> Author: Leon Hwang <leon.hwang@linux.dev>
>>
>> libbpf: Add support for global percpu data
>>
>> This commit adds support for global percpu data in libbpf by introducing a 
>> new ".percpu" section. It updates the lightweight skeleton loader to use 
>> BPF_F_ALL_CPUS when updating the percpu_array map and marks the mmaped data 
>> as read-only after population.
>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 514e4e9daa825..9f79a8e850fdb 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>
>> [ ... ]
>>
>>> @@ -5293,18 +5326,26 @@ static int
>>>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>>>  {
>>>  	enum libbpf_map_type map_type = map->libbpf_type;
>>> +	bool is_percpu = map_type == LIBBPF_MAP_PERCPU;
>>> +	const __u64 update_flags = is_percpu ? BPF_F_ALL_CPUS : 0;
>>>  	int err, zero = 0;
>>>  	size_t mmap_sz;
>>>  
>>> +	if (is_percpu && !obj->gen_loader && !kernel_supports(obj, FEAT_PERCPU_DATA)) {
>>> +		pr_warn("map '%s': kernel does not support percpu data.\n",
>>> +			bpf_map__name(map));
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>
>> [Severity: Low]
>> Is this check reachable? 
>>
>> Looking at bpf_object__create_maps(), if the kernel does not support
>> FEAT_PERCPU_DATA, map->autocreate is set to false and the map processing
>> loop continues early:
>>
>> bpf_object__create_maps() {
>>     ...
>>     if (bpf_map__is_internal(map) && bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY &&
>>         !kernel_supports(obj, FEAT_PERCPU_DATA))
>>         map->autocreate = false;
>>
>>     if (!map->autocreate) {
>>         pr_debug("map '%s': skipped auto-creating...\n", map->name);
>>         continue;
>>     }
>>     ...
>> }
>>
>> Since bpf_object__populate_internal_map() is called later in this same
>> loop (after the continue), wouldn't the !kernel_supports() condition
>> already be filtered out, making this warning dead code?
>>
> 
> True.
> 
> Will drop this warning.
> 
> And, update 'bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY' to
> 'map->libbpf_type == LIBBPF_MAP_PERCPU' in bpf_object__create_maps().
> 


Hi Andrii,

Could you apply this series to bpf-next tree? This series seems good
enough to be merged.

Then, I'll post a separate patch to drop the warning, and update the iff
condition.

Thanks,
Leon

