Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7EB378D88
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318988; cv=pass; b=L7IVEOIboq1kFS8qJceYcH6aDMvF2/GhXAu89aJPMx/Jf1Kjsmj+hPH1PVEplkChJtdlA323+PlVJZydOmCuDX8SzxzjdAU+vYI+wHvDI4EQQFd+sXCYrka0QIlRwpsxavQHkgrbPCBRMdmP76slQGiEe894x2M6FgZT+ZbDEfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318988; c=relaxed/simple;
	bh=W31fJ1JxJQYGjmSvX4KclqEKeZsNyAjbWE6Nax8Qe9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sq/Nz9CYfMnlDngwpGD0VwKJ6dXcb0dSA1YWvy6fJqUKjbEat1R9SSkWatPoZHBSkfvDaGL4HOx1m1D7WF5lpPZdgd+CD+WvVJw/RGcE4Q1w9T/opfDfgeWWBfGJjW2rpU+hUhP5z0zGizG9S4Xy/BRu5u8XwQDk8LFgF/bwWbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTqMvNly; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTqMvNly"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so8721583e87.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 22:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776318985; cv=none;
        d=google.com; s=arc-20240605;
        b=aD7cakuXJ2Q5sn9AVLvCPrEMn7HVk6wJlbV1H9sVAyaHvmzDI6UGkRND9eJ6OgKrdl
         gyeNX6thG4TOOw4aRkZVy6bA250AW3mV8ZgvKAHwVKE5csbDXNwig8sKN7bshzx/R/QZ
         tdez/rbaGnQSZhADkeK/CcBZyn3lZ76VB+LinxrR9kNlge/58XakEcaRywhz5mvQP4bd
         xbVfjcqIoRBdpZzOCkFsBxHmyNvFSxUkvP7Q0WaiSHTJswh15QBlmDynRSmkMZ7iZusb
         8tQgXUg/2InLJiacLP7SrF273UOf/ZRZdTPSuArg+7TrannDybC4DisOcRqURt43G6/9
         luvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gH6UMkImy0McJC94EHW1d9KPrIFruC8cngg/rsQ4PS8=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=bM7lBMcA6DEmmy/gHKHYZAvU4CFPZkW5rO+JeoGsDXsbnDB1sbm9S3ssNOzzThZp+e
         fQZo/m1MShrIJdiXGLVBNvJoE1E+v87Y105QK3ZfI/1+ZK7zMCvddRGyjvtWS+tnf25m
         EJxPLCZL4dZARx9Rk3BlrhrttQX6wmrambeLVnT55B/qGv/HyjV2Ox2PGPTxKx+DvwH7
         pLtBM1zlN4Z116uwMrCoZSkY7uUb/kjmZIY/5NzZTF11otOIKFDIQMAd60EoTjnr0i/v
         27SHpZ7fHC5E9daN7tyQTDxUMKg4l1lIiy1UtbRLUC1nm6BH+qn5nFvVOvtnUEeb+Qzn
         WnaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776318985; x=1776923785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH6UMkImy0McJC94EHW1d9KPrIFruC8cngg/rsQ4PS8=;
        b=gTqMvNly3N8Lj9SB7WIRyEbDciWidc9qGmpuwZEecyqVOlm9CW+GJktgNu8YtdqYDU
         Ef58kFtfnH7StcfOuJ3RE1rO6Bx9raYuO2TPG4b2K4wqcQ322ta2JVyFKJVPIraHYQks
         CUoIFYpQbj4LDD87BGhAZzubySrGypAKPPl+dQqTE2xwFkfxhYXTc1FNfl9IerNXhkVr
         eLEQduEjF0+Dw4TbsIBK9Cd/UuQIXyXbL1e1o1s9vTaz58v7g8lA905ehLf1H+MU/PnF
         bQz/IrgwuwsyufpoQkb/S/749VauSHBQGItjr05d2O8oORI90oNni10DaZx3lX7DHuhv
         qt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776318985; x=1776923785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gH6UMkImy0McJC94EHW1d9KPrIFruC8cngg/rsQ4PS8=;
        b=XvA2f5Lo2/OXEQ4BQn/cYNv8kNaAIqlDLt3Lhq/27Lg8yTIILnzsVnxgA+sCp2EIUa
         B22m8bzvb8HlMQ7PbtCvAcft/AQLg6WKZcAAqZTj7h6GrBpr5fBebDTliWIbt7auH6Ur
         7QtmSI08hrJBSl4nN7R7YVxR6ebHPo4jD28tzII2slcSeu8j2O2uPY2xEfowXvCm17XJ
         HbkFMK/osrhb1BBjfOUaEgEZwzJ1tfTRctfD6a33+Vngl/USjY4Z4zAw3uh8OGrp0KmT
         0LWfGxF9e5cVLjvMEbZUup6K/cDoa5r1BMUDmjtnXkUbWFdVhgG6XaFY0O+iu9+4SEPO
         taJw==
X-Gm-Message-State: AOJu0YzTbXATzXhjUYhkm7M3xQBpIs5gCboSP7s0WNghY9QFWgepvFz2
	8UvKQcjH87xynxHYWImCvlWgwFmAVoq5VpzS/BLB6DhugVAlytjpRa4viIJ8SiWgrf+xOvCXzlk
	GD8Nk27wAbDa7qNT+FdwPPNUATwczfomEMTqUVnr7pQ==
X-Gm-Gg: AeBDies8scm1Wz9V3ydP2kQlOHvnn7TaK8DQlW5WRJIY2gieY6FybhBlJT3C3+ecSQu
	vhTXix/ZjhFfEl3c9hUOY/9JuDY4MOn5NESg25mKpjMh/kn8yFwn8e34zJi1yd5F0lBlWy2ee/r
	xo8jF0qq8j45Qib3eYsk0DOpzTijJxeRslXUR3YN1pRZSecd7S5JZc27XsOJApimW7LNZcLSWqY
	wRmboHg7VavFaEhyTNnuxPJcqxT9DHmJZih5Id/wbqzW4t2+UQhLEZlvYXV6n6CDsu6B7Hq9rgQ
	OT5eSxdGGQD9QXJ+ehE=
X-Received: by 2002:a05:6512:3e20:b0:5a2:c914:8af7 with SMTP id
 2adb3069b0e04-5a3ef705974mr7717535e87.5.1776318984448; Wed, 15 Apr 2026
 22:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-8-kerneljasonxing@gmail.com> <20260415093301.799F2C19424@smtp.kernel.org>
In-Reply-To: <20260415093301.799F2C19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 13:55:46 +0800
X-Gm-Features: AQROBzDPBGTwcTBz7FItba8D2EL1RQu15_e5rBvhpfDw5iG271Yd9yhDFbFOb8A
Message-ID: <CAL+tcoCVOX1oPY1S+QrHVMFYvXx+V2PYXq0Hykimt8YbnfPSMA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 07/14] xsk: try to skip validating skb
 list in xmit path
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [Critical] Bypassing `validate_xmit_skb_list()` based on `NETIF_F_SG` s=
kips critical hardware capability checks, software fallbacks, and SKB initi=
alization, leading to kernel panics and corrupted packets.
> - [High] Breaking out of the transmit loop early leaves packets stuck in =
the TX ring indefinitely because the hardware doorbell is never flushed.
> --
>
> commit 7603ac608a36b8d39e026a60b567ea2b106617f0
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: try to skip validating skb list in xmit path
>
> This patch attempts to optimize the XSK transmit path by skipping
> validate_xmit_skb_list() if the device supports Scatter-Gather,
> aiming to improve performance for drivers like ixgbe.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 99188353abec6..12643cbab6530 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> [ ... ]
> > @@ -4878,15 +4879,17 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, =
struct net_device *dev)
> >       local_bh_disable();
> >       HARD_TX_LOCK(dev, txq, smp_processor_id());
> >       while ((skb =3D __skb_dequeue(send_queue)) !=3D NULL) {
> > -             struct sk_buff *orig_skb =3D skb;
> > -             bool again =3D false;
> > -
> > -             skb =3D validate_xmit_skb_list(skb, dev, &again);
> > -             if (skb !=3D orig_skb) {
> > -                     dev_core_stats_tx_dropped_inc(dev);
> > -                     kfree_skb_list(skb);
> > -                     ret =3D NET_XMIT_DROP;
> > -                     break;
> > +             if (unlikely(need_validate)) {
> > +                     struct sk_buff *orig_skb =3D skb;
> > +                     bool again =3D false;
> > +
> > +                     skb =3D validate_xmit_skb_list(skb, dev, &again);
>
> Does skipping validate_xmit_skb_list() based on NETIF_F_SG bypass necessa=
ry
> hardware capability checks and software fallbacks?
>
> validate_xmit_skb() performs dynamic feature verification via
> ndo_features_check(), transport header initialization via
> skb_set_transport_header(), and software checksum fallbacks via
> skb_csum_hwoffload_help().
>
> AF_XDP users can request TX checksum offload, setting skb->ip_summed to
> CHECKSUM_PARTIAL. By skipping validation solely because the device suppor=
ts
> Scatter-Gather, packets bypass skb_set_transport_header(), leaving
> skb->transport_header uninitialized.
>
> Could this cause drivers that use skb_transport_offset() to compute massi=
ve
> sizes, corrupting TX descriptors and potentially hanging the NIC?
>
> Additionally, if the device lacks NETIF_F_HW_CSUM, skipping
> skb_csum_hwoffload_help() sends CHECKSUM_PARTIAL to drivers unable to han=
dle
> it. Might this result in silent data corruption on the wire or driver cra=
shes?

Makes sense. I will exclude this metadata case (using csum) by adding
a new condition:
if (unlikely(need_validate || skb->ip_summed =3D=3D CHECKSUM_PARTIAL)) {

>
> > +                     if (skb !=3D orig_skb) {
> > +                             dev_core_stats_tx_dropped_inc(dev);
> > +                             kfree_skb_list(skb);
> > +                             ret =3D NET_XMIT_DROP;
> > +                             break;
>
> If this loop breaks early, does it leave packets stuck in the TX ring?
>
> While this behavior was introduced earlier in the series and not by this
> specific patch, the issue is present in this modified block.
>
> The batching logic calls netdev_start_xmit() with more =3D true for all p=
ackets
> except the last one in the queue.
>
> If the loop breaks early here due to a validate_xmit_skb_list() failure,
> the function returns without ever calling netdev_start_xmit() with
> more =3D false.
>
> Will this cause the driver to defer ringing the hardware TX doorbell,
> leaving previously submitted packets stranded in the TX ring and causing
> latency spikes or TX watchdog timeouts?

I answered in patch 6. No need to take action in this series unless
maintainers request me to do this first.

Thanks,
Jason

>
> > +                     }
> >               }
> >
> >               if (netif_xmit_frozen_or_drv_stopped(txq)) {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D7
