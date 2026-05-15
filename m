Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B433BFAD5
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812619; cv=pass; b=cIEouzf0mYXoXXLQqFYy1p2HZ5JU3YotsVg8OoRmBVocUveJiIfkHUuTlrXDU8eMZs/VGCKL4dV3UO6m1l5jyBsROFF63YTChhSN6RQQyKgjhF+EBdiX9tNxHRg1nhrUhmdGlBVQDpXvFgcIlgHmPjErcBa5ICYaouC4TQMHDws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812619; c=relaxed/simple;
	bh=jQsBjTgYWRd37BoT8zL4I69YBxXmzBFQDBEBiWWlxX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsCOP50TQgxlEw0wR1kHoY9UiHoKmutfHA/GbWhZkjmRikUDlona3z5wTkfCSsTXSaLrXlvV5bvrPpx659fP3UCJixF6dHjxwU1A0YtGbTQ9BD+a6M5qukiAlWgLdt3tGtedU89ZdBYyQIeYTtcCZPkQW7UWo5E2Nnb/DwCUidU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuyB+/zT; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuyB+/zT"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39556b00a85so9458361fa.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 19:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778812616; cv=none;
        d=google.com; s=arc-20240605;
        b=VhFZLAKMLQzCd5zfP8CJExTcYVFIDOgXeA81r61wF+mqzT0DMXcgc96vEkomHecrQG
         mIEuoGSkyC4BfM2wS0wQ33ue38W1znvt8sZ3k12sefUYTr6Es/KZb3Ce6mIWsgELohqM
         M+V4rg/8Zsrk7uRcEHr6gRZqpHZpozDw8JVsaJpf/S9DwdMJwcVYUUKdVfvSb3vfei6z
         k62pMEYJ9NeKF9xQ0B4dnDLcl++D+HN2nNSw/V5Th61IX6S2Obi5I/uhy+Wa+gyAH1Oq
         YDTZyPm7WGys78U1DRkqWEEGSGskkj8PHCyVO6D+Spw8UZDKY4/Z3vlI/miY33pR9kts
         2jrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5H6FMgknlF6hNoIW+s8VHjozDY2P7YaikVATd/DLqo=;
        fh=IIuaCDKQ9PCOpQGIEtkUHk8f81G5VN6UxSwAT2EflVQ=;
        b=EiwRakAReq86d917PK6b/95p4JM/1Ur0EfZZPtfOPA8AIcoZ0+V+HwTU2pl3fVKZc5
         M/B41iOpBcJIeyD3a+q/e++mcaoGxi3Jrd81KoumPSSAr7pHGGWgnXxvbXUso+QnlCAS
         lULa+58ynk9llrvasvGman19af1tyC/9Hdittm6jebZ2wJeBF1HDDLQPP5PMSuGBE2h/
         JXhgQ2kZNh6ShUiPbIXCmt1ku3NjXQeP8828iv67OA1sTNFvuaT5MvvLQjfsKTcZX5yj
         Ccim/bRoWT7INPzVGL6a1gXdwLMy7mTH+/9GzQWbfqaq4O9WtpYlB3mqZXupUHtBVYpe
         I/kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778812616; x=1779417416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5H6FMgknlF6hNoIW+s8VHjozDY2P7YaikVATd/DLqo=;
        b=UuyB+/zTuEirv44YXPaeViTRGVgdkm4nKIpKPYKy5/EUWhq/w8UhV3lV/b25GQD1+s
         ZdWZ+ReAuhy0VzOjgqDmyBGSXy3KWkzIdjIGbkXnjZ1rsVHKR0arGXJf3ytAE/jUSKcB
         ttSABS790GjcbjXQLjYU+s2nwFiUOdPzJ1VD/mQQOqp3Zv9HtgDWKaEBsN3cZfqGp6b1
         Q8mYqQlS8XMQXrfnIRVcHO5bZuOa0rWCztAZwEmY3hTW6t/owcMuNxzR0lpkDlUPxqwo
         9sUitO2dLhxxooQXj0Z6vAQeTA2W9E4Js7zw5POf05k+3lBKDTbqohXpk2C0PUnfGk5t
         189A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812616; x=1779417416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5H6FMgknlF6hNoIW+s8VHjozDY2P7YaikVATd/DLqo=;
        b=Ob1H7/FHXwHKQaWiJvnqbofIOXMIPN6K7/uob2JljUKRFFaW3zEzEKrzIOvtxbPExD
         W5MAyem4Kx2GGOSsB0sWWmD0rQ9dydFCM6FTA0Oe1e7TKCa1fs9u2FS54dO+tS9lJ2Rb
         WQ7JybHF/OopejGG+q/eDpgCxGqUgiTgY//1BZ9NXTZKtyinjhJ4ntVIhuUGRQdcaLBz
         /sKnNQDagg/wx9LPaAsAFjRZjknUDob7UwnUUb6YEhUEgLiU3FIOUueij7ALnDQbK5xF
         kci6Tbj6XXhVFnd18hg/5aH45M1/Nrqa6/bl+nkZp65eHbSfz90PdN11T+fLgw7MCeTb
         loIw==
