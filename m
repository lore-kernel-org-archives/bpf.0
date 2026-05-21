Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7F3C3C07
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363607; cv=none; b=mGP2/ZL6zUK6gkA1CABE46HrAyywMsfPhemCHY88wocRSPnTve8g9N3ZR8k1NbJoUJ9midpFWCjrjEanuMnmKDrmtsNHW7XAw9HK985qZNBu6TkUMYcV+tW/FqVyKYf1Q/ypwIkkrrCw2xLOhU93l4V49elBy2zwwDJe4h/1WHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363607; c=relaxed/simple;
	bh=4XhC/zvHXU/cXg/PTJkovdG5QCBCacxU2LkJHH9Ymv8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tyRJJmvUrhxUNoepTw2m2FfRcbvSZqqL0WsS1nbZCDNGv/pWSH9jgTk87JLwqmiW3XEpShdzJ+os62FNR+3fHOjoBq+K1GyaiAPW7boJa6+SLrJ96y1kpETNVR7qd3xbKFrDgY7sETjkSeFtrhGLbsjQS146BI1wBZWYtpKZ+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxDuoP7w5qv_kLAA--.34295S3;
	Thu, 21 May 2026 19:40:00 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxjcIO7w5qWwSLAA--.64865S3;
	Thu, 21 May 2026 19:39:58 +0800 (CST)
Subject: Re: [PATCH v1 1/3] LoongArch: BPF: Fix tail call prologue alignment
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260521070128.28086-2-yangtiezhu@loongson.cn>
 <20260521080021.AD9EE1F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <202feb71-403f-2e09-c3cd-c933754b8ea9@loongson.cn>
Date: Thu, 21 May 2026 19:39:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260521080021.AD9EE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxjcIO7w5qWwSLAA--.64865S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurykCrWkGF4fZw1xWF4kGrX_yoW5AFWxpF
	Wxu3yrCFWkXrn2kFs7Kay8u39IvFZ5Gry7Jr1Yqry5Aw43urn3KF1fKrWfuas8Ar48Gr10
	qrs0vwn8Jan8ArXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Ui
	iSdUUUUU=

On 2026/5/21 下午4:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch adds a `nop` to the subprogram prologue to fix a non-existent tail call jump offset issue, as BPF tail calls can never target subprograms.
> --
> 
> commit d9b7854227e065cad33918647040161cb3ceac6c
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> LoongArch: BPF: Fix tail call prologue alignment
> 
> This commit adds a NOP instruction to the subprogram prologue in the LoongArch
> BPF JIT. The goal is to align the prologue size between main programs and
> subprograms so that tail calls skip the correct number of instructions.
> 
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index 24913dc7f4e83..aefe5fa1c5840 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -149,12 +149,15 @@ static void build_prologue(struct jit_ctx *ctx)
>>   		emit_insn(ctx, nop);
>>   
>>   	/*
>> -	 * First instruction initializes the tail call count (TCC)
>> -	 * register to zero. On tail call we skip this instruction,
>> -	 * and the TCC is passed in REG_TCC from the caller.
>> +	 * Initialize or align the TCC register slot.
>> +	 * For main programs, TCC is zeroed. For subprograms, a nop is emitted
>> +	 * to keep the prologue size consistent, ensuring tail calls skip the
>> +	 * correct number of instructions.
>>   	 */
>>   	if (is_main_prog)
>>   		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
>> +	else
>> +		emit_insn(ctx, nop);
> 
> [Severity: Low]
> Is this nop instruction and alignment actually necessary for tail calls?
> 
> BPF tail calls resolve their target programs exclusively from a
> BPF_MAP_TYPE_PROG_ARRAY map. Because subprograms do not have file descriptors,
> the verifier ensures that only main programs can be inserted into program
> array maps.
> 
> Since a tail call can never target a subprogram, it seems it will always
> unconditionally target a main program (which includes the TCC initialization
> instruction). Does this mean the existing JIT implementation already safely
> skips the main program's prologue, and this added nop provides no functional
> benefit?

Hi,

Thanks for the question. While it is true that a subprogram can never
be the destination (target) of a tail call, a subprogram can indeed
act as the originator (caller) of a tail call in combined bpf2bpf and
tail call scenarios.

In such complex mixed hierarchies, maintaining a strictly consistent
prologue structure and size between main programs and subprograms is
crucial. It ensures that the JIT compiler can deterministically
calculate stack frame offsets, TCC slot distances, and relative
entry-point jumps without generating misaligned or broken code
across different function frames.

Therefore, emitting this NOP is necessary to preserve text symmetry
and layout consistency in mixed call chains.

Thanks,
Tiezhu

