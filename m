Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AB11A23B1;
	Mon, 15 Jun 2026 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781489137; cv=none; b=TJKe87s3dfLEMKZ7Ys40OC6sxfCdq9txhYKQgtA75M61jaR3xj1iFRQVY4dgK9Xr+gufby4SFKsh9MYFnWouAT5D+Tg3WhatHWvtdxh9b+BNtSYnBiUNmj0rpRBrYKixMJuPt/PJepRfGqkQDy5ky3+AjKyKe13h4o98VODkuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781489137; c=relaxed/simple;
	bh=3Evm8E64UJiHJeWvRrQzxFAP7yAy1tHphwvX6cAZlY8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BfpfH4CuC/G2ykj4ZJ1pw/NmlflDWlz6JOoO9CPDeasiMZ0uOHrquNt7/LRvcXNBP1Epz6MQPpln0NkH/NVmrFoSo6xyx651wfO8W9kTvFChSDOQTzD04fOn3SERtaUNVawlnAyKnJH+yTeU8nCvtowU7zkfUdxwE1CI3BqBRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxQ_DsXS9qdCkUAA--.52655S3;
	Mon, 15 Jun 2026 10:05:32 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxKMHpXS9q25+mAA--.39733S3;
	Mon, 15 Jun 2026 10:05:30 +0800 (CST)
Subject: Re: [PATCH bpf-next v2] bpf: Fix unaligned interpreter panic on JIT
 fallback path
To: Leon Hwang <leon.hwang@linux.dev>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611101216.30153-1-yangtiezhu@loongson.cn>
 <093f957d-3d3a-4ce7-b59b-06203c556629@huaweicloud.com>
 <9c84609b-3b82-9a43-0f25-4ac632109819@loongson.cn>
 <f8d1b14f-e577-44bf-baf7-fe9da871889d@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <ad046aad-c258-d121-41a2-7fa823b3cb02@loongson.cn>
Date: Mon, 15 Jun 2026 10:05:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f8d1b14f-e577-44bf-baf7-fe9da871889d@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxKMHpXS9q25+mAA--.39733S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr43Wr4UZF4xCw4Dtw45CFX_yoW8XFW7p3
	WkCayYkr4DJF92ga9Fqw1kXw1Yvw45AFWDGw1rG3yrAFyYgr1fXF45tF4Y9a9xCr10kry0
	va1xKF95urn8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU

On 2026/6/15 上午9:49, Leon Hwang wrote:
> On 15/6/26 09:23, Tiezhu Yang wrote:
>> On 2026/6/12 下午8:37, Xu Kuohai wrote:
>>> On 6/11/2026 6:12 PM, Tiezhu Yang wrote:
>>>> When an architecture implements bpf_jit_inlines_helper_call(), such
>>>> as LoongArch, ARM64, and RISC-V, the BPF verifier skips rewriting
>>>> the helper call offset (insn->imm) during the bpf_do_misc_fixups()
>>>> phase if the helper is expected to be inlined by the JIT compiler.
>>>> As a result, insn->imm remains as the raw helper enum ID.
>>
>> ...
>>
>>>> +static void bpf_fixup_fallback_inline_helpers(struct
>>>> bpf_verifier_env *env, struct bpf_prog *fp)
>>>
>>> The function name is a bit long for a static function
>>
>> If there are no objections, I will shorten the static function
>> name to bpf_fixup_inline_helpers() in v4.
>>
> 
> I think bpf_fixup_inline_helpers() is not accurate, since it is to fix
> those non-inline helpers here. bpf_fixup_non_inline_helpers() is a
> candidate. However, a shorter name is preferred.

I see your point. Indeed, we are fixing up the helpers that ultimately 
failed to be inlined on the fallback path.

How about shortening it to fixup_fallback_helpers()? Since it is a
static function, we can safely drop the bpf_ prefix to keep it concise,
clean, and accurate.If that looks good to you, I will use this name and
remove the redundant check in the next version.

> Please provide changelog btw. For a single patch, you can provide
> changelog here.

OK, no problem.

Thanks,
Tiezhu

