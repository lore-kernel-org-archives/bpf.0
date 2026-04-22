Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421834678C
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899381; cv=none; b=FYrKei+SUCnbnQMQcIzBbpVh9FmeTQpHqAqL1Jj7K8R96anU6k2ItNhab64D6hLmR5/V/9KSR41yek2m2rHcD3UrZK+qDCgNgbvyafpHvIBDhTmkI9ux9eU9YKd1epMp/wp8Em62jqN2lU6XRBUaueLnLuAaZpkbhi0l2drQxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899381; c=relaxed/simple;
	bh=5AkVbbngonKpiOiGE2KQTBrG2rPIX2zSOk8j02uR1M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGIAh+dZCyBt38YWMxfxgVVptZuC23dfLR5mdzPUSb7pZS58xzgtoJ5xj714RWhJ2MMqVD4lNyjXSsuxTvKI36c2vZV66rMcuYfUOLVHZqyRvDx9DaLH3JFWeY23Qsbo+v+3hgw9sMHE53mBMvqAsZQekERPekJZvBrkFEHAw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=te5Xk7VR; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="te5Xk7VR"
Message-ID: <2ad13b46-a291-4dd1-bf6d-3c9ca9319eea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776899376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdU7g6GqRMNCeeZfPi5WUbdTl4qeZatEzwfzA7VLNAM=;
	b=te5Xk7VRZ6ojrsLWuZde5XCcCfJjJoUyebf4rhtszwXRHBWzwn1squy5mxKRi0HvI1b0YA
	8e6uK+SH9VH3zvvb5MhvZeHGTf/twthzaNSFEK71yvh8KKhFHjjV9R2oakLqTV688PQccs
	W4pOhllRB/gQ2mxBiiRO3f5jXKFek/0=
Date: Wed, 22 Apr 2026 16:09:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 7/9] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260422054224.3127905-1-yonghong.song@linux.dev>
 <25c10a6b1a6f9703f2b2c943ab42245cb9de30d2004eb301d85d9de0ca6ca7b3@mail.kernel.org>
 <715fcb76-c1ba-44e2-9b6f-e3133f2a5610@linux.dev>
 <cb70fcff-2e3e-4132-ada7-7af4e8a4ab35@linux.dev>
 <DI00R3E7C8FD.1U98NQCWU1BW4@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DI00R3E7C8FD.1U98NQCWU1BW4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/22/26 2:58 PM, Alexei Starovoitov wrote:
