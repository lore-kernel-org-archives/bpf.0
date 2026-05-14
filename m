Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D4175A68
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778718128; cv=pass; b=rUSn14+OC4ini4i/PReAwk8meXHh6zovfdMSMhXlKPIz8hZHqcxHAifq7i7nkkQRBtIFcVScLlcDyLJCunb1u5YP1wvSCb3U6ShYjjrNnBxqPZpiu6dBNVAYVvk1r53TNzBiqokq8ZHfT+05ZwEqzmtBrAhfFZdLdfK5jDVGz2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778718128; c=relaxed/simple;
	bh=Lc3oSZlCUzSkC3rQNdwVLXb9YFU0HUcQgXJicIKmQws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSD89k+9okWH7ICV1KxXGv5ScfEa6I5M6jEc+zXDTJRnl9lDip/GBSD5mFpeFWIol8K5+d/0ERQwNewGBvTEptcJqNYMj3rgJ0jRJZnx3jyTkQjl2IbILTLOAcz04Aud1/Zy95w59Qc80Z3KNhBHtvroz24UEszaiKssQFoZ5UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slJoRPJO; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slJoRPJO"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a865d1547aso7441048e87.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 17:22:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778718125; cv=none;
        d=google.com; s=arc-20240605;
        b=Hb6RzTtQWLG5E6SmbJJe43q52x7nSic5L+EGAE3uM/aSwm6XATNpDeXsx6KVOpuRbt
         cjCNuPm144IE/TN8vghM1tBQ8veC/ffuzrbowwfZdIt734OW6/vna7DCP2q1JcMWZUOp
         31yAyz8uJsNNnVadErcZEc8C2oz6tT4fgZ5pyhUNUztbI8aRz/oZOPM/lgs+ru2aa5a9
         ptbAeBU8z7NmmBosKR+lzNrD628PDUNuKwTeEfApF2kucjJxL5jeZK4ldBgA/g2pP2WC
         vewqiHOFKNX6+1SiKAHneSZf2wBvuEe4ZGwbuspoz0zRXYK+KZUnpMfQ66pXSzq8crqP
         veeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=elklsPS7/fsP24AvxZDwbdGxgVD1nkLgFN6em3Wy+xQ=;
        fh=TSZd6tuBzZMw1P+wvpfZecvq0DCBHqm01qsWEBq4Fdk=;
        b=OSW7doVfVT/pqB5dIO3uh07/IgfK787hZjmMOqnPn1EUO4mmGUgKAEq3sFtTv6a0M7
         fFb2wodmm1SNs1287Bbe3mFGARm/WFqMA8v7SKziaWxgplU/HP2FhlGpIydhxSDmLVOq
         IDCsa1hw6J+Xed6nozvktt1u+EL04UYC0BJY4ma05TS+Nlu+T453VwrAvAI9Y+9VedO+
         wZaUSBpZiphsM8UBb3xFLYRV1SwpZCsEKtoIk9RKFvL8ib3jqvWYfJNPWiL3XHWMxWvO
         ZnD1qyOPVx+V740OCnCOqKvIBBeAMRz9x23islgR0HfvZgGzM6Rb+AeBJ7xrjFXNG8Xg
         fiPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778718125; x=1779322925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elklsPS7/fsP24AvxZDwbdGxgVD1nkLgFN6em3Wy+xQ=;
        b=slJoRPJO6hG6tmQTgrsCNyH5Vds0effki7Ww1NAyd/JtfOmlypN23BFawL+Ft/jHLM
         1eZlr8BhL/5VtYnLli269EgvRvxqu00jit0jtZdUYyPREukLQk4uUFZMt6g9DiV89AqI
         SuvBMKpr12OLhFRZ7XccYGipem53+xtn0u6j4WJ+j3kfWwLVFS9W+rJWvtmEXBjZZLEO
         L7aOAQ+Vu8n0de9PXFGNIzo2Aj6PBB9NlutgalHdI5uLflXzA0dbSAr5i8FAYL+iiP2E
         afyWmGF0e9mHIZhNnuBE4cv2yZEIJgApUtBTHhaAQuO3lEkXPtVgmUNCMpxSGTasH8g+
         yLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778718125; x=1779322925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=elklsPS7/fsP24AvxZDwbdGxgVD1nkLgFN6em3Wy+xQ=;
        b=lfo2NYi341Z3oXla8XKz8CX320Uv7b0ZWFGTro0TT6imd89zlHube4sn6vpI1/UNvX
         pZfrVlZel6TztGG6SekSOtcxRmnDtmw+qOJ3U8dNF1q1QXEkinr8POR2iO6cg3dHMlMR
         jpmyu/fmwk0DWDq8Vchvp2WD/0BDmaV6lvn6JanQVqUr7XZh0Q2bKsRgReAdAXYu1Flw
         NGeejrZ78fdXs0EA69+UemTYH2EXX6OPFFlS5M9sDb1we6NNICSCYpd0Xfruo2ht3pia
         kT8nZTzl67L0JVpfX1+z5zLNOtnlQ2gw+LK0uw93gV7bnMUkgjZl6f2ynsJPizN1YAic
         VPdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eFO06lbTX5i8pqTaoy5JC3xAvFaAs0z5D/Yob/GYCDcmPcCMaNnhODyyuFhFU5PSsr7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsvi7D3Sv6JrYy2B6a7rtwYX3N2kHILD9tQGNsOdi/l4YT48+
	3mcMIldDsoauE8L0p071qkY7C4Y/aJ2B2z/R+dTDn2C5nPI3tng4akOk1nmdxM0t98HV46z60BE
	gelO+rtb8laEVOUdPADCymuEdwfCHCXU=
