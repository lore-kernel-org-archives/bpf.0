Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB153803F4
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 23:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095116; cv=none; b=Aw0q6sk0p7NxpGSMWNrnH0j8otIGdD0SgLbReuI2o2N3iP7tFqaPUh3BDBZv9j9GLR0W52YhAisduPZm/Is5revMVIEN5kbS+ySy0+YS5LpXGArBSasv6jviWBauJJ4/0SJ+zBjJ4mHqFu1c4V3vG+DNEciajiAGx5q4GmYfXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095116; c=relaxed/simple;
	bh=MEPpXyDD2yM8XuU1/JIlr4bR98o+GPv/YzF6OkvAOs0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=RNv7LFjsfCz+Qc6NfMxbB+JgszVu0JiEz/HjYF5jo6+lgUlik8VQBsmnZyfyLcyrLrQdVAy1A2WBOey1PKjt4iGzBtc0ZJfz4+9EW9wVJ7awzIi4uuhfypaosKCRjdLi81rXsaqbHMw2s21BLt4MvswREpv8qdVhQqHNvWMJQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ogq+l76a; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ogq+l76a"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so622761a91.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 16:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787095111; x=1787699911; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FSh4v7e+Hfv1szWaqI/qmJdvU291yDZq8xvu03yI1qM=;
        b=ogq+l76aAvtZPPGn4b1v+hHP1T4HOIS9gCYENDY4WU1DlewbxnA7Tmlv75ZZTajH0w
         QdCwSKbChzb5DYJERUPs6pT3jY3c7/6VTKCInP3y8uocU+/Yq7kUtqBZsxY+VSg1qDYB
         62qegGzYmHKgfbxEAj23ayVq4suZKLXD1FoalNrDF8PijkU8HEGkY0z6VBd7uQUOlhQP
         OQx+lUwuAAi4QX8ohciWXTZtRDS6TV5bZGUmh2ZTSxy7+pR6J5jbpeFENGllAFI3k6zg
         oFd4UqvfV6xRTLms6c61G0MLaORffLOVswM09oV1ZNlxH+kG2kGus/DPlxlPr9sk/skt
         YqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787095111; x=1787699911;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FSh4v7e+Hfv1szWaqI/qmJdvU291yDZq8xvu03yI1qM=;
        b=KFvJ2VHUIP1ftyNDG1iLgCjEu7Bjl99r5eFqQmcJWVjT+xwx5EouxFscSAU6KLRF3D
         5pqWp8LNtAgoAb9x7J/ogc89Yku+0FUVMUySj0HHMwlImqrc06qR5FstfETfZGlaO9Ls
         6JHInrCorfEXyl66iXeg5Pfj5OIBCNtp2ps2VCjEqPbKU6CfeK5znmcquNYlAgJFrKV7
         AMYrxHjz33pqH0fL67s8mbU/9IAeXvgFGtwzAYsyIf94ZSR8J68RNGgmHU5HZ00AFc2j
         A6oOSF8CgjYB+C4Yd/z7MSkk5XtJgeJ2pqxRYXfnojXNrGAvvVrHmcNf448lofbC/uKJ
         r6Eg==
X-Forwarded-Encrypted: i=1; AHgh+RrAvnWPArv9tJ/bhagvuYTRpyleyrWDXRl8kasURBvy1oxGAazlDabCYDGdhtESWTCqghQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjypcsqosKSfWfCNxL62pPcs1omQeyEsvFEEejNvqDL700k4u
	w471DlL/REKlcURCZoEE/EFazk/8OdgcacYCFPBcxG+htGeiq/ph77PaOuA2WacRHQo=
