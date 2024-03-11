Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3356B63
	for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194499; cv=none; b=Dh8499femJxMdnZkNr8lzSGHmBjdBWtIgRSyowWkW0tjRT3qcQ33Q8EWXvlc+O4zGI2sxHF3cY84nUV2AJYAOCnVBMDyZ5c5nGs4oFRvbU2ft6mn6oPLPRbYxxRGRG/1To032AR/wayHYBwCDKO8apDr7Ws00zV88BaOiCDCvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194499; c=relaxed/simple;
	bh=c2rncGIx3It5uSjR1rNCs+gpravEstIuZTQCk73Znvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9yT7bDhkNH4qk7YyJKT0Aeg6P+2AXkx8XpBjqQ/Pnqt2Wq7RB1Y27Zw8rKFz2ZLKPkc3hK2nKX6jF5aK8BtiNqvdp6UdTZPUI8aNfMMVQcNEpf6nc3B4SqicFrPM9SjM2YjGHnXuzdMacdVvUnAUCbiU5U/icu5GmuJI1Eq2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amWXzuGr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amWXzuGr"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29bc1c64a98so1904682a91.1
        for <bpf@vger.kernel.org>; Mon, 11 Mar 2024 15:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710194496; x=1710799296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oetuATnmI6T7xE+z6eeBRaCJ+kkjrCNvBDkUC6LtDrE=;
        b=amWXzuGrxrypEE7PbNorPcZcJMkW75HlZtFXbae7tA37aFZb389/j3vS9IDsV4gCVA
         cZlrrPbsLoghcSgurizZL+5PXYDiHySwVJdqqJlYUwypiJAF+r/GiWSwP6177/UNrltQ
         A0DNa4DAplBNrYH+NQDctUDL1udHbf3AJGiE9F4E1h1MWjdfcqUGy4IwE72c/hcT3rz8
         jC5z6hzYVKmKiMJ7No28/rFueMBEffZ1sPrdolWgGtpnfyIjcTl2RycGdGxG3jH2u/zi
         4XE9kgqS8hhF4Z/TbndbaRtlJO0nuOxSGnASmUPdbPyQVVflBB3eHd3BqAZZ5Lr5Sy9R
         i1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710194496; x=1710799296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oetuATnmI6T7xE+z6eeBRaCJ+kkjrCNvBDkUC6LtDrE=;
        b=PUSU3MIJzwunydPGK4AhNrGVrn+XuuXY4FBjoC2bZHU0AcU/pJ9b4nE/KyF9O3QcEz
         z1TFqp5cxUrZj8nnxB2hrUgIbDJK12RmqUfSYsAWJQCCXqGqXTl2w6CGmjGeZ+wQkjYR
         1BMewidOpDAbVi5lecRkw5eJ5nM/VB3c7rhCRQn+6VkO0sEDWZBc053sPGIESV13BJzS
         yirdfocPoTt+jZ8jT3t8AE3qH0FbRqUDvh3LnXdydCDqPyVdOIST3em5NjVJ4gbLtoEu
         O5GzZLO0wqBzDq7uyOfnoYYXsElPnx6nLGrMNK4+8uh+zfT30A82YwMw5D5G6TdO7eAO
         LebA==
X-Gm-Message-State: AOJu0Yzcz3dKT8DjCTf0Rw7k5+3g0V792BiIsJC1tpj4vHBhTHMV4wBf
	77lKOnll1oNqVLi3Uc2GfDqdQs/y6DC4HVP5BL6HOHTNTCFzJEJdECX2SeoN0d4PKF46qU4O2ev
	aU/D/cRqK4acgoV9pdD6TzpauvuA=
X-Google-Smtp-Source: AGHT+IFhV6Hop4eTCQ9/re/sWMVZkZ+/8qPACjvwRsXKU28oUqFpc1EGBD/mNd7ZBWV3B+f/TNOY6yBj6X8J2WsB9Bo=
X-Received: by 2002:a17:90a:43a7:b0:29b:af87:1e82 with SMTP id
 r36-20020a17090a43a700b0029baf871e82mr5497766pjg.48.1710194496183; Mon, 11
 Mar 2024 15:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308010812.89848-1-alexei.starovoitov@gmail.com> <20240308010812.89848-2-alexei.starovoitov@gmail.com>
