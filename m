Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E822222301
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388261; cv=none; b=Y4UGQsDoLQ8G95adgn7tF6RHVXByooNfIjrtTM3IRcqEzn+Z2+Aoh66TWtff1tMfCQCYaF5gLlVmXcG6O3L/AQ2QJjihrwIDTof1mSCxYStD6KIE6qdO4kAtip8O1zeeLGxnLTcYbaI6fllKNsw/VqxcfO6IOpkd6B8HnRLxVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388261; c=relaxed/simple;
	bh=iUITowo+9PWhdzus0MrkhZp1oBMeDP3Y/q6VGXSGD1o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kJArnHVb0/dXhEqaobSzE480+DBQRTWgqakqNYlcBrXZb3lQW5Q0irSHbMlpvQkPEwmOnfEPjnUcGJkPRuIpbrdATWVQZn9iO4GXEtwFOaMg8q6XUwINaMRmxVIVIDcLdEb9NOGiMFNZJ0ko6zhzFnRffvn3thIoo5y8d+VPbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxRepZWExqV74AAA--.1918S3;
	Tue, 07 Jul 2026 09:37:29 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxLsdLWExqeFIDAA--.19982S3;
	Tue, 07 Jul 2026 09:37:17 +0800 (CST)
Subject: Re: [PATCH bpf-next v8 2/2] bpf: Reject programs with inlined helpers
 if JIT is not available
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, KaFai Wan <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev,
 Leon Hwang <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
References: <20260706040006.10331-1-yangtiezhu@loongson.cn>
 <20260706040006.10331-3-yangtiezhu@loongson.cn>
 <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <33d3eb99-ef5a-5413-b2f6-3217b54cce4d@loongson.cn>
Date: Tue, 7 Jul 2026 09:37:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <abd697d839043d80e0230d2b9ab30b214dfa34d7.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLsdLWExqeFIDAA--.19982S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw1kJFykWF4UZw4UAF1xtFc_yoW5Cw45pF
	WrCw42kFyDXa429a97tw4IvF1avw4FqF17Wrn5G3s29a15Xr1SvrWSgw1Y9FykCr1v9a4I
	yw4Ivry09a4UXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2-VyUUUUU

On 2026/7/7 上午5:41, Eduard Zingerman wrote:
> On Mon, 2026-07-06 at 12:00 +0800, Tiezhu Yang wrote:
>> When an architecture (such as LoongArch, ARM64, and RISC-V) implements
>> bpf_jit_inlines_helper_call(), the verifier skips rewriting the helper
>> call offset (insn->imm) during the bpf_do_misc_fixups() phase, because
>> the helper is expected to be inlined by the JIT compiler. As a result,
>> insn->imm remains as the raw helper enum ID.
>>
>> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
>> if the JIT compilation later dynamically fails (e.g., due to OOM), the
>> core BPF subsystem falls back to the BPF interpreter.
>>
>> When the interpreter executes (__bpf_call_base + insn->imm) with the
>> unpatched raw helper ID, it jumps into an unaligned invalid address
>> space, triggering an instruction alignment fault or a memory access
>> panic.
>>
>> Fix this by setting 'jit_required' to 1 when helper call rewriting is
>> skipped for JIT inlining. Loading will be rejected early with -EINVAL
>> if JIT is disabled, or safely rejected with -ENOTSUPP during runtime
>> selection if JIT compilation dynamically fails, effectively preventing
>> the kernel panic.
>>
>> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
> 
> Sorry, I'm late to the party.
> As far as I understand, the patch #1 doesn't really change anything functionally,
> it just adds the flag, right?
> 
> As for the patch #2 and looking at the helpers that jits currently inline:
> - bpf_get_smp_processor_id (implemented as a function in the helpers.c)
> - bpf_get_current_task (implemented as a function in the bpf_trace.c)
> - bpf_get_current_task_btf (implemented as a function in the bpf_trace.c)
> 
> It is perfectly fine to call these as helper functions even if jit is
> not available. But this was broken since:
> 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> from May 2024, so I guess nobody really cares?
> 
> Imo, the simplest and least intrusive fix is to add a wrapper in the
> verifier.c that would call both bpf_jit_inlines_helper_call() and
> check if the jit is enabled and use that wrapper instead of direct
> calls to bpf_jit_inlines_helper_call().
> 
> Anyway, since this was broken all-along, might as well land as-is.
> Thoughts?

In the previous v4 [1], there is a similar way to fix unaligned
interpreter panic on JIT fallback path, but it was explicitly
rejected by the BPF maintainer Alexei [2]. Furthermore, Alexei
said "The interpreter has to be removed completely... sooner
or later." [3]. So if JIT is not available, rejecting the program
load is the intended design.

[1] 
https://lore.kernel.org/bpf/20260615025316.24429-1-yangtiezhu@loongson.cn/
[2] https://lore.kernel.org/bpf/DJMRIZ5PDWP4.12OOZ8H881H6O@gmail.com/
[3] https://lore.kernel.org/bpf/DJN001X0S57Y.18CKUS4NDDQT1@gmail.com/

Thanks,
Tiezhu

