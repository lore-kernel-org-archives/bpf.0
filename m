Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5111C2DB7AE;
	Mon,  6 Jul 2026 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783315569; cv=none; b=GUsAvlHHnG8/24iYYxY6+HnmTFfpd2cD8aGwVZcPM/ryG59XefuFVMtWgSeQm/co2fszogjULDvuGbhmYhc43sjzYdOYMjTIBMYrueDcuVyy/zy6rt9qt04+7W1S8RM6QFYYsuD8lGCqUXdbQu0/YgnzWYA2JbZWomkCpxXAnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783315569; c=relaxed/simple;
	bh=BpOqhf2DBMaU/iBSUNDq7CF3guAvCrG3i8k9G8jpM/E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LZVvkcSFTNrT1a0g6QRQ+sAKN922k9XZvQ6R7J6XGuunOOmKm33y21Gp+ciQMFLzrfEb6XGmD6Cx1vo7r341UlXegmJ68ndPTo2LBQ5H8+tNlIMN5RrIXdrrY9OkZBXdSVa6jU7PZ5lz9scyQU14cvSd7No5ISLPA08ewUUEvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx6vBsPEtqcUoAAA--.1484S3;
	Mon, 06 Jul 2026 13:26:04 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxHsdqPEtqSNcBAA--.11603S3;
	Mon, 06 Jul 2026 13:26:03 +0800 (CST)
Subject: Re: [PATCH v2 4/4] LoongArch: BPF: Implement branchless conditional
 move for TCC
To: bot+bpf-ci@kernel.org, chenhuacai@kernel.org, hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260706033906.1988-5-yangtiezhu@loongson.cn>
 <70c1acef9c4cb9c5e5374487db3f7ab57a10946dace0845097f3cc66863a83c9@mail.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <28a0b043-a752-7308-c8b5-037b76a5a71d@loongson.cn>
Date: Mon, 6 Jul 2026 13:26:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <70c1acef9c4cb9c5e5374487db3f7ab57a10946dace0845097f3cc66863a83c9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHsdqPEtqSNcBAA--.11603S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWryfXF15XF18XF4DGFW7Awc_yoWrGF17p3
	48XF48tr4kXF17C3ZrJa18ur9xAwsay3y3WF15GrZYyas8ZryFq3W8Kr13uFW5Ar13Z340
	qrn0yFnrZa1DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU7T
	mhUUUUU

On 2026/7/6 下午12:30, bot+bpf-ci@kernel.org wrote:
>> The current implementation handles combined bpf2bpf and tail calls by
>> checking at runtime whether REG_TCC holds a count or an address via a
>> conditional jump (BPF_JGT against 33). This adds non-negligible branch
>> prediction overhead in the hot path of tail call execution.
>> To eliminate this runtime conditional branch in prologue, refactor the
>> logic of prepare_bpf_tail_call_cnt() with a branchless conditional move
>> mechanism using unsigned comparison and mask instructions.

...

> 
> This isn't a bug, but the closing lines:
> 
>> When exposed to complex bpf2bpf + tailcall interleaved control flows,
>> where inputs shuffle dynamically between a scalar count (0 to 33) and
>> a massive kernel pointer address, clear improvements are demonstrated.
>> Furthermore, the optimization significantly eliminated uncertainty in
>> the execution path, making the performance more stable and predictable.
> 
> state performance improvements without any number or benchmark behind them,
> and the rationale (removing the runtime branch from the prologue hot path)
> is already covered earlier in the message.  Could these closing claims be
> backed by a concrete measurement, or trimmed?

I will trim the commit message in v3.

>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index 8d6738103f59..b5419cafc984 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -52,50 +52,56 @@ static void prepare_bpf_tail_call_cnt(struct jit_ctx *ctx, int *store_offset)
> 
> [ ... ]
> 
>> +		/*
>> +		 * Branchless classification and blending:
>> +		 *
>> +		 * In combined bpf2bpf and tailcall scenarios, REG_TCC can carry
>> +		 * either a scalar count (0 to 33) or an inherited kernel pointer address.
>> +		 *
>> +		 * Entrance status for a main program based on REG_TCC physical content:
>> +		 * 1) Initial Entry (Scalar): Enter via a standard event, where REG_TCC
>> +		 *    is initialized to a pure scalar 0.
>> +		 * 2) Inherited Entry (Scalar): Enter via a flat main-to-main tail call,
>> +		 *    where REG_TCC carries an accumulated scalar count (1 to 33) reloaded
>> +		 *    from the prior stack frame.
>> +		 * 3) Inherited Entry (Pointer): Enter via a tail call from a subprogram,
>> +		 *    where REG_TCC inherits and carries a massive kernel pointer address
>> +		 *    reloaded from the prior stack frame.
>> +		 *
>> +		 * sltui:   Identify the type of REG_TCC.
>> +		 *          If REG_TCC < MAX_TAIL_CALL_CNT + 1 (scalar 0~33), sets T8 = 1.
>> +		 *          If REG_TCC >= MAX_TAIL_CALL_CNT + 1 (kernel pointer), sets T8 = 0.
>> +		 *
>> +		 * maskeqz: Handle the local stack pointer (T7).
>> +		 *          If T8 == 1, keeps T7 intact.
>> +		 *          If T8 == 0, clears T7 to 0.
>> +		 *
>> +		 * masknez: Handle the incoming REG_TCC to prevent register pollution.
>> +		 *          If T8 == 1, clears REG_TCC to 0 (erasing 1~33 scalars).
>> +		 *          If T8 == 0, keeps the massive kernel pointer intact.
>> +		 *
>> +		 * or:      Combine the results.
>> +		 *          Scalar Case:  REG_TCC = 0 | T7       -> Clean local stack pointer.
>> +		 *          Pointer Case: REG_TCC = REG_TCC | 0  -> Clean inherited global pointer.
>>   		 */
>> +		emit_insn(ctx, sltui, LOONGARCH_GPR_T8, REG_TCC, MAX_TAIL_CALL_CNT + 1);
>> +		emit_insn(ctx, maskeqz, LOONGARCH_GPR_T7, LOONGARCH_GPR_T7, LOONGARCH_GPR_T8);
>> +		emit_insn(ctx, masknez, REG_TCC, REG_TCC, LOONGARCH_GPR_T8);
>> +		emit_insn(ctx, or, REG_TCC, REG_TCC, LOONGARCH_GPR_T7);
> 
> This isn't a bug, but the comment narrates each of the four emitted
> instructions line by line, and the sltui/maskeqz/masknez/or walk-through
> largely restates the entrance-status text already present in the commit
> message as well as the code right below it.  Could this be condensed?

I will condense the code comments, only remain necessary in v3.

Thanks,
Tiezhu

