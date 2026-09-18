Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FEF388E63;
	Fri, 18 Sep 2026 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694423; cv=none; b=hQr9q48OVGdr7X4Sky50ZBBkKjhSu1JWffD6ND07BkJbFp8ORQ5BDqMXkeDvYIs8IiedX6WARmQzp6hXmvhsOGkBsgVpCmQR6QIRlO4D2toXzzo8yv1gkDxYhfFiY8pc+dTjDgZzyhkmN05u+J9JTcXskzvxU0uDbQ84cpn2GVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694423; c=relaxed/simple;
	bh=vxM8j7eYcA1BWqfsM4Qk+N9UreBRtuXHS6deoiMRuM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RUeYM43UfoUhFRjRnoCtqmQuePGUgBT4MoU3lOJKQ4PZYmbK1AdNCVl8k7gdFpWZI7KtgDEr0G0oA+BZ+Iz4FdXBtO+zC4aumYSHSWDgmLv3tELJxY/beWYTFE9t3gGDQYspsQbdk+MS3EztxQDfjCSsJW3Eug6tK2emKkKsyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vEz/9fxh; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vEz/9fxh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hNVRr0M80noRKxyWstwDdP10shu7MYTQxvymByKOzhw=;
	b=vEz/9fxhFxK7TmUgnStNTZng0XNGGickUIHsjQzIWdJQ6lq70+BdUIahbmUx5KGMByz3QEUY4
	pnJBlEPCcb0qWZRJT0VHauQC9arBG97jVYvXZ5Y74i4oR3w/4tOO/EAZzjvcFvQ2ZB24XQrsVx5
	LA1Tg4Huzo6RmpNclavdNhs=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hmDzW1nKYzLlSh;
	Fri, 18 Sep 2026 09:09:11 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id EC6A64057A;
	Fri, 18 Sep 2026 09:20:10 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 09:20:10 +0800
Message-ID: <c28917c2-4715-4c70-a2d3-582ca641e1d6@huawei.com>
Date: Fri, 18 Sep 2026 09:20:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: patch: fix handling of bpf-jit execmem addresses
To: Wei-Jie Hung <imbigking12@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Alexandre Ghiti <alex@ghiti.fr>, Mike Rapoport <rppt@kernel.org>, Xiaofeng
 Yuan <xiaofengmian@163.com>, Klara Modin <klara@kasm.eu>,
	<linux-riscv@lists.infradead.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260914115607.350097-1-imbigking12@gmail.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260914115607.350097-1-imbigking12@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2026/9/14 19:56, Wei-Jie Hung wrote:
> Commit 8718e5a3090b ("riscv: patch: skip fixmap mapping when kernel text
> is already writable") gated the core_kernel_text() branch of patch_map()
> on CONFIG_STRICT_KERNEL_RWX, and explicitly left the vmalloc branch
> unchanged. That branch has a separate problem.
> 
> That branch only creates a temporary writable fixmap alias when
> CONFIG_STRICT_MODULE_RWX is enabled, and otherwise assumes the target is
> directly writable and returns the address unchanged. That assumption no
> longer holds: bpf_prog_pack_alloc calls set_memory_rox() on every pack
> unconditionally in alloc_new_pack(), independently of any
> CONFIG_STRICT_*_RWX option, so BPF text in the vmalloc area is read-only
> regardless of what CONFIG_STRICT_MODULE_RWX says.
> 
> With CONFIG_STRICT_MODULE_RWX=n, patch_map() returns the read-only
> address directly, the subsequent copy_to_kernel_nofault() takes a
> page fault and returns -EFAULT. bpf_arch_text_copy() turns that into
> -EINVAL, which propagates through bpf_jit_binary_pack_finalize() to the
> WARN_ON() in bpf_int_jit_compile() and leaves the program un-JITed.
> 
> Note that BPF cannot be fixed the way kprobes was in
> commit bdc46e507b59 ("riscv: mm: make EXECMEM_KPROBES writable without
> CONFIG_STRICT_MODULE_RWX"). EXECMEM_BPF is already PAGE_KERNEL, i.e.
> writable at allocation time; the read-only mapping is established
> afterwards by generic code in alloc_new_pack(), which arch code cannot
> influence. The only place this can be handled is patch_map().
> 
> This is the same problem that was fixed on arm64 by commit b1480ed230ac
> ("arm64: patching: fix handling of execmem addresses"), and the fix is
> the same: CONFIG_EXECMEM is what actually tracks whether the vmalloc
> area can hold executable memory that needs a temporary alias to be
> written. CONFIG_BPF_JIT, CONFIG_KPROBES and CONFIG_MODULES all select
> it.
> 
> Note that this is not limited to CONFIG_MODULES=n. Unlike arm64, riscv
> selects CONFIG_ARCH_OPTIONAL_KERNEL_RWX, so CONFIG_STRICT_MODULE_RWX can
> be disabled with CONFIG_MODULES=y as well, and the bug is reachable in
> that configuration too.
> 
> The !CONFIG_MMU build is unaffected: it has its own __patch_insn_set()
> and __patch_insn_write() implementations and never calls patch_map().
> 
> Fixes: 2c9e5d4a0082 ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of")
> Signed-off-by: Wei-Jie Hung <imbigking12@gmail.com>
> ---
> Based on riscv/fixes (b94cec5761d2).
> 
> Reproduced on qemu-system-riscv64 -M virt with CONFIG_BPF_JIT=y,
> CONFIG_BPF_JIT_ALWAYS_ON=y and CONFIG_STRICT_MODULE_RWX=n.
> ptp_classifier_init() builds a cBPF filter from sock_init(),
> so the failure happens during boot without any userspace involved:
> 
>    WARNING: arch/riscv/net/bpf_jit_core.c:156 at bpf_int_jit_compile+0x3dc/0x43e
>    Call Trace:
>     bpf_int_jit_compile+0x3dc/0x43e
>     __bpf_prog_select_runtime+0xec/0x186
>     bpf_prog_select_runtime+0x12/0x1a
>     bpf_prepare_filter+0x368/0x46a
>     bpf_prog_create+0x66/0x90
>     ptp_classifier_init+0x3e/0x60
>     sock_init+0xc4/0xe6
>     do_one_initcall+0x78/0x14a
> 
>    kernel BUG at net/core/ptp_classifier.c:227!
>    Kernel panic - not syncing: Fatal exception in interrupt
> 
> The BUG_ON() is reached because CONFIG_BPF_JIT_ALWAYS_ON=y turns the
> silent interpreter fallback into -ENOTSUPP. With
> CONFIG_BPF_JIT_ALWAYS_ON=n the failure is silent: writing 1 to
> /proc/sys/net/core/bpf_jit_enable and loading any program reproduces the
> same warning, but the program simply falls back to the interpreter and
> the kernel keeps running.
> 
> Tested with CONFIG_BPF_JIT=y:
>    - CONFIG_MODULES=n, CONFIG_BPF_JIT_ALWAYS_ON=y:
>      panics before this patch, boots after
>    - CONFIG_MODULES=y, CONFIG_STRICT_MODULE_RWX=n,
>      CONFIG_BPF_JIT_ALWAYS_ON=y: same panic before this patch, boots after
>    - CONFIG_BPF_JIT_ALWAYS_ON=n: the warning above is emitted when a
>      program is loaded from userspace before this patch, and gone after
>    - riscv defconfig (CONFIG_STRICT_MODULE_RWX=y): unaffected, boots
>      before and after
>    - kprobes (kretprobe on __riscv_sys_openat via kprobe_events):
>      works before and after this patch
> 
>   arch/riscv/kernel/patch.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 2239c28981bc..2b5adf01c550 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -48,7 +48,7 @@ static __always_inline void *patch_map(void *addr, const unsigned int fixmap)
>   		if (!IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
>   			return addr;
>   		phys = __pa_symbol(addr);
> -	} else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX)) {
> +	} else if (IS_ENABLED(CONFIG_EXECMEM)) {
>   		struct page *page = vmalloc_to_page(addr);
>   
>   		BUG_ON(!page);

Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Pu Lehui <pulehui@huawei.com>
