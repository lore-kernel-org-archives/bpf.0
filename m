Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7A2FD7D3
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747672; cv=pass; b=WAPisvHUuO/+ey3af63duTKWQRyYEOFijSl6v/R/+KfgsD0QEM0ILcdx+rmRSwz1Eout0xO1d2Yy+xyUeifJTnKBFMpsLGZu8NBpsKbUFn2lttCJ7JgI8C23Me+Ld289/btRaLjWMX71RMKzxJj6zko6+3s9dtrWjCJjX0qe5sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747672; c=relaxed/simple;
	bh=NQnK1MvuMY7FIQRMlY1q/k9+lH31cUlZfoBRseGhyVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WU9qhWLiaP1xXM0gC1NL6eNM5GyD7EYVvS0fDZIRYmDIBSsC2GqaqCkGZzAGhROhnnHRnenW6fHRQuwWQYnxanKBXMPPYHh3yJ3LjA2hEGUlHDYmBRVWgEG3OnWROhWb6xyz8PGZUQUiX/RjiaOnUcie/kChA9nOaqJLtYTrXXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBUIk7Dn; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBUIk7Dn"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso1055475a12.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 15:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786747670; cv=none;
        d=google.com; s=arc-20260327;
        b=kGAF2tYGD0GxVdNRdbuH29ECD8A9CNBQp91tMWeQti8J9rZ/8hYh/i6mi55ZYX3Q58
         g5gGD3L7cOUtoB7CeoUt2vhUvJQ9m9Ng2mXvcO/B/oHkrLXhzYd9G0lqjthvURrvJtEM
         7D+6jULFfcjNz7jhVNERVpRPcFWQCzoypRAVBB/QVhS4PbzY0HuD1zO73OMAmoxbHoTb
         jM865F/qoS7+FGPer3fqO34K4N8PprDVnxcCqUPgRZ4+r3ikM8CV5r2FcuAS/+L4xFCt
         89LXngW9ikdlMSoxEiIJ4CEF5V6Uds0iZSoEZIAzvZYA+MxU0613fwu97cHDckwhbmzG
         yD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bXVXF4zZVFVXsU2DViW+IZ7tz1OTxaQnBIGkSwLmVOY=;
        fh=qVtT5G4755aEjqfiI9ibJkCwPSxkeQqFp/HyF6+NL2U=;
        b=pFfPoVQGXhu/aLygJCDrXJNIPJvJOIGDgK2GOGlsu053kBV3ViP2gnwO6/Vc5yt5SI
         VAti9RRvO9uyFlF8sP4JjuCk32IOc3JeXkyjFVvWStnOM7hd5vbPb50N05u4Fp25uJpz
         3GDq+DGq/q70p2wOY8THlv+u1UpoXzP9nsvimCGACROZO6TXD4O6eMS/P6GFmXiaHYZc
         nwPOA6mbvmqwQMNR+pXDmFZGDZasWtzTUm6qJR1FiA2srn2opZ2bgJD3QJ7xXLL9ZDtX
         ZzCp0i682x3Vp9z+US0L4lbQc8bfPZWe1UNBudvqZFF8rwfj1zDRAERDrgtKyZMbSU6q
         9e2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786747670; x=1787352470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bXVXF4zZVFVXsU2DViW+IZ7tz1OTxaQnBIGkSwLmVOY=;
        b=tBUIk7Dn1A1Bdz1vrvO4UVRzTYKj8+ONF5wNYSyRDAPa/XBuICyi3EgmZg+mgZWVc2
         1sxAHHpfQRDRhJ5gT1tm0ngQPEUQ9jtwIBs+UKjmGvczITGxs5VUPH73zGJ0LN9UrCq2
         bQYpO+rITRPDAyxGHKjHbvghnNGdD7RejWhcU8VLlk7JWVPWyI+d9Hj5ykvqXiGYp+dh
         zL7/0G4MeeRQw3/AqDK1JsYvp9Y4ED3ZIHml1fz+UIxHpiIlGgTxfU5FW52rt/sxAZyQ
         K/4n/BNpfTpWL0Pa2pk+Sbrxswq7TDtUkrtbJeIrdPKE4BDe9+xGBgzQMRUKfC1wyTeI
         H99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786747670; x=1787352470;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bXVXF4zZVFVXsU2DViW+IZ7tz1OTxaQnBIGkSwLmVOY=;
        b=pwYeieSO2Hunv8ANVhM9ipcc5tlSeKdUVWLTRma097xEnSTWnO07bxNHyw3Lxzthy6
         jhkevb4rn6Co7+PxBFmHAbArBSE29gMfeSylMMuprvnXBBIE0JrlpiNpNMnlIqC3F8HJ
         a9VvKZdiUPHBfl9QEET+taMWg+V3p4uBt2F84UDHoUI6WUIjjcSelwIe2Ln1UmKcsYxM
         OMe8ltxh1/NNKZ24XRIsouYsbz7/pwI9XS2fICyRPpNctPYF/n/1ROpNZtf8RV1TR9cU
         nF61OnFTDxa73ks7aW2yZY2MoNl2A7yDo7zBsQCPzsmcyQj/qt2nx+PE7so5Ge/A9Ikm
         S7Vg==
