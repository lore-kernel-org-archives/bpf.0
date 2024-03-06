Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4D1C11
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759073; cv=none; b=nOHkvnzj4Yy1lT3HhOoTTOQnwdJTEnWpWCrLj3t8Z1+crGNbXdA83VEn+kbFZnjLSE3FxmUuMgrqTy09Jh4GfF2gnsrI1TkGEM9zWBfKFAkbwazCFLDsgWBbcj+IarjDZzl5WCj6keFQafJwVQ73ZetmPJg9anl7fBGASeP1ctw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759073; c=relaxed/simple;
	bh=O+iaHtXQ2wa/dSaixtLWAD/rOVgPhJ/t+3J/XX9MAeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhY3vjENgEW9J6SHxST9u67u836IJwGgNMbgs04DCus4GZSkOcK1p6hvWP8OfMGL63MxgBMeLCKH/9pR260QN8Fj5Fpllo/J1FbOQm/kYk82PlnnEI5MzbHs+KSR3vMU9grFuJUwOMRIwgvO7nhWtHsC0yYqJxwOcdNQXS69H8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=Ci5RI/lB; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="Ci5RI/lB"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a136ac89b3so64603eaf.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 13:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1709759071; x=1710363871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqttQc0z5BWF+Q6AXLXQysSwEBzzLxVsfG6yMYfqEBc=;
        b=Ci5RI/lBE3BQ8a9ZIsOkb+Ui3+M45VRDarnxLf4QpR4BULEpryOtEq5W/s6w0SgCip
         1scVAVHMGy1ghx0yGPIFjOzYc18tA5dhhD1xzPJgCazqZbVbcVxOfCVsYtetjiO6EHHI
         PNpB3161wdF3ksuonOdQqXUoMmhVD8ISc9mvDRm7ih/I0UQlt7Vo6tAj4ntxCWot3fPA
         ZMi8Uo3OaZPuas1NHC/Kwn5bwWjpGevwB5JKt8i2akE3LI9fxJ8XpiiT8vupj8z2AUf7
         SGV9yGC7CL0l2xG94zEg/n/LOyFkpiT16EVfuBUn6Lnqa90eVdyinvxl6Hu/Q83wbOaN
         9wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709759071; x=1710363871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqttQc0z5BWF+Q6AXLXQysSwEBzzLxVsfG6yMYfqEBc=;
        b=M4xlLHbFk1chLpmdfzotAvZhJYtwJPWBNuSW1bwy4MA8PCNC2RESfftuFqPjY8bTFT
         zCh0ApoWUxOC54Q86iHjA2Y5tYYkSwFsGnaAmIvQzms1ucYWNviARrSEP/5A2YMXvJ3h
         sAmy++5Ry5q55bETuZQ8Ueik9PUHsrOpRk85CDexC6RBcFClbnszK8t2RXmAPhd2Lk/h
         bpwqGb6E60xlo26yWHvijy6QDwip2W6Q8/dguWYEcpTRww3FpszUB11iup0jnHTPOMtC
         l00IVsHKOFuzcc2hfFq1e867WUfq6542AcCDFEAKjNxOQ4FRHPa+G0f8CqfVTigkeQ/w
         dMOA==
X-Gm-Message-State: AOJu0Yz2YTb9240UaogpJKOGYg0urJR1rNZ4AqqXS2vuDGGBVOg8TOpj
	FxTOiMp4h43tKzw0UNdO3PsSV0kvrC6ryxC0XpC6ImmMCtqpwucrme/e9h5nHsXQCwNMbtJwwjy
	XH8gDl6YyDIdpOYNpX9Aycf+mzxTGOxp4YnwEEx6CybQT7N0ezlk=
