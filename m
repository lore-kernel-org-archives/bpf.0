Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44191360EEE;
	Thu, 23 Jul 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801437; cv=none; b=SKRBdUZVVed8J2vsAw/iUP0fJLwjWaVM+bp1gERv0UCmAaA7i+PyBmi7MerIA2T8MUkc/lYqxsMYoKBprVjLE9LAxTR8McRgLJMW8/08fuZg7D/+OBf/WwZi3jOZbP6Z7Yox//EPnKvJKhtevIjoHq0AbatxGUOteOgNu/CSRzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801437; c=relaxed/simple;
	bh=92c+FaGcdctoHMcJhwFeMWJ7qJ/vZQilYYPJ+JRm0ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jUG4JJmGV+tr76J3JfVmfdL2CRL2S6DnFvlgtIaIGzyEskNP2PZHy7GzIK4G/+JlkDaQuoyEE5JOkvrq3MqGULxgW5H54ckA9nl060L/XuPowFXzT54D6sBqYrmjAf4FGhv87zkWlCDdQyYhN2ZxxEZAy5dusMZiN8w42ZV/cJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kBm9mYld; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kBm9mYld"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4bq3O7+YsxRmC7Dd1A4Vy6325Gn0WoUc+loqYkx+dIk=;
	b=kBm9mYldUdKYVYoKmUQTjnabadxBkDbVLdCAs+J5KSMjHm2SMMGRddmwe1Id1MS9sd4ZxZ8Zn
	hXLwBHxGlUVgwoYU/Kr2Nm9Dz4G+449uvAQo02m2ZfnlNgTYYgPXAkbqtKd4vk2RhrSxZaKrtxu
	deqZttu/wQsgw8eGeIoU1jc=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h5RTJ1xxWznTVx;
	Thu, 23 Jul 2026 18:00:52 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id E822440565;
	Thu, 23 Jul 2026 18:10:22 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 23 Jul
 2026 18:10:21 +0800
Message-ID: <4b4c8567-b5f5-4703-b06f-6369bd47e0ed@huawei.com>
Date: Thu, 23 Jul 2026 18:10:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/3] bpf, riscv: add support for timed
 may_goto
Content-Language: en-US
To: Feng Jiang <jiangfeng@kylinos.cn>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Puranjay Mohan
	<puranjay@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Shuah Khan <shuah@kernel.org>, Ihor Solodrai
	<ihor.solodrai@linux.dev>
CC: <bpf@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
 <20260723-riscv-bpf-timed-may-goto-v5-1-86acb54e5642@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260723-riscv-bpf-timed-may-goto-v5-1-86acb54e5642@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/23 13:41, Feng Jiang wrote:
> Implement arch_bpf_timed_may_goto() for the RV64 JIT. The argument and
> return value are carried in BPF_REG_AX, and BPF R0-R5 are preserved
> across the call to the generic bpf_check_timed_may_goto().
> 
> Enable bpf_jit_supports_timed_may_goto() so the verifier uses the timed
> expansion path.
> 
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> ---
>   arch/riscv/net/Makefile             |  2 +-
>   arch/riscv/net/bpf_jit_comp64.c     | 12 +++++++++-
>   arch/riscv/net/bpf_timed_may_goto.S | 47 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 59 insertions(+), 2 deletions(-)


Reviewed-by: Pu Lehui <pulehui@huawei.com>

> 
> diff --git a/arch/riscv/net/Makefile b/arch/riscv/net/Makefile
> index 9a1e5f0a94e5..6458d4d51990 100644
> --- a/arch/riscv/net/Makefile
> +++ b/arch/riscv/net/Makefile
> @@ -3,7 +3,7 @@
>   obj-$(CONFIG_BPF_JIT) += bpf_jit_core.o
>   
>   ifeq ($(CONFIG_ARCH_RV64I),y)
> -	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o
> +	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp64.o bpf_timed_may_goto.o
>   else
>   	obj-$(CONFIG_BPF_JIT) += bpf_jit_comp32.o
>   endif
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index ad089a9a4ea9..8fe8969fb8a0 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1841,7 +1841,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>   		if (aux->tail_call_reachable && insn->src_reg == BPF_PSEUDO_CALL)
>   			emit_sd(RV_REG_SP, ctx->tcc_offset, RV_REG_TCC, ctx);
>   
> -		if (insn->src_reg != BPF_PSEUDO_CALL)
> +		/*
> +		 * arch_bpf_timed_may_goto() is emitted by the verifier and
> +		 * returns its result in BPF_REG_AX instead of BPF_REG_0, so
> +		 * skip the normal "move return register into R0".
> +		 */
> +		if (insn->src_reg != BPF_PSEUDO_CALL && addr != (u64)arch_bpf_timed_may_goto)
>   			emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);
>   		break;
>   	}
> @@ -2161,3 +2166,8 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>   {
>   	return true;
>   }
> +
> +bool bpf_jit_supports_timed_may_goto(void)
> +{
> +	return true;
> +}
> diff --git a/arch/riscv/net/bpf_timed_may_goto.S b/arch/riscv/net/bpf_timed_may_goto.S
> new file mode 100644
> index 000000000000..02c637d87420
> --- /dev/null
> +++ b/arch/riscv/net/bpf_timed_may_goto.S
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2026 Feng Jiang <jiangfeng@kylinos.cn> */
> +
> +#include <linux/linkage.h>
> +#include <asm/asm.h>
> +
> +/*
> + * Trampoline for the BPF timed may_goto loop bound. Custom calling convention:
> + *	- input:  stack offset in BPF_REG_AX (t0)
> + *	- output: updated count in BPF_REG_AX (t0)
> + *
> + * Calls bpf_check_timed_may_goto(ptr) with the standard RISC-V ABI, where
> + * ptr = BPF_REG_FP (s5) + BPF_REG_AX (t0). BPF R0-R5 (a5, a0-a4) are saved
> + * across the call; BPF_REG_FP (s5) is callee-saved and needs no saving.
> + */
> +
> +SYM_FUNC_START(arch_bpf_timed_may_goto)
> +	addi	sp, sp, -(8*SZREG)
> +	REG_S	ra, 7*SZREG(sp)
> +	REG_S	s0, 6*SZREG(sp)
> +	addi	s0, sp, 8*SZREG
> +
> +	/* Save BPF registers R0-R5 (a5, a0-a4) */
> +	REG_S	a5, 5*SZREG(sp)
> +	REG_S	a0, 4*SZREG(sp)
> +	REG_S	a1, 3*SZREG(sp)
> +	REG_S	a2, 2*SZREG(sp)
> +	REG_S	a3, 1*SZREG(sp)
> +	REG_S	a4, 0*SZREG(sp)
> +
> +	add	a0, t0, s5
> +	call	bpf_check_timed_may_goto
> +	mv	t0, a0
> +
> +	/* Restore BPF registers R0-R5 */
> +	REG_L	a4, 0*SZREG(sp)
> +	REG_L	a3, 1*SZREG(sp)
> +	REG_L	a2, 2*SZREG(sp)
> +	REG_L	a1, 3*SZREG(sp)
> +	REG_L	a0, 4*SZREG(sp)
> +	REG_L	a5, 5*SZREG(sp)
> +
> +	REG_L	s0, 6*SZREG(sp)
> +	REG_L	ra, 7*SZREG(sp)
> +	addi	sp, sp, 8*SZREG
> +	ret
> +SYM_FUNC_END(arch_bpf_timed_may_goto)
> 

