Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584131;
	b=pEAQNRjCMNlME/ZVYt3IQ6lZ1XRPyZmCmlcR+nEsQFQhge1XjVNrcJ9ADhFWAnOezndi
	 EgK9NkSGlPM4yQDuE/I7DWFksJC0U//2RZN/YexL/IW+WJ2qYBiOw2T25wRHz8SV83OwH
	 tzqml3KpyZxLSUiDEYSvgX6LkT5V/dD72Pt6q7OTX4zxwEhmAR8SR47ohRHMSfKeB15Br
	 L3VHV7aJ8JUb76ZALn9g2qMTQmiLshaTEOT/22CBeqVEf3xekcj/y4V8XoctxB0EFBlXC
	 de3XHu2+OG3AZsTA01ijjbtZxmcJIkAlAG98Dtw4KD1dBD87nu3ELM304e9qi8RSnBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584131;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=TB7v9N/W2xTmNch7MkNivf/9UIfr6xOKYhQd3i+ONPg=;
	b=Nkrt2Fj+8S8NsTQI/v+QhMIjIeH8uEsO2+/rXkrDnoAeUPaJGlQRzfbsT/WkUj/p8rhB
	 6Ur6W5c/dZAJCjosGmzkGQvadJnyBzajR3qu1JtKOGBXwcn+VawIW4C94CqpO5YRGUXuF
	 ZMFfPUSUOsFMqKDS5BwE2FzBb8pOc2MIulkFazWX0RBRK9mEz5VD5t3m/nsiENlgR06Ly
	 ht63k4jy0TXQD3n1N340wUOirwsfURrMHdfYAzD+Dsr4YXu8dCpFRQ47vuM0NtWz30scc
	 RVwQ6I8X1hT/T2xkXiecbfcC1zFxUQnuq6rgyhpNLKvNynyRyLoxMShuHSLNTqZTA1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTb0PsEY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AAA606A322;
	Wed, 21 Oct 2026 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTb0PsEY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDDE1F000C9;
	Wed, 21 Oct 2026 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584131;
	bh=TB7v9N/W2xTmNch7MkNivf/9UIfr6xOKYhQd3i+ONPg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oTb0PsEYgwLw1y9tW1PiZ51FoiwOLqMvmA1ZNC242x9QOenanDFnyvuYdUAeVQ/Rn
	 c2yAVy2IuhgPC35XIHJrcGXEWcQtaCr7K9R8jWFIWJx6OJh+luQtc1j/qEMlyU0ydt
	 ZLOGzrVG5IDe9cyrOfb1infJBUv6P4UVyHzvYtDhWsiZNAlrkAtb6ApxrtB8TQrWxa
	 tkTzQPC5PNL+3JMw9qPYvjZv2DD/sg4njywHCpRYzue+MLWOpZMqP326KSW7dDmF80
	 3/SsINkZNkwf4y74LDrfjP69m8FuI48RDqx7JM+ZxAHvVDxjPcEG3AZO5R3/EXlMea
	 n5YtHaDeqWe/g==
Content-Type: multipart/mixed; boundary="===============5182620710229058046=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c4c7baf05581e93321e536d935a27b4c1da8b7d8879852664864bff8d3b269a2@mail.kernel.org>
In-Reply-To: <20261021112437.1799213-3-zhen.ni@easystack.cn>
References: <20261021112437.1799213-3-zhen.ni@easystack.cn>
Subject: Re: [PATCH v3 2/7] mm/page_owner: protect page access with mem-hotplug read lock
From: bot+bpf-ci@kernel.org
To: zhen.ni@easystack.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,akpm@linux-foundation.org,vbabka@kernel.org,surenb@google.com,mhocko@suse.com,brendan.jackman@linux.dev,hannes@cmpxchg.org,ziy@nvidia.com,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-mm@kvack.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,zhen.ni@easystack.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 21 Oct 2026 12:02:10 +0000 (UTC)

--===============5182620710229058046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> mm/page_owner: protect page access with mem-hotplug read lock

TL;DR: read_page_owner() holds the mem-hotplug read lock across
copy_to_user(); a page fault there may deadlock against mmap_lock (lock-order
inversion with memremap_pages callers) and userspace can stall hot-remove
indefinitely.

> diff --git a/mm/page_owner.c b/mm/page_owner.c
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c

[ ... ]

