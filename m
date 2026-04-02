Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDB331214;
	Thu,  2 Apr 2026 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098136; cv=none; b=EAZugfqP3rD1KHU5fFEDwMtLmoQ/eQ/pfrBjP1tcCHV1kDKp+xcvNwYdcBumeUkUSRueZV0zJT5Y+k4qg/+M8yl4XliAKq+W2YpKrMdIKVo9nBpQgvBZj3cSFW/b7DGHLWduTplnJDZGEimIGZ0aJl9FbixkgLLXape0LLvvHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098136; c=relaxed/simple;
	bh=nvdPCKZmii8Q5beKHgefCNimY7ElhJYekIGNQA4QKCM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V+1Q75VQWRbe3wXi0VuxJN987OYB7P0UZChfYh8Qgdaq6B4UlC0FSER0y8tsSHZmPoA9de5JuBVtuOsXm/6mxKy6a9f3tJmbuYkH89/Vd/cOR5vMXE1uLuU3nVY3DkypnY6QWZWLU15JHOr8Syx3T+0oNO9jl91QE45hFX3myIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx48AR2c1p5RAhAA--.33981S3;
	Thu, 02 Apr 2026 10:48:49 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxGMEH2c1p4CRjAA--.44258S3;
	Thu, 02 Apr 2026 10:48:39 +0800 (CST)
Subject: Re: [PATCH v1 1/5] LoongArch: Define format for AM{SWAP/ADD}.{B/H},
 DBAR and BSTRINS.D
To: bot+bpf-ci@kernel.org, chenhuacai@kernel.org, hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260401071206.5506-2-yangtiezhu@loongson.cn>
 <6089c3c90bd2f2cf2848a39fc0d30219d0f3f95f9c74257a19d01de053eb1c44@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3b8ef23a-e324-4ad8-430c-e02adca44a1c@loongson.cn>
Date: Thu, 2 Apr 2026 10:48:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6089c3c90bd2f2cf2848a39fc0d30219d0f3f95f9c74257a19d01de053eb1c44@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxGMEH2c1p4CRjAA--.44258S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZF48Jr4ruF1rZF4fJF1DJwc_yoWkCrc_Cw
	sFgFy5Gr48AanYvw1DG3Z5Xr45Aa1fKFnaya4DK39rAFy5Xr13twsxJa4fAryYqF1ftFZa
	yw4xZFnF9w12qosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbq8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUceOJUUUUU

On 2026/4/1 下午4:23, bot+bpf-ci@kernel.org wrote:
>> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
>> index 657bbae6c1c7..93466fc7d33d 100644
>> --- a/arch/loongarch/kernel/cpu-probe.c
>> +++ b/arch/loongarch/kernel/cpu-probe.c
>> @@ -177,6 +177,10 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
>>   		c->options |= LOONGARCH_CPU_LAM;
>>   		elf_hwcap |= HWCAP_LOONGARCH_LAM;
>>   	}
>> +	if (config & CPUCFG2_LAM_BH) {
>> +		c->options |= LOONGARCH_CPU_LAM_BH;
>> +		elf_hwcap |= HWCAP_LOONGARCH_LAM_BH;
>> +	}
> 
> Should there be a corresponding entry in the "Features" line of
> /proc/cpuinfo for the new lam_bh capability?
> 
> Every other feature that sets elf_hwcap in cpu_probe_common() also
> has a matching seq_puts() in show_cpuinfo() in proc.c:
> 
> arch/loongarch/kernel/proc.c:show_cpuinfo() {
>      ...
>      if (cpu_has_lam)
>              seq_puts(m, " lam");
>      if (cpu_has_scq)
>              seq_puts(m, " scq");
>      ...
> }
> 
> The new cpu_has_lam_bh is missing from this list.

Yes, I think so, thank you.
I will wait for more comments before sending v2.

Thanks,
Tiezhu

