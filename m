Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5824F14276
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760527; cv=none; b=Wm2LiUcjemDb6u18nLlCk/HWRM3QyIWwRSLHFl0SOxJLcx2mnIkHPoqsGesBMh3sGurncUSG0tXZWPykZDQmt34uAB5zBFaK1v2NQGFCAG1PCGlpXzokjPSiCXTu3B/hzRlzwaTO4xcAOrBAdeKWl0gQ6nnFRs0K4nbCOq/tnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760527; c=relaxed/simple;
	bh=xviWqzLveo8kQJjAD4JEyknmLRyojWvCkOaeYNbq10M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmOlMQBxipIPldRek2D8+HfM5fL3HrdyePpVEI8ANO1bDQo+oNerlZbYy8HaQZPqzpqGyICc0nJkkFic8JeUStQvSlJ9fZVfArXKFRaTHX1MNi8W2UzKdOsZTBXI7sdVuZcxQCrvNQ2r21FO7BxWcG8tKG5u7PEymgSpXLV1+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAm0d9Z+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAm0d9Z+"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e122c8598so48291f8f.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709760523; x=1710365323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1WsOY8bv9E8W81TGc4aAT5ds7Sn1+QowuadTWjYWtk=;
        b=aAm0d9Z+LqYU0ua+jP4zoNqy4mySPZFslHZCIJXwm6dFAteDdwfiQa06GN2on4hmy4
         zMuk9w2ibXHC/cDcdNnOyKy8r+YrdE4odYfGQLqF0Uq1fqxzR3+Mqb9mP0UF/H4mg1A7
         LUGiQldiIjKCUEQ51UV1Y/pHe7rD2tTippWx99WQnPJwYmExOLSOSc2CBpWA/HCXlzjj
         PqqQStn4+mPJiLVMmvbJP3LVUQAq6j2leZzhSotsw7YNzOv06VHj7oyEcd7oxRpWSRPo
         N9AXB1pQZ8SRLGDu/9l/HMnruT0FJqFZ2eWW1tH7wIu+8X+z9ZHwhUor/wqZtkQl6k1g
         tVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760523; x=1710365323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1WsOY8bv9E8W81TGc4aAT5ds7Sn1+QowuadTWjYWtk=;
        b=QDYZmKzQ9YI+CsX62FpIhZXqnXt1gM/uiMQb/0NQS9cMccJH3kABbiitQ/296fNhWU
         by+13CEHwleh4In6ZsN9qm6ZPIEXssVr5PU6ur5Mxlrtv8Z4zLOufpRIAjuEuy9MHcUJ
         VZGltk/axmwhFmeEUWQ0d6ijM/JPqwR0/dm++H3w+2MRJxjhxW/lwV5pERhwLWYPlNbz
         OZPK7X81JxME8AOB4Ho0RPcZnO8z2Q2dsXcNemm4rCujZZB/lUL0vVTGlb8GrkJ6I7Ym
         gh6WUaqtvpMJSRzJ+HjsABUWbo7z7kKQR0LMxle83jVLib7POcCoehIdtopYprr4pfXS
         7Mjw==
X-Gm-Message-State: AOJu0YwyTEDvgpE8OU7gY+LNfZ+Q6EBQ91/u+VZDiTQUDIhkYkvyILgH
	ln4qKm/rHyPQMZzfUh4z4BpoytCYx19ogcGuqy9IakZtTA1S4f+kxxJEihhKC62xEQTGtqUGu3A
	bOptTb3zSLOCvbygCiZ3PBVBSLvo=
X-Google-Smtp-Source: AGHT+IE8LqByzqRA7G6sW+7haX1F0BJfAJWcPpQ+nTruzkV9H0WItHjtg14wkPEK8qPwytWAsZTgM/brnIzbFge2cI0=
X-Received: by 2002:a5d:5750:0:b0:33d:1145:8787 with SMTP id
 q16-20020a5d5750000000b0033d11458787mr11006914wrw.25.1709760523501; Wed, 06
 Mar 2024 13:28:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
 <20240305030516.41519-3-alexei.starovoitov@gmail.com> <CA+CK2bDCgpYR2-gHv-H3vDXDqcoA16vMNr55BZ6nouZNdwGufQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDCgpYR2-gHv-H3vDXDqcoA16vMNr55BZ6nouZNdwGufQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 13:28:31 -0800
