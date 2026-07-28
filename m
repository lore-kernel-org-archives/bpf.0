Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8D157487
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197314; cv=pass; b=V4lSn969U3/XuasrT5w7XcOF1rfc/E0+yb+/hWuxMEy1gv2X/lrYurX0VnYFTQIvK/fY57UOjsMfnt5vKiJjQqyqIl1F6mOtuDE+XlXczP/NWIkuINJ6vA1QRP3Av7mYKr6LnpOEOn5pkElXMhCD4q+4cDi3RM95YHCVNzxuqaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197314; c=relaxed/simple;
	bh=voxm8VmqWRxT16M4v5FlC9VfSgM+rfNj0Lnz0u8QsYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0W6NPsYG0g08q09YUcaE3GfNjwW1eC6uLihvAmx+L8Nj8KuCLsn5ebNAnx87qPviCrCYVbVHM4h6L48eROVZ8VBcvntnZ5BkfeyTM8I3UkbtNmGqn9JMf5ItHiSvnDlLye2ZBoXO3yOAH8czN+/Zj3C4Ns2Ob6aL5AIZSRCZGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Udu1EkH7; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udu1EkH7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-848595b338cso3583259b3a.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 17:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785197312; cv=none;
        d=google.com; s=arc-20260327;
        b=OFyfmwwepKnORU7jsvDPsR7xL6zeVJtNjdJ96M1XkUr1nhonwPpG+D55NXBMejSLcT
         8NLHmkhEExPhOPnDzAKYZxg0VCFN+CchLOJRkKbspP4k3bAgfLr+8rqcQllPFeJbH/i7
         AiDaMYdrbISyaYlj8XktR42lhZPidMohMASnydzUdV4of9umcf9kORpNqC288YxshS7D
         3YV9otvIycGemodQLlHBxpBaloJreH/paSOROxOBFFVZh56CwH57Tg+nDFQ9DxQ7XelV
         ZHwo0SFIac6Dg55TWmAnL06q4QSBRJ987wUYTkuIiwaP+gZ270fcJTy3E93OHLqorOLF
         FiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sukUGR/r/jcZqixsvEfVTV8/DBs4WxfTg7TXAo14YbY=;
        fh=qVtT5G4755aEjqfiI9ibJkCwPSxkeQqFp/HyF6+NL2U=;
        b=UibUvGrOZf7qso6wRpGvgD4nLXrDm9vmA9XH1A09UYYjqxkD6tstGlzTFS55qQY4fz
         smS2aIQWHt8YYAvF5YzqqxVV2wTAFw1cC/ybxxPHpyNVOKdbGVD4vzImyXGWkVxOlFfu
         i54RxeB3tS8n8PuSIsT8TvN/caToiLsTvWJKchLQL5GnEi0RIrawtt4wG741wSHUTnXq
         XPvi377nFN6Y6X6Kp10xDD/3HSEw98Tm7pyl0VUaRJmMDq59jtk8bDDgGq0dBrMcORvU
         oxaYz5r8fsyO/9Y6tqzkhE3lBGYK5ithLrTX6c2XQqK21v7GnnrQlQpf+Qi/2yWfuisO
         gIxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785197312; x=1785802112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sukUGR/r/jcZqixsvEfVTV8/DBs4WxfTg7TXAo14YbY=;
        b=Udu1EkH7dX5zJ9XeuiSDPxkLIX9//A9IXFij4Ryi4X2C4Z6VKEp+mQyCqz9sMccA5T
         FCFF8vcsfCApdWHQrIq/rF6JHuSdpIqu9GuTN5GhxZ4Aj5Suf7/HIloYIaWebQjGQ1EH
         S9VyCw2mXDbDri3lqSxJz92XmZbd/2pKHeaj2a7Wxml7ccnGDkri7ixilGRhGXMFuuxp
         41bXZKd2JKgmk0SjuINw9mqhKaFHK9M9qsZsiQqz2ko4U+HOj5SQEm17c0jKWfvhIapE
         aqZPv/1fW9R/vqWfL8ZdD2MBikJlBM1jrwKKYo9XS3hgiI3ET957BRN5XTeW1raedzg9
         rp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197312; x=1785802112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sukUGR/r/jcZqixsvEfVTV8/DBs4WxfTg7TXAo14YbY=;
        b=QNqe+D4U+kb1kzWDt8xzEsPWem42XYH1ok5E6bHBYOLWv1FTK4lnFb3qdMaOYt0DUw
         ErUJB8QSGhObblabRqWBsW/FyriIrdBXJqfAq2UQj3cg0TIIOjgGfXyDEhhwdbUgMxu3
         Fkg6KFvn1bGGjcnlWm0/XK+MIoobLeSJk6gEF4HUCiYSerXkC1kRf6Hzsx9kWEP3r9bA
         nj5yH4v9YL8kCHQxNgnnYBmjWTRMQbhMWasPKsN1DCjhtJgTyWtI+LGGVHrQP1FdX1oU
         YJtMPGA3qu/cdy5kJ6AEv+FF3n0VluQ6plKQ8MyAMnHPlhGUjP8wQXHNApTYqdnsKN48
         u5wA==
X-Gm-Message-State: AOJu0YwMYD/DtdoIMIcYEjClEs359j8nFOfRjIL1oTTyIkcHW89kmEIH
	syt+SXr+xfNRLsklJ03lio+rdrOoEEBO6kg9puev/O661WVoSRlYKH2YYjRwi4ubBsY68lxBECL
	WWq4ec1RWfxSwEvJStzw8Oqm0DrLRLoE=
