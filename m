Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19DA30ACF6
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 04:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000815; cv=pass; b=aPE04mPq9RWxwHbB2i0lRbN4l/kDHyg0pNKIHjl52KBxDMwqnoYvIveOqgACP7mf1kzqB43ft1wPx1b+MKdzkqgVg+9a4HhppUM6ZEaPW6U0DFzzI7jCi5paNifvK8sHAuOTEUIP7pp4FJ3Vj1azKuYPE0qUAWRJdQKZ0rWRgwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000815; c=relaxed/simple;
	bh=ArJIYT9PS952osYm0s+crb1tdeWCEb92/lCBjMz6BG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzjuVEqVHrPwhnDa9AQsZtPEANtmm5uxkJTeYE6ft9SIPHJR79qc55vHiqsF57c15GG3aq0vK9WF2nM5p2hZhVDY7OZl4nl6CS7C1eUkqBxPNADd9HmtV/JROtM8qHjTbOpB/UXe4u0OHMw9FDqCdft0hbYnet/81uDfKQkHG+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shQnxRoX; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shQnxRoX"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2321a12.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 21:13:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791000812; cv=none;
        d=google.com; s=arc-20260327;
        b=GESfLCcFejKzhPdwAmqwOrPnGUPa6D28z2vr2p7LgZ/ju7Jd6vu1mkwASlAeUSAwgU
         Mc/ux/Dw4M8MMYwPaC/fQbMaPSbB4I6IHQp7VJwcmPu+10qaXYUDljhrV4Okq3zc8EIp
         7ikAE9mHOGpYFQn2j6NC4musWxogkYuGiw1Q+lomF4UKgmEaP3PcvmZXzsIv25hPv1Ru
         390HM/qeTDt4LYSY7Tp3/OB4MC6MmSEx2scaKd7N8WcSkqRHeFK9x61wJCcKD2AbzJRC
         MMtVmHdAxzyRlVWAOHf2jUPNLnPhfQtiWDYFU+E2UI65ghqsgpkECxGQZ5oGJmDvd+yx
         3Hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Ie5QAjzsQT8aGFssdYiQrgQZPfEPZ2/bR922KyiVM8=;
        fh=4DPRMXtRYJaBwUabS6dkFOwtKbu9R1YCFvppVA5f+v4=;
        b=psWjoNTXPUGCvoHO2ClT1WeSVncHeuD6gcMLYswPbvIOP/JASQxkoumic9yEGoooEJ
         hALww0d/4gUz9DFDRiQMRUd7vSHzC6Ro63ViQfXxZHfJdIjtrb9BBLdi6+UgK1wDRr6J
         R6qw2vGuUEUtxe/JxAssQmXJYY0ktOfKtNSdYhALjPskUutS8760GaGIpl0Onq4iMYqX
         l5WGcMHu26DjmiUWlhe4r24oTmaTg92poY55lopu1DR4d9PQh+jQzxIZNkvnGys5y/Dv
         jBKLjivp7lzpg/ibV/a8Ra0ywlRWqdJeU3vnJyFxdmcQ/5oKH2Fs3DZHxO9GNEyO4MJv
         2ZMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791000812; x=1791605612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Ie5QAjzsQT8aGFssdYiQrgQZPfEPZ2/bR922KyiVM8=;
        b=shQnxRoXH2dmQqkBLrlD5CKlQJekPeX86ZCEFtTl38hMtrpzYcriwrNQ2pK1PFRbdS
         NllKZajqTI2FuqNae5t7HQIjRAM/dL9Da0XQfOAggs7t2lRELoyUwipMpERyBBTv46a5
         PgUUY92L31Q4bSJ2VVbwRC67WxcCqArkezABJEEHT64FfGTHC7Cr0NT3hhY4dOkHzzVr
         6N1iF/vMFkgN8YJFGWPmS/tKNLN+lSM3MWkTK2JUUg35Kxybnnoi3ggJoj7Z/1C6pX85
         e0Oh19++bH+vidtL0vj5nu3trb1FJ3AzpKNA7i+PyMENXM/FgpUiBVL3eHyM6SRGeMGq
         VoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791000812; x=1791605612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Ie5QAjzsQT8aGFssdYiQrgQZPfEPZ2/bR922KyiVM8=;
        b=1eNXHMJ8Lt3FzF3M+d+KsSCV4RPEccTE9gxkMq5F7pGhNtJP8DTOcQsrPLd89ntNMB
         YcxTWww/ovNmpsdkw4xMuQfvqGb6WSR659Gh7Zy5fm+TRxHvnLbfnBZT6icOTRH/mB1Y
         3LmeoTVCJIcqkbfKEkeNKNw9TBcytefdmQMjq9xOImppcG50QkLSrKINm68GbIeVJCak
         l1o2HBA+Y2qNxLO76Hgl+AbNMd+OFsykwRQ7yvd0H0dUQQICb2eb56lzsH3UCkNtsSn5
         1XYg7qILTIcNSTW5yIvWiTf6YcOhzTg8iMF0cmK6dQu3shfYzZdww9IC0iP3YS8ZvGO8
         0jDA==
