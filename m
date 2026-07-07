Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C7E3F54BE
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421283; cv=none; b=qNdGEV8vtow/EWSqqs5F9wJheR/j0iAJNOLb0kfoJnKZadmd5NYhdxYekSUpYGmUbvILkndyA3vgXCOzjky4T3d/2eQKrtZLAJZ5fVtP+XgovGgcrWPTEAUIkOjTbv1rjKWclIljg2EqhbgozKIgeMivGa4JSThsc3c0tZcQKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421283; c=relaxed/simple;
	bh=sUOvuXt5sHvq2oLawocZrKJ08knavUH3uTHQEhEZFIc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qD21WQXzOZKTiPMN2gweQdwnDnKgXqJ63pH0r0o61hk97O8STY7kF4Js9EfOuvYQ++//xMPDR0lW2DmrsUurjTs9urtd2aJ2nOBF720ET3ILToaCCFF5kW7UbHvePHyJRVWuJiNPbTDYCVxkiWWgg9BgPtsHzvq3nCe5Lv0leyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxNOpc2Uxq5eMAAA--.2447S3;
	Tue, 07 Jul 2026 18:47:56 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxbsVZ2UxqaNADAA--.20854S3;
	Tue, 07 Jul 2026 18:47:53 +0800 (CST)
Subject: Re: [PATCH v3 1/4] LoongArch: BPF: Optimize redundant TCC loads in
 epilogue
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260707101508.32283-1-yangtiezhu@loongson.cn>
 <20260707101508.32283-2-yangtiezhu@loongson.cn>
 <20260707102642.AEF191F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <aa66f92d-5faa-fb92-14bf-2f81658015c7@loongson.cn>
Date: Tue, 7 Jul 2026 18:47:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707102642.AEF191F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxbsVZ2UxqaNADAA--.20854S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxuryDZw1fGFyxGr1kKrW5CFX_yoWrJF1rpr
	yvk3WxAF4kXr15tFs7tanrKr97tasa9ry3Wr1UGrZakr909rn3Wa43Kw4Y9a4kXwn5Ar1I
	qFZ09FsI9a1DZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
	xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r
	17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	riSlUUUUU

On 2026/7/7 下午6:26, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The macro BPF_TAIL_CALL_CNT_PTR_STACK_OFF does not account for the BPF Arena register, leading to an incorrect stack offset calculation and a deterministic kernel panic on tail calls when arena is used.
> --
> 
> --- Patch [1]: [PATCH v3 1/4] LoongArch: BPF: Optimize redundant TCC loads in epilogue ---
> commit eabfba52164a1855119336bb138d22f9f54aedfe
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
>      LoongArch: BPF: Optimize redundant TCC loads in epilogue
>      
>      The legacy epilogue implementation pops the tail call counter (TCC)
>      context via a redundant double-load pattern. It first decrements the
>      load_offset by 2 slots to fetch 'tcc_ptr', and then immediately bumps
>      it back up by 1 slot to load the original 'tcc' value into REG_TCC,
>      unnecessarily overwriting the register.
>      
>      Optimize this sequence by adjusting the load_offset by only 1 slot.
>      This aligns the offset directly with the higher stack slot containing
>      the entry TCC counter (or caller state), allowing us to restore the
>      REG_TCC register safely with a single load.
> 
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index 2738b4db11653..93a1813122564 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -246,14 +246,8 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
>>   		emit_insn(ctx, ldd, REG_ARENA, LOONGARCH_GPR_SP, load_offset);
>>   	}
>>   
>> -	/*
>> -	 * When push into the stack, follow the order of tcc then tcc_ptr.
>> -	 * When pop from the stack, first pop tcc_ptr then followed by tcc.
>> -	 */
>> -	load_offset -= 2 * sizeof(long);
>> -	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
>> -
>> -	load_offset += sizeof(long);
>> +	/* Only restore the TCC state into REG_TCC from the higher slot */
>> +	load_offset -= sizeof(long);
>>   	emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, load_offset);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while looking at the dynamic
> stack offset handling for REG_ARENA here, I noticed an issue in how the stack
> offset is calculated for the tail call counter pointer.
> 
> While the prologue and epilogue dynamically adjust load_offset for REG_ARENA
> (shifting the offsets down by 8 bytes when ctx->arena_vm_start is true),
> the macro BPF_TAIL_CALL_CNT_PTR_STACK_OFF uses a hardcoded subtraction:
> 
> arch/loongarch/net/bpf_jit.c:
> #define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
> 
> When a BPF program using the BPF arena makes a tail call, emit_bpf_tail_call()
> uses this macro to calculate tcc_ptr_off:
> 
> arch/loongarch/net/bpf_jit.c:emit_bpf_tail_call() {
>      ...
>      int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
>      ...
>      emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
>      emit_insn(ctx, ldd, t3, REG_TCC, 0);
>      ...
> }
> 
> Because the hardcoded macro doesn't account for the 8-byte shift from
> REG_ARENA, it will evaluate to the offset of the integer tail call count (tcc)
> instead of tcc_ptr.
> 
> Could this lead to the JIT loading the integer count (often 0) into REG_TCC
> and dereferencing it as a pointer, resulting in a kernel panic?

This pre-existing issue is fixed in the next patch of this series
([PATCH v3 2/4] LoongArch: BPF: Move arena register slot below TCC context)
by moving the arena slot below the TCC context to keep the tcc_ptr
offset constant.

Thanks,
Tiezhu

