Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AFD3E49FA
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553384; cv=none; b=GhHEtkR/WrrhMpvz5Uhi365GJBY5094rG0/kM1Zx3hE8KqmAi0x+31Z9RtUvdykzeRwWj5hK6K/EdY+Qkd9gWLhQ391e2NYoqqWvuGbJuUp4AYiyJkeZ/gsWgQJKxJjm34mWq0x67gfIOcFGPgUJcZKn8zNeQnNPbea87gcGf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553384; c=relaxed/simple;
	bh=WooD5FWQRAdQszQbsEe0elfu66P6X5WYm2ZFgcb/4P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qh95icBCVjSEiClIUZXayfOLQZ3GZ9JrMgAPipz5MNv7lBbMTl7Z1r4mkK88Frnsa68rv8GB47S5nvXr8PVXgpJuqfc3lce3oylLeXACRJJ/LEGH0/O8zP08IsvNBEEfsyeU8ggKHfkLRgST0Nyud5/1gBDtfNvpKP93EnL0JDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YYAEkHDq; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YYAEkHDq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VCXCmJWXfxxTkQ8qcsVO8oLxFclCv993m9k07egMDLo=;
	b=YYAEkHDqXO6tOMMRFeZChf9ow1he0BbhEYGo5pcGyeVzKvIs6EjinV4YkK6d/erNwdZckeOs6
	0rBtTQjpcWaLFQmzAGwYGH+lC/wbZGDD9nnh4YFLmjvQsgAzyLutN0B9J+6zK1esi1wTP79OBn+
	E+gYDGvP4QH9Hzf16WHTel0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hT1Bn1wxlz1T4Mc;
	Mon, 24 Aug 2026 14:26:09 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 7995040561;
	Mon, 24 Aug 2026 14:36:16 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 14:36:15 +0800
Message-ID: <75cde0ff-0558-4c9a-8aa7-21bcc8667a9f@huawei.com>
Date: Mon, 24 Aug 2026 14:36:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 03/14] bpf, riscv: JIT arena kfunc argument
 rebasing
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	<kkd@meta.com>, <kernel-team@meta.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-4-memxor@gmail.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260821233516.3426127-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/8/22 7:34, Kumar Kartikeya Dwivedi wrote:
> A BPF arena pointer is represented as a zero-extended 32-bit offset while
> a kfunc receives a kernel address. Kfuncs whose BTF argument names carry
> the __arena suffix therefore need the JIT to rebase those offsets
> immediately before the native call.
> 
> RV_REG_ARENA already holds kern_vm_start whenever the program uses an
> arena. Zero-extend each tagged argument and add that base:
> 
>    zext.w aN, aN
>    add    aN, s7, aN
> 
> For an __arena__nullable argument, branch over the fixed-width add when
> the truncated offset is zero so that NULL remains NULL. An unconditionally
> tagged zero is intentionally converted to the arena base.
> 
> The sequence is emitted as native code after the BPF instruction stream
> has been blinded, and its size depends only on the function model and
> enabled ISA extensions. Advertise the kfunc capability independently;
> struct_ops argument conversion is not enabled by this change.
> 
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Pu Lehui <pulehui@huawei.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 40 +++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index b1084f30f3ce..c97d13a3eae4 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -714,6 +714,37 @@ static int sign_extend(u8 rd, u8 rs, u8 sz, bool sign, struct rv_jit_context *ct
>   	return 0;
>   }
>   
> +/*
> + * Rebase the __arena args of a kfunc call to arena kernel addresses,
> + * aN = kern_vm_start + (u32)aN, with RV_REG_ARENA holding kern_vm_start.
> + * A nullable arg preserves NULL by skipping the add, tested on the
> + * truncated value as arena NULL is offset 0.
> + */
> +static int emit_kfunc_arena_args(struct rv_jit_context *ctx,
> +				 const struct btf_func_model *fm)
> +{
> +	int i;
> +
> +	for (i = 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) {
> +		u8 flags = fm->arg_flags[i];
> +		u8 reg = bpf_to_rv_reg(BPF_REG_1 + i, ctx);
> +
> +		if (!(flags & BTF_FMODEL_ARENA_ARG))
> +			continue;
> +		if (WARN_ON_ONCE(!ctx->arena_vm_start))
> +			return -EINVAL;
> +
> +		emit_zextw(reg, reg, ctx);
> +		if (flags & BTF_FMODEL_NULLABLE_ARG) {
> +			/* Skip the fixed-width add so that NULL stays NULL. */
> +			emit(rv_beq(reg, RV_REG_ZERO, 4), ctx);
> +		}
> +		emit(rv_add(reg, RV_REG_ARENA, reg), ctx);
> +	}
> +
> +	return 0;
> +}
> +
>   #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
>   #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
>   #define REG_DONT_CLEAR_MARKER	0	/* RV_REG_ZERO unused in pt_regmap */
> @@ -1834,6 +1865,10 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx, >   				if (sign_extend(reg, reg, fm->arg_size[idx], sign, ctx))
>   					return -EINVAL;

sign_extend will emit for both signed and unsigned 4-byte kfunc 
arguments. The current patch therefore generates a redundant sign-ext 
prior to zero-ext for arena pointers.

It would be cleaner to merge the two passes into a single loop:

for (idx = 0; idx < fm->nr_args; idx++) {
     u8 flags = fm->arg_flags[idx];
     bool sign = flags & BTF_FMODEL_SIGNED_ARG;
     u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);

     if (flags & BTF_FMODEL_ARENA_ARG) {
         xxx
         continue;
     }

     if (sign_extend(reg, reg, fm->arg_size[idx], sign, ctx))
         return -EINVAL;
}

>   			}
> +
> +			ret = emit_kfunc_arena_args(ctx, fm);
> +			if (ret)
> +				return ret;
>   		}
>   
>   		/* restore TCC to RV_REG_TCC before bpf2bpf call */
> @@ -2132,6 +2167,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
>   	return true;
>   }
>   
> +bool bpf_jit_supports_arena_kfunc_args(void)
> +{
> +	return true;
> +}
> +
>   bool bpf_jit_supports_ptr_xchg(void)
>   {
>   	return true;
