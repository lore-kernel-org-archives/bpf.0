Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519593D171A
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369093; cv=pass; b=AAihF3PkmwfpasL9mwMysOcaDNiJDADYxf7oJpNjH3SlU1fKFBhfx3u+LWKUjZ7pQd4bE1zceJ+kp4jiSBjQccPUam21w1lFBqbJubGAXSmXvCOcc7HLwbZd1tukgT1sm7oh2GSNIVuYe0fR1kUKcg2swsECWbXJJIkpd+f6ykQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369093; c=relaxed/simple;
	bh=r6LxEN58qbq0Y/M28+MsnZWSw96N7dXM2LM1lFWQMNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toqsv1kYbR9byD++QkbCHcYocBr+zC2dgWUrIezntVyuGL6xNXWlAeIb2NrEYhghlHg7VXVRV8h1Jjf/4ct5atvmM/twagXGbIolgHexQQKDW9vYt1artJYVa1VpoUJpaqrs9/L37J6yeCdod3EVvVhM70vkMTu9VGd4BxYmaL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g10aHEcd; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g10aHEcd"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a88db610ccso6590646e87.2
        for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:11:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779369089; cv=none;
        d=google.com; s=arc-20240605;
        b=a3wy/4hzuQJdgE9ue8wO1SgaJkwcAcPgIctgdjNayoQJWwaT+xUDzFUyM+zKrs21ZX
         tyMd7VEo2AbW7xHFb6uECQtC1mx9A1nOkQHt4ns2JpIVmp+jtsLD5ivz911YukwaglkB
         0DK86hItEtf1kBkDmt06LDsAw/ghd85szbBlHNfNjzeHAko3NtEhxckltYO/+QXpW6h8
         27AwVVvT/hdhh5gNPc6D5DIO1+lU3HuXUi7b9R+MGKdtlL4oeY+YCY6YxK/gQNzTq7mU
         GbRcV86MwZqlJVUvq4b/pQ47lSp5Uh1gkMdf+zDQ0eUp1x8K0TYtQyj99lg/+vThHxwC
         9h5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oPRoiP89QkO6oH3NtO+q0F6orRcQ/LGFJxe4k+Ya1A4=;
        fh=D9Q3UesVAHr1LDe5iRHoUL5sohv3I7lgC4icPWDmkUI=;
        b=ABKR2GtuqN8z8i/JOZwxU0ihmzuAs0GikcLv5qbtAU2GothG+f+W7tRQ0XLzlqzIj8
         PkU0Ysa6n31tDMRmdjNEroqqydFNSTvauFdTDxv+1c7VqXhe0HtyOtab3nqQkI2yU+9+
         2lQLZ3isYFReFwt4jbnoUgJ9RDIHGm7HAcfzIPnE0VPw9ob+wFjImzAK7yf4POKQFdFf
         Cv9yGq4T36wITzRaUxCZik8SK8HNdf85gUDxQi8PlgSrTX4LqOX46E8gyRVMOjKtELUt
         GfQ+u4GrvGkizAlpffl9R96wRumoIWWP/wYCRuxwfT4CEBWhzg03cf3zupWk5G3rKewz
         hC0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779369089; x=1779973889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPRoiP89QkO6oH3NtO+q0F6orRcQ/LGFJxe4k+Ya1A4=;
        b=g10aHEcd3xJj4AmkJhtNQT2e1SaP1Ul3P/u9lViAIt5OizEiDnYNBTl1HhA7hTI/5P
         vGKkzj9N+NJF0/BFnY4MWtcowetMSkFWAD7Wsnia8XafuRtZUytTlXfoXZzdNGAWog4T
         b22Itom+D1Qc0n8DjMGmSl0SgTyY/2xkNpOYF3lEWDIGaEXgUZ3XwWmKjBd1BhYkRjnR
         lzmGaIEBmjFa3N0VnVQwZ111zWOr6u+yF7NQDFmq7wsBWGojU96jZa0mn5CUzvQvk5Ls
         txegAbrMq2YvMiyntaiqLNj0ia5yLp4qyJg1917hdzFLz9grA5Je40rZ1fsjG80uvN/6
         N8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369089; x=1779973889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oPRoiP89QkO6oH3NtO+q0F6orRcQ/LGFJxe4k+Ya1A4=;
        b=kIOSWMXZiB7FHypuD2jvhyG8UfSKiiPhsHuiTKaRK3K3133hqZm6Xd96HiEA0d5Tw5
         t6IcoviivurTcEt9/JlNlosGNysOriNsoCC7YgaVeNOUK+7fIkzi49Qrqx7xTH9G56fH
         4ctZOJUZH90nVx4C78z0riU/8FiKzU0ln59Rqhr/C8/2BtYz9jsd+ndEZep72fngvNE0
         8YOCurABB8ALGTX6oi8GcEXE/Oxv9o0Xp792CM6uMTyU4e40adA63bUv08zL/78GZqaz
         +AQFewZI0fm1LTyMkEKJ0LyLpPX9Zt0KjFm/s+y0QkqUEQ/S1VZh6iqIk7H1TfG84Lb+
         0S4g==
