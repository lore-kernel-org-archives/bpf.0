Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7F46B5
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777620980; cv=none; b=DTiUum3aa2sGcGIMrr3+H5vxFojtFdfCYx4C0n8YoPBsbCkfV3ftoZNELEtRDeUfIV1RxP7ExExfDh5PfdWRW9eKHzYgY3lJF2tT+Y+KJrsuCBP+7sq9lshXhDuD2R0/qXx7FYIxDVOZF6K1UURBH9aWX+AfGe0Pi7K0J/yqsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777620980; c=relaxed/simple;
	bh=2yiEfI/eXc+J4PdwywiDJoAoWGxZ51esyz6qE9CaznQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hv6vRs1uzjqp/kfNoP+DpuQm3zHtyRsCTaQUIWFYS1v/hh2aMljoIOgaLJGHsJZrJveyGHML3o+ZEMh9r++MJOYC+0y6Ju4cLEIMDW3uNAWyZVwNPXwLcARnlYYDKALig9sWUthYmXyUBhYDAwTJkMmNGnJsCX+dgOKwZt5hh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.162.232])
	by mtasvr (Coremail) with SMTP id _____wDXoUXXV_Rpr8TxAA--.10288S3;
	Fri, 01 May 2026 15:35:52 +0800 (CST)
Received: from [IPV6:fd53:414e:4746:4f52:104f:147f:6f5f:164a] (unknown [10.190.162.232])
	by mail-app4 (Coremail) with SMTP id zi_KCgAHOjHVV_RpgPuYAA--.49574S3;
	Fri, 01 May 2026 15:35:50 +0800 (CST)
Message-ID: <e85fa7f9-02ef-42ad-80eb-26c1756737da@zju.edu.cn>
Date: Fri, 1 May 2026 15:35:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yazhou Tang <tangyazhou@zju.edu.cn>
Subject: Re: [PATCH bpf-next v9 2/3] bpf: Fix s16 truncation for large
 bpf-to-bpf call offsets
To: Quentin Monnet <qmo@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 bpf@vger.kernel.org, ast@kernel.org, eddyz87@gmail.com,
 emil@etsalapatis.com, puranjay@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com, ziye@zju.edu.cn
References: <20260429171904.107244-1-tangyazhou@zju.edu.cn>
 <20260429171904.107244-3-tangyazhou@zju.edu.cn>
 <518d74d6-7750-4950-a76f-3e67e480840e@huaweicloud.com>
 <6fc310e8-f929-4b1a-b298-71f2445e3c6e@zju.edu.cn>
 <c801c51e-70d5-4bdd-8f83-d1f71f84186d@kernel.org>
Content-Language: en-US
In-Reply-To: <c801c51e-70d5-4bdd-8f83-d1f71f84186d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAHOjHVV_RpgPuYAA--.49574S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg8RCmnyXw44nQADs6
X-CM-DELIVERINFO: =?B?nGnlPgXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9HD5f/v2qbBNnu6nxZck69NNlFtLrtoJ9tyLw5gPpHxc6MiTZw3V40aNwRLmOeGis2wN
	WtHouj9U6+4JZc00zD/F1wU4Pe7it71ai4gjW5yOxQOYcMrWzBVHplh5x7YEIA==
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1DWFy5GryUAr1fWr1fXwc_yoW8trykpF
	4kJa4jkFW5Xr1fAr1UKa17KrW5tFWxC348Gr1ftFWUZr1rJr1aqFWjqFZY93W5ur4xJF17
	XF4jvryDuF1UXacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8c
	xan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU13r
	cDUUUUU==

Hi Quentin,

Thanks for your reply.

On 4/30/26 23:25, Quentin Monnet wrote:
> 2026-04-30 23:00 UTC+0800 ~ Yazhou Tang <tangyazhou@zju.edu.cn>
>> Hi Kuohai,
>>
>> Thanks for your review and the Acked-by tag.
>>
>> On 4/30/26 11:29, Xu Kuohai wrote:
>>> On 4/30/2026 1:19 AM, Yazhou Tang wrote:
>>
>> [...]
>>
>>>> diff --git a/tools/bpf/bpftool/cfg.c b/tools/bpf/bpftool/cfg.c
>>>> index e3785f9a697d..df43a0e0023f 100644
>>>> --- a/tools/bpf/bpftool/cfg.c
>>>> +++ b/tools/bpf/bpftool/cfg.c
>>>> @@ -142,7 +142,7 @@ static bool cfg_partition_funcs(struct cfg *cfg,
>>>> struct bpf_insn *cur,
>>>>                continue;
>>>>            if (cur->src_reg != BPF_PSEUDO_CALL)
>>>>                continue;
>>>> -        func = cfg_append_func(cfg, cur + cur->off + 1);
>>>> +        func = cfg_append_func(cfg, cur + cur->imm + 1);
>>>
>>> Do we need to matain backward compatibility with the old bpftool here?
>>> I suspect not, but I'm not entirely sure.
>>
>> I agree. Since bpftool is maintained in-tree, it should be enough to just
>> keep it in sync with the current kernel tree.
> 
> Hi, bpftool is also mirrored on GitHub at
> https://github.com/libbpf/bpftool
> and many people build it from there, so yes, it should be backward
> compatible if possible at all.

Thanks for pointing that out. Considering this situation, I will make
sure to maintain backward compatibility in bpftool.

However, since the xlated format for BPF_PSEUDO_CALL swaps the imm and
off fields, distinguishing the old format from the new one purely from
the instruction stream seems a bit tricky. Both fields could technically
contain small integers.

I'm not very familiar with bpftool. Is there a standard/preferred way
in bpftool to probe for such kernel behavior changes?

One potential approach could be to load a minimal dummy BPF program with
a BPF_PSEUDO_CALL instruction, dump its xlated instructions, and check
whether the kernel stored the offset in imm or off. Finally use this
boolean result for subsequent bpftool dumps.

Do you have any suggestions on this? Thanks again for the guidance.

> 
> Thanks,
> Quentin

