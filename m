Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794323325;
	b=JBg06sbnxklJVJLfMD29yeTbD0siH5xUR80lUk1SKOYKcBYOFoLJp/u8VuAF+d2U4WAo
	 JWJj25SFKM5Bvl8UMttCoEzIG4HOg8j//kyZpX/Evlbd1HTObIdt65ZBoOhnjOxnBXjZ3
	 m4BEVZShA023Tk7n1nRaJNQQ+7Q0PAwH/6HJLzC1omIFiv6FUODPFwD2w1OOpA+/2QZBH
	 /dT6Uy+3khkXZLl5z2mH0oKWqAhlWEs1OCf6q8c+aw2Zq4XRbwsutKgUvn6SUfLN4eHtP
	 zZPm9qJPyS8jcPIkzmJPQgfLhSdq5tjXx2A9+nqe28BzaoZUFjMudDNIljmLIRT8M0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c1nbMdS2/wACnz7+n6RyuA+wAdoXXvtuh3t/Ui9Sz3A=;
	b=rrhCLCCgUV6eBjgcIwIS0SL2mw0xfik/ELGw7mu9iCeofKGnIXKckfVdg9a7LVFngxb2
	 5samCme3cLPXEH0tUM7F9qEnWXSGHUP1saCJerxsCXzJmCKNWDTn4ebTvM6wYDkjGQca3
	 D0epDC0KyAJ0MFOD0BNp94rU/jQG+9Tlth7r/53AuypvBcOhRjTz76VoMfobJjhRWh2wS
	 pkdugOSgMP1EprnL+vrwXY35oXgfrCYP2ibhST6hxxzN3bjr4hwYzQwzYeJAFw1QrqjA6
	 i+dBs7ZEq3LPmo6xN23ZoeQUCOu06LSQwusXAOgy7p5hijgp8x6w/2xh6fUmDcOHwXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFJvOvW6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B2606A320
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 15:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 485B2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CFJvOvW6
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1018112a12.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 07:08:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794323325; cv=none;
        d=google.com; s=arc-20260327;
        b=X0JSrGNypRXOisqfr326Nl8DZHUDaiLKujpvkeURg5UKqHbebAoXD347n9cvth0wyi
         567LJpobCTzBhuobS8uFs5nk/edx4RqiauwMrXfCoEPvoyos7FM5eMfTCbRwUeLqYeJu
         m8k3qqlLLQeqGoLdt1mp9RGeqtmcDAAANBZapKWsVwrVbPfLbAAMzifrMu8Vv7/D6A0n
         KVo09QlpLDm8wRiEhn9AvZH2V2yXKaWXEIkZxXXOwVQZ7zwersMoVoOmzUpjKYRf3yHr
         lsXsz6Ai9brMfkqCiNYaalzO1nUl8WLi8tuT4duikQsi8mQMHgxq3zJ0ylqbizKggwBI
         OWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c1nbMdS2/wACnz7+n6RyuA+wAdoXXvtuh3t/Ui9Sz3A=;
        fh=3c2R+Gc027qjiEp66tHWn3y0zVsphFK1TbtHLh3OBc4=;
        b=nGdDMT4Y74KfJCXBElEH8/FwTFSRCJH6/Sqx4/+RBRiqpgBEhSv53Ywx3gD/Aax/wy
         2I7XoVl3WeasTJ4Da60uTF0uyeRNUGfNwiMQ7XgNBfx18nlWW4lw8P6M3b4et7xmBEqd
         Z8YKHgz66QUUarwj+1jLSoKMyi97ZluGA1eXYbHwZTr/15lcBx7AxhWadGEbD5+NKRBJ
         jMPFnpq45QNqw2yzcOop1PjTbsb6JJ4pSkPSnLJdxhOo7R3chh9T+75HnqUyXCDK7KfK
         eAgRaNGfr6a4fggT6dr6WWnChbAqmCpxUMd21zJeLlv66H7tu9bUh40FL/hZqj931HDP
         PdZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323325; x=1794928125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c1nbMdS2/wACnz7+n6RyuA+wAdoXXvtuh3t/Ui9Sz3A=;
        b=CFJvOvW6jk27IyasqE7tgYN8mkBBsQ0gyKXftzU/SGayTPf5b9yiXujRNHgwuPxNKr
         kU1R4YfpEa7oQ+xNbKT6eGcyTRCfWwMh/ELCAOC7fhMqpizV9k+f/8o9DY1LGNdgkecH
         VNKViEw++ZKjHT/3owob37cMu+P29+gUI7K9Di9sB6SdH38oMrXAYizUfDF1birdN4YO
         nge4tFm1ywqVh67GmI4kQhM/7oZNLwyAnkt78X3uDGRGxQeJ4rhv2dZh2uOX4veNrc1P
         omClfrAfH2DqoMwrMBqv488JV79Kty5ozzzmgDwUg5ZiBWvPOfKCqXJRnyhtL6Iolc02
         aJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323325; x=1794928125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c1nbMdS2/wACnz7+n6RyuA+wAdoXXvtuh3t/Ui9Sz3A=;
        b=no07bIOoQayketD0yx1URyBnV251Y5KyfXVvlQYCanPlDHiwmK8XWXNZniFDBtuhQ3
         4782cHzR7pFdSrE0bWBhCi/Rx/N+UGlvG6F4difsxEP/7/Zvd1Z7+hcmJMxWef3mSoXt
         lUh/7aJnewFquFCZ9hQOFtST31ebrkvDQSjMsccG0uJP5rrdiXCaaBx0936Rh16Rm7ZH
         b0f8rA4I/I9mRmZSKFaJN28Ycx1mffhK0By/0p67f8mzMq4PsBXxPTqd4A3eNUdYmoVx
         3KdzJki2QzbKTbXlYa3zM7hNI+MR7ZNsEIY6d3P7orJnBOmV2QPbNPU9UJG+BczxAWsJ
         t5Nw==
