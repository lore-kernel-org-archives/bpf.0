Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D2637D10A;
	Tue, 14 Jul 2026 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996478; cv=none; b=Yqt8evsppsIdVuiAqFb8K3CFcZFK8rQSDtwZbcMmaCzvpXu3fzilJPL6apikc+L3SgqGt6k5p/50CpYjtNoPC7FwREI73Xt6o8QT2i+bZUuuyfCYqsHr0fGUL5ShnXqAEq0kUi90YRGzeRsMnFLQrjgvXgm4QdNY4JoUQPyihXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996478; c=relaxed/simple;
	bh=8YipGl7Qmx5gEZoE/bx+sZjm4SStI1merlpCJG6NGN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G0EOjSlLBXxqONorwAyz5x0DYFfLkppRcJ3yHOoi6gokCAsb+oem7E52kvoFRhLhb5x+SneL7HYiUIhP/C+xAo8TB7HtB8RHJGDGs12Fr5XdXWwBx11HNJMZeI8V9vt7UKRdLtQfbUsetyoKZsbc4elUxU/AynC1+QCh3XXPnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0Yqbc9OD; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0Yqbc9OD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qqpE1DPNHlP97IVzgSIh0XiGAFcsNkwfTot6IyvEl+o=;
	b=0Yqbc9OD3qlAoEoRmkH9CEhcVEtRveFLplL1WmrNIYlNXc62kAQw6oZLxvd+Ottg2UxuDqnSt
	lQsw3TGHx7uigsUltOwvigeeDplpWzGWa1bV5ireMh+eDiILP85+KtEJ1z+lrfu38B8n8d3AnnJ
	mSrLJyksADpfunCvW9A1JDo=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gzjnk1p6Xz1cyVb;
	Tue, 14 Jul 2026 10:25:14 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CB344056C;
	Tue, 14 Jul 2026 10:34:30 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 14 Jul
 2026 10:34:29 +0800
Message-ID: <45db6d96-9cac-46e1-ba86-3d3552efbdb8@huawei.com>
Date: Tue, 14 Jul 2026 10:34:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/3] riscv, bpf: Add 32 bit atomic operations
 to RV32 JIT
Content-Language: en-US
To: Kuan-Wei Chiu <visitorckw@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>, <luke.r.nels@gmail.com>, <xi.wang@gmail.com>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <emil@etsalapatis.com>, <alex@ghiti.fr>,
	<jserv@ccns.ncku.edu.tw>, <eleanor15x@gmail.com>, <marscheng@google.com>,
	<bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260714002451.4091139-1-visitorckw@gmail.com>
 <20260714002451.4091139-4-visitorckw@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260714002451.4091139-4-visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/7/14 8:24, Kuan-Wei Chiu wrote:
