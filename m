Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6071E33120E
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841731; cv=none; b=haE4+FsgcqajXsS3V5iH/plMhXrK4a2UjD6Y8aKtt8N5MS/6g3rjNdHYOqQSs5bBbPygOJMY9uxO/DhZ/YvWYTITXOovc+0tEYJJxOPUrVPwksshCOXPTmi4RcPmgwdJ3wYYE/sIaACFm/QJt3/ImpiIJwmGzk/gcZx916YgDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841731; c=relaxed/simple;
	bh=9ezy3cW49oLbe+hC0YzUnZI4SjL5IUuAUAgabggXP8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3vs4Gldc8FmNUhV1JZAcisJZhyP4j4IWHxAm01ddrYqcKuvT8xo8wyz6TQiq8IYffjdDfkJbjon9nmaSjBBUDRhUuXWrSfVAdZ3BHOl8ehecLT6EUlNyV3fMNMIedjjNW3YK+tzAQ8ix+2G7t2KD1Fbn80BFS+68BBkV1QaFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gN8TSHav; arc=none smtp.client-ip=95.215.58.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gN8TSHav"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9ezy3cW49oLbe+hC0YzUnZI4SjL5IUuAUAgabggXP8s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788841727; v=1; x=1789446527;
 b=gN8TSHavBcMyk30CQqRxebvm02BxIcO1Pn8FGD4Ei5VhRNL7TlhF1qo2pxIaYL00rEKnqhfl
 xBGM3iWQgRAU1JyS1GHC22gEoPzIHy+VDvOcbp+IlpCa1Ow6CrmQEPv3bYspcJnvd9Fzyx6ZhHo
 xqinOQQRG+ci1KMQtpMO2B+k=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e09d003ee0a11567;
	Tue, 08 Sep 2026 04:28:47 +0000
X-Mizu-Trace-ID: e09d003ee0a11567
X-Migadu-Flow: FLOW_OUT
Message-ID: <aa959f6f-dd5b-4a7e-b34d-a3d71ecd23a7@linux.dev>
Date: Mon, 7 Sep 2026 21:28:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 08/12] bpf: Record a 16-byte argument alignment
 in the function model
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260904051038.3980676-1-yonghong.song@linux.dev>
 <8d16df40357e1ac7177a9e63e754fb506f348198ee3dfbad37d7c969b0f13431@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <8d16df40357e1ac7177a9e63e754fb506f348198ee3dfbad37d7c969b0f13431@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/3/26 11:09 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 3a7eb2185c35..5b93aa97f1bc 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -1193,6 +1193,9 @@ struct bpf_prog_offload {
>>   	u32			jited_len;
>>   };
>>
>> +/* Argument aligned to 16 bytes. */
>> +#define BTF_FMODEL_ALIGN16_ARG		BIT(0)
>> +
>>   /* The argument is signed. */
>>   #define BTF_FMODEL_SIGNED_ARG		BIT(1)
> [ ... ]
>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 6c391449e298..f933a675b0a8 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7633,6 +7633,15 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
>>   		}
>>   		m->arg_size[i] = ret;
>>   		m->arg_flags[i] = __get_arg_fmodel_flags(btf, &args[i], t);
>> +
>> +		align16 = btf_type_align16(btf, t, 0);
>> +		if (align16 < 0) {
>> +			bpf_log(log, "The function %s arg%d type %s has unknown alignment.\n",
>> +				tname, i, btf_type_str(t));
>> +			return -EINVAL;
>> +		} else if (align16) {
>> +			m->arg_flags[i] |= BTF_FMODEL_ALIGN16_ARG;
>> +		}
>>   	}
>>   	m->nr_args = nargs;
>>   	return 0;
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 030fb37c22ef..461883158ffa 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -11748,6 +11748,31 @@ bool btf_struct_is_composed_of(struct bpf_verifier_env *env,
>>   	return btf_struct_member_walk(env, btf, t, member_kinds, 0, NULL);
>>   }
>>
>> +int btf_type_align16(const struct btf *btf, const struct btf_type *t, int rec)
>> +{
>> +	const struct btf_member *member;
>> +	int ret;
>> +	u32 i;
>> +
>> +	while (btf_type_is_array(t))
>> +		t = btf_type_skip_modifiers(btf, btf_array(t)->type, NULL);
>> +
>> +	if (btf_type_is_int(t))
>> +		return t->size > 8;
>> +	if (!btf_type_is_struct(t))
>> +		return 0;
>> +	if (rec >= BTF_MEMBER_MAX_DEPTH)
>> +		return -E2BIG;
>> +
>> +	for_each_member(i, t, member) {
>> +		ret = btf_type_align16(btf, btf_type_skip_modifiers(btf, member->type, NULL),
>> +				       rec + 1);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +	return 0;
>> +}
> This isn't a bug, but btf_type_align16() looks structurally similar to
> kfunc_arg_align() further down in the same file. Both walk types with the
> same pattern: strip arrays with `while (btf_type_is_array(t))`, test for
> `btf_type_is_int(t)` with `t->size > 8`, bail on `!btf_type_is_struct(t)`,
> check `rec >= BTF_MEMBER_MAX_DEPTH`, and recurse through members via
> `btf_type_skip_modifiers(btf, member->type, NULL)`. Could the two share one
> walk, and would hiding the `rec` argument behind a wrapper keep the exported
> signature simpler, the way btf_struct_is_composed_of() wraps
> btf_struct_member_walk()?

This is for arm64 jit. I will simplify it and this patch is not necessary any more.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33840714551