X-Gm-Message-State: AOJu0YxydPr9SREU99VwvaxZSUKRS+Oe+kzFdAC4Hf0nlrHrP/wxt6ik
	XMUPRmK2zbiHoL+OQjmgusYhbz0+gKSwGOX5zbzCHM2fXYQVP/NJMX31DkCZOkNZlYfqoEwVHRC
	WiMpNyEO7qK+r8XZ2NTW0SEWaMH0SE6Q=
X-Gm-Gg: AR+sD10ZtUdRvTHHyz4ZyMasmCZLn0zdc6P8r1S+EyMLSPgdBB5236t/YdCmuyEKVQr
	bJztZ+sCkmP9xajD58NIqOrzqxWKTvaLkputOAA/uTfeEhZdlVo2f2JcdRXAMJo0aZcfsvMI3ax
	dJD0GCw81zIR4QEzxtLzDpNgO0Rxq9wxxqQuFK4qhT6e7Cce7hC3GUzBKni0W00j5ZU4CK9RgLs
	BUpAybmQ8869GaiVBW8CvJZn79QpF7VLIC1/m3KyhuhovWDGbhdHMjC9XOquqXuKKs3FUL9UtDI
	g+AIgsa/yQ9zp77qbBc/Jju4G5kg5et/lil3iXEj7BNFCfgBjYd9Zwpu9FOOo5nNlSLqjZwd4Av
	dP0GmiU890xfxXJhl6AkJ4Wa7Wg==
X-Received: by 2002:a05:6a20:7345:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cc71d1e819mr10281527637.18.1786747669586; Fri, 14 Aug 2026
 15:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814155623.111565-1-song@kernel.org>