X-Forwarded-Encrypted: i=1; AKwUvBzVJsf+fuwvMOYdOn6zetBbPq0lNCsuVory9vVwandcTHxN58Ukx/GJBsUgOfR7SeoYQIQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvxMXpvlBolr0tla1DphzLY8FU0jxB8tKE7FZkkIfigKk1E/l0
	AB5d8Z6GgcPI5eXbe8K19TD0MAL0o1vAYr8gnrKBek79K27lkfxkFMg4gm8lyqNOWKeC62NLM2D
	hmEab6F0sKK4E+KI66zZ+vWUFSrcDvRDxuC0O4bAm
X-Gm-Gg: AYBFou28y7HvkLDoHcDs+iwCEdFeWmTcMNKkwWRriw1RUzzKiMqtNM0N0JVKoX/8jYQ
	T/V1O4J1ofGAPg99/6H7ayITZeQ7ilnoo2+Z0yaRNsDCUvRV7v4fyWIOkBJ82AMsYGbtNi2n92J
	xYoyAte6DLG02zaEjCOmQiOPkgA1YobhdzNCRnPtBwKDn2GLDPO9nteoqToF5wocV3LJgVdBima
	b8ekHPsd6yi9tm/CAeVg7X9MTSM7776DsaZaI01AaD4m4QueQkeo7UIPjMPrXCrKZmVWaIPMYZe
	oSfo6zmbL6l6uFNxwmHAgLC1iXpFtiStjWfMg9k7u1elS5QDy7L8
X-Received: by 2002:aa7:d30f:0:b0:6ac:84a2:bdc7 with SMTP id
 4fb4d7f45d1cf-6afaf6af058mr13377a12.15.1791000810925; Fri, 02 Oct 2026
 21:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002190018.696925-1-bjorn@kernel.org> <20261002190018.696925-4-bjorn@kernel.org>
