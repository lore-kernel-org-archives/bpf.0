Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB2F384235
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061969; cv=none; b=uLxAXIuDWVLgED4780G/5bqhwtKYo6t0FGMXdz6jIy0YRbY7iTvNSVIQCUFbMa6UTVoTV9jcY43reMKbRE4Rvu4/STQEYm9ahdJfZQpeREynyjoQ+mEuIMZJ0/pg0k/Xqr41dZqFOr895wgcHMV5pIsh2a8E1qyZ1VWtxClMT68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061969; c=relaxed/simple;
	bh=SVl+E6gsa4saeiLEnri52k+A5LP0N8pcQuOf7csyrH4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h1xYKxdNgXrESA+hCCY4RPMntS4VtXgy9fTDLUes6sRDzxVuTkHSLzrgC0MYBNPwBo1YUq+LEe7BRCCHTPyhuDTBslaKFAl0fzIJD4IRzGLBpjH1ngfENXe8jjKfk2xJb0NUYzt57oKrsVpa6p98WG3K2/hizIlWr0fwy023s9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxRvDFXUdqez0BAA--.6820S3;
	Fri, 03 Jul 2026 14:59:17 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxacHAXUdqNJ69AA--.18269S3;
	Fri, 03 Jul 2026 14:59:13 +0800 (CST)
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
To: Leon Hwang <leon.hwang@linux.dev>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 KaFai Wan <kafai.wan@linux.dev>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-2-yangtiezhu@loongson.cn>
 <20260702145855.07C6B1F000E9@smtp.kernel.org>
 <7cce1695-eaa2-816b-2877-9cb2f117aa27@loongson.cn>
 <42e59c6f-5040-4b50-91ce-10066551a32c@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c6aca1e2-1f7a-7e01-62c8-81d0658a20fe@loongson.cn>
Date: Fri, 3 Jul 2026 14:59:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <42e59c6f-5040-4b50-91ce-10066551a32c@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxacHAXUdqNJ69AA--.18269S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw1DArWUKw1kZFW5uFW8Zrc_yoW5KryUpF
	95tFyjkFyvqw1Ivw12yF1jyry5tw18J3W7Kr1kJFyfZr42qFs2ga1UWrya93yaqr48tr10
	v3yS9FW2vw1UZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vA
	pUUUUUU==

On 2026/7/3 下午1:24, Leon Hwang wrote:
> On 3/7/26 10:57, Tiezhu Yang wrote:
>> On 2026/7/2 下午10:58, sashiko-bot@kernel.org wrote:
> [...]
>>>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>>>> index 649cce41e13f3..5fcd19ccb41a9 100644
>>>> --- a/kernel/bpf/core.c
>>>> +++ b/kernel/bpf/core.c
>>>> @@ -2619,8 +2619,7 @@ struct bpf_prog
>>>> *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>>>        if (fp->bpf_func)
>>>>            goto finalize;
>>>>    -    if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>>>> -        bpf_prog_has_kfunc_call(fp))
>>>> +    if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
>>>>            jit_needed = true;
>>>>          if (!bpf_prog_select_interpreter(fp))
>>>
>>> [Severity: Medium]
>>> Since bpf_prog_has_kfunc_call() was replaced here with fp->jit_required,
>>> should bpf_fixup_call_args() in kernel/bpf/fixups.c also be updated to
>>> use
>>> the new flag?
>>>
>>> Currently, bpf_fixup_call_args() still calls
>>> bpf_prog_has_kfunc_call(). If
>>> a program has a pruned kfunc (allocating kfunc_tab but leaving
>>> jit_required=0) and JIT falls back to the interpreter, wouldn't
>>> bpf_fixup_call_args() incorrectly reject the program with -EINVAL?
> 
> 
> I think this rejection is intentional. '!!prog->aux->kfunc_tab' means
> there is kfunc call in the prog, even though the kfunc call could be pruned.
> 
>>>
>>> kernel/bpf/fixups.c:bpf_fixup_call_args() {
>>>       ...
>>>      bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>>>       ...
>>>      if (has_kfunc_call) {
>>>          verbose(env, "calling kernel functions are not allowed in non-
>>> JITed programs\n");
>>>          return -EINVAL;
>>>      }
>>>       ...
>>> }
> 
> [...]
> 
>> ```
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f496b45b9da4..1f5824c1c691 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2772,7 +2772,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env
>> *env, u32 func_id, u16 offset)
>>
>>   bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
>>   {
>> -       return !!prog->aux->kfunc_tab;
>> +       return prog->jit_required && !!prog->aux->kfunc_tab;
> 
> 
> When 'prog->jit_required' is used for JIT-inlineable helper call, this
> change could also cause false positive for the above pruned kfunc case.
> 
> If you don't want bpf_fixup_call_args() rejects the program with -EINVAL
> for the pruned kfunc case, suggest moving 'if (!func_id && !offset)'
> before the tab allocation in bpf_add_kfunc_call().

How about this:

```
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..c34cc524651a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2770,7 +2770,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env 
*env, u32 func_id, u16 offset)

  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
  {
-       return !!prog->aux->kfunc_tab;
+       return prog->aux->kfunc_tab && prog->aux->kfunc_tab->nr_descs > 0;
  }

  static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
```
IMO, there are no side effects for the following four cases:

1. Pure JIT-inlined Helper
2. Pure Pruned kfunc
3. Pruned kfunc + Inlined Helper
4. Active (Unpruned) kfunc

Thanks,
Tiezhu

