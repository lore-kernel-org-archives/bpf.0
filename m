Received: from mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEE4B2031
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005432; cv=none; b=OUBou5UPvcKC1enLbyn3/VzvAGp2YTlcAAH5hO96nY6SmSDQER6XnA1xAuU0yNFt6eRQZTMIkm7Sx8+BhcFMAZRQDW45bSQtyT8+C8C10/pmI+ZbZzmFflC9H0GcJR2gZlUzSchyoG2C9dZXtW02N/yyArx3Ylra/W6p63BTsBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005432; c=relaxed/simple;
	bh=gpmRDH4YzLw1WHl2Uosl2eeV0mSZvwBOt8c+40q0wA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSH2iFadz6Y4ubBX0zTV3uLb9aJG4JbCKqFvUlwsABk3Ye59oShXc6hrNJGRjt+dJAzmz3OxAb8gGsN3wEBy8M/+cWvgHJ25wRJ/bvGxQPrLiztRXnSqu/4Bn0ebV4uz/fo4xo7+RrKlpBNMdDBcw8dG4CPbhRLUd3QTu7oz+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wggBA8hT; arc=none smtp.client-ip=95.215.58.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wggBA8hT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gpmRDH4YzLw1WHl2Uosl2eeV0mSZvwBOt8c+40q0wA0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790005427; v=1; x=1790610227;
 b=wggBA8hTnS1AvS2ILPvChUW6PlF+hQjN+R9Jl482Df7ZX1zjBFcgFo3AwzmkbOG8itKI8t/Y
 FIBxeX+GeLLYCZOsWlXZmcfAMOg5n25ISFLn1I5Mm5SUvow9aGCs1fBbflx3QIGnce1im85pF+U
 RCz+dfFFgHGerN2D6bJVI1xo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4b02a64f2017c2e7;
	Mon, 21 Sep 2026 15:43:47 +0000
X-Mizu-Trace-ID: 4b02a64f2017c2e7
X-Migadu-Flow: FLOW_OUT
Message-ID: <3407188b-e4ff-45e4-b90a-ea0e62a4ba3a@linux.dev>
Date: Mon, 21 Sep 2026 08:43:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/20] bpf: Accept the compiler's exception
 cleanup table at program load
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260920054225.864535-1-yonghong.song@linux.dev>
 <20260920054231.865520-1-yonghong.song@linux.dev>
 <20260920055653.6D6D91F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260920055653.6D6D91F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 10:56 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] bpf: unbounded memory allocation in check_cleanup_info via cleanup_info_cnt
> --
>
> commit 18ab7230f0d26780fd3b40453aca2155a679f967
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Accept the compiler's exception cleanup table at program load
>
> This commit adds support for BPF exception handling cleanup tables generated
> by LLVM. It introduces a new UAPI to pass the .bpf_cleanup table into the
> kernel via BPF_PROG_LOAD, along with the necessary validation logic in
> check_cleanup_info().
>
> Link: https://github.com/llvm/llvm-project/pull/192164 [1]
>
>> diff --git a/kernel/bpf/check_btf.c b/kernel/bpf/check_btf.c
>> index 0e8b3ccc7a5b9..d03dc791042a2 100644
>> --- a/kernel/bpf/check_btf.c
>> +++ b/kernel/bpf/check_btf.c
> [ ... ]
>
>> @@ -407,6 +407,149 @@ static int check_core_relo(struct bpf_verifier_env *env,
>>   	return err;
>>   }
>>   
>> +static int cleanup_insn_subprog(struct bpf_verifier_env *env, u32 off)
>> +{
> [ ... ]
>
>> +static int check_cleanup_info(struct bpf_verifier_env *env,
>> +			      const union bpf_attr *attr,
>> +			      bpfptr_t uattr)
>> +{
>> +	u32 krec_size = sizeof(struct bpf_cleanup_info);
>> +	u32 i, nrec, urec_size, min_size, prev_end = 0;
>> +	struct bpf_cleanup_info *krecord;
>> +	bpfptr_t urecord;
>> +	int ret = -EINVAL;
>> +
>> +	nrec = attr->cleanup_info_cnt;
>> +	if (!nrec)
>> +		return 0;
>> +	if (nrec > INT_MAX / krec_size)
>> +		return -EINVAL;
> [Severity: Medium]
> Can an unprivileged user trigger a multi-gigabyte memory allocation here
> by passing an artificially large attr->cleanup_info_cnt?
>
> While the allocation below uses GFP_KERNEL_ACCOUNT and will not cause a CPU
> lockup, kvcalloc() still attempts to allocate and zero up to ~2.1 GB of
> memory.
>
> Since each cleanup info record must cover at least one instruction and
> they cannot overlap, is there a case where nrec could legitimately
> exceed env->prog->len? Would it be safer to add a bounds check like
> if (nrec > env->prog->len) before the allocation to prevent this
> resource churn?

Okay, I will use the above condition to limit the upper bound of memory
allocation.

>
>> +
>> +	urec_size = attr->cleanup_info_rec_size;
>> +	if (urec_size < MIN_BPF_CLEANUP_INFO_SIZE ||
>> +	    urec_size > MAX_CLEANUP_INFO_REC_SIZE ||
>> +	    urec_size % sizeof(u32)) {
>> +		verbose(env, "invalid cleanup info rec size %u\n", urec_size);
>> +		return -EINVAL;
>> +	}
>> +
>> +	krecord = kvcalloc(nrec, krec_size, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> [ ... ]
>