X-Forwarded-Encrypted: i=1; AL+hErFxP2vOldK+ynfuubldptrTmnoJQjddOXTkq/Ihf8fSUsqAJlsPp+2eZ21s6A8X769fkpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UO5e4gNAM9CYALdMeIw6wTHov/nV0Eq0z6RZS6ShCX+MmuK8e
	VDq+/7wsqdJpCzjSaE+In8WADPrpLb0wNNaB3UkJUBTAiB6sbY9R+hh2QY+S59qGjurwkj+HBq3
	V8qRacXT+Xr+QS6qDLHoD6bkldPO1M7g=
X-Gm-Gg: AYBFou22Dl3vfvaHxf2A+wUJ94BZKld7Vkk6OIksIGZ2XemZMdrTc2Nnid7XYfWlUZP
	kUmCquC4dIsGlOAtekIXNlq7cgOtFy1ZwD6eNOJWyollGZNMXEpr7SsA10/KJ45dqie49fqgrt4
	ZcsaB+UIjlE+x33rhC8HN90V+M9mhRVz5O1AEExOph9BPNZ/MFFXbG7+sCNMD1C0lC5qsWAUKlC
	FPlu1ILKJOxssTplrz0UqzCn4AOA69iiyrciBoMe00lSZ0xzCJOD0uWsq8dc8LQLO1dllq6Oegd
	PbUnkWlSJ6+/n6rXpL+VIISXqW9hSfTNgxg0I6X20qdS9RlGDFSCMrGCf99HVjCMvnQk8H4OV4N
	QbPV++TWXQBYa//W0PJVlfCFOzYFMm1+GMnWqYAo=
X-Received: by 2002:a17:903:1aef:b0:2e8:4040:792b with SMTP id
 d9443c01a7336-2edb9120edemr28852925ad.22.1794323324501; Tue, 10 Nov 2026
 07:08:44 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-5-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-5-bjorn@kernel.org>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 10 Nov 2026 16:08:32 +0100