X-Gm-Gg: Acq92OGjh5EGZhEOAzO+Kv24B73wz7kflGiZLfKIi+7GCzVtvqdhj/w10EDJygghEMO
	GESLwyeB+0tiqB3rofExVl3OxIYKuy/Le8aCKPXMB3MLbq3CXVS2BBXG1YX/UNddIuHDv6r5wSF
	XtKlKL+1wZeTMSmTYALdE5H79/G5gbNDxLgVqMNnqSsiIN6IMO5WEzlqL16cSCjyuJ7p4pQrFyz
	GQDGYRGo+TYrqPjiwqMrcxlGP2aF+WuTGKKDW3WxivNWNkBKi/0a1LUU87r9A9j8/s4QxP06WlS
	MC7LoHMGrp574l0xAnixEebgGjkavJWzOOYgcqw=
X-Received: by 2002:a05:6512:3705:b0:5a9:61:91e9 with SMTP id
 2adb3069b0e04-5a9006192e1mr235422e87.5.1778718124774; Wed, 13 May 2026
 17:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com> <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
In-Reply-To: <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 14 May 2026 08:21:27 +0800
X-Gm-Features: AVHnY4Kr3pySaOM1DVuwqCO--aBL0CRlKfLqwTONR5pH9ZZWjMsLo8--RWbgeNo
Message-ID: <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com>
Subject: Re: [PATCH net 3/4] xsk: drain continuation descs after overflow in xsk_build_skb()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 05/10, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When a multi-buffer packet exceeds MAX_SKB_FRAGS and triggers -EOVERFLO=
W,
> > only the current descriptor is released from the TX ring. The remaining
> > continuation descriptors of the same packet stay in the ring. Since
> > xs->skb is set to NULL after the drop, the TX loop picks up these
> > leftover frags and misinterprets each one as the beginning of a new
> > packet, corrupting the packet stream.
> >
> > Fix this by adding a drain_cont flag to xdp_sock. When overflow occurs
> > and the dropped descriptor has XDP_PKT_CONTD set, the flag is raised.
> > The main TX loop in __xsk_generic_xmit() then handles continuation
> > descriptors one at a time: each gets a normal CQ reservation (with
> > backpressure), its address is submitted to the completion queue, and
> > the descriptor is released from the TX ring. When the last fragment
> > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > function returns -EOVERFLOW so the next call starts with a fresh
> > budget for normal packets.
> >
> > This reuses the existing CQ backpressure and budget mechanisms, so if
> > the CQ is full the function returns -EAGAIN and userspace drains the
> > CQ before retrying. Zero buffer leakage, zero packet stream corruption.
> >
> > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.ker=
nel.org/
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx pa=
th")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/xdp_sock.h |  1 +
> >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index 23e8861e8b25..1958d19d9925 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -80,6 +80,7 @@ struct xdp_sock {
> >        * call of __xsk_generic_xmit().
> >        */
> >       struct sk_buff *skb;
> > +     bool drain_cont;
> >
> >       struct list_head map_list;
> >       /* Protects map_list */
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 3f1e590c855d..232dd7126905 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >                       xs->tx->invalid_descs++;
> >               }
> >               xskq_cons_release(xs->tx);
> > +             if (xp_mb_desc(desc))
> > +                     xs->drain_cont =3D true;
> >       } else {
> >               /* Let application retry */
> >               xsk_cq_cancel_locked(xs->pool, 1);
> > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       goto out;
> >               }
> >
> > +             if (unlikely(xs->drain_cont)) {
> > +                     unsigned long flags;
> > +                     u32 idx;
> > +
>
> [..]
>
> > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, flags)=
;
> > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.addr=
);
> > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_lock, f=
lags);
>
> Not sure I understand why you want this if you're still marking the desc
> invalid.

The key point is that as long as we read the desc from txq, the desc
should be either put back to txq again or publish it in the cq (for
application to keep track of this) at this point. Or else, the
application will lose track of this desc, which breaks the whole
logic.

>
> > +
> > +                     xs->tx->invalid_descs++;
> > +                     xskq_cons_release(xs->tx);
> > +                     if (!xp_mb_desc(&desc)) {
> > +                             xs->drain_cont =3D false;
> > +                             err =3D -EOVERFLOW;
> > +                             goto out;
> > +                     }
>
> I also don't understand why you want to return -EOVERFLOW again? Why not
> (quietly) swallow these invalid xp_mb_desc from the previous packet and m=
ove
> on?

This particular desc is really one of overflow cases, right? We should
warn users to handle this with this error code.

>
> Also, have you considered doing this drain in xsk_build_skb error path?
> Is it more messy? Carrying this drain_cont across the calls seems a bit
> too complicated (but idk, maybe the alternative drain in xsk_build_skb
> is even messier).

Sure, it was my first version actually. One of the primary reasons is
how to handle it gracefully when CQ is full? Then those descriptors
can not be processed in this loop at this time and will be delayed
until CQ has available slots. Another important reason is that I want
to put the whole read process under the previous clear logic in
__xsk_generic_xmit(). Some protections like budget/batch still take
effect in this case. In this way, there is no strange/exceptional read
process in copy mode :)

Thanks,
Jason
