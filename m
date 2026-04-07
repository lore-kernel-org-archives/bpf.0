Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8135F179
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775581688; cv=pass; b=dzyERTujqACq+Mv2Pb+H02jc7FZ3LYwx6Iglq98R3PHPLfBUv/Gs05AGsViiElKfIZYPEMeQjipN4LC9cYpZpWzDlqdInHQsmsmvPCn1EfrEA+e+JWLPw81JY3UIdaA9KeWPU7LsxWaaLDR4Z42/ZYkspjuhASrUPpq5iHSQamg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775581688; c=relaxed/simple;
	bh=ajr3fPitS3uz+NR+rqnPdj+x1g/aWEQn0wJhJvgzv2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQj23+0CsnRgfASCyyDg+rKiTIWGYKy+80/QbqyYJgD4OHPBXRVQdOBdm5znBLmuQcsoptsP8ixgFM0cN6gKw8hhu+qF6eqip3Zto92axSwy5NNAABrigIboVf2Dyf7l5Zuouy/iAD/HARmmz8lXCDA80AhxZvdah065GvdiFOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAPILtPv; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAPILtPv"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so4641196f8f.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 10:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775581684; cv=none;
        d=google.com; s=arc-20240605;
        b=CN59bGrf4CMJZpJBG4eL9Rt0bM8G1PxHlSB36A0FCI34w0YmuZp/h3Tr5nxVDDqAZs
         zUtkz1F+EJslTuEyVkUzmX/lc96ziz+TzwqUS5tXgOHCu8QOYtqx9pWL8qz6jv7XENut
         QzawSzgxURP4R161lr9wY86R/XN/0IYAQ2Kb2ZHQTTlVq+PgeyMHMGwei9ikeFjeG8HT
         7RFgDXrwQMY3PUwXmuCJDePIPoWcFQww39Hqou+4F9gTCThHXvSm1gJcbqOkK2+vNppZ
         QWKu+yHj6PxIdSbNgXcdOJXKw193TK6QdnCDz2YdHuW+F09GYPutJbSu0+3zoCjRJ5yL
         VA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FiEyCjOsWYiG+bjIr6LG9SmQjf70EF6n4sEcVwHX2+E=;
        fh=hfRje2veXRgnK/5UbF368BTRuTdPC/oA5JvW+CkXkIA=;
        b=HhSxdbqUBPC9h7B5nzmeJJC4oqAVIbMrBsfM/xcCGElOI5Co4jruWo+Aw8nM/Zplz5
         Hghe+uK/RvMG+R1LvyWZ+PXbtLQWOGHqYz575PdSrT+7VjhpvkB4X0uts6hdRBHEv0ki
         vOGN/VxsxMtsRqgJLH5bcMM/8Zk2e01+s/EfbNKZUVYR5vDyc3F7yTKNGETkML8WNExy
         99pF6HHGf2pnkRkN2jEZho6ZUN4/neW0hzt+AqoGbOTf5qDCkZHQudV/VkdkpfwFsuY3
         7ss9/i9Y1okbrFTngn4XkEMz3cwUQNvrNX7MKlcCIdxKuox07qRbsv5arj5jUgPuV0qZ
         3ztA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775581684; x=1776186484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiEyCjOsWYiG+bjIr6LG9SmQjf70EF6n4sEcVwHX2+E=;
        b=TAPILtPvRoifynPBlUBYytiFd6ozsQ2abRtmDTTXcVamm3dxsnw1im+DXwkvjwKm+1
         89Pt2/8XOTRCZITVHoB6VHKyMe33xA8v1IcrjI2kMsLv5zOKQl6NdglAaBrRvsUTpcix
         oBTHhsme5/Kxt5FjrKvssUQJf7kWgiflAHqU+q3bcDfmRG6N5p1neb0ilkr+0SLkDCHj
         ++I9xteBPC050EIQDBx0ampN7nE1I3fo3VVmHCQlBfNx6TxoDoRCJWGNLVIgvdPr78Zj
         J+lLHi0D+wW0S4tElpx0c4D0sdeE5QhrAq8InTHZiI5CwqPvUlz14jEYMgelCmKq9KVk
         gEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775581684; x=1776186484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FiEyCjOsWYiG+bjIr6LG9SmQjf70EF6n4sEcVwHX2+E=;
        b=jkscTn5k2AljLC6dBgPW8iljgDS8LkpE6UFg27sIQJsOul8lP6Y7u2M3keXqwdBz66
         t6JEySLjV9hoep8nwwiKRJnWUbXBOa6NIVjOW+wfwAJa96+in8YUO4wiBPQ+BjKFpr0R
         o+B4iZJ3PSoEGW15s4tPlySr8Ea/3YsKtkHgX97gTht4LrsZeURoUEb3p5dtVweA+VzP
         7J11LivVa+DGGFaH7PpPrS4XJddSp5f761tID/nuDqAK83viwLlftWxVvP15wbX9ZZfk
         Ib33ySIaxODiJayJhIbo99w3i65AGW6BG4lsMbPa7hFLdNOKM3+rXeZMHUM8jbsgMduw
         QT6Q==
X-Gm-Message-State: AOJu0YzJE26slldUUHUWzfZE351UPcC1Ber4T9C0bBbJNAsbP7UjPvgw
	NL5pFyGJtxXQywtdFR/EJiIZ7PX/jvCXPDbe+dIZ6NMxnf9c4Ucn56sGqQ3OztKy9ehvGxGAmnl
	4wWZTFEKluMXVsC7IL6G5boq04kRtjbA=
