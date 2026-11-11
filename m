Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405102;
	b=rIbPb6cwjQEQ1/vUTcQZxdiTg8WrsA7Jycwlpe6fgTTSxskQ57sv6jP/W8j2ldKs+s8R
	 qeBpnY8+FyctvtWay/mSi2zHA9/dRvb3HVW8j0DrkbMFqzFJpKyNnC7KEPrZXhRO5nqz6
	 BCIP81zG9wTJ9uZ3mki/jaGDZSwxyg+I8W1BUlmjtO5BWq4GQGUv8R8r94VWo7VjJq35s
	 Bf/sm52g5Xt8leoJlhBVqR5dTKsg97VcIeV3jzNy5Ps07yhfhGWmWwtZq5to0T0GBpbjZ
	 M9tERdAwGgx5trsILifQexjMzGs9ugjE0T2EChppE4HReasmXXsPPsqAqn5/5gYW72A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xdwgS6nFFPgGcnzDnviv3rlnY2N4c/xLYaETcsEp4NQ=;
	b=bs+Xkr51kysk3PJEN6ZwfW/TLIz1cW46mHTlEWJleNWNGDlyuCXv230eBTUgDRlboWPo
	 EBkOnjcRRTzY0R1wkELcle0CEoBRyqB6BE2yUt2mDZhdxjGjyucmFgssJ05WffS3pyPoe
	 RkYl3027uyOANMDvvKOQsB1uPQh3PFArFA3Z2i60T7QD0Nk4KK7GNm637oCGKLbXTmdmm
	 VipC3HyNY/SLGwm0EMIL8DLECxGM6V0at8bQnAIXI8FIpxrhoIZtp2wHgluBaKq9Ozgvp
	 j49LKt/2fKt8DlS8MSipIx8QojYj+3aX/DeqqJhIgCdR9PKtCJcuaHzFC90Mz44n00Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOEM2LJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CE606A321;
	Wed, 11 Nov 2026 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VOEM2LJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A051F00A05;
	Wed, 11 Nov 2026 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405102;
	bh=xdwgS6nFFPgGcnzDnviv3rlnY2N4c/xLYaETcsEp4NQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VOEM2LJjaiSVRyMdMxeRjb+JH91r76k7rrchf2Q0YlZ+O2d2YPHl8W2itpk5Q4d6R
	 EN4Lsb9fdyI7lxf9Fppr5u7HCb4e3+gqojPwIuDYF37FlGyQV7XrxW52Hk4j9M6OMM
	 t9JJofvC2SYkc0gjMtsd/X2lMkdGM9NGVsGH+xPAMoa5519oI6MjVJk4SoM76Vkcgn
	 CL6u+hEBA/JiFSavEVYpXn03Gryo/ZEewXyZ486my9LGCMDVkSLlUzM/UgjxdFy8om
	 C+VtmctaB0fgmgYcljhJF7toQT7a9XSmn5MzciMPq1dY9jOCJ8qjxhSPCGx7KsRsMW
	 YyCCFPoUT0aaA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, io-uring@vger.kernel.org,
 Mina Almasry <almasrymina@google.com>, "Mike Marciniszyn (Meta)"
 <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through
 page_pool
In-Reply-To: <CAJ8uoz0gcQmqTPGBmNF6+WvWZHPOVRsPoEmTwG6WeOaq1vPxcg@mail.gmail.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-5-bjorn@kernel.org>
 <CAJ8uoz0gcQmqTPGBmNF6+WvWZHPOVRsPoEmTwG6WeOaq1vPxcg@mail.gmail.com>
Date: Wed, 11 Nov 2026 05:51:39 -0800
Message-ID: <87wlqj8oic.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> On Tue, 10 Nov 2026 at 12:26, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:

>> diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
>> index 7c811b5cce76..4dab7b9a1487 100644
>> --- a/net/xdp/xsk.h
>> +++ b/net/xdp/xsk.h
>> @@ -34,6 +34,12 @@ static inline struct xdp_sock *xdp_sk(struct sock *sk)
>>
>>  void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
>>                              struct xdp_sock __rcu **map_entry);
>> +struct xsk_pp;
>
> How about a header file instead of a forward declaration?

Thanks for taking a look, Magnus!

Hmm, my take was this this was ont by itself sufficient for a header.
Let me think about it, and I might add net/xdp/xsk_pp.h.

>
>> +extern const struct memory_provider_ops xsk_pp_ops;
>> +
>> +struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool);
>> +void xsk_pp_put(struct xsk_pp *pp);
>>  void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
>>  int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *p=
ool,
>>                         u16 queue_id);
>> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
>> new file mode 100644
>> index 000000000000..fdd55265a6cd
>> --- /dev/null
>> +++ b/net/xdp/xsk_pp.c
>> @@ -0,0 +1,246 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* AF_XDP UMEM as a page pool memory provider
>> + *
>> + * Each aligned UMEM chunk is a readable net_iov with one owner at a ti=
me:
>> + *
>> + *   userspace --FILL--> page pool --release--> reuse --alloc--> page p=
ool
>> + *       ^                   |
>> + *       +-----RX ring-------+
>> + */
>> +
>> +#include <net/page_pool/helpers.h>
>> +#include <net/page_pool/memory_provider.h>
>> +#include <net/xdp_sock_drv.h>
>> +
>> +#include "xsk.h"
>> +#include "xsk_queue.h"
>> +
>> +enum xsk_pp_chunk {
>> +       XSK_PP_USER,    /* owned by userspace */
>> +       XSK_PP_POOL,    /* owned by a page pool */
>> +       XSK_PP_REUSE,   /* on the reuse stack */
>> +};
>> +
>> +struct xsk_pp {
>> +       struct net_iov_area area;
>> +       struct xsk_buff_pool *pool;
>> +       /* Protects fq, state and reuse */
>> +       spinlock_t lock;
>> +       struct xsk_queue *fq;
>> +       refcount_t refs;
>> +       u32 nr_pools;
>> +       bool dma_need_sync;
>> +       u8 *state;
>> +       u32 reuse_cnt;
>> +       u32 reuse[];
>
> Is the reason that you have a reuse stack here and not use the one in
> xsk_buff_pool that it only exists in unaligned mode, which you are not
> supporting? Could you still use the "pre-calculated" heads in aligned
> mode and link them up? There is already a xskb_list and free_list in
> there that is used for that purpose. Just an idea that could cut down
> the state and maybe the amount of code.


Not quite. reuse is the counterpart of free_list, which aligned mode has
too. But free_list links xdp_buff_xsk, and this mode has none: the page
pool hands out net_iovs, and the driver has its own xdp_buff. Patch 5
stops allocating the heads here: 128 bytes per chunk, against 69 for
net_iov, reuse and state. devmem and zcrx use the same kind of index
stack.

free_list is also NAPI only, while the page pool releases chunks from
process context too (below). And state is needed either way; it is what
drops a FILL entry for a chunk the kernel still owns.


>> +};
>> +
>> +static void xsk_pp_free(struct xsk_pp *pp)
>> +{
>> +       kvfree(pp->state);
>> +       kvfree(pp->area.niovs);
>> +       kvfree(pp);
>> +}
>> +
>> +void xsk_pp_put(struct xsk_pp *pp)
>> +{
>> +       if (refcount_dec_and_test(&pp->refs))
>> +               xsk_pp_free(pp);
>> +}
>> +
>> +/* @pool must be DMA mapped and have aligned chunks. The provider must =
be
>> + * the only consumer of its FILL ring.
>> + */
>> +struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool)
>> +{
>> +       struct net_iov *niov;
>> +       struct xsk_pp *pp;
>> +       dma_addr_t dma;
>> +       u32 i;
>> +
>> +       pp =3D kvzalloc_flex(*pp, reuse, pool->heads_cnt, GFP_KERNEL_ACC=
OUNT);
>> +       if (!pp)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       pp->area.niovs =3D kvzalloc_objs(*pp->area.niovs, pool->heads_cn=
t,
>> +                                      GFP_KERNEL_ACCOUNT);
>> +       pp->state =3D kvzalloc(pool->heads_cnt, GFP_KERNEL_ACCOUNT);
>> +       if (!pp->area.niovs || !pp->state) {
>> +               xsk_pp_free(pp);
>> +               return ERR_PTR(-ENOMEM);
>> +       }
>> +
>> +       pp->area.num_niovs =3D pool->heads_cnt;
>> +       pp->area.niov_shift =3D pool->chunk_shift;
>> +       pp->area.vaddr =3D pool->addrs;
>> +       pp->pool =3D pool;
>> +       pp->fq =3D pool->fq;
>> +       pp->dma_need_sync =3D dma_dev_need_sync(pool->dev);
>
> Are you copying these for performance reasons, i.e. no extra pointer
> dereference in the fast path? In the same manner as the pool copies
> some information from the umem?

Only dma_need_sync is a cache -- I'll drop that!

fq stays. It's the provider's handle on FILL: unbind clears it under the
lock (patch 5), so the provider stops reading FILL, while pool->fq stays
with the socket for mmap, need_wakeup and copy mode until the ring is
freed. The area fields are the generic net_iov_area that
netmem_address() needs.

Does that make sense?

>> +       spin_lock_init(&pp->lock);
>> +       refcount_set(&pp->refs, 1);
>> +
>> +       for (i =3D 0; i < pp->area.num_niovs; i++) {
>> +               niov =3D &pp->area.niovs[i];
>> +               dma =3D xp_raw_get_dma(pool, (u64)i << pool->chunk_shift=
);
>> +               net_iov_init(niov, &pp->area, NET_IOV_XSK);
>> +               if (net_mp_niov_set_dma_addr(niov, dma)) {
>> +                       xsk_pp_free(pp);
>> +                       return ERR_PTR(-ERANGE);
>> +               }
>> +       }
>> +
>> +       return pp;
>> +}
>> +
>> +static int xsk_pp_init(struct page_pool *pool)
>> +{
>> +       struct xsk_pp *pp =3D pool->mp_priv;
>> +
>> +       if (pool->p.order || pool->p.dma_dir !=3D DMA_BIDIRECTIONAL ||
>> +           pool->p.dev !=3D pp->pool->dev)
>> +               return -EINVAL;
>> +       if (pool->p.max_len > pp->pool->chunk_size ||
>> +           pool->p.offset > pp->pool->chunk_size - pool->p.max_len)
>> +               return -EINVAL;
>> +
>> +       refcount_inc(&pp->refs);
>> +       spin_lock_bh(&pp->lock);
>> +       pp->nr_pools++;
>
> What is the difference between this counter and the refcount?

refs is the lifetime of struct xsk_pp. The buffer pool holds one
reference, and each page pool that takes the provider holds one. A page
pool can outlive the socket, as page_pool_destroy() defers while buffers
are in flight. The struct is freed with the last reference.

nr_pools only tells whether a page pool still exists, when a failed bind
(patch 5) hands the leftover chunks to copy mode. But the page pools of
a failed bind never ran, and are gone by then, so a WARN on refs !=3D 1
does the same job... I'll drop nr_pools. Thanks!

>> +       spin_unlock_bh(&pp->lock);
>> +       return 0;
>> +}
>> +
>> +static void xsk_pp_destroy(struct page_pool *pool)
>> +{
>> +       struct xsk_pp *pp =3D pool->mp_priv;
>> +
>> +       spin_lock_bh(&pp->lock);
>> +       pp->nr_pools--;
>> +       spin_unlock_bh(&pp->lock);
>> +       xsk_pp_put(pp);
>> +}
>> +
>> +static bool xsk_pp_claim(struct xsk_pp *pp, u32 idx, enum xsk_pp_chunk =
from)
>> +{
>> +       lockdep_assert_held(&pp->lock);
>> +
>> +       if (pp->state[idx] !=3D from)
>> +               return false;
>> +
>> +       pp->state[idx] =3D XSK_PP_POOL;
>> +       return true;
>> +}
>> +
>> +static u32 xsk_pp_alloc_reuse(struct xsk_pp *pp, netmem_ref *netmems, u=
32 max)
>> +{
>> +       u32 idx, n =3D 0;
>> +
>> +       while (n < max && pp->reuse_cnt) {
>> +               idx =3D pp->reuse[--pp->reuse_cnt];
>> +               if (WARN_ON_ONCE(!xsk_pp_claim(pp, idx, XSK_PP_REUSE)))
>> +                       continue;
>> +               netmems[n++] =3D net_iov_to_netmem(&pp->area.niovs[idx]);
>> +       }
>> +
>> +       return n;
>> +}
>> +
>> +static u32 xsk_pp_alloc_fill(struct xsk_pp *pp, netmem_ref *netmems, u3=
2 max)
>> +{
>> +       struct xsk_buff_pool *pool =3D pp->pool;
>> +       struct xsk_queue *fq =3D pp->fq;
>> +       u32 i, entries, cons, idx, n =3D 0;
>> +       u64 addr;
>> +
>> +       if (!fq || !max)
>> +               return 0;
>> +
>> +       entries =3D xskq_cons_nb_entries(fq, max);
>> +       if (!entries) {
>> +               fq->queue_empty_descs++;
>> +               return 0;
>> +       }
>> +
>> +       cons =3D fq->cached_cons;
>> +       for (i =3D 0; i < entries; i++) {
>> +               __xskq_cons_read_addr_unchecked(fq, cons++, &addr);
>> +               addr &=3D pool->chunk_mask;
>> +               idx =3D addr >> pp->area.niov_shift;
>> +               if (unlikely(addr >=3D pool->addrs_cnt ||
>> +                            !xsk_pp_claim(pp, idx, XSK_PP_USER))) {
>> +                       fq->invalid_descs++;
>> +                       continue;
>> +               }
>> +               netmems[n++] =3D net_iov_to_netmem(&pp->area.niovs[idx]);
>> +       }
>> +
>> +       xskq_cons_release_n(fq, entries);
>> +       __xskq_cons_release(fq);
>> +       return n;
>> +}
>> +
>> +static netmem_ref xsk_pp_alloc_netmems(struct page_pool *pool, gfp_t gf=
p)
>> +{
>> +       netmem_ref *netmems =3D pool->alloc.cache;
>> +       struct xsk_pp *pp =3D pool->mp_priv;
>> +       struct net_iov *niov;
>> +       dma_addr_t dma;
>> +       u32 i, n;
>> +
>> +       if (WARN_ON_ONCE(pool->alloc.count))
>
> What has the driver writer or system done if this ever happens?

A correct driver can't get there; the page pool calls ->alloc_netmems()
only with an empty cache. It fires on a page_pool core bug, or when a
driver recycles with allow_direct outside the pool's NAPI, and races the
cache. The provider fills the cache from index 0, so failing beats
overwriting live entries. devmem and zcrx have the same check; I'll add
zcrx's comment.


>> +               return 0;
>> +
>> +       spin_lock_bh(&pp->lock);
>
> For my understanding, what entities can call this function at the same
> time? With the xsk_buff_pool we were protected by NAPI.

Yeah... this is a bit gnarley.=20

The provider outlives a page pool: a queue restart starts the new queue
before it frees the old pool, so the old pool releases chunks while the
new NAPI allocates. Teardown can be deferred to a work item, and the
initial fill, bind and unbind run in process context. A driver that
fills its new rings in ndo_queue_mem_alloc() even has two pools on one
FILL ring.

However, in steady state only in NAPI, once per refill, so the lock is
uncontended. I haven't been able to see it in perf...

I'll list that in a comment.


Bj=C3=B6rn
