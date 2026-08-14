Received: from mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F48296BC8
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 06:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786687970; cv=none; b=Y5s9vThhfwePjdlDIx3H+8t7TAviE/znShLhviuE0vrgW6phLoad82NCpusEMFP3NzlK7A7gv+qr+auppaZOAzoje3ze4GeJqWORKS7pUkT5Hw/HhNyXUz2FXLoDUItgVsNJy91JM7kYhwlnHWqE90NjY0mBAMZq19PBEpaLmcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786687970; c=relaxed/simple;
	bh=L90ab17fh6i5j6O9COB4cSteBc9RGNKCbqLdHSck5Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KoaDE+fvE98t6tjdv3dhfSG9PqJ+iXhJwbG6E02eJram6uWdfdzuaMBG8LSwItc+02jgpW29dz0hnwoBFgXJo983d/AN4xWYVfxHtwpRXosNcXkMgOnNG4cMrSV39Ty9QiVt2Devk/1BXEC6YjRlRliqLpV07PgbzHl3KUBnAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xMyORaU6; arc=none smtp.client-ip=95.215.58.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xMyORaU6"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L90ab17fh6i5j6O9COB4cSteBc9RGNKCbqLdHSck5Ag=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786687966; v=1; x=1787292766;
 b=xMyORaU6pdWatvbEtojOD1zOEnTHuZX+0NdXRWnlQSfyBWxG2D8OleKjQICGTXe3JJDXywZY
 0hwXPcGQ1Qj55s1lp1AV5NKwG/gp1UqTh17/mmXnS28Sit/JDSI8mMetuguKqLDALvTaQjixHEG
 UYF3mzEnasOef7YuRrmiyapk=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id 7f3db8feae3a1828;
	Fri, 14 Aug 2026 06:12:46 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e7a89c70-1f76-431e-a57e-6f6b10c3d029@linux.dev>
Date: Fri, 14 Aug 2026 14:12:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v12 06/10] bpftool: Generate skeleton for global
 percpu data
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260813152324.97937-7-leon.hwang@linux.dev>
 <5e196fcd4e2ac190d9232398274607860c07747f6d5adf39fb41db4f0a8d0167@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <5e196fcd4e2ac190d9232398274607860c07747f6d5adf39fb41db4f0a8d0167@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/8/26 00:26, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index a01d06d22d1a3..a50540ef6521c 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
> 
> [ ... ]
> 
>> @@ -254,7 +260,7 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>>  	return NULL;
>>  }
>>
>> -static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>> +static bool is_skel_data(const struct bpf_map *map, char *buf, size_t sz)
>>  {
>>  	size_t tmp_sz;
>>
>> @@ -263,13 +269,24 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>>  		return true;
>>  	}
>>
>> -	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>> +	if (!bpf_map__is_internal(map))
>>  		return false;
>>
>>  	if (!get_map_ident(map, buf, sz))
>>  		return false;
>>
>> -	return true;
>> +	if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
>> +		return true;
>> +
>> +	if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
>> +		return bpf_map__btf_value_type_id(map) != 0;
>> +
>> +	return false;
>> +}
>> +
>> +static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>> +{
>> +	return is_skel_data(map, buf, sz) && bpf_map__type(map) != BPF_MAP_TYPE_PERCPU_ARRAY;
>>  }
>>
>>  static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>> @@ -287,7 +304,7 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>>
>>  	bpf_object__for_each_map(map, obj) {
>>  		/* only generate definitions for memory-mapped internal maps */
>> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
>> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>>  			continue;
> 
> The comment here says "only generate definitions for memory-mapped
> internal maps," but is_skel_data() now also returns true for
> BPF_MAP_TYPE_PERCPU_ARRAY maps. Those percpu maps are never
> memory-mapped: map_is_mmapable() in tools/lib/bpf/libbpf.c returns false
> for LIBBPF_MAP_PERCPU, which is why this patch had to add mprotect() for
> the init buffer rather than relying on shared mmap.
> 
> When you removed the identical comment from codegen_maps_skeleton()
> (line 988), should this one have been updated to say "skeleton data maps"
> or "internal maps exposed as skeleton data" to match what is_skel_data()
> actually checks?
> 
> The same wording also appears at line 534 in codegen_asserts():

Will update the comments.

> 
>>  	bpf_object__for_each_map(map, obj) {
>> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
>> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>>  			continue;
> 
> where the comment above (line 513) says "Emit type size asserts for all
> top-level fields in memory-mapped internal maps." That comment now covers
> percpu maps too.

Will update the comment to "Emit type size asserts for all top-level
fields in skel data maps.".

Thanks,
Leon

> 
