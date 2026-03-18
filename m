Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A221B918
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773874096; cv=none; b=JUoLGx3wD1N4qrq/fdZfxsPoNCEsnkSDfa+vjsFxJ7u3DFipA3px+G9/yKfHnbAggkjYgLK0hX+ICSUpSpwrkiX85A8SrHE7zeFpxopAwfd1woRKdoWVNg36B2sOHxrfdGQCU1YerIn8XxEyDmKtMHTpYXseGU+ktjVyvonXeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773874096; c=relaxed/simple;
	bh=KTYO6QJ2XCdTF3KE7niKsbgYb2hEO+DiUoPhlTXrJYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhfhLFmDGR2/CFXlGrI+sw/3e7qW23s3xknkH6HCO7CQgJ5ZzrEABnLw2bSdYTdSbQYCs4QG3iayBFJE+9F4YUBU7QO1IaKAfKMLkc+m6Vs9l4vvLNhEaPNWI1HPpBLU7d5jqKWhTuzl7OVWfZua5wFAVOYAUJujI5XKA7lqRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eQtCFKHL; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eQtCFKHL"
Message-ID: <1f87fb02-ba86-4615-9f64-d5146a133881@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773874092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2N52NtB8Aa5JR/g0YCTIiTjaY6Eg2PZM0pyIkFgnEE=;
	b=eQtCFKHLzQZiwRAUoXE9Nrb985ZSsB6J8Wf7oOQbB1JPMj0e/u05lGrJSuLxojeOzy5jIB
	UGDLZAeWKzzQPU0NmXkcRaD6wvYd6yZSU4YkhWTAgjLjbPdG1QWwpBk545WUNvogknIEL9
	mfobBjmyU0DnsuFHHVVKU6PxyqjBMwE=
Date: Wed, 18 Mar 2026 15:48:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Support struct btf_struct_meta via
 KF_IMPLICIT_ARGS
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com
Cc: alexis.lothore@bootlin.com, bpf@vger.kernel.org, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260312193546.192786-1-ihor.solodrai@linux.dev>
 <4641dd98f7a3a4f162c24c53e0b246ec5017d79b67cdf93486db2583039f24b2@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <4641dd98f7a3a4f162c24c53e0b246ec5017d79b67cdf93486db2583039f24b2@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/12/26 1:05 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index cb6d242bd093..e5c8fb6596e7 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> 
> [ ... ]
> 
>> +__bpf_kfunc void *bpf_percpu_obj_new(u64 local_type_id__k, struct btf_struct_meta *meta)
>> +{
>> +	u64 size = local_type_id__k;
>> +
>> +	/* The verifier has ensured that meta__ign must be NULL */
>> +	return bpf_mem_alloc(&bpf_global_percpu_ma, size);
>> +}
> 
> The parameter here is named "meta", not "meta__ign". Should this
> comment say "meta" instead?
> 
> [ ... ]
> 
>> +__bpf_kfunc void bpf_percpu_obj_drop(void *p__alloc, struct btf_struct_meta *meta)
>> +{
>> +	/* The verifier has ensured that meta__ign must be NULL */
>> +	bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
>> +}
> 
> Same here -- the comment references "meta__ign" but the parameter is
> "meta".
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 4fbacd2149cd..2e4f1e9b1d37 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
>> @@ -13575,12 +13658,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>>  			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
>> -				if (meta->func_id != special_kfunc_list[KF_bpf_obj_drop_impl]) {
>> +				if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
>>  					verbose(env, "arg#%d expected for bpf_obj_drop_impl()\n", i);
>>  					return -EINVAL;
>>  				}
>>  			} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
>> -				if (meta->func_id != special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
>> +				if (!is_bpf_percpu_obj_drop_kfunc(meta->func_id)) {
>>  					verbose(env, "arg#%d expected for bpf_percpu_obj_drop_impl()\n", i);
>>  					return -EINVAL;
>>  				}
> 
> The conditions now match both bpf_obj_drop and bpf_obj_drop_impl (and
> their percpu variants), but the error messages still reference only
> the _impl names. Would it make sense to update these to say
> "bpf_obj_drop" and "bpf_percpu_obj_drop" respectively, so that a
> developer calling the new variants sees the right function name in
> the error?

All valid nits. Lost this in my inbox before sending v2.
Will send a v3 soon.

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23020502189

