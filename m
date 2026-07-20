Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338A2D97BB
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784523567; cv=none; b=Jb18xHF5haYptR4hkqITfAV9L2qN5Rwg1WJ+QiimGvQlWCrK/JC6uyBoA8KeGapkdi3uc+P/6v9qnrzFtbWbwAvVB70s3yX489mLpynCmF7vVIHMVwtu+fjwL8eM89jj5pgX9xQobZU4JpuexS3w0I/wmgltxCQMeAVQGjQJyYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784523567; c=relaxed/simple;
	bh=BJS2+mkFhprys5kERsW68INIvtIVaX1Ay3f+CUlrrOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3IYyc4rQM4fPMoOL4RqMehJ7ZrPXrWN6VqXktaHPEA83SDwaQhgelSLUOZ/9kmShssseFeWghX37zgMYK9z5OWZbXRitzeCc/U5HixTwQ9cnB4UDDncnSAWt4zHRgfFeDNs2Jhtvpse/Fw644nk952jZm1dD0yK1A7JGm6qy+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rV99D+Ml; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rV99D+Ml"
Message-ID: <9615cf9b-4a77-4d7a-aec4-8990ea6ff638@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784523552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrDWATovCwgpMVQwj7SV06bEzlRmjyDz0ZNXxVdu1V8=;
	b=rV99D+Ml9dKH1LlS85UylG9LFBx765lVm4TPNBdY+VJFv1wAeaCTEcarO3t6QvsTA3W+sx
	D4VYvrrGbTvcM1yd4YEvS7Alrq85HiIO12xLp1PT8Nqdgrpd8OsiSC398cBq94fngY6lNb
	XrW4jBkgxo5zGNKxZFTfn4TkURDbgtw=
Date: Mon, 20 Jul 2026 12:59:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 2/9] bpf: Introduce global percpu data
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
 <20260715153254.92010-3-leon.hwang@linux.dev>
 <DK0MRMWIAE1T.20UJQKK2YN3VY@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DK0MRMWIAE1T.20UJQKK2YN3VY@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/7/26 14:25, Emil Tsalapatis wrote:
> On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:

[...]

>>  
>> +static int percpu_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
>> +{
>> +	struct bpf_array *array = container_of(map, struct bpf_array, map);
>> +
>> +	if (map->max_entries != 1)
>> +		return -EOPNOTSUPP;
>> +	if (off >= map->value_size)
>> +		return -EINVAL;
>> +	if (!bpf_jit_supports_percpu_insn())
>> +		return -EOPNOTSUPP;
> 
> Nit: This should be first, if the JIT doesn't support the instruction
> all else is moot. Same below.

Ack.

> 
>> +
>> +	*imm = (u64)(__force unsigned long) array->pptrs[0];
>> +	return 0;
>> +}
>> +
>> +static int percpu_array_map_direct_value_meta(const struct bpf_map *map, u64 imm, u32 *off)
>> +{
>> +	struct bpf_array *array = container_of(map, struct bpf_array, map);
>> +	u64 base = (u64)(__force unsigned long) array->pptrs[0];
>> +
>> +	if (map->max_entries != 1)
>> +		return -EOPNOTSUPP;
>> +	if (imm < base || imm >= base + array->elem_size)
>> +		return -ENOENT;
>> +	if (!bpf_jit_supports_percpu_insn())
>> +		return -EOPNOTSUPP;
>> +
>> +	*off = imm - base;
>> +	return 0;
>> +}
>> +

[...]

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e1244a721194..ae442ea217c4 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5615,6 +5615,8 @@ int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
>>  	u64 addr;
>>  	int err;
>>  
>> +	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY || map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
>> +		return -EINVAL;
>>  	err = map->ops->map_direct_value_addr(map, &addr, off);
>>  	if (err)
>>  		return err;
>> @@ -6174,6 +6176,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
>>  			if (tnum_is_const(reg->var_off) &&
>>  			    bpf_map_is_rdonly(map) &&
>>  			    map->ops->map_direct_value_addr &&
>> +			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY &&
>>  			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
> 
> An issue I have with the patch is that it takes the special-casing we
> already have for INSN_ARRAY and makes it worse. The instruction arrays
> implement direct_value_addr, but it's not actually valid to call
> direct_value_addr from a bunch of places where it's called, so we have
> to special case check the map type to prevent it. Case in point the
> special casing in check_arg_const_str in the thunk below.
> 
> Imo we should consider making a different map method different from
> direct_value_addr that INSN_ARRAY and PERCPU_ARRAY implement. That way
> we remove most of the map type checks in those paths. I'm not exactly
> sure how that would look like, but I could take a look at it tomorrow.


Seems reasonable to me. I don't have good candidates for the new map
method name.

Instead of making a new map method, how about factoring out a helper for
the 'if (t == BPF_READ && value_regno >= 0) {}' block? It will simplify
these map_type checks in the helper.

> 
>>  				int map_off = off + reg->var_off.value;
>>  				u64 val = 0;
>> @@ -8176,6 +8179,12 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
>>  		return -EACCES;
>>  	}
>>  
>> +	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY) {
>> +		verbose(env, "%s points to percpu_array map which cannot be used as const string\n",
>> +			reg_arg_name(env, argno));
>> +		return -EACCES;
>> +	}
>> +
>>  	if (!bpf_map_is_rdonly(map)) {
>>  		verbose(env, "%s does not point to a readonly map'\n", reg_arg_name(env, argno));
>>  		return -EACCES;
>> @@ -18279,6 +18288,12 @@ static int check_and_resolve_insns(struct bpf_verifier_env *env)
>>  					return -EINVAL;
>>  				}
>>  
>> +				if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY &&
>> +				    !env->prog->jit_requested) {
>> +					verbose(env, "JIT is required to use global percpu data\n");
>> +					return -EOPNOTSUPP;
>> +				}
>> +
> 
> Another place where we add map-specific checks where there are none.


I think this check is unnecessary, because 'prog->jit_required = true'
has been set for global percpu data.

Will drop this if.

Thanks,
Leon

> 
>>  				err = map->ops->map_direct_value_addr(map, &addr, off);
>>  				if (err) {
>>  					verbose(env, "invalid access to map value pointer, value_size=%u off=%u\n",
> 

