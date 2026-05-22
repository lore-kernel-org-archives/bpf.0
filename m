Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602C3B8955
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440782; cv=pass; b=BIpSU4/8tA6u9w6qMIaF2YiBvzTPm6fS5wWMGnvkOu0RZ6tn+qzamzTYIOgYjpOGl8iRHp+rl32ABze9RH6U+ceK2MWLoFsk6639Rv18jCm/IOJFUTyfQGG+7axyH6fw+plHxiOqQMhAYEeJJI9t/DxkfbubUXBvfyMFL9ogUlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440782; c=relaxed/simple;
	bh=R+S7aw8jm/S0niR/bgF2z9EKXggL1ReO5jO3N/+1zP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdStv3tLVlYE/jJjWKwyfNnym+VAqEh9rTQo2cFkM2aRI/Qk1J7uf9qrV+D2bfx8OzWK0oxta6ILu66RgV1wtPsHBvaGNgLwxAECP3uTxnQnXTPrcpHXR+tudWTe/EUKDYUvMX25ibcXCyfaZJ+JsMURgJK9biIDOaEmzJmGKaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBsgu/lO; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBsgu/lO"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2baef9f5ecdso57175705ad.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 02:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779440780; cv=none;
        d=google.com; s=arc-20240605;
        b=UQbifWCXsq8q088KiD1NsAdR/wRcF21o1Vinw0/iiEJYW6mXLq/kvdUJrGnmRPoGZS
         W+M1dd34A5Q75XWSk71c4nht+ogO3+og9n1YEkJ5JykckCBQUT8B+wCtPj+FkbIFxolE
         AQO9b2802MfQBauiKCz8/IHmNZvw7lSjBL0G4Uoe1MeeshHVebjSDB38Us8u6mGb5Yu2
         Rc369i6HgoapofrYAYlu7iSoyDevPc/bv9gDeWRxXjW4GLC4Gu2w1k4DL7sW+lCkx1Rz
         ZsOniCX5BedewXaya9Cj/vBZwNMdpUrsVmcN+TFfLTi0NBcvm33Hh0O3wDNkjFlsoDD9
         51RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0g2cVKUQEj9Q4kYnLCnoahgGlOqxaRvFqX0zcp0b8M=;
        fh=4vnddbiLEm0/heK7J+1kvJ8QA6p898RxEFNZxZqM4dg=;
        b=Bh06os/lkQ5KfRRLEKiLMZsZ/y0dC9H/09jQNsBEUjg1J1tbuhWrOKyRGeGWuDGx+B
         sx03xWEmHv3/RpJwYTR2K2efzhhuIm9MVOCutzFNnsB5X1Zsyot/jd0K/AXXDHfLRH0G
         UHNYHEpNcg8pD1zDMug4hP2hxMIPZZt68x4J558XhJK5E2MbHZLL27Xmg+cw+hzQDOfh
         6A5u/uA0zjd3Fix91BRsxffkZZbEz0cIP7EAneh1aS9fCTAue0UHNjmabvBVpztBhnqW
         oWF1dEyht2gfw0OqY3cBIJctOjJ/hA9//AmAc7SuAyJuCGqqoGjNkscxSX+F6IBwntfs
         2IRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779440780; x=1780045580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0g2cVKUQEj9Q4kYnLCnoahgGlOqxaRvFqX0zcp0b8M=;
        b=nBsgu/lOM+L+g0xYW7sSm1uAkRersmD/hxD/ZkWGl8cY5lLvFHF84A2QchoMD18tfv
         XCjNxC7pH8ja59asDOz8aVZywmwHkTDJMBUPEMYq8kU/ECIPh3eUNHEVXbhm8kQ2oKTI
         OxISYWit8y2OYLK2LcqDai2lXxyzIgZuisXCAdMIj3YcwuBwdDetDCkOIUmIWSMLE17U
         tCeI3gdhgaiG1MggcFTBD5n7760fh9oKDaAt0dsO2hjkA7BUGsYMsPHgQSFrT4AJlyjb
         FOLH0VgvqIy4Gg1QyWsOn2KuUD1BGHP+Me+lq6I+ydLiHmdpE+yTguyktz3Bl74a3spw
         KQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779440780; x=1780045580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0g2cVKUQEj9Q4kYnLCnoahgGlOqxaRvFqX0zcp0b8M=;
        b=BduRYFhQVk+TAJ+L2KuUrDn9WKq0dx3YSCHeLusf6ZZRcl4xwNSfJjXFwj3Km+LxDn
         bQrSsWQWkqrqHxn19pjtlpzahJzt5ZRfcGd5hCYaCCz1aWQ4XASjLXfn5FvKTSPEMwRa
         hfZUngm/as8JKuQBlj3Vcgv168H9InENd56rgS1PcvGlNa/UnWT1/nzp4HoeKEJKd8ug
         w3K5aczvenwlAabHWbCP8U4soVXbNJ2nUDplpQVeEWmFbc2tu/+M7WbJn/t33i8sUrXS
         LSRZkGI6EcmG5GG5JDxAQNq1rlRtMDP11USrVLpq7Ryylf3A7tHuhFaExhGmLqQKR4UO
         lO8g==
