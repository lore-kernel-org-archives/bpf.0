Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3992F1D558
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709966934; cv=none; b=S50SlpQ49YIgngSFisbDkdbzVa3u3J8teHNhFZFTjTp/xMFto6ktiIP7hLhLqotPOr7RX4r7Jd5l2qmTrWnEnNsvrklbPTddFAMt8O2/TuySjkrgcaVAgbYUhUrNlYKHpQMGBt9+boDqTtyzi8rU8ULS4sb2ZFtPr7G3S87LBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709966934; c=relaxed/simple;
	bh=WP5oobjhhkhpYflRy+irgdGS9peCv3p2hdSVGzKUdfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGO3fGqKghifmuWTTNi1OdBbfuGTxa1zrwXIV7GIPrkXHXzQQ4vxpNlkipFYJoXLKMML+lKy7FgjOsHMZnBVil4fMjpjMUk5vm4FSuhdIx8itmv31IIX53jzdf7N72ZVTuBvmqLTYXeNdcPYFOTvWBuYjE3NH17fNkFfPkLC+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TsDCC5yPqz4f3lgN
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 14:48:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6F93F1A016E
	for <bpf@vger.kernel.org>; Sat,  9 Mar 2024 14:48:47 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgAXNQ5OBuxl25GXGQ--.25189S2;
	Sat, 09 Mar 2024 14:48:47 +0800 (CST)
Message-ID: <f399749b-85bf-4aaf-8af6-ea735c5ab517@huaweicloud.com>
Date: Sat, 9 Mar 2024 14:48:45 +0800
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
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20240305155223.1823287-1-pulehui@huaweicloud.com>
 <20240307-oat-mule-10441ef7e94a@spud>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20240307-oat-mule-10441ef7e94a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXNQ5OBuxl25GXGQ--.25189S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4fWw4xCrWfJrWxXr4UXFb_yoW8uw4UpF
	WIkFySka1rJF1Ivw13XF1vq3W5X3ykKF9xKr95K3s8urs0kFnrKFyvyayrC3W8Zr1fAryI
	vr17KrW3Ca45ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/3/8 1:52, Conor Dooley wrote:
> On Tue, Mar 05, 2024 at 03:52:23PM +0000, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> RISC-V perf does not yet support branch sampling. Two riscv bpf
>> testcases get_branch_snapshot and perf_branches/perf_branches_hw failed
>> due to not disabling such sampling.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> This seems worthy of a fixes tag. For what commit I do not know, but I
> figure it is a problem currently in mainline and a fix should be
> backported?

Thanks for review. We need to ban this type of event, otherwise we will 
get unpredictable results. It should be with a fixes tag.

> 
>> ---
>>   drivers/perf/riscv_pmu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
>> index c78a6fd6c57f..bc42cb95a97c 100644
>> --- a/drivers/perf/riscv_pmu.c
>> +++ b/drivers/perf/riscv_pmu.c
>> @@ -313,6 +313,10 @@ static int riscv_pmu_event_init(struct perf_event *event)
>>   	u64 event_config = 0;
>>   	uint64_t cmask;
>>   
>> +	/* does not support taken branch sampling */
> 
> Skimming patchwork, I found this comment confusing.
> Isolated from the commit message, which it will be once committed, it
> was not immediately clear that you were referring to the driver. I think
> it is just matter of making this a complete sentence that starts by
> mentioning /what/ does not support this feature. Is it the driver? Does
> the spec not allow it? etc

I actually just found out that the current implementation of riscv perf 
driver doesn't support it. After reading the relevant spec, I did not 
find any description related to branch record. Maybe I may have missed 
something or it may be supported in the future, but the current driver 
does not support it, so I think it is more appropriate to limit this 
comment to the driver implementation. How about "riscv perf driver does 
not support branch stack sampling"?

> 
> Cheers,
> Conor.
> 
>> +	if (has_branch_stack(event))
>> +		return -EOPNOTSUPP;
>> +
>>   	hwc->flags = 0;
>>   	mapped_event = rvpmu->event_map(event, &event_config);
>>   	if (mapped_event < 0) {
>> -- 
>> 2.34.1
>>