> @@ -831,7 +843,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>
>  	/* Find an allocated page */
>  	while (page_owner_next_eligible(&scan)) {
> -		struct page *page = pfn_to_page(scan.pfn);
> +		struct page *page;
> +		ssize_t ret;
> +
> +		/*
> +		 * The scan is lockless. Re-resolve the page under a mem-hotplug
> +		 * read-side lock so that we never access a hot-removed section.
> +		 */
> +		get_online_mems();
> +		page = pfn_to_online_page(scan.pfn);
> +		if (!page)
> +			goto skip_continue;

[ ... ]

> @@ -851,10 +873,13 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  		/* Record the next PFN to read in the file offset */
>  		*ppos = scan.pfn + 1;
>
> -		return print_page_owner(buf, count, scan.pfn, page,
> +		ret = print_page_owner(buf, count, scan.pfn, page,
>  				&scan.po_snap, scan.po_snap.handle, state);
> +		put_online_mems();
> +		return ret;
                ^^^^

Can this deadlock against mmap_lock?  read_page_owner() now holds the
mem_hotplug_lock reader across the whole print_page_owner() call, and that
includes the copy_to_user() of the formatted record:

print_page_owner()
    ...
    if (copy_to_user(buf, kbuf, ret))
            ret = -EFAULT;

Once kbuf is formatted, nothing in that copy touches struct page, so the
reader isn't needed there.  A user page fault on buf taken inside this
region takes current->mm->mmap_lock for read (on x86 a fault from
kernel-mode uaccess always does, see the 'goto lock_mmap' path in
arch/x86/mm/fault.c for !FAULT_FLAG_USER), and __might_fault() records that
dependency for lockdep.  That creates the lock order:

mem_hotplug_lock(R) -> mmap_lock(R)

The opposite order already exists in the tree.  Code that hotplugs device
memory while holding mmap_read_lock goes through memremap_pages() ->
pagemap_range() -> mem_hotplug_begin(), which does cpus_read_lock() and then
percpu_down_write(&mem_hotplug_lock):

nouveau_svmm_bind()
    mmap_read_lock(mm)
    nouveau_dmem_migrate_vma()
      nouveau_dmem_migrate_chunk()
        nouveau_dmem_migrate_copy_one()
          nouveau_dmem_page_alloc_locked()
            nouveau_dmem_chunk_alloc()
              memremap_pages()

lib/test_hmm.c:dmirror_migrate_to_device()
    mmap_read_lock(mm)
    dmirror_migrate_alloc_and_copy()
      dmirror_devmem_alloc_page()
        dmirror_allocate_chunk()
          memremap_pages()

With three threads sharing one mm, could this sequence occur?

T1 read(page_owner):
    get_online_mems(), then copy_to_user() faults on buf
T2 SVM bind ioctl:
    holds mmap_read_lock(mm), blocks in percpu_down_write(&mem_hotplug_lock)
    waiting for T1
T3 mmap()/munmap():
    queues on mmap_write_lock(mm) behind T2
T1 fault:
    mmap_read_lock(mm) blocks behind T3

None of these waits has a timeout.  While T2 waits it also holds
cpus_read_lock(), so CPU hotplug writers and every later get_online_mems()
caller stall too.

Even without that cycle, the reader can now be held for as long as
userspace wants.  A buf backed by userfaultfd or by a slow or remote file
mapping could stall memory hot-remove for an unbounded time.  Does that
match the commit message claim:

    "Taking the lock per-page bounds the writer's wait to a single page's
    check-and-deref, keeping hot-remove stalls brief while all accesses stay
    protected."

For comparison, ptdump_walk_pgd() already takes get_online_mems() followed
by mmap_write_lock(current->mm).  This new instance sits on a much more
commonly used debug path, and here the lock isn't needed around
copy_to_user() at all.

Would it work to format the record under the reader (or snapshot the
page-derived fields: pageblock migratetype, page->flags, memcg info), call
put_online_mems(), and only then call copy_to_user()?  The kmalloc() in
print_page_owner() could also move outside the locked region.

The last commit in the series (5b123f2cd336 "selftests/bpf: add tests for
the page_owner bpf_iter target") still calls print_page_owner() under the
reader, so the series does not address this later.

>
>  skip_continue:
> +		put_online_mems();
>  		scan.pfn++;
>  		cond_resched();
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39593164040
--===============5182620710229058046==--