> On Wed Apr 22, 2026 at 8:37 AM PDT, Yonghong Song wrote:
>>
>> On 4/22/26 7:57 AM, Yonghong Song wrote:
>>>
>>> On 4/21/26 11:25 PM, bot+bpf-ci@kernel.org wrote:
>>>>> diff --git a/include/linux/bpf_verifier.h
>>>>> b/include/linux/bpf_verifier.h
>>>>> index b148f816f25b..d5b4303315dd 100644
>>>>> --- a/include/linux/bpf_verifier.h
>>>>> +++ b/include/linux/bpf_verifier.h
>>>>> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>>>>>         * e.g., in reg_type_str() to generate reg_type string
>>>>>         */
>>>>>        char tmp_str_buf[TMP_STR_BUF_LEN];
>>>>> +    char tmp_arg_name[32];
>>>>>        struct bpf_insn insn_buf[INSN_BUF_SIZE];
>>>>>        struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>>>>>        struct bpf_scc_callchain callchain_buf;
>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>> index c777a294302a..e7f5f0bb499b 100644
>>>>> --- a/kernel/bpf/verifier.c
>>>>> +++ b/kernel/bpf/verifier.c
>>>>> @@ -261,6 +261,30 @@ struct bpf_kfunc_meta {
>>>>>
>>>>>    struct btf *btf_vmlinux;
>>>>>
>>>>> +typedef struct argno {
>>>>> +    int argno;
>>>>> +} argno_t;
>>>>> +
>>>>> +static argno_t argno_from_reg(u32 regno)
>>>>> +{
>>>>> +    return (argno_t){ .argno = regno };
>>>>> +}
>>>>> +
>>>>> +static argno_t argno_from_arg(u32 arg)
>>>>> +{
>>>>> +    return (argno_t){ .argno = -arg };
>>>>> +}
>>>>> +
>>>>> +static int reg_from_argno(argno_t a)
>>>>> +{
>>>>> +    return a.argno >= 0 ? a.argno : -1;
>>>>> +}
>>>>> +
>>>>> +static int arg_from_argno(argno_t a)
>>>>> +{
>>>>> +    return a.argno < 0 ? -a.argno : -1;
>>>>> +}
>>>> [ ... ]
>>>>
>>>>> @@ -7026,8 +7068,8 @@ static int check_helper_mem_access(struct
>>>>> bpf_verifier_env *env, struct bpf_reg_
>>>>>     */
>>>>>    static int check_mem_size_reg(struct bpf_verifier_env *env,
>>>>>                      struct bpf_reg_state *mem_reg,
>>>>> -                  struct bpf_reg_state *size_reg, u32 mem_regno,
>>>>> -                  u32 size_regno, enum bpf_access_type access_type,
>>>>> +                  struct bpf_reg_state *size_reg, argno_t mem_argno,
>>>>> +                  argno_t size_argno, enum bpf_access_type
>>>>> access_type,
>>>>>                      bool zero_size_allowed,
>>>>>                      struct bpf_call_arg_meta *meta)
>>>>>    {
>>>> [ ... ]
>>>>
>>>>> @@ -7052,31 +7094,31 @@ static int check_mem_size_reg(struct
>>>>> bpf_verifier_env *env,
>>>>>            meta = NULL;
>>>>>
>>>>>        if (size_reg->smin_value < 0) {
>>>>> -        verbose(env, "R%d min value is negative, either use
>>>>> unsigned or 'var &= const'\n",
>>>>> -            size_regno);
>>>>> +        verbose(env, "%s min value is negative, either use unsigned
>>>>> or 'var &= const'\n",
>>>>> +            reg_arg_name(env, size_argno));
>>>>>            return -EACCES;
>>>>>        }
>>>>>
>>>>>        if (size_reg->umin_value == 0 && !zero_size_allowed) {
>>>>> -        verbose(env, "R%d invalid zero-sized read: u64=[%lld,%lld]\n",
>>>>> -            size_regno, size_reg->umin_value, size_reg->umax_value);
>>>>> +        verbose(env, "%s invalid zero-sized read: u64=[%lld,%lld]\n",
>>>>> +            reg_arg_name(env, size_argno), size_reg->umin_value,
>>>>> size_reg->umax_value);
>>>>>            return -EACCES;
>>>>>        }
>>>>>
>>>>>        if (size_reg->umax_value >= BPF_MAX_VAR_SIZ) {
>>>>> -        verbose(env, "R%d unbounded memory access, use 'var &=
>>>>> const' or 'if (var < const)'\n",
>>>>> -            size_regno);
>>>>> +        verbose(env, "%s unbounded memory access, use 'var &=
>>>>> const' or 'if (var < const)'\n",
>>>>> +            reg_arg_name(env, size_argno));
>>>>>            return -EACCES;
>>>>>        }
>>>>> -    err = check_helper_mem_access(env, mem_reg, mem_regno,
>>>>> size_reg->umax_value,
>>>>> +    err = check_helper_mem_access(env, mem_reg, mem_argno,
>>>>> size_reg->umax_value,
>>>>>                          access_type, zero_size_allowed, meta);
>>>>>        if (!err)
>>>>> -        err = mark_chain_precision(env, size_regno);
>>>>> +        err = mark_chain_precision(env, reg_from_argno(size_argno));
>>>>>        return err;
>>>>>    }
>>>>                                        ^^^^^^^
>>>>
>>>> Does mark_chain_precision(env, reg_from_argno(size_argno)) properly
>>>> handle
>>>> kfunc size arguments?
>>>>
>>>> Before this patch, check_mem_size_reg() was called with size_regno
>>>> being a
>>>> u32 register number. For kfuncs with KF_ARG_PTR_TO_MEM_SIZE, the
>>>> pre-patch
>>>> call at check_kfunc_args was check_kfunc_mem_size_reg(env, reg,
>>>> size_reg,
>>>> regno, regno+1), passing real register numbers like R2..R5.
>>>>
>>>> After this patch, check_kfunc_args constructs size_argno via
>>>> argno_from_arg(i+2) for the size parameter of a KF_ARG_PTR_TO_MEM_SIZE
>>>> pair. The argno_from_arg() helper creates a negative encoding (-.argno).
>>>> When reg_from_argno(size_argno) is called, it checks a.argno >= 0 and
>>>> returns -1 for negative values.
>>>>
>>>> mark_chain_precision(env, -1) then reaches bpf_mark_chain_precision in
>>>> backtrack.c, where the "if (regno >= 0)" guard causes it to skip marking
>>>> the register, and the subsequent "if (bt_empty(bt)) return 0;" silently
>>>> returns success without doing any precision tracking.
>>>>
>>>> For helpers, this works correctly because check_func_arg calls
>>>> check_mem_size_reg with argno_from_reg(regno), which produces a
>>>> non-negative
>>>> encoding that reg_from_argno() correctly extracts back to the register
>>>> number.
>>>>
>>>> Can you verify whether the loss of precision tracking for kfunc size
>>>> registers might cause programs that previously verified to hit the
>>>> BPF_COMPLEXITY_LIMIT_INSNS threshold? Kfuncs with __sz/__szk size
>>>> arguments are widely used in-tree.
>>> This is indeed a problem.
>>> Function check_mem_size_reg() is the one which does
>>>     mark_chain_precision(env, reg_from_argno(size_argno))
>>>
>>>
>>> There are two callers for check_mem_size_reg():
>>>     - check_kfunc_mem_size_reg() <- check_kfunc_args
>>>       so arg_from_argno() should be used here to get the value
>>>     - check_func_arg() <- check_helper_call()
>>>       in this case, since helper_call is fixed at most 5 registers,
>>>       so argno_from_reg() is used in check_func_arg(), so later
>>>       on it should use reg_from_argno() should be used to get value.
>>>
>>> There are two options to fix:
>>>   1. do proper check like
>>>      int reg_val = reg_from_argno(size_regno);
>>>      if (reg_val >= 0)
>>>        mark_chain_precision(env, reg_val);
>>>      else
>>>        mark_chain_precision(env, arg_from_argno(size_regno));
>>>
>>> 2. for arguments in check_helper_call(), we also use
>>>     arg_from_argno() instead of reg_from_argno().
>>>     This way, we can just do
>>>        mark_chain_precision(env, arg_from_argno(size_regno));
>>>
>>> Not sure which is preferred or there are some other better alternatives.
>> The following should work.
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e7f5f0bb499b..2ead411b949d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -7112,8 +7112,12 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>>           }
>>           err = check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax_value,
>>                                         access_type, zero_size_allowed, meta);
>> -       if (!err)
>> -               err = mark_chain_precision(env, reg_from_argno(size_argno));
>> +       if (!err) {
>> +               int regno = reg_from_argno(size_argno);
>> +
>> +               regno = regno >= 0 ? regno : arg_from_argno(size_argno);
>> +               err = mark_chain_precision(env, regno);
>> +       }
> Both options are not great and
> regno = arg >= 0 ? arg : reg_from_argno(argno);
> in reg_arg_name() points to the same issue.
>
> I think it should be:
> static int reg_from_argno(argno_t a)
> {
>     if (a.argno >= 0)
>        return a.argno;
>     if (a.argno >= -MAX_BPF_FUNC_REG_ARGS)
>        return -a.argno;
>     return -1;
> }
>
> whether arg_from_argno() should do similar logic is something to think about.

I think the following arg_from_argno() should be okay:

static int arg_from_argno(argno_t a)
{
         if (a.argno < 0)
                 return -a.argno;
         return -1;
}

In some cases, there is a need to get an arg_idx which will be
used for an array element. e.g.,

process_iter_arg(..., argno, ...)
    ...
    u32 arg_idx = arg_from_argno(argno) - 1;
    ...
    btf_id = btf_check_iter_arg(meta->btf, meta->func_proto, arg_idx);

btf_check_iter_arg(..., arg_idx)
    ...
    arg = &btf_params(func)[arg_idx];
    ...

