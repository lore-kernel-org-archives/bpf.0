Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C73BA220;
	Mon,  6 Jul 2026 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783313725; cv=none; b=KQf51tXlRVLvb7gcAsESg6dvFamSbLKXClwje9m4RCKJEDoO9PHvMimCwzYYnYtklVLxRKH2lpxS4UtaOto8V2RvTMxjytpSd//6F/b1+k/dxsjIwfi2SbX5UcQmfoni2fyWJzdr6UjJXih0ajoqOXq5zKepvirZml8rZ2lu0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783313725; c=relaxed/simple;
	bh=CK8/oxY+WDje9wxcbiIyirckvoFdemiA7l7C5VZBgi0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=M+R2XLwRtu29GcPWMsmisBPX2OL6fIuvaNqHgh5BpyboedzQuIJoAV1drhq/5FAMPuMOV5ioVM75OqKYbmDRYLf4czBjKHaikzwfx3k1WLKX5wTF4UOGHTOAl0u848tJjlE/MAIw80XkQWyjMErSY5YYyfYCEc1wpMNKELBWoRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bx1+o3NUtqg0gAAA--.1410S3;
	Mon, 06 Jul 2026 12:55:19 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxIuQyNUtq5c8BAA--.11146S3;
	Mon, 06 Jul 2026 12:55:16 +0800 (CST)
Subject: Re: [PATCH bpf-next v2 01/11] LoongArch: BPF: Fix tail call count
 pointer offset for arena programs
To: George Guo <dongtai.guo@linux.dev>, Huacai Chen <chenhuacai@kernel.org>,
 Hengqi Chen <hengqi.chen@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 George Guo <guodongtai@kylinos.cn>, bpf@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260702022322.51033-1-dongtai.guo@linux.dev>
 <20260702022322.51033-2-dongtai.guo@linux.dev>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d7f2c8d3-4a46-e978-5cce-f59b84e632f0@loongson.cn>
Date: Mon, 6 Jul 2026 12:55:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260702022322.51033-2-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuQyNUtq5c8BAA--.11146S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFyDWF47ur45AF48Jr18WFX_yoWrCF1xpr
	47ZF47KrWkXF1xAFsrG3y2vw1rKws3ZrW3GF1UC34rCF9Ivr1fWFyFga15WFy5Cw48tr18
	Xrs09r43uan8A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU7W
	SoDUUUU

On 2026/7/2 上午10:23, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> The tail call count (TCC) and its pointer occupy the two deepest slots of
> the callee-saved area set up by build_prologue(). An arena program reserves
> one extra word for REG_ARENA (arena_vm_start) right above them:
> 
>      ra fp s0 s1 s2 s3 s4 s5      <- 8 words
>      [ REG_ARENA ]                <- only if ctx->arena_vm_start
>      tail_call_cnt
>      tail_call_cnt_ptr            <- loaded on tail call / bpf2bpf call
> 
> BPF_TAIL_CALL_CNT_PTR_STACK_OFF() hardcodes the pointer at
> round_up(stack, 16) - 80, which is only correct when REG_ARENA is absent.
> For an arena program the extra word shifts every slot below it down by 8
> bytes, so the macro resolves to the tail_call_cnt slot (the counter value)
> instead of tail_call_cnt_ptr. The JIT then loads the counter value and
> dereferences it as the TCC pointer, corrupting memory or panicking the
> kernel whenever an arena program performs a tail call or a bpf2bpf call.
> 
> Replace the macro with a helper that accounts for the REG_ARENA slot,
> mirroring the reservation logic in build_prologue().
> 
> This is the same fix already posted separately for the bpf tree; it is
> included here, as patch 1/11, only so the rest of this series applies
> and builds cleanly on top of it. It can be dropped from this series
> once it lands via the bpf tree.
> 
>    https://lore.kernel.org/all/20260629085511.359546-1-dongtai.guo@linux.dev
> 
> Fixes: ef54c517a937 ("LoongArch: BPF: Implement PROBE_MEM32 pseudo instructions")
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>   arch/loongarch/net/bpf_jit.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index ad7e28375aa9..5e34e9e3f508 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -25,7 +25,23 @@
>   
>   #define REG_TCC		LOONGARCH_GPR_A6
>   #define REG_ARENA	LOONGARCH_GPR_S6 /* For storing arena_vm_start */
> -#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack) (round_up(stack, 16) - 80)
> +
> +static int tail_call_cnt_ptr_stack_off(struct jit_ctx *ctx)
> +{
> +	/* Ten words are pushed below the BPF stack: ra, fp, s0-s5, and the
> +	 * tail call count plus its pointer, which occupy the two deepest
> +	 * slots of the callee-saved area.
> +	 */
> +	int offset = sizeof(long) * 10;
> +
> +	/* An arena program reserves one extra word above them (REG_ARENA),
> +	 * which pushes the tail call count pointer down by one slot.
> +	 */
> +	if (ctx->arena_vm_start)
> +		offset += sizeof(long);
> +
> +	return round_up(ctx->stack_size, 16) - offset;
> +}

This introduces a runtime helper to dynamically
calculate the stack offset. If another optional
slot is introduced in the future, this helper
will need further adjustments.

>   static const int regmap[] = {
>   	/* return value from in-kernel function, and exit value for eBPF program */
> @@ -291,7 +307,7 @@ bool bpf_jit_supports_far_kfunc_call(void)
>   static int emit_bpf_tail_call(struct jit_ctx *ctx, int insn)
>   {
>   	int off, tc_ninsn = 0;
> -	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
> +	int tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
>   	u8 a1 = LOONGARCH_GPR_A1;
>   	u8 a2 = LOONGARCH_GPR_A2;
>   	u8 t1 = LOONGARCH_GPR_T1;
> @@ -1181,7 +1197,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   			return ret;
>   
>   		if (insn->src_reg == BPF_PSEUDO_CALL) {
> -			tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(ctx->stack_size);
> +			tcc_ptr_off = tail_call_cnt_ptr_stack_off(ctx);
>   			emit_insn(ctx, ldd, REG_TCC, LOONGARCH_GPR_SP, tcc_ptr_off);
>   		}
>   

Please see the following simple and long-term
solution, just move the arena slot below TCC
context slots, this ensures a constant offset,
reducing complex runtime calculations and
eliminating extra instructions.

LoongArch: BPF: Optimize redundant TCC loads in epilogue
https://lore.kernel.org/loongarch/20260630022705.11536-2-yangtiezhu@loongson.cn/

LoongArch: BPF: Move arena register slot below TCC context
https://lore.kernel.org/loongarch/20260630022705.11536-3-yangtiezhu@loongson.cn/

Thanks,
Tiezhu

