Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161203C13F1;
	Mon, 15 Jun 2026 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509915; cv=none; b=HxdEpqR6JWMmhXY7/umQ8GZU3tHGqkh3n3ZHKEQyA1JhPaKulU9zYJbgJruQHpt8gW7Ro594x7QdmjfS1T027uo3grYelgmUT53BS84z1gJTCENm6TPQESUEK4J7dgJ7G3o6joktUKmDTrgVieQXN1FJbpSNRMi6AsWSK/tHzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509915; c=relaxed/simple;
	bh=+O/aknDOAU54SHW0tAJSTtpg9g1Vzt6FSt3KcuF3lm4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aAuqmZ/A1N8ksdbXx8pgQuVmdR2lyzx9RrM13jK7qBjcbSMpo8YFnkDwfzKyXlmoDWmKCtWrmIEseP4Y0/p4pxB3MN96oDolr4v7A/YetpsVjpj+CkeyvxRaaGCcNdjtmYAB/a/n/2R/V1RDxQN2UHI1pgbfOcb2wRwCJTecuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx9OgVry9q2kAUAA--.47127S3;
	Mon, 15 Jun 2026 15:51:49 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxpsASry9qVummAA--.20475S3;
	Mon, 15 Jun 2026 15:51:47 +0800 (CST)
Subject: Re: [PATCH v3 0/3] Move thread_info into task_struct for LoongArch
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20260612011616.27771-1-yangtiezhu@loongson.cn>
 <CAAhV-H4daHGFoAiXrwcNXj=T1kZm5jRRwd_sCiv7ksjR2ynHgw@mail.gmail.com>
 <e23e6781-d39d-d7fa-10ec-8d09349103ed@loongson.cn>
 <CAAhV-H6jJpEnNTUF0CF60fDB5ShNT+C59NEH=YodJtepFQgrKQ@mail.gmail.com>
 <833e2fca-6a41-786c-356d-6480ca168e44@loongson.cn>
 <CAAhV-H5LORpNeTycjmHFobOZEA5w=spSkxJuOajuizz-941zQg@mail.gmail.com>
 <CAADnVQLAgYFQ=BRi+hKwt5pp7fffqsvD0rXzn6Nk9jJQ=6uUZA@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <c3b8242e-c436-bfa4-5081-0484457dcd6b@loongson.cn>
Date: Mon, 15 Jun 2026 15:51:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQLAgYFQ=BRi+hKwt5pp7fffqsvD0rXzn6Nk9jJQ=6uUZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxpsASry9qVummAA--.20475S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur47XryrJF13KryUZF13GFX_yoW5CF1kp3
	ySka1YkF4DKr17AFZrt3s8uFyftr13GrW8Xwn8JryUCrn0vw1rGry3Kr4UuFyDurWFkr1j
	9r4jq3srCa4DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
	xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	cVc_UUUUU

On 2026/6/15 上午11:45, Alexei Starovoitov wrote:
> On Sun, Jun 14, 2026 at 8:31 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>>
>> On Mon, Jun 15, 2026 at 11:16 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>
>>> On 2026/6/15 上午10:23, Huacai Chen wrote:
>>>> On Mon, Jun 15, 2026 at 9:41 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>>
>>>>> On 2026/6/14 上午10:51, Huacai Chen wrote:
>>>>>> Hi, Tiezhu,
>>>>>>
>>>>>> I have queued this series for 7.2, does the below series depend on this one?
>>>>>>
>>>>>> https://lore.kernel.org/loongarch/20260521125636.26744-1-yangtiezhu@loongson.cn/T/#t
>>>>>
>>>>> This is independent on CONFIG_THREAD_INFO_IN_TASK.
>>>>>
>>>>>> https://lore.kernel.org/loongarch/20260428080051.20938-1-yangtiezhu@loongson.cn/T/#t
>>>>>
>>>>> This is dependent on CONFIG_THREAD_INFO_IN_TASK.
>>>>>
>>>>> But anyway, I plan to send new version for the above two series of
>>>>> selftests once this "Move thread_info into task_struct for LoongArch"
>>>>> series is merged into the mainline, maybe after 7.2-rc1.
>>>>>
>>>>> Because the code under selftests need to be updated, for example,
>>>>> it can use bpf_get_current_task_btf()->thread_info.preempt_count
>>>>> for get_preempt_count(), and it should use ld.wu rather than ld.w
>>>>> for bpf_get_smp_processor_id().
>>>> You can update new versions now, then they can be merged together.
>>>
>>> Thanks for your suggestion.
>>>
>>> However, considering that these selftest patches need to be
>>> routed through the BPF tree (rather than the LoongArch tree),
>>> updating them right now during the active merge window might
>>> be inappropriate and risky.
>>>
>>> Given that these selftests strictly depend on the "move
>>> thread_info into task_struct" core changes, sending them to
>>> the BPF list now could cause cross-tree dependency issues and
>>> potential build breakages if the core series undergoes any late
>>> adjustments before hitting mainline.
>>>
>>> Moreover, because these are selftest adaptations rather than
>>> urgent bug fixes, they aren't high-priority for this immediate
>>> window. I will rebase and submit the new version to the BPF tree
>>> right after 7.2-rc1, once the LoongArch base infrastructure is
>>> securely merged into the mainline.
>> In history most arch-specific selftests are merged via arch trees,
>> including perf, bpf, ftrace, kvm and so on.
> 
> This is not true at all.
> All bpf selftests are going through bpf-next tree.
> For example, x86 and arm64 bpf JIT changes always go
> through bpf-next.
> loongarch is causing problems this way by taking bpf JIT changes
> into the loongarch tree.

I will prepare and send the new version of bpf selftests patches
based on the bpf-next repo shortly. In the cover letter, I will
explicitly state the dependency on the "Move thread_info into
task_struct for LoongArch" series.

I will leave it to you and the LoongArch maintainer to decide on
the best way and timing for the actual merge.

Thanks,
Tiezhu

