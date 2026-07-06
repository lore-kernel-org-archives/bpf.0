Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B491381AF
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783299416; cv=none; b=E+zyRiOQ2tqVjzzwIgB4SciXGznuVftuxHraS6Y7H4CGOQGT2CRPswEXSNjTvmciRkdALUNGh9UL6e89UEf1DVkOLQfwnxW5VVXEqcz/5bBlaQV2ck3eUIE9xZWexr73RiJrVSioONsmKQgaBvL040rKRb5snQc9ysIi8gJeCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783299416; c=relaxed/simple;
	bh=FulFPZYiAaI5jV6suIOR9VjlPvn1tII/OQ/NkyH0Zw0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m3rI9675aIeKuRyU4V87uKYkaXxlLOVPuNAFrcptExeMGHyA764csACqn80rr6kkRuV6ohJXZIpf9AZGJCHaLlRGGeX1yUrtFJmcaPkHTEB+cWAUICLf7S6MiWZadxz2BzF3t2sniwdXxcTmG3Jyl6Wh2nS8+CmmlLnDjz8ZaMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxqutL_UpqrzMAAA--.1014S3;
	Mon, 06 Jul 2026 08:56:43 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxIuRI_Upq9YoBAA--.9420S3;
	Mon, 06 Jul 2026 08:56:41 +0800 (CST)
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
To: KaFai Wan <kafai.wan@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Leon Hwang <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-2-yangtiezhu@loongson.cn>
 <ba5679e744e0209ca10788c2c385c6727eddb8a5.camel@linux.dev>
 <2d1babdf-a4d9-9902-77b0-3f5640871323@loongson.cn>
 <2240908fb833182e502d1804b392874cccf17b6c.camel@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <aa26b3fc-9717-4273-dd76-a0dd6b15ff61@loongson.cn>
Date: Mon, 6 Jul 2026 08:56:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2240908fb833182e502d1804b392874cccf17b6c.camel@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuRI_Upq9YoBAA--.9420S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF13uFWrAF13Cw45Aw17twc_yoW5Gw1fpF
	95J34jkFWqqr4SvFsrJ3Wxur13Ww18Ww4UKF4kGr9akF1UXasxtF1fG342qFW3Wr9rtayF
	vr4Iva48Ww18uacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Jr0_Gr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==

On 2026/7/4 上午9:57, KaFai Wan wrote:
> On Sat, 2026-07-04 at 00:14 +0800, Tiezhu Yang wrote:
>> On 7/3/26 21:55, KaFai Wan wrote:
>>> On Thu, 2026-07-02 at 22:36 +0800, Tiezhu Yang wrote:

...

>>
>> IIUC, there are two places to modify so far:
>> (1) struct bpf_prog
> 
> yes
> 
>> (2) bpf_prog_has_kfunc_call()
> 
> I think we can remove this func.
> 
> actually, I feed your patch to dsv4-pro and gpt-5.4 yesterday, both point out the we should do this
> and change the log message.
> 
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 12a8a4eb757f..7fb92b5fa415 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1378,7 +1378,6 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>   	struct bpf_prog *prog = env->prog;
>   	struct bpf_insn *insn = prog->insnsi;
> -	bool has_kfunc_call = bpf_prog_has_kfunc_call(prog);
>   	int depth;
>   #endif
>   	int i, err = 0;
> @@ -1404,7 +1403,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>   			return err;
>   	}
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> -	if (has_kfunc_call) {
> +	if (prog->jit_required) {
>   		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
>   		return -EINVAL;
>   	}
> 
> I think we can change the log message for general purpose no just for kunc, so we can know why prog
> failed in patch#2 as you test yesterday.

Hi KaFai,

Thanks a lot for the explanations and suggestions,
I really appreciate it.

I will do the following changes in the next version v8:

1. Completely remove bpf_prog_has_kfunc_call().
2. Set jit_required at the entry of bpf_add_kfunc_call().
3. Generalize the error message to:
    "program requires BPF JIT compiler but it is not available"

I have tested the updated v8 patch on LoongArch.
Here are the test results:

1. net.core.bpf_jit_enable = 1 and JIT compilation succeeded:
=> test PASS

2. net.core.bpf_jit_enable = 0 and JIT compilation succeeded:
=> returns -EINVAL (-22) and prints:
"program requires BPF JIT compiler but it is not available"

3. net.core.bpf_jit_enable = 1 and JIT compilation failed:
=> returns -ENOTSUPP (-524)

4. net.core.bpf_jit_enable = 0 and JIT compilation failed:
=> returns -EINVAL (-22) and prints:
"program requires BPF JIT compiler but it is not available"

As long as net.core.bpf_jit_enable = 0, it always returns early
in bpf_fixup_call_args() with -EINVAL and prints the error log.

Only when net.core.bpf_jit_enable = 1 and the runtime JIT compilation
dynamically fails, it safely falls back to the -ENOTSUPP runtime check.

I think it works exactly as expected.

Thanks,
Tiezhu

