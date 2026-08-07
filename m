Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A5353A64
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140771; cv=pass; b=EqAZbHx3ylfO8uekfNuwTq4rfOJr4jfGhyOPU156VBAFP1wrKInWuSgIMaq1X4dCKh+bjsxoWvsTSX69wyfdSLYELa8VMjM/lR4nZimEClKGu86q9txDGslQ8l1Q69RWmb9z5ZvnqoZf7QtovrauxEiFvGPlyqrNf1lyeAsPC5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140771; c=relaxed/simple;
	bh=XkWVa7TJdt8MUM15ieZrS3OFnv5BUPxfsaVdPmuUYEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUmr85aiz81CGrEezFOYA/rmoJ6LeF1kP5sFS88vG3D4C1pEFmBY7/iNwXfRb3eoyLyasFfj5yQvBvk9h3wqe8ZxRRnuarpzbwxpeA4oR0QtmfKDn1laRUYkku/kXmn1gHbEdSD9oyUA2Zm33Fk1RqIDMECqLPSHO5K7zBTvDHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY7tYghA; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY7tYghA"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb662575d3so2339589a12.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 15:12:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786140769; cv=none;
        d=google.com; s=arc-20260327;
        b=rx+PciHGGCXI7anpwi5Ewg0bO6SDPbV5Ps7t2pZ3xtsO/N/duIR43oW+e7ATkF0An9
         WtHdvUg4UVflnoTdrNdjykQu/yHfyrYgpaOJrZkMQ4rTTssN896++qNAe6Otfj0zf45l
         sKe2nuytS+dOtB5mUaOLuvOBWPdCXYkWb8VdNsSEm5giwpVwKds5t0GfVwEDGYJBvvU+
         QL9RiYZ2LpjcCUuHOe+dLX+/a+ejbn1ZxUv6uuE2emchyTSVgRLRawdX3Shp5Vwln5gf
         Jo8hHc7TbVMtYFGZRjK29fC7JjlKK121opoueWkCtfW3jjXC2sCX3hSWioxiNX6gLA0n
         er6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aJuXnKzxoiGbkq1qubASy9MkRDjcFgeKofMQ0+pxUGQ=;
        fh=qVtT5G4755aEjqfiI9ibJkCwPSxkeQqFp/HyF6+NL2U=;
        b=dz5yafLUiV+Aimja6FbXMTR/0BDT8AYFV7V/0ceEz9e8prRehO5DU82aXVdE3zyfm+
         09EFgsQUm7YAqk3ZHH1qsTZOKPWFpyseX7maPSEq/xqmF4NTOwWYt5FRJBj4cfQSrXom
         duGFQ0UYrPgipZnjR7c+OYg4zFg9/EIN/Lc05E7yacAoj79SRyZ/4OICAXJyawmK9rn4
         diUAP357gBmhmEnDk01K0SQIG590SviHk0Y+t/l6FBVSfyZNMsFwj4xMaaVnT878FhrA
         1IAbEEmIivCERsnx7U8mVmv0ak27BkndjhnYlS9WgXXpiihXTR0UfttLpGOJ9OjKwgG2
         IT0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786140769; x=1786745569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aJuXnKzxoiGbkq1qubASy9MkRDjcFgeKofMQ0+pxUGQ=;
        b=OY7tYghAKA0skbAGaVh6iJdON5eIDlHi6kxbF6nM+Or3dDsTL7aJl+mnIb0lSByp94
         hwZv2Eqkon2MxsmpKloBxzZbEk+vYI71rLmLdLo3VYyGfh2VlAFvLdFX46FCaTIwDyfV
         gcIIq206liGl1H9D3t7c6+OrkOXVghg/Xw0t7XWqbDyXhhzDzMy3Z7Xz/dNLyvMjM4GI
         lHVFsanMiMSo7jZN1ZWL3JBu1a3Squtl/yudJeBrKhiTQPAD7b8Iq8F7GladR/gzDS+c
         7Q9Amu97FE6RfbHIMA5vpP2FQZN87gd2jndQlPErKa3sn0aoJJmxwNfETU+m2g/tpMBf
         PfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786140769; x=1786745569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJuXnKzxoiGbkq1qubASy9MkRDjcFgeKofMQ0+pxUGQ=;
        b=ERLYMZStlBQ9AgtQ3NwWw3cVnB5I3gfY2xN4QyJthIV865ASpTin5whM5WFeJhmUA2
         ftLKFGedq8H/a00h3iRpuXSbzooD2YdCIgBBKCXHOGftfagtTCK7YtLlTYKfn0JmqjCA
         JZy8UYRV2MgHe3AZ5ZrtdfvpxBvWUqbeXtKNVNSMMhpfSVgQG4vG3FByVaP4XCfkHJ3N
         OzWvNoIet2vTcKOuOeGZIWG27WZXB+q53ArSYamMUBL4VP+Rn9UcUSTCb9CfSxKfFn07
         odvqWjZ5kFJEgYOzadco/ZOfnYqZRuJQ2TZWSLUpzmSQpfO4hPpZZK45ivveqRa2rEWE
         4gpw==
