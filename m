Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000332D0D4
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774578519; cv=pass; b=PNh+72grhzwFge7smpMRdZOA0AReZKFme+VDydSDAEwNtTLEEymPudqpAsdH4rvfdPC3dKVEHnHi9gGoKHTrENpYUKwiq/VHFAkJehTG2UArwdg0xByD4ph3YZIX9H5SafQC4NSKsJbIMIOCepxPBhbc92QNAYyHkloE506GcQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774578519; c=relaxed/simple;
	bh=HdDqD4u/X6L1QK8GFdtslv9KZE3dAP7uRvJPuX1zDoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6wKNVQ6WfOp9gszuSER/s2gTVGr2S//sLSQ5nQ2leh1E1FdhGcVoUOuuq9ZNe5JB5vWInvkge1c80MKFRp/o/M2YEdtw4Yo4N3D/HuKb9OT/x09NiPHIgwKRSQ8MY1DbrRFD7CKP6K7em1UsXBRvY16A2D2YXK6SmqVEo3kkV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=osoo/iwX; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osoo/iwX"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66ad907833dso2813202a12.3
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 19:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774578516; cv=none;
        d=google.com; s=arc-20240605;
        b=Dji1X/G/6zEelLbIE8UOzbG9pKduUj1lC3QTaxNcfExaEl2xaTFTxtXtaufslKSN3B
         43Rh1ZZBIBB+C+M3I2NULyGmPepwxZCB+nJrjbOeITnUBg96FwLph6JPYicRjLApBWXC
         Rkv/S8GRpIjWL+JpIOVGbdT5o1DEL3awp1ZC9FW8YUIqAM0ayyMkVwo//5a9YwNlLkub
         js1JGnd3ImEu6qybPg8ua6/eE3LLgElJqKOUyDAos83cbfPXbhgxUfFh6iKP2NuwtVv4
         79wnMoZduA/whrgCCqdcMNpqEJxSUpZvQNLCoomDh8PF2MftjcmzYJniAsG/5Mc7nXVf
         7CnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o/QYHaH5lUz5iP49ZKscBpC9M/ZhuP2QIdCxew6sXwY=;
        fh=IrS5EFMubmlJ6LflfYld6LPEA681Fm8XevdLq9qcDeE=;
        b=d9UVcBVpTRIr3R99YLGTfZE+7Ph+z8SvHX6W1KNtGSOHtwbEAkZH/FHLKddPDWFCnP
         /QlqTZz2IWz+YlgonJdPiizsiY4udJuvDq8Bss9bxdsNeiczItMIVoxbx8Q+o5YfjZRY
         nuWhSvliKT5MjqC2xqnrDpXlPsk/amgXBzRGqaxlg1cKUSYs1+k0GWMClJNDGbWNt8zg
         BXpZq4w+MTy6WAup70o1F5SdJ6RfrpewIg5FEkfmAAdxT1hP55r5t+88N0BIo9qOrwnJ
         GM3//C4QNpT1xFwNHsOdx0sz7q14ikkzqIrQUFZ6Ody3i+slj1Zux5iwgBaQb6L+zmw2
         LzcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774578516; x=1775183316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o/QYHaH5lUz5iP49ZKscBpC9M/ZhuP2QIdCxew6sXwY=;
        b=osoo/iwXVRYkFj6XpPsvL4mN0Vw11EYfasWQhfJyT9V40j72sF0l5TQ6nZ7EeGNXul
         /77JDWS3wJ4sbOquxpTOZSFuWHe6SW2Wkjg8ZcPWl7GklvJlycnxU4GCWELCqe5UHkBD
         6Ux56dQQj4SV+ekc2IVkWEd3RRE59kRJkEf3u17E9ot/W6o4DlBMrUuGQzdEJi6sZfbr
         F7exnCSSlxcln7eNc+NxF+0wgfV4DVZb1qMKaSuuAuYV2lSbQSTcLuaL5YFn+aS+g4tU
         MBTfeXySZz+wkRE3r487tC+KB/G73I7vmPnmyqMdS86rsSfAYE6Xy2CjhnGjyo2lF67t
         NVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774578516; x=1775183316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/QYHaH5lUz5iP49ZKscBpC9M/ZhuP2QIdCxew6sXwY=;
        b=NRcGOmW5A6xbTn9Jqforlm03FAAYzfvWrbpuXuI8rsRpeDXr2Z5PiqoU1ZupWCV1xI
         lWZWJFpyxeIw60pjcTDRPcBmSmfLv9/ktPR2daHkcMBNdy4b2eVzOItyd2D+fW/Exsxp
         4vggG4B9J8IIIxyGFywfx73WBxvm0o7GAf1v/PJ341e/DBPtQqEW8FSz2vGDJw3ks13+
         j7bkFHhITVplRwrpmLsJTrLxJ8HYz+/6Pp3UCzaW65rXSIeIdfilsL2V+mMUexkn3a4M
         gKRwURkVMcOlnjP7Lm5L5GEwCHfzduw1knBQ60GaWy+FPgYveI0NRGBF06TZnG3aACK1
         3zZg==
