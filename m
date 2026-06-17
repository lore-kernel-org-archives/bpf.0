Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACFC2E1F0E;
	Wed, 17 Jun 2026 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679207; cv=none; b=duEz6aTMNnBEuPAUirOs21SNw8xxMRfANd1R08kebaN2V6AUcElEz0Rs5SVmIExByL7y46LsF1mfejojEG/nj13uzyaP9awx9jceAfnTXcffxGekhBglTb77p991Rk8cVKV8UpC49x004ZDtgoBLRcFaImOQWVS2lxqwZRbACdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679207; c=relaxed/simple;
	bh=H1X1/oNYM1aeqlFUyVZqyRGobeAlI7aFGCTriW22C44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZmONHAFbTr6hAGc+S4dRILjujDiJHY8NO01nsLvHL9z14Tz0GB8uzSK2Fm6MVm4E7T+sr/6HP4srtkrjIN67v3BfaWxE3dXLQTDoIjJtmGQa/4plfSr2LIfIaMuJoQWDjBkLRAX18Ps3o+51Dvam/VBgajfop5Sek0X7tAoBnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l7pba1O4; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l7pba1O4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=djA+SxTM/4DdX0nuhSS9rd5BRl3y7xbZwe5Na5XIBDQ=;
	b=l7pba1O4Jax4lanbsZdumec7DcFKMwARlx0KpuNousaYNfUrBf9Wx+Vh2Z0fpYcucI5n9WO8Z
	3twZ1jC6VjuG1jaZXqq9L8j5rLAwc+MJBKwKywMfXH1cq0wW9eE3WepYC5nOTcTNCLIABjO2Yc5
	7fr2PYmgDBIf9a0lxOZCkJ0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4ggDrJ3RjJz1K97S;
	Wed, 17 Jun 2026 14:45:20 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E3B4405D0;
	Wed, 17 Jun 2026 14:53:17 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Jun
 2026 14:53:16 +0800
Message-ID: <c20a7c0e-121f-474c-945a-2a4705a45bd5@huawei.com>
Date: Wed, 17 Jun 2026 14:53:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] riscv, bpf: Fix support for BPF_SDIV and
 BPF_SMOD in RV32 JIT
Content-Language: en-US
To: Kuan-Wei Chiu <visitorckw@gmail.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<eddyz87@gmail.com>, <memxor@gmail.com>, <luke.r.nels@gmail.com>,
	<xi.wang@gmail.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <alex@ghiti.fr>,
	<jserv@ccns.ncku.edu.tw>, <eleanor15x@gmail.com>, <marscheng@google.com>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260511221648.3251464-1-visitorckw@gmail.com>
 <20260511221648.3251464-2-visitorckw@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260511221648.3251464-2-visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


lgtm, just some nits

On 2026/5/12 6:16, Kuan-Wei Chiu wrote:
> The current rv32 bpf jit compiler incorrectly treats BPF_SDIV and
> BPF_SMOD as unsigned operations. The BPF instruction set allows
> signed division and modulo by reusing the BPF_DIV and BPF_MOD opcodes
> with the instruction offset set to 1.
> 
> Update the emit_alu_r32() function to accept an 'is_sdiv' variable and
> emit the correct div and rem instructions when the offset is 1.
> 
> Before this patch:
> [   44.161771] test_bpf: #165 ALU_SDIV_X: -6 / 2 = -3 jited:1 ret 2147483645 != -3 (0x7ffffffd != 0xfffffffd)FAIL (1 times)
> [   44.167385] test_bpf: #166 ALU_SDIV_K: -6 / 2 = -3 jited:1 ret 2147483645 != -3 (0x7ffffffd != 0xfffffffd)FAIL (1 times)
> [   44.171053] test_bpf: #169 ALU_SMOD_X: -7 % 2 = -1 jited:1 ret 1 != -1 (0x1 != 0xffffffff)FAIL (1 times)
> [   44.172081] test_bpf: #170 ALU_SMOD_K: -7 % 2 = -1 jited:1 ret 1 != -1 (0x1 != 0xffffffff)FAIL (1 times)
> 
> After this patch:
> [   16.002192] test_bpf: #165 ALU_SDIV_X: -6 / 2 = -3 jited:1 95 PASS
> [   16.002983] test_bpf: #166 ALU_SDIV_K: -6 / 2 = -3 jited:1 1059 PASS
> [   16.017167] test_bpf: #169 ALU_SMOD_X: -7 % 2 = -1 jited:1 136 PASS
> [   16.023002] test_bpf: #170 ALU_SMOD_K: -7 % 2 = -1 jited:1 109 PASS
> 
> Fixes: ec0e2da95f72 ("bpf: Support new signed div/mod instructions.")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp32.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
> index 592dd86fbf81..7396899ea276 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c
> @@ -509,7 +509,7 @@ static void emit_alu_r64(const s8 *dst, const s8 *src,
>   }
>   
>   static void emit_alu_r32(const s8 *dst, const s8 *src,
> -			 struct rv_jit_context *ctx, const u8 op)
> +			 struct rv_jit_context *ctx, const u8 op, bool is_sdiv)

let's combind `op` and `is_sdiv` to `const struct bpf_insn *insn`, and 
better to name `is_signed = insn->off == 1`

>   {
>   	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
>   	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
> @@ -539,10 +539,16 @@ static void emit_alu_r32(const s8 *dst, const s8 *src,
>   		emit(rv_mul(lo(rd), lo(rd), lo(rs)), ctx);
>   		break;
>   	case BPF_DIV:
> -		emit(rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
> +		if (is_sdiv)
> +			emit(rv_div(lo(rd), lo(rd), lo(rs)), ctx);
> +		else
> +			emit(rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
>   		break;
>   	case BPF_MOD:
> -		emit(rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
> +		if (is_sdiv)
> +			emit(rv_rem(lo(rd), lo(rd), lo(rs)), ctx);
> +		else
> +			emit(rv_remu(lo(rd), lo(rd), lo(rs)), ctx);

how about
emit(is_signed ? rv_rem(lo(rd) : rv_remu(lo(rd), lo(rd), lo(rs)), ctx)

>   		break;
>   	case BPF_LSH:
>   		emit(rv_sll(lo(rd), lo(rd), lo(rs)), ctx);
> @@ -959,6 +965,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	u8 code = insn->code;
>   	s16 off = insn->off;
>   	s32 imm = insn->imm;
> +	bool is_sdiv = false;
>   
>   	const s8 *dst = bpf2rv32[insn->dst_reg];
>   	const s8 *src = bpf2rv32[insn->src_reg];
> @@ -1041,7 +1048,9 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   			emit_imm32(tmp2, imm, ctx);
>   			src = tmp2;
>   		}
> -		emit_alu_r32(dst, src, ctx, BPF_OP(code));
> +		if ((BPF_OP(code) == BPF_DIV || BPF_OP(code) == BPF_MOD) && insn->off == 1)
> +			is_sdiv = true;
> +		emit_alu_r32(dst, src, ctx, BPF_OP(code), is_sdiv);
>   		break;
>   
>   	case BPF_ALU | BPF_MOV | BPF_K:
> @@ -1065,7 +1074,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		 * src is ignored---choose tmp2 as a dummy register since it
>   		 * is not on the stack.
>   		 */
> -		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code));
> +		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code), false);
>   		break;
>   
>   	case BPF_ALU | BPF_END | BPF_FROM_LE:
