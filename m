Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3AD296BB5;
	Mon, 28 Sep 2026 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568177; cv=none; b=pq50torW1M9DicOIw+42a1l57SaETPkoFkyzAOlTPZaeIWNRq/y3j3qQ7SjosKt6f5Xl7iWGEzFvAJR/+0eBtFsiPDTElXqMkWn3eTJFPdn9wpvdI4DPsUM2p2BWJVv3IyZEDG4yb60c3QGxw6+3zIAU7Rv44ADCT71HEsgFfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568177; c=relaxed/simple;
	bh=fWB+U6HN+5VMZSPOv2LBtHKPlsDUFfHhToHk9FOLauI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ojQVQhz8Qj56rCzfrXr236R3Bla9DuFUgfh/0nFmEvFUfMdE7vIuW9LxOLOtMCOCTGqBoQqarSz+4dlHgaSfN2bflgqTYBx6HsVfbzt+MlccobhXqctLc9kNLspi/xGnd8rs1zRdRTJyuvLVs564XRjSg0mZP1rfxzGTiRprPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=iv8hKHoo; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="iv8hKHoo"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yMzZ40MhXUsj3z/JaHRvax3vgrWefMoxo7kjo8blCQU=;
	b=iv8hKHooDlWFLLNnKXJ8wnracqfZKs3Hrl++aGpOUmX6mTgoOgg0iJgAa/Agey5caljAZSStV
	5Y2A+zU4kxt0dgVgXV3V/tvf5jgRcWmzie3A9GYZNKWT9ictu/8DIUVWO0JL7WNvZhoETsLjIwF
	xpKwlgrwZj1Xf1GwPW3Oe0k=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4htS5D0FFmznTVv;
	Mon, 28 Sep 2026 11:50:40 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id AC63940565;
	Mon, 28 Sep 2026 12:02:41 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 12:02:40 +0800
Message-ID: <6a87a54e-2792-4c07-a48a-c9a4083bfd5c@huawei.com>
Date: Mon, 28 Sep 2026 12:02:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, riscv: Add support for indirect
 jumps
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <ihor.solodrai@linux.dev>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
	<emil@etsalapatis.com>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<shuah@kernel.org>, <guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260928022109.1093-1-cp0613@linux.alibaba.com>
 <20260928022109.1093-2-cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260928022109.1093-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/9/28 10:21, Chen Pei wrote:
> Implement JIT support for the indirect jump instruction (BPF_JMP |
> BPF_JA | BPF_X), a.k.a. gotox, which lets a BPF program jump through a
> BPF_MAP_TYPE_INSN_ARRAY jump table.
> 
> Emit "jalr zero, rd, 0" and hand the xlated to jitted offsets to
> bpf_prog_update_insn_ptrs(), which is what fills in the jump table
> entries; without that call the load fails with -EFAULT in
> bpf_insn_array_ready(). ctx->offset[] holds the offset of the insn
> *following* insn i, as bpf_prog_fill_jited_linfo() expects, so it is
> shifted by one and offset[0] comes from the prologue length. build_body()
> now records both halves of a multi-insn record, so no slot keeps a
> fabricated offset.
> 
> Only the RV64 JIT is covered; RV32 keeps failing to load as before.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Acked-by: Björn Töpel <bjorn@kernel.org>
> ---
> 
> Changes since v1:
> - Reword the code comment to say "shift ctx->offset[] by one".
> 
>   arch/riscv/net/bpf_jit_comp64.c |  5 +++++
>   arch/riscv/net/bpf_jit_core.c   | 16 ++++++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index ed0a6f871dea..9de3749fb268 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1691,6 +1691,11 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   			emit_zextw(rd, rd, ctx);
>   		break;
>   
> +	/* JUMP reg */
> +	case BPF_JMP | BPF_JA | BPF_X:
> +		emit_jalr(RV_REG_ZERO, rd, 0, ctx);
> +		break;
> +
>   	/* JUMP off */
>   	case BPF_JMP | BPF_JA:
>   	case BPF_JMP32 | BPF_JA:
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index 470a6ace5662..5265dd5bd39e 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -26,10 +26,13 @@ static int build_body(struct rv_jit_context *ctx, bool extra_pass, int *offset)
>   		int ret;
>   
>   		ret = bpf_jit_emit_insn(insn, ctx, extra_pass);
> -		if (ret > 0)
> -			i++; /* skip the next instruction */
>   		if (offset)
>   			offset[i] = ctx->ninsns;
> +		if (ret > 0) {
> +			i++; /* skip the next instruction */
> +			if (offset)
> +				offset[i] = ctx->ninsns;
> +		}
>   		if (ret < 0)
>   			return ret;
>   	}
> @@ -176,6 +179,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
>   		for (i = 0; i < prog->len; i++)
>   			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
>   		bpf_prog_fill_jited_linfo(prog, ctx->offset);
> +
> +		/*
> +		 * bpf_prog_update_insn_ptrs() wants the start of each insn, so
> +		 * shift ctx->offset[] by one and get insn 0 from the prologue.
> +		 */
> +		for (i = prog->len - 1; i > 0; i--)
> +			ctx->offset[i] = ctx->offset[i - 1];
> +		ctx->offset[0] = ninsns_rvoff(ctx->prologue_len);
> +		bpf_prog_update_insn_ptrs(prog, ctx->offset, jit_data->ro_image);
>   out_offset:
>   		kvfree(ctx->offset);
>   		kfree(jit_data);

Reviewed-by: Pu Lehui <pulehui@huawei.com>
