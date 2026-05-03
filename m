Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C09340281
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777791390; cv=none; b=mYsKpwCBzvTn1TafrjyTR3k4c+LGFw8q/BQHyusaKXtr70EFHdAkhW5W4R3gN6ZIS0eeHcn6C6tQCEifSG+YbDkn4Ybxq7aH+hYRwZtFlkj/dryLkBbevd42JLu7kOQBXjvF1+6P5PmLhqXb9bXIem6hE2TW2nlsldToqN6XLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777791390; c=relaxed/simple;
	bh=9OMJ5kVcEKuW+8lmfiN/lMqqmKC9ZUR2NxuDeIxIyAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLQosMHZ+GcfOYEIEs/pXQIZshZq/BXkb8dR3x1vz0UwTRQaAKPdmlTWCZAdRefH+2NN4Y72XRW0nsdY7+ZcKd5+KO9qEh2ORxsLukN+aitbrgP5mJQp5+hc82idSWWACc+bR1eoZ44bRpu5cT76qtcHtMLTwjJ6efKP0/2zQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.236.2.93])
	by mtasvr (Coremail) with SMTP id _____wBHJKyA8fZpzP_+AA--.19853S3;
	Sun, 03 May 2026 14:56:01 +0800 (CST)
Received: from [10.16.97.57] (unknown [115.236.2.93])
	by mail-app3 (Coremail) with SMTP id zS_KCgAnYXR88fZpTFjZAA--.5506S3;
	Sun, 03 May 2026 14:55:57 +0800 (CST)
Message-ID: <6fb4db24-e98b-4129-8f22-689ad7c04323@zju.edu.cn>
Date: Sun, 3 May 2026 14:55:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Eduard <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 Puranjay Mohan <puranjay@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Yazhou Tang <tangyazhou518@outlook.com>,
 Shenghao Yuan <shenghaoyuan0928@163.com>, Tianci Cao <ziye@zju.edu.cn>
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-3-tangyazhou@zju.edu.cn>
 <518d74d6-7750-4950-a76f-3e67e480840e@huaweicloud.com>
 <6fc310e8-f929-4b1a-b298-71f2445e3c6e@zju.edu.cn>
 <c801c51e-70d5-4bdd-8f83-d1f71f84186d@kernel.org>
 <e85fa7f9-02ef-42ad-80eb-26c1756737da@zju.edu.cn>
 <CAADnVQLqpwc2q_Zesgvqq0WLNzcnGUc9D5QTdzLDX8_tj7OBFA@mail.gmail.com>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <CAADnVQLqpwc2q_Zesgvqq0WLNzcnGUc9D5QTdzLDX8_tj7OBFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAnYXR88fZpTFjZAA--.5506S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg8RCmnyXw44nQAFs8
X-CM-DELIVERINFO: =?B?4i73MgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HD5f/v2qbBNnu6nxZck69OEbrQHbtpMSfDVWDU4csKRYmXNQcYDsTwU3hDC4QhK7rlp
	+gVSAxRwAgTnAYSk+3jCcrV/MQC0rlf45yYz57wsVt9PEwr806Wj2HDVxNsdIQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxArW5Gw17AF18Aw1rWry3Awc_yoW5AF1kpa
	98Ga4jkF4DXr13ArnrKw4IkFW5trWSk348Wr45try5X3sYqr1ftF48tF4Fkw13ur1xGF12
	va4jvF9rWF1UXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGO
	UUUUU

Hi Alexei,

Thanks for your advice.

On 5/1/26 15:53, Alexei Starovoitov wrote:
> On Fri, May 1, 2026 at 8:36 AM Yazhou Tang <tangyazhou@zju.edu.cn> wrote:
>>
>> Hi Quentin,
>>
>> Thanks for your reply.
>>
>> On 4/30/26 23:25, Quentin Monnet wrote:
>>> 2026-04-30 23:00 UTC+0800 ~ Yazhou Tang <tangyazhou@zju.edu.cn>
>>>> Hi Kuohai,
>>>>
>>>> Thanks for your review and the Acked-by tag.
>>>>
>>>> On 4/30/26 11:29, Xu Kuohai wrote:
>>>>> On 4/30/2026 1:19 AM, Yazhou Tang wrote:
>>>>
>>>> [...]
>>>>
>>>>>> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
>>>>>> index e3785f9a697d..df43a0e0023f 100644
>>>>>> --- a/tools/bpf/bpftool/cfg.c
>>>>>> +++ b/tools/bpf/bpftool/cfg.c
>>>>>> @@ -142,7 +142,7 @@ static bool cfg_partition_funcs(struct cfg *cfg,
>>>>>> struct bpf_insn *cur,
>>>>>>                 continue;
>>>>>>             if (cur->src_reg != BPF_PSEUDO_CALL)
>>>>>>                 continue;
>>>>>> -        func = cfg_append_func(cfg, cur + cur->off + 1);
>>>>>> +        func = cfg_append_func(cfg, cur + cur->imm + 1);
>>>>>
>>>>> Do we need to matain backward compatibility with the old bpftool here?
>>>>> I suspect not, but I'm not entirely sure.
>>>>
>>>> I agree. Since bpftool is maintained in-tree, it should be enough to just
>>>> keep it in sync with the current kernel tree.
>>>
>>> Hi, bpftool is also mirrored on GitHub at
>>> https://github.com/libbpf/bpftool
>>> and many people build it from there, so yes, it should be backward
>>> compatible if possible at all.
>>
>> Thanks for pointing that out. Considering this situation, I will make
>> sure to maintain backward compatibility in bpftool.
>>
>> However, since the xlated format for BPF_PSEUDO_CALL swaps the imm and
>> off fields, distinguishing the old format from the new one purely from
>> the instruction stream seems a bit tricky. Both fields could technically
>> contain small integers.
>>
>> I'm not very familiar with bpftool. Is there a standard/preferred way
>> in bpftool to probe for such kernel behavior changes?
>>
>> One potential approach could be to load a minimal dummy BPF program with
>> a BPF_PSEUDO_CALL instruction, dump its xlated instructions, and check
>> whether the kernel stored the offset in imm or off. Finally use this
>> boolean result for subsequent bpftool dumps.
>>
>> Do you have any suggestions on this? Thanks again for the guidance.
> 
> There should be no need to do probing in bpftool.
> The xlated insns should be translated back to the original format
> by the kernel.

Got it. I will restore the original format for the xlated insns in
bpf_insn_prepare_dump() and drop the bpftool modifications.

One minor issue is that the printed offset will still be truncated
if the real offset (the original insn->imm) is out of s16 bounds.
To avoid confusion, I will just set it to 0 in that case. See prior
discussion in https://lore.kernel.org/bpf/422fce2b-228d-40d0-8fbf-f295f2aac0db@zju.edu.cn/

Thanks for your guidance.

