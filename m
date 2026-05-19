Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690E2AD03
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 23:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232876; cv=pass; b=s76Sb3YU8skEkFNt3rwITdepcb+F9UWyPABVkfiTTL4FwOG0OMGg3FU6efwLAs3e8t2jpQtUOMD4A/oG551ibdiJB41zudkvXQMvTrW2Uy74scz4Ge8vRVonR/fcQg83XuvaOHbhFwyOGot6Vr16uIABWi089yHt9Gxm9DaiSX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232876; c=relaxed/simple;
	bh=0HJvPMskz64iLjn658sJLzxp9W4oeojL4y/6CD2PAjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0dyUjff3mt4dJSyUJG5qAdqm+Y8q8V//FNHhSzxbw6u8zVv2ZfuVrQMOqraUxSqqUrv2BwitpUqZrY8ZgldTvAydGlz3Ut1yXJPr/dXEryP6CL3PHNw7feZk8qBJd5+hVYku6VdvuAEKITqfxGW7VhuVk9c7LZ+fv9H+PRnuKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nc7yzXCV; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc7yzXCV"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39380e79936so45113311fa.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 16:21:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779232873; cv=none;
        d=google.com; s=arc-20240605;
        b=eX4hmiyBTnuVmQzN4+OxuSHuTLqxMypRrvIxDCl5kWaQD4SU6KEi52SSzCIoFyBBB1
         Wl4Zcm2C7NckIF36avy0nZ9wClULLSylsyIiZYvCRa5jmpUU3yBfUWFztzmplvPTsIwj
         dEHd8Uv8/0QYt/DzReNM7YPG4hDlWcuE90DeTheV9BvRz1HNg9xeU1xAqhVcrPh7ZveJ
         ooDmI5p0x/D0Cj9Wl2qY3z51NJqbkzDYkVZW5GW2ZO2YaDZlmhSTH7bywrlEBTfDnrpE
         vW42j1HNKIpN1imHSyFi51XtnX+yrFrWzE6ZX2Emd5JL12OJk7A5zxipIZKfANggj4nv
         2p2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FtDS8H6/4LJAue06gEKQz2TXraZRCihB+Ehk4X15M/Q=;
        fh=SYpGfGUbcXhVaNlNIeUWci4UtzsV57Hd2ijtFe9McA0=;
        b=cT4GVFaoNggH3dqRo+GfMseQ9TsxdhLE9mzqkVL0+0yXW0XTnOugaTyzJ7Ed0oZlmT
         AwXVfaSi0OKEdndIbzdDcsCuaH+Xl19S1GO/54W5LlkuGoCpbG7WBMXesJ/RnKxPb3Zx
         rD3G2terWJgIuE9HgIP5KRzurbBEbBmg5ldpGLHN1ODM0vcZZSW9wrw9EyRWLSFsyou+
         SQUa3U4xGM7XNmHteh+yoz5o8Q8T7sMYtVGcz49ha+sFhDdIq01gx60AS+u6zjcoFm2h
         CIHUDDo9iAc9bHuI9WPyKOecgcUQDSU29lyzjmayeKgycVjw1yXZUCW+L6FpguIz1wFo
         N8cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779232873; x=1779837673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtDS8H6/4LJAue06gEKQz2TXraZRCihB+Ehk4X15M/Q=;
        b=Nc7yzXCV/oU1PGv5K9KYQYZELZ5CGKjkoTio5DOY0bMop8Jeay3sb63oiJvwX5+cHO
         0TMg9zBzip8n1Q4XKlHGO/XoSJ+qq2+bVizoWF6yGtbmoCco18cqEYpKdeZPGSbMf7aP
         fv1Dzn38geGtGQ/QcDVE5lKrvUp88LU/+7HpH7TZvJfv5znYTqSCb9jwNQcuPsLp7qL0
         8QiJnNoZwr2peghyYMRlAsh3kRDIACDB3a5w5djw0DYzBlTaX8rI9s5tRdEbqZftnS7G
         zenW6v1XGQcFfK8lQS0mdlzvIx1Hstr/LYykI/mGTVLQsbV6NNPwP2oYD0MbIoqPqGHp
         ZK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779232873; x=1779837673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FtDS8H6/4LJAue06gEKQz2TXraZRCihB+Ehk4X15M/Q=;
        b=Ayl4+3MDFCdb+bvPkIQrsirGYXnD124eJgg1AlxHaX1fUuDldsI4SnzgvEYU0CKJkY
         Zr4b2YTCCyb+HyDTJJNtUl/VxgzXelhg7wl2FhLVJjXDWfJnGBisq7m4i2ieHY6ha3w+
         9OCflwqUaD8St6HLiJ5+7/3qB68mZt7qnBy0rde1BOw/+gS4R6O2GPg/+g1L5LbDAYqa
         7DVRC9Hg+2QGITpVkEkfUTzm7kzSiIh637MhV4qgKg3I+0K4NMr92aR3UZ5kyzbRtthf
         SiIlMRp2uSYHKS99vYPflz5SvT/YJdOJ/IChPqauAvoNKr/pACOUVgCK06jBuwUBXtCV
         lpnw==
