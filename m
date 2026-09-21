Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E54AB1AA
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006146; cv=none; b=ZQagu2meTqVWydHpVwHD5AZithEsISGVMb6z2W7PKIVXJ33o3Ml6HRruY/inVPvt58NbaB0pPjtIawUP2TLngA4LbXfmXmTp+GxRmhxIR4ZhTFhIaEvyf2KI9bBJttcpSrg3ZLOVPxb+iLcFAarlzti1uJDtO/re/m5MxdnfDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006146; c=relaxed/simple;
	bh=8ib0CO4B2w8yiSCOX32m2ti/uDjrIl5dv9F2gCvdsPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fK/cGLATjZ50MJLrHoC9pWCu/2b+zSzRcABTl9iAkbMz5CTTEZdVtub4kHzemaIQtMVU/0gQnvagdOQjgAdBIG6QKjKFlrEPtrh14h291NlHdHdypWrNviWp7YIwyjWu+LCSKmc7s8kAVITkVxxQ7IsmVaz6eRLPUd8uPew6qxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FGOVo9fh; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FGOVo9fh"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8ib0CO4B2w8yiSCOX32m2ti/uDjrIl5dv9F2gCvdsPw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790006142; v=1; x=1790610942;
 b=FGOVo9fhlVEo+Xt9u8IsZfX4mWxopGSl5/AtlByZfB5YCMys91/4UuBQVttgVehS9aBUJcvv
 XSCrpIjCP4GL6NXL86SX5WRTVlWfEzUeuajM0/KbBa/VmGmfdFJGxBAqMbc3dXGhKJkzTNxEzIE
 JmWOv61zixcXtfvYR/RMh2gw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d37cbe4e34ee13fe;
	Mon, 21 Sep 2026 15:55:25 +0000
X-Mizu-Trace-ID: d37cbe4e34ee13fe
X-Migadu-Flow: FLOW_OUT
Message-ID: <fa10eda0-cdc1-4c31-afaa-5cfa0a0e848b@linux.dev>
Date: Mon, 21 Sep 2026 08:55:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 10/20] bpf: Dispatch exception cleanup pads
 from bpf_throw()
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260920054317.870021-1-yonghong.song@linux.dev>
 <16d53b65310325ae6e5c4c49c2ddbc02146050c34ffba04b25a071a70ffdf9cf@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <16d53b65310325ae6e5c4c49c2ddbc02146050c34ffba04b25a071a70ffdf9cf@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/26 11:32 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 5033b934ffd9..0502b9fc4a6d 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
> [ ... ]
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index 4859d6484cc8..d4dcbcf4fb25 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
> [ ... ]
>
>> @@ -499,3 +501,164 @@ int bpf_cleanup_pad_of_call(struct bpf_verifier_env *env, u32 idx)
>>
>>   	return pad ? (int)pad - 1 : -1;
>>   }
>> +
>> +int bpf_cleanup_alloc_info(struct bpf_prog_aux *aux)
>> +{
>> +	if (aux->exc)
>> +		return 0;
>> +	aux->exc = kzalloc_obj(struct bpf_exception_info, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>> +	return aux->exc ? 0 : -ENOMEM;
>> +}
>> +
>> +int bpf_cleanup_attach_info(struct bpf_prog_aux *aux, struct bpf_cleanup_info *recs, u32 cnt)
>> +{
>> +	struct bpf_exception_info *exc = aux->exc;
>> +	struct bpf_cleanup_range *ranges;
>> +	u32 i, n_at, *at;
>> +
>> +	if (!cnt) {
>> +		kvfree(recs);
>> +		return 0;
>> +	}
> This isn't a bug, but bpf_cleanup_attach_info()'s only caller already
> returns early when cnt is zero - is the `if (!cnt)` arm here reachable,
> or would dropping it (and letting the caller keep owning that case) make
> the recs ownership easier to follow?

Will drop the above if condition.

>
>> +
>> +	ranges = kvcalloc(cnt, sizeof(*ranges), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> [ ... ]
>
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 558653d3046d..169cbf9f4415 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
> [ ... ]
>
>> @@ -1114,6 +1124,129 @@ static void bpf_restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_s
>>   	env->subprog_info[env->subprog_cnt].start = env->prog->len;
>>   }
>>
>> +static int cleanup_pad_body_for_subprog(struct bpf_verifier_env *env, struct bpf_prog *sub,
>> +					u32 start, u32 end)
>> +{
>> +	unsigned long *bits;
>> +	u32 i, cnt = 0;
>> +
>> +	for (i = start; i < end; i++)
>> +		if (env->insn_aux_data[i].in_cleanup_pad)
>> +			cnt++;
>> +	if (!cnt)
>> +		return 0;
>> +
>> +	bits = bitmap_zalloc(end - start, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
>> +	if (!bits)
>> +		return -ENOMEM;
>> +
>> +	for (i = start; i < end; i++)
>> +		if (env->insn_aux_data[i].in_cleanup_pad)
>> +			__set_bit(i - start, bits);
>> +
>> +	sub->aux->exc->pad_body = bits;
>> +	sub->aux->exc->nr_pad_body = end - start;
>> +	return 0;
>> +}
> This isn't a bug, but would naming this field after the bitmap size
> rather than nr_pad_body make it clearer that it is the bit count and not
> the number of pad-body instructions, given the nr_throw_at /
> nr_resume_at siblings are true counts?

Will rename to pad_body_bits.

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35492765538

