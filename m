Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C11F3DBD55;
	Tue,  7 Jul 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419175; cv=none; b=cp1WpaUiOzLP5SDZobDYQetApgcu+ehHNCWhsD+CQFKvtdq+T5chYdSr8/bU7IVBsomKFlkzuZJYtOqy0wgfBQJQaGzd2MzA7FMNcY7l9yqTnOH+VkxcmKeU4OGCEh1gb+6KSQIkuGuW3dKzP55FkyKe7KeIsCKhZyJHn/bxGiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419175; c=relaxed/simple;
	bh=MlCJJZSDn6B2CJ2AIRX17y1Y2ddC8O+nAHvgtBDrG8E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GWM0ItDTKHAb9obfRCGKtWxpTAsmCBeRWz0SOkdhSBOvmUusDBEQqG9iz4naXx1qhxg5fESeuh5ZRIQNYqkP8hkhWO6YgSyeJD+fJD5mMb60iah451zBGWuD/2i25PLAKjDhzWYTFVQMKo9ozIK+FK8O1Qm+1ZBA4LaDIWTtCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxWesi0UxqleAAAA--.3823S3;
	Tue, 07 Jul 2026 18:12:50 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxvMYe0Uxqo8gDAA--.22378S3;
	Tue, 07 Jul 2026 18:12:48 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 01/11] LoongArch: BPF: Fix tail call count
 pointer offset for arena programs
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org, hengqi.chen@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kernel@xen0n.name,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, guodongtai@kylinos.cn,
 bpf@vger.kernel.org, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <d7f2c8d3-4a46-e978-5cce-f59b84e632f0@loongson.cn>
 <20260707094354.319438-1-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <19ce4437-2eac-23ab-586f-d425dd4af29b@loongson.cn>
Date: Tue, 7 Jul 2026 18:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707094354.319438-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvMYe0Uxqo8gDAA--.22378S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1UXF4rKr4rtry5AF47trc_yoW8KrWrpr
	W0ga1DJr4kJr18ZrWkuw4xta4F939xJ3y3Wr1rtr4rA3s0qr13tFWF9ayY9FyUArs5WFya
	vFn0y3sI93Z0yFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4qg4DU
	UUU

On 2026/7/7 下午5:43, George Guo wrote:
> Hi Tiezhu,
> Thanks for reviewing!
> 
>> This introduces a runtime helper to dynamically calculate the stack
>> offset. If another optional slot is introduced in the future, this
>> helper will need further adjustments.
> 
> Fair -- that's exactly the tradeoff. This patch was written to be the
> minimal, obviously-correct fix on top of the existing layout (arena slot
> above tcc/tcc_ptr) so it could go to the bpf tree as a standalone,
> backportable fix. It does mean any future optional slot needs another
> "if (...)" in the helper, as you say.
> 
>> Please see the following simple and long-term solution, just move
>> the arena slot below TCC context slots, this ensures a constant
>> offset, reducing complex runtime calculations and eliminating extra
>> instructions.
>>
>>    LoongArch: BPF: Optimize redundant TCC loads in epilogue
>>    https://lore.kernel.org/loongarch/20260630022705.11536-2-yangtiezhu@loongson.cn/
>>
>>    LoongArch: BPF: Move arena register slot below TCC context
>>    https://lore.kernel.org/loongarch/20260630022705.11536-3-yangtiezhu@loongson.cn/
> 
> I read through both -- the reordering is a nice fix: with the arena slot
> moved below tcc_ptr instead of above it, tcc_ptr's offset from $fp stays
> a fixed 80 regardless of arena, so the original hardcoded macro is
> correct again everywhere and the runtime branch goes away entirely.
> Agreed that's the better long-term shape.
> 
> One thing to work out: this series (patch 5, exceptions/bpf_throw) also
> needs an optional extra slot for exception programs, using the same
> mechanism as arena (it currently piggybacks on the same
> `ctx->arena_vm_start || is_exception_prog` check your patch 2/4 would
> replace). If your reordering lands, I'd extend it the same way --
> moving the exception-program slot below tcc_ptr too, rather than adding
> a runtime check back in.
> 
> Where does your series stand? I'd rather rebase this patch series on
> top of your fixed-offset approach once it's in bpf-next than have both
> land and immediately conflict. Let me know what's the best way to
> sequence these.

I am currently addressing the comments from the CI bot and
will send out v3 shortly.

Once this series is upstream, you can rebase your patches
on top of it.

Thanks,
Tiezhu