X-Gm-Gg: AeBDiescYkD4IcZfjp8ZnaMpZv7OVFU7X1mZFDBN7wHMQrcuo3KaRdcgMBJjbdMq9Bn
	LG7mti/mBE5uFzPZd+mPLcgnclpD1fVH+nQKktmYGqTVdIqK3hG1qr3Lbw7ZXYEnLOA35UiPS+S
	s4SXVGd5GRPgxKHj+zEdumqirU1CCr/EzGk+udy7W3gwyeQzbg2jlIDQf1erqZjpnyizfKQaLbT
	0Ux3w9yvHA3OhVwdkDRzra6L0ajIpvc8TZwVeSbtCCxJAiyiyBrCVGReQJUvWH5EELZ9IkFpGL5
	GcKfjr0jkVhI8YD2Ln29iwRm1f1g4HroF7vsvCe8ep7y35EdGzaYGK9ury3zoU6zUfv+rOPjlLQ
	yDOK0YtxCzx2UZgwzLKVyvoDkUA==
X-Received: by 2002:a05:6000:25c8:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-43d29267feemr26987439f8f.7.1775581683493; Tue, 07 Apr 2026
 10:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407045730.13359-1-emil@etsalapatis.com> <20260407045730.13359-9-emil@etsalapatis.com>
In-Reply-To: <20260407045730.13359-9-emil@etsalapatis.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 Apr 2026 10:07:52 -0700
X-Gm-Features: AQROBzD2xD71-jaIb11QCWYBCopmsmz_B_XRK2E5mnXLGixOQln0-qPc21-lM9E
Message-ID: <CAADnVQKnHXg0YnuLvzfXjszMaqugpMNWD5=ipffWS4GVNg6rFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 8/9] selftests/bpf: Add buddy allocator for libarena
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:57=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> Add a byte-oriented buddy allocator for libarena. The buddy
> allocator provides an alloc/free interface for small arena
> allocations (down to 16 bytes).

what happens to allocation request of < 16 bytes?
and what is the max ?

> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../selftests/bpf/libarena/include/buddy.h    |  64 ++
>  .../selftests/bpf/libarena/src/buddy.bpf.c    | 879 ++++++++++++++++++
>  2 files changed, 943 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
>  create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
>
> diff --git a/tools/testing/selftests/bpf/libarena/include/buddy.h b/tools=
/testing/selftests/bpf/libarena/include/buddy.h
> new file mode 100644
> index 000000000000..aa63752bc657
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/include/buddy.h
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#pragma once
> +
> +/* Buddy allocator-related structs. */

not a useful comment.

> +
> +struct buddy_chunk;
> +typedef struct buddy_chunk __arena buddy_chunk_t;
> +
> +struct buddy_header;
> +typedef struct buddy_header __arena buddy_header_t;
> +
> +enum buddy_consts {
> +       BUDDY_MIN_ALLOC_SHIFT   =3D 4,
> +       BUDDY_MIN_ALLOC_BYTES   =3D 1 << BUDDY_MIN_ALLOC_SHIFT,
> +       BUDDY_CHUNK_NUM_ORDERS  =3D 1 << 4,       /* 4 bits per order */

this 4 is the same as BUDDY_MIN_ALLOC_SHIFT or can be different?

> +       BUDDY_CHUNK_BYTES       =3D BUDDY_MIN_ALLOC_BYTES << BUDDY_CHUNK_=
NUM_ORDERS,
> +       BUDDY_HEADER_OFF        =3D 8, /* header byte offset, see buddy.b=
pf.c for details */

sizeof(struct buddy_header) instead?

> +       BUDDY_CHUNK_PAGES       =3D BUDDY_CHUNK_BYTES / __PAGE_SIZE,
> +       BUDDY_CHUNK_ITEMS       =3D 1 << BUDDY_CHUNK_NUM_ORDERS,
> +       BUDDY_CHUNK_OFFSET_MASK =3D BUDDY_CHUNK_BYTES - 1,
> +       BUDDY_VADDR_OFFSET      =3D BUDDY_CHUNK_BYTES,    /* Start aligni=
ng at chunk */
> +       BUDDY_VADDR_SIZE        =3D BUDDY_CHUNK_BYTES << 10 /* 1024 chunk=
s maximum */

I tried to make sense of these constants in isolation and got
completely lost.

> +};
> +
> +struct buddy_header {
> +       u32 prev_index; /* "Pointer" to the previous available allocation=
 of the same size. */
> +       u32 next_index; /* Same for the next allocation. */
> +};
> +
> +/*
> + * We bring memory into the allocator 1MiB at a time.
> + */
> +struct buddy_chunk {
> +       /* The order of the current allocation for a item. 4 bits per ord=
er. */
> +       u8              orders[BUDDY_CHUNK_ITEMS / 2];
> +       /*
> +        * Bit to denote whether chunk is allocated. Size of the allocate=
d/free
> +        * chunk found from the orders array.
> +        */
> +       u8              allocated[BUDDY_CHUNK_ITEMS / 8];
> +       /* Freelists for O(1) allocation. */
> +       u64             freelists[BUDDY_CHUNK_NUM_ORDERS];
> +       buddy_chunk_t   *prev;
> +       buddy_chunk_t   *next;
> +};
> +
> +struct buddy {
> +       buddy_chunk_t *first_chunk;             /* Pointer to the chunk l=
inked list. */
> +       arena_spinlock_t __arena *lock;         /* Allocator lock */
> +       u64 vaddr;                              /* Allocation into reserv=
ed vaddr */
> +};

ohh. so the main 'buddy' object is not inside arena and
that's why you need a pointer to a lock instead of directly
embedding the lock in struct buddy?
Can it move to global arena data instead?

