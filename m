Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECD25782D
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552527; cv=none; b=T+V+ZEUCJhngC2BBhl2SSfVh4tJDze4GrnA1U++nmDttull3WPmNunOxE7XjH/hKEg/R5qwymMxhe0pgRkvHzz3EECl8XUUgdlwtyeNPXS8/eV7B7gwATzaquduGsFCDqVccXwea39wmxIOKrv9YQc7uBeAD2BzLa8dTIztsvU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552527; c=relaxed/simple;
	bh=+1PE+tYJbfNs3BBXGvL1uJ17lIn3xjI7OVQoU5RaJJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i/OBsM4l3LtJhQSXncAPl5byGmkI/KBweVl//iIQ7cH2O32LvkpQLXpv2QGD9rS2FIwF4lj+1CeXAkiJ4lPKxXvhBZGxKiR1YsrcpmJ+oJTKtt54R8LgtGF9sZIT7yBDdWMioKAY+9F56JGG0zKb9osRit+1vOhm8YhsGTIkpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Vbb475N1; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Vbb475N1"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QD92rEaaMjbdthSVbHTawUlLI5HCQYGf1p71W8iKy0k=;
	b=Vbb475N1ZBCEl+h8vO8DyZ8Gl5P2rH/hv/HzCVlp5L8drpeY4v2UR9iXwLP22d4kJh4fcdfWw
	GmlnpkNoWdLKVx0i4znfOheel9lSGUOT3nPkVFnC8zAQED9hw+esNUf3oMnmWwATG/ox7GFheUg
	04ehPK+IEb7wyGxqGuzKoe4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hT0tJ3nKpz1T4K6;
	Mon, 24 Aug 2026 14:11:52 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id C579540561;
	Mon, 24 Aug 2026 14:21:59 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 14:21:59 +0800
Message-ID: <f60dec14-dbd4-4c81-a486-2c4d01a8c878@huawei.com>
Date: Mon, 24 Aug 2026 14:21:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 02/14] bpf, riscv: Fix stack-passed arguments
 for indirect trampolines
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, <bpf@vger.kernel.org>
CC: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	<kkd@meta.com>, <kernel-team@meta.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
 <20260821233516.3426127-3-memxor@gmail.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260821233516.3426127-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/8/22 7:34, Kumar Kartikeya Dwivedi wrote:
> store_args() reads stack-passed arguments relative to FP assuming the
> trampoline was entered through the fentry call from a traced function. In
> that path, the trampoline pushes the parent frame before establishing its
> final FP, so the incoming stack arguments start at FP + 16.
> 
> An indirect trampoline for a struct_ops callback is called through a
> function pointer. Its prologue allocates only the trampoline frame and sets
> FP to the incoming SP. The RISC-V ABI places the first stack argument at
> that incoming SP, so the arguments start at FP, not FP + 16. Every
> stack-passed argument of a callback with more than eight argument slots is
> therefore read two slots late.
> 
> Pass the prologue-dependent offset to store_args(), using zero for a direct
> struct_ops trampoline and 16 for the fentry path.
> 
> Fixes: 6801b0aef79d ("riscv, bpf: Add 12-argument support for RV64 bpf trampoline")
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Pu Lehui <pulehui@huawei.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>   arch/riscv/net/bpf_jit_comp64.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 47c7bf431ba8..b1084f30f3ce 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -857,7 +857,8 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>   	return ret;
>   }
>   
> -static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ctx)
> +static void store_args(int nr_arg_slots, int args_off, int stack_args_off,
> +		       struct rv_jit_context *ctx)
>   {
>   	int i;
>   
> @@ -865,8 +866,8 @@ static void store_args(int nr_arg_slots, int args_off, struct rv_jit_context *ct
>   		if (i < RV_MAX_REG_ARGS) {
>   			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
>   		} else {
> -			/* skip slots for T0 and FP of traced function */
> -			emit_ld(RV_REG_T1, 16 + (i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
> +			emit_ld(RV_REG_T1, stack_args_off +
> +				(i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
>   			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
>   		}
>   		args_off -= 8;
> @@ -1152,7 +1153,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>   	func_meta = nr_arg_slots;
>   	emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
>   
> -	store_args(nr_arg_slots, args_off, ctx);
> +	/*
> +	 * A direct struct_ops call has its first stack argument at the incoming
> +	 * SP, which the trampoline keeps as FP. The fentry path pushes the
> +	 * parent frame first, so its incoming stack arguments start at FP + 16.
> +	 */
> +	store_args(nr_arg_slots, args_off, is_struct_ops ? 0 : 16, ctx);
>   
>   	if (bpf_fsession_cnt(tnodes)) {
>   		/* clear all session cookies' value */

Reviewed-by: Pu Lehui <pulehui@huawei.com>