X-Forwarded-Encrypted: i=1; AFNElJ9Mz0DTitDTzBhCTRjiyrNPF/Fzrx1Fqxl18LXe/biALKzAJ1SFZHT5i6SCBlNzMb9C4us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxquZGKSCQPRZ/mb9+VYo4cYAcMuf5ClIcVhd4lg1Qpo8JlAHuc
	zpc0emorFOYrQqVR537ZX7d/dXftRk9e76kUTyu9naAo5xDdYFg5bqlrkle5vNxEs7PVT3oifww
	9rU+eQOVdI+AEdBTrVG8OipmVHA9Wh2M=
X-Gm-Gg: Acq92OE5jI89MB/WVOZBvxOylAOF0TTMWIgPU7AiEAZuvDKDennmHareRjfmv6raHF/
	ITxVT3cTFGbMTEHw7gYWVK84XoCuhJiyA6EA2juFglJ660jK5WpjYokSiZ2vdE2HNk1ekfwiVlF
	FphHB75N3t2bMxCtpXChXiQTSj8P78i4hc4FNo6dmJSSemqn2h+ReUEXVGNqzqpUEmzKLlXYSs4
	+0IqjNf0MVUWGUMjbSD/FSiPms8EGfLRifJw2ftS622mGBALt2arxpLOIm39ks7D2wL2We5czfv
	3GudI8kOJg==
X-Received: by 2002:a17:903:234e:b0:2b4:5931:bc4c with SMTP id
 d9443c01a7336-2beb069806dmr27409495ad.15.1779440779790; Fri, 22 May 2026
 02:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-4-kerneljasonxing@gmail.com> <ag3c9/EF4h7DLQu3@boxer>
 <CAL+tcoAvbEZ7U2oXBWwLAKeuC==gAHi=GXLZcrEPxbb4mQ9sfA@mail.gmail.com>
 <ag70RrU4nGy0Nlna@boxer> <CAL+tcoAHnVDOFgmUvi1jfTdTHchxdUrRYppenQ6Ubiwyv8jmUg@mail.gmail.com>
In-Reply-To: <CAL+tcoAHnVDOFgmUvi1jfTdTHchxdUrRYppenQ6Ubiwyv8jmUg@mail.gmail.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 22 May 2026 11:06:05 +0200
X-Gm-Features: AVHnY4KiTvx6DrhHqiVR7wrSm7hruax0kEs4hqu-if92Ny5qh6-NW-NaDOy7_Ko
Message-ID: <CAJ8uoz0bKHSiHjRvNmvVs_z3cWg58U=6wGKKs9_n65yCCcYbEw@mail.gmail.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org, 
	magnus.karlsson@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2026 at 15:42, Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> On Thu, May 21, 2026 at 8:02=E2=80=AFPM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, May 21, 2026 at 07:53:27AM +0800, Jason Xing wrote:
> > > On Thu, May 21, 2026 at 12:10=E2=80=AFAM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EO=
VERFLOW,
> > > > > only the current descriptor is released from the TX ring. The rem=
aining
> > > > > continuation descriptors of the same packet stay in the ring. Sin=
ce
> > > > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > > > leftover frags and misinterprets each one as the beginning of a n=
ew
> > > > > packet, corrupting the packet stream.
> > > > >
> > > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow o=
ccurs
> > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is rai=
sed,
> > > > > so we have a chance to examine and handle the potential remaining=
 descs
