Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA07E2
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206308; cv=none; b=SKfq+M1PR2H8bFxNVKcqjTGJw4fL9F/BNF/CRCYshFbFCngbxnBg5RubUgOqAkmKB1R5V88/4awDQ3plUgO/wA+HXofHBP863qNPUqAWGD0uVYtYHOfFIl9I/Zkoj1xUyHYBSebSjiqI2QeQxkZD756q+r3LOjGFIzHlK/1zOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206308; c=relaxed/simple;
	bh=GMTJh7nOt41dKISqA9lEK3Eyhx+pUfwiFPevnSznlHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuhkruqcNG6aWD+7BmSBt8e5rg9J7RsEkODy3fWbYY7ErCn7hfbk/DkQRx+eapmbczTI/HbO+EgJUcjFnNlgGIQ3f0i2k+sK12o/hWRKsgYNYoUeVEMy3S55wF7BryYTToFErg4j7/9fXCvmrp5byjPs5E1TRyrNko7bVHdBNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ttwkb6wB2z4f3jsg
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 09:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9DB711A019F
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 09:18:21 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgA3955cre9laYFJGg--.31220S2;
	Tue, 12 Mar 2024 09:18:21 +0800 (CST)
Message-ID: <1133a3d8-a7a5-47f1-8768-682c3e502d7e@huaweicloud.com>
Date: Tue, 12 Mar 2024 09:18:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while
 not supported
Content-Language: en-US
To: Atish Patra <atishp@atishpatra.org>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20240305155223.1823287-1-pulehui@huaweicloud.com>
 <20240307-oat-mule-10441ef7e94a@spud>
 <f399749b-85bf-4aaf-8af6-ea735c5ab517@huaweicloud.com>
 <CAOnJCULGctBu6viW7PwpT30o2fZ=aApi6UaJKsB4qjMEaEQ2cg@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAOnJCULGctBu6viW7PwpT30o2fZ=aApi6UaJKsB4qjMEaEQ2cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgA3955cre9laYFJGg--.31220S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4kWw1fXryUGFW7AF1DZFb_yoW5Ww13pF
	48CFyFka15Jr1ayw1aqF1ktF1rt3s5K3s8XryDt34Uurs09F9rKFWkKayrC3W8Xr1xCry2
	vr1UKrW3Ca45AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/3/9 17:06, Atish Patra wrote:
> On Fri, Mar 8, 2024 at 10:48 PM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>>
>>
>> On 2024/3/8 1:52, Conor Dooley wrote:
>>> On Tue, Mar 05, 2024 at 03:52:23PM +0000, Pu Lehui wrote:
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> RISC-V perf does not yet support branch sampling. Two riscv bpf
>>>> testcases get_branch_snapshot and perf_branches/perf_branches_hw failed
>>>> due to not disabling such sampling.
>>>>
>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>
>>> This seems worthy of a fixes tag. For what commit I do not know, but I
>>> figure it is a problem currently in mainline and a fix should be
>>> backported?
>>
>> Thanks for review. We need to ban this type of event, otherwise we will
>> get unpredictable results. It should be with a fixes tag.
>>
>>>
>>>> ---
>>>>    drivers/perf/riscv_pmu.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
>>>> index c78a6fd6c57f..bc42cb95a97c 100644
>>>> --- a/drivers/perf/riscv_pmu.c
>>>> +++ b/drivers/perf/riscv_pmu.c
>>>> @@ -313,6 +313,10 @@ static int riscv_pmu_event_init(struct perf_event *event)
>>>>       u64 event_config = 0;
>>>>       uint64_t cmask;
>>>>
>>>> +    /* does not support taken branch sampling */
>>>
>>> Skimming patchwork, I found this comment confusing.
>>> Isolated from the commit message, which it will be once committed, it
>>> was not immediately clear that you were referring to the driver. I think
>>> it is just matter of making this a complete sentence that starts by
>>> mentioning /what/ does not support this feature. Is it the driver? Does
>>> the spec not allow it? etc
>>
>> I actually just found out that the current implementation of riscv perf
>> driver doesn't support it. After reading the relevant spec, I did not
>> find any description related to branch record. Maybe I may have missed
>> something or it may be supported in the future, but the current driver
>> does not support it, so I think it is more appropriate to limit this
> 
> Yes. There was no specification at the time this driver was upstreamed.
> The spec for branch record being is on its way for ratification and patches
> will be available soon.
> https://github.com/riscv/riscv-control-transfer-records
> 
> The changes look good to me for now. I will be happy to send a RB tag once you
> add the Fixes tag.
> 

Thanks for your addition, looking forward to the upcoming 
implementation. Will send new version soon.

>> comment to the driver implementation. How about "riscv perf driver does
>> not support branch stack sampling"?
>>
>>>
>>> Cheers,
>>> Conor.
>>>
>>>> +    if (has_branch_stack(event))
>>>> +            return -EOPNOTSUPP;
>>>> +
>>>>       hwc->flags = 0;
>>>>       mapped_event = rvpmu->event_map(event, &event_config);
>>>>       if (mapped_event < 0) {
>>>> --
>>>> 2.34.1
>>>>
>>
> 
> 