X-Gm-Gg: AR+sD12dVr3rxfW/fjHy9flt7ZRghRvZ6zrcB9umHy72SLCRjqBVu5FJtidiu2wHs23
	BkfJFbsaES5o307S7G5KiKaW5ZOt8v4kMH3U/Tu0z58i8KD2M4Obz5NvHo8tRlSXgg0ONVM/YY9
	651bpMOr3plrEN56jrPbgiivj/xFFHYM8Wv5dHmoA5LP/UyW1iN5nm0HipuI2w2YEeAly8qkKmS
	oT1OENporsVb0Ds3oPfR0v8fNxAkD2KGQml8LSxDYkVG4CytjBFmb1pQ4ikZlsdih26M7sFFWDa
	g6IA41hf9jhkaaqYlQaUMrmCPjkPT8yQj+PJ2Ac/meaDW/O5MsfCDP0qehMu1Hg45CzFVZIjTcM
	FK/8ZuvQxytlR2TccJQlGUPrZPVcKdWwHqPTCuYH4TkEHYK7XWSwISAl5yt/hs4UMm3sphvcMZs
	n7JI1ifw2u+v+SRpD3b7Hfs+7woid1GvcjmQSwGIaxMuQDE76TsjvS6Blt+vrFm3FxAWqUb1Wmx
	TsM2/meG+lam5jCwg==
X-Received: by 2002:a17:90b:510d:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-39580f2d498mr743485a91.8.1787095110988;
        Tue, 18 Aug 2026 16:18:30 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f9ab8besm329084a91.6.2026.08.18.16.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 16:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 19:18:29 -0400
Message-Id: <DKSGCFDM14NC.1YMDZUUT89UVM@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: arena: allocate the fault-in page
 outside the lock
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260808140720.293604-1-jiayuan.chen@linux.dev>
 <20260808140720.293604-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260808140720.293604-3-jiayuan.chen@linux.dev>

