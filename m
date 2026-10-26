Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793018069;
	b=xcfZLdc80OcveU6WKCWotnAB1aT4XDYBEfau37D6OZvh12jOO+1yC07gdKDKESQ71TEE
	 7Gowr9OYuQM42l6owHSf6fC1dte3YbiCnQ+qC2jce2A/lwmACyQK9q0FVv+0XQ2EbCh6f
	 uiP+gtvGMnF6rv5g2zWjR1a21lVx4JNEiTNY7t3bUYz4xPU47E7bYkYlkttc6zGArbs5e
	 vRau8htcbbw6h481sTX9V1u+Znt6VNZlbBR2F1DCpB/2ly1JVhlKuNMWMK/ovnawgqnN6
	 Czye5QPBKaseRKFqPNWsY6UPnjhoncasNwrZkcZQRc5pBq9pQWlCxwrfKzrdK6QBuZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
	b=Yu5kjcVX6/GKboXKvEADmbyYVBtbZhEMRMaDnwoZeDnGdSXigC7xdpkyqKqQAxF3x3l/
	 9JFFDtFwSDVxtpJWGGCIUCXxJIIiH7oHrFv3hoxxCICWlqafmKonxgjy+U/p9q3N8D42F
	 ugrC/7yjRrUSAIF4kA6Oj58PotQkIqhLBhpTNjeC9izJs7ehOVw/MjmVsClLYqcpayPWg
	 37GxvcV/oTcPk0H8ISC9Z9V+1N2XTFbQOS0mfx+oWbJvzIFg31j6VHpJ+yGRocYSugXtI
	 FSDuKQlnJUHmQmVQJhXzbzYulnRlBcMLvG4TL/spa+m08eAdj9AdDh0FkNeIeAHiU5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HdtFncM0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2C606A31E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 12:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADB2C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HdtFncM0
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e9d1114320so22003435ad.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 05:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793018068; cv=none;
        d=google.com; s=arc-20260327;
        b=YEX/x4ghjLB/WBuVBFRqwpNmAho2ZcDVEtdcqBtjlfE1Em12TFBYFtPxHMt398yQlG
         ifo7rMAnTNsUKJftTiKjQjOTmKq5fAFWTIvmQ97i6rW/toiLw5ghl2l4iF+IlVvsr4eF
         1HQn7NI3BTBgdAUtNJj3Gazs32u04OvEb/kOGGbxKH+z+9WqHSqyqtS/D1UIZba5Gh9c
         g8Pw1pm1xiJp47CWpgfOzcxDnXpcPTq+hNPgfWYOhBUTg38hgMJ+kOL4+CgRjDvk4Zo0
         A4tAv1ql9WpeNmFhSxlRgTFthyzPPAfwoMIt9vMb3v6QNmRwIm0shzWG8WH1+8QM7SUt
         dwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        fh=lMlxpi5RnkmoRhfW4xxOgcGHZQM4C2e4TqZgcji5xO4=;
        b=lxSfu1zfpJ7BPytrXWzXny9uv4ooDf7p+NbZDgqDmqVosBUdhUpfZYjxPb/8Mqj6dM
         T2G+9/OfJcL1QW1i6l9EFX+FszYQVdKiYMZLmpNx4L0EQMW4olCt8tZBfMJ0zqx7/xAk
         tF1kh6nOf7YcQi8D8noC90O3ieV74OVnVRulce17I1QhXukIyO42DSF0gRXpo2oQWzNX
         Kz8Sksy/IasHuYxA6mfldQS4RyEt0O7XUyriC3BPX8S7V+r9CXCFRLwoyn7K/Iyhx4J3
         gprRN/1J1EfeQuaG53QMso2r55qybZjasfzqVCGM9kAFQJtNRxIFi3GT28pC1Zmdy5dl
         TAAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018068; x=1793622868; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        b=HdtFncM04w4/76lIdgLfZLw/0vgYLnhbPuHclib1LzHCRj0B1KxFZekGEulO7gtq0i
         POQFwKjj3LXA2dcopzYhgWNgZVrCWwBJLkmFGbQaQmsO/c6Q1q4XO0ouSL8XC7x45/dG
         um54EGBS+m6o8La2GkzbOUNBl00ocendPMUC4FY8qPvHfiBE14TfsV8EHQymgVVUgUJ3
         rCQ0Q8nLVU2lfnQDMCfYtUF915/7YSDk499Rh45X2gFlBYLHwdKfTlBzUSIQrxjWe4tU
         Bnwlr+e+VjVQX273sUjj3mClGgrORgkouFyUX0sQzGugEhDMrQrX5xTow4oT9R47UA2T
         JfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018068; x=1793622868;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SaxBkLbIzbkEbnKAF/XTN2o3bSo+ZWaTXQ9XQ6IuC4s=;
        b=mNnVXkEZ8CFYmk2eNahliHsnHCR1bYTuVU9zHn/b+wlchIt04avQjkXCVKytODns4G
         Ze/QviWzDxJJSYdDsDrBDLfw8GP7OOq3zVZMLDHWdEzbApu64xs4l74IQNOjp70ScO/1
         uUcvynetLTH9xmqQxFo1SFo9R7J8MiwoMjWfgs9Y1vK/4xQIwiyM1ss5iTN5EzJfprFK
         A8eL9WULqlk2ONYSKXOSH6v/S5biODT7cVn/4cke3bqLDKFST7DkYdiAR5ohaZxCncqD
         OP4K/E0nUjHIRgpttbyXPVmHQaM08tra+74aRFuLVmMzUx8LGGQCKjZ/nQCEWVAHWptT
         zSJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxjH1V+8dOhGILxhvpFCB4olZlfJ+SwrbAVJGIJnO/i4Nf7QtmI2URuTQI1/0k3cJgfgrA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLl1NKYKjAAxCg9wAVg1u8mIxi5lql+FxvCEFKKgukVwsJEXauO
	Y47MBi91eYgljvUdT5MZTEUc3MuKjt/5n5sUs3Gzt+xV8mBbVnLY+tnl+088wa2FpKzxaRf73Br
	kGeaqanDrowkkvefXg1vjDyt8NNOJRpU=
