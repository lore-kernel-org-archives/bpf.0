Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DF1D89F4;
	Mon, 15 Jun 2026 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781493413; cv=none; b=knsxWsco/9epytxM4lBzRg4vBb8q5tq32t59GIYnzPkottDTQKEqrVPLVyBkUd+5yL6xFwHvoOShxlFmFmMlecMgAidoXLq1WNlKWE59rZSvTtE28MUJvdp29VkMvMQptdGZT8c7kKKdPlHPxqKK9cgCS2fr+l/upPAMs2zHhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781493413; c=relaxed/simple;
	bh=EIuF3oNbkt0jxHFS4anqKg/YvPaeOwuUXO4ArtMQYLo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UWiGiYOsPCJzbl6bEI8BWMpUa2XJH1X8U0h+ov6TraZa9HqkiSjNBD4PvKqtSLNuRpUVyVftXsjKctjfTbAr8Aen9dMZ/Fsp2xFD20pHhHBLGLcyVu1Gf/pwMDuglz9qYUSGwLk8rk+cbvV5/6p5pS33CzOdhpPWYog7oZpokoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxNeifbi9qJi4UAA--.47005S3;
	Mon, 15 Jun 2026 11:16:47 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxPMKcbi9qYq+mAA--.52506S3;
	Mon, 15 Jun 2026 11:16:45 +0800 (CST)
Subject: Re: [PATCH v3 0/3] Move thread_info into task_struct for LoongArch
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260612011616.27771-1-yangtiezhu@loongson.cn>
 <CAAhV-H4daHGFoAiXrwcNXj=T1kZm5jRRwd_sCiv7ksjR2ynHgw@mail.gmail.com>
 <e23e6781-d39d-d7fa-10ec-8d09349103ed@loongson.cn>
 <CAAhV-H6jJpEnNTUF0CF60fDB5ShNT+C59NEH=YodJtepFQgrKQ@mail.gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <833e2fca-6a41-786c-356d-6480ca168e44@loongson.cn>
Date: Mon, 15 Jun 2026 11:16:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6jJpEnNTUF0CF60fDB5ShNT+C59NEH=YodJtepFQgrKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPMKcbi9qYq+mAA--.52506S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF15GF4kuryxurW8KF1rAFc_yoW8ZF48pw
	4fKa1Ykws5Kr1UArWxtw4DZFyIqr13uFW0qrn3Gw15Cwn0qw4rKrW7Wr45uFyxurWF9r1j
	vFs2q3srCFyDJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8HSoJUUUUU==

On 2026/6/15 上午10:23, Huacai Chen wrote:
> On Mon, Jun 15, 2026 at 9:41 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> On 2026/6/14 上午10:51, Huacai Chen wrote:
>>> Hi, Tiezhu,
>>>
>>> I have queued this series for 7.2, does the below series depend on this one?
>>>
>>> https://lore.kernel.org/loongarch/20260521125636.26744-1-yangtiezhu@loongson.cn/T/#t
>>
>> This is independent on CONFIG_THREAD_INFO_IN_TASK.
>>
>>> https://lore.kernel.org/loongarch/20260428080051.20938-1-yangtiezhu@loongson.cn/T/#t
>>
>> This is dependent on CONFIG_THREAD_INFO_IN_TASK.
>>
>> But anyway, I plan to send new version for the above two series of
>> selftests once this "Move thread_info into task_struct for LoongArch"
>> series is merged into the mainline, maybe after 7.2-rc1.
>>
>> Because the code under selftests need to be updated, for example,
>> it can use bpf_get_current_task_btf()->thread_info.preempt_count
>> for get_preempt_count(), and it should use ld.wu rather than ld.w
>> for bpf_get_smp_processor_id().
> You can update new versions now, then they can be merged together.

Thanks for your suggestion.

However, considering that these selftest patches need to be
routed through the BPF tree (rather than the LoongArch tree),
updating them right now during the active merge window might
be inappropriate and risky.

Given that these selftests strictly depend on the "move
thread_info into task_struct" core changes, sending them to
the BPF list now could cause cross-tree dependency issues and
potential build breakages if the core series undergoes any late
adjustments before hitting mainline.

Moreover, because these are selftest adaptations rather than
urgent bug fixes, they aren't high-priority for this immediate
window. I will rebase and submit the new version to the BPF tree
right after 7.2-rc1, once the LoongArch base infrastructure is
securely merged into the mainline.

Thanks,
Tiezhu

