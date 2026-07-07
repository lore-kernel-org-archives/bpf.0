Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67237233955;
	Tue,  7 Jul 2026 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783390926; cv=none; b=WMuBORLPlqFcCRGEg/89CwLVZnQjhLadjrCWR25LDVeWd2UXb91QJHigGO9s/EetMsDkR4cXIOnn1T+B84kHd418P1FlHi00F69Y5AszwKuJkYjWS+55SrV6mF4dqdthCApux2JhzEMZ3JGa1KdGcNLEGkkF/hF/yVbqAEEGRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783390926; c=relaxed/simple;
	bh=prC+DuTRKrd/VnxwT7PiciNy6ceFR//BkQOymMMzkO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CGj9bfonzxRKMaZvyWQo3hcXV5fv2e5s+l/nVYUHrrNIOiyy9bqzinL6jVw3ZoreRG4NNxnA+vNZ11Vh7wWnG30OrevOUk4Wd1znBAkXKc/1d3THmWMuJ09E9E+Nnw3dXncQwv9ido4B8M+fPVj3UXFB8SpNboxmMWdGFv315zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aakhfOll; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aakhfOll"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1+B6eVS3lS4biayl/G73KUccdaeP7ipijwhDj8mVJNo=;
	b=aakhfOllkZdnwaPhMzIhcvWV+gdiZYN1YxKGj9wODnuMXXFW6sDqrue2A8CSLduPt+WLw++KL
	/rKMwhcRxp9/lddh3/PstZT4z+3ZRKRb76astZc8VzYEwtPey+tgyOyaPmEAOkDuWDACvxCGbmQ
	UjYPEKi6hVpblspqV6y62OA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gvPrV23GczRhWC;
	Tue,  7 Jul 2026 10:12:42 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 3915840579;
	Tue,  7 Jul 2026 10:21:54 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 7 Jul
 2026 10:21:53 +0800
Message-ID: <c9603890-a58f-425d-9f48-7c980e7309b8@huawei.com>
Date: Tue, 7 Jul 2026 10:21:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] riscv, bpf: Add support for BPF_SDIV and
 BPF_SMOD in RV32 JIT
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
References: <20260706172846.3876436-1-visitorckw@gmail.com>
 <20260706172846.3876436-2-visitorckw@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260706172846.3876436-2-visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/7 1:28, Kuan-Wei Chiu wrote:
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
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp32.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
> index 592dd86fbf81..89153946a4e4 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c
> @@ -509,12 +509,15 @@ static void emit_alu_r64(const s8 *dst, const s8 *src,
>   }
>   
>   static void emit_alu_r32(const s8 *dst, const s8 *src,
> -			 struct rv_jit_context *ctx, const u8 op)
> +			 struct rv_jit_context *ctx,
> +			 const struct bpf_insn *insn)
>   {
>   	const s8 *tmp1 = bpf2rv32[TMP_REG_1];
>   	const s8 *tmp2 = bpf2rv32[TMP_REG_2];
>   	const s8 *rd = bpf_get_reg32(dst, tmp1, ctx);
>   	const s8 *rs = bpf_get_reg32(src, tmp2, ctx);
> +	u8 op = BPF_OP(insn->code);
> +	bool is_signed = insn->off == 1;
>   
>   	switch (op) {
>   	case BPF_MOV:
> @@ -539,10 +542,12 @@ static void emit_alu_r32(const s8 *dst, const s8 *src,
>   		emit(rv_mul(lo(rd), lo(rd), lo(rs)), ctx);
>   		break;
>   	case BPF_DIV:
> -		emit(rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
> +		emit(is_signed ? rv_div(lo(rd), lo(rd), lo(rs)) :
> +				 rv_divu(lo(rd), lo(rd), lo(rs)), ctx);
>   		break;
>   	case BPF_MOD:
> -		emit(rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
> +		emit(is_signed ? rv_rem(lo(rd), lo(rd), lo(rs)) :
> +				 rv_remu(lo(rd), lo(rd), lo(rs)), ctx);
>   		break;
>   	case BPF_LSH:
>   		emit(rv_sll(lo(rd), lo(rd), lo(rs)), ctx);
> @@ -1041,7 +1046,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   			emit_imm32(tmp2, imm, ctx);
>   			src = tmp2;
>   		}
> -		emit_alu_r32(dst, src, ctx, BPF_OP(code));
> +		emit_alu_r32(dst, src, ctx, insn);
>   		break;
>   
>   	case BPF_ALU | BPF_MOV | BPF_K:
> @@ -1065,7 +1070,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		 * src is ignored---choose tmp2 as a dummy register since it
>   		 * is not on the stack.
>   		 */
> -		emit_alu_r32(dst, tmp2, ctx, BPF_OP(code));
> +		emit_alu_r32(dst, tmp2, ctx, insn);
>   		break;
>   
>   	case BPF_ALU | BPF_END | BPF_FROM_LE:

lgtm, thanks

Reviewed-by: Pu Lehui <pulehui@huawei.com>

