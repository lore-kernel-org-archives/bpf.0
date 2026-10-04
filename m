Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF341DED5;
	Sun,  4 Oct 2026 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791154339; cv=none; b=QRjAr7DW6aLWruzoaOC+WHJIv1dmggVHDDei+R5gvI6LJfK8kVTUEZHSYvOpjRMtPgssnTX4E4Fw96bmTM08HWCmqcnXJjqlE5YoiRlsxUdg6kNeHwJuWZJtPeBNDrc55KQZQEBvlndgSY26sDnHmrLXny1XkvVAyy+ImPUI0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791154339; c=relaxed/simple;
	bh=1YpIQPJxSeEWFFpDwNEi3RFPDu7ZYURr8aCIeXi2MkY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rx0kqa/bK4l5PCEsUqITHEwksejT8OhE/6+IkGokAC76jYjzUo9Ff6xDuOqoTP3s3wa/o1sgMpGqdisdW+Oem4Bp3vX94yHqP6kph4uVLUZHzIhucJRYAwD5vPgGhXxw83D934hV4lrEp6hAeAJAAFG4bSq6UZDvBzLOkHPrJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwgN3X7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwgN3X7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80A71F000FF;
	Sun,  4 Oct 2026 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791154336;
	bh=0g2Vd/WGDWx11Z5eDEYlSIfjJcLTcCv15IHzPL8eEL8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=lwgN3X7IEPZrn04fjF+jM8fK5uE4aKHBKxjxKoexZ17Zug641RRd8T0s+2+Hq0fxT
	 nhSzRlir695dbO4XRQ2NXQsG9vPMLy3cbt6QEfbvmLzyunDdwwqamlky1L271Kdo9R
	 HIz5cBFDWwX+0SssHEAaBeq9fmdMylzrV2GLogS3PVfDF2dCqdzTKg7JXEXuHW2fCJ
	 teOx/VyZCfPmU6kExhAloJQ7GUfCL4u8NysKbnAjUZ0UWLOTQA5pqsoxwOvWyeSvFe
	 A8WJSrC86sT6PkrH8yhbd1F8VpKEL4/uqYDTBHFtPVFFHiIUzTNdoyd22ncTCiyk4i
	 JeouYLX8Hkjjw==
Date: Sun, 4 Oct 2026 16:52:12 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Wei-Jie Hung <imbigking12@gmail.com>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
    Mike Rapoport <rppt@kernel.org>, Xiaofeng Yuan <xiaofengmian@163.com>, 
    Klara Modin <klara@kasm.eu>, linux-riscv@lists.infradead.org, 
    bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: patch: fix handling of bpf-jit execmem
 addresses
In-Reply-To: <20260914115607.350097-1-imbigking12@gmail.com>
Message-ID: <19ff2b67-55e9-92f2-5bee-57d36a9074c4@kernel.org>
References: <20260914115607.350097-1-imbigking12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 14 Sep 2026, Wei-Jie Hung wrote:

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

Thanks, queued for v7.3-rc.


- Paul