> The RV32 BPF JIT compiler currently only supports the BPF_ADD atomic
> operation. Other 32 bit atomic operations (and, or, xor, xchg) and
> their BPF_FETCH variants are not supported and gracefully fall back to
> the interpreter.
> 
> Since the RISC-V A extension is required for Linux on RV32, we can
> natively support these 32-bit BPF atomic operations by mapping them
> directly to the corresponding RISC-V amo*.w instructions.
> 
> Implement BPF_ADD, BPF_AND, BPF_OR, BPF_XOR, and BPF_XCHG with and
> without BPF_FETCH. BPF_CMPXCHG requires a more complex lr.w/sc.w
> loop and is left to fall back to the interpreter.
> 
> Before this patch:
> [  138.862161] test_bpf: Summary: 1054 PASSED, 0 FAILED, [843/1042 JIT'ed]
> 
> After this patch:
> [  157.024124] test_bpf: Summary: 1054 PASSED, 0 FAILED, [902/1042 JIT'ed]
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp32.c | 64 +++++++++++++++++++++++++++------
>   1 file changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
> index 39e2b0b907dc..a9e0bd5cc81d 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c
> @@ -874,14 +874,58 @@ static int emit_load_r64(const s8 *dst, const s8 *src, s16 off,
>   	return 0;
>   }
>   
> -static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
> -			  struct rv_jit_context *ctx, const u8 size,
> -			  const u8 mode)
> +static int emit_bpf_atomic(s8 dst, const s8 *src, const s8 *rs,
> +			   struct rv_jit_context *ctx,
> +			   const struct bpf_insn *insn)
> +{
> +	s32 imm = insn->imm;
> +	bool is_fetch = (imm & BPF_FETCH) || (imm == BPF_XCHG);
> +	s8 fetch_reg = is_fetch ? lo(rs) : RV_REG_ZERO;
> +	int aq = is_fetch ? 1 : 0;
> +	int rl = is_fetch ? 1 : 0;
> +
> +	switch (imm) {
> +	case BPF_ADD:
> +	case BPF_ADD | BPF_FETCH:
> +		emit(rv_amoadd_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
> +		break;
> +	case BPF_AND:
> +	case BPF_AND | BPF_FETCH:
> +		emit(rv_amoand_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
> +		break;
> +	case BPF_OR:
> +	case BPF_OR | BPF_FETCH:
> +		emit(rv_amoor_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
> +		break;
> +	case BPF_XOR:
> +	case BPF_XOR | BPF_FETCH:
> +		emit(rv_amoxor_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
> +		break;
> +	case BPF_XCHG:
> +		emit(rv_amoswap_w(fetch_reg, lo(rs), dst, aq, rl), ctx);
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	if (is_fetch) {
> +		emit(rv_addi(hi(rs), RV_REG_ZERO, 0), ctx);
> +		bpf_put_reg64(src, rs, ctx);
> +	}
> +	return 0;
> +}
> +
> +static int emit_store_r64(const s8 *dst, const s8 *src,
> +			  struct rv_jit_context *ctx,
> +			  const struct bpf_insn *insn)
>   {
>   	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
>   	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
>   	const s8 *rd = bpf_get_reg64(dst, tmp1, ctx);
>   	const s8 *rs = bpf_get_reg64(src, tmp2, ctx);
> +	u8 size = BPF_SIZE(insn->code);
> +	u8 mode = BPF_MODE(insn->code);
> +	s16 off = insn->off;
>   
>   	if (mode == BPF_ATOMIC && size != BPF_W)
>   		return -1;
> @@ -901,9 +945,9 @@ static int emit_store_r64(const s8 *dst, const s8 *src, s16 off,
>   		case BPF_MEM:
>   			emit(rv_sw(RV_REG_T0, 0, lo(rs)), ctx);
>   			break;
> -		case BPF_ATOMIC: /* Only BPF_ADD supported */
> -			emit(rv_amoadd_w(RV_REG_ZERO, lo(rs), RV_REG_T0, 0, 0),
> -			     ctx);
> +		case BPF_ATOMIC:
> +			if (emit_bpf_atomic(RV_REG_T0, src, rs, ctx, insn))
> +				return -1;
>   			break;
>   		}
>   		break;
> @@ -1303,21 +1347,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   			src = tmp2;
>   		}
>   
> -		if (emit_store_r64(dst, src, off, ctx, BPF_SIZE(code),
> -				   BPF_MODE(code)))
> +		if (emit_store_r64(dst, src, ctx, insn))
>   			return -1;
>   		break;
>   
>   	case BPF_STX | BPF_ATOMIC | BPF_W:
> -		if (insn->imm != BPF_ADD) {
> +		if (insn->imm == BPF_CMPXCHG) {
>   			pr_info_once(
>   				"bpf-jit: not supported: atomic operation %02x ***\n",
>   				insn->imm);
>   			return -EFAULT;
>   		}
>   
> -		if (emit_store_r64(dst, src, off, ctx, BPF_SIZE(code),
> -				   BPF_MODE(code)))
> +		if (emit_store_r64(dst, src, ctx, insn))
>   			return -1;
>   		break;
>   

looks quite good to me, thanks

Reviewed-by: Pu Lehui <pulehui@huawei.com>


