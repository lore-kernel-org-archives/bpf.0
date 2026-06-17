Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20839C012;
	Wed, 17 Jun 2026 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681420; cv=none; b=PIA1zmjMvsdJh1WJpy+WHlm+ch7aAprZp9Bl6MxloXgkJxMLz+VA82SvDg4eSoYnmV+jkErZ10xbLLaV8BMlNhN5/3FXq7jqIOCk9FnOmVLCn/5zmtYOpEJj7+4xCTD63MOcKr1xbKhgJIeTvbjdR0NphgaQ8a9jh4s0yyvGaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681420; c=relaxed/simple;
	bh=m5AOnezOQdbgPnq0bYL7H4+rLwUtXUfQiRIhvU82yM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LJP/poRZ+LaHw2I4O81pu62cqziudlWLDBPeNH0eXH32oYhjXUG0KCMCDHTiMMdF8YI2UnnC0Sh1828yCkT06MCKwiMs+UAc2c7x1FLxxzh9WxeZXxO5C+By47+WwfllTb4fXWqRaoiwwB8ExDAelCENOFWuyINmtf2AlnIspLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vl7t1HdC; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vl7t1HdC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=r72SZ0T5nPg5YOaeX9GzZ5PhvkCNhJKsFZeacJsMyXc=;
	b=Vl7t1HdCfBihnCzda/CLpC1pp2eNZcxuD23b1uR5Y7zyk7M1RyBoP8rd1LN1f4kvUCj/YhkQC
	oWIuSQxui3bJlsK+KE2UT600MzS7vG735SE+8HzvU0okVGvzp2KlqgwYzQrWz+b27ONc0oFvDST
	Bxz8Tm3GjUyLPKqZVg01Dfg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4ggFfm2DdNz1cypx;
	Wed, 17 Jun 2026 15:22:08 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C04D4056C;
	Wed, 17 Jun 2026 15:30:05 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Jun
 2026 15:30:04 +0800
Message-ID: <2ca2a85a-d4a9-4459-a534-6159de6e5890@huawei.com>
Date: Wed, 17 Jun 2026 15:30:03 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] riscv, bpf: Fix support for BPF_MOVSX in
 RV32 JIT
Content-Language: en-US
To: Kuan-Wei Chiu <visitorckw@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>, <luke.r.nels@gmail.com>, <xi.wang@gmail.com>,
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <alex@ghiti.fr>, <jserv@ccns.ncku.edu.tw>,
	<eleanor15x@gmail.com>, <marscheng@google.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260511221648.3251464-1-visitorckw@gmail.com>
 <20260511221648.3251464-3-visitorckw@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260511221648.3251464-3-visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/5/12 6:16, Kuan-Wei Chiu wrote:
> The current rv32 bpf jit compiler incorrectly treats BPF_MOVSX as a
> standard zero-extended move operation. The bpf instruction set allows
> sign-extension moves by reusing the BPF_MOV opcode with the instruction
> offset set to 8, 16, or 32.
> 
> Update the bpf_jit_emit_insn() function to check the offset field for
> both ALU and ALU64 MOV operations. If the offset is non-zero, emit the
> correct slli and srai instructions to perform the sign extension.
> 
> Before this patch:
> [   19.549705] test_bpf: #82 ALU_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> [   19.551354] test_bpf: #83 ALU_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> [   19.552576] test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> [   19.553542] test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> [   19.554807] test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 ret 2 != 1 (0x2 != 0x1)FAIL (1 times)
> 
> After this patch:
> [   17.931172] test_bpf: #82 ALU_MOVSX | BPF_B jited:1 125 PASS
> [   17.932198] test_bpf: #83 ALU_MOVSX | BPF_H jited:1 124 PASS
> [   17.933039] test_bpf: #84 ALU64_MOVSX | BPF_B jited:1 124 PASS
> [   17.933918] test_bpf: #85 ALU64_MOVSX | BPF_H jited:1 124 PASS
> [   17.934751] test_bpf: #86 ALU64_MOVSX | BPF_W jited:1 122 PASS
> 
> Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")

not a fix, the fixes tag should remove. And the title should `Add 
support for xxx`

others lgtm,

Reviewed-by: Pu Lehui <pulehui@huawei.com>

> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp32.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp32.c b/arch/riscv/net/bpf_jit_comp32.c
> index 7396899ea276..f8509950fed4 100644
> --- a/arch/riscv/net/bpf_jit_comp32.c
> +++ b/arch/riscv/net/bpf_jit_comp32.c
> @@ -974,6 +974,24 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   
>   	switch (code) {
>   	case BPF_ALU64 | BPF_MOV | BPF_X:
> +		if (insn->off != 0) {
> +			const s8 *rd = bpf_get_reg64(dst, tmp1, ctx);
> +			const s8 *rs = bpf_get_reg64(src, tmp2, ctx);
> +
> +			if (insn->off == 8) {
> +				emit(rv_slli(lo(rd), lo(rs), 24), ctx);
> +				emit(rv_srai(lo(rd), lo(rd), 24), ctx);
> +			} else if (insn->off == 16) {
> +				emit(rv_slli(lo(rd), lo(rs), 16), ctx);
> +				emit(rv_srai(lo(rd), lo(rd), 16), ctx);
> +			} else {
> +				emit(rv_addi(lo(rd), lo(rs), 0), ctx);
> +			}
> +			emit(rv_srai(hi(rd), lo(rd), 31), ctx);
> +			bpf_put_reg64(dst, rd, ctx);
> +			break;
> +		}
> +		fallthrough;
>   
>   	case BPF_ALU64 | BPF_ADD | BPF_X:
>   	case BPF_ALU64 | BPF_ADD | BPF_K:
> @@ -1024,6 +1042,20 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   			emit_zext64(dst, ctx);
>   			break;
>   		}
> +		if (insn->off != 0) {
> +			const s8 *rd = bpf_get_reg32(dst, tmp1, ctx);
> +			const s8 *rs = bpf_get_reg32(src, tmp2, ctx);
> +
> +			if (insn->off == 8) {
> +				emit(rv_slli(lo(rd), lo(rs), 24), ctx);
> +				emit(rv_srai(lo(rd), lo(rd), 24), ctx);
> +			} else if (insn->off == 16) {
> +				emit(rv_slli(lo(rd), lo(rs), 16), ctx);
> +				emit(rv_srai(lo(rd), lo(rd), 16), ctx);
> +			}
> +			bpf_put_reg32(dst, rd, ctx);
> +			break;
> +		}
>   		fallthrough;
>   
>   	case BPF_ALU | BPF_ADD | BPF_X:
