Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34092E8B9B
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721839; cv=none; b=vEFWTDcLvJE64lybDVC8ImzYy6EqUcC/eiFQoxAywG0ztEsxVcWvP1pVTSCZ4hBQXQ+94eiQlT2erEYEUQ0liEWxF+0FOM48FQJOwfd0sCUZBq9Rz4cnermRa+FN8ft4YGTanodZ85YEmVKy71XL6um+O5LjJWtLSPDYd/Z+Pq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721839; c=relaxed/simple;
	bh=r/AKtcfmh+i0t/IAyo56XCM2gpkFYyYIGp9e1yvhZY4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s7bEkcytyEI5qD2c/gPZ4bNG3M0dPN9XEauBSBNcbnSnZvIBTOu7JVIJYVZ5qP61BQoTNGWc/sHEWspsLPxvSgQlXAU5ABN24Xs7KyaL8SG+zEOQ/hkOqs9+Lzh0J7owQLtxK8ULz/G9MXpJ8T+Geyihn2DAwoMddll8nzBzMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qhf4Xd6W; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qhf4Xd6W"
Message-ID: <24e52e2a-d47e-4baf-9ce8-d66e8bb9b99c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785721835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KGjkU2S+UQ8+uueiw5ohLDox719eKH3WXwxyMJy25ow=;
	b=Qhf4Xd6Wi5go8vXBwrtXiQPqbnq9Z/zzsn1/6iOznD9EpeUv7JIdwDZ2tTuZymfSYRJOMA
	m6SqQm/WPRFc913JBP6FVcXBiSL++n+AwRhsMFiqIvXTcEgG6SZof4l+qwT0yLbMk4VtT7
	sjt5oUTUNFgaVM6enwNNXeAIrriXDZQ=
Date: Mon, 3 Aug 2026 09:50:24 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 4/9] libbpf: Add support for global percpu
 data
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Andrii Nakryiko <andrii@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-5-leon.hwang@linux.dev>
 <DK167GCPUAJE.3GGIPEE5MIX3G@etsalapatis.com>
 <39e09b62-53b4-4f3a-928a-1fdeac8c7dc4@linux.dev>