In-Reply-To: <20261002190018.696925-4-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 2 Oct 2026 21:13:19 -0700
X-Gm-Features: AclHuK9Gl9KMFgKRjsYy_SiHECkATkLonjp_0BvZEfQ5Bsd2sOFca7-m1cK4pXA
Message-ID: <CAHS8izP1vXB9ro7coamL7MUvTJu0kWzej71T2o5y_GYpJzFB+w@mail.gmail.com>
Subject: Re: [RFC net-next 03/15] net: Add memory provider capabilities
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Luigi Rizzo <lrizzo@google.com>
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
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 12:01=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> The current memory providers, devmem and io_uring zero-copy RX, give
> memory that the CPU cannot read. The core allows them only on queues
> with header-data split on, a zero header-split threshold, and no XDP
> program. AF_XDP needs a provider that the CPU can read and that
> works with XDP.
>
> Add a capability field to the provider operations, with
> MP_CAP_READABLE as the first flag. Apply the header-split and XDP
> rules only to providers without it. A queue with an AF_XDP buffer
> pool still rejects other providers, but it accepts the provider made
> from that same pool.
>
> Provider memory can become free while a queue is restarted, and no
> device event reports it. After a restart, and after a failed restart
> is rolled back, schedule the queue's NAPI if the queue has a
> provider, so the driver tries to refill.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> ---
>  Documentation/networking/netmem.rst     |  7 ++-
>  include/net/page_pool/memory_provider.h | 11 +++++
>  include/net/page_pool/types.h           |  7 +--
>  net/core/dev.c                          |  4 +-
>  net/core/netdev_rx_queue.c              | 57 ++++++++++++++++++++-----
>  net/ethtool/rings.c                     | 18 +++-----
>  net/xdp/xsk_buff_pool.c                 |  3 +-
>  7 files changed, 78 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/networking/netmem.rst b/Documentation/networki=
ng/netmem.rst
> index 217869d1108d..aacd185843ac 100644
> --- a/Documentation/networking/netmem.rst
> +++ b/Documentation/networking/netmem.rst
> @@ -48,8 +48,11 @@ Driver RX Requirements
>     - PP_FLAG_DMA_SYNC_DEV: netmem dma addr is not necessarily dma-syncab=
le
>       by the driver. The driver must delegate the dma syncing to the page=
_pool,
>       which knows when dma-syncing is (or is not) appropriate.
> -   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. The driver must specify this flag =
iff
> -     tcp-data-split is enabled.
> +   - PP_FLAG_ALLOW_UNREADABLE_NETMEM. This opts the page pool into the m=
emory
> +     provider configured on its RX queue. For a provider without
> +     MP_CAP_READABLE, the driver must specify it only for a payload pool
> +     with tcp-data-split enabled. A readable provider may also back a
> +     regular or header pool.

I kinda don't like this doc update. This flag was never meant to say
'I support memory providers'. It's just that the existing memory
providers are all unreadable so support-unreadable (headersplit) =3D=3D
supports-memory-providers.

The code should be updated such that if the memory provider is
!MP_CAP_READABLE and driver doesn't support
PP_FLAG_ALLOW_UNReADABLE_NETMEM, fail.

If another limitation applies to the new provider, add it as a
separate flag. The doc is accurate as-is I think.

