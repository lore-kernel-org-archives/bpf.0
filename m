Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED657233920
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784523669; cv=none; b=LeyXY8EQLTZLvGgBgi8j3+qIg9P6W+P+1rb5KxmIHXtCtLyiLwYNlszh7Zfy+/wD2e1W0hRJBNIc4loGNzd2IF8XASS+cPIflZy+cLjq8sT/OTOt9uMq26atFl/bW4yGjJVX8gKn3ja9q4Vff/RBQM1MmkGwUEVkQlUW5R6JdOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784523669; c=relaxed/simple;
	bh=0Z/lwmRG0AeMalL+iKxv3YbXrpHHVpkoZPz/RgN3/cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQOjbtxPBLLfofBD6CRkUuRzndVmC1lSGS0i57IytvaNTY/JuP2vJFMq9putOTM91mnHksyL8vUTnBa8TasSo866xmRPR+3W59JpVmRWo+FsesIDKJx3zSsrqhA7ta22RWHdSmDE+OCTyHtbTrlwpno/n+NORPOYoRKIgkFIIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gEopos5l; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gEopos5l"
Message-ID: <149c6e74-fe9e-4b7e-a782-015cc44bec18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784523665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iivp2cjxAhsEaT6zhCWx101EoS9MTB9EfCJa2p/gQbU=;
	b=gEopos5lM6Paz7ub39po8+e0N+Yqrb1l+wkcmuUi4piYlmD51vbPqW+N6o/lE+m4IjJqMy
	pwOimkurPjOEhllXf1060VBjAU2y+iDpMjQxqftyecGalEbAeNovRkctxl0xQwI/e7To+h
	nDmoAbY6MdjI46OdS4gcr0s73ugFkvI=
Date: Mon, 20 Jul 2026 13:00:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 5/9] bpftool: Generate skeleton for global
 percpu data
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-patches-bot@fb.com
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-6-leon.hwang@linux.dev>
 <DK16GZ1CVRYZ.1ZKXOISH3846Z@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DK16GZ1CVRYZ.1ZKXOISH3846Z@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/7/26 05:52, Emil Tsalapatis wrote:
> On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:

[...]

>>  
>>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
>>  {
>> -	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
>> +	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".percpu", ".kconfig" };
>>  	int i, n;
>>  
>>  	/* recognize hard coded LLVM section name */
>> @@ -254,7 +260,7 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>>  	return NULL;
>>  }
>>  
>> -static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>> +static bool is_skel_data(const struct bpf_map *map, char *buf, size_t sz)
> 
> Here we change the function to take PERCPU_ARRAY into account, but then 
> immediately turn around and add checks of the form is_skel_data && type
> != BPF_MAP_TYPE_PERCPU_ARRAY. If we keep both the existing mmapable_map
> and add a separate is_skel_data map (possibly using is_mappable_map),
> we can remove those additional checks.


Agreed.

I'd like to keep this new is_skel_data(), then update the
is_mmapable_map() to:

static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
{
	return is_skel_data(map, buf, sz) && bpf_map__type(map) !=
BPF_MAP_TYPE_PERCPU_ARRAY;
}

Yep, it is not a good choice to use '!=' here. But it can simplify the code.