X-Forwarded-Encrypted: i=1; AJvYcCUV9ky5xhf++5KKSTMbO728ZQiHKHo568050UPCevUwigOfhjrPUtlRulk3rlS6nPqYItI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf5wB+kmrJMSigSLvt+5AzIVRCHrsYXuXj01fTuTFT4+lFayVU
	cQx9tNposYuNoWke8a224pF1Ab20C/3veRYdvnI40bbxnX39aXTNwMLC7Z3Qg6dUTxzO4sNQhVJ
	czHE6GtIgEuYbPm1kBRblEXbaJgd/UTY=
X-Gm-Gg: ATEYQzz/W5U/gRlhu1euVtaAch70u1D6hj2xYvtICsjAWKiaNDH4SW0Evikf4L3v3ZT
	BCPAK3VfbGhE/GFbV7G/D1JWsrpZ3KnzY7H0IUAc9uD4s31m1o4dikvGf+RUCnhs5hUCP9jYco0
	iDdJ+SrQBrURzAUX7HjjCf9NCXUU4/VeyYFsVSHTRP7INkY0Z/NFrpYUq1e8H+gru7r8KTxatUL
	Xj0yhM8S2SaU0P5DfGGdjrm7iJQX8e0pTfxtytZhiK0VrKJlQBHexVo0hooVAg/zXQOafolszR/
	1nts
X-Received: by 2002:a05:6402:a0dc:b0:666:d675:e2ed with SMTP id
 4fb4d7f45d1cf-66b28b5d0c3mr265917a12.21.1774578516178; Thu, 26 Mar 2026
 19:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323182823.5813-1-teknoraver@meta.com> <20260323182823.5813-2-teknoraver@meta.com>
 <IA3PR11MB8986EC18B4FE10649049AF87E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986EC18B4FE10649049AF87E548A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Fri, 27 Mar 2026 03:27:59 +0100
