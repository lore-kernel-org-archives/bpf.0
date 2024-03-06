Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D081B299
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766733; cv=none; b=fYiyRP/bvFYDGEx8SvQ/tBirexJAQgLmo8PRVWybfBgeo8CRjHDmOOToAFZtbFiRTVwMl3Gw0ZisDXFugI0ehPawbjcYrprAQGsa20tRVD3E63iAVSojY62nV/eZgG2PkMKpBhAmRjdwSFE3x8ZzA/i+mhjllSokce6Wjxa4tjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766733; c=relaxed/simple;
	bh=0CK0YpLudjb11T8MrxGteY9zF5rLVq8zOos2R2OfRQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqCfbdvE91b+r23uzY2iZdvn6Mvb25ArlEBbKh0LeM63HAvQyoSoOgHn8eKWDjdRaR0sTE8yzFXhsGwyPKQnR5gn4celql/zdvxPxV6jCVYAIjxfEuBgKIuJAv3bfzKjNHkE2oQ6rhA/Z1q3vRqU9bsD6lsIxzNxOI9UIQ6BQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMOSXQ7A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMOSXQ7A"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412f1961101so3240085e9.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 15:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766730; x=1710371530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx5iRvChP8NO+/mhuLuLKmdBFsw3uQNbAw3BGNdYR3g=;
        b=hMOSXQ7AVWfTW20UBRKWrIAIzJBsybngrWg21zNmmvq6yn2KBM7KqxwH8WzaZYgoUI
         MKIBg4d7eRYytJHAKv7QmqMkoAZaCx1K9p49zS6P9sJzg2eOofrBgfiyl/K8b7Novc5D
         ym9537xdqD8eFx3w1/k9w0W4D80CHB3HWu+c1syMx1qhxeg0Br2Hnxm5XfyL+PZdBXL0
         v1of6WlvRQQtYFR4Nm9pwzMxUwgKxIz4b5ribFUWU3t8B2+FOocGQRGLke86fosPQvMr
         mmzwY922ZqPm4JIWr6tQsXlQH7IUFqEny//Hxta0CeIsYAM2A84t8RMJnLuyqnwa5rs3
         cfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766730; x=1710371530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx5iRvChP8NO+/mhuLuLKmdBFsw3uQNbAw3BGNdYR3g=;
        b=fl0N+pivpjEiS/kHPowETmob49is7zlToMScj6WieRh2VIrpkk+frs5+J2qIcDL7Y3
         TgX6i3bc24HbYvZIWwYnQpCx49GSj+YQPY1lYJDivfs+7KdT6zcTqDriaBEoRvlVxQfe
         2vUz8U3ly9fWwLJnTJVEZfI0tnhgSrsJq50CBwVP+3oJRApSgVUQ2SqfFM7kpVUe9BP4
         M2g4LTqZx9+IPawYsPZfy7OPiJskiH34VrVzRASvoSlRCtDlld65Ffib3CU6DbcyNDgA
         mjFWvBV3P7as8vbd148ovHiLNYkjUFGq1F8jt6sETikgmN2itrEDItmPIOUibG8GSHXr
         SpRg==
X-Gm-Message-State: AOJu0YxcHdqnsuHADYALNof7ZiuNo+0fM9MKN2miMjLiJ7pNzCE0R42G
	+tIc3p7ryfew028GkxRJLzNUEGGlrz4OfjeDK1icMLxLlm55wldDdKEbwH4WzPQRmIAdadUwI1U
	NZYCBbh/S+4mwxbIn2QA4rZVaoCU=
X-Google-Smtp-Source: AGHT+IGLGZhZkUQNkXFQULSBWx3zFTB/DY3Hwy4o8Qn6U6VB9fAcd5bv3pWUFD1OuIX/9JAsZj7/H8SpTHn4VXTZWJQ=
X-Received: by 2002:a5d:5918:0:b0:33e:1bec:c48f with SMTP id
 v24-20020a5d5918000000b0033e1becc48fmr11116715wrd.24.1709766729962; Wed, 06
 Mar 2024 15:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
 <20240305030516.41519-3-alexei.starovoitov@gmail.com> <CA+CK2bDCgpYR2-gHv-H3vDXDqcoA16vMNr55BZ6nouZNdwGufQ@mail.gmail.com>
 <CAADnVQ+pxrRRvyLXG+opUuPuYZc+XTBLksK0rERrS1BY9ayQpQ@mail.gmail.com>
 <CA+CK2bAhWgSSotKjiGA4oTbH0XaCAtiWe+5p5u9OAf0ykBekwg@mail.gmail.com>
 <CAADnVQL9h7R0zYyr=P4jm9AFvK27Vx+rrUuPjTuw4QpubNngpw@mail.gmail.com> <CA+CK2bDUA0zes3Qk5JPPurKc_8fTCbuz8VFYVc9wa7gjUbHHvA@mail.gmail.com>
