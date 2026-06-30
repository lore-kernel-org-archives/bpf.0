Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FB32367DF
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789610; cv=none; b=gcb5dUFGiVBSQL7n3WH2afDjixHFEavIWhT0VXAIVF8+tPVy6djSG9YUfhb2sqH49w9NVvsP3g6yShWg/TM7exlRwCbS6opljGpxSC/uMQGCPxdCLkqYOK2xpqnpxezyCrrqbQaayIpc87Y/gsK+xP7PzhDyTlac+pgC1IcIBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789610; c=relaxed/simple;
	bh=mUq3InlUgj+BAWa9s2S5mLTFpk5qAryF8o1OYoMXI5s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ozZfVMScQjwu9olljLPckraVbQ+3Kca7sKNHMF4qWYTKw1R9AYEZN774gZYNRYTCbaq27NMPFioKnPHJM8vKCOwoelSdi+2GnXKcfIL79PqYvv56Kgv7R3VGb3kHighCjbgrj/wivqacOgeaYlxx8vyyFGx17Ea0biqIhFBgeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxT+rlNUNqdHwZAA--.64316S3;
	Tue, 30 Jun 2026 11:20:05 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxSeDhNUNqDIy4AA--.22102S3;
	Tue, 30 Jun 2026 11:20:02 +0800 (CST)
Subject: Re: [PATCH v1 3/4] LoongArch: BPF: Refactor jump offset calculation
 in tail call
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260630022705.11536-1-yangtiezhu@loongson.cn>
 <20260630022705.11536-4-yangtiezhu@loongson.cn>
 <20260630024002.26F4D1F000E9@smtp.kernel.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <38d77460-2824-13e6-ef64-6732c60c30fb@loongson.cn>
Date: Tue, 30 Jun 2026 11:20:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260630024002.26F4D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeDhNUNqDIy4AA--.22102S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurykZryfuryUGF4kKrWfJFc_yoW5GFykpF
	Z0gwn3Aay7Wr1Dtanrt395X3WUtw1kGry7Gr1rGr10y3yYqr9FgFW5Ka15ua48Cw4kZw4S
	qFs0v34SvF4DAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

On 2026/6/30 上午10:40, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Spurious JIT compilation failure for large BPF programs with tail calls due to invalid jump offset calculation in the first JIT pass.
> --
> 
> commit c7d3e2cbf4a615b76ec73b1fff169ff7f13381b9
> Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> 
> LoongArch: BPF: Refactor jump offset calculation in tail call
> 
> This patch modifies the jump offset calculation in emit_bpf_tail_call()
> to use an absolute target reference anchor based on the next instruction
> offset, ensuring immediate offsets land precisely on instruction boundaries.
> 
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
> [ ... ]
>> @@ -310,12 +306,12 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
> [ ... ]
>>   	off = offsetof(struct bpf_array, map.max_entries);
>>   	emit_insn(ctx, ldwu, t1, a1, off);
>>   	/* bgeu $a2, $t1, jmp_offset */
>> +	jmp_offset = ctx->offset[insn + 1] - ctx->idx;
>>   	if (emit_tailcall_jmp(ctx, BPF_JGE, a2, t1, jmp_offset) < 0)
>>   		goto toofar;
> 
> [Severity: High]
> Does this calculation cause large BPF programs to fail JIT compilation during
> the first pass?
> 
> During the first JIT pass, ctx->offset[insn + 1] is not yet populated and will
> be 0. As a result, jmp_offset evaluates to -ctx->idx.
> 
> If ctx->idx exceeds 32767 for a large program, jmp_offset will fail the 16-bit
> bounds check inside emit_tailcall_jmp(), causing JIT compilation to abort
> prematurely.
> 
> Previously, jmp_offset used a small relative offset which safely fit within
> the 16-bit limit during the initial pass.

Thank you for catching this critical corner case, you are correct.

During Pass 1, ctx->offset[insn + 1] is uninitialized (0), making
jmp_offset = -ctx->idx. For large BPF programs, this negative offset
overflows the 16-bit range check inside emit_tailcall_jmp(), causing
the JIT compilation to abort prematurely.

To fix this cleanly without breaking any function signatures, we can
use ctx->image to detect Pass 1. Since conditional branch instructions
on LoongArch always have a fixed 4-byte size, using a safe dummy offset
(like 0) during Pass 1 will not affect the size estimation but will
successfully bypass the 16-bit bounds check.

I will send a v2 patch shortly with the following guard logic:

   jmp_offset = ctx->image ? (ctx->offset[insn + 1] - ctx->idx) : 0;

Thanks,
Tiezhu

