Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712363E47B
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776311076; cv=pass; b=tovQB6m3JqrlJw+7qfeXoUFhNw8xQw5QLRLqPu3+xPzVYOO/qpKhZugYog/TJe03yCTFis48zYbVd6ALKSDns3GkC+bj8HUhzSFKO0RQb9QOjtaueLiexsR1QFxX1BvKGcD55100dfLpcLZlsrET8nHg7eatCCBvl2hwc74Lt4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776311076; c=relaxed/simple;
	bh=dpt4IJ3GDG0XHW9jydXe0NywBRPJF46+FLWkhFYg8uQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVQeolLBNm8QbAXZsPcol5dLpeqaXFKstsMcy9g9bEvkV+NiZXN/+5kJUB1QuU/zK8MDV4B0sPRQlC84+jTFMFP0z1whWv1gi6DIT1y5CA/N/e4SPxWRdTfTlrzd1X1KzlNuqobBmncW2Rz9XE/JEKCyFJdmTDyf0koL27tIJRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si42mY0G; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si42mY0G"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a2bd236adbso338145e87.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776311072; cv=none;
        d=google.com; s=arc-20240605;
        b=JR6X2794jMaf0J4p1nip0C6tNlljeIJBf4Ce72NpH6LHLlvA6/s9w4Fj0U+LaVYHZL
         TtpElf44OvjYQnEzBj0VJjGGSLBgxlP7MtI0Jc9+sLKLiR2gh9s4ipC6Yfr00kmtHb60
         pRZ9PVYqQEzJG6NplyMgudKNu0kUzhyJwIFfosdDWpKzf0BCWLQw0ao6aLYacx0WNbAk
         DcR96qjSOkmv+bcn0iNVIfJQvgdM9W+P5IvaCt8OCBknHfdmhjkC9T0WQXnndRQv3bi8
         Q4bzOgG+O3vJXvxaleVOkkJ8g4sJgXuxOJgfVsgrFEi+m2F5HSZOhuiu7+ZvePitujRf
         dirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ucDq05nFVA74XEJrVhKyCRM7W5uLCDWodS8G7L/HG4U=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=SRPqYKNS5pwAhmp2PVJdlNXxeeQejQ9x4N1yv+r9PDjAEP2JVcMVqrF5qMA9CV+qbN
         CIufVqM163zIXCd7RHORY3QZUD03QATIT+KFUeviTersRp0XOneL7e8eWDc6h1sX4x/Y
         vitK15H10qdP3iyA0D30IH2E7zULIs0muc8y5GJpSm2P/1U6rEMiC8gF5ILNG0nove47
         ISHmfnQZRj7XAxezFV3vb7JU0gODupEgZGhpCHU5nJLBt3GXY8MzyiqNZHYvhJn0y+Tf
         tZl0rHUMMOffTvAPPiAg83gyMXRmD3J42cMqP/oxgLvBzmm42XsYQaioemZ1XzQffErT
         MSpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776311072; x=1776915872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucDq05nFVA74XEJrVhKyCRM7W5uLCDWodS8G7L/HG4U=;
        b=Si42mY0GqnTeQ5YBgFY58Vs9Xwtaoi9QqHOq42acgQ0UocmOJczn96XSzXE5tTBcJD
         bijJc7cN8+nnqkgnd3lr8QAPG6GxZ2bZsryR2sLughnBXPWDS3MlpYACrx3Sq4+9sLCA
         LIXAxnPMPSo9zuiUKbp5YiJsBBYFWrkijX+UUvcGFrO7+i8LTjbItikU0+jNrLjux0pX
         nk59fLOh2eHbm1bt6fXlCjte90OKm1zQS3wmBMKWNe23kPkQO+QyWNvqui3WUx89leOh
         pjZrjTckotkNmATg62Ri0sXMbHlUjLZhKcODBufOCLR41iJTS3f8X2AkQmKwETjP7mge
         I0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776311072; x=1776915872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ucDq05nFVA74XEJrVhKyCRM7W5uLCDWodS8G7L/HG4U=;
        b=cNnUGbGfKj41n46RZR9lMhn9AT6jCMvPmccRWfxLTj4qZjreSz8UfR4zqSzWFA981L
         4R/Hr8C3/VcG8LdsMPIcWvz2DvP2m48R8JQy45CbP8y+UbwPNsYbD8axD6NLK8sEJpVz
         67z2xo4X8NyBbn5CBMECxDp9mk8f3Ol25TQJVwTRdew6jA1lxPCPiH8hQCaMvoIbvdbO
         Z0xIlp3k1/uTXiVkql6HZ+wkF9yuLa14b69CSo8WOJw6w3QPVyMdwPbBiXBJFzJoYbCv
         nsY837ayWglzm9hoj67LzESOViXnMyQ1hFYehTvlT0YmICylpmgukKlwXr4rPlLq6iWl
         vtCg==
X-Gm-Message-State: AOJu0YyC/17RzB8M5bY83dgtDBnL2dK5F9htg3K1/Y1mgi3O19KRqlrx
	4IKANOwW7Xr0wAJ2n3k217JKQQrE6C3FWbOrD+jk7xIiGYYJiZsaIIpQfJXmu3Md3hgTtO1dlg9
	MPviUw+BzDYQHN84eddYwtnWsB36Pn/jHw77wUea6HQ==
X-Gm-Gg: AeBDiesCsc7zTGi8EcoKo9mjm2zalLTstrLGKpvC7bKN+TP1wvmcwtQjYXrlXdiXTX1
	hoxBmzZreer1calAxmyHJ+AUpqQoRynwfD5weH3B4BqFTdiY1zkDyX6AfEycF5969W2ReOqB2lO
	Pzin4P/Np8NCj0vBeKe1hfk3ZiiQRH5PHM510u+kkbW8nVNPfreDFaVgJPCEvfj6IWN84CIuw15
	kYM9NVC78ZsU8fScfTiQ/7Nl6iBhhW63I2sC0oyFTP8EeunImmqAHIH9GPiKAw2QKc4MQWsj6cg
	9yxtUjH+INHzrEVLnow=
X-Received: by 2002:a05:6512:1081:b0:5a2:9b96:528b with SMTP id
 2adb3069b0e04-5a40dfa9058mr504302e87.20.1776311072241; Wed, 15 Apr 2026
 20:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-7-kerneljasonxing@gmail.com> <20260415093539.4A4BFC19424@smtp.kernel.org>
In-Reply-To: <20260415093539.4A4BFC19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 11:43:53 +0800
X-Gm-Features: AQROBzBl8Pk-WRPKQxQEIYAyeKD4MLfT8hpQzV8U-3Xe31PaNeksxymOLwuLY2Y
Message-ID: <CAL+tcoDUa=MpXSEtweT0LvkBEM2hcYnrjn4FK-ntU3WNMbLEWQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 06/14] xsk: support dynamic xmit.more
 control for batch xmit
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:35=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] Stalled TX queue due to missing hardware doorbell ring on early =
loop exit
> --
>
> commit 6d7c8f2ad056eb4cb2eec8d360e632f9ef9044f5
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: support dynamic xmit.more control for batch xmit
>
> This commit updates xsk batch transmission to only set xmit.more to false=
 for
> the last skb in the send queue, aiming to reduce unnecessary IRQs and imp=
rove
> batching performance.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4873,6 +4873,7 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, st=
ruct net_device *dev)
> >       struct sk_buff_head *send_queue =3D &xs->batch.send_queue;
> >       int ret =3D NETDEV_TX_BUSY;
> >       struct sk_buff *skb;
> > +     bool more =3D true;
> >
> >       local_bh_disable();
> >       HARD_TX_LOCK(dev, txq, smp_processor_id());
>
> [ ... ]
>
> > @@ -4892,8 +4893,12 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, s=
truct net_device *dev)
> >                       __skb_queue_head(send_queue, skb);
> >                       break;
> >               }
> > +
> > +             if (!skb_peek(send_queue))
> > +                     more =3D false;
> > +
> >               skb_set_queue_mapping(skb, queue_id);
> > -             ret =3D netdev_start_xmit(skb, dev, txq, false);
> > +             ret =3D netdev_start_xmit(skb, dev, txq, more);
> >               if (ret !=3D NETDEV_TX_OK) {
> >                       if (ret =3D=3D NETDEV_TX_BUSY)
> >                               __skb_queue_head(send_queue, skb);
> >                       break;
> >               }
> >       }
>
> If an error occurs and the loop breaks early, does this leave previously
> transmitted packets stalled in the driver's TX ring?
>
> Since more is passed as true for all packets prior to the failure, the
> network driver defers ringing the hardware TX doorbell.
>
> If the code breaks out of the loop due to validate_xmit_skb_list() failin=
g,
> netif_xmit_frozen_or_drv_stopped(), or netdev_start_xmit() returning
> NETDEV_TX_BUSY, the loop terminates without ever passing more =3D false t=
o the
> driver.
>
> Could this omission prevent the hardware from being notified to transmit
> the successfully processed packets that preceded the error?

The quite similar code snippet was added in dev_hard_start_xmit()
introduced by the following commit in 2014:
commit 95f6b3dda2a4a052f7dabe9998e4ffac491b7bc2
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Aug 29 21:57:30 2014 -0700

    net: Have xmit_list() signal more=3D=3Dtrue when appropriate.

    Signed-off-by: David S. Miller <davem@davemloft.net>

Look at the doorbell of drivers, like ixgbe:
if (netif_xmit_stopped(txring_txq(tx_ring)) || !netdev_xmit_more()) {
        writel(i, tx_ring->tail);
}

It has already taken care of it.

If we really want to cover all the possible drivers in the above two
cases, maybe we need a separate patchset to add a common interface of
devices to actively kick the hardware. But now I choose to defer it
unless someone insists on this.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D6
