Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21EF35675C
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056299; cv=none; b=ROMzjZOufBVEMILHqUIV2EdZN3h69t+bZ5IEH4ZXbLHk/pru/MIKaAw6dEiqVhz0bcHot6gKRDbBd9o4mhPQgczCFdVpck8747IM/gL7vC2DfyxQHjoy6tsRGyBhQjm+3scsirEHAuMW8lg2t2lhbMP47ioe6u2sEtggDGC25M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056299; c=relaxed/simple;
	bh=eos+/Db6RlUVInMkPYHCOKmIYvFu8I8PUh9Ltd3hvjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1qf0NElIrqyTmwZUEnXF7GX9YtXeZ85rF7wI6iv3CxlcahlM5YGWD9MWbZSo8n6210Gfg+0y+SCJxMIq5GMbjPymmDWIc96Yiv2t/vsH7cnK2wuvT0qqX32JlrvbVLdY12o2wVSKgQEYHsWwFjIHrO121boTrEV95XdgiAzGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aa4l6WYc; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aa4l6WYc"
Message-ID: <42e59c6f-5040-4b50-91ce-10066551a32c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783056288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/pStqMXFFQsfS/gIUKUC14aOv8lYhkbZ0a1Tt5TFIw=;
	b=aa4l6WYcYaD0Ey5Al/au5yU1YoFjDyBswhiwHBOadTZSK5uo4ob5mlKhEEJT9D+bIKdmxE
	yDuijV9QUD8FZYQQZ3Lu00DYmaZ/zZEmq270UmZUKpgYFnJ3MkBvXT3Gv8sobLDhoqwxX3
	kZEHgaYZr3dD0XN2ElCmwdzcsph76ao=
Date: Fri, 3 Jul 2026 13:24:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 KaFai Wan <kafai.wan@linux.dev>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-2-yangtiezhu@loongson.cn>
 <20260702145855.07C6B1F000E9@smtp.kernel.org>
 <7cce1695-eaa2-816b-2877-9cb2f117aa27@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <7cce1695-eaa2-816b-2877-9cb2f117aa27@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/7/26 10:57, Tiezhu Yang wrote:
> On 2026/7/2 下午10:58, sashiko-bot@kernel.org wrote:
[...]
>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>> index 649cce41e13f3..5fcd19ccb41a9 100644
>>> --- a/kernel/bpf/core.c
>>> +++ b/kernel/bpf/core.c
>>> @@ -2619,8 +2619,7 @@ struct bpf_prog
>>> *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>>       if (fp->bpf_func)
>>>           goto finalize;
>>>   -    if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>>> -        bpf_prog_has_kfunc_call(fp))
>>> +    if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
>>>           jit_needed = true;
>>>         if (!bpf_prog_select_interpreter(fp))
>>
>> [Severity: Medium]
>> Since bpf_prog_has_kfunc_call() was replaced here with fp->jit_required,
>> should bpf_fixup_call_args() in kernel/bpf/fixups.c also be updated to
>> use
>> the new flag?
>>
>> Currently, bpf_fixup_call_args() still calls
>> bpf_prog_has_kfunc_call(). If
>> a program has a pruned kfunc (allocating kfunc_tab but leaving
>> jit_required=0) and JIT falls back to the interpreter, wouldn't
>> bpf_fixup_call_args() incorrectly reject the program with -EINVAL?


I think this rejection is intentional. '!!prog->aux->kfunc_tab' means
there is kfunc call in the prog, even though the kfunc call could be pruned.

>>
>> kernel/bpf/fixups.c:bpf_fixup_call_args() {
>>      ...
>>     bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>>      ...
>>     if (has_kfunc_call) {
>>         verbose(env, "calling kernel functions are not allowed in non-
>> JITed programs\n");
>>         return -EINVAL;
>>     }
>>      ...
>> }

[...]

> ```
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f496b45b9da4..1f5824c1c691 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2772,7 +2772,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
> *env, u32 func_id, u16 offset)
> 
>  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>  {
> -       return !!prog->aux->kfunc_tab;
> +       return prog->jit_required && !!prog->aux->kfunc_tab;


When 'prog->jit_required' is used for JIT-inlineable helper call, this
change could also cause false positive for the above pruned kfunc case.

If you don't want bpf_fixup_call_args() rejects the program with -EINVAL
for the pruned kfunc case, suggest moving 'if (!func_id && !offset)'
before the tab allocation in bpf_add_kfunc_call().

Thanks,
Leon

>  }
> [...]