X-Gm-Message-State: AOJu0Ywkq5Wi0VapNcGWPKCyol5jFa3Q4rUy/iOlCDLCK2RW3YQjT1V1
	rcwoR7/TKSPN0QLcMl7ifNDePK4O0Ihig9cr80bgNO5UIWXyMBlaab49IpNlGvQaiUbXc0cPF9V
	yLpbFOOLkxwbWUaqACtUZs1feJAECwVE=
X-Gm-Gg: AR+sD13bRRHwy/oXZAEk246Wi9da0QddSTAWnQb6ecGCVqGMBawSE5GJiuvidb7ETqD
	aK9SjakXEOfWunSv4KIph4oEslwSVW+s7N9zkK8y7XsJLH23L3TGz3539hO+0zLtSXK4QkwoZHg
	rIwtCFoPDD9tGQ7UxvsqEWG5LN0FLiy0HKSBbg1S8vQ1UL6jxyzE+EnZytikktrloa7csyr9G35
	cJy2j/OIFy1HrLcbQKPdDyB/jTNywPRZlbvYucHqmojhp8ANADRvnXD/FqXIBhlCSdGLtzIuvEe
	UQO90fdQWqW8Hzf80NagAS4aERmAaTID9QdZfNErUP3G+yv8kRo/ZQ2YK5IsbwUyknUZYLOPBQI
	eehUFxF4TCJqHZfEc/7da4fa05n3aJ1o1ZhZGpRxjKw==
X-Received: by 2002:a05:6a20:d48f:b0:3c4:3767:adb2 with SMTP id
 adf61e73a8af0-3cbada5bf9fmr15779571637.1.1786140768816; Fri, 07 Aug 2026
 15:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729192419.41331-1-song@kernel.org> <20260729192419.41331-2-song@kernel.org>
In-Reply-To: <20260729192419.41331-2-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 7 Aug 2026 15:12:34 -0700
X-Gm-Features: AUfX_myf693sdZeZwJfhWX2s0eWn2KprzXGCDraHy_gpTV2VF3G7urJ95OIFHQU
Message-ID: <CAEf4BzanPG8qknSiD6+YRGB3P=tWCFzbhwTRStSqCoWz36sOWg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/1] bpf: Populate mmap-able array map memory lazily
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 12:24=E2=80=AFPM Song Liu <song@kernel.org> wrote:
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
> fault path. This turns mmap()/munmap() into an O(1) operation.
>
> To keep populating a large mapping cheap, also provide an
> array_map_mmap_pages() (->map_pages) handler that batch-installs PTEs for
> the whole fault-around window under a single page-table lock. This lets
> mmap(MAP_POPULATE) and linear access patterns avoid taking one full fault
> per page.
>
> Both handlers are reached through new optional ->map_mmap_fault and
> ->map_mmap_pages callbacks dispatched from the shared
> bpf_map_default_vmops, so the existing VMA open/close accounting
> (VM_MAYWRITE write-active tracking, freeze handling) stays centralized
> rather than each map installing its own vm_operations_struct.
>
> remap_vmalloc_range() previously guarded against offset overflow; since
> it is no longer used, array_map_mmap() and the fault handlers compute the
> mapping offset with 64-bit arithmetic and check_shl_overflow() so that a
> large vm_pgoff cannot overflow the bounds check on 32-bit architectures.
>
> Callers that want the pages populated up front can still request that
> explicitly with MAP_POPULATE. Kernel-side access to the map (via the
> vmalloc address) is unaffected.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  include/linux/bpf.h   |   3 +
>  kernel/bpf/arraymap.c | 140 ++++++++++++++++++++++++++++++++++++++++--
>  kernel/bpf/syscall.c  |  30 +++++++++
>  3 files changed, 169 insertions(+), 4 deletions(-)
>