> +
> +#ifdef __BPF__
> +
> +int buddy_init(struct buddy *buddy, arena_spinlock_t __arena *lock);
> +int buddy_destroy(struct buddy *buddy);
> +int buddy_free_internal(struct buddy *buddy, u64 free);
> +#define buddy_free(buddy, ptr) do { buddy_free_internal((buddy), (u64)(p=
tr)); } while (0)
> +u64 buddy_alloc_internal(struct buddy *buddy, size_t size);
> +#define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((=
alloc), (size)))
> +
> +
> +#endif /* __BPF__  */
> diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools=
/testing/selftests/bpf/libarena/src/buddy.bpf.c
> new file mode 100644
> index 000000000000..4343e39760ab
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
> @@ -0,0 +1,879 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <common.h>
> +#include <asan.h>
> +#include <buddy.h>
> +
> +/*
> + * Buddy allocator arena-based implementation.
> + *
> + * Memory is organized into chunks. These chunks
> + * cannot be coalesced or split. Allocating
> + * chunks allocates their memory eagerly.
> + *
> + * Internally, each chunk is organized into blocks.
> + * Blocks _can_ be coalesced/split, but only inside
> + * the chunk. Each block can be allocated or
> + * unallocated. If allocated, the entire block holds
> + * user data. If unallocated, the block is mostly
> + * invalid memory, with the exception of a header
> + * used for freelist tracking.
> + *
> + * The header is placed at an offset inside the block
> + * to prevent off-by-one errors from the previous block
> + * from trivially overwriting the header. Such an error
> + * is also not catchable by ASAN, since the header remains
> + * valid memory even after the block is freed. It is still
> + * theoretically possible for the header to be corrupted
> + * without being caught by ASAN, but harder.
> + *
> + * Since the allocator needs to track order information for
> + * both allocated and free blocks, and allocated blocks cannot
> + * store a header, the allocator also stores per-chunk order
> + * information in a reserved region at the beginning of the
> + * chunk. The header includes a bitmap with the order of blocks
> + * and their allocation state. It also includes the freelist
> + * heads for the allocation itself.
> + */
> +
> +
> +enum {
> +       BUDDY_POISONED =3D (s8)0xef,
> +};
> +
> +static inline int buddy_lock(struct buddy *buddy)
> +{
> +       return arena_spin_lock(buddy->lock);
> +}
> +
> +static inline void buddy_unlock(struct buddy *buddy)
> +{
> +       arena_spin_unlock(buddy->lock);
> +}
> +
> +/*
> + * Reserve part of the arena address space for the allocator. We use
> + * this to get aligned addresses for the chunks, since the arena
> + * page alloc kfuncs do not support alignment.

what kind of alignment is needed? Like align to 1Mbyte or something?

> + */
> +static int buddy_reserve_arena_vaddr(struct buddy *buddy)
> +{
> +       buddy->vaddr =3D 0;
> +
> +       return bpf_arena_reserve_pages(&arena,
> +                                      (void __arena *)BUDDY_VADDR_OFFSET=
,
> +                                      BUDDY_VADDR_SIZE / __PAGE_SIZE);
> +}
> +
> +/*
> + * Free up any unused address space. Used only during teardown.
> + */
> +static void buddy_unreserve_arena_vaddr(struct buddy *buddy)
> +{
> +       bpf_arena_free_pages(
> +               &arena, (void __arena *)(BUDDY_VADDR_OFFSET + buddy->vadd=
r),
> +               (BUDDY_VADDR_SIZE - buddy->vaddr) / __PAGE_SIZE);
> +
> +       buddy->vaddr =3D 0;
> +}
> +
> +/*
> + * Carve out part of the reserved address space and hand it over
> + * to the buddy allocator.
> + *
> + * We are assuming the buddy allocator is the only allocator in the
> + * system, so there is no race between this function reserving a
> + * page range and some other allocator actually making the BPF call
> + * to really create and reserve it.
> + */
> +__weak int buddy_alloc_arena_vaddr(struct buddy *buddy, u64 *vaddrp)
> +{
> +       u64 vaddr, old, new;
> +
> +       if (!buddy || !vaddrp)
> +               return -EINVAL;
> +
> +       do {
> +               vaddr =3D buddy->vaddr;
> +               new =3D vaddr + BUDDY_CHUNK_BYTES;
> +
> +               if (new > BUDDY_VADDR_SIZE)
> +                       return -EINVAL;
> +
> +               old =3D __sync_val_compare_and_swap(&buddy->vaddr, vaddr,=
 new);
> +       } while (old !=3D vaddr && can_loop);

the comment says that there is no race, then why retry loop?

> +
> +       if (old !=3D vaddr)
> +               return -EINVAL;
> +
> +       *vaddrp =3D BUDDY_VADDR_OFFSET + vaddr;
> +
> +       return 0;
> +}
> +
> +static u64 arena_next_pow2(__u64 n)
> +{
> +       n--;
> +       n |=3D n >> 1;
> +       n |=3D n >> 2;
> +       n |=3D n >> 4;
> +       n |=3D n >> 8;
> +       n |=3D n >> 16;
> +       n |=3D n >> 32;
> +       n++;
> +
> +       return n;
> +}
> +
> +__weak
> +int idx_set_allocated(buddy_chunk_t __arg_arena *chunk, u64 idx, bool al=
located)
> +{
> +       if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
> +               arena_stderr("setting state of of invalid idx (%d, max %d=
)\n", idx,
> +                            BUDDY_CHUNK_ITEMS);
> +               return -EINVAL;
> +       }
> +
> +       if (allocated)
> +               chunk->allocated[idx / 8] |=3D 1 << (idx % 8);
> +       else
> +               chunk->allocated[idx / 8] &=3D ~(1 << (idx % 8));
> +
> +       return 0;
> +}
> +
> +static int idx_is_allocated(buddy_chunk_t *chunk, u64 idx, bool *allocat=
ed)
> +{
> +       if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
> +               arena_stderr("getting state of invalid idx (%llu, max %d)=
\n", idx,
> +                            BUDDY_CHUNK_ITEMS);
> +               return -EINVAL;
> +       }
> +
> +       *allocated =3D chunk->allocated[idx / 8] & (1 << (idx % 8));
> +       return 0;
> +}
> +
> +__weak
> +int idx_set_order(buddy_chunk_t __arg_arena *chunk, u64 idx, u8 order)

