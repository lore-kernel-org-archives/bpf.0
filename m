Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B716340DB8;
	Sat, 23 May 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779527958; cv=none; b=iKFsdq/6N92uOHVCv8X9+JaAT1LH0n37dMKU7cVi92i7s42PYJrHzXUz5OkQphwUg9trtN1N9ehXIBVfkSplPPrr4zzZOQE/7qSFckyE7KnFUtk72a0DnKtJsB0kksaebYYPK9pV+ypEfgDB1khjMxZb1KszJTPZ407yQtDiD8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779527958; c=relaxed/simple;
	bh=OcXvGhCIx0gnN9hZgqDI0XkbVbhmCU2xUKZvmj3bmmY=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L1xdoAdpy8gFFrMy7pq+D+znFvzsrpa/S2yhnPotV3yAcKQ5xsRRNV6d5m26kan20pKb4LhI0PST+bDvRmsCbGTtRvuDBtuy24T+weghFZRNyU2EfrI+pP9mN4o/Jdq7luEKhO7syjdTM3Qt6gsUls+X869pkWQWjzxelCQfJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx4eoRcRFqBqMMAA--.36613S3;
	Sat, 23 May 2026 17:19:13 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxfcIPcRFqjbiNAA--.4434S3;
	Sat, 23 May 2026 17:19:12 +0800 (CST)
Subject: Re: [PATCH v1 1/3] LoongArch: BPF: Fix tail call prologue alignment
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>, Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260521070128.28086-1-yangtiezhu@loongson.cn>
 <20260521070128.28086-2-yangtiezhu@loongson.cn>
Message-ID: <136ca454-80d6-3373-be21-d55a7de61412@loongson.cn>
Date: Sat, 23 May 2026 17:19:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260521070128.28086-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxfcIPcRFqjbiNAA--.4434S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF47Zry7ur4kWFyrtw4fWFX_yoWrCr45pF
	Wxuws5CrWvgr17CF17tw48Wr4ayFZ5GrW7WryUZ345Cr43ur92gF1fKay3uF98Ar48AF1F
	qr1Yyw1Y9F4DA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUU
	UUU==

On 2026/5/21 下午3:01, Tiezhu Yang wrote:
> Currently, the LoongArch BPF JIT assumes a fixed number of instructions to
> skip when performing a tail call, but actually it does not account for the
> difference between the main programs and the subprograms. The subprograms
> do not initialize the Tail Call Count (TCC), leading to an incorrect jump
> offset that skips functional instructions (like stack adjustment).
> 
> To fix this issue, add a NOP instruction in the subprogram prologue where
> the TCC initialization would normally be. This ensures that both the main
> programs and the subprograms have consistent prologue layouts, allowing
> tail calls to always land on the correct instruction regardless of the
> target program type.
> 
> Fixes: c0fcc955ff82 ("LoongArch: BPF: Fix the tailcall hierarchy")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/net/bpf_jit.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 24913dc7f4e8..aefe5fa1c584 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -149,12 +149,15 @@ static void build_prologue(struct jit_ctx *ctx)
>   		emit_insn(ctx, nop);
>   
>   	/*
> -	 * First instruction initializes the tail call count (TCC)
> -	 * register to zero. On tail call we skip this instruction,
> -	 * and the TCC is passed in REG_TCC from the caller.
> +	 * Initialize or align the TCC register slot.
> +	 * For main programs, TCC is zeroed. For subprograms, a nop is emitted
> +	 * to keep the prologue size consistent, ensuring tail calls skip the
> +	 * correct number of instructions.
>   	 */
>   	if (is_main_prog)
>   		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
> +	else
> +		emit_insn(ctx, nop);
>   
>   	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);

IMO, the code itself looks good, but the code comment and the commit
message are not accurate, I will send v2 next week, something like this:

----->8-----
LoongArch: BPF: Keep prologue size consistent

The BPF JIT assumes consistent prologue size to preserve text symmetry
and layout alignment across different function frames. But the current
JIT implementation emits a shortened prologue for subprograms, because
it skips the Tail Call Count (TCC) initialization required only by main
programs, resulting in a layout difference.

A tail call can never target a subprogram because the verifier strictly
prevents subprograms from being inserted into a BPF_MAP_TYPE_PROG_ARRAY.
Nevertheless, keeping the prologue size consistent is still vital for the
JIT infrastructure. Without this symmetry, either dynamic text patching
or reliable stack unwinding can miscalculate instruction boundaries,
leading to a kernel crash.

Fix this by emitting a NOP instruction in the subprogram prologue where
the TCC initialization would normally be. This ensures that both main
programs and subprograms keep the prologue size consistent, preserving
text symmetry and layout alignment across all function frames.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
  arch/loongarch/net/bpf_jit.c | 9 ++++++---
  1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..976383a859e1 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -149,12 +149,15 @@ static void build_prologue(struct jit_ctx *ctx)
  		emit_insn(ctx, nop);

  	/*
-	 * First instruction initializes the tail call count (TCC)
-	 * register to zero. On tail call we skip this instruction,
-	 * and the TCC is passed in REG_TCC from the caller.
+	 * Initialize or align the TCC register slot.
+	 * For main programs, TCC is zeroed. For subprograms, a NOP is emitted
+	 * to keep the prologue size consistent, preserving text symmetry and
+	 * layout alignment across different function frames.
  	 */
  	if (is_main_prog)
  		emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, 0);
+	else
+		emit_insn(ctx, nop);

  	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);

-- 

Thanks,
Tiezhu