> > > > > of this big overflow'ed skb.
> > > > >
> > > > > When the last fragment (without XDP_PKT_CONTD) is processed, the =
flag
> > > > > is cleared and the loop continues to process subsequent descripto=
rs
> > > > > with the remaining budget. This behavior follows how previous xmi=
t path
> > > > > treats overflow packets.
> > > > >
> > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@sm=
tp.kernel.org/
> > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on=
 Tx path")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  include/net/xdp_sock.h |  1 +
> > > > >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> > > > >  2 files changed, 20 insertions(+)
> > > > >
> > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > index ebac60a3d8a1..8b51876efbed 100644
> > > > > --- a/include/net/xdp_sock.h
> > > > > +++ b/include/net/xdp_sock.h
> > > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > > >        * call of __xsk_generic_xmit().
> > > > >        */
> > > > >       struct sk_buff *skb;
> > > > > +     bool drain_cont;
> > > > >
> > > > >       struct list_head map_list;
> > > > >       /* Protects map_list */
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index 0a6203c42576..f4add7be8c93 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock=
 *sk)
> > > > >                       goto out;
> > > > >               }
> > > > >
> > > > > +             if (unlikely(xs->drain_cont)) {
> > > >
> > > > Hi Jason,
> > > >
> > > > could we get away from introducing dedicated boolean to xdp_sock fo=
r
> > > > handling this rare case?
> > >
> > > I've tried several ways, but they didn't work. Please see the short
> > > conversation with Stan:
> > > https://lore.kernel.org/all/CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=
=3Duxd2McuR-w@mail.gmail.com/
> > >
> > > That means we always rely on a flag (that is either static or like
> > > this patch) to recognize how we treat this abnormal descs.
> > >
> > > >
> > > > > +                     unsigned long flags;
> > > > > +                     u32 idx;
> > > > > +
> > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, =
flags);
> > > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, des=
c.addr);
> > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_l=
ock, flags);
> > > >
> > > > It feels a bit off to do this cleanup one-by-one.
> > >
> > > Actually no, it adheres to the basic send logic in copy mode.
> >
> > Not really. Here you are producer to cq which we have batched variants =
for
> > usage.
> >
> > But after second thoughts I don't think it would be worth to put any
> > further effort onto optimizations here. Anyways, even though generic xm=
it
> > is a whole bunch of mess, maybe you could pull this out onto a helper
> > function?
>
> Sure thing. My takeaway is that it will be refactored once as the
> batch xmit feature lands in the tree.

I agree that the code has become really messy since I get a headache
when looking at it ;-). Do you want me to take a stab at simplifying
it?

> Thanks,
> Jason
>
> >
> > >
> > > >
> > > > I wonder if it could be covered by xsk_drop_skb() where you would w=
alk the
> > > > tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_add=
r_locked() ?
> > > >
> > > > OTOH, in theory the amount of frags after we hit the overflow case =
could
> > > > be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to c=
over
> > > > them.
> > >
> > > Right, this is why we now put the logic into the xmit path just like
> > > other kinds of descriptors. We need to check and send it under a
> > > series of protections like the check of cq pressure and budget. I
> > > don't think it's an exception to escape the check logic. The whole
> > > process should be fast as there is no need to build skb and send it t=
o
> > > the driver as long as this case is recognized.
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > > +
> > > > > +                     xs->tx->invalid_descs++;
> > > > > +                     xskq_cons_release(xs->tx);
> > > > > +                     if (!xp_mb_desc(&desc))
> > > > > +                             xs->drain_cont =3D false;
> > > > > +                     continue;
> > > > > +             }
> > > > > +
> > > > >               skb =3D xsk_build_skb(xs, &desc);
> > > > >               if (IS_ERR(skb)) {
> > > > >                       err =3D PTR_ERR(skb);
> > > > >                       if (err !=3D -EOVERFLOW)
> > > > >                               goto out;
> > > > > +                     if (xp_mb_desc(&desc))
> > > > > +                             xs->drain_cont =3D true;
> > > > >                       err =3D 0;
> > > > >                       continue;
> > > > >               }
> > > > > --
> > > > > 2.43.7
> > > > >
>