larger than 256 orders will be silently truncated by the compiler.
Use u32?

> +{
> +       u8 prev_order;
> +
> +       if (unlikely(order >=3D BUDDY_CHUNK_NUM_ORDERS)) {
> +               arena_stderr("setting invalid order %u\n", order);
> +               return -EINVAL;
> +       }
> +
> +       if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
> +               arena_stderr("setting order of invalid idx (%d, max %d)\n=
", idx,
> +                            BUDDY_CHUNK_ITEMS);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * We store two order instances per byte, one per nibble.
> +        * Retain the existing nibble.
> +        */
> +       prev_order =3D chunk->orders[idx / 2];
> +       if (idx & 0x1) {
> +               order &=3D 0xf;
> +               order |=3D (prev_order & 0xf0);
> +       } else {
> +               order <<=3D 4;
> +               order |=3D (prev_order & 0xf);
> +       }
> +
> +       chunk->orders[idx / 2] =3D order;
> +
> +       return 0;
> +}
> +
> +static u8 idx_get_order(buddy_chunk_t *chunk, u64 idx)
> +{
> +       u8 result;
> +
> +       _Static_assert(BUDDY_CHUNK_NUM_ORDERS <=3D 16,
> +                      "order must fit in 4 bits");
> +
> +       if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
> +               arena_stderr("setting order of invalid idx\n");
> +               return BUDDY_CHUNK_NUM_ORDERS;
> +       }
> +
> +       result =3D chunk->orders[idx / 2];
> +
> +       return (idx & 0x1) ? (result & 0xf) : (result >> 4);
> +}
> +
> +static void __arena *idx_to_addr(buddy_chunk_t *chunk, size_t idx)
> +{
> +       u64 address;
> +
> +       if (unlikely(idx >=3D BUDDY_CHUNK_ITEMS)) {
> +               arena_stderr("setting order of invalid idx\n");
> +               return NULL;
> +       }
> +
> +       /*
> +        * The data blocks start in the chunk after the metadata block.
> +        * We find the actual address by indexing into the region at an
> +        * BUDDY_MIN_ALLOC_BYTES granularity, the minimum allowed.
> +        * The index number already accounts for the fact that the first
> +        * blocks in the chunk are occupied by the metadata, so we do
> +        * not need to offset it.
> +        */
> +
> +       address =3D (u64)chunk + (idx * BUDDY_MIN_ALLOC_BYTES);
> +
> +       return (void __arena *)address;
> +}
> +
> +static buddy_header_t *idx_to_header(buddy_chunk_t *chunk, size_t idx)
> +{
> +       bool allocated;
> +       u64 address;
> +
> +       if (unlikely(idx_is_allocated(chunk, idx, &allocated))) {
> +               arena_stderr("accessing invalid idx 0x%lx\n", idx);
> +               return NULL;
> +       }
> +
> +       if (unlikely(allocated)) {
> +               arena_stderr("accessing allocated idx 0x%lx as header\n",=
 idx);
> +               return NULL;
> +       }
> +
> +       address =3D (u64)idx_to_addr(chunk, idx);
> +
> +       /*
> +        * Offset the header within the block. This avoids accidental ove=
rwrites
> +        * to the header because of off-by-one errors when using adjacent=
 blocks.
> +        *
> +        * The offset has been chosen as a compromise between ASAN effect=
iveness
> +        * and allocator granularity:
> +        * 1) ASAN dictates valid data runs are 8-byte aligned.
> +        * 2) We want to keep a low minimum allocation size (currently 16=
).
> +        *
> +        * As a result, we have only two possible positions for the heade=
r: Bytes
> +        * 0 and 8. Keeping the header in byte 0 means off-by-ones from t=
he previous
> +        * block touch the header, and, since the header must be accessib=
le, ASAN
> +        * will not trigger. Keeping the header on byte 8 means off-by-on=
e errors from
> +        * the previous block are caught by ASAN. Negative offsets are ra=
rer, so
> +        * while accesses into the block from the next block are possible=
, they are
> +        * less probable.
> +        */
> +
> +       return (buddy_header_t *)(address + BUDDY_HEADER_OFF);
> +}
> +
> +static void header_add_freelist(buddy_chunk_t  *chunk,

double space

> +                               buddy_header_t *header, u64 idx, u8 order=
)
> +{
> +       buddy_header_t *tmp_header;
> +
> +       idx_set_order(chunk, idx, order);
> +
> +       header->next_index =3D chunk->freelists[order];
> +       header->prev_index =3D BUDDY_CHUNK_ITEMS;

BUDDY_CHUNK_ITEMS is used like NULL ?
The header is u32 + u32. Is it really worth saving 8 bytes?
Use two proper pointers?
How many headers are there?

> +
> +       if (header->next_index !=3D BUDDY_CHUNK_ITEMS) {
> +               tmp_header =3D idx_to_header(chunk, header->next_index);
> +               tmp_header->prev_index =3D idx;
> +       }
> +
> +       chunk->freelists[order] =3D idx;
> +}
> +
> +static void header_remove_freelist(buddy_chunk_t  *chunk,
> +                                  buddy_header_t *header, u8 order)
> +{
> +       buddy_header_t *tmp_header;
> +
> +       if (header->prev_index !=3D BUDDY_CHUNK_ITEMS) {
> +               tmp_header =3D idx_to_header(chunk, header->prev_index);
> +               tmp_header->next_index =3D header->next_index;
> +       }
> +
> +       if (header->next_index !=3D BUDDY_CHUNK_ITEMS) {
> +               tmp_header =3D idx_to_header(chunk, header->next_index);
> +               tmp_header->prev_index =3D header->prev_index;
> +       }
> +
> +       /* Pop off the list head if necessary. */
> +       if (idx_to_header(chunk, chunk->freelists[order]) =3D=3D header)
> +               chunk->freelists[order] =3D header->next_index;
> +
> +       header->prev_index =3D BUDDY_CHUNK_ITEMS;
> +       header->next_index =3D BUDDY_CHUNK_ITEMS;
> +}
> +
> +static u64 size_to_order(size_t size)
> +{
> +       u64 order;
> +
> +       /*
> +        * Legal sizes are [1, 4GiB] (the biggest possible arena).
> +        * Of course, sizes close to GiB are practically impossible
> +        * to fulfill and allocation will fail, but that's taken care
> +        * of by the caller.
> +        */
> +
> +       if (unlikely(size =3D=3D 0 || size > (1UL << 32))) {
> +               arena_stderr("illegal size request %lu\n", size);
> +               return 64;
> +       }
> +       /*
> +        * To find the order of the allocation we find the first power of=
 two
> +        * >=3D the requested size, take the log2, then adjust it for the=
 minimum
> +        * allocation size by removing the minimum shift from it. Request=
s
> +        * smaller than the minimum allocation size are rounded up.
> +        */
> +       order =3D arena_fls(arena_next_pow2(size));
> +       if (order < BUDDY_MIN_ALLOC_SHIFT)
> +               return 0;
> +
> +       return order - BUDDY_MIN_ALLOC_SHIFT;
> +}
> +
> +__weak
> +int add_leftovers_to_freelist(buddy_chunk_t __arg_arena *chunk, u32 cur_=
idx,
> +               u64 min_order, u64 max_order)
> +{
> +       buddy_header_t *header;
> +       u64 ord;
> +       u32 idx;
> +
> +       for (ord =3D min_order; ord < max_order && can_loop; ord++) {
> +               /* Mark the buddy as free and add it to the freelists. */
> +               idx =3D cur_idx + (1 << ord);
> +
> +               header =3D idx_to_header(chunk, idx);
> +               if (unlikely(!header)) {
> +                       arena_stderr("idx %u has no header", idx);
> +                       return -EINVAL;
> +               }
> +
> +               asan_unpoison(header, sizeof(*header));
> +
> +               idx_set_allocated(chunk, idx, false);
> +               header_add_freelist(chunk, header, idx, ord);
> +       }
> +
> +       return 0;
> +}
> +
> +static buddy_chunk_t *buddy_chunk_get(struct buddy *buddy)
> +{
> +       u64 order, ord, min_order, max_order;
> +       buddy_chunk_t  *chunk;
> +       size_t left;
> +       int power2;
> +       u64 vaddr;
> +       u32 idx;
> +       int ret;
> +
> +       /*
> +        * Step 1:  Allocate a properly aligned chunk, and
> +        * prep it for insertion into the buddy allocator.
> +        * We don't need the allocator lock until step 2.
> +        */
> +
> +       ret =3D buddy_alloc_arena_vaddr(buddy, &vaddr);
> +       if (ret)
> +               return NULL;
> +
> +       /* Addresses must be aligned to the chunk boundary. */
> +       if (vaddr % BUDDY_CHUNK_BYTES)
> +               return NULL;
> +
> +       /* Unreserve the address space. */
> +       bpf_arena_free_pages(&arena, (void __arena *)vaddr,
> +                            BUDDY_CHUNK_PAGES);
> +
> +       chunk =3D bpf_arena_alloc_pages(&arena, (void __arena *)vaddr,
> +                                     BUDDY_CHUNK_PAGES, NUMA_NO_NODE, 0)=
;
> +       if (!chunk) {
> +               arena_stderr("[ALLOC FAILED]");
> +               return NULL;
> +       }
> +
> +       if (buddy_lock(buddy)) {
> +               /*
> +                * We cannot reclaim the vaddr space, but that is ok - th=
is
> +                * operation should always succeed. The error path is to =
catch
> +                * accidental deadlocks that will cause -ENOMEMs to the p=
rogram as
> +                * the allocator fails to refill itself, in which case va=
ddr usage
> +                * is the least of our worries.
> +                */
> +               bpf_arena_free_pages(&arena, (void __arena *)vaddr, BUDDY=
_CHUNK_PAGES);
> +               return NULL;
> +       }
> +
> +       asan_poison(chunk, BUDDY_POISONED, BUDDY_CHUNK_PAGES * __PAGE_SIZ=
E);
> +
> +       /* Unpoison the chunk itself. */
> +       asan_unpoison(chunk, sizeof(*chunk));
> +
> +       /* Mark all freelists as empty. */
> +       for (ord =3D zero; ord < BUDDY_CHUNK_NUM_ORDERS && can_loop; ord+=
+)
> +               chunk->freelists[ord] =3D BUDDY_CHUNK_ITEMS;

BUDDY_CHUNK_ITEMS sentinel makes it harder to undestand.
Why not zero ? and normal pointers ?

> +
> +       /*
> +        * Initialize the chunk by carving out a page range to hold the m=
etadata
> +        * struct above, then dumping the rest of the pages into the allo=
cator.
> +        */
> +
> +       _Static_assert(BUDDY_CHUNK_PAGES * __PAGE_SIZE >=3D
> +                              BUDDY_MIN_ALLOC_BYTES *
> +                                      BUDDY_CHUNK_ITEMS,
> +                      "chunk must fit within the allocation");
> +
> +       /*
> +        * Step 2: Reserve a chunk for the chunk metadata, then breaks
> +        * the rest of the full allocation into the different buckets.
> +        * We allocating the memory by grabbing blocks of progressively
> +        * smaller sizes from the allocator, which are guaranteed to be
> +        * continuous.
> +        *
> +        * This operation also populates the allocator.
> +        *
> +        * Algorithm:
> +        *
> +        * - max_order: The last order allocation we made
> +        * - left: How many bytes are left to allocate
> +        * - cur_index: Current index into the top-level block we are
> +        * allocating from.
> +        *
> +        * Step 3:
> +        * - Find the largest power-of-2 allocation still smaller than le=
ft (infimum)
> +        * - Reserve a chunk of that size, along with its buddy
> +        * - For every order from [infimum + 1, last order), carve out a =
block
> +        *   and put it into the allocator.
> +        *
> +        *  Example: Chunk size 0b1010000 (80 bytes)
> +        *
> +        *  Step 1:
> +        *
> +        *   idx  infimum                          1 << max_order
> +        *   0        64        128                   1 << 20
> +        *   |________|_________|______________________|
> +        *
> +        *   Blocks set aside:
> +        *      [0, 64)         - Completely allocated
> +        *      [64, 128)       - Will be further split in the next itera=
tion
> +        *
> +        *   Blocks added to the allocator:
> +        *      [128, 256)
> +        *      [256, 512)
> +        *      ...
> +        *      [1 << 18, 1 << 19)
> +        *      [1 << 19, 1 << 20)
> +        *
> +        *  Step 2:
> +        *
> +        *   idx  infimum                          idx + 1 << max_order
> +        *   64       80        96                      64 + 1 << 6 =3D 1=
28
> +        *   |________|_________|______________________|
> +        *
> +        *   Blocks set aside:
> +        *      [64, 80)        - Completely allocated
> +        *
> +        *   Blocks added to the allocator:
> +        *      [80, 96) - left =3D=3D 0 so the buddy is unused and marke=
d as freed
> +        *      [96, 128)
> +        */
> +       max_order =3D BUDDY_CHUNK_NUM_ORDERS;
> +       left =3D sizeof(*chunk);
> +       idx =3D 0;
> +       while (left && can_loop) {
> +               power2 =3D arena_fls(left);
> +               /*
> +                * Note: The condition below only triggers to catch serio=
us bugs
> +                * early. There is no sane way to undo any block insertio=
ns from
> +                * the allocated chunk, so just leak any leftover allocat=
ions,
> +                * emit a diagnostic, unlock and exit.
> +                *
> +                */
> +               if (unlikely(power2 >=3D BUDDY_CHUNK_NUM_ORDERS)) {
> +                       arena_stderr(
> +                               "buddy chunk metadata require allocation =
of order %d\n",
> +                               power2);
> +                       arena_stderr(
> +                               "chunk has size of 0x%lx bytes (left %lx =
bytes)\n",
> +                               sizeof(*chunk), left);
> +                       buddy_unlock(buddy);
> +
> +                       return NULL;
> +               }
> +
> +               /* Round up allocations that are too small. */
> +
> +               left -=3D (power2 >=3D BUDDY_MIN_ALLOC_SHIFT) ? 1 << powe=
r2 : left;
> +               order =3D (power2 >=3D BUDDY_MIN_ALLOC_SHIFT) ? power2 - =
BUDDY_MIN_ALLOC_SHIFT : 0;
> +
> +               idx_set_allocated(chunk, idx, true);
> +
> +               /*
> +                * Starting an order above the one we allocated, populate
> +                * the allocator with free blocks. If this is the last
> +                * allocation (left =3D=3D 0), also mark the buddy as fre=
e.
> +                *
> +                * See comment above about error handling: The error path
> +                * is only there as a way to mitigate deeply buggy alloca=
tor
> +                * states by emitting a diagnostic in add_leftovers_to_fr=
eelist()
> +                * and leaking any memory not added in the freelists.
> +                */
> +               min_order =3D left ? order + 1 : order;
> +               if (add_leftovers_to_freelist(chunk, idx, min_order, max_=
order)) {
> +                       buddy_unlock(buddy);
> +                       return NULL;
> +               }
> +
> +               /* Adjust the index. */
> +               idx +=3D 1 << order;
> +               max_order =3D order;
> +       }
> +
> +       buddy_unlock(buddy);
> +
> +       return chunk;
> +}
> +
> +__hidden int buddy_init(struct buddy *buddy,
> +               arena_spinlock_t __arg_arena __arena *lock)
> +{
> +       buddy_chunk_t *chunk;
> +       int ret;
> +
> +       buddy->lock =3D lock;
> +
> +       if (!asan_ready())
> +               return -EINVAL;
> +
> +       /*
> +        * Reserve enough address space to ensure allocations are aligned=
.
> +        */
> +       if ((ret =3D buddy_reserve_arena_vaddr(buddy)))
> +               return ret;
> +
> +       _Static_assert(BUDDY_CHUNK_PAGES > 0,
> +                      "chunk must use one or more pages");
> +
> +       chunk =3D buddy_chunk_get(buddy);
> +
> +       if (buddy_lock(buddy)) {
> +               bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
> +               return -EINVAL;
> +       }
> +
> +       /* Chunk is already properly unpoisoned if allocated. */
> +       if (chunk) {
> +               chunk->next =3D buddy->first_chunk;
> +               chunk->prev =3D NULL;
> +       }
> +
> +       /* Put the chunk at the beginning of the list. */
> +       buddy->first_chunk =3D chunk;
> +
> +       buddy_unlock(buddy);
> +
> +       return chunk ? 0 : -ENOMEM;
> +}
> +
> +/*
> + * Destroy the allocator. This does not check whether there are any allo=
cations
> + * currently in use, so any pages being accessed will start taking arena=
 faults.
> + * We do not take a lock because we are freeing arena pages, and nobody =
should
> + * be using the allocator at that point in the execution.
> + */
> +__weak int buddy_destroy(struct buddy *buddy)
> +{
> +       buddy_chunk_t *chunk, *next;
> +
> +       if (!buddy)
> +               return -EINVAL;
> +
> +       /*
> +        * Traverse all buddy chunks and free them back to the arena
> +        * with the same granularity they were allocated with.
> +        */
> +       for (chunk =3D buddy->first_chunk; chunk && can_loop; chunk =3D n=
ext) {
> +               next =3D chunk->next;
> +
> +               /* Wholesale poison the entire block. */
> +               asan_poison(chunk, BUDDY_POISONED,
> +                           BUDDY_CHUNK_PAGES * __PAGE_SIZE);
> +               bpf_arena_free_pages(&arena, chunk, BUDDY_CHUNK_PAGES);
> +       }
> +
> +       /* Free up any part of the address space that did not get used. *=
/
> +       buddy_unreserve_arena_vaddr(buddy);
> +
> +       /* Clear all fields. */
> +       buddy->first_chunk =3D NULL;
> +
> +       return 0;
> +}
> +
> +__weak u64 buddy_chunk_alloc(buddy_chunk_t __arg_arena *chunk,
> +                                int order_req)
> +{
> +       buddy_header_t *header, *tmp_header, *next_header;
> +       u32 idx, tmpidx, retidx;
> +       u64 address;
> +       u64 order =3D 0;
> +       u64 i;
> +
> +       for (order =3D order_req; order < BUDDY_CHUNK_NUM_ORDERS && can_l=
oop; order++) {
> +               if (chunk->freelists[order] !=3D BUDDY_CHUNK_ITEMS)
> +                       break;
> +       }
> +
> +       if (order >=3D BUDDY_CHUNK_NUM_ORDERS)
> +               return (u64)NULL;
> +
> +       retidx =3D chunk->freelists[order];
> +       header =3D idx_to_header(chunk, retidx);
> +       chunk->freelists[order] =3D header->next_index;
> +
> +       if (header->next_index !=3D BUDDY_CHUNK_ITEMS) {
> +               next_header =3D idx_to_header(chunk, header->next_index);
> +               next_header->prev_index =3D BUDDY_CHUNK_ITEMS;
> +       }

if everything is a pointer the whole algorithm would be so much easier
to understand. Is it worth it to keep indices vs pointers?
Please do the math and explain the savings.

> +
> +       header->prev_index =3D BUDDY_CHUNK_ITEMS;
> +       header->next_index =3D BUDDY_CHUNK_ITEMS;
> +       if (idx_set_order(chunk, retidx, order_req))
> +               return (u64)NULL;
> +
> +       if (idx_set_allocated(chunk, retidx, true))
> +               return (u64)NULL;
> +
> +       /*
> +        * Do not unpoison the address yet, will be done by the caller
> +        * because the caller has the exact allocation size requested.
> +        */
> +       address =3D (u64)idx_to_addr(chunk, retidx);
> +
> +       /* If we allocated from a larger-order chunk, split the buddies. =
*/
> +       for (i =3D order_req; i < order && can_loop; i++) {
> +               /*
> +                * Flip the bit for the current order (the bit is guarant=
eed
> +                * to be 0, so just add 1 << i).
> +                */
> +               idx =3D retidx + (1 << i);
> +
> +               /* Add the buddy of the allocation to the free list. */
> +               header =3D idx_to_header(chunk, idx);
> +               /* Unpoison the buddy header */
> +               asan_unpoison(header, sizeof(*header));
> +               if (idx_set_allocated(chunk, idx, false))
> +                       return (u64)NULL;
> +
> +               if (idx_set_order(chunk, idx, i))
> +                       return (u64)NULL;
> +
> +               /* Push the header to the beginning of the freelists list=
. */
> +               tmpidx =3D chunk->freelists[i];
> +
> +               header->prev_index =3D BUDDY_CHUNK_ITEMS;
> +               header->next_index =3D tmpidx;
> +
> +               if (tmpidx !=3D BUDDY_CHUNK_ITEMS) {
> +                       tmp_header =3D idx_to_header(chunk, tmpidx);
> +                       tmp_header->prev_index =3D idx;
> +               }
> +
> +               chunk->freelists[i] =3D idx;
> +       }
> +
> +       return address;
> +}
> +
> +/* Scan the existing chunks for available memory. */
> +static u64 buddy_alloc_from_existing_chunks(struct buddy *buddy, int ord=
er)
> +{
> +       buddy_chunk_t *chunk;
> +       u64 address;
> +
> +       for (chunk =3D buddy->first_chunk; chunk !=3D NULL && can_loop;
> +            chunk =3D chunk->next) {
> +               address =3D buddy_chunk_alloc(chunk, order);
> +               if (address)
> +                       return address;
> +       }
> +
> +       return (u64)NULL;
> +}
> +
> +/*
> + * Try an allocation from a newly allocated chunk. Also
> + * incorporate the chunk into the linked list.
> + */
> +static u64 buddy_alloc_from_new_chunk(struct buddy *buddy, buddy_chunk_t=
 *chunk, int order)
