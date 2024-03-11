Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605CD2E40E
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710196898; cv=none; b=qeCf9lIX/mjpZdblxqHm0Mfl0wwiRVkW4vIeDXjhqla0keta/hCt5Po8Cu/j+07aqqLd7XWsYbABbiS+sIqUYm2/OamnGSfr7VsuyUb+RYzz2qSK2yqapm5cJ8GdIWjH9bpfQhpW1z3QMZnaJdSm+S2znhSBk3A3k+8TUhMNnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710196898; c=relaxed/simple;
	bh=NY6WJfma3w0fqrBah/5WHpz+d6m0UwE1dmEVrxO/xVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JETi1mnxgNCcSCpg8fnTI/6B1GtGG0SUhXwsebd88/FD2Y238YodtQYomgwDs3ScVQXr0qwRzf2GOU4Hfg25B7Y5JNA/9Bpouipkr8P/9/o26iNdkTfAKalhL84BYqpoyexMY/JHYQfMoyV5q+DPA9Rh0mMHHOTBDpBOi5ZH5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7J9JcOW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7J9JcOW"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e93514a6aso1067946f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710196895; x=1710801695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+hok7CMknf8yCF5IjgqLKY0YhTUilq17BilfYStpvg=;
        b=R7J9JcOWrZuSSi4qjRjKIG7BJ7FQLBTDEaQQwp5QfLRosClTmJPaqu6RmqVtTBxI4f
         Y49JOfRBhT1b0dO02FSZyVvtJtu4dSqEIvyDXxHLBh/PeW0YgVQKelElTGyc2f1goNTs
         PEaBKZ01uEUkpk4IEz2EnYuO3DwHXyJvzBAy4xxAUhATgf2U33LLjlDF5Rz3C7zi8+x9
         GA2v302dYXfDZ+edtAB70QvMWHmdulfAwDos4kiHhGaMHSE9V6zEELMoUm2Szd5e0YRZ
         R1TsAlRt+/l5yc9+zBynb+LpJTJutdEIvkeS/uJxK4pgI2uAaFN80OncfNCDh5/MMZ5X
         SS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710196895; x=1710801695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+hok7CMknf8yCF5IjgqLKY0YhTUilq17BilfYStpvg=;
        b=mC2A2wduemu+yu61WFePVehUL31cniIAiCRaC7AyxEB4uYUSnykKMgdQNgESdUVIaV
         yO/uhCKgIfu7JMsGefQByfuPbVyfbweaAMkhkjl8Yqyq4UZ/hM+IdqqxTYTqdVlvUT0u
         /gHTnw3/iS0DzhB/M6D2QGR3TdI/WFN3nXtbS/0RlhNl2gR427OdC5y7wOSKepMI8UBw
         eAK0+m6pL2uy4wuv+Def8mV1bfB+110wXKsPYgst0jCF+In6isgbG1qPAEZCzqJSF/dz
         z4QS+UD51PyTdHCoPTeWlU3TRUcsLyUJ7zRTEAbR+pmhUJJk238jkqImbz/+wk1/kE+j
         4+vg==
X-Gm-Message-State: AOJu0YzXpwAmRvus2x3xC5yP1d7/rLF3eyOEDNx4JfPHbjVDR8X8EzMw
	dSQ0axi3770feC0ZWli49xKaBHzhoWmD5a9OMGOeWKRtpVTipFHGL5r3SPOGXojDflWYgXRp4El
	nC1Shcgeu63pWtkW+JCNdqm/Ikh8=
X-Google-Smtp-Source: AGHT+IGgI3+NI1PGKg12H0R2P3I+ZtGed1aY5NXNAvQ/BizygxdDMQBVRXY/BlkeWmse+ER0enQ+FoGWpjzMiADqqzY=
X-Received: by 2002:a05:6000:18af:b0:33d:5484:e451 with SMTP id
 b15-20020a05600018af00b0033d5484e451mr7288705wri.34.1710196894373; Mon, 11
 Mar 2024 15:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com>
 <20240308010812.89848-2-alexei.starovoitov@gmail.com> <CAEf4BzZr_Ki7VnEO6Gi-w07vX9p-oaqaGZQq62VTD_fJm39K4A@mail.gmail.com>
In-Reply-To: <CAEf4BzZr_Ki7VnEO6Gi-w07vX9p-oaqaGZQq62VTD_fJm39K4A@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 15:41:22 -0700
Message-ID: <CAADnVQ+4ySB7hxZ-vbt5u7YPNqORXo87rLq8D05oO_GQLXM2iQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/14] bpf: Introduce bpf_arena.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 3:01=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 7, 2024 at 5:08=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce bpf_arena, which is a sparse shared memory region between the=
 bpf
