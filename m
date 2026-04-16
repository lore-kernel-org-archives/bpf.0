Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628A18872A
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 03:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776308728; cv=pass; b=T1R3VhZlmX1BGQ9YLPVJCPIv/TqozLrwBNZrRp59FauddlinDIgnFkHcwhxLsx4Efee/QX4BbdpyfC3GWCXqVIkJr+mWz55wgzkgT6MKgKPKEUwDibeXEebQgN6edPScW6DXcXTTcmlj2OrM40vICgp4IvXhoA1KTAopgaNNkSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776308728; c=relaxed/simple;
	bh=3SJOaDXiJKPLrEQCXp0Hi1o/eFcwWpxbFDX39mPRpWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sizHCDBEf3dTe88hwlw3lg2ZWEilMGXB5oqc7DQukSB9IlXIQQzTd5efRN6FQjdQ6XZYMNMWcbyqYgBqPfBroFg7s7/S5R+ayX51NX0gJ54HYbYQD9y+DZ9sYX23ilcR0z42FRDJtltlQrbVP97I4BTOs8+kmdEgNt802JNu3hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imborb+/; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imborb+/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2c3dfb4a1so7910333e87.2
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 20:05:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776308724; cv=none;
        d=google.com; s=arc-20240605;
        b=CvGjyC1y+ovmBmp5DlD8xVLdygolHIBIaYw6hxmU57AbodHNqPo8V8RI/1+kkRIaa0
         UNj9O5eS575OH+UkQput9oysuguKZrP3gE976D0L6IZc4I4oT1k6DpYHZI/IENCwK8Q7
         Gmg7KcPzoruH4QR14iT0DLPPMnJ1CL2QY4+OaqDdnDMR5xz2+Z4K+h+jP3GVr32z8o0l
         6IbdeZQdGAQWBO6bmLyD1TKy1cVn5Gdo9Igk7n8pCs2K2coECzNU7kPm3D0P5QFbLop6
         17Pu8zaylaVgUJDoLEgTgwS9Ui96jarf+eAXfJb994afoSqgFGOJJfsVYGcQEKjHSZSu
         j20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+x9fm6pO6USW8WdV5snWH77PpLZQ5qVyPAEGN3LxmSE=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=F7MWkG70B9F1c95N85JhFPE3FFhXPn063UWNCl2Gnh3yp9IvMN3nAG5mvTIHQAGDA7
         vlYSj83FtOVTqkk1BVgD35Rb0UjW3L5IrtCwW7+gNUOV5HxH9uIxScQRT+K3oLGRa2OE
         kOKlBUCf7H6+dPzw9ezk+HPDFF2vU/EfumvptIkjmhaknZy8c2bEpAbFgSZ2NL1WNTcJ
         eQ4EOTv5UDaQHr0epuMoydILVCl4yFgQgiVD7Zp7SYiSeqDkY5aEcqtMTUuopDvXHHI9
         2hdG9/CBpUDoINJjOrDvYpWVCkEOtSTbKJmSdfpN4pStpdnxn1mKx9Vis6x8siCHlTs2
         Cn2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776308724; x=1776913524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x9fm6pO6USW8WdV5snWH77PpLZQ5qVyPAEGN3LxmSE=;
        b=Imborb+/9NQtsix0X69aSnoRt2ZQH1cYN5+8lYpE0enaAvYAZYEb7OZsfmw2ASp8Ce
         uVlIgrLdAHFerZHTSjFT/aQxWkbFrenNiGzP49GCxq7L7xH3BGgKBKsCrb57pJHFQ5uY
         KhhifEvsOg2G5Bbd8jh47Lxeo16s+Dn0LZd2SFLfK9ZobT55s8XVdFmr+9p+TUuJb+WL
         w9tNX4I+bffIfztrYE1GpR9E39z7HlTMp0Ybu0fkpRp4+pB4wdSgNtqLn45cLLg2mynn
         Mz40IXO5ppdUJjuzp1sYHphZlUhKG0TVwicNrVV+bSmbQpxUMlMjFr7eI87uFoyWMpHx
         iCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776308724; x=1776913524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+x9fm6pO6USW8WdV5snWH77PpLZQ5qVyPAEGN3LxmSE=;
        b=NhYIaxjdQ6UoEKwzJSfpZkKVlmENHxLZ5rBXt2XAH1qb3eiEgX5/6VXA4sssxCqwze
         YGITXy2ArXrDkVsC9nkQlSV9D2XquHOJ0Yro7NJAnuFzRyiGqk9k1d1yQuYTPk9Zpk7N
         qB6tAqy7L1lLmo560zf+lgGVrDz1wVbO5eHeL87WQjCXDDtb2lDuMR+oiq19YnDD+gXj
         6q7lf7ON4qvncD+JRwVHMiCZRQj4PkI2nY/Qy5gaZER3RIKG96jIXrWskufs4RPAXsW8
         Z6yHFD+Oxhg0ecMds+PzWYGKhzr+0EdzQcUD74dsCipQ1RvcmG4Fw8Z/zONGfDzvBbbF
         lywQ==
X-Gm-Message-State: AOJu0YxwsvAT59q0Ax3rxDlbrvAFfvA/DHd7E/BJnwC0CyPv/+7tiZ33
	3iTvBgq8+I60Taner25VeiwEm/eQiIVhNHsKgz5vVLQVgyJsVgcETtbmyc2NrAU+qqUazF7+IUg
	LHspjuAwigZvEENGuRCrykILLfJT1b/I=