>
>  5. The driver must not assume the netmem is readable and/or backed by pa=
ges.
>     The netmem returned by the page_pool may be unreadable, in which case
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_p=
ool/memory_provider.h
> index 255ce4cfd975..d18ec079ffe2 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -9,6 +9,15 @@ struct netdev_rx_queue;
>  struct netlink_ext_ack;
>  struct sk_buff;
>
> +/**
> + * enum mp_caps - memory provider capabilities
> + * @MP_CAP_READABLE: The CPU can access provider buffers. They may back
> + *     header and regular page pools, and XDP programs may run on them.
> + */
> +enum mp_caps {
> +       MP_CAP_READABLE         =3D BIT(0),
> +};
> +
>  struct memory_provider_ops {
>         netmem_ref (*alloc_netmems)(struct page_pool *pool, gfp_t gfp);
>         bool (*release_netmem)(struct page_pool *pool, netmem_ref netmem)=
;
> @@ -17,11 +26,13 @@ struct memory_provider_ops {
>         int (*nl_fill)(void *mp_priv, struct sk_buff *rsp,
>                        struct netdev_rx_queue *rxq);
>         void (*uninstall)(void *mp_priv, struct netdev_rx_queue *rxq);
> +       u32 caps;
>  };
>
>  bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
>  void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *n=
iov);
>  void net_mp_niov_clear_page_pool(struct net_iov *niov);
> +bool netif_mp_lacks_cap(struct net_device *dev, u32 cap);
>
>  int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>                       const struct pp_memory_provider_params *p,
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 03da138722f5..a96376613dda 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -22,9 +22,10 @@
>                                         */
>  #define PP_FLAG_SYSTEM_POOL    BIT(2) /* Global system page_pool */
>
> -/* Allow unreadable (net_iov backed) netmem in this page_pool. Drivers s=
etting
> - * this must be able to support unreadable netmem, where netmem_address(=
) would
> - * return NULL. This flag should not be set for header page_pools.
> +/* Allow memory-provider (net_iov backed) netmem in this page_pool. Driv=
ers

Comment is slightly inaccurate. It implies memory-providers can
only-even be net_iov backed. There is nothing wrong with a memory
provider returning page-backed-netmems. Mke it something like:

Allow unreadable memory-providers in this page_pool. Drivers that
support this must support unreadable netmem...

Have your pet LLM please go over the code for any instances in the
code/comments where we assumed net_iov =3D=3D unreadable and fix those
with checks.

Here are the places my pet LLM thinks you missed:

  ### Handled by the Series

  =E2=80=A2 netmem_address(): Returns net_iov_address() instead of NULL for
readable net_iovs.
  =E2=80=A2 page_pool_is_unreadable() & netif_rxq_has_unreadable_mp(): Chec=
k
!(ops->caps & MP_CAP_READABLE).
  =E2=80=A2 xdp_buff_add_frag(): Only sets XDP_FLAGS_FRAGS_UNREADABLE when
!net_iov_is_readable(niov).

  ### Missed by the Series (Feedback to Add)

  1. xdp_build_skb_from_buff() (page head + readable net_iov frags):
Only checks xdp_buff_has_netmem(xdp) (head buffer), and
xdp_buff_add_frag() no longer sets XDP_FLAGS_FRAGS_UNREADABLE for
readable net_iovs.
  A packet with a page-backed head and NET_IOV_XSK frags won't be
copied and will leak NET_IOV_XSK into an skb with skb->unreadable =3D 0.
  2. skb_frag_address() & skb_frag_address_safe(): Still return NULL
if !skb_frag_page(frag). Patch 11 added a duplicate xdp_frag_address()
for 6 call sites, leaving other XDP frag readers (bpf_test_finish(),
  driver multi-buffer XDP_TX like mlx5e_xdp_mpwqe_add_dseg()) broken.
skb_frag_address() itself should use netmem_address().
  3. __skb_fill_netmem_desc() & skb_dump(): Still treat all net_iovs
as unreadable (skb->unreadable =3D true). Also, drivers that build skbs
via skb_add_rx_frag_netmem() when !xdp_prog will attach NET_IOV_XSK
  directly to skbs (which __get_netmem()` / `__put_netmem() don't refcount)=
.
  4. bnxt & bnge need_head_pool: Set rxr->need_head_pool =3D
page_pool_is_unreadable(pool) to decide whether head_pool needs a
separate struct page pool, then call page-only page_pool_alloc_frag()
and
  page_pool_free_va() on head_pool. Returning false from
page_pool_is_unreadable() breaks them.
  5. Drivers checking netmem_is_net_iov() as "unreadable":
      =E2=80=A2 gve_rx_dqo.c:892, 953: Uses netmem_is_net_iov() to drop
unsplit headers and skip copybreak; should check !netmem_address().
      =E2=80=A2 en_rx.c:2282-2286: Uses netmem_is_net_iov() to drop unsplit
headers; should check !netmem_address().
      =E2=80=A2 en_main.c:5694-5705: Uses netif_rxq_has_unreadable_mp() to
validate custom page size; should be netif_rxq_has_mp().
      =E2=80=A2 idpf_txrx.c:3470-3479: Uses netmem_is_net_iov() and
__netmem_to_page() in idpf_rx_hsplit_wa(); should use
netmem_address().
  6. Stale comments/docs:
      =E2=80=A2 netmem.h:73-83: Comment on struct net_iov still says it is
only for non-struct page memory and fixed PAGE_SIZE chunks.
      =E2=80=A2 netmem.rst:27 & types.h:32: Still state tcp-data-split is
unconditionally required and keep the PP_FLAG_ALLOW_UNREADABLE_NETMEM
name for readable providers.

> + * setting this must honor the provider's capabilities. Unless the provi=
der has
> + * MP_CAP_READABLE, netmem_address() returns NULL, and the flag must not=
 be set
> + * for a header page_pool.
>   *

That bit about header page_pool is good to add anyway.

>   * If the driver sets PP_FLAG_ALLOW_UNREADABLE_NETMEM, it should also se=
t
>   * page_pool_params.slow.queue_idx.
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5ac08da8b9d7..12b532c09a9c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10423,7 +10423,7 @@ int netif_xdp_propagate(struct net_device *dev, s=
truct netdev_bpf *bpf)
>                 return -EBUSY;
>         }
>
> -       if (dev_get_min_mp_channel_count(dev)) {
> +       if (netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {

Could use a name easier to read?

if (!netif_all_mps_have_cap())

>                 NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to d=
evice using memory provider");

...using unreadable memory provider");

>                 return -EBUSY;
>         }
> @@ -10499,7 +10499,7 @@ static int dev_xdp_install(struct net_device *dev=
, enum bpf_xdp_mode mode,
>                 return -EBUSY;
>         }
>
> -       if (dev_get_min_mp_channel_count(dev)) {
> +       if (netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
>                 NL_SET_ERR_MSG(extack, "unable to install XDP to device u=
sing memory provider");

Same.

>                 return -EBUSY;
>         }
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 00a7011eb4d5..610e31d1a717 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -82,8 +82,12 @@ __netif_get_rx_queue_lease(struct net_device **dev, un=
signed int *rxq_idx,
>  /* See also page_pool_is_unreadable() */
>  bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rx=
q_idx)
>  {
> -       if (rxq_idx < dev->real_num_rx_queues)
> -               return __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_o=
ps;
> +       const struct memory_provider_ops *ops;
> +
> +       if (rxq_idx < dev->real_num_rx_queues) {
> +               ops =3D __netif_get_rx_queue(dev, rxq_idx)->mp_params.mp_=
ops;
> +               return ops && !(ops->caps & MP_CAP_READABLE);
> +       }

handle error case inside if() block please.

>         return false;
>  }
>  EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
> @@ -95,6 +99,32 @@ bool netif_rxq_has_mp(struct net_device *dev, unsigned=
 int rxq_idx)