> > program and user space.
> >
> > Use cases:
> > 1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed
> >    anonymous region, like memcached or any key/value storage. The bpf
> >    program implements an in-kernel accelerator. XDP prog can search for
> >    a key in bpf_arena and return a value without going to user space.
> > 2. The bpf program builds arbitrary data structures in bpf_arena (hash
> >    tables, rb-trees, sparse arrays), while user space consumes it.
> > 3. bpf_arena is a "heap" of memory from the bpf program's point of view=
.
> >    The user space may mmap it, but bpf program will not convert pointer=
s
> >    to user base at run-time to improve bpf program speed.
> >
> > Initially, the kernel vm_area and user vma are not populated. User spac=
e
> > can fault in pages within the range. While servicing a page fault,
> > bpf_arena logic will insert a new page into the kernel and user vmas. T=
he
> > bpf program can allocate pages from that region via
> > bpf_arena_alloc_pages(). This kernel function will insert pages into th=
e
> > kernel vm_area. The subsequent fault-in from user space will populate t=
hat
> > page into the user vma. The BPF_F_SEGV_ON_FAULT flag at arena creation =
time
> > can be used to prevent fault-in from user space. In such a case, if a p=
age
> > is not allocated by the bpf program and not present in the kernel vm_ar=
ea,
> > the user process will segfault. This is useful for use cases 2 and 3 ab=
ove.
> >
> > bpf_arena_alloc_pages() is similar to user space mmap(). It allocates p=
ages
> > either at a specific address within the arena or allocates a range with=
 the
> > maple tree. bpf_arena_free_pages() is analogous to munmap(), which free=
s
> > pages and removes the range from the kernel vm_area and from user proce=
ss
> > vmas.
> >
> > bpf_arena can be used as a bpf program "heap" of up to 4GB. The speed o=
f
> > bpf program is more important than ease of sharing with user space. Thi=
s is
> > use case 3. In such a case, the BPF_F_NO_USER_CONV flag is recommended.
> > It will tell the verifier to treat the rX =3D bpf_arena_cast_user(rY)
> > instruction as a 32-bit move wX =3D wY, which will improve bpf prog
> > performance. Otherwise, bpf_arena_cast_user is translated by JIT to
> > conditionally add the upper 32 bits of user vm_start (if the pointer is=
 not
> > NULL) to arena pointers before they are stored into memory. This way, u=
ser
> > space sees them as valid 64-bit pointers.
> >
> > Diff https://github.com/llvm/llvm-project/pull/84410 enables LLVM BPF
> > backend generate the bpf_addr_space_cast() instruction to cast pointers
> > between address_space(1) which is reserved for bpf_arena pointers and
> > default address space zero. All arena pointers in a bpf program written=
 in