Content-Language: en-US
In-Reply-To: <39e09b62-53b4-4f3a-928a-1fdeac8c7dc4@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/7/26 12:59, Leon Hwang wrote:
> On 18/7/26 05:39, Emil Tsalapatis wrote:
>> On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
> 
> [...]
> 
>>>  
>>>  struct elf_sec_desc {
>>> @@ -1839,6 +1842,8 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
>>>  	switch (map->def.type) {
>>>  	case BPF_MAP_TYPE_ARRAY:
>>>  		return array_map_mmap_sz(map->def.value_size, map->def.max_entries);
>>> +	case BPF_MAP_TYPE_PERCPU_ARRAY:
>>> +		return map->def.value_size;
>>>  	case BPF_MAP_TYPE_ARENA:
>>>  		return page_sz * map->def.max_entries;
>>>  	default:
>>> @@ -1866,7 +1871,8 @@ static int bpf_map_mmap_resize(struct bpf_map *map, size_t old_sz, size_t new_sz
>>>  	return 0;
>>>  }
>>>  
>>> -static char *internal_map_name(struct bpf_object *obj, const char *real_name)
>>> +static char *internal_map_name(struct bpf_object *obj, const char *real_name,
>>> +			       enum libbpf_map_type type)
>>
>> We can avoid passing the type here by testing against ".percpu" since
>> that's how we are deriving the map type in the first place. But more
>> importantly:
>>
>>>  {
>>>  	char map_name[BPF_OBJ_NAME_LEN], *p;
>>>  	int pfx_len, sfx_len = max((size_t)7, strlen(real_name));
>>> @@ -1907,8 +1913,11 @@ static char *internal_map_name(struct bpf_object *obj, const char *real_name)
>>>  	if (sfx_len >= BPF_OBJ_NAME_LEN)
>>>  		sfx_len = BPF_OBJ_NAME_LEN - 1;
>>>  
>>> -	/* if there are two or more dots in map name, it's a custom dot map */
>>> -	if (strchr(real_name + 1, '.') != NULL)
>>> +	/*
>>> +	 * Don't prefix the bpf_object name if this is a custom dot map
>>> +	 * (containing two or more dots) or a percpu data map.
>>> +	 */
>>> +	if (strchr(real_name + 1, '.') != NULL || type == LIBBPF_MAP_PERCPU)
>>
>> Is there a reason we don't use the exact same logic as the other
>> internal maps here? I understand that a lot of the conventions around
>> the naming are there for legacy reasons, but it seems like we're
>> singling out the .percpu section for highly nonbvious reasons. Imo we
>> should consider doing the same prefixing for a bare ".percpu" section
>> that we do for the other internal ones. At the very least, there needs
>> to be some explanation as to why .percpu gets special treatment.
> 
> 
> I prefer passing 'type'. Excluding _PERCPU here is to avoid the legacy
> naming convention for new internal maps.
> 
>>
>> @Andrii Wdyt? 
>>
>>>  		pfx_len = 0;
>>>  	else
>>>  		pfx_len = min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1, strlen(obj->name));
>>> @@ -1938,7 +1947,7 @@ static bool map_is_mmapable(struct bpf_object *obj, struct bpf_map *map)
>>>  	struct btf_var_secinfo *vsi;
>>>  	int i, n;
>>>  
>>> -	if (!map->btf_value_type_id)
>>> +	if (!map->btf_value_type_id || map->libbpf_type == LIBBPF_MAP_PERCPU)
>>>  		return false;
>>
>> Nit: These are two separate checks rolled into one, and each one checks
>> a different thing. THe type check against MAP_PERCPU merits a comment as
>> well: It's the only internal section that is not really mappable because
>> there's no way to represent it as userspace state.
> 
> 
> Ack.
> 
> Will add a new iff for libbpf_type check with a comment.
> 
>>
>>>  
>>>  	t = btf__type_by_id(obj->btf, map->btf_value_type_id);
>>> @@ -1962,6 +1971,7 @@ static int
>>>  bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>>  			      const char *real_name, int sec_idx, void *data, size_t data_sz)
>>>  {
>>> +	bool is_percpu = type == LIBBPF_MAP_PERCPU;
>>>  	struct bpf_map_def *def;
>>>  	struct bpf_map *map;
>>>  	size_t mmap_sz;
> [...]
> 
>>> @@ -4944,7 +4970,7 @@ static int map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map)
>>>  
>>>  	/*
>>>  	 * LLVM annotates global data differently in BTF, that is,
>>> -	 * only as '.data', '.bss' or '.rodata'.
>>> +	 * only as '.data', '.bss', '.percpu' or '.rodata'.
>>>  	 */
>>>  	if (!bpf_map__is_internal(map))
>>>  		return -ENOENT;
>>> @@ -5293,18 +5319,30 @@ static int
>>>  bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>>>  {
>>>  	enum libbpf_map_type map_type = map->libbpf_type;
>>> +	bool is_percpu = map_type == LIBBPF_MAP_PERCPU;
>>
>> Nit: If we do 
>> 	__u64 update_flags = is_percpu ? BPF_F_ALL_CPUS : 0;
>>
>> we can declare the variable as const and ...
>>
>>> +	__u64 update_flags = 0;
>>>  	int err, zero = 0;
>>>  	size_t mmap_sz;
>>>  
>>> +	if (is_percpu) {
>>> +		if (!obj->gen_loader && !kernel_supports(obj, FEAT_PERCPU_DATA)) {
>>> +			pr_warn("map '%s': kernel does not support percpu data.\n",
>>> +				bpf_map__name(map));
>>> +			return -EOPNOTSUPP;
>>> +		}
>>> +
>>> +		update_flags = BPF_F_ALL_CPUS;
>>> +	}
>>
>> ... we can collapse the above into a single nested level:
>>
>> 	if (is_percpu && !obj->gen_loader && !kernel_supports(obj, FEAT_PERCPU_DATA)) {
>> 		...
>> 	}
> 
> Good point.
> 
>>
>>> +
>>>  	if (obj->gen_loader) {
>>>  		bpf_gen__map_update_elem(obj->gen_loader, map - obj->maps,
>>> -					 map->mmaped, map->def.value_size);
>>> +					 map->mmaped, map->def.value_size, update_flags);
>>>  		if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG)
>>>  			bpf_gen__map_freeze(obj->gen_loader, map - obj->maps);
>>>  		return 0;
>>>  	}
>>>  
>>> -	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, 0);
>>> +	err = bpf_map_update_elem(map->fd, &zero, map->mmaped, update_flags);
>>>  	if (err) {
>>>  		err = -errno;
>>>  		pr_warn("map '%s': failed to set initial contents: %s\n",
>>> @@ -5349,6 +5387,13 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
>>>  			return err;
>>>  		}
>>>  		map->mmaped = mmaped;
>>> +	} else if (is_percpu) {
>>> +		if (mprotect(map->mmaped, mmap_sz, PROT_READ)) {
>>> +			err = -errno;
>>> +			pr_warn("map '%s': failed to mprotect() contents: %s\n",
>>> +				bpf_map__name(map), errstr(err));
>>> +			return err;
>>> +		}
>>>  	} else if (map->mmaped) {
>>>  		munmap(map->mmaped, mmap_sz);
>>>  		map->mmaped = NULL;
>>> @@ -10807,11 +10852,16 @@ static bool map_uses_real_name(const struct bpf_map *map)
>>>  	 * such map's corresponding ELF section name as a map name.
>>>  	 * This check distinguishes .data/.rodata from .data.* and .rodata.*
>>>  	 * maps to know which name has to be returned to the user.
>>> +	 * Map name of the custom .percpu.* maps might be truncated to
>>> +	 * BPF_OBJ_NAME_LEN-1 chars in internal_map_name(). Hence, percpu data
>>> +	 * maps must use real name for their user-visible name.
>>>  	 */
>>>  	if (map->libbpf_type == LIBBPF_MAP_DATA && strcmp(map->real_name, DATA_SEC) != 0)
>>>  		return true;
>>>  	if (map->libbpf_type == LIBBPF_MAP_RODATA && strcmp(map->real_name, RODATA_SEC) != 0)
>>>  		return true;
>>> +	if (map->libbpf_type == LIBBPF_MAP_PERCPU)
>>> +		return true;
>>
>> Same comment as above here wrt uniformity. This is the part that
>> requires us to check agianst the map type in __init_internal_map().
> 
> 
> Let us wait for Andrii's comment.
> 

Hi Andrii,

Any comment?

Thanks,
Leon

