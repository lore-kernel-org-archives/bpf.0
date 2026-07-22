Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4AA442B1B
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784744998; cv=pass; b=bUP/TfcGmQOe4NwFVBxupICtD2dTP3X3zIGDTTF7BDmKmUTc+mXMhB/lzwigt9cL9te7DdM9638BgNWUPpii0E7vczN4XHykx5mhLn3FkJllV7mYmkovI53fcq1HfDRphQxkm8qVc4GNwso9B4ue7l4SbizLNzAe+6Yeuu5IQtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784744998; c=relaxed/simple;
	bh=/l71NXez5IBHg2o5uvalxHKgKhdxiODPMlFk8RG5G6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM/3ekRqRt0qgV+LhhxOOSo5FyxNZcU0AG15Z9p3UxCAjDogEpPBL30M0rCNhvo9iZSP7CtZCZDqcenNym6qWjjoMmBjfC0NpUYZ8j+03678FFbXDwbTP+dZWFssYFdS6jfC/Pwg0TnDovTA26SrIZt2zfqE2cb5jW8IWI1Xh20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLv9dXbu; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLv9dXbu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cede6375caso7825ad.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784744996; cv=none;
        d=google.com; s=arc-20260327;
        b=ULYzbSKcy8zSO4JwT4RIidcEtGQBfImeVAZ86gqJJV8ob+T+47j2pS4gAe6H5GBQwb
         t1zzs3BMetSFBiVRJGk7AXt/UB3oL+aXtrS7B/ecEQu9OCqvCPGIgtXWLbUOBAVy62Ui
         wQKsLOV0UlBTfVRKVsahfmlkQYAJu/s4EEmOyrWRKgi41zjMpPaFE1G8WStHZ9TZjoFK
         /oM33VcRSnK4Mu3E2SGxlCNClPIiDhnWoG9hhvAilc3Wwl/EZXpV+6OW70eVojrfZGg9
         iU3wHBIKJCy6gXud89abMShlhmQDp3dCO4TBYzg0EB64CfMgZoCySb5o6S4uJpXEWQiv
         6XNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EFjIw+YHhZOGu9EHRZwkadgAAA6y6Xc2ZzPm9AMLH64=;
        fh=+E0+s+6mVGv414kJG3yHjNOcn3j9c2b+vbn7Wz8c8Gg=;
        b=SU7CoOqouFOzJHEdrg44j8S3MiGzAXVgMkAvcw7rmrbls6R5vBil51XeyQsxk3TLxV
         9y0aqi8KTN23PsLKNeTJ79Mt09raV71Q4uF2MLgp70DnfjBZ0JxK9j7ESmRn7mUr/WPX
         8TU1xO3aTVS8kilZx3Y25DsuXWFtxzksHny5+8opGZ70AYgTebSAY2gJejvmqM/Crqel
         jqBWyqw4e+B13A939labWpXQdykz2DzAXMqZpneUl82gYY8JXkXwf5s4WTkuddmCKJGr
         PWJGQFS2Frmh+GHJJ7fnPbbtQQwa+zdhQ/j87qEIErXuj7DCORor822QhMANo+72+xoz
         k7MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784744996; x=1785349796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EFjIw+YHhZOGu9EHRZwkadgAAA6y6Xc2ZzPm9AMLH64=;
        b=qLv9dXbuiZs4OgRQjTHMs60lWeLrqtl8W0Kj3quzkzcueC5owi6iTnLsPCTpDf8jlT
         HOcrs1ggqQmLOIALs+r9cgKfuzzb6c95qD44Akl0V+d6/9vvsDn3sGZgFpbhCQMm4zGo
         luw2bl3TGlHYoGDtHCX0zI2vzHQa8OJwytkMUW6hfb08+ULpZh/WOGkmNs4VphUMtWTQ
         BgujSYZgalBUWPkOnSh6Tz1GkFkLY16XzQAQkBhELvzG762l2YukaAheyWPCZZaS/n5+
         6B8LFpllAD4MLAq5dgUkJDydxwudYLyM5Ho8Ie0rAet2K9uS0OM4lnPDJDQTypQ9Q8Qz
         lsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784744996; x=1785349796;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EFjIw+YHhZOGu9EHRZwkadgAAA6y6Xc2ZzPm9AMLH64=;
        b=AJ7h6a6r4IMYRFYzk8p1NpffBS0PcLHBEs63l8slBcFMeKygAhRzBfzGoF1GBEnErb
         BRnx4KdpTK9SEm1uEFfjhwiniKCIZ2hMtKT1z9CLjnAvko5+COHY1I0wIsSX6CtoRWvH
         jvQjzWV68CUEGQNSxwPsB2oXELy1zRRDWfCNFdtbUXvIfnmx2SZ+vex3fRgIQUyKHwr/
         fHz6oyCrDSac3rGpcR8P8G8s3pAoqAX5560qGPGEr/rq7NpILjk0EWx7ZqU5tjZSacxf
         cIeu3rlil98joJn+ofshn+1FHm7Q8WviYOMFnTxZluckiHYWiD2PohcVPgJ3XZJik+B+
         CwSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGc83QKb/d1zf1vfjrt4wtVrELL1xyudm8xbLx07hEh4zK6roZCh7GBJV+ZGs226aN5Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BgyV6PGrDihO5lWiAFAQBiStYHd2aixstm7eI098BDGRYTY2
	zXQw1/51QP92yhk5K7sHwIBcsunaJffIPvfwR4F3ZKdAzfWqXBZlsPA4e6rGP9osYK6lgoUj32/
	o+Lxze9t+hxU29JVPkY/FXkdGtWdETY1ZhGNLkCI07QuI4drJSjmxg58N
X-Gm-Gg: AR+sD13rFTt+eykAwND5FI3fnI1sIcsVTm6+MlfVgr3FvzA2Xq3pP2KATSry0F3FaUX
	MH1FoQp9VrLTM0k+hvbz/BYUFw52gqQDrikApla8B1ZZIeBIr4z/5NgdTLGoT6TPoDcuIiAsdVv
	ErZTnorJ/SNsufOT/euTi7UNL8t/K8Q3pGq2EcnHsqGxp0HYndiA9baAwAmyqbpTPBO9LrF3wY+
	NHcN/RkP+g4l10ofLVhbhRXPKiI0SF4zMw4hLVHUp9M7OmByhC2d3V6ISQbCELegZvj27pB7pb/
	LHVjWBPsFHhNF8kx
X-Received: by 2002:a17:902:f60e:b0:2c1:ee6e:4e49 with SMTP id
 d9443c01a7336-2cfa53828bcmr546965ad.26.1784744995317; Wed, 22 Jul 2026
 11:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_7DB01BE7F8FA056BB5F11D3570CF636C4309@qq.com> <tencent_8FE30FDFA32089B69BA3112E4A4C5E886D06@qq.com>
In-Reply-To: <tencent_8FE30FDFA32089B69BA3112E4A4C5E886D06@qq.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 22 Jul 2026 11:29:42 -0700
X-Gm-Features: AUfX_mzS7_PqfH6KstmDgOCBUlGwA2ixyTSez2IFSShyi5JJI7ari5NvR-MmgQI
Message-ID: <CAHS8izPBvv4ENCcnSpsbcL9+TEMj9nBE6CAj4fg9_aDBdhrBaQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: atlantic: free stranded TX buffers on
 ring deinit
To: Yangyu Chen <cyy@cyyself.name>
Cc: Sukhdeep Singh <sukhdeeps@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 10:41=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
> call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
> stops at hw_head, which no longer moves once aq_vec_stop() has stopped
> the hardware and NAPI. Completed descriptors beyond the budget and
> everything still posted in [hw_head, sw_tail) keep their skb or
> xdp_frame when the interface goes down: aq_vec_ring_free() then frees
> the buffer ring and the references are lost for good.
>
> Today this is a silent memory leak on every interface down under
> TX/XDP_TX load. With the following conversion of the RX path to
> page_pool it becomes much more visible: XDP_TX frames carry fragment
> references on the RX ring's page_pool, so a single stranded frame
> keeps the pool's inflight count above zero forever. page_pool_destroy()
> then never completes, the pool is leaked together with its pages, and
> "page_pool_release_retry() stalled pool shutdown" is warned every 60
> seconds from that point on, on every ifdown, XDP detach or ring resize
> under XDP_TX load.
>
> Bring back aq_ring_tx_deinit() as it was before the removal and use it
> for teardown again, with one extension: TX rings can hold xdp_frames
> nowadays, so release those too. They are returned with
> xdp_return_frame() since this runs in process context.
>
> Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Looks fine as far as I can tell, but don't you want this sent to net as a f=
ix?

> ---
>
> Notes:
>     Without this fix, converting the RX path to page_pool (next patch)
>     turns the stranded XDP_TX frames into leaked page_pool fragments, so
>     page_pool_destroy() can never drain and the shutdown stalls forever.
>
>     Reproduced on an AQC100 with this patch dropped from the series (i.e.
>     page_pool applied without the tx-deinit fix):
>
>       # reflect received frames back out through XDP_TX
>       xdp-bench tx enp99s0                    # or any trivial XDP_TX pro=
g
>       # from a peer on the same link, flood RX so frames are in flight, t=
hen
>       ip link set enp99s0 down
>
>     The pool is destroyed with frames still stranded on the TX ring, and
>     page_pool_release_retry() warns every 60s with the same id and inflig=
ht
>     count and a growing age, indefinitely:
>
>       [161110.753385] page_pool_release_retry() stalled pool shutdown: id=
 361, 12 inflight 60 sec
>       [161171.170756] page_pool_release_retry() stalled pool shutdown: id=
 361, 12 inflight 120 sec
>       [161231.588685] page_pool_release_retry() stalled pool shutdown: id=
 361, 12 inflight 181 sec
>       [161292.005886] page_pool_release_retry() stalled pool shutdown: id=
 361, 12 inflight 241 sec
>
>     With this patch the stranded buffers are freed at deinit, inflight
>     drops to zero and the pool drains cleanly.
>
>  .../net/ethernet/aquantia/atlantic/aq_ring.c  | 30 +++++++++++++++++++
>  .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
>  .../net/ethernet/aquantia/atlantic/aq_vec.c   |  2 +-
>  3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.c
> index 8ff07de2bd52..c59b6c0b37f1 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -360,6 +360,36 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>         return !!budget;
>  }
>
> +void aq_ring_tx_deinit(struct aq_ring_s *self)
> +{
> +       if (!self)
> +               goto err_exit;

return; here and delete label?

> +
> +       for (; self->sw_head !=3D self->sw_tail;
> +               self->sw_head =3D aq_ring_next_dx(self, self->sw_head)) {
> +               struct aq_ring_buff_s *buff =3D &self->buff_ring[self->sw=
_head];
> +               struct device *ndev =3D aq_nic_get_dev(self->aq_nic);
> +
> +               if (likely(buff->is_mapped)) {
> +                       if (unlikely(buff->is_sop)) {
> +                               dma_unmap_single(ndev, buff->pa, buff->le=
n,
> +                                                DMA_TO_DEVICE);
> +                       } else {
> +                               dma_unmap_page(ndev, buff->pa, buff->len,
> +                                              DMA_TO_DEVICE);
> +                       }

I would remove the unlikelys that seem unnecassry to me. This is a
reconfig path and the unlikely is probably not improving perf.

> +               }
> +
> +               if (unlikely(buff->is_eop)) {
> +                       if (buff->skb)
> +                               dev_kfree_skb_any(buff->skb);
> +                       else if (buff->xdpf)
> +                               xdp_return_frame(buff->xdpf);
> +               }
> +       }
> +err_exit:;
> +}
> +
>  static void aq_rx_checksum(struct aq_ring_s *self,
>                            struct aq_ring_buff_s *buff,
>                            struct sk_buff *skb)
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/n=
et/ethernet/aquantia/atlantic/aq_ring.h
> index a70b880ada67..6431cc62962f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
> @@ -202,6 +202,7 @@ void aq_ring_update_queue_state(struct aq_ring_s *rin=
g);
>  void aq_ring_queue_wake(struct aq_ring_s *ring);
>  void aq_ring_queue_stop(struct aq_ring_s *ring);
>  bool aq_ring_tx_clean(struct aq_ring_s *self);
> +void aq_ring_tx_deinit(struct aq_ring_s *self);
>  int aq_xdp_xmit(struct net_device *dev, int num_frames,
>                 struct xdp_frame **frames, u32 flags);
>  int aq_ring_rx_clean(struct aq_ring_s *self,
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/ne=
t/ethernet/aquantia/atlantic/aq_vec.c
> index 2f9033ceed8c..05814fea0f5f 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
> @@ -275,7 +275,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
>
>         for (i =3D 0U; self->tx_rings > i; ++i) {
>                 ring =3D self->ring[i];
> -               aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
> +               aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
>                 aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
>         }
>
> --
> 2.47.3
>
>


--=20
Thanks,
Mina
