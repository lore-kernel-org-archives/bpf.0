Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCDE2E7179
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507730; cv=none; b=ejcNwRgCMn0UcNLhr2/NLjHw6tREeOJZaNwUG3E4FxuNg6glCu9Bn75LQlu/OY7EjkKn4dZAK/mOKas7Tc+WhRXEo0399qi1HZELCrHRQoLqvVUSq1mdyGe0eDR707XD8WbIQh6HVL/w0auyymuRthv4CbLm7NUmSlOqMJc2o1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507730; c=relaxed/simple;
	bh=vwHAkDctMYBjsbJdxFFxSqLh7SCbl5pspuWDwDn5tWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoGPKWXI+LEcutEQBD3nhaPtGOum6yFat5SYDA92XabOHG4MacU0S4oetXTWPcKqPqmXUIy1pej5T5QuvL7KZ/NdSKheDBN16IMEEvpGGgkKa5PFOO7SLsmFm8YMPxHrqlqb7/yErCl73X3JCnNc3m96Vu0JyeOOhpQiiBxZXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AVuJcSOX; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AVuJcSOX"
Message-ID: <27c32796-c265-408d-b12c-6c307db01943@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786507727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WVwTrkX3p77Vyzv+J/1SigeABNhqxZJeXVvTaI+3/U=;
	b=AVuJcSOXR3J8eDUMpjoG0COR98J7g1xy+aQqsEi2LVaEjdeEsD90vl0CdDYZ+dBFEeYmb5
	KiZBfZwlShVxBq9qUMPpd8EJiEIPxrIWWi4RWgvlYcCMyTPAEeyLhEHOYjoMC61ijqZwMZ
	CethRfCClH7UpcMCUK1xnmGCatgWxEk=
Date: Wed, 12 Aug 2026 12:08:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 12/13] selftests/bpf: Add tracing_multi bpf prog
 link info test
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-13-leon.hwang@linux.dev>
 <20260809152940.0EFDF1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260809152940.0EFDF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/8/26 23:29, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing array sorting in user-space targets leads to flaky test
> - [Medium] Uninitialized stack variable `fids` passed to kernel
> --
> 
> --- Patch [12]: [PATCH bpf-next 12/13] selftests/bpf: Add tracing_multi bpf prog link info test ---
> commit 5ee3239754522a052ad0eb2cf3e2485319bff581
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> selftests/bpf: Add tracing_multi bpf prog link info test
>     
> Verify the link info works well for bpf prog targets of tracing_multi link.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
>> index 0918321c8e63d..a5f8bfcb1e07a 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> [ ... ]
>> @@ -467,13 +489,48 @@ static int setup_tmulti_targets(const struct bpf_program *prog,
>>  	return -1;
>>  }
>>  
>> +static int setup_tmulti_bpf_prog_targets(const struct bpf_program *prog, int token_fd,
>> +					 const __u64 *cookies,
>> +					 const struct bpf_program * const *target_progs,
>> +					 struct tmulti_target *targets,
>> +					 __u32 *btf_obj_id)
>> +{
> [ ... ]
>> +		targets[i].cookie = cookies[i];
>> +		targets[i].id = prog_info.id;
>> +		targets[i].func_btf_id = func_btf_id;
>> +	}
>> +
>> +	return setup_tmulti_btf_obj_id(prog, btf_obj_id);
>> +}
> 
> [Severity: Medium]
> Will this lead to flaky tests? The kernel sorts the tracing_multi targets by a
> computed key during attachment.
> 
> When returning link info, the arrays are returned in this sorted order, and
> verify_tracing_multi_link_info() asserts that they perfectly match the targets
> array at the exact same indexes.
> 
> However, unlike setup_tmulti_targets(), this function does not call qsort() on
> the targets array. If ID allocation wraps around or another process allocates
> IDs concurrently, this might fail non-deterministically.
> 

Will add qsort() here.

>> +
>>  static int verify_tracing_multi_link_info(int fd, const struct bpf_program *prog,
>>  					  const struct tmulti_target *targets,
>> -					  __u32 btf_obj_id, bool has_cookies)
>> +					  __u32 btf_obj_id, __u32 count,
>> +					  bool has_cookies, bool tgt_progs)
>>  {
>> +#define TMULTI_CNT (TRACING_MULTI_CNT > TRACING_MULTI_BPF_CNT ? \
>> +		    TRACING_MULTI_CNT : TRACING_MULTI_BPF_CNT)
>>  	enum bpf_attach_type attach_type = bpf_program__expected_attach_type(prog);
>> -	__u64 addrs[TRACING_MULTI_CNT], cookies[TRACING_MULTI_CNT];
>> -	__u32 ids[TRACING_MULTI_CNT];
>> +	__u64 addrs[TMULTI_CNT], cookies[TMULTI_CNT];
>> +	__u32 ids[TMULTI_CNT], fids[TMULTI_CNT];
>>  	struct bpf_link_info info;
>>  	__u32 len = sizeof(info);
>>  	int err, i;
> [ ... ]
>>  	memset(ids, 0, sizeof(ids));
>>  	memset(cookies, 0, sizeof(cookies));
>> @@ -496,7 +555,8 @@ static int verify_tracing_multi_link_info(int fd, const struct bpf_program *prog
>>  	info.tracing_multi.ids = ptr_to_u64(ids);
>>  	info.tracing_multi.addrs = ptr_to_u64(addrs);
>>  	info.tracing_multi.cookies = has_cookies ? ptr_to_u64(cookies) : 0;
>> -	info.tracing_multi.count = TRACING_MULTI_CNT;
>> +	info.tracing_multi.func_btf_ids = tgt_progs ? ptr_to_u64(fids) : 0;
>> +	info.tracing_multi.count = count;
>>  
>>  	err = bpf_link_get_info_by_fd(fd, &info, &len);
> 
> [Severity: Medium]
> Does this code leave the fids array uninitialized?
> 
> The other stack arrays (ids, cookies, addrs) are explicitly cleared with
> memset() before being passed to the bpf_link_get_info_by_fd() syscall, but
> fids is not. This could potentially cause issues with uninitialized memory.
> 

Will add 'memset(fids, 0, sizeof(fids))'.

Thanks,
Leon

