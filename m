Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A689403EAE
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678468; cv=none; b=Es11+weUBsNNEmU349PsxrBIaty7xfVa3/KQPuxN0idhn1g8255jVALCKKMiCra0tFp95APF9DA9fHxiM3oxWGko+I5ajTD8GaiqmlLNpYYfjnlCKc5eqRDgZQNO5juxAu/VIKS39T/U553yyI193pJoZ4jxoLgWdpAyOWzi6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678468; c=relaxed/simple;
	bh=nr/B9v+znqPbQQBFnbgGUbWVJlu/bIZPW7SIDkie15I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TXtPqoq/VqzR4P0iAO/uVrnNa0tDSUTejWWD+6itXUmjuk8maTryJ069Gh4Agw3tjc68OVhausJoW86J1maLSPrdOcsktOqqZX0hb7vjGo1bLirMYRMpEY6bObIaLOer9YydjHX5IDSIRV2E7+zkdQgOPFGJATG8R+NTe2ejrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxCOv+xVBqIDsCAA--.9365S3;
	Fri, 10 Jul 2026 18:14:23 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxEuT7xVBqBTQIAA--.25342S2;
	Fri, 10 Jul 2026 18:14:19 +0800 (CST)
Subject: Re: [PATCH bpf] LoongArch: bpf: zero-extend signed ALU32 div/mod
 results
To: Nicholas Dudar <main.kalliope@gmail.com>, bpf@vger.kernel.org
Cc: hengqi.chen@gmail.com, loongarch@lists.linux.dev,
 Huacai Chen <chenhuacai@kernel.org>
References: <20260709135344.1744677-1-main.kalliope@gmail.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <bca7ef40-932f-1841-16fd-6da4197678c5@loongson.cn>
Date: Fri, 10 Jul 2026 18:14:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260709135344.1744677-1-main.kalliope@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxEuT7xVBqBTQIAA--.25342S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr47tFWxCw47ArWxJw1DArc_yoWrJr1kpF
	sxGrsYkFW8Jr1Yqa4kJ39rXr42ya13ArZ3JwnFqrWkAr9aqry8WryfKr1j9ay3Z3s3K3Wk
	Z3Wqkrn0ga9rAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjwZcUUUUU=

Cc: Huacai Chen <chenhuacai@kernel.org> loongarch@lists.linux.dev

On 2026/7/9 下午9:53, Nicholas Dudar wrote:
> ALU32 operations write a 32-bit result and leave the upper 32 bits of
> the BPF register zero. The LoongArch JIT sign-extends the result of
> signed ALU32 BPF_DIV and BPF_MOD (off=1), so a negative 32-bit quotient
> or remainder leaves bits 63:32 set in JITted code while the verifier
> and interpreter model those bits as zero.
> 
> Keep sign-extension on the operands, which signed divide needs, and
> zero-extend the ALU32 result after the divide or modulo instruction,
> matching the unsigned ALU32 div/mod paths and every other ALU32
> operation in this JIT.
> 
> Fixes: 2425c9e002d2 ("LoongArch: BPF: Support signed div instructions")
> Fixes: 7b6b13d32965 ("LoongArch: BPF: Support signed mod instructions")
> Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
> Reported privately to security@kernel.org first; posting to the list
> at the maintainer's request. The patch is the same.
> 
>   arch/loongarch/net/bpf_jit.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 2738b4db1165..c91d474faba7 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -835,7 +835,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   			move_reg(ctx, t1, src);
>   			emit_sext_32(ctx, t1, is32);
>   			emit_insn(ctx, divd, dst, dst, t1);
> -			emit_sext_32(ctx, dst, is32);
> +			emit_zext_32(ctx, dst, is32);
>   		}
>   		break;
>   
> @@ -852,7 +852,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   			emit_sext_32(ctx, t1, is32);
>   			emit_sext_32(ctx, dst, is32);
>   			emit_insn(ctx, divd, dst, dst, t1);
> -			emit_sext_32(ctx, dst, is32);
> +			emit_zext_32(ctx, dst, is32);
>   		}
>   		break;
>   
> @@ -870,7 +870,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   			move_reg(ctx, t1, src);
>   			emit_sext_32(ctx, t1, is32);
>   			emit_insn(ctx, modd, dst, dst, t1);
> -			emit_sext_32(ctx, dst, is32);
> +			emit_zext_32(ctx, dst, is32);
>   		}
>   		break;
>   
> @@ -887,7 +887,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>   			emit_sext_32(ctx, t1, is32);
>   			emit_sext_32(ctx, dst, is32);
>   			emit_insn(ctx, modd, dst, dst, t1);
> -			emit_sext_32(ctx, dst, is32);
> +			emit_zext_32(ctx, dst, is32);
>   		}
>   		break;
>   
> 
> base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53

Here is the link:
https://lore.kernel.org/bpf/20260709135344.1744677-1-main.kalliope@gmail.com/

When executing "sudo modprobe test_bpf" on LoongArch with v7.2-rc1,
there are 4 failed testcases without this patch:

test_bpf: #811 ALU32_SDIV_K: registers jited:1 ret 1354 != 1 (0x54a != 
0x1)FAIL (1 times)
test_bpf: #812 ALU32_SMOD_K: registers jited:1 ret 1354 != 1 (0x54a != 
0x1)FAIL (1 times)
test_bpf: #875 ALU32_SDIV_K: all immediate value magnitudes jited:1 ret 
0 != 1 (0x0 != 0x1)FAIL (1 times)
test_bpf: #876 ALU32_SMOD_K: all immediate value magnitudes jited:1 ret 
0 != 1 (0x0 != 0x1)FAIL (1 times)

But the failures were not present in v7.1, these regressions were
exposed by commit c8f0ee969f76 ("bpf: Exhaustive test coverage for
signed division and modulo"), which added these cases in v7.2-rc1.

With the provided patch, all tests pass as expected.

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks,
Tiezhu