X-Forwarded-Encrypted: i=1; AFNElJ8triycC3DInPJqMRf4icr/dbI4OSYLYa/rT7Nq6BpiPC0B3mDGF6sy1d6u49Gt5kxnziU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQdoY2ibgE7xfBaVS4MexH8RlZjkDZcfsUxaZJDNCSG4S0T/k
	ugzGeVBbgVI/dglsVyLrWuh5oRn3YN+w+rQm+PcfqLRrKh5g9+uZyrBMsRc1iA1GPUtyckfOzVD
	BjyHk9xXrrDUMdi5yvPYyLQJTLMilsjs=
X-Gm-Gg: Acq92OGUFnolECqXfo5QBP4OaaMPrjeXwgfa7fACNviVYmI2Y79PVrNYtPXv4wDw23a
	6/VP7k6Oldbn9mUG7st3iYLxDSri2ucNjT9dH4YRZ/6qhJ78bL5/Dgn6Wvrp0mWGGkH/0SFjNNM
	e5lIx+i/vCtqXEnXXfR4/aPYRmzH7hMk0roNX347JJKQMnwe8dhFAlrDV+O00w3Ga+X8aG+SDK2
	dqeOZE04HMZrhrKLT7Ljx4fpLtzKhxYCIsolirXdPHcD7KvX0HmiBNkGMkxCbQwf7VzdfbAIuPS
	01oC977b95UlAIOqknNz9geJX2jSwtkoFPs6qCI=
X-Received: by 2002:a05:6512:b07:b0:5a8:6e64:a932 with SMTP id
 2adb3069b0e04-5aa0e769bd1mr6901985e87.32.1779232872772; Tue, 19 May 2026
 16:21:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
 <20260517063311.28921-4-kerneljasonxing@gmail.com> <agzTbgnDCd9DkPOz@devvm7509.cco0.facebook.com>
In-Reply-To: <agzTbgnDCd9DkPOz@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 20 May 2026 07:20:34 +0800
X-Gm-Features: AVHnY4JEfXwtFT7bIRXYGiyd_zeLKnFWHRb69nrElUL_D-JJj9Wh5C0s79DQrL8
Message-ID: <CAL+tcoCWs+kor-Uxkbwb9q3+mW2Mtw7eEevUo51LqzdvPJx8NQ@mail.gmail.com>
Subject: Re: [PATCH net v3 3/5] xsk: drain continuation descs after overflow
 in xsk_build_skb()
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

On Wed, May 20, 2026 at 5:19=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 05/17, Jason Xing wrote:
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
> > budget for normal packets. This behavior roughly follows how xmit path
> > treats overflow packets previously: stop sending packets when detecting
> > the desc has problems. Here, it is stopped only when this group of desc=
s
> > from the same skb are completed.
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
> >  net/xdp/xsk.c          | 19 +++++++++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index ebac60a3d8a1..8b51876efbed 100644
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
> > index 0a6203c42576..298194b7335e 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1016,6 +1016,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> >                       xs->tx->invalid_descs++;
> >               }
> >               xskq_cons_release(xs->tx);
>
> [..]
>
> > +             if (xp_mb_desc(desc))
> > +                     xs->drain_cont =3D true;
>
> Since you're gonna be addressing sashiko comment, should we also move thi=
s
> part to __xsk_generic_xmit? Right after err=3D0? Feels like having
> both true/false/check in the same function is a bit cleaner?

It makes sense. Thanks. Will do that:)

Thanks,
Jason