Message-ID: <CAADnVQ+pxrRRvyLXG+opUuPuYZc+XTBLksK0rERrS1BY9ayQpQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, sstabellini@kernel.org, 
	Juergen Gross <jgross@suse.com>, linux-mm <linux-mm@kvack.org>, xen-devel@lists.xenproject.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:04=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Mon, Mar 4, 2024 at 10:05=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > vmap/vmalloc APIs are used to map a set of pages into contiguous kernel
> > virtual space.
> >
> > get_vm_area() with appropriate flag is used to request an area of kerne=
l
> > address range. It's used for vmalloc, vmap, ioremap, xen use cases.
> > - vmalloc use case dominates the usage. Such vm areas have VM_ALLOC fla=
g.
> > - the areas created by vmap() function should be tagged with VM_MAP.
> > - ioremap areas are tagged with VM_IOREMAP.
> >
> > BPF would like to extend the vmap API to implement a lazily-populated
> > sparse, yet contiguous kernel virtual space. Introduce VM_SPARSE flag
> > and vm_area_map_pages(area, start_addr, count, pages) API to map a set
> > of pages within a given area.
> > It has the same sanity checks as vmap() does.
> > It also checks that get_vm_area() was created with VM_SPARSE flag
> > which identifies such areas in /proc/vmallocinfo
> > and returns zero pages on read through /proc/kcore.
> >
> > The next commits will introduce bpf_arena which is a sparsely populated
> > shared memory region between bpf program and user space process. It wil=
l
> > map privately-managed pages into a sparse vm area with the following st=
eps:
> >
> >   // request virtual memory region during bpf prog verification
> >   area =3D get_vm_area(area_size, VM_SPARSE);
> >
> >   // on demand
> >   vm_area_map_pages(area, kaddr, kend, pages);
> >   vm_area_unmap_pages(area, kaddr, kend);
> >
> >   // after bpf program is detached and unloaded
> >   free_vm_area(area);
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/vmalloc.h |  5 ++++
> >  mm/vmalloc.c            | 59 +++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index c720be70c8dd..0f72c85a377b 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -35,6 +35,7 @@ struct iov_iter;              /* in uio.h */
> >  #else
> >  #define VM_DEFER_KMEMLEAK      0
> >  #endif
> > +#define VM_SPARSE              0x00001000      /* sparse vm_area. not =
all pages are present. */
> >
> >  /* bits [20..32] reserved for arch specific ioremap internals */
> >
> > @@ -232,6 +233,10 @@ static inline bool is_vm_area_hugepages(const void=
 *addr)
> >  }
> >
> >  #ifdef CONFIG_MMU
> > +int vm_area_map_pages(struct vm_struct *area, unsigned long start,
> > +                     unsigned long end, struct page **pages);
> > +void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
> > +                        unsigned long end);
> >  void vunmap_range(unsigned long addr, unsigned long end);
> >  static inline void set_vm_flush_reset_perms(void *addr)
> >  {
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index f42f98a127d5..e5b8c70950bc 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -648,6 +648,58 @@ static int vmap_pages_range(unsigned long addr, un=
signed long end,
> >         return err;
> >  }
> >
> > +static int check_sparse_vm_area(struct vm_struct *area, unsigned long =
start,
> > +                               unsigned long end)
> > +{
> > +       might_sleep();
>
> This interface and in general VM_SPARSE would be useful for
> dynamically grown kernel stacks [1]. However, the might_sleep() here
> would be a problem. We would need to be able to handle
> vm_area_map_pages() from interrupt disabled context therefore no
> sleeping. The caller would need to guarantee that the page tables are
> pre-allocated before the mapping.

Sounds like we'd need to differentiate two kinds of sparse regions.
One that is really sparse where page tables are not populated (bpf use case=
)
and another where only the pte level might be empty.
Only the latter one will be usable for such auto-grow stacks.

Months back I played with this idea:
https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?&id=3Dc=
e63949a879f2f26c1c1834303e6dfbfb79d1fbd
that
"Make vmap_pages_range() allocate page tables down to the last (PTE) level.=
"
Essentially pass NULL instead of 'pages' into vmap_pages_range()
and it will populate all levels except the last.
Then the page fault handler can service a fault in auto-growing stack
area if it has a page stashed in some per-cpu free list.
I suspect this is something you might need for
"16k stack that is populated on fault",
plus a free list of 3 pages per-cpu,
and set_pte_at() in pf handler.