X-Forwarded-Encrypted: i=1; AFNElJ+Evw9xAuabpmBzumMs1FSb5LhYR288f98SDFopJyJXMCGcpw7iJj8JJmhIfjbfiEW92Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK8TyCzSNXTD3n6F/tyo0IlXb6EeSn6Hdj/uH2HT1MdENvYR2K
	Ai/lun1TSGiKt+OFo753TDiXdh4YyJwmeEvk0jWedtG50y833RNhh+HATzwsz7UCRmr/XHJtpnJ
	JC1yOv5qczvaEy58tpS3Ww7mofPrMofc=
X-Gm-Gg: Acq92OFwcrbq4pYtVvpM0LawKBrZwr4ixvDn/8NI864Z1MrD8pIxBnKtkbDeHvrZoXP
	0i83ezWT+eknygoCDE1vRZDRPD2gWA5WR5H6+jhEvXOQ9C08Sue0bDjZdgFLAscpoF/aWtMvgbY
	SzGlDiUetfo/Hxc+Jqzv5ThBNS904OBKtUqNTT1QcI64XaaI07v53+dFv5UZHaNS4piCewMi4sY
	DyLeJJTFyAng/FkreCD4ODcp7ohXrnvgxwIQ26ypQElFk/31INP5M/P/SgQcNOCFr+Rvz4lM55X
	P8a27wfbhTPiBc8rnTMDY3xboBjLTRqB5JcUayE=
X-Received: by 2002:ac2:5ed9:0:b0:5aa:b6b:796f with SMTP id
 2adb3069b0e04-5aa2bc916bemr719139e87.43.1779369089186; Thu, 21 May 2026
 06:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <20260520004244.55663-4-kerneljasonxing@gmail.com> <ag3c9/EF4h7DLQu3@boxer>
 <CAL+tcoAvbEZ7U2oXBWwLAKeuC==gAHi=GXLZcrEPxbb4mQ9sfA@mail.gmail.com> <ag70RrU4nGy0Nlna@boxer>