X-Forwarded-Encrypted: i=1; AFNElJ/qZ5c3JjGoxqqS+IoxiVzgcuSFuUyOyzobYQEKwxwhkqd9cjIozz2yUNclLXiPkWF2nXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQQdl6XCQbfNlOWCWXsXdUFbMgRMx+PowYkMiaMYaYjjzpP1P+
	UiS2BMf8mj2lOBrUqJJYru1ErxF+BKBH7XEhkZ8HUQmSNRr/zYP+X9+x3iWbZclUB3BqUaXJCXr
	76abxEpM77KufzzC/2JXMPVAGEwLHTyE=
X-Gm-Gg: Acq92OHL97JhsBOISHZsSHMS3d8s6mIt5kRvD/oEzCsKRfVTpyST0ST8H7IInxFHiCI
	Awc5Aa3MBPQfga6L186bMQhvL4swFNfwfIbZcQXyF1KPCme39gUpHJIQ85RMk61sQnxMoiIGepc
	fN6r8KT/7F51M4SkvkfJgVYGjTDHkrT9L95gQMJMdbel5pC7si37JXeLeYw2NkmiKVJj6Po+EmF
	z/83IbxDRjQevVQyQEXEP1ZTA4YU8BUxs4S9vdMull9ISPKw1hEU6++Ktx9S30eruvfTz1F6pFr
	BxFL966sqdZ00CKVRm7CO828ynlRLhpUO01DiOTUOK7hjxyhmtk=
X-Received: by 2002:a05:6512:1350:b0:5aa:1008:e174 with SMTP id
 2adb3069b0e04-5aa1008e225mr194321e87.9.1778812615698; Thu, 14 May 2026
 19:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-4-kerneljasonxing@gmail.com> <agSk6FPCDTBWMGpv@devvm7509.cco0.facebook.com>
 <CAL+tcoA6Cu3P-y2wYjJ_R9cSeRkW2tswY1LveqH=uxd2McuR-w@mail.gmail.com> <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
In-Reply-To: <agZnf78JR9pcLL3v@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 15 May 2026 10:36:18 +0800
X-Gm-Features: AVHnY4Kr9ja2kr2U3eHpbgYT2B_b5P94TRZKb5gOLDiiD0v_4nwor76voyumwGg
Message-ID: <CAL+tcoDA1tezc4XBUA1-4wDrpckXpQuPGFDsNPCkpUP4qyXeYQ@mail.gmail.com>
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

