Received: from mta0.migadu.com (out-4.mta0.migadu.com [91.218.175.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425F3E5ED1
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 04:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789100840; cv=none; b=XqlD1wDKJ1gNFkR3ApGfupWm3g0ZH3It0f9vZhY/hxaC4uEe1ZUvLjd90BDlLDXbpEdL9bKvaWWoOnng0DYbRb1ekMp+CCZaB2PZsgs/+jbET2K2FlkLCyjWRpyOwEKw0RuXI+cf6lcqUvlU8kCMNRyKNuX07n5XGnOsGVGPGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789100840; c=relaxed/simple;
	bh=FZ7+Qsyfcz8m+PbGomIyArnAcCvHSIFWYtLBYAY2SC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y85W1n/BGsifVIwLTaAIGBwg6WKboyaac/pEe6Oaj7Ck4Rm/Jxsg1Hj0cVPMAQA9JDFILffU+rpD0CCsesxLpV0U/pmXVZB7NbFujrCKXMkQHIEezXdyG4MKpZDSG7zlEWdmNzIdiqEBz6RJCql0tl44UX0dG9T6dSUNzItTTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bOwSs2WT; arc=none smtp.client-ip=91.218.175.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bOwSs2WT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FZ7+Qsyfcz8m+PbGomIyArnAcCvHSIFWYtLBYAY2SC0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789100835; v=1; x=1789705635;
 b=bOwSs2WTSzbjPg/pZQWjhSaA8mEdE4BAtHGNPELecZ0RVj5fbgE5Z8osWW867EvMOKAdvrTu
 nvd1fRVGchcQtEvE9hVHEpaLfE0cAHcos75b42zfib0sAB1kNnP/kkQqHBZotvagzIWEhU4KEkl
 Pz/KX7KO4Rr1Z+cILKXOgVqs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d0ad1d7329b3dad2;
	Fri, 11 Sep 2026 04:27:15 +0000
X-Mizu-Trace-ID: d0ad1d7329b3dad2
X-Migadu-Flow: FLOW_OUT
Message-ID: <f305d666-e649-4b68-a34c-f81b2db6091b@linux.dev>
Date: Thu, 10 Sep 2026 21:27:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 02/12] bpf: Index global function arguments by
 argument slot
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260909062533.4002610-1-yonghong.song@linux.dev>
 <015098d2b080372b27acd82b6bea918f3762ba1c4f49a8c26ca273842ba67547@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <015098d2b080372b27acd82b6bea918f3762ba1c4f49a8c26ca273842ba67547@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/26 12:13 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 31057c8f3a7c..104a91f5ffd5 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -8037,7 +8037,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   	const struct btf_param *args;
>>   	const struct btf_type *t, *ref_t, *fn_t;
>>   	int err;
>> -	u32 i, nargs, btf_id;
>> +	u32 i, slots_used, nargs, btf_id;
>>   	const char *tname;
> [ ... ]
>
>>   	args = (const struct btf_param *)(t + 1);
>>   	nargs = btf_type_vlen(t);
>>   	sub->arg_cnt = nargs;
> [ ... ]
>
>> @@ -8122,8 +8122,9 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   	/* Convert BTF function arguments into verifier types.
>>   	 * Only PTR_TO_CTX and SCALAR are supported atm.
>>   	 */
>> -	for (i = 0; i < nargs; i++) {
>> +	for (i = 0, slots_used = 0; i < nargs; i++) {
>>   		u32 tags = 0;
>> +
> [ ... ]
>
>> @@ -8254,6 +8260,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   		return -EINVAL;
>>   	}
>>
>> +	sub->arg_cnt = slots_used;
>> +
> This isn't a bug, but would a short comment on the early 'sub->arg_cnt =
> nargs;' noting that it exists only so the error path in
> btf_check_func_arg_match() has a stack-arg count, and that the
> authoritative slot count is set after the loop, make the two meanings of
> arg_cnt easier to keep straight in the later patches?

I will rename arg_cnt to arg_slot_cnt to make it clear.

>
>>   	sub->args_cached = true;
>>
>>   	return 0;
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34320399441