X-Gm-Gg: AR+sD11T5Ik1PYXt5lKtDZ9z8b0iqY+aOHBRlNBICOMEWUyq29Of2Y3Xs+du2MNCzOz
	F/zXqPr5VRc10lE/8FMLQuMAuh4CpFpuIHlzO0QsWf+jdnO9HV9JXlM9O7OFq7bGNMlWWNB0ySX
	vcIPXjOUo4HDvTCV8J10Bf4YR3yFg+hDcQM3+XAwGQaVcGJZtfxjicY2eCJL7FjpEI/azzCZAg4
	Xvf0nyz+QnjJYHfY/9PTch+gL0/SbkUf2QPa4yts0OmfIC/hsVnMNSw3Wxj5DfHuZQaaf8BLPwF
	ufctIo4C+bmLS4uwo7K59WDM44mmHHTeLzAG29c8ZB1v609VvXfguTj/7A==
X-Received: by 2002:a05:6a00:3ccf:b0:845:4928:8655 with SMTP id
 d2e1a72fcca58-84e93334b79mr62636b3a.39.1785197312400; Mon, 27 Jul 2026
 17:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722205032.1245094-1-song@kernel.org> <20260722205032.1245094-2-song@kernel.org>
In-Reply-To: <20260722205032.1245094-2-song@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 17:08:17 -0700
X-Gm-Features: AUfX_mxSUEsOLS6J2baJUEUyxBn2glN1rcHemoFiFBKNS6fJWA3uirM9SWmvtuY
Message-ID: <CAEf4BzZmStZdra-mf9taSQ2=9ghSJaV_KS-MdsBCGE7upzFmrg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Populate mmap-able array map memory lazily
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:50=E2=80=AFPM Song Liu <song@kernel.org> wrote:
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
> leaving the PTEs unpopulated; the pages are inserted on demand by a new
> array_map_mmap_fault() handler. Because the memory is already resident,
> the fault handler simply resolves the vmalloc page and hands it to the
> fault path.
>
> To keep the existing VMA open/close accounting (VM_MAYWRITE write-active
> tracking, freeze handling) centralized, the fault handler is reached
> through a new optional ->map_mmap_fault callback dispatched from the
> shared bpf_map_default_vmops, rather than each map installing its own
> vm_operations_struct.
>
> remap_vmalloc_range() previously guarded against offset overflow; since
> it is no longer used, array_map_mmap() and the fault handler compute the
> mapping offset with 64-bit arithmetic so that a large vm_pgoff cannot
> overflow the bounds check on 32-bit architectures.
>
> This turns mmap()/munmap() of an mmap-able array from O(map size) into
> O(1). Callers that want the pages populated up front can still request
> that explicitly with MAP_POPULATE, matching regular file semantics.
> Kernel-side access to the map (via the vmalloc address) is unaffected.
>
> Signed-off-by: Song Liu <song@kernel.org>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/arraymap.c | 43 +++++++++++++++++++++++++++++++++++++++----
>  kernel/bpf/syscall.c  | 17 +++++++++++++++++
>  3 files changed, 57 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e066f44a9c05..b536f3c9e103 100644
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
> index 248b4818178c..59fda56062a9 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -576,17 +576,51 @@ static int array_map_check_btf(struct bpf_map *map,
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
> +        * The backing memory is vmalloc'ed up front, so instead of wirin=
g up
> +        * every PTE here we let array_map_mmap_fault() insert pages on d=
emand.
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
> +static vm_fault_t array_map_mmap_fault(struct bpf_map *map,
> +                                      struct vm_fault *vmf)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       pgoff_t pgoff =3D PAGE_ALIGN(sizeof(*array)) >> PAGE_SHIFT;
> +       struct page *page;
> +       void *kaddr;
> +
> +       /*
> +        * vmf->pgoff is the page offset within the mapping (vma->vm_pgof=
f plus
> +        * the offset of the faulting address). The data pages start afte=
r the
> +        * bpf_array header, hence the extra pgoff. This mirrors the offs=
et that
> +        * remap_vmalloc_range(vma, ..., vma->vm_pgoff + pgoff) used to a=
pply.
> +        */
> +       kaddr =3D array_map_vmalloc_addr(array) +
> +               (((u64)vmf->pgoff + pgoff) << PAGE_SHIFT);
> +

remap_vmalloc_range() uses careful check_shl_overflow() and
check_add_overflow() checks, while we just (u64) cast and go... should
we be more careful and avoid some weird edge cases. Not sure if that's
possible, but maybe better safe than sorry?

> +       page =3D vmalloc_to_page(kaddr);
> +       if (!page)
> +               return VM_FAULT_SIGBUS;
> +
> +       get_page(page);
> +       vmf->page =3D page;
> +
> +       return 0;
>  }
>
>  static bool array_map_meta_equal(const struct bpf_map *meta0,
> @@ -812,6 +846,7 @@ const struct bpf_map_ops array_map_ops =3D {
>         .map_direct_value_addr =3D array_map_direct_value_addr,
>         .map_direct_value_meta =3D array_map_direct_value_meta,
>         .map_mmap =3D array_map_mmap,
> +       .map_mmap_fault =3D array_map_mmap_fault,
>         .map_seq_show_elem =3D array_map_seq_show_elem,
>         .map_check_btf =3D array_map_check_btf,
>         .map_lookup_batch =3D generic_map_lookup_batch,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ff9e3aa293d..fb0e1f55c487 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1077,9 +1077,26 @@ static void bpf_map_mmap_close(struct vm_area_stru=
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
>  static const struct vm_operations_struct bpf_map_default_vmops =3D {
>         .open           =3D bpf_map_mmap_open,
>         .close          =3D bpf_map_mmap_close,
> +       .fault          =3D bpf_map_mmap_fault,
>  };
>
>  static int bpf_map_mmap(struct file *filp, struct vm_area_struct *vma)
> --
> 2.53.0-Meta
>
