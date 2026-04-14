Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221C469D;
	Tue, 14 Apr 2026 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776129241; cv=none; b=K4QUXKo9BUaCOpghZ5esp2riaXFN7dFJGvgyWFsg41+fTr0KOn4rAZCY6qvqy83YHPCfwxjXOpy6iN6enNJFgneXyiQ8th6OfWR45tvTiFdUCAJxUbzMSzcOoaTuq6CZwF/cXi2Rqr7bUY91pqcCWzgRlSC1aPzQd6Dt1Z8kvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776129241; c=relaxed/simple;
	bh=siOyvlXkkttU8z1OxyRt7Dj35Jt/Voon0GJe4XIX2Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OwQDssPgfX8HUOqsZKUU2UQ8WfKqezqm1Wzx2yLrB0W/LbjylescE80XGNlfSAugQZGglecAzzUGvdMA+8sADOinNYDLCOumMBgWRCd++oyXoepsR4yuV7QM6xA+DSrQ+c2qLzlFD3CyUefe2KEHUMQnzukGkrLTiLEVNwEltDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jNL5kmCI; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jNL5kmCI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wwwLs654l6TRJx+paG/bUIxIbs35+7AXfMc8chQ7/iU=;
	b=jNL5kmCIIYuPd/zWkmUvcDYti0PpsMK3r+eFp8ifV+x4+kUvvvPWqueyqpi3wazbxRtJDbNnx
	jM6gs6FqE8r/a/vYMqMlLqm8i+y1lxnRFLoviW2QICVez8WwbinZGnOX+VAqBKE4qNKuRGeAzWN
	YPmcDRp6rPzklYWl6CHxNG4=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fvmNK50yzzpSvH;
	Tue, 14 Apr 2026 09:07:45 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id CD6AE40561;
	Tue, 14 Apr 2026 09:13:55 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 14 Apr
 2026 09:13:54 +0800
Message-ID: <775f4b9f-2bf4-4e6b-be7a-094e8f9528c2@huawei.com>
Date: Tue, 14 Apr 2026 09:13:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] bpf, riscv: Remove redundant
 bpf_flush_icache() after pack allocator finalize
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Xu Kuohai
	<xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
	<xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260413191111.3426023-1-puranjay@kernel.org>
 <20260413191111.3426023-3-puranjay@kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260413191111.3426023-3-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/4/14 3:11, Puranjay Mohan wrote:
> bpf_flush_icache() calls flush_icache_range() to clean the data cache
> and invalidate the instruction cache for the JITed code region. However,
> since commit 48a8f78c50bd ("bpf, riscv: use prog pack allocator in the
> BPF JIT"), this flush is redundant.
> 
> bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
> region via bpf_arch_text_copy() -> patch_text_nosync(), and
> patch_text_nosync() already calls flush_icache_range() on the written
> range. The subsequent bpf_flush_icache() repeats the same cache
> maintenance on an overlapping range.
> 
> Remove the redundant bpf_flush_icache() call and its now-unused
> definition.
> 
> Fixes: 48a8f78c50bd ("bpf, riscv: use prog pack allocator in the BPF JIT")
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/riscv/net/bpf_jit.h      | 6 ------
>   arch/riscv/net/bpf_jit_core.c | 7 -------
>   2 files changed, 13 deletions(-)
> 
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 632ced07bca4..da0271790244 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -11,7 +11,6 @@
>   
>   #include <linux/bpf.h>
>   #include <linux/filter.h>
> -#include <asm/cacheflush.h>
>   
>   /* verify runtime detection extension status */
>   #define rv_ext_enabled(ext) \
> @@ -105,11 +104,6 @@ static inline void bpf_fill_ill_insns(void *area, unsigned int size)
>   	memset(area, 0, size);
>   }
>   
> -static inline void bpf_flush_icache(void *start, void *end)
> -{
> -	flush_icache_range((unsigned long)start, (unsigned long)end);
> -}
> -
>   /* Emit a 4-byte riscv instruction. */
>   static inline void emit(const u32 insn, struct rv_jit_context *ctx)
>   {
> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index b3581e926436..f7fd4afc3ca3 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -183,13 +183,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   			prog = orig_prog;
>   			goto out_offset;
>   		}
> -		/*
> -		 * The instructions have now been copied to the ROX region from
> -		 * where they will execute.
> -		 * Write any modified data cache blocks out to memory and
> -		 * invalidate the corresponding blocks in the instruction cache.
> -		 */
> -		bpf_flush_icache(jit_data->ro_header, ctx->ro_insns + ctx->ninsns);
>   		for (i = 0; i < prog->len; i++)
>   			ctx->offset[i] = ninsns_rvoff(ctx->offset[i]);
>   		bpf_prog_fill_jited_linfo(prog, ctx->offset);

Reviewed-by: Pu Lehui <pulehui@huawei.com>
