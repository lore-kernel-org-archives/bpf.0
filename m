Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6BC2BD02
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783312066; cv=none; b=HNI0yA9/HHGcGe4imjYeXnO5TVCCLSK/yPjkDXG4iP7Fg+CKrKp2QQ7tC8Eck/KWLTd0HHQm6FHM8TeFwlIqwGfODrH5j+q5JIGhk5LVnvGUzqb/nk/F1qJzrywzv24ocSDliEqxJaxkgK9OxqXwKXJAurx/4Tu7uQCTdX4ajVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783312066; c=relaxed/simple;
	bh=zjPL46tmjTZFYj3ZF5T+MCN1F2vEDZmtML2eu6lgJjE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QTdLpcTOFs3ZasaVs697KJuVpTcpeq6z00nn5p/5P5Uhg3CrkHv4ZYdKgo0QND+xjFliyfAO4odpbA4cCx58ghVWc79yGxxHnekCMK3CXv2oKY6Od1VgE65urfeWIPiKt6zCyV38Rj2cK7Q9DgOiHkxpx84snFNvY6iaSNIzNFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxOOu7LktqEEcAAA--.1422S3;
	Mon, 06 Jul 2026 12:27:39 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx3ca5LktqBckBAA--.11145S3;
	Mon, 06 Jul 2026 12:27:38 +0800 (CST)
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
To: Leon Hwang <leon.hwang@linux.dev>, KaFai Wan <kafai.wan@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-2-yangtiezhu@loongson.cn>
 <ba5679e744e0209ca10788c2c385c6727eddb8a5.camel@linux.dev>
 <2d1babdf-a4d9-9902-77b0-3f5640871323@loongson.cn>
 <2240908fb833182e502d1804b392874cccf17b6c.camel@linux.dev>
 <aa26b3fc-9717-4273-dd76-a0dd6b15ff61@loongson.cn>
 <746b428a-a81f-4b8e-a767-109965959170@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <5c8bf98b-adb4-5696-4f22-34b88b27b777@loongson.cn>
Date: Mon, 6 Jul 2026 12:27:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <746b428a-a81f-4b8e-a767-109965959170@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3ca5LktqBckBAA--.11145S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF13uFW3AF4rXr1kGrWfZwc_yoW5XFyrpF
	95JFyjk3y0gw48ZasrtF1UAry5tr1jqw18GFs5JFyftrsFgF9agF18WrZI9ry3ur40yr1I
	vr4SgFy7Z347A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzt
	x6UUUUU

On 2026/7/6 上午11:59, Leon Hwang wrote:
> On 6/7/26 08:56, Tiezhu Yang wrote:
>> On 2026/7/4 上午9:57, KaFai Wan wrote:
>>> On Sat, 2026-07-04 at 00:14 +0800, Tiezhu Yang wrote:
>>>> On 7/3/26 21:55, KaFai Wan wrote:
>>>>> On Thu, 2026-07-02 at 22:36 +0800, Tiezhu Yang wrote:
>>
>> ...
>>
>>>>
>>>> IIUC, there are two places to modify so far:
>>>> (1) struct bpf_prog
>>>
>>> yes
>>>
>>>> (2) bpf_prog_has_kfunc_call()
>>>
>>> I think we can remove this func.
>>>
>>> actually, I feed your patch to dsv4-pro and gpt-5.4 yesterday, both
>>> point out the we should do this
>>> and change the log message.
>>>
>>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>>> index 12a8a4eb757f..7fb92b5fa415 100644
>>> --- a/kernel/bpf/fixups.c
>>> +++ b/kernel/bpf/fixups.c
>>> @@ -1378,7 +1378,6 @@ int bpf_fixup_call_args(struct bpf_verifier_env
>>> *env)
>>>    #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>>>        struct bpf_prog *prog = env->prog;
>>>        struct bpf_insn *insn = prog->insnsi;
>>> -    bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>>>        int depth;
>>>    #endif
>>>        int i, err = 0;
>>> @@ -1404,7 +1403,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env
>>> *env)
>>>                return err;
>>>        }
>>>    #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>>> -    if (has_kfunc_call) {
>>> +    if (prog->jit_required) {
> 
> 
> Agreed with this change.
> 
> Then, think it harder, pls.
> 
> Can we clean some code of __bpf_prog_select_runtime() btw?
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..bad55e119cb5 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -120,6 +120,9 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned
> int size, gfp_t gfp_extra_flag
>   		return NULL;
>   	}
> 
> +#ifdef CONFIG_BPF_JIT_ALWAYS_ON
> +	fp->jit_required = true;
> +#endif
>   	fp->pages = size / PAGE_SIZE;
>   	fp->aux = aux;
>   	fp->aux->main_prog_aux = aux;
> @@ -2614,15 +2617,11 @@ struct bpf_prog
> *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>   	/* In case of BPF to BPF calls, verifier did all the prep
>   	 * work with regards to JITing, etc.
>   	 */
> -	bool jit_needed = false;
> +	bool jit_needed = fp->jit_required;
> 
>   	if (fp->bpf_func)
>   		goto finalize;
> 
> -	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> -	    bpf_prog_has_kfunc_call(fp))
> -		jit_needed = true;
> -
>   	if (!bpf_prog_select_interpreter(fp))
>   		jit_needed = true;
> 
> WDYT?

Sorry, just saw your reply.
I have already sent out v8.

I think it is better to keep
the patch changes simple and focused.

The clean-up can be done as a follow-up
separate patch if necessary.

Thanks,
Tiezhu

