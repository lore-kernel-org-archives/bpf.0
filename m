Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054294457C5
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784745840; cv=pass; b=QJPXEtqWbGg7PMOyehgSb+NJfa+drPDOkgVm3qvO9v1mYGAe3VMS5qPiffbDENVf4bHcBz6KzJHWW8Rvz/Bo9CoUuCkVHdbYTMJTJVKZ0RjDshTWC2k8MxiQzvS25HrAXgxMdwCzLoLeIfvSnKcCYaT/7acc48lM17uoUQDTbI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784745840; c=relaxed/simple;
	bh=sWuC7RcEfO2bBvVxTAgFyctvDw7VaGC57NMExonBeIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hn2Clv1b+Pwm8RMA0BI0cEk+JnOAJjBQDv6YGYM1hHmMFULVGUrI3cmYs2rvHSL+NIzvzGafquxFBHTVVEjRBBXzIttQ02pD97KdDH5daO8dziPf26q6ewarb0dSOp4Ovf804HThulzR8dBmr3aSj/5guYR0xXRcsoJ/nMXklQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UmRbC7+9; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UmRbC7+9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccdf36f63dso11665ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784745837; cv=none;
        d=google.com; s=arc-20260327;
        b=lJUCiZ8HIW88S11K5lV4ucmP8TBkmNR8amOLIJquh+pgTMBD5pFGriqKreNcKOUX70
         QHuVSDZBfTE5Otb9wmG35fyo1hKy0J9ZBt3QJd3Lnt7xc/V0mFQdlUWpLOZwDMyn80eg
         TRcfwvq7UI5H8sLwJSt538mViuGSCkE+rgZXoFQdwSLvR/WK+M9byR1ERIAsdm3DPPTd
         o9DzFYe+UK8a+6/9xw98aZRm0DAbXxlyKBb4K5UiHK1IFmpsXWhcRfHD9GxGDIAHjlPB
         bV08LprPUCRQLGby5opqNsFqVltGX02t7FDD4YpMUsGAV/tYvHfVuvQT2gXW4961Ri/x
         zLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SwB+xCH1z9pWiUIqElqZkFZUWVe28VGLc6W9xbc0aqw=;
        fh=xBR2NEI9DholcM/8opscoKRZURKtwaQEaqtxAANvH7k=;
        b=nncZ8QBKxH5C9hyCJAKyQJYTNX9nZ2UnD4Vx2l2IrpEMR4/5mdEL4O14XgM0F8kpI3
         LdfpZqW8KRHxcWL6TG3hKJbLqSGzFuYDCzUPYm4J1aVVcdfCiZew3fKRcoxV7u1acnYa
         hfwJPCUoTUnkkZq1DlI3CbnJoxL3Q2vBZvG84mahKj0kPDGDEvFFxn+O3hZWQNifrP+C
         A5egk37IMmmyyydVY/YLd7/dgeweVNLRTixh5M5kAZNo86z46kuqXEVU+L8JiHVQkicE
         hYDm3HqCxPNFD2S81BKAN5BIROrj6Cl0orl5uI9qrz7Jm5Os5+CDwIlT6dF4niGnXJS2
         0ihg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784745837; x=1785350637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SwB+xCH1z9pWiUIqElqZkFZUWVe28VGLc6W9xbc0aqw=;
        b=UmRbC7+9NFnly+w1RCN0orn0AGZKMB/gHH/D/+kP1vcInPN404mNadMYnSAZTVJ65z
         IWITk4ch6zjCQ+SOdwQxMCZfHZvtKS/sjxNRHSA5YdI7hgKposLgoeLLSiHPfaSnzFoJ
         QAIdXT6THdRcAeuk9AZxsfRtE2K7mJi0LOAfRDKzEUVGtJsnJuA6v2l0wR1ALzyC99SL
         3YPZNXPFX+AhweqQwLvobOx7tPLUtb4nLgAkIZDGC2KPrSczV5a2dTWYxRo9i2UAc5Ah
         k7T7UjhO/51o2RFpqgEvE+6CzwYil8RfDYHWWMEmm7aSYVgJBoTk9QCGYCfUXO4hJtVt
         MWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784745837; x=1785350637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SwB+xCH1z9pWiUIqElqZkFZUWVe28VGLc6W9xbc0aqw=;
        b=gzbzB0n18Di9LEaIq91Lu3I2cQwe+Nw8XqwGooglNez8Cf8vxt5xu0NUpriQ4DfphW
         Z4qet63R9XRA9rOpXA7ChVhWVTbI44uwZf7SBdBjA662RQ6PFdu7vgu3SQbS7ntiShcK
         yONz/kgmlGV3m0MOkKnOCxvS0coVEOaig9yzPyt8+MRghrS04Vcxkc5Mj81X1DgdFwn8
         gvLyefh0ABAtzNqdA+yrx7pY89KSvbWbky5i5sbbCZGRIXY8SGes0aClUAjcDBHe49tj
         tt6OuJUlw8GDLyu3GJNfV9TRoNmpMIhnr7xHLciWXLyMeoWxn2ihbD2PHwwk7VyCpGb2
         QkbA==