In-Reply-To: <20240308010812.89848-2-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Mar 2024 15:01:23 -0700
Message-ID: <CAEf4BzZr_Ki7VnEO6Gi-w07vX9p-oaqaGZQq62VTD_fJm39K4A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/14] bpf: Introduce bpf_arena.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:08=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Introduce bpf_arena, which is a sparse shared memory region between the b=
pf
> program and user space.
>
> Use cases:
> 1. User space mmap-s bpf_arena and uses it as a traditional mmap-ed
>    anonymous region, like memcached or any key/value storage. The bpf
>    program implements an in-kernel accelerator. XDP prog can search for
>    a key in bpf_arena and return a value without going to user space.
> 2. The bpf program builds arbitrary data structures in bpf_arena (hash
>    tables, rb-trees, sparse arrays), while user space consumes it.
> 3. bpf_arena is a "heap" of memory from the bpf program's point of view.
>    The user space may mmap it, but bpf program will not convert pointers
>    to user base at run-time to improve bpf program speed.
>
> Initially, the kernel vm_area and user vma are not populated. User space
> can fault in pages within the range. While servicing a page fault,
> bpf_arena logic will insert a new page into the kernel and user vmas. The
> bpf program can allocate pages from that region via
> bpf_arena_alloc_pages(). This kernel function will insert pages into the
> kernel vm_area. The subsequent fault-in from user space will populate tha=
t
> page into the user vma. The BPF_F_SEGV_ON_FAULT flag at arena creation ti=
me
> can be used to prevent fault-in from user space. In such a case, if a pag=
e
> is not allocated by the bpf program and not present in the kernel vm_area=
,
> the user process will segfault. This is useful for use cases 2 and 3 abov=
e.
>
> bpf_arena_alloc_pages() is similar to user space mmap(). It allocates pag=
es
> either at a specific address within the arena or allocates a range with t=
he
> maple tree. bpf_arena_free_pages() is analogous to munmap(), which frees
> pages and removes the range from the kernel vm_area and from user process
> vmas.
>
> bpf_arena can be used as a bpf program "heap" of up to 4GB. The speed of
> bpf program is more important than ease of sharing with user space. This =
is
> use case 3. In such a case, the BPF_F_NO_USER_CONV flag is recommended.
> It will tell the verifier to treat the rX =3D bpf_arena_cast_user(rY)
> instruction as a 32-bit move wX =3D wY, which will improve bpf prog
> performance. Otherwise, bpf_arena_cast_user is translated by JIT to
> conditionally add the upper 32 bits of user vm_start (if the pointer is n=
ot
> NULL) to arena pointers before they are stored into memory. This way, use=
r
> space sees them as valid 64-bit pointers.
>
> Diff https://github.com/llvm/llvm-project/pull/84410 enables LLVM BPF
> backend generate the bpf_addr_space_cast() instruction to cast pointers
> between address_space(1) which is reserved for bpf_arena pointers and
> default address space zero. All arena pointers in a bpf program written i=
n
> C language are tagged as __attribute__((address_space(1))). Hence, clang
> provides helpful diagnostics when pointers cross address space. Libbpf an=
d
> the kernel support only address_space =3D=3D 1. All other address space
> identifiers are reserved.
>
> rX =3D bpf_addr_space_cast(rY, /* dst_as */ 1, /* src_as */ 0) tells the
> verifier that rX->type =3D PTR_TO_ARENA. Any further operations on
> PTR_TO_ARENA register have to be in the 32-bit domain. The verifier will
> mark load/store through PTR_TO_ARENA with PROBE_MEM32. JIT will generate
> them as kern_vm_start + 32bit_addr memory accesses. The behavior is simil=
ar
> to copy_from_kernel_nofault() except that no address checks are necessary=
.
> The address is guaranteed to be in the 4GB range. If the page is not
> present, the destination register is zeroed on read, and the operation is
> ignored on write.
>
> rX =3D bpf_addr_space_cast(rY, 0, 1) tells the verifier that rX->type =3D
> unknown scalar. If arena->map_flags has BPF_F_NO_USER_CONV set, then the
> verifier converts such cast instructions to mov32. Otherwise, JIT will em=
it
> native code equivalent to:
> rX =3D (u32)rY;
> if (rY)
>   rX |=3D clear_lo32_bits(arena->user_vm_start); /* replace hi32 bits in =
rX */
>
> After such conversion, the pointer becomes a valid user pointer within
> bpf_arena range. The user process can access data structures created in
> bpf_arena without any additional computations. For example, a linked list
> built by a bpf program can be walked natively by user space.
>
> Reviewed-by: Barret Rhoden <brho@google.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf.h            |   7 +-
>  include/linux/bpf_types.h      |   1 +
>  include/uapi/linux/bpf.h       |  10 +
>  kernel/bpf/Makefile            |   3 +
>  kernel/bpf/arena.c             | 558 +++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c              |  11 +
>  kernel/bpf/syscall.c           |  36 +++
>  kernel/bpf/verifier.c          |   1 +
>  tools/include/uapi/linux/bpf.h |  10 +
>  9 files changed, 635 insertions(+), 2 deletions(-)
>  create mode 100644 kernel/bpf/arena.c
>

[...]

>
>  struct bpf_offload_dev;
> @@ -2215,6 +2216,8 @@ int  generic_map_delete_batch(struct bpf_map *map,
>  struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
>  struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
>
> +int bpf_map_alloc_pages(const struct bpf_map *map, gfp_t gfp, int nid,

nit: you use more meaningful node_id in arena_alloc_pages(), here
"nid" was a big mystery when looking at just function definition

> +                       unsigned long nr_pages, struct page **page_array)=
;
>  #ifdef CONFIG_MEMCG_KMEM
>  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t=
 flags,
>                            int node);

[...]

> +u64 bpf_arena_get_kern_vm_start(struct bpf_arena *arena)
> +{
> +       return arena ? (u64) (long) arena->kern_vm->addr + GUARD_SZ / 2 :=
 0;
> +}
> +
> +u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
> +{
> +       return arena ? arena->user_vm_start : 0;
> +}
> +

is it anticipated that these helpers can be called with NULL? I might
see this later in the patch set, but if not, these NULL checks would
be best removed to not create wrong expectations.

> +static long arena_map_peek_elem(struct bpf_map *map, void *value)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static long arena_map_push_elem(struct bpf_map *map, void *value, u64 fl=
ags)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static long arena_map_pop_elem(struct bpf_map *map, void *value)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static long arena_map_delete_elem(struct bpf_map *map, void *value)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static int arena_map_get_next_key(struct bpf_map *map, void *key, void *=
next_key)
> +{
> +       return -EOPNOTSUPP;
> +}
> +

This is a separate topic, but I'll just mention it here. It was always
confusing to me why we don't just treat all these callbacks as
optional and return -EOPNOTSUPP in generic map code. Unless I miss
something subtle, we should do a round of clean ups and remove dozens
of unnecessary single line callbacks like these throughout the entire
BPF kernel code.

> +static long compute_pgoff(struct bpf_arena *arena, long uaddr)
> +{
> +       return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
> +}
> +

[...]