X-Gm-Features: AclHuK8pcGlhvdthobLOqB0JgP37exZok7OAn9iLvLH8hYIBz6_niNrIr15aryU
Message-ID: <CAJ8uoz0gcQmqTPGBmNF6+WvWZHPOVRsPoEmTwG6WeOaq1vPxcg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through page_pool
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2026 at 12:26, Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wrot=
e:
>
> AF_XDP zero copy needs a second RX allocator in every driver. A
> page_pool driver can take UMEM chunks from a memory provider instead,
> and keep its refill, recycling and DMA sync code.
>
> Each aligned chunk becomes a net_iov, whose address netmem_address()
> finds without calling the provider. Userspace may post a chunk that
> the kernel still owns, so the provider tracks the owner of each chunk
> and drops such FILL entries. Chunks that a page pool releases stay in
> the kernel for reuse. Nothing installs the provider yet.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> ---
>  include/net/netmem.h |  25 ++++-
>  include/net/xdp.h    |   2 +-
>  net/xdp/Kconfig      |   1 +
>  net/xdp/Makefile     |   2 +-
>  net/xdp/xsk.h        |   6 ++
>  net/xdp/xsk_pp.c     | 246 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 279 insertions(+), 3 deletions(-)
>  create mode 100644 net/xdp/xsk_pp.c
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index b986ad616334..a3b67ef32b21 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -69,6 +69,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_restricted);
>  enum net_iov_type {
>         NET_IOV_DMABUF,
>         NET_IOV_IOURING,
> +       NET_IOV_XSK,
>  };
>
>  /* A memory descriptor representing abstract networking I/O vectors.
> @@ -107,6 +108,10 @@ struct net_iov_area {
>         size_t num_niovs;
>         /* Each net_iov covers 1 << niov_shift bytes. */
>         unsigned int niov_shift;
> +       /* CPU address of the first net_iov, or NULL if the CPU cannot re=
ad
> +        * the area.
> +        */
> +       void *vaddr;
>  };
>
>  static inline struct net_iov_area *net_iov_owner(const struct net_iov *n=
iov)
> @@ -119,6 +124,18 @@ static inline unsigned int net_iov_idx(const struct =
net_iov *niov)
>         return niov - net_iov_owner(niov)->niovs;
>  }
>
> +static inline void *net_iov_address(const struct net_iov *niov)
> +{
> +       const struct net_iov_area *area =3D net_iov_owner(niov);
> +       unsigned long off;
> +
> +       if (!area->vaddr)
> +               return NULL;
> +
> +       off =3D (unsigned long)net_iov_idx(niov) << area->niov_shift;
> +       return area->vaddr + off;
> +}
> +
>  /* Initialize a niov: stamp the owning area, the memory provider type.
>   */
>  static inline void net_iov_init(struct net_iov *niov,
> @@ -345,10 +362,16 @@ static inline void *__netmem_address(netmem_ref net=
mem)
>         return page_address(__netmem_to_page(netmem));
>  }
>
> +/**
> + * netmem_address - get the CPU address of the memory behind @netmem
> + * @netmem: netmem to get the address of
> + *
> + * Return: the address, or NULL if the CPU cannot read @netmem.
> + */
>  static inline void *netmem_address(netmem_ref netmem)
>  {
>         if (netmem_is_net_iov(netmem))
> -               return NULL;
> +               return net_iov_address(netmem_to_net_iov(netmem));
>
>         return __netmem_address(netmem);
>  }
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 1105bb9e3292..5ab7802ac4e1 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -368,7 +368,7 @@ static inline bool xdp_buff_add_frag(struct xdp_buff =
*xdp, netmem_ref netmem,
>
>         if (unlikely(netmem_is_pfmemalloc(netmem)))
>                 xdp_buff_set_frag_pfmemalloc(xdp);
> -       if (unlikely(netmem_is_net_iov(netmem)))
> +       if (unlikely(netmem_is_net_iov(netmem) && !netmem_address(netmem)=
))
>                 xdp_buff_set_frag_unreadable(xdp);
>
>         return true;
> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> index 71af2febe72a..c9c68d3b3712 100644
> --- a/net/xdp/Kconfig
> +++ b/net/xdp/Kconfig
> @@ -2,6 +2,7 @@
>  config XDP_SOCKETS
>         bool "XDP sockets"
>         depends on BPF_SYSCALL
> +       select PAGE_POOL
>         default n
>         help
>           XDP sockets allows a channel between XDP programs and
> diff --git a/net/xdp/Makefile b/net/xdp/Makefile
> index 30cdc4315f42..6e9d60f9f7f1 100644
> --- a/net/xdp/Makefile
> +++ b/net/xdp/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_XDP_SOCKETS) +=3D xsk.o xdp_umem.o xsk_queue.o xskmap.o
> -obj-$(CONFIG_XDP_SOCKETS) +=3D xsk_buff_pool.o
> +obj-$(CONFIG_XDP_SOCKETS) +=3D xsk_buff_pool.o xsk_pp.o
>  obj-$(CONFIG_XDP_SOCKETS_DIAG) +=3D xsk_diag.o
> diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
> index 7c811b5cce76..4dab7b9a1487 100644
> --- a/net/xdp/xsk.h
> +++ b/net/xdp/xsk.h
> @@ -34,6 +34,12 @@ static inline struct xdp_sock *xdp_sk(struct sock *sk)
>
>  void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
>                              struct xdp_sock __rcu **map_entry);
> +struct xsk_pp;