X-Google-Smtp-Source: AGHT+IH0C9ZIzGNFSz2j11GV3Dru4fT7GOz2PcdFewNaPrEAF+/MVK+QyAyKdBXc1oQAITbi8412yO35RUBzydE/0Wo=
X-Received: by 2002:a05:6358:10a5:b0:17b:bd6e:22c9 with SMTP id
 j37-20020a05635810a500b0017bbd6e22c9mr8106933rwi.8.1709759071077; Wed, 06 Mar
 2024 13:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com> <20240305030516.41519-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20240305030516.41519-3-alexei.starovoitov@gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 6 Mar 2024 16:03:54 -0500
Message-ID: <CA+CK2bDCgpYR2-gHv-H3vDXDqcoA16vMNr55BZ6nouZNdwGufQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, rppt@kernel.org, boris.ostrovsky@oracle.com, 
	sstabellini@kernel.org, jgross@suse.com, linux-mm@kvack.org, 
	xen-devel@lists.xenproject.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> vmap/vmalloc APIs are used to map a set of pages into contiguous kernel
> virtual space.
>
> get_vm_area() with appropriate flag is used to request an area of kernel
> address range. It's used for vmalloc, vmap, ioremap, xen use cases.
> - vmalloc use case dominates the usage. Such vm areas have VM_ALLOC flag.
> - the areas created by vmap() function should be tagged with VM_MAP.
> - ioremap areas are tagged with VM_IOREMAP.
>
> BPF would like to extend the vmap API to implement a lazily-populated
> sparse, yet contiguous kernel virtual space. Introduce VM_SPARSE flag
> and vm_area_map_pages(area, start_addr, count, pages) API to map a set
> of pages within a given area.
> It has the same sanity checks as vmap() does.
> It also checks that get_vm_area() was created with VM_SPARSE flag
> which identifies such areas in /proc/vmallocinfo
> and returns zero pages on read through /proc/kcore.
>
> The next commits will introduce bpf_arena which is a sparsely populated
> shared memory region between bpf program and user space process. It will
> map privately-managed pages into a sparse vm area with the following step=
s:
>
>   // request virtual memory region during bpf prog verification
>   area =3D get_vm_area(area_size, VM_SPARSE);
>
>   // on demand
>   vm_area_map_pages(area, kaddr, kend, pages);
>   vm_area_unmap_pages(area, kaddr, kend);
>
>   // after bpf program is detached and unloaded
>   free_vm_area(area);
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/vmalloc.h |  5 ++++
>  mm/vmalloc.c            | 59 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index c720be70c8dd..0f72c85a377b 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -35,6 +35,7 @@ struct iov_iter;              /* in uio.h */
>  #else
>  #define VM_DEFER_KMEMLEAK      0
>  #endif
> +#define VM_SPARSE              0x00001000      /* sparse vm_area. not al=
l pages are present. */
>
>  /* bits [20..32] reserved for arch specific ioremap internals */
>
> @@ -232,6 +233,10 @@ static inline bool is_vm_area_hugepages(const void *=
addr)
>  }
>
>  #ifdef CONFIG_MMU
> +int vm_area_map_pages(struct vm_struct *area, unsigned long start,
> +                     unsigned long end, struct page **pages);
> +void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
> +                        unsigned long end);
>  void vunmap_range(unsigned long addr, unsigned long end);
>  static inline void set_vm_flush_reset_perms(void *addr)
>  {
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index f42f98a127d5..e5b8c70950bc 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -648,6 +648,58 @@ static int vmap_pages_range(unsigned long addr, unsi=
gned long end,
>         return err;
>  }
>
> +static int check_sparse_vm_area(struct vm_struct *area, unsigned long st=
art,
> +                               unsigned long end)
> +{
> +       might_sleep();

This interface and in general VM_SPARSE would be useful for
dynamically grown kernel stacks [1]. However, the might_sleep() here
would be a problem. We would need to be able to handle
vm_area_map_pages() from interrupt disabled context therefore no
sleeping. The caller would need to guarantee that the page tables are
pre-allocated before the mapping.

Pasha

[1] https://lore.kernel.org/all/CA+CK2bBYt9RAVqASB2eLyRQxYT5aiL0fGhUu3TumQC=
yJCNTWvw@mail.gmail.com
