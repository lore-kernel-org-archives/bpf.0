Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442342;
	b=sX6xGtCww+I0qHeAgwQexhIQcWszz5eQM44uZGhovH5YIHRIOFO1cyTJkb2TC+SN7rMu
	 isnTlC54Ulj9E98sohn+jygRl0jnsasDe90zuNMNoxV+0L/Z6Rx2gqdpK7gNTmcbJwsne
	 SmZwZcM+y1d9vW0SBaGjHgAaDOrWfqXTKQsEzQHV5XFm/2i4mM932QKJHZPt3EEE8ltrm
	 AdsNWDgV+lp8gqdEOv/hhn9E4OwldhilsN78sr7blXek9/tnknIcKfv1N7ZtvEQULNGHT
	 izk/ms16N8Me7oyumH3DNa+bXn3woVLc7KF5nIwVgb2WAom3ljTu6yMeD5oggWPCKkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442342;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=rQrwLkWPs/sgcjrdJz7n1H9Y2d9Q/zNd6aYBgbEUAcY=;
	b=ELmTRhcGcw1acAXwTxKGTEalqzSvkhwM2JXK3eC9GiwPwLzTWhoG9hf2T2T0JKn43Hc/
	 zdF6t2/uBfn1tp2bV8H5PoOGCTRh1iEnWj39OMOdJuDddnuqgtyufIb8ssVWD7zIUl31X
	 Y9Qan5hjUoO2mgNx3sQRO+w9b+L8S+0CmKzn6uTasdb21IPpA5yvdiqzmdWJUrSDr0Bza
	 uH3ZIL/kuBgc7gfx415yJbAtHGtdjYFSFC6nLggKbdiinFJYq/p/t7n6nR0cz5JgBebLL
	 eZ3rVyTxy1Mj+4V+px56kEmn71qgoEbh/U33n4BdEorL4wBwjH9VtyslibpNEyxrTUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QR+ebvgP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FBB606A319
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QR+ebvgP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EE61F000C4;
	Mon, 19 Oct 2026 20:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792442342;
	bh=rQrwLkWPs/sgcjrdJz7n1H9Y2d9Q/zNd6aYBgbEUAcY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QR+ebvgP0H2BTw63eZwx2OfbwN6LcFQ94GnOI7+hARM5zKY0SL5DMU6egEr+r66/o
	 gb7y8xj79YYBA8AUMEhKLgMPkxDpaTjDX1Py8CA3JUzcafqQwxmADvGcMoIqHQgslQ
	 7qFpcQes/dxk3/2NsH8K7OMnQwoMDFNf5hiUaJxhOPOz6brl6SW5Rg7DCEWdGFotb4
	 9vbDGpQS2D1S0hQBzYrzDcpKrYeQgqNvIixzYjfluySyoobVKZbYU5xyHaoUCgEBrB
	 e8dZeRrn3v4jJq1K1BjKGkmKk9XzQYMaTbPv1/8ayQjAquaabAcxfhUzvLnlcNsf81
	 xlOkShL5HNkFw==
Content-Type: multipart/mixed; boundary="===============6021076871367193231=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c00cb40a9eeb29c7c4863e3e011f094899463d3f6cba9bc4d77192bbc4e195c6@mail.kernel.org>
In-Reply-To: <20261019201108.4552-2-emil@etsalapatis.com>
References: <20261019201108.4552-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Revalidate faulted arena pages before installing user mappings
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 20:39:01 +0000 (UTC)

--===============6021076871367193231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Revalidate faulted arena pages before installing user mappings

