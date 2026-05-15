Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF493F44CE
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859673; cv=none; b=KL1O+oUoHfrdQYJx3GB0M5Vg/Xw7waE2b452KI8u5bcfFLJCrx0i6twkB6S/U4sS9KxszRAQ5kQCCgKaHOYP8OnYgSZ0f4FIWxr4V9RvtblA5zhBi2vHhmsOUxAbrzQ61vwGGTUJctE0ZJ16K/DwxySC1zKLLx4Y625g1GRBVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859673; c=relaxed/simple;
	bh=enzv6N0QCiqfkNtjs/94FtsKlI6TpVoKaDPEWI1KWEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHYICRQtHsX+H7KPqlEhXJ4r+7TlOwxfc8aRS+NltHU40gTkK16vTxSeyFf3FRatA/+c6FVZYrqhOD3OQ5UDosgTLV5i6Thxwau9ugASALDfdsQLcCdzXmUDulQmgZrY1Yrk5kfO3NIbIikHwiy3hcG7jr9ELbKn3hjcKoHzjJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/nxhxjJ; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/nxhxjJ"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-835386ff122so9006963b3a.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778859665; x=1779464465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gb6mWUFOgGMdl96ZRrsaW/Iiz+8X35ZZDW3pFeC3q5c=;
        b=Z/nxhxjJVb3DGWwLaMI5Jwrzkg0e38jcSoYdJn5zbPag4NuMPcJ7zYDfGk0iUX45Mb
         7N//cFPF2JKXuQK+pa/rWfTV8mylRWH67hJixQ21rTLPQvW74vLYU6asfbmaDJXRTd7g
         +qjGRUwEF9AkBWOAebfQptTcvuC3xLAjRRgGpi4mMtLhE49AAEWgI+wSojbViYri0EIU
         4AJZyN40O83AoC3wuFP1bI5jbODETy0LQjtgvPq3J1ZpxukcP/qKQWJEa3V4Hf3HPob3
         7QgbdTswVVjdErlc01xZPd4gRUdslZgoL4sJRNR8g3T50Zn3YiZihe4i8YktavfQN/7e
         7DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859665; x=1779464465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb6mWUFOgGMdl96ZRrsaW/Iiz+8X35ZZDW3pFeC3q5c=;
        b=g/6ny7VQATmpwPKtdpe21hIYGhUsBS6z5owFVEmJ+XBzmhsyRiQKzFPD53iQ7/XF04
         UWK17FO6KFNLSUoruRruAg9Ovaw5zUZIGP17PKY5+FEHuoMvU6RzLcKaQyRKxRh77M07
         OmJpjZNJjkgPBKKuAwLzJwFQjPHuVIdJWGw9RHa6vjHX2LS4r29klPdtl8mCupGYbLJY
         bIKA/u63jzU3uGksUpblKsh9NMriGCcjxoCppDF13HiQowHum2aXuxIb0WGVnEY5Acjh
         yEd+psCh6nbVsJ1R+2ahikBhFZ52N1Mwy7eeLPkH1A3NtDNJNsfUHfc808aVQU7v8Amu
         rODw==
X-Forwarded-Encrypted: i=1; AFNElJ/YIREPxc2/VGGaH4OM5pgszII+SIhWyfAnUtteq3ybu8OHKVHRVDNDCTXMoLwVWHsluQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNh1ldzvO39PHW4y0QTmf78GB8OOXFtyp/BKesVv3Hy6ZrVr7l
	fbx6BXGs5US6VbQTzhtJ02cTaMu542adtyNknzJiyu4ul+O14SAmVaJc
X-Gm-Gg: Acq92OGsOETRPfYHTdrLb0IFgHBI+i12M1KGUQvnJ/NfIaNxki62DF2pJ2Rcm9wY6oo
	RwMkyef8mhtG8SQntdz5R2OD6d0z1DcCwS+1N9YdLVTKs9f3XjUVPv9IXSpGATCPwKlGerQ5GiU
	zFtGOO7DCjMJB1K3AZN2mHbiu2kKExPTuCKcLcF0tmsKCdhyVyEX0rKyqgs9FI+ovI8fG+K3qb/
	6Dtzc7LvBuKHhDdXfXvNOBWd5mK88q7+PIouHG1eI8CWLvCgmpT4RGpZtwAWYAXG3+8YLE498Bd
	o0YMyeypkZO+EtGspmo9cyqdfCGBrohnofXVWxJfbOZXS35+/i9HT+2Vwc3JPQWrsQKkGZrOSso
	9NWW4/KbZXy+HTuIpV366V05eU1e3YlQMV+xmchEO3SaMG2ofEB6dK3HT74HBE5YIbQf1+SE3fZ
	C4ILtxPNSa3WUVhewl
X-Received: by 2002:a05:6a00:12e7:b0:821:7d7e:41cd with SMTP id d2e1a72fcca58-83f33aeb06dmr5353877b3a.10.1778859664787;
        Fri, 15 May 2026 08:41:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660f9sm8235975b3a.10.2026.05.15.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:41:04 -0700 (PDT)