> 
>>  {
>>  	size_t tmp_sz;
>>  
>> @@ -263,13 +269,19 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
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
>> +		return true;
>> +
>> +	return false;
>>  }
>>  
>>  static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>> @@ -286,8 +298,11 @@ static int codegen_datasecs(struct bpf_object *obj, const char *obj_name)
>>  		return -errno;
>>  
>>  	bpf_object__for_each_map(map, obj) {
>> -		/* only generate definitions for memory-mapped internal maps */
>> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
>> +		/*
>> +		 * Only generate definitions for internal maps that have
>> +		 * mmapped data.
>> +		 */
>> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>>  			continue;
>>  
>>  		sec = find_type_for_map(btf, map_ident);
>> @@ -339,8 +354,14 @@ static int codegen_subskel_datasecs(struct bpf_object *obj, const char *obj_name
>>  		return -errno;
>>  
>>  	bpf_object__for_each_map(map, obj) {
>> -		/* only generate definitions for memory-mapped internal maps */
>> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
>> +		/*
>> +		 * Only generate definitions for internal maps that have
>> +		 * mmapped data.
>> +		 */
>> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>> +			continue;
>> +
>> +		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
>>  			continue;
> 
> Case in point, the old is_mmapable_map would work fine here.

Yes.

> 
>>  
>>  		sec = find_type_for_map(btf, map_ident);
>> @@ -493,7 +514,10 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
>>  	return map_sz;
>>  }
>>  
>> -/* Emit type size asserts for all top-level fields in memory-mapped internal maps. */
>> +/*
>> + * Emit type size asserts for all top-level fields in internal maps that
>> + * have mmaped data.
> 
> I do not think the new comment makes it any clearer, the difference is
> "memory-mapped internal maps" and "maps that are memory-mapped initially
> but actually inaccessible after loading because there's no way to 
> represent them as a mapping of the skeleton" AFAICT which is not easy
> to infer currently.


Hmm, it is hard to explain the new case that the mmaped data is visible
in user-space, but is invisible in kernel-space.

Will drop this change.

> 
>> + */
>>  static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
>>  {
>>  	struct btf *btf = bpf_object__btf(obj);
>> @@ -517,7 +541,7 @@ static void codegen_asserts(struct bpf_object *obj, const char *obj_name)
>>  		", obj_name);
>>  
>>  	bpf_object__for_each_map(map, obj) {
>> -		if (!is_mmapable_map(map, map_ident, sizeof(map_ident)))
>> +		if (!is_skel_data(map, map_ident, sizeof(map_ident)))
>>  			continue;
>>  
>>  		sec = find_type_for_map(btf, map_ident);
>> @@ -669,7 +693,8 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>>  		if (!get_map_ident(map, ident, sizeof(ident)))
>>  			continue;
>>  		if (bpf_map__is_internal(map) &&
>> -		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
>> +		    ((bpf_map__map_flags(map) & BPF_F_MMAPABLE) ||
>> +		     bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY))
> 
> I think this gives us a hint on how we could structure is_skel_data
> above, we now have a special calss that is "mappable maps + PERCPU_ARRAY
> whose initial representation in userspace is mappable, but the loaded
> map isn't".

Will use is_skel_data() here.

Thanks,
Leon

> 
>>  			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zu);\n",
>>  			       ident, bpf_map_mmap_sz(map));
>>  		codegen("\
>> @@ -741,7 +766,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>>  		const void *mmap_data = NULL;
>>  		size_t mmap_size = 0;
>>  
>> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
>> +		if (!is_skel_data(map, ident, sizeof(ident)))
>>  			continue;
>>  
>>  		codegen("\
>> @@ -849,8 +874,22 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>>  	bpf_object__for_each_map(map, obj) {
>>  		const char *mmap_flags;
>>  
>> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
>> +		if (!is_skel_data(map, ident, sizeof(ident)))
>> +			continue;
>> +
>> +		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY) {
>> +			codegen("\
>> +		\n\
>> +			err = skel_protect_map_data(skel->%1$s, &skel->maps.%1$s.initial_value, %2$zd);\n\
>> +			if (err)					    \n\
>> +				return err;				    \n\
>> +		#ifdef __KERNEL__					    \n\
>> +			skel->%1$s = NULL;				    \n\
>> +		#endif							    \n\
>> +			",
>> +			ident, bpf_map_mmap_sz(map));
>>  			continue;
>> +		}
>>  
>>  		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)
>>  			mmap_flags = "PROT_READ";
>> @@ -955,8 +994,7 @@ codegen_maps_skeleton(struct bpf_object *obj, size_t map_cnt, bool mmaped, bool
>>  				map->map = &obj->maps.%s;	    \n\
>>  			",
>>  			i, bpf_map__name(map), ident);
>> -		/* memory-mapped internal maps */
>> -		if (mmaped && is_mmapable_map(map, ident, sizeof(ident))) {
>> +		if (mmaped && is_skel_data(map, ident, sizeof(ident))) {
>>  			printf("\tmap->mmaped = (void **)&obj->%s;\n", ident);
>>  		}
>>  
>> @@ -1740,7 +1778,9 @@ static int do_subskeleton(int argc, char **argv)
>>  		/* Also count all maps that have a name */
>>  		map_cnt++;
>>  
>> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
>> +		if (!is_skel_data(map, ident, sizeof(ident)))
>> +			continue;
>> +		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
>>  			continue;
> 
> Another instance of what I was talking about.
> 
>>  
>>  		map_type_id = bpf_map__btf_value_type_id(map);
>> @@ -1863,7 +1903,9 @@ static int do_subskeleton(int argc, char **argv)
>>  
>>  	/* walk through each symbol and emit the runtime representation */
>>  	bpf_object__for_each_map(map, obj) {
>> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
>> +		if (!is_skel_data(map, ident, sizeof(ident)))
>> +			continue;
>> +		if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
>>  			continue;
>>  
>>  		map_type_id = bpf_map__btf_value_type_id(map);
>> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
>> index 53fee53d36d5..1f3f332dffbe 100644
>> --- a/tools/lib/bpf/skel_internal.h
>> +++ b/tools/lib/bpf/skel_internal.h
>> @@ -131,8 +131,10 @@ static inline void skel_free_map_data(void *p, __u64 addr, size_t sz)
>>  {
>>  	if (addr != ~0ULL)
>>  		kvfree(p);
>> -	/* When addr == ~0ULL the 'p' points to
>> -	 * ((struct bpf_array *)map)->value. See skel_finalize_map_data.
>> +	/*
>> +	 * When addr == ~0ULL the init buffer has already been released.
>> +	 * For skel_finalize_map_data(), 'p' points to
>> +	 * ((struct bpf_array *)map)->value.
>>  	 */
>>  }
>>  
>> @@ -170,6 +172,15 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
>>  	return addr;
>>  }
>>  
>> +static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
>> +{
>> +	(void)sz;
>> +
>> +	kvfree(p);
>> +	*init_val = ~0ULL;
>> +	return 0;
>> +}
>> +
>>  #else
>>  
>>  static inline void *skel_alloc(size_t size)
>> @@ -208,6 +219,15 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
>>  		return NULL;
>>  	return addr;
>>  }
>> +
>> +static inline int skel_protect_map_data(void *p, __u64 *init_val, size_t sz)
>> +{
>> +	(void)init_val;
>> +
>> +	if (mprotect(p, sz, PROT_READ))
>> +		return -errno;
>> +	return 0;
>> +}
>>  #endif
>>  
>>  static inline int skel_closenz(int fd)
> 