X-Gm-Gg: AYBFou1fqluJw0g6p2QyfC+YhFkffcd79Hb+O6fRqDD/Mhq4lQgfNOXdDvIuCbflPkK
	1yey8/ivTmQEHQf0Fl4iF73dNUL9FpUAGvqUCLdpVc7MrGXdUgp3UZYZy9hH/dlYWgNcYCvXItM
	K7Z4oS+W42+jtQEfYtxx88j/DxXF2NsUAe1G6b5/RUSi0/89iCAc0Fm3Z/eM/apPz8zZjvvMLIu
	fzePVUjgf+S9GyuzqS0HaMjUTilh+dI800e5voyyLQfGA5uOW7lU7ZHxa5Oa6assiJmdZEqtPNS
	aS/WjAHLdQbE6Jd0dzY9/YdbgncmRBT1W6R6is3XhPfCJ68O1H8n6ciFP3/Jm3d0ia7YOLXWebW
	GszkIwGkqrk7ygVIsr4+od3kFMkoHvtsh1xRqDdk=
X-Received: by 2002:a17:903:3ba5:b0:2ea:33eb:7375 with SMTP id
 d9443c01a7336-2ea9c7fb26fmr60059095ad.45.1793018067828; Mon, 26 Oct 2026
 05:34:27 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024091256.17918-1-testwrzwrz@gmail.com> <20261024141157.59301-1-testwrzwrz@gmail.com>
 <20261024141157.59301-2-testwrzwrz@gmail.com> <at82NLzM7g8HGgum@boxer>
In-Reply-To: <at82NLzM7g8HGgum@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 26 Oct 2026 14:34:15 +0200
X-Gm-Features: AclHuK86Nf4MoOy1SZ-DK_sdM59j4Q0Ek644A1GPV_2QYD872VpQvocWDHsm21I
Message-ID: <CAJ8uoz0bU0ETmEp0Nv9V4Q-H272D9dmyuK8vFj+B_un-rA4VoA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] xsk: defer software checksum until the skb is complete
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Rongzheng Wang <testwrzwrz@gmail.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 13:32, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sat, Oct 24, 2026 at 10:11:56PM +0800, Rongzheng Wang wrote:
> > When XDP_UMEM_TX_SW_CSUM is used with multi-buffer TX, xsk_skb_metadata()
> > calls skb_checksum_help() while only the first descriptor has been added to
> > the skb. The checksum therefore covers just the first fragment, and
> > skb_checksum_help() sets ip_summed to CHECKSUM_NONE, so the remaining
> > fragments are never included in the checksum.
> >
> > Move the software checksum calculation to the point where the last
> > descriptor has been added to the skb.
> >
> > On a checksum failure the packet is now dropped instead of being returned
> > to the application for a retry. This path is not reachable with the
> > existing metadata validation, but the behavior change is intentional.
> >
> > Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Rongzheng Wang <testwrzwrz@gmail.com>
> > ---
> >  net/xdp/xsk.c | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 33475b180ea6..65be2a368325 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1011,14 +1011,6 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >               skb->csum_start = hr + csum_start;
> >               skb->csum_offset = csum_offset;
> >               skb->ip_summed = CHECKSUM_PARTIAL;
> > -
> > -             if (unlikely(pool->tx_sw_csum)) {
> > -                     int err;
> > -
> > -                     err = skb_checksum_help(skb);
> > -                     if (err)
> > -                             return err;
> > -             }
> >       }
> >
> >       if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> > @@ -1030,6 +1022,14 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> >       return 0;
> >  }
> >
> > +static int xsk_skb_sw_csum(struct sk_buff *skb, struct xsk_buff_pool *pool)
> > +{
> > +     if (!pool->tx_sw_csum || skb->ip_summed != CHECKSUM_PARTIAL)
>
> If i am reading this right check against ip_summed is a way to tell that
> first frag had XDP_TXMD_FLAGS_CHECKSUM flag set.
>
> Agreed with Jason to preserve unlikely() when checking pool->tx_sw_csum.
>
> Regarding skb drop, I am leaning towards this, I don't see much sense in
> retry when packet is malformed? Not sure how this could be communicated up
> to user space.

Do we need a new error statistics counter, e.g. tx_malformed_packet or
tx_invalid_packet? We do have one for invalid descriptors, but that
does not really apply here.

> > +             return 0;
> > +
> > +     return skb_checksum_help(skb);
> > +}
> > +
> >  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >                                             struct xdp_desc *desc)
> >  {
> > @@ -1275,6 +1275,12 @@ static int __xsk_generic_xmit(struct sock *sk)
> >               if (xp_mb_desc(&desc)) {
> >                       xs->skb = skb;
> >                       continue;
> > +             } else {
> > +                     err = xsk_skb_sw_csum(skb, xs->pool);
> > +                     if (unlikely(err)) {
> > +                             xsk_drop_skb(skb);
> > +                             goto out;
> > +                     }
> >               }
> >
> >               err = __dev_direct_xmit(skb, xs->queue_id);
> > --
> > 2.39.5 (Apple Git-154)
> >
>
