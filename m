Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C147043D;
	Wed, 22 Jul 2026 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715494; cv=none; b=NhZkPlvkLwLQISnYkL7/4igw07uz+oO5VABaKGexFKtnkIoKsXSk2jH6+vEGbRPVf6xtaHyXRnhz/qIcfiX9BBsy2hrB5tC08XDenpOzr6iWeLCxbng16XQt2nnl/PEMsNXuHFUdnXoH1bt/pQEzsa2w6Ef9pxmCXWaqOn5xGiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715494; c=relaxed/simple;
	bh=CUVABRT8u6sIkCSaBwXYAsL2LoY6BthfYLDAz7oEI3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CWT/4AqG0RdZJ2A1KcTS0ckRhsjhpDU32YQ6QGdQVnxKZLYJ2d+bSf7t9Bwrdg0KRRsg1gCHNKJtrCnJk+feyztz7lIF1ebbcBJhV4DZFs8DE3iOwRSGb9SkxB/aj3i/zOALbrPFo/siPjSSeX1pxznxA+XMJ1hIk+ibGOzpUR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4DwY6um3; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4DwY6um3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=h9L8mZwcaSEYqtHbvb4ujqFx0pT12RwD6oNzavrJYvE=;
	b=4DwY6um3U7bafCA1X9Y9RRHNOHavkkRwtEebewVEtIekBpcjcvBP+YczJPxY1YduGPc/yfIto
	1tPzHs/zmV8qzc6T2hVU86xoSItkwbYtT0S3cV8NFlp2AA6Hm5bwp7hi1i5/6nMVmX+ch7oTsVa
	oxSlmoQfoYb+VUE52Ewswjo=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h4qhh6njYzcZyH;
	Wed, 22 Jul 2026 18:08:36 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id C36A6202E6;
	Wed, 22 Jul 2026 18:18:05 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 22 Jul
 2026 18:18:04 +0800
Message-ID: <53b49505-f593-44d1-a4ea-b3ad81f6cc0b@huawei.com>
Date: Wed, 22 Jul 2026 18:18:04 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/3] bpf, riscv: add support for timed
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
References: <20260722-riscv-bpf-timed-may-goto-v4-0-e117e6337bc7@kylinos.cn>
 <20260722-riscv-bpf-timed-may-goto-v4-1-e117e6337bc7@kylinos.cn>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260722-riscv-bpf-timed-may-goto-v4-1-e117e6337bc7@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/7/22 12:21, Feng Jiang wrote:
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
> index 000000000000..f4bf2cd10586
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
> +	addi	sp, sp, -64
> +	sd	ra, 56(sp)
> +	sd	s0, 48(sp)
> +	addi	s0, sp, 64
> +
> +	/* Save BPF registers R0-R5 (a5, a0-a4) */
> +	sd	a5, 40(sp)
> +	sd	a0, 32(sp)
> +	sd	a1, 24(sp)
> +	sd	a2, 16(sp)
> +	sd	a3, 8(sp)
> +	sd	a4, 0(sp)
> +
> +	add	a0, t0, s5
> +	call	bpf_check_timed_may_goto
> +	mv	t0, a0
> +
> +	/* Restore BPF registers R0-R5 */
> +	ld	a4, 0(sp)
> +	ld	a3, 8(sp)
> +	ld	a2, 16(sp)
> +	ld	a1, 24(sp)
> +	ld	a0, 32(sp)
> +	ld	a5, 40(sp)
> +
> +	ld	s0, 48(sp)
> +	ld	ra, 56(sp)
> +	addi	sp, sp, 64
> +	ret
> +SYM_FUNC_END(arch_bpf_timed_may_goto)

I think we should use REG_S/REG_L/SZREG like in arch/riscv ([0]) – it 
keeps us in sync with upstream and will make it easier if we may later 
port timed_may_goto to RV32.

[0] arch/riscv/kernel/mcount.S