> > C language are tagged as __attribute__((address_space(1))). Hence, clan=
g
> > provides helpful diagnostics when pointers cross address space. Libbpf =
and
> > the kernel support only address_space =3D=3D 1. All other address space
> > identifiers are reserved.
> >
> > rX =3D bpf_addr_space_cast(rY, /* dst_as */ 1, /* src_as */ 0) tells th=
e
> > verifier that rX->type =3D PTR_TO_ARENA. Any further operations on
> > PTR_TO_ARENA register have to be in the 32-bit domain. The verifier wil=
l
> > mark load/store through PTR_TO_ARENA with PROBE_MEM32. JIT will generat=
e
> > them as kern_vm_start + 32bit_addr memory accesses. The behavior is sim=
ilar
> > to copy_from_kernel_nofault() except that no address checks are necessa=
ry.
> > The address is guaranteed to be in the 4GB range. If the page is not
> > present, the destination register is zeroed on read, and the operation =
is
> > ignored on write.
> >
> > rX =3D bpf_addr_space_cast(rY, 0, 1) tells the verifier that rX->type =
=3D
> > unknown scalar. If arena->map_flags has BPF_F_NO_USER_CONV set, then th=
e
> > verifier converts such cast instructions to mov32. Otherwise, JIT will =
emit
> > native code equivalent to:
> > rX =3D (u32)rY;
> > if (rY)
> >   rX |=3D clear_lo32_bits(arena->user_vm_start); /* replace hi32 bits i=
n rX */
> >
> > After such conversion, the pointer becomes a valid user pointer within
> > bpf_arena range. The user process can access data structures created in
> > bpf_arena without any additional computations. For example, a linked li=
st
> > built by a bpf program can be walked natively by user space.
> >
> > Reviewed-by: Barret Rhoden <brho@google.com>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  include/linux/bpf.h            |   7 +-
> >  include/linux/bpf_types.h      |   1 +
> >  include/uapi/linux/bpf.h       |  10 +
> >  kernel/bpf/Makefile            |   3 +
> >  kernel/bpf/arena.c             | 558 +++++++++++++++++++++++++++++++++
> >  kernel/bpf/core.c              |  11 +
> >  kernel/bpf/syscall.c           |  36 +++
> >  kernel/bpf/verifier.c          |   1 +
> >  tools/include/uapi/linux/bpf.h |  10 +
> >  9 files changed, 635 insertions(+), 2 deletions(-)
> >  create mode 100644 kernel/bpf/arena.c
> >
>
> [...]
>
> >
> >  struct bpf_offload_dev;
> > @@ -2215,6 +2216,8 @@ int  generic_map_delete_batch(struct bpf_map *map=
,
> >  struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
> >  struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
> >
> > +int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,
>
> nit: you use more meaningful node_id in arena_alloc_pages(), here
> "nid" was a big mystery when looking at just function definition

nid is a standard name in mm/.
git grep -w nid mm/|wc -l
1064
git grep -w node_id mm/|wc -l
77

Also see slab_nid(), folio_nid().

> > +                       unsigned long nr_pages, struct page **page_arra=
y);
> >  #ifdef CONFIG_MEMCG_KMEM
> >  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp=
_t flags,
> >                            int node);
>
> [...]
>
> > +u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> > +{
> > +       return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2=
 : 0;
> > +}
> > +
> > +u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
> > +{
> > +       return arena ? arena->user_vm_start : 0;
> > +}
> > +
>
> is it anticipated that these helpers can be called with NULL? I might
> see this later in the patch set, but if not, these NULL checks would
> be best removed to not create wrong expectations.

Looks like you figured it out.

> > +static long arena_map_peek_elem(struct bpf_map *map, void *value)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static long arena_map_push_elem(struct bpf_map *map, void *value, u64 =
flags)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static long arena_map_pop_elem(struct bpf_map *map, void *value)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static long arena_map_delete_elem(struct bpf_map *map, void *value)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static int arena_map_get_next_key(struct bpf_map *map, void *key, void=
 *next_key)
> > +{
> > +       return -EOPNOTSUPP;
> > +}
> > +
>
> This is a separate topic, but I'll just mention it here. It was always
> confusing to me why we don't just treat all these callbacks as
> optional and return -EOPNOTSUPP in generic map code. Unless I miss
> something subtle, we should do a round of clean ups and remove dozens
> of unnecessary single line callbacks like these throughout the entire
> BPF kernel code.

yeah. could be a generic follow up. agree.

