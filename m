Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940973264CB
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052068; cv=none; b=kQjj7ygzMrLwJOTY5F4metnTrBV6YvMzGndmnWaks3IilWUkosZhSAx6mkXeSxtFswqA0yYtNBWs6khm4rSedBlMcl2+QqEGsfl99JL6MPXLj+576UDL0M9e3k6/HAIFUQouJE5/10rAhQTCmDvAwiDojzLezb8TjA1Z1g/Gtu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052068; c=relaxed/simple;
	bh=hNF+BYFw5WurQLv1dEpQiKqkpQlRM3UA8yxeoelt8e0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mwuu5YKMiaPgHX5CIaaJ03QvUi7Rygm6Ds0kbJ1nlMwxDhYUhJp7atzUhs9wH6D0OQO+2gwv5PQVeVP9rS625iZsjuHySjtF8m271SVWrzAxcwfCHfnXs2zklv7RWLbSrAW0c5YVMgo9mQclGw6Pi7cRS4okNJOsAQ+6/tPjE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxOPIVN0dqFDMBAA--.6675S3;
	Fri, 03 Jul 2026 12:14:13 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxWeAQN0dqVHO9AA--.31828S3;
	Fri, 03 Jul 2026 12:14:09 +0800 (CST)
Subject: Re: [PATCH bpf-next v7 2/2] bpf: Reject programs with inlined helpers
 if JIT is unavailable
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 KaFai Wan <kafai.wan@linux.dev>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
 <20260702143656.28845-3-yangtiezhu@loongson.cn>
 <20260702145726.0B96B1F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1f9a6291-d221-36da-1989-5f8db7d6fb20@loongson.cn>
Date: Fri, 3 Jul 2026 12:14:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260702145726.0B96B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxWeAQN0dqVHO9AA--.31828S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFW5GF18Jr15Ww1xJF1DJwc_yoW8ZFyUpF
	4fKayYk3yDXwn7Ka47t3y7Z3Wjqw48Gr47GFnYgr1Ik3Wakr97XFyfKr47uFn5Gr4v9F1I
	vr4Igryvk3WDGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
	UUUUU

On 2026/7/2 下午10:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch prevents loading BPF programs that use JIT-inlined helpers (e.g., `bpf_get_smp_processor_id`) when the BPF JIT is explicitly disabled at load time (`net.core.bpf_jit_enable=0`).
> --
> 
> commit 01713d8606e656f4dadefe493f371f4c861d842b
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> bpf: Reject programs with inlined helpers if JIT is unavailable
> 
> This patch sets the jit_required flag to 1 when a BPF program uses helpers
> that are expected to be inlined by the JIT compiler. This prevents a kernel
> panic in the BPF interpreter by rejecting the program with -ENOTSUPP if
> JIT compilation is unavailable at runtime.
> 
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index 12a8a4eb757f1..94e0457a0aa33 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1841,8 +1841,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>>   		}
>>   
>>   		/* Skip inlining the helper call if the JIT does it. */
>> -		if (bpf_jit_inlines_helper_call(insn->imm))
>> +		if (bpf_jit_inlines_helper_call(insn->imm)) {
>> +			prog->jit_required = 1;
>>   			goto next_insn;
>> +		}
> 
> [Severity: High]
> While this correctly prevents the interpreter panic, does this unconditionally
> reject valid BPF programs when the JIT is explicitly disabled at load time
> (e.g., net.core.bpf_jit_enable=0)?

Yes.

> If this block checked prog->jit_requested before skipping the fixup and
> setting jit_required, wouldn't the verifier properly patch the instruction
> when JIT is disabled, allowing the program to execute successfully in the
> interpreter?

No, this was already explored in earlier version (v4), but it was
explicitly rejected by the BPF maintainer.

If JIT is unavailable, rejecting the program load with -ENOTSUPP is
the intended design.

Thanks,
Tiezhu