X-Forwarded-Encrypted: i=1; AHgh+RrHpwrxlQQb7rlYEQpExWT5KQrPyH0A015zdwOSbVy/JQ3phGBBkf7sCMDm36MslGB1p94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGxGocCpHAPb84AFcCyo9VM/3poIUZ8dGVbUtoKEwe91SnNxn
	giUtxON4iwRmu2KgwvqqShNiXhFgQko0v8qSQ45v9d+hSWFHQ4ClN0Om9SWpQjn8X9Kv/NN+Q+y
	Bnpx959UUIRzIeB5tAB95sL87Mzdx4MdZeQ4SPZO7
X-Gm-Gg: AR+sD13DrcGigjzQLpMdNzCcc0hPxt3PZXi5UEuWuxZQBdzWnULMgi+TfdSFTcgOmq3
	4t3IY0YIlikroR1xBY8zMQOO/MvIF4ZJ3kWGafFDGhF6mSe6CjxRZn+pTE1N5MeKKiP2ACrd/uC
	ScFjQ4nd5CsBmskRE1Kews7hIfeWBgI9omO1MbsZqgASfX+uC98go0Hu7horjuONz3/Ik9Ww01h
	Qkfa0eb89a5LpGrJ5/gj5RCqhBmtwjE0E530dW2TrQf2L5Fk7Sa6RUxVk1jW0xb3EtFx5jldbO1
	uJH65/pgF+50foUU
X-Received: by 2002:a17:902:e544:b0:2ca:4bb4:4bd with SMTP id
 d9443c01a7336-2cfa54a8b89mr658905ad.5.1784745836571; Wed, 22 Jul 2026
 11:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com> <tencent_164779DC8B18AB10B9C636BE23C178ED5907@qq.com>
In-Reply-To: <tencent_164779DC8B18AB10B9C636BE23C178ED5907@qq.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 22 Jul 2026 11:43:44 -0700
X-Gm-Features: AUfX_mw5UAwzkJ7NPvu44HLKSHoX9nB5Y5w52d1GXfqklxyWXm6Ky8JWEjQRdEE
Message-ID: <CAHS8izPPAC7CvRw+eRvMND96NduMjEFMhGFOBrbs8JzbtWXg_g@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: atlantic: convert RX path to page_pool
To: Yangyu Chen <cyy@cyyself.name>
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 10:42=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> The driver currently allocates RX buffers with dev_alloc_pages(), maps
> them with dma_map_page(), and uses a hand-rolled page-flip scheme to
> subdivide high-order pages. Behind an IOMMU, the map/unmap churn is a
> major RX cost: on a Thunderbolt-attached QNAP QNA-T310G1S, iperf3 -R
> over IPv6 tops out at about 2.2 Gbit/s over MTU 1500.
>
> Convert RX buffers to page_pool fragments. Pages are DMA-mapped once
> when entering the pool and recycled through the stack or XDP via the
> MEM_TYPE_PAGE_POOL memory model. This removes the custom page-flip
> accounting, lets page_pool handle fragment reuse, and ensures every RX
> path either keeps the ring's fragment reference for reposting or hands
> it to the skb/xdp_buff for later recycling.
>
> Register the PTP RX ring's xdp_rxq as well, since it shares the RX
> clean paths. Walk the full RX ring during deinit so consumed but not yet
> refilled slots cannot leak page-pool references. Drop the ethtool
> PageFlips/PageReuses/PageFrees counters which only described the old
> scheme.
>
> On the QNA-T310G1S, MTU 1500, TCP over IPv6, iperf3 -R improves from
> 2.24 Gbit/s to 9.14 Gbit/s. The module was also smoke-tested with native
> XDP PASS, DROP, and ABORTED actions; carrier recovered after each
> attach/detach cycle and dmesg showed no page_pool/DMA warnings.
>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---
>  drivers/net/ethernet/aquantia/Kconfig         |   1 +
>  .../ethernet/aquantia/atlantic/aq_ethtool.c   |   3 -
>  .../net/ethernet/aquantia/atlantic/aq_ptp.c   |  20 +-
>  .../net/ethernet/aquantia/atlantic/aq_ring.c  | 238 ++++++++----------
>  .../net/ethernet/aquantia/atlantic/aq_ring.h  |   6 +-
>  .../net/ethernet/aquantia/atlantic/aq_vec.c   |  15 +-
>  6 files changed, 140 insertions(+), 143 deletions(-)
>
> diff --git a/drivers/net/ethernet/aquantia/Kconfig b/drivers/net/ethernet=
/aquantia/Kconfig
> index cec2018c84a9..c8fb7b33e5b7 100644
> --- a/drivers/net/ethernet/aquantia/Kconfig
> +++ b/drivers/net/ethernet/aquantia/Kconfig
> @@ -20,6 +20,7 @@ config AQTION
>         tristate "aQuantia AQtion(tm) Support"
>         depends on PCI
>         depends on MACSEC || MACSEC=3Dn
> +       select PAGE_POOL
>         help
>           This enables the support for the aQuantia AQtion(tm) Ethernet c=
ard.
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/driver=
s/net/ethernet/aquantia/atlantic/aq_ethtool.c
> index 420af958d486..0f5125bd2315 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> @@ -100,9 +100,6 @@ static const char * const aq_ethtool_queue_rx_stat_na=
mes[] =3D {
>         "%sQueue[%d] AllocFails",
>         "%sQueue[%d] SkbAllocFails",
>         "%sQueue[%d] Polls",
> -       "%sQueue[%d] PageFlips",
> -       "%sQueue[%d] PageReuses",
> -       "%sQueue[%d] PageFrees",
>         "%sQueue[%d] XdpAbort",
>         "%sQueue[%d] XdpDrop",
>         "%sQueue[%d] XdpPass",
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_ptp.c
> index 558ac9237f75..5b8a4d0d1cff 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> @@ -13,6 +13,7 @@
>  #include <linux/ptp_classify.h>
>  #include <linux/interrupt.h>
>  #include <linux/clocksource.h>
> +#include <net/xdp.h>
>
>  #include "aq_nic.h"
>  #include "aq_ptp.h"
> @@ -1192,12 +1193,25 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
>         if (err)
>                 goto err_exit_ptp_tx;
>
> +       err =3D xdp_rxq_info_reg(&aq_ptp->ptp_rx.xdp_rxq, aq_nic->ndev,
> +                              rx_ring_idx, aq_ptp->napi.napi_id);
> +       if (err < 0)
> +               goto err_exit_ptp_rx;
> +
> +       err =3D xdp_rxq_info_reg_mem_model(&aq_ptp->ptp_rx.xdp_rxq,
> +                                        MEM_TYPE_PAGE_POOL,
> +                                        aq_ptp->ptp_rx.pg_pool);
> +       if (err < 0) {
> +               xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
> +               goto err_exit_ptp_rx;

Why do it like this? Why not goto err_exit_xdp_rxq; which will do the
same thing?

> +       }
> +
>         if (aq_ptp->a1_ptp) {
>                 err =3D aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, P=
TP_HWST_RING_IDX,
>                                             aq_nic->aq_nic_cfg.rxds,
>                                             aq_nic->aq_nic_cfg.aq_hw_caps=
->rxd_size);
>                 if (err)
> -                       goto err_exit_ptp_rx;
> +                       goto err_exit_xdp_rxq;
>         }
>
>         err =3D aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cf=
g.rxds);
> @@ -1217,6 +1231,8 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
>  err_exit_hwts_rx:
>         if (aq_ptp->a1_ptp)
>                 aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
> +err_exit_xdp_rxq:
> +       xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
>  err_exit_ptp_rx:
>         aq_ring_free(&aq_ptp->ptp_rx);
>  err_exit_ptp_tx:
> @@ -1233,6 +1249,8 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
>                 return;
>
>         aq_ring_free(&aq_ptp->ptp_tx);
> +       if (xdp_rxq_info_is_reg(&aq_ptp->ptp_rx.xdp_rxq))
> +               xdp_rxq_info_unreg(&aq_ptp->ptp_rx.xdp_rxq);
>         aq_ring_free(&aq_ptp->ptp_rx);
>         if (aq_ptp->a1_ptp)
>                 aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index c59b6c0b37f1..e06c502b59f9 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -14,120 +14,37 @@
>  #include "aq_vec.h"
>  #include "aq_main.h"
>
> +#include <net/page_pool/helpers.h>
>  #include <net/xdp.h>
>  #include <linux/filter.h>
>  #include <linux/bpf_trace.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
>
> -static void aq_get_rxpages_xdp(struct aq_ring_buff_s *buff,
> -                              struct xdp_buff *xdp)
> -{
> -       struct skb_shared_info *sinfo;
> -       int i;
> -
> -       if (xdp_buff_has_frags(xdp)) {
> -               sinfo =3D xdp_get_shared_info_from_buff(xdp);
> -
> -               for (i =3D 0; i < sinfo->nr_frags; i++) {
> -                       skb_frag_t *frag =3D &sinfo->frags[i];
> -
> -                       page_ref_inc(skb_frag_page(frag));
> -               }
> -       }
> -       page_ref_inc(buff->rxdata.page);
> -}
> -
> -static inline void aq_free_rxpage(struct aq_rxpage *rxpage, struct devic=
e *dev)
> -{
> -       unsigned int len =3D PAGE_SIZE << rxpage->order;
> -
> -       dma_unmap_page(dev, rxpage->daddr, len, DMA_FROM_DEVICE);
> -
> -       /* Drop the ref for being in the ring. */
> -       __free_pages(rxpage->page, rxpage->order);
> -       rxpage->page =3D NULL;
> -}
> -
> -static int aq_alloc_rxpages(struct aq_rxpage *rxpage, struct aq_ring_s *=
rx_ring)
> +static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s =
*rxbuf)
>  {
> -       struct device *dev =3D aq_nic_get_dev(rx_ring->aq_nic);
> -       unsigned int order =3D rx_ring->page_order;
> +       unsigned int size =3D self->page_offset + self->frame_max +
> +                           self->tail_size;
> +       unsigned int pg_off;
>         struct page *page;
> -       int ret =3D -ENOMEM;
> -       dma_addr_t daddr;
> -
> -       page =3D dev_alloc_pages(order);
> -       if (unlikely(!page))
> -               goto err_exit;
>
> -       daddr =3D dma_map_page(dev, page, 0, PAGE_SIZE << order,
> -                            DMA_FROM_DEVICE);
> +       /* Buffers whose page was not passed up the stack are reposted
> +        * with the data they already carry discarded.
> +        */
> +       if (rxbuf->rxdata.page)
> +               return 0;
>
> -       if (unlikely(dma_mapping_error(dev, daddr)))
> -               goto free_page;
> -
> -       rxpage->page =3D page;
> -       rxpage->daddr =3D daddr;
> -       rxpage->order =3D order;
> -       rxpage->pg_off =3D rx_ring->page_offset;
> -
> -       return 0;
> -
> -free_page:
> -       __free_pages(page, order);
> -
> -err_exit:
> -       return ret;
> -}
> -
> -static int aq_get_rxpages(struct aq_ring_s *self, struct aq_ring_buff_s =
*rxbuf)
> -{
> -       unsigned int order =3D self->page_order;
> -       u16 page_offset =3D self->page_offset;
> -       u16 frame_max =3D self->frame_max;
> -       u16 tail_size =3D self->tail_size;
> -       int ret;
> -
> -       if (rxbuf->rxdata.page) {
> -               /* One means ring is the only user and can reuse */
> -               if (page_ref_count(rxbuf->rxdata.page) > 1) {
> -                       /* Try reuse buffer */
> -                       rxbuf->rxdata.pg_off +=3D frame_max + page_offset=
 +
> -                                               tail_size;
> -                       if (rxbuf->rxdata.pg_off + frame_max + tail_size =
<=3D
> -                           (PAGE_SIZE << order)) {
> -                               u64_stats_update_begin(&self->stats.rx.sy=
ncp);
> -                               self->stats.rx.pg_flips++;
> -                               u64_stats_update_end(&self->stats.rx.sync=
p);
> -
> -                       } else {
> -                               /* Buffer exhausted. We have other users =
and
> -                                * should release this page and realloc
> -                                */
> -                               aq_free_rxpage(&rxbuf->rxdata,
> -                                              aq_nic_get_dev(self->aq_ni=
c));
> -                               u64_stats_update_begin(&self->stats.rx.sy=
ncp);
> -                               self->stats.rx.pg_losts++;
> -                               u64_stats_update_end(&self->stats.rx.sync=
p);
> -                       }
> -               } else {
> -                       rxbuf->rxdata.pg_off =3D page_offset;
> -                       u64_stats_update_begin(&self->stats.rx.syncp);
> -                       self->stats.rx.pg_reuses++;
> -                       u64_stats_update_end(&self->stats.rx.syncp);
> -               }
> +       page =3D page_pool_dev_alloc_frag(self->pg_pool, &pg_off, size);
> +       if (unlikely(!page)) {
> +               u64_stats_update_begin(&self->stats.rx.syncp);
> +               self->stats.rx.alloc_fails++;
> +               u64_stats_update_end(&self->stats.rx.syncp);
> +               return -ENOMEM;
>         }
>
> -       if (!rxbuf->rxdata.page) {
> -               ret =3D aq_alloc_rxpages(&rxbuf->rxdata, self);
> -               if (ret) {
> -                       u64_stats_update_begin(&self->stats.rx.syncp);
> -                       self->stats.rx.alloc_fails++;
> -                       u64_stats_update_end(&self->stats.rx.syncp);
> -               }
> -               return ret;
> -       }
> +       rxbuf->rxdata.page =3D page;
> +       rxbuf->rxdata.daddr =3D page_pool_get_dma_addr(page);
> +       rxbuf->rxdata.pg_off =3D pg_off + self->page_offset;
>
>         return 0;
>  }

The LLM thinks this code is perfect :-), but any chance you can pretty
up the diff above a bit so it's more easily human reviewable? Maybe
keep the function names the same or  factor the renames into another
patch or something? Right now it looks like completely deleted code
and new added.

--=20
Thanks,
Mina