> > +static long compute_pgoff(struct bpf_arena *arena, long uaddr)
> > +{
> > +       return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
> > +}
> > +
>
> [...]
>
> > +static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
> > +{
> > +       struct bpf_map *map =3D vmf->vma->vm_file->private_data;
> > +       struct bpf_arena *arena =3D container_of(map, struct bpf_arena,=
 map);
> > +       struct page *page;
> > +       long kbase, kaddr;
> > +       int ret;
> > +
> > +       kbase =3D bpf_arena_get_kern_vm_start(arena);
> > +       kaddr =3D kbase + (u32)(vmf->address & PAGE_MASK);
> > +
> > +       guard(mutex)(&arena->lock);
> > +       page =3D vmalloc_to_page((void *)kaddr);
> > +       if (page)
> > +               /* already have a page vmap-ed */
> > +               goto out;
> > +
> > +       if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> > +               /* User space requested to segfault when page is not al=
located by bpf prog */
> > +               return VM_FAULT_SIGSEGV;
> > +
> > +       ret =3D mtree_insert(&arena->mt, vmf->pgoff, MT_ENTRY, GFP_KERN=
EL);
> > +       if (ret)
> > +               return VM_FAULT_SIGSEGV;
> > +
> > +       /* Account into memcg of the process that created bpf_arena */
> > +       ret =3D bpf_map_alloc_pages(map, GFP_KERNEL | __GFP_ZERO, NUMA_=
NO_NODE, 1, &page);
>
> any specific reason to not take into account map->numa_node here?

There are several reasons for this.
1. is to avoid expectations that map->num_node is meaningful
for actual run-time allocations.
Since arena_alloc_pages() take explicit nid and it would conflict
if map->numa_node was also used.
2. In this case it's user space faulting in a page,
so best to let NUMA_NO_NODE pick the right one.


> > +       if (ret) {
> > +               mtree_erase(&arena->mt, vmf->pgoff);
> > +               return VM_FAULT_SIGSEGV;
> > +       }
> > +
> > +       ret =3D vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_S=
IZE, &page);
> > +       if (ret) {
> > +               mtree_erase(&arena->mt, vmf->pgoff);
> > +               __free_page(page);
> > +               return VM_FAULT_SIGSEGV;
> > +       }
> > +out:
> > +       page_ref_add(page, 1);
> > +       vmf->page =3D page;
> > +       return 0;
> > +}
> > +
>
> [...]
>
> > +/*
> > + * Allocate pages and vmap them into kernel vmalloc area.
> > + * Later the pages will be mmaped into user space vma.
> > + */
> > +static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, lon=
g page_cnt, int node_id)
> > +{
> > +       /* user_vm_end/start are fixed before bpf prog runs */
> > +       long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_star=
t) >> PAGE_SHIFT;
> > +       u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> > +       struct page **pages;
> > +       long pgoff =3D 0;
> > +       u32 uaddr32;
> > +       int ret, i;
> > +
> > +       if (page_cnt > page_cnt_max)
> > +               return 0;
> > +
> > +       if (uaddr) {
> > +               if (uaddr & ~PAGE_MASK)
> > +                       return 0;
> > +               pgoff =3D compute_pgoff(arena, uaddr);
> > +               if (pgoff + page_cnt > page_cnt_max)
>
> As I mentioned offline, is this guaranteed to not overflow? it's not
> obvious because at least according to all the types (longs), uaddr can
> be arbitrary, so pgoff can be quite large, etc. Might be worthwhile
> rewriting as `pgoff > page_cnt_max - page_cnt` or something, just to
> make it clear in code it has no chance of overflowing.

It cannot overflow. All three variables:
page_cnt, pgoff, page_cnt_max are within u32 range.
Look at how they're computed.

> > +                       /* requested address will be outside of user VM=
A */
> > +                       return 0;
> > +       }
> > +
> > +       /* zeroing is needed, since alloc_pages_bulk_array() only fills=
 in non-zero entries */
> > +       pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL)=
;
> > +       if (!pages)
> > +               return 0;
> > +
> > +       guard(mutex)(&arena->lock);
> > +
> > +       if (uaddr)
> > +               ret =3D mtree_insert_range(&arena->mt, pgoff, pgoff + p=
age_cnt - 1,
> > +                                        MT_ENTRY, GFP_KERNEL);
> > +       else
> > +               ret =3D mtree_alloc_range(&arena->mt, &pgoff, MT_ENTRY,
> > +                                       page_cnt, 0, page_cnt_max - 1, =
GFP_KERNEL);
>
> mtree_alloc_range() is lacking documentation, unfortunately, so it's
> not clear to me whether max should be just `page_cnt_max - 1` as you
> have or `page_cnt_max - page_cnt`. There is a "Test a single entry" in
> lib/test_maple_tree.c where min =3D=3D max and size =3D=3D 4096 which is
> expected to work, so I have a feeling that the correct max should be
> up to the maximum possible beginning of range, but I might be
> mistaken. Can you please double check?

Not only I double checked this, the patch 12 selftest covers
this boundary condition :)

>
> > +       if (ret)
> > +               goto out_free_pages;
> > +
> > +       ret =3D bpf_map_alloc_pages(&arena->map, GFP_KERNEL | __GFP_ZER=
O,
> > +                                 node_id, page_cnt, pages);
> > +       if (ret)
> > +               goto out;
> > +
> > +       uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> > +       /* Earlier checks make sure that uaddr32 + page_cnt * PAGE_SIZE=
 will not overflow 32-bit */
>
> we checked that `uaddr32 + page_cnt * PAGE_SIZE - 1` won't overflow,
> full page_cnt * PAGE_SIZE can actually overflow, so comment is a bit
> imprecise. But it's not really clear why it matters here, tbh.
> kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE can actually update
> upper 32-bits of the kernel-side memory address, is that a problem?

There is a giant thread in v2 series between myself and Barrett
that goes into length why we decided to prohibit overflow within lower 32-b=
it.
The shortest tldr: technically we can allow lower 32-bit overflow,
but the code gets very complex.

