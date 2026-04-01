Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBC3F0A95
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064097; cv=none; b=OvU/IoUTb9vlFdyAJhKsffSO2/BvO4OPbbDw61bxTYs9RQcqrocE+X5nF7pwuDbzLHNHH2ilQDfOqI1sD8ZqElpdkzdixSfjcZ10Pz8Z8COxNjG2vmH0BgRFgMHMd4vQOpWr96eFfRtJznHCqP+84MSWn4Ps8UPUV9IDuiNYHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064097; c=relaxed/simple;
	bh=TdmYurIQ022Q2wOvF7OtevRG38Lbg29hY2RbIu9sJ3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ep5V7qSdO1pj3KqL+/fSyJMJunj6uaDJwd5yOM0KBql+GsP0FOZtbqgsahyV8Cm1fJuZSgsqtuTLKAV/sqBXbWDas/GBFHWSPOh2JJlTM1CN6zZl6PfvVel7FJ3PESy/a7AQl8do9KDKRJyvOOXhLV+LEw6cghlf5EwIW0qW/AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.10.227.6])
	by mtasvr (Coremail) with SMTP id _____wB3wJz1U81pbS01AA--.13959S3;
	Thu, 02 Apr 2026 01:20:54 +0800 (CST)
Received: from [192.168.0.104] (unknown [112.10.227.6])
	by mail-app3 (Coremail) with SMTP id zS_KCgB3YnfxU81p6c0+AA--.45456S3;
	Thu, 02 Apr 2026 01:20:51 +0800 (CST)
Message-ID: <f120c3c4-6999-414a-b514-518bb64b4758@zju.edu.cn>
Date: Thu, 2 Apr 2026 01:21:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 1/3] bpf: Reject bpf-to-bpf call with large offset
 in interpreter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Yazhou Tang <tangyazhou518@outlook.com>,
 Shenghao Yuan <shenghaoyuan0928@163.com>, Tianci Cao <ziye@zju.edu.cn>,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
 <20260326090133.221957-2-tangyazhou@zju.edu.cn>
 <319906e9-3b47-472f-9a11-a0da60626144@huaweicloud.com>
 <9a61d64e-7943-4e39-8c82-c79bb9ac65b4@zju.edu.cn>
 <fa28e388-fbd4-43af-982a-828f5c0456eb@huaweicloud.com>
 <CAADnVQL5MKCqiEpa+vHA9TByBy0K-CPpSoJQ1_PF68kE6gxAwg@mail.gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <CAADnVQL5MKCqiEpa+vHA9TByBy0K-CPpSoJQ1_PF68kE6gxAwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgB3YnfxU81p6c0+AA--.45456S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAgAHCmnK0gwjnwADsN
X-CM-DELIVERINFO: =?B?1ERJQwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9JAoCNGA0NRqGkjYUoYU5m0UrG9BOIr+UAtDL0cRJbRzxf/DwATTX9bR0pB7YYAKSbPn
	LplJXeUxFS0JoM8TTB9KSCVveemUcRgvIlz84M1gDXAzI02+RkRQCQ7mpLWGLg==
X-Coremail-Antispam: 1Uk129KBj93XoWxZF15WF1DtrWUur4UZrW3CFX_yoW5Zr1fpF
	W8Wa4Yyw1DArWay397Aw48Aw15Krsrt3WUWF45KryfZws8Gr1Y9F15KFZY9FnrCrn7C34j
	qFWYv3s7Aas0kacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x0262
	8vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ
	18PUUUUU=

Hi Kuohai and Alexei,

Sorry for the late reply.

Kuohai, your intuition was absolutely right. And Alexei, thank you
for pushing this direction.

I ran a micro-benchmark (unrolling 1000 contiguous bpf-to-bpf calls,
triggered via bpf_prog_test_run for 1M repeats) to measure the overhead
with JIT disabled. To my surprise, the "interpreters_args[insn->off]"
approach is actually ~19% FASTER than the original implementation.

Performance Results (1 Billion calls):

- Before (using "__bpf_call_base_args + imm"): 5.752 seconds
- After (using "interpreters_args[insn->off]"): 4.644 seconds

(Benchmark program: https://github.com/ADSWT518/linux-ebpf/commit/0bace08761b2ed41ba48244d973b2fcfb0ac3461 )

Why it's faster?

I guess the performance boost comes from better instruction-level parallelism.
- In the old method, computing the target address required an explicit
   calculation (via LEA) on the critical path, stalling the branch until the
   arithmetic result was ready.
- By switching to a static array lookup, the CPU can resolve the jump target
   earlier and reduce pipeline stalls.

This change elegantly fixes the 32KB limit, cleans up the code, and
improves interpreter performance. I will send out v6 shortly.

Thanks again for the brilliant suggestions!

Best,
Yazhou

On 4/1/26 07:29, Alexei Starovoitov wrote:
> On Fri, Mar 27, 2026 at 7:05 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> On 3/27/2026 5:37 PM, Yazhou Tang wrote:
>>> Hi Kuohai,
>>>
>>> On 3/26/26 21:45, Xu Kuohai wrote:
>>>> Maybe I’m missing something, but since interpreters_args is a small array, why not
>>>> just store the index (round_up(stack_depth, 32) / 32) - 1 in insn->off?
>>>>
>>>> That way, the interpreter could directly use this index to find the function address,
>>>> without needing insn->imm to record the address offset, thus avoiding the need to use
>>>> another field like insn->off in the instruction to back up the original insn->imm.
>>>
>>> Thanks for the suggestion! Conceptually, storing the array index in insn->off and keeping the 32-bits insn->imm unchanged is a very elegant way to solve this problem.
>>> But I think it will introduce a performance regression in the interpreter's hot path (___bpf_prog_run).
>>>
>>> Currently, the array lookup is done once during verification. The resulting offset is stored in insn->imm, allowing the runtime to use a fast ALU addition: __bpf_call_base_args + insn->imm.
>>>
>>> However, If we store the index in insn->off instead, we force the runtime to perform a memory load (interpreters_args[insn->off]) on every single bpf-to-bpf call.
>>>
>>> Because of this overhead, rejecting out-of-bounds offsets at load time with -EINVAL (as done in v5) seems to be the safer and more performant trade-off.
>>>
>>> What are your thoughts on this?
>>>
>>
>> Do you have any performance data?
>> TBH, I am curious if the overhead is even measurable.
> 
> I think it's a great idea. interpreter is a slow path.
> The interpreters_args[insn->off] approach will let use remove
> __bpf_call_base_args too.
> 
> Pls respin
> 
> pw-bot: cr

