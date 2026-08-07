Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022952C1788
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070203; cv=none; b=fxHrjC2JmZZsNkvHuffkaRwuZi9e1jNVlekLA8V9iqiBtMUNcuDb+xk+IYnG+zCfVusvKfxYdrlfdX9izMa3WuA9oYrTmppCt8GsArrJYWAAKmfIVxPxwhd/PYeDaZgGgm88iYcicidyEcPeGtoRFI4DZOiEN+3Cuxx4sogWmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070203; c=relaxed/simple;
	bh=RjdbIv/92OBQVKHvI8DoYf/S79ml1my5Lf3FSLlpQs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQ2XwjTcfFedh866KONznOcdi7GgHzLVVdI2/GxF+kNvkBmx2dk0eFF/k/nhEy7X2KOAiRo3XjV9g+6rTaCvoa7zKY+XVtLHp7FR6FZmmWG3n8uDW55X0yrawBzdKT3pELQ/UkwtRJoWxsHLMId8WH18uCLlU+Ve39Dywm4jWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XZM29nRm; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XZM29nRm"
Message-ID: <2b16a129-1329-436e-b796-ce83ba4d608b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786070190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ou9YQoj58vv1yhpCBAsrG70nlVGkHXknkmpj957MAM=;
	b=XZM29nRmHugTAnrQBHHzvb4NCEZQOEc/4CMxS8JIQ/iJaWkbbAjaXosXPKbW2Xq3AeyzY7
	dvuBRMS9BX9JWXEZP9ZhWysPoRLvhuiCPJ4UgfFkNqmH5tNp03U2b05sUOnr6C1qCVWZ2l
	sJVHWLtYxs70F9Z+VUuijP/uTcWT9Zc=
Date: Fri, 7 Aug 2026 10:36:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 05/10] libbpf: Add support for global percpu
 data
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260806163125.11172-1-leon.hwang@linux.dev>
 <20260806163125.11172-6-leon.hwang@linux.dev>
 <20260806165754.B77971F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260806165754.B77971F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/26 00:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Dead code in percpu global data feature check
> --
> 
> --- Patch [5]: [PATCH bpf-next v11 05/10] libbpf: Add support for global percpu data ---
> commit ee97f8a8e25b5e9337024df3dd6f3a1aae4f6cdc
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> libbpf: Add support for global percpu data
> 
> This commit adds support for global percpu data in libbpf by introducing a 
> new ".percpu" section. It updates the lightweight skeleton loader to use 
> BPF_F_ALL_CPUS when updating the percpu_array map and marks the mmaped data 
> as read-only after population.
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa825..9f79a8e850fdb 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -5293,18 +5326,26 @@ static int
>>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>>  {
>>  	enum libbpf_map_type map_type = map->libbpf_type;
>> +	bool is_percpu = map_type == LIBBPF_MAP_PERCPU;
>> +	const __u64 update_flags = is_percpu ? BPF_F_ALL_CPUS : 0;
>>  	int err, zero = 0;
>>  	size_t mmap_sz;
>>  
>> +	if (is_percpu && !obj->gen_loader && !kernel_supports(obj, FEAT_PERCPU_DATA)) {
>> +		pr_warn("map '%s': kernel does not support percpu data.\n",
>> +			bpf_map__name(map));
>> +		return -EOPNOTSUPP;
>> +	}
>> +
> 
> [Severity: Low]
> Is this check reachable? 
> 
> Looking at bpf_object__create_maps(), if the kernel does not support
> FEAT_PERCPU_DATA, map->autocreate is set to false and the map processing
> loop continues early:
> 
> bpf_object__create_maps() {
>     ...
>     if (bpf_map__is_internal(map) && bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY &&
>         !kernel_supports(obj, FEAT_PERCPU_DATA))
>         map->autocreate = false;
> 
>     if (!map->autocreate) {
>         pr_debug("map '%s': skipped auto-creating...\n", map->name);
>         continue;
>     }
>     ...
> }
> 
> Since bpf_object__populate_internal_map() is called later in this same
> loop (after the continue), wouldn't the !kernel_supports() condition
> already be filtered out, making this warning dead code?
> 

True.

Will drop this warning.

And, update 'bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY' to
'map->libbpf_type == LIBBPF_MAP_PERCPU' in bpf_object__create_maps().

Thanks,
Leon