>
> > +       ret =3D vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr=
32,
> > +                               kern_vm_start + uaddr32 + page_cnt * PA=
GE_SIZE, pages);
> > +       if (ret) {
> > +               for (i =3D 0; i < page_cnt; i++)
> > +                       __free_page(pages[i]);
> > +               goto out;
> > +       }
> > +       kvfree(pages);
> > +       return clear_lo32(arena->user_vm_start) + uaddr32;
> > +out:
> > +       mtree_erase(&arena->mt, pgoff);
> > +out_free_pages:
> > +       kvfree(pages);
> > +       return 0;
> > +}
> > +
> > +/*
> > + * If page is present in vmalloc area, unmap it from vmalloc area,
> > + * unmap it from all user space vma-s,
> > + * and free it.
> > + */
> > +static void zap_pages(struct bpf_arena *arena, long uaddr, long page_c=
nt)
> > +{
> > +       struct vma_list *vml;
> > +
> > +       list_for_each_entry(vml, &arena->vma_list, head)
> > +               zap_page_range_single(vml->vma, uaddr,
> > +                                     PAGE_SIZE * page_cnt, NULL);
> > +}
> > +
> > +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long=
 page_cnt)
> > +{
> > +       u64 full_uaddr, uaddr_end;
> > +       long kaddr, pgoff, i;
> > +       struct page *page;
> > +
> > +       /* only aligned lower 32-bit are relevant */
> > +       uaddr =3D (u32)uaddr;
> > +       uaddr &=3D PAGE_MASK;
> > +       full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
> > +       uaddr_end =3D min(arena->user_vm_end, full_uaddr + (page_cnt <<=
 PAGE_SHIFT));
> > +       if (full_uaddr >=3D uaddr_end)
> > +               return;
> > +
> > +       page_cnt =3D (uaddr_end - full_uaddr) >> PAGE_SHIFT;
> > +
> > +       guard(mutex)(&arena->lock);
> > +
> > +       pgoff =3D compute_pgoff(arena, uaddr);
> > +       /* clear range */
> > +       mtree_store_range(&arena->mt, pgoff, pgoff + page_cnt - 1, NULL=
, GFP_KERNEL);
> > +
> > +       if (page_cnt > 1)
> > +               /* bulk zap if multiple pages being freed */
> > +               zap_pages(arena, full_uaddr, page_cnt);
> > +
> > +       kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
> > +       for (i =3D 0; i < page_cnt; i++, kaddr +=3D PAGE_SIZE, full_uad=
dr +=3D PAGE_SIZE) {
> > +               page =3D vmalloc_to_page((void *)kaddr);
> > +               if (!page)
> > +                       continue;
> > +               if (page_cnt =3D=3D 1 && page_mapped(page)) /* mapped b=
y some user process */
> > +                       zap_pages(arena, full_uaddr, 1);
>
> The way you split these zap_pages for page_cnt =3D=3D 1 and page_cnt > 1
> is quite confusing. Why can't you just unconditionally zap_pages()
> regardless of page_cnt before this loop? And why for page_cnt =3D=3D 1 we
> have `page_mapped(page)` check, but it's ok to not check this for
> page_cnt>1 case?
>
> This asymmetric handling is confusing and suggests something more is
> going on here. Or am I overthinking it?

It's an important optimization for the common case of page_cnt=3D=3D1.
If page wasn't mapped into some user vma there is no need to call zap_pages
which is slow.
But when page_cnt is big it's much faster to do the batched zap
which is what this code does.
For the case of page_cnt=3D2 or small number there is no good optimization
to do other than try to count whether all pages in this range are
not page_mapped() and omit zap_page().
I don't think it's worth doing such optimization at this point,
since page_cnt=3D1 is likely the most common case.
If it changes, it can be optimized later.

> > +               vm_area_unmap_pages(arena->kern_vm, kaddr, kaddr + PAGE=
_SIZE);
> > +               __free_page(page);
>
> can something else in the kernel somehow get a refcnt on this page?
> I.e., is it ok to unconditionally free page here instead of some sort
> of put_page() instead?

hmm. __free_page() does the refcnt. It's not an unconditional free.
put_page() is for the case when folio is present. Here all of them
are privately managed pages. All are single page individual allocations
and a normal refcnt scheme applies. Which is what __free_page() does.

Thanks for the review.
I believe I answered all the questions. Looks like the only
followup is to generalize all 'return -EOPNOTSUPP'
across all map types. I'll add it to my todo. Unless somebody
will have more free cycles.