TL;DR: Possible NULL pointer dereference in arena_vm_fault(): returning
VM_FAULT_LOCKED for mapping-less arena pages may crash __do_fault() if a
memory failure poisons a mapped page right after the check.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 0ff707707da0..5e0e0837980b 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -584,8 +584,22 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>  	if (new_page)
>  		free_pages_nolock(new_page, 0);
> -	vmf->page = page;
> -	return 0;
> +
> +	/*
> +	 * A free clears the kernel pte and then takes the page lock before it
> +	 * zaps user vma-s. Either it waits for this fault and zaps its pte, or
> +	 * the page is gone from here.
> +	 */
> +	lock_page(page);
> +	if (vmalloc_to_page((void *)kaddr) == page && !PageHWPoison(page)) {
> +		vmf->page = page;
> +		return VM_FAULT_LOCKED;
> +	}
                ^^^^

Can this return path lead to a NULL pointer dereference when the page is
poisoned after this check?

Once arena_vm_fault() returns VM_FAULT_LOCKED, __do_fault() takes the
locked branch of its hwpoison handling, which assumes a page-cache folio
with a valid folio->mapping.  Arena pages come from
alloc_pages_node()/alloc_pages_nolock() and never get a mapping, so
folio->mapping is NULL.

The !PageHWPoison(page) test keeps already-poisoned pages out of that
branch, but it is a check-then-act sequence.  memory_failure() runs
TestSetPageHWPoison(p) before it takes a reference or the folio lock, so
holding the page lock here does not stop it from setting the flag.
__do_fault() then reads the flag again:

    ret = vma->vm_ops->fault(vmf);          /* arena: VM_FAULT_LOCKED */
    ...
    if (unlikely(PageHWPoison(vmf->page))) {
            vm_fault_t poisonret = VM_FAULT_HWPOISON;
            if (ret & VM_FAULT_LOCKED) {
                    if (folio_mapped(folio))
                            unmap_mapping_folio(folio);

and unmap_mapping_folio() does:

    struct address_space *mapping = folio->mapping;   /* NULL */
    ...
    i_mmap_lock_read(mapping);    /* down_read(&mapping->i_mmap_rwsem) */

A possible sequence:

1. Processes A and B mmap the same arena.  This is allowed, since
   arena_map_mmap() lets a second process use the same address.  Page P is
   already mapped by a user PTE in A, so folio_mapped(P) is true via
   folio_add_file_rmap_ptes() in set_pte_range().

2. B touches the same offset.  arena_vm_fault() locks P, sees
   vmalloc_to_page(kaddr) == P and !PageHWPoison(P), and returns
   VM_FAULT_LOCKED.

3. Before B's __do_fault() reads PageHWPoison(vmf->page), memory_failure()
   runs for pfn(P) on another CPU (MCE/GHES, madvise(MADV_HWPOISON) from A,
   or hwpoison_inject) and sets PG_hwpoison.

4. B's __do_fault() sees PageHWPoison, VM_FAULT_LOCKED and folio_mapped(),
   and calls unmap_mapping_folio() with a NULL mapping, which dereferences
   NULL in i_mmap_lock_read().

Before this patch the handler returned 0, so the poisoned branch in
__do_fault() only did folio_put() and returned VM_FAULT_HWPOISON without
touching folio->mapping.  The window is short, but this opens a crash path
during memory-error recovery.

tcmu_vma_fault() also returns VM_FAULT_LOCKED for mapping-less pages, which
suggests the mm core gap is latent elsewhere, but that does not make the
arena case safe.

Would it make sense to give arena pages a mapping the way fb_deferred_io
does, or to make the mm core skip unmap_mapping_folio() when folio->mapping
is NULL?

The following commit in the series (e49bf3a39cc3 "bpf: Fix arena race
between page free and alloc leading to incoherency") does not touch this
path.

> +	/* The page was freed meanwhile. Let the fault start over. */
> +	fault_ret = PageHWPoison(page) ? VM_FAULT_HWPOISON : VM_FAULT_NOPAGE;
> +	unlock_page(page);
> +	put_page(page);
> +	return fault_ret;
>
>  out_err_locked_memcg:
>  	bpf_map_memcg_exit(old_memcg, new_memcg);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39318700728
--===============6021076871367193231==--
