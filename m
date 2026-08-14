Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870046AA66
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727207; cv=none; b=ULr+/T/YRPReSQXEyHf75Tr0PCeKD348aW9WIyjBLjU4UtE7NxRv+Nr7qvr1E59SEFNwOsb0fb851XK/7fetnayy2tPEt0O3VqT3zzuaYSskoG+rExsGeGQ/PQKvnREP7mlbCeGqcWB1VI9sXAGMTP7NnZh3UGlxsxKzCua7veY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727207; c=relaxed/simple;
	bh=qKQGP7n82hmtlKoBjE8Sy6gLmwLvcJ+qrxljpQQAgaM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=S3SUzJOvSvFg/zI53MlaGhv5O3jwrrVmB/bAcaFqikrRfAJH0w6Z+0IGOV9PTqPepbmnqYX5Ixq8gtQSrYrJJgZ4DU0nYBGxVVDZsRvFmzGxDtROACVTQRrbZdjc+4Z/XE33QjknonJ1X3To1rBtMODN38cb3pXk40F7cZ1jeEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlGFQRYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlGFQRYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F451F000E9;
	Fri, 14 Aug 2026 17:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786727206;
	bh=poLZfZBX20fDgqE9E3xJ5/EMweIro3R6XmDCu7efluw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mlGFQRYQgJ6s+OlBys181NrAFE6U4QpSJGryW8I59TuK9bfWBXMlZv3yaMrlbXH4f
	 gFOBOKraXxXTGGRy80SsbpDe2ylLBNmj3APLhliSIZ3q0f5mgnIbFrJdm3UeVcUBN1
	 I9gZi7/PPp36d3CRuB/Lv0E/Jgy/mc6hYs9ThhuV6TX2Mwwmk14qpPbBl14NjoaDsI
	 OYHKAmQAUUyWqq85ALk5rwTf0j7g9z7NDZs3AVynt2TS+QOe7h9Scn8EignTKqsGgd
	 6JHR1ZoGuALMq1s4Nk0IdVmCxvslkzbRMKFDBm852wr8mkyYn9AqqidlJ8g3SLmBwt
	 3EIP0i9buG8zQ==
Content-Type: multipart/mixed; boundary="===============5835378174024522285=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7ba836fac5c330d50422c41b551eddb613b74ccffffbc49fb242482bcba3e293@mail.kernel.org>
In-Reply-To: <20260814155623.111565-1-song@kernel.org>
References: <20260814155623.111565-1-song@kernel.org>
Subject: Re: [PATCH v7 bpf-next] bpf: Populate mmap-able array map memory lazily
From: bot+bpf-ci@kernel.org
To: song@kernel.org,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 17:06:45 +0000 (UTC)

--===============5835378174024522285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f4e8d372253ac..04cadd9871696 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -145,6 +145,7 @@ struct bpf_map_ops {
>  	int (*map_direct_value_meta)(const struct bpf_map *map,
>  				     u64 imm, u32 *off);
>  	int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
> +	vm_fault_t (*map_mmap_fault)(struct bpf_map *map, struct vm_fault *vmf);
>  	__poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
>  			     struct poll_table_struct *pts);
>  	unsigned long (*map_get_unmapped_area)(struct file *filep, unsigned long addr,

[ ... ]

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 34865701f7f75..ef315b168b296 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -608,17 +608,42 @@ static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
>  {
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
> -	pgoff_t pgoff = PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
>
>  	if (!(map->map_flags & BPF_F_MMAPABLE))
>  		return -EINVAL;
>
> -	if (vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
> +	/* use u64 math so the offset cannot overflow on 32-bit archs */
> +	if ((u64)vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
>  	    PAGE_ALIGN((u64)array->map.max_entries * array->elem_size))
>  		return -EINVAL;
>
> -	return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
> -				   vma->vm_pgoff + pgoff);
> +	/*
> +	 * Pages are faulted in on demand by array_map_mmap_fault(). Set the
> +	 * same flags that the eager remap_vmalloc_range() path used to set
> +	 * via vm_insert_page(), so that e.g. NUMA balancing keeps skipping
> +	 * these VMAs.
> +	 */
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP | VM_MIXEDMAP);

This isn't a bug, but VM_DONTEXPAND and VM_DONTDUMP were set by
remap_vmalloc_range_partial() itself, not by vm_insert_page() - only
VM_MIXEDMAP came from vm_insert_page(). Should the comment name both
sources so it is clear why each flag is needed?

> +
> +	return 0;
> +}
> +
> +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> +				       struct vm_fault *vmf)
> +{
> +	struct bpf_array *array = container_of(map, struct bpf_array, map);
> +	struct page *page;
> +
> +	page = vmalloc_to_page(array->value + ((u64)vmf->pgoff << PAGE_SHIFT));
> +	if (!page)
> +		return VM_FAULT_SIGBUS;
> +
> +	/* the eager remap_vmalloc_range() flushed via vm_insert_page() */
> +	flush_dcache_folio(page_folio(page));
> +	get_page(page);
> +	vmf->page = page;
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7d8c3e8e6d62e..caf3e202ad6c3 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1076,11 +1076,30 @@ static void bpf_map_mmap_close(struct vm_area_struct *vma)
>  		bpf_map_write_active_dec(map);
>  }
>
> +static vm_fault_t bpf_map_mmap_fault(struct vm_fault *vmf)
> +{
> +	struct bpf_map *map = vmf->vma->vm_private_data;
> +
> +	return map->ops->map_mmap_fault(map, vmf);
> +}
> +
>  static const struct vm_operations_struct bpf_map_default_vmops = {
>  	.open		= bpf_map_mmap_open,
>  	.close		= bpf_map_mmap_close,
>  };
>
> +/*
> + * Only for maps that populate their mapping lazily. Maps that populate it
> + * eagerly keep the default vm_ops, so that a fault racing the temporary
> + * pte clearing of a read/modify/write update still gets the pte re-checked
> + * under the ptl by do_fault() instead of a SIGBUS.
> + */
> +static const struct vm_operations_struct bpf_map_lazy_vmops = {
> +	.open		= bpf_map_mmap_open,
> +	.close		= bpf_map_mmap_close,
> +	.fault		= bpf_map_mmap_fault,
> +};

This isn't a bug, but the comment justifies the default vm_ops for
eager maps by saying a .fault handler would give SIGBUS when racing a
temporary pte clear. If such a map did have a .fault handler, wouldn't
it just repopulate the pte in that window?  Isn't the actual reason
simply that eager maps have no ->map_mmap_fault callback to install?
Could the comment be trimmed to say that?

> +
>  static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>  	struct bpf_map *map = filp->private_data;
> @@ -1116,7 +1135,8 @@ static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
>  		return err;
>
>  	/* set default open/close callbacks */
> -	vma->vm_ops = &bpf_map_default_vmops;
> +	vma->vm_ops = map->ops->map_mmap_fault ? &bpf_map_lazy_vmops
> +					       : &bpf_map_default_vmops;
>  	vma->vm_private_data = map;
>  	vm_flags_clear(vma, VM_MAYEXEC);
>  	/* If mapping is read-only, then disallow potentially re-mapping with


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31817523195
--===============5835378174024522285==--