On Fri, May 15, 2026 at 8:29=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 05/14, Jason Xing wrote:
> > On Thu, May 14, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > On 05/10, Jason Xing wrote:
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
d.
> > > > The main TX loop in __xsk_generic_xmit() then handles continuation
> > > > descriptors one at a time: each gets a normal CQ reservation (with
> > > > backpressure), its address is submitted to the completion queue, an=
d
> > > > the descriptor is released from the TX ring. When the last fragment
> > > > (without XDP_PKT_CONTD) is processed, the flag is cleared and the
> > > > function returns -EOVERFLOW so the next call starts with a fresh
> > > > budget for normal packets.
> > > >
> > > > This reuses the existing CQ backpressure and budget mechanisms, so =
if
> > > > the CQ is full the function returns -EAGAIN and userspace drains th=
e
> > > > CQ before retrying. Zero buffer leakage, zero packet stream corrupt=
ion.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp=
.kernel.org/
> > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on T=
x path")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/net/xdp_sock.h |  1 +
> > > >  net/xdp/xsk.c          | 22 ++++++++++++++++++++++
> > > >  2 files changed, 23 insertions(+)
> > > >
> > > > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > > > index 23e8861e8b25..1958d19d9925 100644
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
> > > > index 3f1e590c855d..232dd7126905 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -936,6 +936,8 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> > > >                       xs->tx->invalid_descs++;
> > > >               }
> > > >               xskq_cons_release(xs->tx);
> > > > +             if (xp_mb_desc(desc))
> > > > +                     xs->drain_cont =3D true;
> > > >       } else {
> > > >               /* Let application retry */
> > > >               xsk_cq_cancel_locked(xs->pool, 1);
> > > > @@ -982,6 +984,26 @@ static int __xsk_generic_xmit(struct sock *sk)
> > > >                       goto out;
> > > >               }
> > > >
> > > > +             if (unlikely(xs->drain_cont)) {
> > > > +                     unsigned long flags;
> > > > +                     u32 idx;
> > > > +
> > >
> > > [..]
> > >
> > > > +                     spin_lock_irqsave(&xs->pool->cq_prod_lock, fl=
ags);
> > > > +                     idx =3D xskq_get_prod(xs->pool->cq);
> > > > +                     xskq_prod_write_addr(xs->pool->cq, idx, desc.=
addr);
> > > > +                     xskq_prod_submit_n(xs->pool->cq, 1);
> > > > +                     spin_unlock_irqrestore(&xs->pool->cq_prod_loc=
k, flags);
> > >
> > > Not sure I understand why you want this if you're still marking the d=
esc
> > > invalid.
> >
> > The key point is that as long as we read the desc from txq, the desc
> > should be either put back to txq again or publish it in the cq (for
> > application to keep track of this) at this point. Or else, the
> > application will lose track of this desc, which breaks the whole
> > logic.
>
> Yes, makes sense!
>
> > > > +
> > > > +                     xs->tx->invalid_descs++;
> > > > +                     xskq_cons_release(xs->tx);
> > > > +                     if (!xp_mb_desc(&desc)) {
> > > > +                             xs->drain_cont =3D false;
> > > > +                             err =3D -EOVERFLOW;
> > > > +                             goto out;
> > > > +                     }
> > >
> > > I also don't understand why you want to return -EOVERFLOW again? Why =
not
> > > (quietly) swallow these invalid xp_mb_desc from the previous packet a=
nd move
> > > on?
> >
> > This particular desc is really one of overflow cases, right? We should
> > warn users to handle this with this error code.
>
> Right, but didn't we already return -EOVERFLOW to the user once?
> The part where you set drain_count=3Dtrue will -EOVERFLOW. Then this
> remainder will also return -EOVERFLOW?

Right, my intention is to alert users twice under this kind of
circumstance. We silently drain the remaining portion of the skb the
second time, which looks a bit strange, doesn't it?

>
> But let's maybe step back, what's the expectation on the user
> when we return -EOVERFLOW? In theory, the user can re-submit new
> shorter packet (at the current prod index), right? And then your
> !xp_mb_desc logic will break/swallow/-EOVERFLOW it?

People would be aware of the skb that is too big to handle when
receiving two times of overflow warning. To put it in a simpler way,
the second time in xmit path only handling the remaining is enough, no
more descs that belong to another skb should be taken care of.

If the user is able to quickly react to this case, I think the whole
skb should be re-put into the txq again instead of adding the
remaining part. I'm not so sure if I interpret the "break" correctly
here.

Thanks,
Jason

>
> > >
> > > Also, have you considered doing this drain in xsk_build_skb error pat=
h?
> > > Is it more messy? Carrying this drain_cont across the calls seems a b=
it
> > > too complicated (but idk, maybe the alternative drain in xsk_build_sk=
b
> > > is even messier).
> >
> > Sure, it was my first version actually. One of the primary reasons is
> > how to handle it gracefully when CQ is full? Then those descriptors
> > can not be processed in this loop at this time and will be delayed
> > until CQ has available slots. Another important reason is that I want
> > to put the whole read process under the previous clear logic in
> > __xsk_generic_xmit(). Some protections like budget/batch still take
> > effect in this case. In this way, there is no strange/exceptional read
> > process in copy mode :)
>
> Agreed, given the fact that we need to handle prod backpressure, your
> approach is good (but see above comment, we should probably clarify
> what's the expectation on the user side).