Date: Fri, 15 May 2026 08:41:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in
 xsk_build_skb()
Message-ID: <agc8xgt2wXI-1ryb@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com>
 <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
 <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
 <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>

On 05/15, Jason Xing wrote:
> On Fri, May 15, 2026 at 8:29 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 05/14, Jason Xing wrote:
> > > On Thu, May 14, 2026 at 12:27 AM Stanislav Fomichev
> > > <sdf.kernel@gmail.com> wrote:
> > > >
> > > > On 05/10, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLOW,
> > > > > only the current descriptor is released from the TX ring. The remaining
> > > > > continuation descriptors of the same packet stay in the ring. Since
> > > > > xs->skb is set to NULL after the drop, the TX loop picks up these
> > > > > leftover frags and misinterprets each one as the beginning of a new
> > > > > packet, corrupting the packet stream.
> > > > >
> > > > > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > > > > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> > > > > The main TX loop in __xsk_generic_xmit() then handles continuation
> > > > > descriptors one at a time: each gets a normal CQ reservation (with
> > > > > backpressure), its address is submitted to the completion queue, and
> > > > > the descriptor is released from the TX ring. When the last fragment
> > > > > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > > > > function returns -EOVERFLOW so the next call starts with a fresh
> > > > > budget for normal packets.
> > > > >
> > > > > This reuses the existing CQ backpressure and budget mechanisms, so if
> > > > > the CQ is full the function returns -EAGAIN and userspace drains the
> > > > > CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> > > > >
> > > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  include/net/xdp_sock.h |  1 +
> > > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > > >  2 files changed, 23 insertions(+)
> > > > >
> > > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > > index 23e8861e8b25..1958d19d9925 100644
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
> > > > > index 3f1e590c855d..232dd7126905 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
> > > > >                       xs->tx->invalid_descs++;
> > > > >               }
> > > > >               xskq_cons_release(xs->tx);
> > > > > +             if (xp_mb_desc(desc))
> > > > > +                     xs->drain_cont = true;
> > > > >       } else {
> > > > >               /* Let application retry */
> > > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > > >                       goto out;
> > > > >               }
> > > > >
> > > > > +             if (unlikely(xs->drain_cont)) {
> > > > > +                     unsigned long flags;
> > > > > +                     u32 idx;
> > > > > +
> > > >
> > > > [..]
> > > >
> > > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags);
> > > > > +                     idx = xskq_get_prod(xs->pool->cq);
> > > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr);
> > > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, flags);
> > > >
> > > > Not sure I understand why you want this if you're still marking the desc
> > > > invalid.
> > >
> > > The key point is that as long as we read the desc from txq, the desc
> > > should be either put back to txq again or publish it in the cq (for
> > > application to keep track of this) at this point. Or else, the
> > > application will lose track of this desc, which breaks the whole
> > > logic.
> >
> > Yes, makes sense!
> >
> > > > > +
> > > > > +                     xs->tx->invalid_descs++;
> > > > > +                     xskq_cons_release(xs->tx);
> > > > > +                     if (!xp_mb_desc(&desc)) {
> > > > > +                             xs->drain_cont = false;
> > > > > +                             err = -EOVERFLOW;
> > > > > +                             goto out;
> > > > > +                     }
> > > >
> > > > I also don't understand why you want to return -EOVERFLOW again? Why not
> > > > (quietly) swallow these invalid xp_mb_desc from the previous packet and move
> > > > on?
> > >
> > > This particular desc is really one of overflow cases, right? We should
> > > warn users to handle this with this error code.
> >
> > Right, but didn't we already return -EOVERFLOW to the user once?
> > The part where you set drain_count=true will -EOVERFLOW. Then this
> > remainder will also return -EOVERFLOW?
> 
> Right, my intention is to alert users twice under this kind of
> circumstance. We silently drain the remaining portion of the skb the
> second time, which looks a bit strange, doesn't it?
> 
> >
> > But let's maybe step back, what's the expectation on the user
> > when we return -EOVERFLOW? In theory, the user can re-submit new
> > shorter packet (at the current prod index), right? And then your
> > !xp_mb_desc logic will break/swallow/-EOVERFLOW it?
> 
> People would be aware of the skb that is too big to handle when
> receiving two times of overflow warning. To put it in a simpler way,
> the second time in xmit path only handling the remaining is enough, no
> more descs that belong to another skb should be taken care of.
> 
> If the user is able to quickly react to this case, I think the whole
> skb should be re-put into the txq again instead of adding the
> remaining part. I'm not so sure if I interpret the "break" correctly
> here.

Let's say the user puts a packet with too many descriptors. We find that
mid-way and return -EOVERFLOW. What is user supposed to do with that error?
In my mind, the user should drain TX ring completely and start posting
shorter packets. You seem to be trying to handle the case where the user
leaves the remainder of the previously EOVERFLOW'd packet in place, why?