btw, you don't need cover letter for a single patch, it's redundant

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7bfc28673124..eb578ce087b7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -145,6 +145,9 @@ struct bpf_map_ops {
>         int (*map_direct_value_meta)(const struct bpf_map *map,
>                                      u64 imm, u32 *off);
>         int (*map_mmap)(struct bpf_map *map, struct vm_area_struct *vma);
> +       vm_fault_t (*map_mmap_fault)(struct bpf_map *map, struct vm_fault=
 *vmf);
> +       vm_fault_t (*map_mmap_pages)(struct bpf_map *map, struct vm_fault=
 *vmf,
> +                                    pgoff_t start_pgoff, pgoff_t end_pgo=
ff);
>         __poll_t (*map_poll)(struct bpf_map *map, struct file *filp,
>                              struct poll_table_struct *pts);
>         unsigned long (*map_get_unmapped_area)(struct file *filep, unsign=
ed long addr,
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178c..b33bfdae8698 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -7,6 +7,8 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/mm.h>
> +#include <linux/overflow.h>
> +#include <linux/pgtable.h>
>  #include <linux/filter.h>
>  #include <linux/perf_event.h>
>  #include <uapi/linux/btf.h>
> @@ -576,18 +578,144 @@ static int array_map_check_btf(struct bpf_map *map=
,
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
> +       if (!IS_ENABLED(CONFIG_MMU)) {
> +               pgoff_t pgoff =3D PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIF=
T;
> +
> +               /*
> +                * Without an MMU there are no page faults, so the lazy f=
ault
> +                * handlers below are not built. Populate the whole mappi=
ng up
> +                * front instead, as the eager path always did.
> +                */
> +               return remap_vmalloc_range(vma, array_map_vmalloc_addr(ar=
ray),
> +                                          vma->vm_pgoff + pgoff);
> +       }
> +
> +       /*
> +        * The backing memory is vmalloc'ed up front, so instead of wirin=
g up
> +        * every PTE here we let the fault handlers insert pages on deman=
d.
> +        * remap_vmalloc_range_partial() used to set these flags for us; =
keep
> +        * them to preserve behavior (no VMA expansion, excluded from cor=
edump).
> +        */
> +       vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_MMU
> +/* Resolve the vmalloc page backing the value-area offset of a fault. */
> +static struct page *array_map_fault_page(struct bpf_array *array, pgoff_=
t pgoff)
> +{
> +       u64 array_size, off;
> +       struct page *page;
> +
> +       array_size =3D PAGE_ALIGN((u64)array->map.max_entries * array->el=
em_size);
> +
> +       /*
> +        * pgoff is the faulting page's offset into the mapped value area=
 (the
> +        * bpf_array header precedes array->value and is not mapped). Gua=
rd the
> +        * shift and the bounds explicitly, the same way that
> +        * remap_vmalloc_range_partial() does for the eager path, instead=
 of
> +        * relying on the mmap()-time bounds check alone.
> +        */

this overly verbose Claude comment made me pause, and according to my
Claude, this overflow isn't necessary as long as we set DONTEXPAND and
DONTDUMP, so let's drop unnecessary checks (and comments as well)

pw-bot: cr


> +       if (check_shl_overflow(pgoff, PAGE_SHIFT, &off))
> +               return NULL;
> +       if (off >=3D array_size)
> +               return NULL;
> +
> +       page =3D vmalloc_to_page(array->value + off);
> +       if (page)
> +               /*
> +                * The kernel writes this memory through the vmalloc alia=
s, so
> +                * flush the D-cache before it is exposed at a new user a=
ddress.
> +                * The eager remap_vmalloc_range() path did this via
> +                * vm_insert_page() -> validate_page_before_insert().
> +                */
> +               flush_dcache_folio(page_folio(page));
> +
> +       return page;
> +}
> +
> +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> +                                      struct vm_fault *vmf)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       struct page *page;
> +
> +       page =3D array_map_fault_page(array, vmf->pgoff);
> +       if (!page)
> +               return VM_FAULT_SIGBUS;
> +
> +       get_page(page);
> +       vmf->page =3D page;
> +
> +       return 0;
> +}
> +
> +/*
> + * Fault-around handler: install PTEs for the whole [start_pgoff, end_pg=
off]
> + * window under a single page-table lock, so that populating a large map=
ping
> + * (e.g. mmap(MAP_POPULATE) or a linear access pattern) does not take on=
e full
> + * fault per page.
> + */
> +static vm_fault_t array_map_mmap_pages(struct bpf_map *map, struct vm_fa=
ult *vmf,
> +                                      pgoff_t start_pgoff, pgoff_t end_p=
goff)

my instinct here is to drop this small optimization, it has way too
much mm internals (mm counter, pmd_none, etc). Unless someone more
familiar with mm internal APIs reviews and acks, I'd drop this. I
don't think realistically anyone will do MAP_POPULATE eagerly and/or
care about few extra microseconds to page in a bunch of pages, so I'd
KISS it for now.

> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       unsigned long addr, rss =3D 0;
> +       vm_fault_t ret =3D 0;
> +       pte_t *start_pte;
> +       pgoff_t pgoff;
> +
> +       /*
> +        * The PTE table for this PMD must already exist; installing it n=
eeds
> +        * mm-internal helpers. If it is missing, let the regular ->fault=
 path
> +        * install it and rely on the next fault-around to batch the rest=
.
> +        */
> +       if (pmd_none(*vmf->pmd))
> +               return 0;
> +
> +       addr =3D vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_S=
HIFT);
> +       start_pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vm=
f->ptl);
> +       if (!start_pte)
> +               return 0;
> +       vmf->pte =3D start_pte;
> +
> +       for (pgoff =3D start_pgoff; pgoff <=3D end_pgoff;
> +            pgoff++, vmf->pte++, addr +=3D PAGE_SIZE) {
> +               struct folio *folio;
> +               struct page *page;
> +
> +               if (!pte_none(ptep_get(vmf->pte)))
> +                       continue;
> +
> +               page =3D array_map_fault_page(array, pgoff);
> +               if (!page)
> +                       continue;
> +
> +               folio =3D page_folio(page);
> +               folio_get(folio);
> +               set_pte_range(vmf, folio, page, 1, addr);
> +               rss++;
> +               if (addr =3D=3D vmf->address)
> +                       ret =3D VM_FAULT_NOPAGE;
> +       }
> +
> +       add_mm_counter(vma->vm_mm, MM_FILEPAGES, rss);
> +       pte_unmap_unlock(start_pte, vmf->ptl);
> +
> +       return ret;
>  }
> +#endif /* CONFIG_MMU */
>
>  static bool array_map_meta_equal(const struct bpf_map *meta0,
>                                  const struct bpf_map *meta1)
> @@ -812,6 +940,10 @@ const struct bpf_map_ops array_map_ops =3D {
>         .map_direct_value_addr =3D array_map_direct_value_addr,
>         .map_direct_value_meta =3D array_map_direct_value_meta,
>         .map_mmap =3D array_map_mmap,
> +#ifdef CONFIG_MMU
> +       .map_mmap_fault =3D array_map_mmap_fault,
> +       .map_mmap_pages =3D array_map_mmap_pages,
> +#endif
>         .map_seq_show_elem =3D array_map_seq_show_elem,
>         .map_check_btf =3D array_map_check_btf,
>         .map_lookup_batch =3D generic_map_lookup_batch,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ff9e3aa293d..990c2f5be40a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1077,9 +1077,39 @@ static void bpf_map_mmap_close(struct vm_area_stru=
ct *vma)
>                 bpf_map_write_active_dec(map);
>  }
>
> +/*
> + * Called for maps that populate their memory-mapped region lazily, i.e.=
 that
> + * return without wiring up any PTEs from their ->map_mmap callback. Map=
s that
> + * populate the whole VMA eagerly (e.g. via remap_vmalloc_range()) never=
 reach
> + * here.
> + */
> +static vm_fault_t bpf_map_mmap_fault(struct vm_fault *vmf)
> +{
> +       struct bpf_map *map =3D vmf->vma->vm_private_data;
> +
> +       if (!map->ops->map_mmap_fault)
> +               return VM_FAULT_SIGBUS;
> +
> +       return map->ops->map_mmap_fault(map, vmf);
> +}
> +
> +/* Fault-around: batch-populate PTEs around the faulting address. */
> +static vm_fault_t bpf_map_mmap_pages(struct vm_fault *vmf,
> +                                    pgoff_t start_pgoff, pgoff_t end_pgo=
ff)
> +{
> +       struct bpf_map *map =3D vmf->vma->vm_private_data;
> +
> +       if (!map->ops->map_mmap_pages)
> +               return 0;
> +
> +       return map->ops->map_mmap_pages(map, vmf, start_pgoff, end_pgoff)=
;
> +}
> +
>  static const struct vm_operations_struct bpf_map_default_vmops =3D {
>         .open           =3D bpf_map_mmap_open,
>         .close          =3D bpf_map_mmap_close,
> +       .fault          =3D bpf_map_mmap_fault,
> +       .map_pages      =3D bpf_map_mmap_pages,
>  };
>
>  static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
> --
> 2.53.0-Meta
>
