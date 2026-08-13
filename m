Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A120DD51
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580499; cv=none; b=fP+DPKggV79BR+H8cqObQFW9DN7TRBp4XqND275tFJss/oj1lx3XkG4hEXUuF6eZ3HA9nEo4CeeX+as86X30c0rA7tMSTjHBBNYWPITf5lyfczY3wDNNm+MPFgu2LJFGajrIib8TQOzqb+fyJylewlls+TK1d733mpw5zoRllkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580499; c=relaxed/simple;
	bh=MpaF9CyR+wsVNbBEXnyAeEQTQ9BplUrA24X/VWhJph4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uiatD/28Th3/G0461Wa3maPGQZEv0MdhUbc+6sOp5CnL4XT/aihQ4nxkZMktlXGEvzFHVmfnntvqYeZpgtfqeBpHj3/j78eADIw2K91Kr2iqE+1Y4MOEV85PKfPYr3f51Oa/jqNw4ZPiPFVtqfOADSs3u93AnAWiHLJP7NYYSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSXe8nbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSXe8nbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00DB1F000E9;
	Thu, 13 Aug 2026 00:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580498;
	bh=YFmEq8MScB0y/KdolFMKVp+1X9tEHKB4z3AN6DrKqFA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cSXe8nbPRIUub6UBwpgLf3Iyl1/7H0jzZeDs6/Te2xj5spXyKbT3veNCSUPRGCirg
	 23Q42PuCy7R1dkHLrbA69oV9DBAUN0ygMtZlakVlRIp2ecjV5UgdaWKr7lue5eqZ6F
	 /fFSEdiZDfwNsQk7jvcHa9ZPTNggQHe1MmmCgMh66WJ2YsQ1nhuesv/kwJOg+lmyag
	 TVTYr13gelm3OrZgAaVG1cK4dtVlvw3KC5a0PS00HnKsjiXEC9yhSiP9wPWfVgSQmQ
	 hRoEmDeLyN0YNPOQ5THoc+XizT9/YU3U1/Xxv6oFpa9qclrmnGPXilpq1FPiLzK+/1
	 FahzkX4QqZJTQ==
Content-Type: multipart/mixed; boundary="===============8002898766788512426=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <baf0009b171aae5045f3788c6c213ff9ddcc76407b344b5d719dc384ef2b9a37@mail.kernel.org>
In-Reply-To: <20260812230248.2452103-1-song@kernel.org>
References: <20260812230248.2452103-1-song@kernel.org>
Subject: Re: [PATCH v5 bpf-next] bpf: Populate mmap-able array map memory lazily
From: bot+bpf-ci@kernel.org
To: song@kernel.org,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kernel-team@meta.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 00:21:37 +0000 (UTC)

--===============8002898766788512426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4a10c9878cf8..4a50324e78189 100644
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
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178cd..a1767ef2b473f 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -576,17 +576,45 @@ static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
>  static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
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
> +	if (!IS_ENABLED(CONFIG_MMU)) {
> +		pgoff_t pgoff = PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
> +
> +		/* no page faults without an MMU, populate the mapping now */
> +		return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
> +					   vma->vm_pgoff + pgoff);
> +	}

This isn't a bug, but can the !CONFIG_MMU branch actually be reached?

On nommu, bpf_map_new_fd() uses anon_inode_getfd(), which creates an inode
with no S_IFMT type (alloc_anon_inode() at fs/libfs.c sets i_mode to just
S_IRUSR|S_IWUSR). Since bpf_map_fops has no ->mmap_capabilities, nommu's
validate_mmap_request() falls into the default case and returns -EINVAL
before ->mmap() runs.

So it looks like the eager path preserves an -EINVAL that nommu already
produces one layer up, rather than providing a working fallback.

> +
> +	/* pages are faulted in on demand by array_map_mmap_fault() */
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8d111da886553..ee0b01373a4b6 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1077,9 +1077,21 @@ static void bpf_map_mmap_close(struct vm_area_struct *vma)
>  		bpf_map_write_active_dec(map);
>  }
>
> +/* Called for maps that populate their memory-mapped region lazily. */
> +static vm_fault_t bpf_map_mmap_fault(struct vm_fault *vmf)
> +{
> +	struct bpf_map *map = vmf->vma->vm_private_data;
> +
> +	if (!map->ops->map_mmap_fault)
> +		return VM_FAULT_SIGBUS;
> +
> +	return map->ops->map_mmap_fault(map, vmf);
> +}
> +
>  static const struct vm_operations_struct bpf_map_default_vmops = {
>  	.open		= bpf_map_mmap_open,
>  	.close		= bpf_map_mmap_close,
> +	.fault		= bpf_map_mmap_fault,
>  };
>
>  static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)

The commit message states:

> leaving the PTEs unpopulated; pages are inserted on demand by a new
> array_map_mmap_fault() handler. Because the memory is already resident,
> the fault handler simply resolves the vmalloc page and hands it to the
> fault path. This turns mmap()/munmap() into an O(1) operation.
>
> Lazy population requires page faults, so on !CONFIG_MMU array_map_mmap()
> keeps populating the mapping eagerly via remap_vmalloc_range().

This isn't a bug, but could the O(1) claim be scoped to mmap() only?
munmap() still zaps every PTE that was faulted in, which is why the
benchmark table shows the access-all case going from 236us to 1341us.

Also, could the !CONFIG_MMU paragraph clarify what the branch is actually
for? As noted above, nommu cannot mmap() a BPF map fd in the first place,
since validate_mmap_request() rejects it before ->mmap() runs.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31650392779
--===============8002898766788512426==--
