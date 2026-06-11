Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BACC343884
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154567; cv=none; b=KjiIPY7rSLgdUCl+J/eP31z9IJswicrtw469k5nBwjcMkdzmeYdfjoXkBMqXmw/aGj1yTzYF+baEEOEWVjaobwEO3OysPsQPUcrYmTsQpTS1xos40+xRULF4MRsacDQTuEyiPrgYug785wbVhVEd9j0LrnXucA249VSK1yLBdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154567; c=relaxed/simple;
	bh=EIkQpsi0hIfaWwwQ8lXEVPLC+tHG5I9Y2bhf4TlkfPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PM1T5kkFBIfUkF3tvxNMmPg98Vx/9/qE9Cn05HO5Z3+N9LqZf3KvX3eD/sd6aoxJUtwFd6xec+R2HlUMSG/bi8/5b+scwL+atGVDiGhaQbfcnsO13OpSFKWeZdda16OfjdoJ1q4NOitGW8B5zF52BGL7IZWcve0etljxxzRI1tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EyNmpyrN; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EyNmpyrN"
Message-ID: <76112c8e-e9c2-463d-80a3-171fae5a98c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781154557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ot0PB1cUCdj59LIuhmYBgeIah0KgI7O/WS+FeWAXis8=;
	b=EyNmpyrNSu2xXjU2nOw2haYmPO/Xydg34ABcgp0GRd34Bx7W2csRt4hfmHGhEkZjzAkueW
	+pfoQ0DLF1x4va22mVd0RhjkeXb0t6LHLAnx1SYFrSXEHNxruPNQcO0UUgepHRdVtoVcFr
	BwSpUSIoun/hs4jZYf4psxrZD/dw+m8=
Date: Thu, 11 Jun 2026 13:09:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 5/9] bpftool: Generate skeleton for global
 percpu data
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260608145113.65857-6-leon.hwang@linux.dev>
 <20260608151109.D0A701F00893@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260608151109.D0A701F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 23:11, sashiko-bot@kernel.org wrote:
[...]
>> @@ -263,13 +268,12 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>  		return true;
>>  	}
>>  
>> -	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>> -		return false;
>> -
>> -	if (!get_map_ident(map, buf, sz))
>> -		return false;
>> +	if (bpf_map__is_internal(map) &&
>> +	    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) || bpf_map_is_percpu_data(map)) &&
>> +	    get_map_ident(map, buf, sz))
>> +		return true;
>>  
>> -	return true;
>> +	return false;
>>  }
> 
> [Severity: High]
> Does forcibly treating the percpu maps as mmapable here break subskeletons?
> 
> Since subskeletons operate on an already-loaded BPF object to read or write
> live state, this change might cause do_subskeleton() to export pointers to
> disconnected user-space memory.
> 
> If they point to the disconnected PROT_READ initialization buffer instead of
> live state, would reads always return stale initial data and fail to reflect
> live kernel modifications?
> 

Do subskeletons operate on an already-loaded BPF object to read or write
live state?

If true, will skip percpu data variables for subskeleton.

> [ ... ]
> 
>> @@ -847,7 +851,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>>  	bpf_object__for_each_map(map, obj) {
>>  		const char *mmap_flags;
>>  
>> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
>> +		if (!is_mmapable_map(map, ident, sizeof(ident)) || bpf_map_is_percpu_data(map))
>>  			continue;
>>  
>>  		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
> 
> [Severity: High]
> Does skipping map finalization for percpu maps in light skeletons leave the
> user-space initialization buffer mapped as PROT_READ | PROT_WRITE?
> 
> In standard skeletons managed by libbpf, the buffer is protected with
> PROT_READ to explicitly crash on invalid writes.
> 
> If we skip finalization here in gen_trace(), it seems writes to lskel->percpu
> after load() might silently succeed without actually updating the kernel map.
> 

The buffer should be protected with PROT_READ in light skeletons. Will
do it.

Thanks,
Leon

