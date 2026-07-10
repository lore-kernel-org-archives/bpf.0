Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7920C00C
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705538; cv=none; b=fcL2oGOlLhtW6E/DogqiWG7celubhQW+M0wWFDter0rtTtbtccsYthIF5SCy9SVGSDIa8Inso0eTfqoR/6VsF4zHbPH1mZiinkzHnPCepASJwO0oaCefkcrpF9kV8tii47x9PYZfgSIh5EPSpYEv6xno6pbMF87QCDeNGJ4cidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705538; c=relaxed/simple;
	bh=nY7Kr3ZkR2wIycYZFiJm76QQaOfw8DQR3G+56wMiVOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWh78ifjmFshoI6al2x1EsfPItF7YBWT4Oso6vB+E3lLL943siF+gUg10wEGkO16uSakJuH2Ou6dlxNG0RSP7zbR/q8EiMl7KifA1OrryUoCqR+Ho7KgXRX7XBxlxNBXqqGZf+pP1f2/N7uxHMTpC3ugnvzrXIyXGSL4lJuRzFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sv2PXtpC; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sv2PXtpC"
Message-ID: <d989e94b-c84f-454d-a6b1-75a7eabfd3af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783705533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cyq/I1pYpj9Z1uU76p5JNkjqODQ4MdT5oNHILYfJAJA=;
	b=Sv2PXtpCOXRFcBozOBV4E6c5KvFf5ZD8ztq3+/cTsUnjeCwKhVTgRWMunhMMIu4Oqcyvot
	waVzOEzViWshVGojFbEHes24U86vh5Lq02ut2p7BE7/0fNBj6ZngK8LzdaVWL7Drg8/hvI
	CrKng2BmjGEmZtDnqVP+b3crhX69x5U=
Date: Fri, 10 Jul 2026 10:45:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf: Reject >8 byte return values on
 return-reading trampoline paths
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20260710144404.2579671-1-yonghong.song@linux.dev>
 <67bf1951-96be-4ccf-adc4-012c7e7f0055@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <67bf1951-96be-4ccf-adc4-012c7e7f0055@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/10/26 9:37 AM, Leon Hwang wrote:
> On 2026/7/10 22:44, Yonghong Song wrote:
>
> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6515d4d3c003..26d281b77a6e 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -18873,6 +18873,20 @@ static int btf_id_allow_sleepable(u32 btf_id, unsigned long addr, const struct b
>>   	return -EINVAL;
>>   }
>>   
>> +static bool attach_uses_trampoline_retval(enum bpf_attach_type type)
>> +{
>> +	switch (type) {
>> +	case BPF_MODIFY_RETURN:
>> +	case BPF_TRACE_FEXIT:
>> +	case BPF_TRACE_FEXIT_MULTI:
>> +	case BPF_TRACE_FSESSION:
>> +	case BPF_TRACE_FSESSION_MULTI:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>>   int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   			    const struct bpf_prog *prog,
>>   			    const struct bpf_prog *tgt_prog,
>> @@ -19137,6 +19151,14 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>>   		if (ret < 0)
>>   			return ret;
>>   
>> +		if (tgt_info->fmodel.ret_size > 8 &&
>> +		    attach_uses_trampoline_retval(prog->expected_attach_type)) {
>> +			bpf_log(log,
>> +				"Attach to function %s with a >8 byte return value is not supported for this attach type\n",
>> +				tname);
>> +			return -EOPNOTSUPP;
>> +		}
>> +
>>   		/*
>>   		 * *.multi programs don't need an address during program
>>   		 * verification, we just take the module ref if needed.
>> @@ -19413,6 +19435,9 @@ int bpf_check_attach_btf_id_multi(struct btf *btf, struct bpf_prog *prog, u32 bt
>>   	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
>>   	if (err < 0)
>>   		return err;
>> +	if (tgt_info->fmodel.ret_size > 8 &&
>> +	    attach_uses_trampoline_retval(prog->expected_attach_type))
>> +		return -EOPNOTSUPP;
>>   	if (btf_is_module(btf)) {
>>   		/* The bpf program already holds reference to module. */
>>   		if (WARN_ON_ONCE(!prog->aux->mod))
>
> I think there's no need to introduce the helper
> attach_uses_trampoline_retval().
>
> See this untested diff:
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03e2202cca13..899d5b129b54 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19023,6 +19023,7 @@ int bpf_check_attach_target(struct
> bpf_verifier_log *log,
>   	const char prefix[] = "btf_trace_";
>   	struct bpf_raw_event_map *btp;
>   	int ret = 0, subprog = -1, i;
> +	bool attach_retval = false;
>   	const struct btf_type *t;
>   	bool conservative = true;
>   	const char *tname, *fname;
> @@ -19232,19 +19233,21 @@ int bpf_check_attach_target(struct
> bpf_verifier_log *log,
>   		if (ret)
>   			return ret;
>   		break;
> +	case BPF_MODIFY_RETURN:
> +	case BPF_TRACE_FEXIT:
> +	case BPF_TRACE_FEXIT_MULTI:
> +	case BPF_TRACE_FSESSION:
> +	case BPF_TRACE_FSESSION_MULTI:
> +		attach_retval = true;
> +		fallthrough;
>   	default:
> -		if (!prog_extension)
> +		if (!prog_extension && !attach_retval)
>   			return -EINVAL;
>   		fallthrough;
> -	case BPF_MODIFY_RETURN:
>   	case BPF_LSM_MAC:
>   	case BPF_LSM_CGROUP:
>   	case BPF_TRACE_FENTRY:
> -	case BPF_TRACE_FEXIT:
> -	case BPF_TRACE_FSESSION:
> -	case BPF_TRACE_FSESSION_MULTI:
>   	case BPF_TRACE_FENTRY_MULTI:
> -	case BPF_TRACE_FEXIT_MULTI:
>   		if ((prog->expected_attach_type == BPF_TRACE_FSESSION ||
>   		    prog->expected_attach_type == BPF_TRACE_FSESSION_MULTI) &&
>   		    !bpf_jit_supports_fsession()) {
> @@ -19275,6 +19278,13 @@ int bpf_check_attach_target(struct

Thanks for the suggestion. I still prefers the helper approach. It provides
a single place in verifier.c to handle this case (tgt_info->fmodel.ret_size > 8).
The above switch already very subtle and the change makes it even more subtle.

> bpf_verifier_log *log,
>   		if (ret < 0)
>   			return ret;
>
> +		if (tgt_info->fmodel.ret_size > 8 && attach_retval) {
> +			bpf_log(log,
> +				"Attach to function %s with a >8 byte return value is not supported
> for this attach type\n",
> +				tname);
> +			return -EOPNOTSUPP;
> +		}
> +
>   		/*
>   		 * *.multi programs don't need an address during program
>   		 * verification, we just take the module ref if needed.
> @@ -19551,6 +19561,13 @@ int bpf_check_attach_btf_id_multi(struct btf
> *btf, struct bpf_prog *prog, u32 bt
>   	err = btf_distill_func_proto(NULL, btf, t, tname, &tgt_info->fmodel);
>   	if (err < 0)
>   		return err;
> +	switch (prog->expected_attach_type) {
> +	case BPF_TRACE_FEXIT_MULTI:
> +	case BPF_TRACE_FSESSION_MULTI:
> +		if (tgt_info->fmodel.ret_size > 8)
> +			return -EOPNOTSUPP;
> +		break;
> +	}
>   	if (btf_is_module(btf)) {
>   		/* The bpf program already holds reference to module. */
>   		if (WARN_ON_ONCE(!prog->aux->mod))
>
>
> WDYT?
>
> Thanks,
> Leon
>