In-Reply-To: <ag70RrU4nGy0Nlna@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 21 May 2026 21:10:49 +0800
X-Gm-Features: AVHnY4Kwv3EeqRw8Jlv440foRrB0qmD4hhTs741XyLFsgNn7yl66c2alVXVDX24
Message-ID: <CAL+tcoAHnVDOFgmUvi1jfTdTHchxdUrRYppenQ6Ubiwyv8jmUg@mail.gmail.com>
Subject: Re: [PATCH net v4 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 8:02=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, May 21, 2026 at 07:53:27AM +0800, Jason Xing wrote:
> > On Thu, May 21, 2026 at 12:10=E2=80=AFAM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Wed, May 20, 2026 at 08:42:42AM +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVE=
RFLOW,
> > > > only the current descriptor is released from the TX ring. The remai=
ning
> > > > continuation descriptors of the same packet stay in the ring. Since
> > > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > > leftover frags and misinterprets each one as the beginning of a new
> > > > packet, corrupting the packet stream.
> > > >
> > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occ=
urs
> > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raise=
d,
> > > > so we have a chance to examine and handle the potential remaining d=
escs
> > > > of this big overflow'ed skb.
> > > >
> > > > When the last fragment (without XDP_PKT_CONTD) is processed, the fl=
ag
> > > > is cleared and the loop continues to process subsequent descriptors
> > > > with the remaining budget. This behavior follows how previous xmit =
path
> > > > treats overflow packets.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp=
.kernel.org/
> > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on T=
x path")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/net/xdp_sock.h |  1 +
> > > >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> > > >  2 files changed, 20 insertions(+)
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index ebac60a3d8a1..8b51876efbed 100644
> > > > --- a/include/net/xdp_sock.h
> > > > +++ b/include/net/xdp_sock.h
> > > > @@ -80,6 +80,7 @@ struct xdp_sock {
> > > >        * call of __xsk_generic_xmit().
> > > >        */
> > > >       struct sk_buff *skb;
> > > > +     bool drain_cont;
> > > >
> > > >       struct list_head map_list;
> > > >       /* Protects map_list */
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 0a6203c42576..f4add7be8c93 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -1062,11 +1062,30 @@ static int __xsk_generic_xmit(struct sock *=
sk)
> > > >                       goto out;
> > > >               }
> > > >
> > > > +             if (unlikely(xs->drain_cont)) {
> > >
> > > Hi Jason,
> > >
> > > could we get away from introducing dedicated boolean to xdp_sock for
> > > handling this rare case?
> >
> > I've tried several ways, but they didn't work. Please see the short
> > conversation with Stan:
> > https://lore.kernel.org/all/CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=3D=
uxd2McuR-w@mail.gmail.com/
> >
> > That means we always rely on a flag (that is either static or like
> > this patch) to recognize how we treat this abnormal descs.
> >
> > >
> > > > +                     unsigned long flags;
> > > > +                     u32 idx;
> > > > +
> > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, fl=
ags);
> > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.=
addr);
> > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_loc=
k, flags);
> > >
> > > It feels a bit off to do this cleanup one-by-one.
> >
> > Actually no, it adheres to the basic send logic in copy mode.
>
> Not really. Here you are producer to cq which we have batched variants fo=
r
> usage.
>
> But after second thoughts I don't think it would be worth to put any
> further effort onto optimizations here. Anyways, even though generic xmit
> is a whole bunch of mess, maybe you could pull this out onto a helper
> function?

Sure thing. My takeaway is that it will be refactored once as the
batch xmit feature lands in the tree.

Thanks,
Jason

>
> >
> > >
> > > I wonder if it could be covered by xsk_drop_skb() where you would wal=
k the
> > > tx ring and store addrs at xsk_addrs and then use xsk_cq_submit_addr_=
locked() ?
> > >
> > > OTOH, in theory the amount of frags after we hit the overflow case co=
uld
> > > be well over MAX_SKB_FRAGS again so xsk_addrs wouldn't be able to cov=
er
> > > them.
> >
> > Right, this is why we now put the logic into the xmit path just like
> > other kinds of descriptors. We need to check and send it under a
> > series of protections like the check of cq pressure and budget. I
> > don't think it's an exception to escape the check logic. The whole
> > process should be fast as there is no need to build skb and send it to
> > the driver as long as this case is recognized.
> >
> > Thanks,
> > Jason
> >
> > >
> > > > +
> > > > +                     xs->tx->invalid_descs++;
> > > > +                     xskq_cons_release(xs->tx);
> > > > +                     if (!xp_mb_desc(&desc))
> > > > +                             xs->drain_cont =3D false;
> > > > +                     continue;
> > > > +             }
> > > > +
> > > >               skb =3D xsk_build_skb(xs, &desc);
> > > >               if (IS_ERR(skb)) {
> > > >                       err =3D PTR_ERR(skb);
> > > >                       if (err !=3D -EOVERFLOW)
> > > >                               goto out;
> > > > +                     if (xp_mb_desc(&desc))
> > > > +                             xs->drain_cont =3D true;
> > > >                       err =3D 0;
> > > >                       continue;
> > > >               }
> > > > --
> > > > 2.43.7
> > > >
