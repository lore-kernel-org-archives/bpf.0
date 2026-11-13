Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588242;
	b=AzFE/04DU0maX7LUC6iKnC20hb4q44xJ5CPwI2SmcwSYpNvGiOBJRLySqA6T+6MsJ2oC
	 REWPSfn99d2teVhrbVLmPE8NHwNIz3Az8TS6ml7aY2oTRDMyVCeMIyhXP7W1J8W6AEu9v
	 PSMUkUuIB4XdhqD470QZHoXq4zLfpU0dkRHz4e68Zs+Th/9o9Hu7o8ALuVlCory08f4Xd
	 iwLiA0wbW0m/bFieNaJP9ZrUXmAZEL3aN6ydYUsahrZsL/BRQtudKM+agtuWK2GxpQrUv
	 A4xz5vhQoaYoaTKsHwWLgtl+ecv53aNpocniW0hQP00kuMyAa5M1ZtFk2b4FgP+RHpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2xwSLY+4r/iqUlN1eu/g4afeC8e/qnS1T9wNCqgOQ6U=;
	b=0tJtT1JoBplWYxJm6G+NEFHD9wUcCvvSnQ4jxcOkoMXZG3ZlspBXL7/GvLY0xMa/HViQ
	 gBx6YLHvnZPIp+oeEyIq2+A9mhwOBZ4DjpZWuM88L5rXcWr9TRKB0oX98SedxLnOT7XTh
	 /66o3x2C1y+6pFgPYO//aeRcC85iz/gqrGBLhc+6SMumJLbj7Ft/7utcK/ndaAwGfqDBX
	 Kx6sV999YpBRSTf0oMGqCB/oqNr8B4BmU/ibPlw9+lStIIFA7vy0mjNcZgmtXf+Yg6yVn
	 vAK2TOICPaLfwMQ5OnsBU0nKMn6rGrHSC6EuQUnnjsfuQZ0oI5c/zCO21l1kUUE/CHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmfdLKVI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E5606D625
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 16:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F9E5606D625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmfdLKVI
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so1688496fac.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 08:44:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794588240; cv=none;
        d=google.com; s=arc-20260327;
        b=X4lV56r/EpQHMruVDkaY4jyiBsW023RMeTuvctKOhiPLrQTABUUJYNYI12Ybq+JyLr
         vAj5Q0Dv893U3gypfk7Cx+302P6Ua8ZTuQQ3FS9LrDbi9xaoEBULdGjfrbOlr4irZelu
         jQGrBSEBFvbtpOA1DDPpmsWaY5N2Hd2tgAqo7AIQj8yVHBM1hAgbA0rsj5c0XBL2y+Es
         aIgivrLcjYq6dyMmg/jihZibnJ4/7ivMSOojHQVTWckfKaaoH+dPv42gKWAG2bKWuUxj
         VQHSwaO4xyBHjanWLh7sqM8t/IV41+35se5UURBD9FIiCkeXByY7PoHz53qGcLYyKuaH
         3JWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2xwSLY+4r/iqUlN1eu/g4afeC8e/qnS1T9wNCqgOQ6U=;
        fh=1xQkpy6FTw3S/Dq1IcLaAl9Y3Tf9/dYP+JVzLI9iDWU=;
        b=cBXFRi6NwJbrA5kkjx2foQ4exwGer7mkbLRuYX583pCi1TXsxJBffrU9/YdoX05Qck
         GEEBCxav4Siis3MisfdU3yrZ6VJFaF/VDCVdz5wnhUQNdTjvhMEoniwrLWMYw1tQW9oL
         ogxp7Afj2MVzWDcVW0TAh5r1878XOrgyaWQVPpE1hAxrwv9LghXmQ++kp0k7sQAmG0ER
         dQ5uw28a06h5z/2AAKNFlXTAWPhXH6JyHHNChbu0eVpzpu7ia/uxGXQRrP3q9uVhRZO2
         gy5ryOnthhbVt5KnwvVld/OtCWUOKR9B0Nf2bCgdCuSMOegCwAq318rtIV50l9+W/7n8
         gYsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794588240; x=1795193040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2xwSLY+4r/iqUlN1eu/g4afeC8e/qnS1T9wNCqgOQ6U=;
        b=AmfdLKVIDpgzHuwlcvHErRH9NVzhDO2HuQVDShKPUFxJRLCsxh4KAmjTEUdh9+6b/p
         U+1yXpA2bfsVcyDycpQKA1W+CIEz0jxWc+NVOx3cYfUDcgVuBTaylSQbIJKxW7sAYxl0
         td/37xJtH3qJrjEWx4GknkWohhezJ8XByloymeab6svDftBj8m8EFOL+4lpOEId5AnBQ
         vTGDGzL1i0WxOh6cEXFtaUB7nIfpqwJ9nzd5mRVc+HkV9rX4Dgyuom38vHsGByeRtcMe
         zxPkQKPHeIIjkD3mJB7m5zxsfoft3dt10X0Ob5/su/ObFWPfmxjNvFlXBaGTNu7XElhk
         9nhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588240; x=1795193040;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2xwSLY+4r/iqUlN1eu/g4afeC8e/qnS1T9wNCqgOQ6U=;
        b=qpMcZ8y1udeIEPKYa6lnJ0nJo47mmw6J/5cqKWT1D+n4LvpQWuQCcRdnPaKzi7mhv0
         AwtylCenhpwAKgxDdM6HjEI3B50FtJhnv5Zu25BzVqzLPZ/4qqHDrHSk/sSQPwaMUaFB
         M8VMsGpbyQYJm5Di0XDk8tZ5RcbdYV7++1pP88fty7tlYuI/gITRgFxZIk5QoRLn+Ntt
         AHz9ZQv2hHHgzhM0U3fhoji5B+JQKO44J9QegwcUyc5HE7gcfvIaPP+Scfzfin6Il649
         fmbLt9UrabmGOqZMNorqUvIkWlwzrmjbgUZjIvcBALbmW3cJvSr1x0NePxf/hget0GL9
         ruow==
X-Forwarded-Encrypted: i=1; AL+hErHSEgH3Pz9bel4zjqewlQpHo6SmQxiByYqJgYpbhvwhi41uCaHdAt+Q0GmoUcYyu+IGiCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z979mPAEmhAuZFAUdmqBSRQXjCzKugAm6KMFnIwYtaYrN+Ogk6E
	2VtsgikPC96n2WTssBKLjdhgl02l72Bxj2ZhSVDoko7AIU832sk1sOyyDUi9gLpphQm/0/nm0KK
	L6UcpuUgCkk8nrchsqndGgRuXVaXabUA=
X-Gm-Gg: AYBFou2n9Jhg27Q5rZ/fiTnNou0lt0wadg/dyUyedGIzG1hKe08y1UxUPWN0Llm2ZoK
	m3wvxeYM5+3Bfb1smUVVvixJjWmCbl5vzIES2CJAVOuY23/XNyXj5DqzKgw4uB0KHkHajW+QNZy
	WpGMNhMfUc19y0ibGbKHOByHcH5Y+UvZFNDObliKoMzY9BjXpUbizmjpDhMDTZwkktm83DWz9bH
	+Q+lOeSkpiGY8GU2PBRTKoXuCRk5Vyz/+uuWin6Co2bpq+R+5Fwdp/ptA1eE9vezHZDvhy1QapP
	0vnMiugmFznNgkmuEGqb/MTx+EmieNnTBYPuwoVNSFR3Z7D0SJDiTM0acgI6KWf7bS2vQnVeBcS
	FFO7zMdCu1Rq/aGVVmpo3G6dHzjz2EcFj6v78xlVzZm7u6VAkJVEOYrZDFK8ehcx5n+Gn
X-Received: by 2002:a05:6870:3926:b0:456:5d8b:5681 with SMTP id
 586e51a60fabf-4afdf02c194mr2838250fac.1.1794588239713; Fri, 13 Nov 2026
 08:43:59 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109100437.331423-2-amaan.cheval@gmail.com>
 <179439161258.2199510.10096207449822395421@kernel.org> <CAG+wEg3m_w1vK7VzG2jnVZfo=NUS1=FGSOU_g7iM7e8_Gg8t3g@mail.gmail.com>
In-Reply-To: <CAG+wEg3m_w1vK7VzG2jnVZfo=NUS1=FGSOU_g7iM7e8_Gg8t3g@mail.gmail.com>
From: Amaan Cheval <amaan.cheval@gmail.com>
Date: Fri, 13 Nov 2026 22:13:47 +0530
X-Gm-Features: AclHuK-dvQ8FR7iuDY6reqGLulnAiTGIl0ZxYViuhh3Gd5yQpc3FzWvdbn-ybe0
Message-ID: <CAG+wEg04LC5_RxzK2tyxkSXzDz0pBucBRjmeTYVKpgbQF8AE5A@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] gve: refuse XDP on queue formats without XDP support
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, bcf@google.com, jordanrhee@google.com, 
	przemyslaw.kitszel@intel.com, maciej.fijalkowski@intel.com, 
	pkaligineedi@google.com, maolson@google.com, csully@google.com, 
	willemb@google.com, yangchun@google.com, npl@google.com, 
	awogbemila@google.com, shailend@google.com, nktgrg@google.com, 
	maxyuan@google.com, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	hawk@kernel.org, sdf@fomichev.me, daniel@iogearbox.net, ast@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I misplaced my bot request, so v6 tests are gated. Fixing now:
pw-bot: cr

On Thu, Nov 12, 2026 at 2:33=E2=80=AFPM Amaan Cheval <amaan.cheval@gmail.co=
m> wrote:
>
> On Wed, Nov 11, 2026 at 3:36=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 (1) =C2=B7 Medium: 1 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The commit message misstates which queue formats the new che=
ck
> >   affects.
> >
> > Pre-existing issues:
> > - [High] This problem wasn't introduced by this patch, but the patch
> >   extends it.
> >
> > --
> >
> > gve: refuse XDP on queue formats without XDP support
> >
> > This patch adds a check to gve_verify_xdp_configuration() that refuses =
XDP
> > setup when dev->xdp_features lacks NETDEV_XDP_ACT_BASIC. It replaces th=
e
> > queue format gate dropped by commit d8a8ca14c937. The aim is to keep XD=
P
> > off DQO-QPL, whose RX page accounting can free a page that is still
> > DMA-mapped and registered in the QPL.
> >
> > > Refuse XDP setup in gve_verify_xdp_configuration() whenever the drive=
r
> > > advertises no XDP features for the current queue format, which today
> > > means DQO-QPL.
> >
> > [Severity: Medium]
> > Is "which today means DQO-QPL" accurate? gve_set_netdev_xdp_features() =
only
> > sets NETDEV_XDP_ACT_BASIC for GQI-QPL and DQO-RDA:
>
> Makes sense, the commit message should be clearer.
> pw-bot: cr
>
> >
> > drivers/net/ethernet/google/gve/gve_main.c:gve_set_netdev_xdp_features(=
) {
> >         if (priv->queue_format =3D=3D GVE_GQI_QPL_FORMAT) {
> >                 xdp_features =3D NETDEV_XDP_ACT_BASIC;
> >                 ...
> >         } else if (priv->queue_format =3D=3D GVE_DQO_RDA_FORMAT) {
> >                 xdp_features =3D NETDEV_XDP_ACT_BASIC;
> >                 ...
> >         } else {
> >                 xdp_features =3D 0;
> >         }
> >         ...
> > }
> >
> > GQI-RDA also falls into the else branch. gve_adminq.c can still select
> > GVE_GQI_RDA_FORMAT from the GQI_RDA and GQI_RAW_ADDRESSING device optio=
ns,
> > so the new check refuses GQI-RDA as well.
> >
> > The check that d8a8ca14c937 removed (queue_format !=3D GVE_GQI_QPL_FORM=
AT)
> > also refused GQI-RDA. Since that commit, XDP could be attached on GQI-R=
DA,
> > and XDP_TX there takes this path:
> >
> > gve_rx()
> >   gve_xdp_done()
> >     gve_xdp_xmit_one()
> >       gve_tx_fill_xdp()
> >
> > gve_tx_fill_xdp() always uses tx->tx_fifo: it calls gve_tx_alloc_fifo()=
,
> > memcpy()s into tx->tx_fifo.base and reads tx->tx_fifo.qpl->page_buses. =
A
> > raw-addressing TX ring never allocates that FIFO. Isn't that a NULL
> > dereference that this patch also fixes without saying so?
> >
> > Could the commit message mention GQI-RDA? Two things are worth stating:
> > GQI-RDA now gets -EOPNOTSUPP, and this closes the XDP_TX crash there. T=
hat
> > would help stable backporters.
> >
> > The follow-up patch "gve: fix RX page refcount overflow from INT_MAX
> > pagecnt_bias" uses the same wording ("The previous patch keeps it that =
way
> > by blocking XDP on DQO-QPL"). Its safety argument also depends on XDP b=
eing
> > blocked on GQI-RDA.
> >
> > > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net=
/ethernet/google/gve/gve_main.c
> > > index 2437cd8ba6331..fe560f5c5408c 100644
> > > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > > @@ -1723,6 +1723,12 @@ static int gve_verify_xdp_configuration(struct=
 net_device *dev,
> > >       struct gve_priv *priv =3D netdev_priv(dev);
> > >       u16 max_xdp_mtu;
> > >
> > > +     if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC)) {
> > > +             NL_SET_ERR_MSG_MOD(extack,
> > > +                                "XDP is not supported on this queue =
format.");
> > > +             return -EOPNOTSUPP;
> > > +     }
> > > +
> >
> > [Severity: High]
> > This is a pre-existing issue that this patch did not introduce, but the
> > patch adds another exit to the same gate. gve_xdp() calls
> > gve_verify_xdp_configuration() before it looks at the command, so the g=
ate
> > also runs for teardown:
>
> I'll leave this for a separate fix; it seems legitimate independently.
> The check this patch adds on xdp_features derives only from queue_format
> (in gve_set_netdev_xdp_features) which cannot change between setup and
> teardown, so it adds no new exit as claimed.
>
> >
> > drivers/net/ethernet/google/gve/gve_main.c:gve_xdp() {
> >         err =3D gve_verify_xdp_configuration(dev, xdp->extack);
> >         if (err)
> >                 return err;
> >         switch (xdp->command) {
> >         case XDP_SETUP_PROG:
> >                 return gve_set_xdp(priv, xdp->prog, xdp->extack);
> >         case XDP_SETUP_XSK_POOL:
> >                 if (xdp->xsk.pool)
> >                         ...
> >                 else
> >                         return gve_xsk_pool_disable(dev, xdp->xsk.queue=
_id);
> >         ...
> > }
> >
> > Several of the gate's conditions can become true after a successful bin=
d:
> >
> > - gve has no ndo_change_mtu, so the MTU can be raised above max_xdp_mtu
> >   while a zero-copy pool is bound.
> > - gve_set_features() refuses HW-GRO only when priv->xdp_prog is set, so
> >   HW-GRO can be turned on while only a pool is bound.
> > - The queue counts can be changed the same way.
> >
> > When the AF_XDP socket is then closed:
> >
> > xp_release_deferred()
> >   xp_clear_dev()
> >     __xp_clear_dev()
> >       xp_disable_drv_zc()
> >         gve_xdp()
> >           gve_verify_xdp_configuration()   /* returns -EOPNOTSUPP */
> >
> > On failure, xp_disable_drv_zc() only does WARN(1, "Failed to disable
> > zero-copy!\n"). The core then goes on to xsk_clear_pool_at_qid(),
> > xdp_put_umem() and xp_destroy().
> >
> > Because gve_xsk_pool_disable() never runs, clear_bit(qid, priv->xsk_poo=
ls),
> > xsk_pool_dma_unmap() and gve_unreg_xsk_pool() are all skipped. Won't
> > rx->xsk_pool and tx->xsk_pool still point at the freed pool when the RX
> > refill and XSK TX NAPI paths use them? The UMEM DMA mappings would also=
 be
> > leaked.
> >
> > dev_xdp_uninstall() follows the same pattern for programs. It does WARN=
_ON()
> > on the failed removal and then calls bpf_prog_put(), which leaves
> > priv->xdp_prog dangling.
> >
> > The new xdp_features check cannot change between setup and teardown by
> > itself, since gve_setup_device() computes it only from queue_format. Ev=
en
> > so, would it be better to run the verification only for XDP_SETUP_PROG =
with
> > a non-NULL prog and for pool enable, so that teardown is never refused?
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20261109100437.331423-1-amaan.cheval%40gmail.com