> +static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
> +{
> +       struct bpf_map *map =3D vmf->vma->vm_file->private_data;
> +       struct bpf_arena *arena =3D container_of(map, struct bpf_arena, m=
ap);
> +       struct page *page;
> +       long kbase, kaddr;
> +       int ret;
> +
> +       kbase =3D bpf_arena_get_kern_vm_start(arena);
> +       kaddr =3D kbase + (u32)(vmf->address & PAGE_MASK);
> +
> +       guard(mutex)(&arena->lock);
> +       page =3D vmalloc_to_page((void *)kaddr);
> +       if (page)
> +               /* already have a page vmap-ed */
> +               goto out;
> +
> +       if (arena->map.map_flags & BPF_F_SEGV_ON_FAULT)
> +               /* User space requested to segfault when page is not allo=
cated by bpf prog */
> +               return VM_FAULT_SIGSEGV;
> +
> +       ret =3D mtree_insert(&arena->mt, vmf->pgoff, MT_ENTRY, GFP_KERNEL=
);
> +       if (ret)
> +               return VM_FAULT_SIGSEGV;
> +
> +       /* Account into memcg of the process that created bpf_arena */
> +       ret =3D bpf_map_alloc_pages(map, GFP_KERNEL | __GFP_ZERO, NUMA_NO=
_NODE, 1, &page);

any specific reason to not take into account map->numa_node here?

> +       if (ret) {
> +               mtree_erase(&arena->mt, vmf->pgoff);
> +               return VM_FAULT_SIGSEGV;
> +       }
> +
> +       ret =3D vm_area_map_pages(arena->kern_vm, kaddr, kaddr + PAGE_SIZ=
E, &page);
> +       if (ret) {
> +               mtree_erase(&arena->mt, vmf->pgoff);
> +               __free_page(page);
> +               return VM_FAULT_SIGSEGV;
> +       }
> +out:
> +       page_ref_add(page, 1);
> +       vmf->page =3D page;
> +       return 0;
> +}
> +

[...]

> +/*
> + * Allocate pages and vmap them into kernel vmalloc area.
> + * Later the pages will be mmaped into user space vma.
> + */
> +static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long =
page_cnt, int node_id)
> +{
> +       /* user_vm_end/start are fixed before bpf prog runs */
> +       long page_cnt_max =3D (arena->user_vm_end - arena->user_vm_start)=
 >> PAGE_SHIFT;
> +       u64 kern_vm_start =3D bpf_arena_get_kern_vm_start(arena);
> +       struct page **pages;
> +       long pgoff =3D 0;
> +       u32 uaddr32;
> +       int ret, i;
> +
> +       if (page_cnt > page_cnt_max)
> +               return 0;
> +
> +       if (uaddr) {
> +               if (uaddr & ~PAGE_MASK)
> +                       return 0;
> +               pgoff =3D compute_pgoff(arena, uaddr);
> +               if (pgoff + page_cnt > page_cnt_max)

As I mentioned offline, is this guaranteed to not overflow? it's not
obvious because at least according to all the types (longs), uaddr can
be arbitrary, so pgoff can be quite large, etc. Might be worthwhile
rewriting as `pgoff > page_cnt_max - page_cnt` or something, just to
make it clear in code it has no chance of overflowing.

> +                       /* requested address will be outside of user VMA =
*/
> +                       return 0;
> +       }
> +
> +       /* zeroing is needed, since alloc_pages_bulk_array() only fills i=
n non-zero entries */
> +       pages =3D kvcalloc(page_cnt, sizeof(struct page *), GFP_KERNEL);
> +       if (!pages)
> +               return 0;
> +
> +       guard(mutex)(&arena->lock);
> +
> +       if (uaddr)
> +               ret =3D mtree_insert_range(&arena->mt, pgoff, pgoff + pag=
e_cnt - 1,
> +                                        MT_ENTRY, GFP_KERNEL);
> +       else
> +               ret =3D mtree_alloc_range(&arena->mt, &pgoff, MT_ENTRY,
> +                                       page_cnt, 0, page_cnt_max - 1, GF=
P_KERNEL);

mtree_alloc_range() is lacking documentation, unfortunately, so it's
not clear to me whether max should be just `page_cnt_max - 1` as you
have or `page_cnt_max - page_cnt`. There is a "Test a single entry" in
lib/test_maple_tree.c where min =3D=3D max and size =3D=3D 4096 which is
expected to work, so I have a feeling that the correct max should be
up to the maximum possible beginning of range, but I might be
mistaken. Can you please double check?

> +       if (ret)
> +               goto out_free_pages;
> +
> +       ret =3D bpf_map_alloc_pages(&arena->map, GFP_KERNEL | __GFP_ZERO,
> +                                 node_id, page_cnt, pages);
> +       if (ret)
> +               goto out;
> +
> +       uaddr32 =3D (u32)(arena->user_vm_start + pgoff * PAGE_SIZE);
> +       /* Earlier checks make sure that uaddr32 + page_cnt * PAGE_SIZE w=
ill not overflow 32-bit */

we checked that `uaddr32 + page_cnt * PAGE_SIZE - 1` won't overflow,
full page_cnt * PAGE_SIZE can actually overflow, so comment is a bit
imprecise. But it's not really clear why it matters here, tbh.
kern_vm_start + uaddr32 + page_cnt * PAGE_SIZE can actually update
upper 32-bits of the kernel-side memory address, is that a problem?

> +       ret =3D vm_area_map_pages(arena->kern_vm, kern_vm_start + uaddr32=
,
> +                               kern_vm_start + uaddr32 + page_cnt * PAGE=
_SIZE, pages);
> +       if (ret) {
> +               for (i =3D 0; i < page_cnt; i++)
> +                       __free_page(pages[i]);
> +               goto out;
> +       }
> +       kvfree(pages);
> +       return clear_lo32(arena->user_vm_start) + uaddr32;
> +out:
> +       mtree_erase(&arena->mt, pgoff);
> +out_free_pages:
> +       kvfree(pages);
> +       return 0;
> +}
> +
> +/*
> + * If page is present in vmalloc area, unmap it from vmalloc area,
> + * unmap it from all user space vma-s,
> + * and free it.
> + */
> +static void zap_pages(struct bpf_arena *arena, long uaddr, long page_cnt=
)
> +{
> +       struct vma_list *vml;
> +
> +       list_for_each_entry(vml, &arena->vma_list, head)
> +               zap_page_range_single(vml->vma, uaddr,
> +                                     PAGE_SIZE * page_cnt, NULL);
> +}
> +
> +static void arena_free_pages(struct bpf_arena *arena, long uaddr, long p=
age_cnt)
> +{
> +       u64 full_uaddr, uaddr_end;
> +       long kaddr, pgoff, i;
> +       struct page *page;
> +
> +       /* only aligned lower 32-bit are relevant */
> +       uaddr =3D (u32)uaddr;
> +       uaddr &=3D PAGE_MASK;
> +       full_uaddr =3D clear_lo32(arena->user_vm_start) + uaddr;
> +       uaddr_end =3D min(arena->user_vm_end, full_uaddr + (page_cnt << P=
AGE_SHIFT));
> +       if (full_uaddr >=3D uaddr_end)
> +               return;
> +
> +       page_cnt =3D (uaddr_end - full_uaddr) >> PAGE_SHIFT;
> +
> +       guard(mutex)(&arena->lock);
> +
> +       pgoff =3D compute_pgoff(arena, uaddr);
> +       /* clear range */
> +       mtree_store_range(&arena->mt, pgoff, pgoff + page_cnt - 1, NULL, =
GFP_KERNEL);
> +
> +       if (page_cnt > 1)
> +               /* bulk zap if multiple pages being freed */
> +               zap_pages(arena, full_uaddr, page_cnt);
> +
> +       kaddr =3D bpf_arena_get_kern_vm_start(arena) + uaddr;
> +       for (i =3D 0; i < page_cnt; i++, kaddr +=3D PAGE_SIZE, full_uaddr=
 +=3D PAGE_SIZE) {
> +               page =3D vmalloc_to_page((void *)kaddr);
> +               if (!page)
> +                       continue;
> +               if (page_cnt =3D=3D 1 && page_mapped(page)) /* mapped by =
some user process */
> +                       zap_pages(arena, full_uaddr, 1);

The way you split these zap_pages for page_cnt =3D=3D 1 and page_cnt > 1
is quite confusing. Why can't you just unconditionally zap_pages()
regardless of page_cnt before this loop? And why for page_cnt =3D=3D 1 we
have `page_mapped(page)` check, but it's ok to not check this for
page_cnt>1 case?

This asymmetric handling is confusing and suggests something more is
going on here. Or am I overthinking it?

> +               vm_area_unmap_pages(arena->kern_vm, kaddr, kaddr + PAGE_S=
IZE);
> +               __free_page(page);

can something else in the kernel somehow get a refcnt on this page?
I.e., is it ok to unconditionally free page here instead of some sort
of put_page() instead?

> +       }
> +}
> +
> +__bpf_kfunc_start_defs();
> +

[...]
