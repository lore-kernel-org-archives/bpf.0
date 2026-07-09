Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E32D73B5
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615235; cv=none; b=R3C2IiFAlJ7l1Uw2BZT73afNldEIxN4a/S/cmVHLNL7BB1dBPioqh9uPikgv6LWZcKXBuGUy7DWwFFrpbxwx+YL5HCxlglWl/8iz6/RD80C+CLcV0lJQeQzTX+aQ64M2Jc4c7Yt2ZiswYLQ8w4vZCzS2GwWY6drjjv5c5V0lCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615235; c=relaxed/simple;
	bh=tAcSWUxkneqJCikv5tTIxNkUJCi1d++Ccp8k2/vK2v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dE+XHnAiL2t8dzEBkQuW9NvxJB3j3wKGSuveYcyba4Y96+TUQGihr2MaNCZ0t/KRIgP2uC3OdIkumkaGwiOIyc8icuZoT29gllBpPOgXXsfZZYOFP/TWyx9jYz7P5dbtHyuvX8NoegIb+3kdfhcHtYVfm9gVOhSAyP+skeTykCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qg5fEOYJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qg5fEOYJ"
Message-ID: <1466cbf7-7b1f-48b2-a573-9c8a5dba9c4f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783615230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wr+oX7lGKEdLAAa2Ha76OX4RCC1LJUr+1omYJP6PFgc=;
	b=Qg5fEOYJBZPn5V7lq1IVDdTBoUTVSBsHvR1D80TnJ27YWt6ZdNiW6mbKLv7vhwTfM7yGmF
	CEjWeLUKoXhhKWbSyPYd5H6AirYW7nQDOkk1+fMalY5xogaFobHgnohnAab/dZwFw4bRsX
	dOEoDGcXozQ+ppgkls8uCsGZojcGbzg=
Date: Thu, 9 Jul 2026 09:40:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 02/12] bpf: Add verifier support for 16-byte
 returns in R0:R2
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260708200949.2156169-1-yonghong.song@linux.dev>
 <24d590de409218c14cbfe4124dbb59737c500b995ddf57d379851fe75c48c437@mail.kernel.org>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <24d590de409218c14cbfe4124dbb59737c500b995ddf57d379851fe75c48c437@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/8/26 2:17 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 3f34ce1a3107d..03ffb5f839fa0 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -424,6 +424,35 @@ static bool subprog_returns_void(struct bpf_verifier_env *env, int subprog)
>>   	return btf_type_is_void(type);
>>   }
>>
>> +static bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	const struct btf_type *type, *func, *func_proto;
>> +	const struct btf *btf = env->prog->aux->btf;
>> +	u32 btf_id;
>> +
>> +	if (!btf || !env->prog->aux->func_info)
>> +		return false;
>> +
>> +	btf_id = env->prog->aux->func_info[subprog].type_id;
>> +
>> +	func = btf_type_by_id(btf, btf_id);
>> +	if (!func)
>> +		return false;
>> +
>> +	func_proto = btf_type_by_id(btf, func->type);
>> +	if (!func_proto)
>> +		return false;
>> +
>> +	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
>> +	if (!type)
>> +		return false;
>> +
>> +	if (btf_type_is_struct(type) || btf_type_is_scalar(type))
>> +		return type->size > 8 && type->size <= 16;
>> +
>> +	return false;
>> +}
> This isn't a bug, but could bpf_ret_reg_pair() and subprog_returns_void()
> share a helper for the func_info -> func -> func_proto -> return type walk?
>
> Both functions repeat the same ~8 line sequence:
>
> subprog_returns_void():
> 	btf_id = env->prog->aux->func_info[subprog].type_id;
> 	func = btf_type_by_id(btf, btf_id);
> 	if (!func)
> 		return false;
> 	func_proto = btf_type_by_id(btf, func->type);
> 	if (!func_proto)
> 		return false;
> 	type = btf_type_skip_modifiers(btf, func_proto->type, NULL);
>
> They only differ in the final predicate: subprog_returns_void() checks
> btf_type_is_void(type), while bpf_ret_reg_pair() checks the struct/scalar
> size.
>
> [ ... ]

Indeed, I think this probably worthwhile to factor a new helper.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28973410219