In-Reply-To: <CA+CK2bDUA0zes3Qk5JPPurKc_8fTCbuz8VFYVc9wa7gjUbHHvA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 15:11:58 -0800
Message-ID: <CAADnVQ+AJmddbKWzanasiE38rZcq533w-MoXKqfZNtstzKg12Q@mail.gmail.com>
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

On Wed, Mar 6, 2024 at 2:57=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Wed, Mar 6, 2024 at 5:13=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Mar 6, 2024 at 1:46=E2=80=AFPM Pasha Tatashin <pasha.tatashin@s=
oleen.com> wrote:
> > >
> > > > > This interface and in general VM_SPARSE would be useful for
> > > > > dynamically grown kernel stacks [1]. However, the might_sleep() h=
ere
> > > > > would be a problem. We would need to be able to handle
> > > > > vm_area_map_pages() from interrupt disabled context therefore no
> > > > > sleeping. The caller would need to guarantee that the page tables=
 are
> > > > > pre-allocated before the mapping.
> > > >
> > > > Sounds like we'd need to differentiate two kinds of sparse regions.
> > > > One that is really sparse where page tables are not populated (bpf =
use case)
> > > > and another where only the pte level might be empty.
> > > > Only the latter one will be usable for such auto-grow stacks.
> > > >
> > > > Months back I played with this idea:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/=
?&id=3Dce63949a879f2f26c1c1834303e6dfbfb79d1fbd
> > > > that
> > > > "Make vmap_pages_range() allocate page tables down to the last (PTE=
) level."
> > > > Essentially pass NULL instead of 'pages' into vmap_pages_range()
> > > > and it will populate all levels except the last.
> > >
> > > Yes, this is what is needed, however, it can be a little simpler with
> > > kernel stacks:
> > > given that the first page in the vm_area is mapped when stack is firs=
t
> > > allocated, and that the VA range is aligned to 16K, we actually are
> > > guaranteed to have all page table levels down to pte pre-allocated
> > > during that initial mapping. Therefore, we do not need to worry about
> > > allocating them later during PFs.
> >
> > Ahh. Found:
> > stack =3D __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN, ...
> >
> > > > Then the page fault handler can service a fault in auto-growing sta=
ck
> > > > area if it has a page stashed in some per-cpu free list.
> > > > I suspect this is something you might need for
> > > > "16k stack that is populated on fault",
> > > > plus a free list of 3 pages per-cpu,
> > > > and set_pte_at() in pf handler.
> > >
> > > Yes, what you described is exactly what I am working on: using 3-page=
s
> > > per-cpu to handle kstack page faults. The only thing that is missing
> > > is that I would like to have the ability to call a non-sleeping
> > > version of vm_area_map_pages().
> >
> > vm_area_map_pages() cannot be non-sleepable, since the [start, end)
> > range will dictate whether mid level allocs and locks are needed.
> >
> > Instead in alloc_thread_stack_node() you'd need a flavor
> > of get_vm_area() that can align the range to THREAD_ALIGN.
> > Then immediately call _sleepable_ vm_area_map_pages() to populate
> > the first page and later set_pte_at() the other pages on demand
> > from the fault handler.
>
> We still need to get to PTE level to use set_pte_at(). So, either
> store it in task_struct for faster PF handling, or add another
> non-sleeping vmap function that will do something like this:
>
> vm_area_set_page_at(addr, page)
> {
>    pgd =3D pgd_offset_k(addr)
>    p4d =3D vunmap_p4d_range(pgd, addr)
>    pud =3D pud_offset(p4d, addr)
>    pmd =3D pmd_offset(pud, addr)
>    pte =3D pte_offset_kernel(pmd, addr)
>
>   set_pte_at(init_mm, addr, pte, mk_pte(page...));
> }

Right. There are several flavors of this logic across the tree.
What you're proposing is pretty much vmalloc_to_page() that
returns pte even if !pte_present, instead of a page.
x86 is doing mostly the same in lookup_address() fwiw.
Good opportunity to clean all this up and share the code.