>         return false;
>  }
>
> +/* Return true if an installed memory provider lacks @cap. */
> +bool netif_mp_lacks_cap(struct net_device *dev, u32 cap)
> +{
> +       const struct memory_provider_ops *ops;
> +       int i;
> +
> +       netdev_assert_locked_ops_compat(dev);
> +
> +       for (i =3D dev->real_num_rx_queues - 1; i >=3D 0; i--) {
> +               ops =3D dev->_rx[i].mp_params.mp_ops;
> +               if (ops && (ops->caps & cap) !=3D cap)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +/* Provider memory may become available while the queue is replaced,
> + * without a device event to report it.
> + */
> +static void netdev_rx_queue_kick(struct netdev_rx_queue *rxq)
> +{
> +       if (rxq->mp_params.mp_ops && rxq->napi)
> +               napi_schedule(rxq->napi);
> +}
> +


Honestly maybe open code this at the call site. It's confusing to have
a hepler that doesn't mention mp only do something if the rx queue has
an mp configured. Or maybe netdev_mp_rx_queue_kick().

>  static int netdev_rx_queue_reconfig(struct net_device *dev,
>                                     unsigned int rxq_idx,
>                                     struct netdev_queue_config *qcfg_old,
> @@ -142,6 +172,8 @@ static int netdev_rx_queue_reconfig(struct net_device=
 *dev,
>         }
>
>         qops->ndo_queue_mem_free(dev, old_mem);
> +       if (netif_running(dev))
> +               netdev_rx_queue_kick(rxq);
>
>         kvfree(old_mem);
>         kvfree(new_mem);
> @@ -165,6 +197,11 @@ static int netdev_rx_queue_reconfig(struct net_devic=
e *dev,
>
>  err_free_new_queue_mem:
>         qops->ndo_queue_mem_free(dev, new_mem);
> +       /* Freeing the replacement can hand provider memory back to the o=
ld
> +        * queue, which still runs unless the rollback failed.
> +        */
> +       if (err !=3D -ENETDOWN && netif_running(dev))
> +               netdev_rx_queue_kick(rxq);

These kicks feel extremely error prone and hard to point where in the
code we missed a necessary kick. Try to find something better to do.

>
>  err_free_old_mem:
>         kvfree(old_mem);
> @@ -189,6 +226,7 @@ static int __netif_mp_open_rxq(struct net_device *dev=
, unsigned int rxq_idx,
>                                struct netlink_ext_ack *extack)
>  {
>         const struct netdev_queue_mgmt_ops *qops =3D dev->queue_mgmt_ops;
> +       u32 caps =3D p->mp_ops->caps;
>         struct netdev_queue_config qcfg[2];
>         struct netdev_rx_queue *rxq;
>         int ret;
> @@ -196,15 +234,13 @@ static int __netif_mp_open_rxq(struct net_device *d=
ev, unsigned int rxq_idx,
>         if (!qops)
>                 return -EOPNOTSUPP;
>
> -       if (dev->cfg->hds_config !=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
> -               NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
> +       if ((dev->cfg->hds_config !=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
> +            dev->cfg->hds_thresh) && !(caps & MP_CAP_READABLE)) {

nit: This could use a helper mp_caps_readable() or something.

> +               NL_SET_ERR_MSG(extack,
> +                              "memory provider does not support current =
tcp-data-split configuration");
>                 return -EINVAL;
>         }
> -       if (dev->cfg->hds_thresh) {
> -               NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
> -               return -EINVAL;
> -       }
> -       if (dev_xdp_prog_count(dev)) {
> +       if (dev_xdp_prog_count(dev) && !(caps & MP_CAP_READABLE)) {
>                 NL_SET_ERR_MSG(extack, "unable to custom memory provider =
to device with XDP program attached");

unable to use unreadable memory provider with XDP program attached maybe.

>                 return -EEXIST;
>         }
> @@ -219,7 +255,8 @@ static int __netif_mp_open_rxq(struct net_device *dev=
, unsigned int rxq_idx,
>                 return -EEXIST;
>         }
>  #ifdef CONFIG_XDP_SOCKETS
> -       if (rxq->pool) {
> +       /* An AF_XDP pool owns the queue unless it is this provider. */
> +       if (rxq->pool && rxq->pool !=3D p->mp_priv) {
>                 NL_SET_ERR_MSG(extack, "designated queue already in use b=
y AF_XDP");
>                 return -EBUSY;
>         }
> diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
> index e3810c0320e3..789d0e328b77 100644
> --- a/net/ethtool/rings.c
> +++ b/net/ethtool/rings.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>
>  #include <net/netdev_queues.h>
> +#include <net/page_pool/memory_provider.h>
>
>  #include "common.h"
>  #include "netlink.h"
> @@ -258,17 +259,12 @@ ethnl_set_rings(struct ethnl_req_info *req_info, st=
ruct genl_info *info)
>                 return -EINVAL;
>         }
>
> -       if (dev_get_min_mp_channel_count(dev)) {
> -               if (kernel_ringparam.tcp_data_split !=3D
> -                   ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
> -                       NL_SET_ERR_MSG(info->extack,
> -                                      "can't disable tcp-data-split whil=
e device has memory provider enabled");
> -                       return -EINVAL;
> -               } else if (kernel_ringparam.hds_thresh) {
> -                       NL_SET_ERR_MSG(info->extack,
> -                                      "can't set non-zero hds_thresh whi=
le device is memory provider enabled");
> -                       return -EINVAL;
> -               }
> +       if ((kernel_ringparam.tcp_data_split !=3D
> +            ETHTOOL_TCP_DATA_SPLIT_ENABLED || kernel_ringparam.hds_thres=
h) &&
> +           netif_mp_lacks_cap(dev, MP_CAP_READABLE)) {
> +               NL_SET_ERR_MSG(info->extack,
> +                              "memory provider does not support requeste=
d tcp-data-split configuration");
> +               return -EINVAL;
>         }
>
>         /* ensure new ring parameters are within limits */
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 9d2d94f1fb75..f01e1de7360e 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -2,6 +2,7 @@
>
>  #include <linux/netdevice.h>
>  #include <net/netdev_lock.h>
> +#include <net/page_pool/memory_provider.h>
>  #include <net/xsk_buff_pool.h>
>  #include <net/xdp_sock.h>
>  #include <net/xdp_sock_drv.h>
> @@ -235,7 +236,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
>                 goto err_unreg_pool;
>         }
>
> -       if (dev_get_min_mp_channel_count(netdev)) {
> +       if (netif_mp_lacks_cap(netdev, MP_CAP_READABLE)) {
>                 err =3D -EBUSY;
>                 goto err_unreg_pool;
>         }
> --
> 2.55.0
>


--=20
Thanks,
Mina