X-Gm-Gg: AeBDievff/3c+PlYvkih7aX+F9HFiPAUANv1wIkAIYhTIahP0M9bNDcklU1dLbdtvTG
	M+fPOcbrDsOgiA9JZ9wZypsggWIDyeYyE1LteO7DlLNaWj0V747BiaOxZlqAwKl8lGtSTfCvIUE
	l+aW18s8UQ1Af2fU0uaKXHRCMmOAtAs5pacaJaZP9S/KbmGsoJzOLJCAd6h84KmswtR/G6DFWVd
	kNliSTWm09BF1gdfTUpcLwWVPl9KTwHkCJrCSrqgAmrEMMT+tBGVw0HBPs7BYB+fWf73jKasOLb
	x/WLDLEqDnVlXWW1Kg8L/dbvhUx5dw==
X-Received: by 2002:ac2:5df8:0:b0:5a3:f3a4:1aff with SMTP id
 2adb3069b0e04-5a3f3a41bbfmr5546765e87.38.1776308724250; Wed, 15 Apr 2026
 20:05:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-6-kerneljasonxing@gmail.com> <20260415091159.2BC4FC19424@smtp.kernel.org>
In-Reply-To: <20260415091159.2BC4FC19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 11:04:45 +0800
X-Gm-Features: AQROBzBEKiKbghToJ65gA5j39dJR3T27ly3tRT1z5EFF8r1bEsdg-lixRkSHrkw
Message-ID: <CAL+tcoAN-U1YgKRGEys-nvamnbmEsnED=0bOThFi3vpEgYgOvw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 05/14] xsk: add direct xmit in batch function
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 4 potential issue(s):
> - [High] Packet validation executed inside hardware transmit lock, causin=
g severe lock contention
> - [High] Missing transmit recursion protection introduces deadlock vector=
s
> - [High] Missing device state validation allows transmission to stopped o=
r suspended devices
> - [Medium] Hardware doorbell batching is defeated by hardcoded 'more' par=
ameter
> --
>
> commit b98984346f64d24e3ecd521b219464ccbe9fba91
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: add direct xmit in batch function
>
> This commit adds a batch transmission logic for AF_XDP. It introduces a
> new direct transmit function that disables bottom halves, grabs the lock
> once, and sends all aggregated packets in a loop.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
>
> [ ... ]
>
> > +int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
> > +{
> > +     u16 queue_id =3D xs->queue_id;
> > +     struct netdev_queue *txq =3D netdev_get_tx_queue(dev, queue_id);
> > +     struct sk_buff_head *send_queue =3D &xs->batch.send_queue;
> > +     int ret =3D NETDEV_TX_BUSY;
> > +     struct sk_buff *skb;
> > +
>
> Should there be a check for the device state before attempting to transmi=
t?
> Direct transmit paths that bypass the Qdisc layer, like __dev_direct_xmit=
(),
> typically verify that the device is running and the carrier is up:
>
>         if (unlikely(!netif_running(dev) ||
>                      !netif_carrier_ok(dev)))
>                 goto drop;

Actually I did it at the very beginning of the sendmsg function, but
with the respect to the original code I will move it.

>
> Could invoking transmission on a stopped or suspended device cause issues=
?
>
> > +     local_bh_disable();
>
> Are we missing transmit recursion protection here? Standard paths wrap th=
e
> hardware transmit lock with recursion tracking to protect against stack
> overflows and deadlocks when routing through virtual devices:
>
>         dev_xmit_recursion_inc();
>         HARD_TX_LOCK(dev, txq, smp_processor_id());

This is intended because I think it's not necessary for XSK that is
only triggered by sendmsg only in copy mode. No such terrible thing is
likely to happen as no one binds xsk to macvlan type of devices.

I will reconsider it, fearing some over-engineering work impacts the
performance.

>
> > +     HARD_TX_LOCK(dev, txq, smp_processor_id());
> > +     while ((skb =3D __skb_dequeue(send_queue)) !=3D NULL) {
> > +             struct sk_buff *orig_skb =3D skb;
> > +             bool again =3D false;
> > +
> > +             skb =3D validate_xmit_skb_list(skb, dev, &again);
>
> Will executing validate_xmit_skb_list() inside the hardware transmit lock
> cause lock contention? This function can perform computationally expensiv=
e
> operations such as GSO segmentation, software checksum fallbacks, and
> subsystem hooks. Other transmit paths execute this validation strictly
> before acquiring the hardware lock.

The next patch adds a fast path check for this so it has been improved.

>
> > +             if (skb !=3D orig_skb) {
> > +                     dev_core_stats_tx_dropped_inc(dev);
> > +                     kfree_skb_list(skb);
> > +                     ret =3D NET_XMIT_DROP;
> > +                     break;
> > +             }
> > +
> > +             if (netif_xmit_frozen_or_drv_stopped(txq)) {
> > +                     __skb_queue_head(send_queue, skb);
> > +                     break;
> > +             }
> > +             skb_set_queue_mapping(skb, queue_id);
> > +             ret =3D netdev_start_xmit(skb, dev, txq, false);
>
> Does passing false for the more parameter defeat the purpose of hardware
> doorbell batching? It instructs the driver to ring the hardware doorbell =
for
> every single packet instead of delaying it until the end of the batch.
>
> It looks like this might be fixed later in the patch series by commit
> 6d7c8f2ad056e ("xsk: support dynamic xmit.more control for batch xmit").

Yep, it was suggested by Jesper already.

Thanks,
Jason

>
> > +             if (ret !=3D NETDEV_TX_OK) {
> > +                     if (ret =3D=3D NETDEV_TX_BUSY)
> > +                             __skb_queue_head(send_queue, skb);
> > +                     break;
> > +             }
> > +     }
> > +     HARD_TX_UNLOCK(dev, txq);
>
> Also, we would need to pair any added recursion increment with a decremen=
t
> here:
>
>         dev_xmit_recursion_dec();
>
> > +     local_bh_enable();
> > +
> > +     return ret;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D5
