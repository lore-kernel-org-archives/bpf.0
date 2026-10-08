Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3628F5;
	Thu,  8 Oct 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791433591; cv=none; b=LrJjMaX6uqqeDlB46/8BnhGlTK63SndwbSNdHlKMMYB6ZMcVhji2pk8WFKxaz/ZcGvIxDQP0Ms5QPJVIYpaeXAhXLFDNKxVQCK9DkXwCer+SM7PS2Ydxb/0Y7Dsq8A9wQF73NqkwMPX8kvdAOMBgZwiL9PhTnjYepOYqLkTSgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791433591; c=relaxed/simple;
	bh=fKmC7isANeWSQkMFdzhABW3n8nX5aIVpn/6hyVkAaGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuX1j70DZfRQiDiEiDCpNUlS+gxDsFpq1cj206jA5dnkxjJR2oRfvjk074Of5fxt9/6p80HPMdaqholhNPG4hka6htV1DRmO9gLou1TnQlNXYM7RAMnrzV2CJ16R97Wt+kN7wbC9j0ZvFBSmY5EGp3y1Ks6NMjC59jwQwegqXjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j0bzW06SyzYQtmV;
	Thu,  8 Oct 2026 12:07:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 059EE40597;
	Thu,  8 Oct 2026 12:07:45 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDHPvkPF8dqUfGADA--.58498S2;
	Thu, 08 Oct 2026 12:07:44 +0800 (CST)
Message-ID: <d0a4c5f6-fb17-4f9b-9e5a-b42b0c5450db@huaweicloud.com>
Date: Thu, 8 Oct 2026 12:07:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf, arm64: Fix racy plt target update in
 bpf_arch_text_poke()
Content-Language: en-US
To: Matthew Wood <thepacketgeek@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261002121233.561368-1-thepacketgeek@gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20261002121233.561368-1-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHPvkPF8dqUfGADA--.58498S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4xXryfXrWkurWDWFWrGrg_yoWrAF15pF
	yjvrnIkr4qgFWDArs7K3WUXF1rZw4kWrsrCr9ak34rCay5XrySvryrKw13Crs8Cr98u3s5
	ZFWjv3sxZa1DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
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

On 10/2/2026 8:12 PM, Matthew Wood wrote:
> When a long-jump trampoline is attached to or detached from a bpf prog,
> bpf_arch_text_poke() updates the plt target at the end of the prog by
> temporarily making the page writable:
> 
> 	set_memory_rw(page);
> 	WRITE_ONCE(plt->target, plt_target);
> 	set_memory_ro(page);
> 
> Since commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory
> management"), bpf progs are allocated from the bpf prog pack, so
> unrelated progs and their plts commonly share a page. The sequence
> above is not serialized against other pokers, it runs before text_mutex
> is taken and callers only hold the lock of the trampoline being
> updated. Two CPUs attaching to or detaching from different target progs
> in the same page can therefore race:
> 
> 	CPU A                           CPU B
> 	set_memory_rw(page)
> 	                                set_memory_rw(page)
> 	                                WRITE_ONCE(plt_B->target, ...)
> 	                                set_memory_ro(page)
> 	WRITE_ONCE(plt_A->target, ...)  <- permission fault
> 
> This was hit on an arm64 server with 64K pages while attaching fentry
> programs to bpf progs:
> 
>    Unable to handle kernel write to read-only memory at virtual address ffff80008f46d5f8
>    ESR = 0x000000009600004f
>    FSC = 0x0f: level 3 permission fault
>    pte=00c00200ea5a0783
>    Internal error: Oops: 000000009600004f [#1]  SMP
>    pc : bpf_arch_text_poke+0x214/0x238
>    lr : bpf_arch_text_poke+0x200/0x238
>    Call trace:
>     bpf_arch_text_poke+0x214/0x238 (P)
>     __bpf_trampoline_link_prog+0x1c8/0x470
>     bpf_trampoline_link_prog+0x64/0x90
>     bpf_tracing_prog_attach+0x318/0x4a8
>     bpf_raw_tp_link_attach+0x104/0x258
>     bpf_raw_tracepoint_open+0x6c/0x90
>     __sys_bpf+0x134c/0x3e10
> 
> Rather than serializing the permission changes, stop changing page
> permissions altogether and write the plt target with
> aarch64_insn_write_literal_u64(). It writes through the text patching
> fixmap under patch_lock, the same way the rest of the prog pack is
> written, and performs a single-copy atomic 64-bit store. The plt target
> is naturally aligned (see build_plt()), so CPUs concurrently executing
> the plt still observe either the old or the new target. This is the
> same helper ftrace and static calls use to update 64-bit literals that
> are loaded concurrently.
> 
> Fixes: 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
> ---
> Changes in v2:
> - Replace page permissions change with call to aarch64_insn_write_literal_u64
> - Link to v1: https://lore.kernel.org/linux-arm-kernel/CADvopvZPO1gDMDhDOPcArjRJ0cPpSUZ5suMg-1kwRi+_-Xeitw@mail.gmail.com/
> ---
>   arch/arm64/net/bpf_jit_comp.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 475e70653454..e353403cc1c3 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3339,13 +3339,15 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>   		plt_target = (u64)&dummy_tramp;
> 
>   	if (plt_target) {
> -		/* non-zero plt_target indicates we're patching a bpf prog,
> -		 * which is read only.
> +		/*
> +		 * non-zero plt_target indicates we're patching a bpf prog,
> +		 * which is read only. The prog shares its page in the bpf
> +		 * prog pack with other progs, so write the aligned target
> +		 * through the text patching fixmap without flipping the
> +		 * page permissions to avoid racing with concurrent pokers.
>   		 */
> -		if (set_memory_rw(PAGE_MASK & ((uintptr_t)&plt->target), 1))
> +		if (aarch64_insn_write_literal_u64(&plt->target, plt_target))
>   			return -EFAULT;
> -		WRITE_ONCE(plt->target, plt_target);
> -		set_memory_ro(PAGE_MASK & ((uintptr_t)&plt->target), 1);
>   		/* since plt target points to either the new trampoline
>   		 * or dummy_tramp, even if another CPU reads the old plt
>   		 * target value before fetching the bl instruction to plt,


I think it's better to combine the two nested if statements into one, and merge
the two comments into a single comment above the new if statement.

Otherwise lgtm.

> --
> 2.53.0-Meta

