Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792615305;
	b=e7SEGSmp1OGeOht5huWaH4JmXKWU85515MTIoMfduLuSwgY5I0gGOIXUsb/8uelGS1Qo
	 xWzYMAnJ4RO4AOaw4JMJdUiSDXaUbvIhYxqUvwFgCOsaDA2DcN2vTYPC5bMheEyqePWZP
	 HVQkTU56vHbcpjBspa5yENR1xI1m+X74Wt/8bZilgTKdrQq+zmpLkdaQf40LHsZlfhVIr
	 UC0glM9eosv3kuaMXIdTmz6ukiyt/MLE+FTZiDPRWqEptD62l/CPOF2ypcoc2XG0HrPby
	 kqQZq+wBrskys+sbMPSKWImLfViIQD6RrWDmQ8vC4jsHJ10daAXXSR/xuOkFsd+0LpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792615305;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Bq3V9J9F4ZHKrQtjacM7Tw7YXz58yMhcGPTw8dbAFrA=;
	b=aKmTQhCf5K+icSHoGTIxBDc8p8R8W/8wHgXzhjSyGS8IpycxoQ9mvWYOyUS6ZF/4/xxp
	 hwsW7J07uXoW6vTCBIePhdKb8cBMc2Q5jJbF2JQ4BLCvzAO+UZucIsZ4/OTx4WA5em7rn
	 YNkD5RG5t/BnV9xibfj6KUzVObCvcRbBgP0KLjfvay6AkcJ+RYbBwAEbgwGEOviU5W+GB
	 jNd1FqTVVaTyRy7NymKN748cLArzc/mUCmeogW8V2bYCflc7WzJqs7FtQPS+MAM5MjaGB
	 5RRWDa1QGddLy0EuLaXnmDm/NfgnTYtQvpKwGMhmcG4Q24AkKXJgXTd7nfwhaWMXB6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVPYEOJF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2D606A319;
	Wed, 21 Oct 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVPYEOJF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1411F000C1;
	Wed, 21 Oct 2026 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792615304;
	bh=Bq3V9J9F4ZHKrQtjacM7Tw7YXz58yMhcGPTw8dbAFrA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OVPYEOJFHxyq2Jn+Mw16KBU0u4plWBYpqFAxZfQIetwIc4UlXVDL+weM0LK9cj2UC
	 RC8KozZM3bGjca4q5PGzfvxdvRwJkWOWFr6SOq4BzyWUPITiKI+LTe8X4uRMjUNDux
	 o0kFUr2WR0J0IuQvKhY7daAWRScMmQNEfuGX59yDrN/yz3Hl/bb5wylqgz1rXnJ+Ur
	 /wF7jX7kB1baY0FPJKzEoyCnvxxQdcgleWPu3ZsAxN84jz62ON9Shl1lw5DnEbGgH1
	 K1xe68vud9jyiFi7OU8IJFoVYDnBTVZsrdy2H4RReHnjjJZsPrfO+X/SdQsVJCsXVB
	 B/Xex9h+p1tyg==
Content-Type: multipart/mixed; boundary="===============3655339663897498520=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ff53ef1657f7ecedb34c148ab05588f657dac0d092ffb55923d7bc6fd375bf84@mail.kernel.org>
In-Reply-To: <20261021195759.119421-5-jolsa@kernel.org>
References: <20261021195759.119421-5-jolsa@kernel.org>
Subject: Re: [RFC bpf-next 4/9] bpf: Add kfuncs to allocate and seal user pages
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: bpf@vger.kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,linux-mm@kvack.org,akpm@linux-foundation.org,liam@infradead.org,ljs@kernel.org,linux-kselftest@vger.kernel.org,shuah@kernel.org,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 20:41:43 +0000 (UTC)

--===============3655339663897498520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add kfuncs to allocate and seal user pages

TL;DR: bpf_user_page_exec() may skip the icache flush on arm64/riscv, since
flush_icache_user_page() runs before VM_EXEC is set, so with THP a task could
execute stale instructions.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4d9e9423826a..246f4969a144 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -3739,6 +3743,127 @@ __bpf_kfunc int bpf_copy_from_user_mm(void *dst, u32 dst__sz,

[ ... ]

> +__bpf_kfunc int bpf_user_page_exec(unsigned long addr)
> +{

[ ... ]

> +	err = get_user_pages(addr, 1, FOLL_WRITE, &page);

[ ... ]

> +	flush_icache_user_page(vma, page, addr, PAGE_SIZE);
> +	err = do_mprotect_pkey_locked(addr, PAGE_SIZE, PROT_READ | PROT_EXEC, -1);

Does flush_icache_user_page() do anything here on the architectures that
need it?

At this point the VMA is still the read/write mapping created by
bpf_user_page_alloc(), so VM_EXEC is not set yet.  On riscv the macro is:

    #define flush_icache_user_page(vma, pg, addr, len)  \
    do {                                                \
            if (vma->vm_flags & VM_EXEC)                \
                    flush_icache_mm(vma->vm_mm, 0);     \
    } while (0)

so it is skipped, and VM_EXEC only gets set by the
do_mprotect_pkey_locked() call on the next line.  arm64 does not define
flush_icache_user_page(), so it falls back to the empty stub in
include/asm-generic/cacheflush.h.

That leaves only the set_ptes() hook that runs when change_pte_range()
installs the read/execute PTE.  On arm64 it is
__sync_cache_and_tags()->__sync_icache_dcache(), and on riscv it is
__set_pte_at()->flush_icache_pte().  Both only do cache maintenance when
PG_dcache_clean is clear on the folio, and then set it for the whole folio:

    if (!test_bit(PG_dcache_clean, &folio->flags.f)) {
            sync_icache_aliases(folio_address(folio),
                                folio_address(folio) + folio_size(folio));
            set_bit(PG_dcache_clean, &folio->flags.f);
    }

The BPF program writes the instructions through the user address with
bpf_probe_write_user_faultable(), which uses copy_to_user() and never calls
flush_dcache_folio(), so PG_dcache_clean is not cleared again after the
first exec mapping of the folio.

With THP enabled (arm64 or riscv, 4K pages), can this sequence happen?

  bpf_user_page_alloc(512) returns a PMD-aligned address
  the program writes page 0, and the fault maps a 2MB anonymous THP
  bpf_user_page_exec(addr) splits the VMA and the PMD, the read/execute
    set_ptes() for page 0 syncs the whole 2MB folio and sets PG_dcache_clean
  the program writes code into page 1, which is still read/write
  bpf_user_page_exec(addr + PAGE_SIZE) calls flush_icache_user_page() again
    as a no-op, and the read/execute set_ptes() sees PG_dcache_clean set and
    skips maintenance

The task would then execute page 1 without a D-cache clean to the point of
unification and I-cache invalidate (arm64 without CTR_EL0.IDC/DIC), or
without fence.i (riscv), and could fetch stale instructions.  mTHP sizes
give the same result for smaller allocations.

The uprobe XOL code, which also writes instructions for user space, does
explicit maintenance through the kernel alias: arm64 arch_uprobe_copy_ixol()
calls sync_icache_aliases(), and riscv, loongarch and mips call
flush_icache_range() on the kmap address.

Should bpf_user_page_exec() do the same, for example with
kmap_local_page(page) followed by flush_icache_range()?  Alternatively,
would calling flush_dcache_page(page) before the mprotect, so the arch
set_ptes() hook redoes the sync, be enough?  Either way the flush would no
longer depend on VM_EXEC being set at the time of the call.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39668036298
--===============3655339663897498520==--
