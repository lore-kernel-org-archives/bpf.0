Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720954;
	b=Hj3J5zRiW2W7QvgRpq2vGl6leKSSlJBKNVC78gOv1g1RAHOk0ZEE0MVnZTQ0ub2irjuS
	 tle+bYx7jrrG9n6aBI78C5Z39QTe7+MY+/BJ1yjXSDie30RYd7Az654gjKNMKAFOmNPSc
	 N4VPCHpu35Eev7pylhJbm7oXFAkVtBHuwcQNJ9uuDotqrcwfo9FuMprtzoOiQe5ioGwxk
	 fQhEBnIwXf/J4zz3QwR4d5OWXJgXYVe4Qo3BMth/PbySJcX8m6mo5LnHAeE94pjcKvfcN
	 KELD6DKxNOLcqGxprYSYSnAOBeQg3UejZVx1xxjdNEQWr1dARkWDf0B5giDU6pYLOJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720954;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=O0paVXdQ4B7tiVvakZnTvQOueqcpWaGjY3MAerZlPlA=;
	b=Fievgw8xDNiQYuNaoswRHQoM11BaeEThqEdWKyXtJfIGfgMVaH1cB5mMh5QQFr2xTpfY
	 JJv3/e1+tSTAwb4HlWBRZrDLQdmKyL92cb4AUYZwhASGoDqd3Hh8PTIJT3LqHxs7noltP
	 GZzmU60k7p6tzH+TgJ1aLf7VAEPbqKFtgaVfqEb5FJSiCryeds4OVx+T+AIO6WkgBJlKD
	 Dze5bgxXgrQXnWyvV5qwrUvKnYz+lZH2wzRb/oqMBIBXl+lqu+HcKOBkPKP85IljGumGP
	 zRkxc9vFql9uyF617KLB2ObETjBsCsO99d3wjClNfHA/8PyJrVSpx9ziPZyOlnjRwyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="DmNtro/P";
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D9606A31B;
	Fri, 23 Oct 2026 02:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A99D9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=DmNtro/P
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=O0paVXdQ4B7tiVvakZnTvQOueqcpWaGjY3MAerZlPlA=;
	b=DmNtro/PwoYvttzX/X03x6IAJNmcK1zSPVVafirZdz0CSpt/MuiqoGlZ+jCQQ5NVS596z7OCt
	uLBVAoDPYtisv/9Tsqg6v7w/any3xI3Fq8SCf8Gtd66Up/bTrqn6doz0Wyk/43MeqD+qjx53Etf
	qREZD3LRzZcH+BACbQE3bsI=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4j9mVn5VLGzmV7N;
	Fri, 23 Oct 2026 10:02:25 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id C412640563;
	Fri, 23 Oct 2026 10:02:28 +0800 (CST)
Received: from [10.67.110.154] (10.67.110.154) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 23 Oct 2026 10:02:27 +0800
Message-ID: <fe835795-7184-4c21-8020-07117c10ddef@huawei.com>
Date: Fri, 23 Oct 2026 10:02:26 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 4/7] bpf, riscv: JIT UHMUL and SHMUL on RV64
To: Yazhou Tang <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, David Vernet <void@manifault.com>,
	<bpf@ietf.org>
CC: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin
 Monnet <qmo@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
	<xukuohai@huaweicloud.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
	<bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>, Yazhou Tang
	<tangyazhou518@outlook.com>, Tianci Cao <ziye@zju.edu.cn>, Shenghao Yuan
	<shenghaoyuan0928@163.com>
References: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
 <20261023-bpf-hmul-v3-4-b99e808cb28b@outlook.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20261023-bpf-hmul-v3-4-b99e808cb28b@outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/10/23 0:28, Yazhou Tang wrote:
> From: Yazhou Tang <tangyazhou518@outlook.com>
> 
> On RV64, the RISC-V M extension provides MULHU and MULH instructions that
> return the high 64 bits of an unsigned or signed 64-bit multiplication,
> respectively.
> 
> Add the missing MULH encoder and use MULHU and MULH to lower the UHMUL and
> SHMUL BPF_MUL variants for both register and immediate sources. Keep the
> existing low-half and ALU32 multiplication lowering unchanged.
> 
> Opt the RV64 JIT into HMUL support by returning true from
> bpf_jit_supports_hmul().
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Acked-by: Björn Töpel <bjorn@kernel.org>
> ---
>   arch/riscv/net/bpf_jit.h        |  5 +++++
>   arch/riscv/net/bpf_jit_comp64.c | 23 ++++++++++++++++++++---
>   2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 5c4f53060c91..21a190a6a6d9 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -436,6 +436,11 @@ static inline u32 rv_mul(u8 rd, u8 rs1, u8 rs2)
>   	return rv_r_insn(1, rs2, rs1, 0, rd, 0x33);
>   }
>   
> +static inline u32 rv_mulh(u8 rd, u8 rs1, u8 rs2)
> +{
> +	return rv_r_insn(1, rs2, rs1, 1, rd, 0x33);
> +}
> +
>   static inline u32 rv_mulhu(u8 rd, u8 rs1, u8 rs2)
>   {
>   	return rv_r_insn(1, rs2, rs1, 3, rd, 0x33);
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 788fcc21fd5b..371405598faa 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -197,6 +197,19 @@ static void emit_imm(u8 rd, s64 val, struct rv_jit_context *ctx)
>   		emit_addi(rd, rd, lower, ctx);
>   }
>   
> +static void emit_mul(u8 rd, u8 rs, bool is64, s16 off,
> +		     struct rv_jit_context *ctx)
> +{
> +	if (!is64)
> +		emit(rv_mulw(rd, rd, rs), ctx);
> +	else if (off == BPF_UHMUL)
> +		emit(rv_mulhu(rd, rd, rs), ctx);
> +	else if (off == BPF_SHMUL)
> +		emit(rv_mulh(rd, rd, rs), ctx);
> +	else
> +		emit(rv_mul(rd, rd, rs), ctx);
> +}
> +
>   static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>   {
>   	int stack_adjust = ctx->stack_size, store_offset = stack_adjust - 8;
> @@ -1526,7 +1539,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		break;
>   	case BPF_ALU | BPF_MUL | BPF_X:
>   	case BPF_ALU64 | BPF_MUL | BPF_X:
> -		emit(is64 ? rv_mul(rd, rd, rs) : rv_mulw(rd, rd, rs), ctx);
> +		emit_mul(rd, rs, is64, off, ctx);
>   		if (!is64 && !aux->verifier_zext)
>   			emit_zextw(rd, rd, ctx);
>   		break;
> @@ -1662,8 +1675,7 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   	case BPF_ALU | BPF_MUL | BPF_K:
>   	case BPF_ALU64 | BPF_MUL | BPF_K:
>   		emit_imm(RV_REG_T1, imm, ctx);
> -		emit(is64 ? rv_mul(rd, rd, RV_REG_T1) :
> -		     rv_mulw(rd, rd, RV_REG_T1), ctx);
> +		emit_mul(rd, RV_REG_T1, is64, off, ctx);
>   		if (!is64 && !aux->verifier_zext)
>   			emit_zextw(rd, rd, ctx);
>   		break;
> @@ -2303,3 +2315,8 @@ bool bpf_jit_supports_callx(void)
>   {
>   	return true;
>   }
> +
> +bool bpf_jit_supports_hmul(void)
> +{
> +	return true;
> +}
> 

Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Pu Lehui <pulehui@huawei.com>