> +{
> +       u64 address;
> +
> +       if (buddy_lock(buddy))
> +               return (u64)NULL;
> +
> +
> +       /*
> +        * Add the chunk into the allocator and try
> +        * to allocate specifically from that chunk.
> +        */
> +       chunk->next =3D buddy->first_chunk;
> +       chunk->prev =3D NULL;
> +       buddy->first_chunk =3D chunk;
> +
> +       address =3D buddy_chunk_alloc(buddy->first_chunk, order);
> +
> +       buddy_unlock(buddy);
> +
> +       return (u64)address;
> +}
> +__weak
> +u64 buddy_alloc_internal(struct buddy *buddy, size_t size)
> +{
> +       buddy_chunk_t *chunk;
> +       u64 address =3D (u64)NULL;
> +       int order;
> +
> +       if (!buddy)
> +               return (u64)NULL;
> +
> +       order =3D size_to_order(size);
> +       if (order >=3D BUDDY_CHUNK_NUM_ORDERS || order < 0) {
> +               arena_stderr("invalid order %d (sz %lu)\n", order, size);
> +               return (u64)NULL;
> +       }
> +
> +       if (buddy_lock(buddy))
> +               return (u64)NULL;
> +
> +       address =3D buddy_alloc_from_existing_chunks(buddy, order);
> +       buddy_unlock(buddy);
> +       if (address)
> +               goto done;
> +
> +       /* Get a new chunk. */
> +       chunk =3D buddy_chunk_get(buddy);
> +       if (chunk)
> +               address =3D buddy_alloc_from_new_chunk(buddy, chunk, orde=
r);
> +
> +done:
> +       /* If we failed to allocate memory, return NULL. */
> +       if (!address)
> +               return (u64)NULL;
> +
> +       /*
> +        * Unpoison exactly the amount of bytes requested. If the
> +        * data is smaller than the header, we must poison any
> +        * unused bytes that were part of the header.
> +        */
> +       if (size < BUDDY_HEADER_OFF + sizeof(buddy_header_t))
> +               asan_poison((u8 __arena *)address + BUDDY_HEADER_OFF,
> +                           BUDDY_POISONED, sizeof(buddy_header_t));
> +
> +       asan_unpoison((u8 __arena *)address, size);
> +
> +       return address;
> +}
> +
> +static __always_inline int buddy_free_unlocked(struct buddy *buddy, u64 =
addr)
> +{
> +       buddy_header_t *header, *buddy_header;
> +       u64 idx, buddy_idx, tmp_idx;
> +       buddy_chunk_t *chunk;
> +       bool allocated;
> +       u8 order;
> +
> +       if (!buddy)
> +               return -EINVAL;
> +
> +       if (addr & (BUDDY_MIN_ALLOC_BYTES - 1)) {
> +               arena_stderr("Freeing unaligned address %llx\n", addr);
> +               return -EINVAL;
> +       }
> +
> +       /* Get (chunk, idx) out of the address. */
> +       chunk =3D (void __arena *)(addr & ~BUDDY_CHUNK_OFFSET_MASK);
> +       idx =3D (addr & BUDDY_CHUNK_OFFSET_MASK) / BUDDY_MIN_ALLOC_BYTES;
> +
> +       /* Mark the block as unallocated so we can access the header. */
> +       idx_set_allocated(chunk, idx, false);
> +
> +       order  =3D idx_get_order(chunk, idx);
> +       header =3D idx_to_header(chunk, idx);
> +
> +       /* The header is in the block itself, keep it unpoisoned. */
> +       asan_poison((u8 __arena *)addr, BUDDY_POISONED,
> +                   BUDDY_MIN_ALLOC_BYTES << order);
> +       asan_unpoison(header, sizeof(*header));
> +
> +       /*
> +        * Coalescing loop. Merge with free buddies of equal order.
> +        * For every coalescing step, keep the left buddy and
> +        * drop the right buddy's header.
> +        */
> +       for (; order < BUDDY_CHUNK_NUM_ORDERS && can_loop; order++) {
> +               buddy_idx =3D idx ^ (1 << order);
> +
> +               /* Check if the buddy is actually free. */
> +               idx_is_allocated(chunk, buddy_idx, &allocated);
> +               if (allocated)
> +                       break;
> +
> +               /*
> +                * If buddy is not the same order as the chunk
> +                * being freed, then we're done coalescing.
> +                */
> +               if (idx_get_order(chunk, buddy_idx) !=3D order)
> +                       break;
> +
> +               buddy_header =3D idx_to_header(chunk, buddy_idx);
> +               header_remove_freelist(chunk, buddy_header, order);
> +
> +               /* Keep the left header out of the two buddies, drop the =
other one. */
> +               if (buddy_idx < idx) {
> +                       tmp_idx =3D idx;
> +                       idx =3D buddy_idx;
> +                       buddy_idx =3D tmp_idx;
> +               }
> +
> +               /* Remove the buddy from the freelists so that we can mer=
ge it. */
> +               idx_set_order(chunk, buddy_idx, order);
> +
> +               buddy_header =3D idx_to_header(chunk, buddy_idx);
> +               asan_poison(buddy_header, BUDDY_POISONED,
> +                           sizeof(*buddy_header));
> +       }
> +
> +       /* Header properly freed but not in any freelists yet .*/
> +       idx_set_order(chunk, idx, order);
> +
> +       header =3D idx_to_header(chunk, idx);
> +       header_add_freelist(chunk, header, idx, order);
> +
> +       return 0;
> +}
> +
> +__weak int buddy_free_internal(struct buddy *buddy, u64 addr)
> +{
> +       int ret;
> +
> +       if (!buddy)
> +               return -EINVAL;
> +
> +       if ((ret =3D buddy_lock(buddy)))
> +               return ret;
> +
> +       buddy_free_unlocked(buddy, addr);
> +
> +       buddy_unlock(buddy);
> +
> +       return 0;
> +}
> +
> +__weak char _license[] SEC("license") =3D "GPL";
> --
> 2.53.0
>