In-Reply-To: <20260814155623.111565-1-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 14 Aug 2026 15:47:36 -0700
X-Gm-Features: AUfX_mxAmoErjRcITYr4wHzMLk1Pyp5fTMkLao9X6969GFLatr4U3HLrgVj-Ii4
Message-ID: <CAEf4Bzb33ah9dk1nSPYUH1XhWvSPw3sKR_KjUCJ2Nb-3stTYAA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next] bpf: Populate mmap-able array map memory lazily
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 8:56=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> An mmap-able BPF array map (BPF_F_MMAPABLE) has its backing memory
> vmalloc'ed up front at map creation time. array_map_mmap() then wired up
> the whole mapping eagerly via remap_vmalloc_range(), which calls
> vm_insert_page() for every page of the map. For large maps this makes
> every mmap() O(number of pages): an 8MiB map inserts 2048 PTEs per
> mmap() and tears them all down again on munmap(), even when user space
> only touches a few pages (or none at all).
>
> Populate the mapping lazily instead, the same way the arena map already
> does. array_map_mmap() now only performs the bounds check and returns,
> leaving the PTEs unpopulated; pages are inserted on demand by a new
> array_map_mmap_fault() handler. Because the memory is already resident,
> the fault handler simply resolves the vmalloc page and hands it to the
> fault path. This makes mmap() O(1), and munmap() proportional to the
> number of pages that were actually faulted in rather than to the size of
> the map.
>
> The handler is reached through a new optional ->map_mmap_fault callback.
> Maps that provide it get a vm_operations_struct with a .fault handler;
> maps that populate their mapping eagerly keep the one they had. Both
> share the same open/close callbacks, so the existing VMA accounting
> (VM_MAYWRITE write-active tracking, freeze handling) stays centralized
> rather than each map installing its own vm_operations_struct.
>
> Callers that want the pages populated up front can still request that
> explicitly with MAP_POPULATE. Kernel-side access to the map (via the
> vmalloc address) is unaffected.
>
> Time for one mmap()+munmap() of an 8MiB mmap-able array map:
>
>                                        before     after
>   no MAP_POPULATE, no access            226us     1.1us
>   no MAP_POPULATE, access all pages     236us    1341us
>   MAP_POPULATE, no access               312us     493us
>   MAP_POPULATE, access all pages        318us     519us
>
> Mapping without touching the data, which is what this change targets,
> gets ~160x cheaper. Faulting in the whole mapping one page at a time is
> more expensive than the eager remap_vmalloc_range() loop, so users that
> do touch every page should ask for MAP_POPULATE. Note that MAP_POPULATE
> is not free before this change either: it adds ~85us (226us =3D> 312us)
> for no benefit, as the mapping is already fully populated.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Assisted-by: Claude:claude-opus-4-8
>
> ---
> Changes in v7:
> - Set VM_MIXEDMAP, which the eager remap_vmalloc_range() path set via
>   vm_insert_page(), so that e.g. NUMA balancing keeps skipping these
>   VMAs. (BPF CI AI review)
> - Only install the .fault handler for maps that populate their mapping
>   lazily, so that eagerly populated maps (ringbuf) keep exactly the
>   vm_operations_struct they had before. (BPF CI AI review)
> v6: https://lore.kernel.org/bpf/20260813224853.1436734-1-song@kernel.org/
>
> Changes in v6:
> - Drop the !CONFIG_MMU branch. nommu cannot mmap() a BPF map fd in the
>   first place: the fd is an anon inode and bpf_map_fops has no
>   ->mmap_capabilities, so validate_mmap_request() returns -EINVAL before
>   ->mmap() runs. (BPF CI AI review)
> - Scope the O(1) claim to mmap(); munmap() still tears down whatever was
>   faulted in. (BPF CI AI review)
> v5: https://lore.kernel.org/bpf/20260812230248.2452103-1-song@kernel.org/
>
> Changes in v5:
> - Drop the ->map_pages (fault-around) handler, it pulls in too much mm
>   internal API for the gain. (Andrii)
> - Drop the fault path overflow and bounds checks, and the verbose
>   comments; VM_DONTEXPAND plus the mmap() time check already bound the
>   faulting offset. (Andrii)
> - No cover letter for a single patch. (Andrii)
> v4: https://lore.kernel.org/bpf/20260729192419.41331-1-song@kernel.org/
>
> Changes in v4:
> - Flush the D-cache before exposing a page at a new user address, as the
>   eager vm_insert_page() path did. (Sashiko AI review)
> - Fix the build on !CONFIG_MMU: keep populating the mapping eagerly
>   there, as there are no page faults. (kernel test robot)
> v3: https://lore.kernel.org/bpf/20260729001033.3433328-1-song@kernel.org/
>
> Changes in v3:
> - Add a ->map_pages (fault-around) handler so mmap(MAP_POPULATE) and
>   linear access populate PTEs in batches instead of one fault per page.
> - Harden the fault path with check_shl_overflow() and explicit bounds
>   checks instead of a plain (u64) cast. (Andrii)
> - Drop selftests (2/2 in v2). (Andrii)
> v2: https://lore.kernel.org/bpf/20260722205032.1245094-1-song@kernel.org/
>
> Changes in v2:
> - Use 64-bit arithmetic for the mmap offset and bounds check to avoid a
>   potential overflow on 32-bit architectures.
> v1: https://lore.kernel.org/bpf/20260722065308.4116186-1-song@kernel.org/
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/arraymap.c | 34 ++++++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c  | 22 +++++++++++++++++++++-
>  3 files changed, 52 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f4e8d372253a..04cadd987169 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -145,6 +145,7 @@ struct bpf_map_ops {
>         int (*map_direct_value_meta)(const struct bpf_map *map,
>                                      u64 imm, u32 *off);
>         int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
> +       vm_fault_t (*map_mmap_fault)(struct bpf_map *map, struct vm_fault=
 *vmf);
>         __poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
>                              struct poll_table_struct *pts);
>         unsigned long (*map_get_unmapped_area)(struct file *filep, unsign=
ed long addr,
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 34865701f7f7..ef315b168b29 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -608,17 +608,42 @@ static int array_map_check_btf(struct bpf_map *map,
>  static int array_map_mmap(struct bpf_map *map, struct vm_area_struct *vm=
a)
>  {
>         struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> -       pgoff_t pgoff =3D PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
>
>         if (!(map->map_flags & BPF_F_MMAPABLE))
>                 return -EINVAL;
>
> -       if (vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) >
> +       /* use u64 math so the offset cannot overflow on 32-bit archs */
> +       if ((u64)vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start=
) >
>             PAGE_ALIGN((u64)array->map.max_entries * array->elem_size))
>                 return -EINVAL;
>
> -       return remap_vmalloc_range(vma, array_map_vmalloc_addr(array),
> -                                  vma->vm_pgoff + pgoff);
> +       /*
> +        * Pages are faulted in on demand by array_map_mmap_fault(). Set =
the
> +        * same flags that the eager remap_vmalloc_range() path used to s=
et
> +        * via vm_insert_page(), so that e.g. NUMA balancing keeps skippi=
ng
> +        * these VMAs.
> +        */
> +       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP | VM_MIXEDMAP);
> +
> +       return 0;
> +}
> +
> +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> +                                      struct vm_fault *vmf)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       struct page *page;
> +
> +       page =3D vmalloc_to_page(array->value + ((u64)vmf->pgoff << PAGE_=
SHIFT));
> +       if (!page)
> +               return VM_FAULT_SIGBUS;
> +
> +       /* the eager remap_vmalloc_range() flushed via vm_insert_page() *=
/
> +       flush_dcache_folio(page_folio(page));
> +       get_page(page);
> +       vmf->page =3D page;
> +
> +       return 0;
>  }
>
>  static bool array_map_meta_equal(const struct bpf_map *meta0,
> @@ -844,6 +869,7 @@ const struct bpf_map_ops array_map_ops =3D {
>         .map_direct_value_addr =3D array_map_direct_value_addr,
>         .map_direct_value_meta =3D array_map_direct_value_meta,
>         .map_mmap =3D array_map_mmap,
> +       .map_mmap_fault =3D array_map_mmap_fault,
>         .map_seq_show_elem =3D array_map_seq_show_elem,
>         .map_check_btf =3D array_map_check_btf,
>         .map_lookup_batch =3D generic_map_lookup_batch,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7d8c3e8e6d62..caf3e202ad6c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1076,11 +1076,30 @@ static void bpf_map_mmap_close(struct vm_area_str=
uct *vma)
>                 bpf_map_write_active_dec(map);
>  }
>
> +static vm_fault_t bpf_map_mmap_fault(struct vm_fault *vmf)
> +{
> +       struct bpf_map *map =3D vmf->vma->vm_private_data;
> +
> +       return map->ops->map_mmap_fault(map, vmf);
> +}
> +
>  static const struct vm_operations_struct bpf_map_default_vmops =3D {
>         .open           =3D bpf_map_mmap_open,
>         .close          =3D bpf_map_mmap_close,
>  };
>
> +/*
> + * Only for maps that populate their mapping lazily. Maps that populate =
it
> + * eagerly keep the default vm_ops, so that a fault racing the temporary
> + * pte clearing of a read/modify/write update still gets the pte re-chec=
ked
> + * under the ptl by do_fault() instead of a SIGBUS.
> + */

removed this comment altogether

> +static const struct vm_operations_struct bpf_map_lazy_vmops =3D {
> +       .open           =3D bpf_map_mmap_open,
> +       .close          =3D bpf_map_mmap_close,
> +       .fault          =3D bpf_map_mmap_fault,
> +};
> +
>  static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
>         struct bpf_map *map =3D filp->private_data;
> @@ -1116,7 +1135,8 @@ static int bpf_map_mmap(struct file *filp, struct v=
m_area_struct *vma)
>                 return err;
>
>         /* set default open/close callbacks */
> -       vma->vm_ops =3D &bpf_map_default_vmops;
> +       vma->vm_ops =3D map->ops->map_mmap_fault ? &bpf_map_lazy_vmops
> +                                              : &bpf_map_default_vmops;

made this into a single line statement, applied to bpf-next, thanks!

>         vma->vm_private_data =3D map;
>         vm_flags_clear(vma, VM_MAYEXEC);
>         /* If mapping is read-only, then disallow potentially re-mapping =
with
>
> base-commit: 259d60f5bfa41056fe01cbf2ba3f6f0331865a16
> --
> 2.53.0-Meta
>