On Sat Aug 8, 2026 at 10:05 AM EDT, Jiayuan Chen wrote:
> arena_vm_fault() allocated the page while holding arena->spinlock, so it
> could only use the non-blocking allocator. Once the memcg is at
> memory.max that allocation just fails, the fault turns into
> VM_FAULT_SIGSEGV, and the process gets a SIGSEGV on a perfectly valid
> arena address. Hitting memory.max is routine (e.g. page cache from
> reading a big file), so this kills innocent processes.
>
> Rework the fault handler:
>
> - Preallocate the page before taking the lock, like do_anonymous_page()
>   does, so it can sleep, reclaim and go through the OOM path, and return
>   VM_FAULT_OOM on failure so the memcg OOM handler runs instead of a fake
>   segfault.
>
> - A lockless probe skips that preallocation when a page is already mapped
>   (e.g. allocated by the bpf program), so the common case wastes no
>   allocation. The rare race where such a page is freed before we take the
>   lock falls back to the non-blocking allocator under the lock.
>
> - Return VM_FAULT_SIGBUS for the non-recoverable errors (lock failure,
>   range-tree and page-table failures) instead of VM_FAULT_SIGSEGV; only
>   BPF_F_SEGV_ON_FAULT, and a scratch-page hole under that flag, is a real
>   user addressing error and keeps VM_FAULT_SIGSEGV.
>
> - Tidy up the error labels.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/arena.c | 92 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 71 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 555ee2531ef9..09a718ca4c8b 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -481,7 +481,8 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf=
)
>  	struct bpf_map *map =3D vmf->vma->vm_file->private_data;
>  	struct bpf_arena *arena =3D container_of(map, struct bpf_arena, map);
>  	struct mem_cgroup *new_memcg, *old_memcg;
> -	struct page *page;
> +	struct page *page, *new_page =3D NULL;
> +	vm_fault_t fault_ret;
>  	long kbase, kaddr;
>  	unsigned long flags;
>  	int ret;
> @@ -489,59 +490,108 @@ static vm_fault_t arena_vm_fault(struct vm_fault *=
vmf)
>  	kbase =3D bpf_arena_get_kern_vm_start(arena);
>  	kaddr =3D kbase + (u32)(vmf->address);
> =20
> -	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> +	page =3D vmalloc_to_page((void *)kaddr);
> +	if (!page && !(arena->map.map_flags & BPF_F_SEGV_ON_FAULT)) {
> +		/*
> +		 * We run in process context here, so preallocate the page
> +		 * outside the lock with an explicitly sleepable allocator. It
> +		 * can then go through reclaim (both memcg and global) and the
> +		 * OOM path, the way do_anonymous_page() does; under
> +		 * arena->spinlock only the non-blocking allocator is available,
> +		 * which never reclaims. That also decides the return value:
> +		 * VM_FAULT_OOM below is only meaningful if the OOM machinery was
> +		 * actually engaged, which the non-blocking allocator never does.
> +		 */
> +		bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +		new_page =3D bpf_map_alloc_page_sleepable(map);
> +		bpf_map_memcg_exit(old_memcg, new_memcg);
> +		if (!new_page)
> +			return VM_FAULT_OOM;
> +	}
> +
> +	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags)) {
>  		/*
>  		 * A failed lock means a possible deadlock was detected. Don't
>  		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
>  		 * the fault path would re-take it on retry and deadlock. Fail.
>  		 */
> +		if (new_page)
> +			free_pages_nolock(new_page, 0);
>  		return VM_FAULT_SIGBUS;
> +	}
> =20
>  	page =3D vmalloc_to_page((void *)kaddr);
>  	if (page) {
> -		if (page =3D=3D arena->scratch_page)
> -			/* BPF triggered scratch here; don't lazy-alloc over it */
> -			goto out_sigsegv;
> +		if (page =3D=3D arena->scratch_page) {
> +			/*
> +			 * A scratch page marks a hole. Segfault only if the user
> +			 * asked for it; otherwise we could lazy-allocate but
> +			 * choose not to over a hole, so report a bus error.
> +			 */
> +			fault_ret =3D (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) ?
> +				    VM_FAULT_SIGSEGV : VM_FAULT_SIGBUS;
> +			goto out_err_locked;
> +		}
>  		/* already have a page vmap-ed */
>  		goto out;
>  	}
> =20
> +	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT) {
> +		/* User space requested to segfault when page is not allocated by bpf =
prog */
> +		fault_ret =3D VM_FAULT_SIGSEGV;
> +		goto out_err_locked;
> +	}
> +
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> =20
> -	if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> -		/* User space requested to segfault when page is not allocated by bpf =
prog */
> -		goto out_sigsegv_memcg;
> +	if (!new_page) {
> +		/*
> +		 * Very rare race: the bpf program had allocated a page here, so
> +		 * the lockless probe saw it and we skipped preallocation, but it
> +		 * freed the page before we took the lock. Now we do need one;
> +		 * sleeping is not allowed here, so fall back to the non-blocking
> +		 * allocator and give up if it fails.
> +		 */
> +		ret =3D bpf_map_alloc_pages(map, map->numa_node, 1, &new_page);
> +		if (ret) {
> +			fault_ret =3D VM_FAULT_SIGBUS;
> +			goto out_err_locked_memcg;
> +		}
> +	}
> =20
>  	ret =3D range_tree_clear(&arena->rt, vmf->pgoff, 1);
> -	if (ret)
> -		goto out_sigsegv_memcg;
> -
> -	struct apply_range_data data =3D { .arena =3D arena, .pages =3D &page, =
.i =3D 0 };
> -	/* Account into memcg of the process that created bpf_arena */
> -	ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
>  	if (ret) {
> -		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		goto out_sigsegv_memcg;
> +		fault_ret =3D VM_FAULT_SIGBUS;
> +		goto out_err_locked_memcg;
>  	}
> +	struct apply_range_data data =3D { .arena =3D arena, .pages =3D &new_pa=
ge, .i =3D 0 };
> =20
>  	ret =3D apply_to_page_range(&init_mm, kaddr, PAGE_SIZE, apply_range_set=
_cb, &data);
>  	if (ret) {
>  		range_tree_set(&arena->rt, vmf->pgoff, 1);
> -		free_pages_nolock(page, 0);
> -		goto out_sigsegv_memcg;
> +		fault_ret =3D VM_FAULT_SIGBUS;
> +		goto out_err_locked_memcg;
>  	}
>  	flush_vmap_cache(kaddr, PAGE_SIZE);
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
> +	/* new_page was consumed */
> +	page =3D new_page;
> +	new_page =3D NULL;
>  out:
>  	page_ref_add(page, 1);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> +	if (new_page)
> +		free_pages_nolock(new_page, 0);
>  	vmf->page =3D page;
>  	return 0;
> -out_sigsegv_memcg:
> +
> +out_err_locked_memcg:
>  	bpf_map_memcg_exit(old_memcg, new_memcg);
> -out_sigsegv:
> +out_err_locked:
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -	return VM_FAULT_SIGSEGV;
> +	if (new_page)
> +		free_pages_nolock(new_page, 0);
> +	return fault_ret;
>  }
> =20
>  static const struct vm_operations_struct arena_vm_ops =3D {