How about a header file instead of a forward declaration?

> +extern const struct memory_provider_ops xsk_pp_ops;
> +
> +struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool);
> +void xsk_pp_put(struct xsk_pp *pp);
>  void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
>  int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *po=
ol,
>                         u16 queue_id);
> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> new file mode 100644
> index 000000000000..fdd55265a6cd
> --- /dev/null
> +++ b/net/xdp/xsk_pp.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* AF_XDP UMEM as a page pool memory provider
> + *
> + * Each aligned UMEM chunk is a readable net_iov with one owner at a tim=
e:
> + *
> + *   userspace --FILL--> page pool --release--> reuse --alloc--> page po=
ol
> + *       ^                   |
> + *       +-----RX ring-------+
> + */
> +
> +#include <net/page_pool/helpers.h>
> +#include <net/page_pool/memory_provider.h>
> +#include <net/xdp_sock_drv.h>
> +
> +#include "xsk.h"
> +#include "xsk_queue.h"
> +
> +enum xsk_pp_chunk {
> +       XSK_PP_USER,    /* owned by userspace */
> +       XSK_PP_POOL,    /* owned by a page pool */
> +       XSK_PP_REUSE,   /* on the reuse stack */
> +};
> +
> +struct xsk_pp {
> +       struct net_iov_area area;
> +       struct xsk_buff_pool *pool;
> +       /* Protects fq, state and reuse */
> +       spinlock_t lock;
> +       struct xsk_queue *fq;
> +       refcount_t refs;
> +       u32 nr_pools;
> +       bool dma_need_sync;
> +       u8 *state;
> +       u32 reuse_cnt;
> +       u32 reuse[];

Is the reason that you have a reuse stack here and not use the one in
xsk_buff_pool that it only exists in unaligned mode, which you are not
supporting? Could you still use the "pre-calculated" heads in aligned
mode and link them up? There is already a xskb_list and free_list in
there that is used for that purpose. Just an idea that could cut down
the state and maybe the amount of code.

> +};
> +
> +static void xsk_pp_free(struct xsk_pp *pp)
> +{
> +       kvfree(pp->state);
> +       kvfree(pp->area.niovs);
> +       kvfree(pp);
> +}
> +
> +void xsk_pp_put(struct xsk_pp *pp)
> +{
> +       if (refcount_dec_and_test(&pp->refs))
> +               xsk_pp_free(pp);
> +}
> +
> +/* @pool must be DMA mapped and have aligned chunks. The provider must b=
e
> + * the only consumer of its FILL ring.
> + */
> +struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool)
> +{
> +       struct net_iov *niov;
> +       struct xsk_pp *pp;
> +       dma_addr_t dma;
> +       u32 i;
> +
> +       pp =3D kvzalloc_flex(*pp, reuse, pool->heads_cnt, GFP_KERNEL_ACCO=
UNT);
> +       if (!pp)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pp->area.niovs =3D kvzalloc_objs(*pp->area.niovs, pool->heads_cnt=
,
> +                                      GFP_KERNEL_ACCOUNT);
> +       pp->state =3D kvzalloc(pool->heads_cnt, GFP_KERNEL_ACCOUNT);
> +       if (!pp->area.niovs || !pp->state) {
> +               xsk_pp_free(pp);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       pp->area.num_niovs =3D pool->heads_cnt;
> +       pp->area.niov_shift =3D pool->chunk_shift;
> +       pp->area.vaddr =3D pool->addrs;
> +       pp->pool =3D pool;
> +       pp->fq =3D pool->fq;
> +       pp->dma_need_sync =3D dma_dev_need_sync(pool->dev);

Are you copying these for performance reasons, i.e. no extra pointer
dereference in the fast path? In the same manner as the pool copies
some information from the umem?

> +       spin_lock_init(&pp->lock);
> +       refcount_set(&pp->refs, 1);
> +
> +       for (i =3D 0; i < pp->area.num_niovs; i++) {
> +               niov =3D &pp->area.niovs[i];
> +               dma =3D xp_raw_get_dma(pool, (u64)i << pool->chunk_shift)=
;
> +               net_iov_init(niov, &pp->area, NET_IOV_XSK);
> +               if (net_mp_niov_set_dma_addr(niov, dma)) {
> +                       xsk_pp_free(pp);
> +                       return ERR_PTR(-ERANGE);
> +               }
> +       }
> +
> +       return pp;
> +}
> +
> +static int xsk_pp_init(struct page_pool *pool)
> +{
> +       struct xsk_pp *pp =3D pool->mp_priv;
> +
> +       if (pool->p.order || pool->p.dma_dir !=3D DMA_BIDIRECTIONAL ||
> +           pool->p.dev !=3D pp->pool->dev)
> +               return -EINVAL;
> +       if (pool->p.max_len > pp->pool->chunk_size ||
> +           pool->p.offset > pp->pool->chunk_size - pool->p.max_len)
> +               return -EINVAL;
> +
> +       refcount_inc(&pp->refs);
> +       spin_lock_bh(&pp->lock);
> +       pp->nr_pools++;

What is the difference between this counter and the refcount?

> +       spin_unlock_bh(&pp->lock);
> +       return 0;
> +}
> +
> +static void xsk_pp_destroy(struct page_pool *pool)
> +{
> +       struct xsk_pp *pp =3D pool->mp_priv;
> +
> +       spin_lock_bh(&pp->lock);
> +       pp->nr_pools--;
> +       spin_unlock_bh(&pp->lock);
> +       xsk_pp_put(pp);
> +}
> +
> +static bool xsk_pp_claim(struct xsk_pp *pp, u32 idx, enum xsk_pp_chunk f=
rom)
> +{
> +       lockdep_assert_held(&pp->lock);
> +
> +       if (pp->state[idx] !=3D from)
> +               return false;
> +
> +       pp->state[idx] =3D XSK_PP_POOL;
> +       return true;
> +}
> +
> +static u32 xsk_pp_alloc_reuse(struct xsk_pp *pp, netmem_ref *netmems, u3=
2 max)
> +{
> +       u32 idx, n =3D 0;
> +
> +       while (n < max && pp->reuse_cnt) {
> +               idx =3D pp->reuse[--pp->reuse_cnt];
> +               if (WARN_ON_ONCE(!xsk_pp_claim(pp, idx, XSK_PP_REUSE)))
> +                       continue;
> +               netmems[n++] =3D net_iov_to_netmem(&pp->area.niovs[idx]);
> +       }
> +
> +       return n;
> +}
> +
> +static u32 xsk_pp_alloc_fill(struct xsk_pp *pp, netmem_ref *netmems, u32=
 max)
> +{
> +       struct xsk_buff_pool *pool =3D pp->pool;
> +       struct xsk_queue *fq =3D pp->fq;
> +       u32 i, entries, cons, idx, n =3D 0;
> +       u64 addr;
> +
> +       if (!fq || !max)
> +               return 0;
> +
> +       entries =3D xskq_cons_nb_entries(fq, max);
> +       if (!entries) {
> +               fq->queue_empty_descs++;
> +               return 0;
> +       }
> +
> +       cons =3D fq->cached_cons;
> +       for (i =3D 0; i < entries; i++) {
> +               __xskq_cons_read_addr_unchecked(fq, cons++, &addr);
> +               addr &=3D pool->chunk_mask;
> +               idx =3D addr >> pp->area.niov_shift;
> +               if (unlikely(addr >=3D pool->addrs_cnt ||
> +                            !xsk_pp_claim(pp, idx, XSK_PP_USER))) {
> +                       fq->invalid_descs++;
> +                       continue;
> +               }
> +               netmems[n++] =3D net_iov_to_netmem(&pp->area.niovs[idx]);
> +       }
> +
> +       xskq_cons_release_n(fq, entries);
> +       __xskq_cons_release(fq);
> +       return n;
> +}
> +
> +static netmem_ref xsk_pp_alloc_netmems(struct page_pool *pool, gfp_t gfp=
)
> +{
> +       netmem_ref *netmems =3D pool->alloc.cache;
> +       struct xsk_pp *pp =3D pool->mp_priv;
> +       struct net_iov *niov;
> +       dma_addr_t dma;
> +       u32 i, n;
> +
> +       if (WARN_ON_ONCE(pool->alloc.count))

What has the driver writer or system done if this ever happens?

> +               return 0;
> +
> +       spin_lock_bh(&pp->lock);

For my understanding, what entities can call this function at the same
time? With the xsk_buff_pool we were protected by NAPI.


> +       n =3D xsk_pp_alloc_reuse(pp, netmems, PP_ALLOC_CACHE_REFILL);
> +       n +=3D xsk_pp_alloc_fill(pp, netmems + n, PP_ALLOC_CACHE_REFILL -=
 n);
> +       spin_unlock_bh(&pp->lock);
> +       if (!n)
> +               return 0;
> +
> +       for (i =3D 0; i < n; i++) {
> +               niov =3D netmem_to_net_iov(netmems[i]);
> +               dma =3D page_pool_get_dma_addr_netmem(netmems[i]);
> +               if (pp->dma_need_sync)
> +                       dma_sync_single_range_for_device(pool->p.dev, dma=
,
> +                                                        pool->p.offset,
> +                                                        pool->p.max_len,
> +                                                        pool->p.dma_dir)=
;
> +               net_mp_niov_set_page_pool(pool, niov);
> +       }
> +
> +       pool->alloc.count =3D n - 1;
> +       return netmems[n - 1];
> +}
> +
> +static bool xsk_pp_release_netmem(struct page_pool *pool, netmem_ref net=
mem)
> +{
> +       struct net_iov *niov =3D netmem_to_net_iov(netmem);
> +       struct xsk_pp *pp =3D pool->mp_priv;
> +       u32 idx =3D net_iov_idx(niov);
> +
> +       spin_lock_bh(&pp->lock);
> +       net_mp_niov_clear_page_pool(niov);
> +       if (!WARN_ON_ONCE(pp->state[idx] !=3D XSK_PP_POOL ||
> +                         pp->reuse_cnt =3D=3D pp->area.num_niovs)) {
> +               pp->state[idx] =3D XSK_PP_REUSE;
> +               pp->reuse[pp->reuse_cnt++] =3D idx;
> +       }
> +       spin_unlock_bh(&pp->lock);
> +
> +       return false;
> +}
> +
> +static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
> +                         struct netdev_rx_queue *rxq)
> +{
> +       return 0;
> +}
> +
> +const struct memory_provider_ops xsk_pp_ops =3D {
> +       .init           =3D xsk_pp_init,
> +       .destroy        =3D xsk_pp_destroy,
> +       .alloc_netmems  =3D xsk_pp_alloc_netmems,
> +       .release_netmem =3D xsk_pp_release_netmem,
> +       .nl_fill        =3D xsk_pp_nl_fill,
> +       .caps           =3D MP_CAP_READABLE,
> +};
> --
> 2.56.0
>
>
