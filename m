Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDEA18872A;
	Tue, 14 Apr 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131770; cv=none; b=q336/pKtBNC3s8ck0CBO0rr9OaYIblDe2btBG3UCYKBEPlEm1onH1l9kR8uPcpOylazMtCDVhPAotil4R4eMoPmBigW6bnMQjgFd4P6RXma15vnHq+KcO6JZZ/wWTgK8CUp/VroB47lHebbVgJo4zcPO0eFVGYRHpPRozO94D08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131770; c=relaxed/simple;
	bh=ItPy1oQpcpGjY0Gg8wUVBWhosSWFD5AmyaCgapicLN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyssZsQmOnp2eLGtuo2QGkzLWxedrP4Ar44F7JoegT6CUdOuK/pD6XqbYYy1i02n7RK/TM4OdrLna7ANyTF+vYO/Ps3n8Nrj1fZhIhfEr5eA1yWM1C6jBvJRK94YvI73XCSe9MhJz/sZ77gKGV94/ASapyTimwsQVOzKYeocOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fvnR64ZfHzYQtHY;
	Tue, 14 Apr 2026 09:55:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 35E1C4056E;
	Tue, 14 Apr 2026 09:55:58 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgC3Y72snt1pNblOAQ--.13774S2;
	Tue, 14 Apr 2026 09:55:57 +0800 (CST)
Message-ID: <dd645fcf-76dc-4c68-8b6f-1a168cafd44f@huaweicloud.com>
Date: Tue, 14 Apr 2026 09:55:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf, arm64: Remove redundant
 bpf_flush_icache() after pack allocator finalize
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260413191111.3426023-1-puranjay@kernel.org>
 <20260413191111.3426023-2-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260413191111.3426023-2-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3Y72snt1pNblOAQ--.13774S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4xJw15ZFW7GrWkZr18Krg_yoW5Gw4UpF
	ZrCwnIkrs5WrW8W3WUJF4xAF1Svw4kJFW3Kas8Ca4Iv3Z0v3s7KFy5Kw1rGFZ8ArW5uw47
	ZFW7trn8u3WDXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/14/2026 3:11 AM, Puranjay Mohan wrote:
> bpf_flush_icache() calls flush_icache_range() to clean the data cache
> and invalidate the instruction cache for the JITed code region. However,
> since commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> management"), this flush is redundant.
> 
> bpf_jit_binary_pack_finalize() copies the JITed instructions to the ROX
> region via bpf_arch_text_copy() -> aarch64_insn_copy() -> __text_poke(),
> and __text_poke() already calls flush_icache_range() on the written
> range. The subsequent bpf_flush_icache() repeats the same cache
> maintenance on an overlapping range, including an unnecessary second
> synchronous IPI to all CPUs via kick_all_cpus_sync().
>

So icache is flushed twice: once per instruction and again after all
instructions are copied. I think it's better to remove the per-instruction
flush and retain the single final flush to avoid repeating flush overhead
for each instruction.

> Remove the redundant bpf_flush_icache() call and its now-unused
> definition.
> 
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   arch/arm64/net/bpf_jit_comp.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index adf84962d579..7417d24a5b6f 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -18,7 +18,6 @@
>   
>   #include <asm/asm-extable.h>
>   #include <asm/byteorder.h>
> -#include <asm/cacheflush.h>
>   #include <asm/cpufeature.h>
>   #include <asm/debug-monitors.h>
>   #include <asm/insn.h>
> @@ -1961,11 +1960,6 @@ static int validate_ctx(struct jit_ctx *ctx)
>   	return 0;
>   }
>   
> -static inline void bpf_flush_icache(void *start, void *end)
> -{
> -	flush_icache_range((unsigned long)start, (unsigned long)end);
> -}
> -
>   static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
>   {
>   	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
> @@ -2204,12 +2198,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>   			prog = orig_prog;
>   			goto out_off;
>   		}
> -		/*
> -		 * The instructions have now been copied to the ROX region from
> -		 * where they will execute. Now the data cache has to be cleaned to
> -		 * the PoU and the I-cache has to be invalidated for the VAs.
> -		 */
> -		bpf_flush_icache(ro_header, ctx.ro_image + ctx.idx);
>   	} else {
>   		jit_data->ctx = ctx;
>   		jit_data->ro_image = ro_image_ptr;

