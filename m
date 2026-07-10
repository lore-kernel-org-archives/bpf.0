Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0C437100
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703382; cv=none; b=KPvDexkcEszwRRKythxphlQOJQNYTYJiEAvMLcTl+iDNivqcuT35FO/Mug025LtKAkVN0yosicm2hlPvas2M08dzGSi5klplQ37tHZjsUnN1m1B5fnVLaagr7RjbOo7FQXgkzoeBM27HV3xMWwAuhIL9TaoLEPIHx0+3TTjZNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703382; c=relaxed/simple;
	bh=MgjPlURqzne3teP+KAz4G6j4EY9mGs/T+MliyM+jEwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajQNIU6YkcbmFAIcGwypbtVD36pY5PLhop/prrC6B+okkycdA2L23LHoNg7FsVhfmocbEUeAWaQcAXqYw5NIs/bnXPDagB8R01zhE3DKryHzblshCCZJ4LlNLSuBfYAsye+kQ6f1th9Zi7qxkpl2yAbwucGPx8iCwu9O4fw0grw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DXccjqh5; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DXccjqh5"
Message-ID: <ce047740-79fe-4fc5-a118-40252b169be8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783703368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Io78s8W9WY3CBqsvmomJUNrtoa/qyI3SmZnT613z+io=;
	b=DXccjqh5e6zSTR7Qi7KO9qjOBz/V4EETQIKVyL0e5Uh/W/3hZrVSAWxOVT7GlwjL7R6Z6g
	sCxBbCCPmmR6VYYr1MQYf9HkllG2ETMLUCB29FrgvXE1Uddggc8QN5gaOl+bfxwxO6dzyy
	bRsXLWoRMyMs1CLP2LxRiig9iDwfZ64=
Date: Fri, 10 Jul 2026 10:08:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit args
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260710005902.2234832-1-ihor.solodrai@linux.dev>
 <20260710012112.577F31F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260710012112.577F31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/9/26 6:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Accessing `btf->kfunc_set_tab` without holding a module reference causes a use-after-free vulnerability.
> --
> 
> --- Patch [1]: [PATCH bpf v1 1/2] bpf: Fix tracing of kfuncs with implicit args ---
> commit 13df91bf669b3a55c459c1663fbf726f9f52bc5c
> Author: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> bpf: Fix tracing of kfuncs with implicit args
> 
> A kfunc marked with KF_IMPLICIT_ARGS flag takes implicit arguments
> (such as bpf_prog_aux) that the verifier injects at load time.
> resolve_btfids strips those from the kfunc's BTF-visible prototype and
> keeps the real kernel ABI in a counterpart _impl prototype.
> 
> Link: https://github.com/sched-ext/scx/issues/3687#issuecomment-4906694106
> 
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 64572f85edc83..20aeca6b4f95c 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> [ ... ]
>> @@ -9114,6 +9114,26 @@ u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_p
>>  	return btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>>  }
>>  
>> +/*
>> + * Return the union of a kfunc's flags across all hooks.
>> + * Unlike btf_kfunc_flags(), not restricted to a calling
>> + * program's hook. Used when attaching to a kfunc for tracing.
>> + */
>> +u32 btf_kfunc_accumulated_flags(const struct btf *btf, u32 kfunc_btf_id)
>> +{
>> +	enum btf_kfunc_hook hook;
>> +	u32 *hook_flags;
>> +	u32 flags = 0;
>> +
>> +	for (hook = 0; hook < BTF_KFUNC_HOOK_MAX; hook++) {
>> +		hook_flags = btf_kfunc_id_set_contains(btf, hook, kfunc_btf_id);
>> +		if (hook_flags)
>> +			flags |= *hook_flags;
>> +	}
>> +
>> +	return flags;
>> +}
>> +
>>  u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
>>  				const struct bpf_prog *prog)
>>  {
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6515d4d3c0032..fde11a2f6869a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -19121,8 +19146,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>  		if (prog_extension &&
>>  		    btf_check_type_match(log, prog, btf, t))
>>  			return -EINVAL;
>> -		t = btf_type_by_id(btf, t->type);
>> -		if (!btf_type_is_func_proto(t))
>> +		t = btf_attach_func_proto(log, btf, btf_id);
>> +		if (!t || !btf_type_is_func_proto(t))
>>  			return -EINVAL;
> 
> [Severity: High]
> Does this introduce a use-after-free race condition during module load?
> 
> The new btf_attach_func_proto() call executes before the module reference is
> safely acquired via btf_try_get_module() later in bpf_check_attach_target():
> 
> bpf_check_attach_target()
>   btf_attach_func_proto()
>     btf_kfunc_accumulated_flags()
>       btf_kfunc_id_set_contains()
>         // Accesses btf->kfunc_set_tab->sets[hook]
> 
> If a module is just loading (in MODULE_STATE_COMING) and its BTF is already
> visible, a concurrent BPF_PROG_LOAD could trigger this path. Meanwhile, the
> module's init function might call register_btf_kfunc_id_set(), which uses
> krealloc() on the same array.
> 
> Could the sets array be freed by krealloc() while the verifier is performing a
> binary search on it here?

Not for a module. A module registers each hook set exactly once.
btf_populate_kfunc_set() rejects a second registration with
WARN_ON_ONCE(set && !vmlinux_set), so it's always krealloc(NULL, ...)

And vmlinux sets are all built before BPF_PROG_LOAD can ever run.

That said, the change does violate "call btf_try_get_module() before
using module's btf" expectation. I'll fix this in v2.


> 