X-Gm-Features: AQROBzBQpBbZY2yB90kykPH3EOXGMHAzeYAHmse7tk-aqdKtuWnq9c8rAoT9-d0
Message-ID: <CAFnufp1H4ptUN0mr1Kq4j2hcOE+pN-XfiHnwh_6=68FD2OzomA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic XDP support
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Mohsin Bashir <mohsin.bashr@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 24 mar 2026 alle ore 09:06 Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> ha scritto:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Matteo Croce
> > Sent: Monday, March 23, 2026 7:28 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> > Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> > <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>; Mohsin
> > Bashir <mohsin.bashr@gmail.com>
> > Cc: netdev@vger.kernel.org; bpf@vger.kernel.org; intel-wired-
> > lan@lists.osuosl.org; linux-kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] e1000e: add basic
> > XDP support
> >
> > Add XDP support to the e1000e driver covering the actions defined by
> > NETDEV_XDP_ACT_BASIC: XDP_DROP, XDP_PASS, XDP_TX and XDP_ABORTED.
> >
> > Infrastructure:
> > - e1000_xdp_setup() / e1000_xdp() for program attach/detach with
> >   MTU validation and close/open cycle
> > - ndo_bpf support in net_device_ops
> > - xdp_rxq_info registration in setup/free_rx_resources
> >
> > Receive path:
> > - e1000_alloc_rx_buffers_xdp() for page-based Rx buffer allocation
> >   with XDP_PACKET_HEADROOM
> > - e1000_clean_rx_irq_xdp() as the XDP receive handler
> > - e1000_run_xdp() to execute the XDP program on received packets
> > - SKB building via napi_build_skb() for XDP_PASS with metadata,
> >   checksum offload and RSS hash support
> >
> > Transmit path:
> > - e1000_xdp_xmit_ring() to DMA-map and enqueue an XDP frame
> > - e1000_xdp_xmit_back() to convert an xdp_buff to a frame and send it
> > - e1000_finalize_xdp() to flush the TX ring after XDP processing
> > - TX completion via xdp_return_frame() with buffer type tracking
> >
> > Assisted-by: claude-opus-4-6
> > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> > ---
> >  drivers/net/ethernet/intel/Kconfig         |   1 +
> >  drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
> > drivers/net/ethernet/intel/e1000e/netdev.c | 533 ++++++++++++++++++++-
> >  3 files changed, 540 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/Kconfig
> > b/drivers/net/ethernet/intel/Kconfig
> > index 288fa8ce53af..46e37cb68e70 100644
> > --- a/drivers/net/ethernet/intel/Kconfig
> > +++ b/drivers/net/ethernet/intel/Kconfig
> > @@ -63,6 +63,7 @@ config E1000E
> >       depends on PCI && (!SPARC32 || BROKEN)
> >       depends on PTP_1588_CLOCK_OPTIONAL
> >       select CRC32
> > +     select PAGE_POOL
> >       help
> >         This driver supports the PCI-Express Intel(R) PRO/1000
> > gigabit
> >         ethernet family of adapters. For PCI or PCI-X e1000 adapters,
> > diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h
> > b/drivers/net/ethernet/intel/e1000e/e1000.h
> > index 63ebe00376f5..4c1175d4e5cb 100644
> > --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> > +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> > @@ -19,10 +19,13 @@
> >  #include <linux/net_tstamp.h>
> >  #include <linux/ptp_clock_kernel.h>
> >  #include <linux/ptp_classify.h>
>
> ...
>
> > +/**
> > + * e1000_xdp_xmit_ring - transmit an XDP frame on the TX ring
> > + * @adapter: board private structure
> > + * @tx_ring: Tx descriptor ring
> > + * @xdpf: XDP frame to transmit
> > + *
> > + * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
> > **/
> > +static int e1000_xdp_xmit_ring(struct e1000_adapter *adapter,
> > +                            struct e1000_ring *tx_ring,
> > +                            struct xdp_frame *xdpf)
> > +{
> > +     struct e1000_buffer *buffer_info;
> > +     struct e1000_tx_desc *tx_desc;
> > +     dma_addr_t dma;
> > +     u16 i;
> > +
> > +     if (e1000_desc_unused(tx_ring) < 1)
> > +             return E1000_XDP_CONSUMED;
> > +
> > +     i = tx_ring->next_to_use;
> Unsynchronized read of next_to_use. ndo_start_xmit on another CPU can be
> reading+writing this same field RIGHT NOW under __netif_tx_lock, which we do NOT hold.
> Isn't it ?
>
> > +     buffer_info = &tx_ring->buffer_info[i];
> > +
> > +     dma = dma_map_single(&adapter->pdev->dev, xdpf->data, xdpf-
> > >len,
> > +                          DMA_TO_DEVICE);
> > +     if (dma_mapping_error(&adapter->pdev->dev, dma))
> > +             return E1000_XDP_CONSUMED;
> > +
> > +     buffer_info->xdpf = xdpf;
> > +     buffer_info->type = E1000_TX_BUF_XDP;
> > +     buffer_info->dma = dma;
> > +     buffer_info->length = xdpf->len;
> > +     buffer_info->time_stamp = jiffies;
> > +     buffer_info->next_to_watch = i;
> > +     buffer_info->segs = 1;
> > +     buffer_info->bytecount = xdpf->len;
> > +     buffer_info->mapped_as_page = 0;
> > +
> > +     tx_desc = E1000_TX_DESC(*tx_ring, i);
> > +     tx_desc->buffer_addr = cpu_to_le64(dma);
> Writing DMA descriptor that ndo_start_xmit may also be writing to
> at the same index - probably causes ring corruption
>
> > +     tx_desc->lower.data = cpu_to_le32(adapter->txd_cmd |
> > +                                        E1000_TXD_CMD_IFCS |
> > +                                        xdpf->len);
> > +     tx_desc->upper.data = 0;
> > +
> > +     i++;
> > +     if (i == tx_ring->count)
> > +             i = 0;
> > +     tx_ring->next_to_use = i;
> Unsynchronized store - races with the identical write in e1000_xmit_frame.
>
> > +
> > +     return E1000_XDP_TX;
> > +}
> > +
>
> ...
>
> >       kfree(adapter->tx_ring);
> >       kfree(adapter->rx_ring);
> >
> > --
> > 2.53.0
>

You're right. I see two solutions here: taking __netif_tx_lock around
the XDP TX, or using a separate TX ring dedicated to XDP.
The latter would be a bigger change for e1000e since it only has one
TX queue, so I'd go with the lock.

Thanks,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay
