Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BB37757D
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752089; cv=pass; b=qfIS/ZPEeW+ENJCuLMeJ9wgwNQ03joRJb807K2tSXFd4CnUMMfo5fJs4DM5FWqp+Gk1BZinJ6reIKdWLm/w9YMF3wMoop8o7G6u9w2xtx5FRPM1hfHRGNZio05IEo0u06N/M8ojmx/Q9g3TeTred1/DQzodqHbjf+9w9sEPSmvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752089; c=relaxed/simple;
	bh=gAGAUv0xZN3unMadQ+Q0yg6cGFB8E+F+y+wNougceUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7LvC5AwV43wTjHeaGHzmXrCVT0swnbFlzgQ3O1tHn9y/PLyb4hg9z60V4jKgMfZHdSuBbdQHyAE6RjdPPuBj0YHCaQid737QixfC1gYcMzJfocBGfqMGzuM/QmBz0KKmUqh84UcEIupr0ZQN1xPQX/WrO5eRqy5NrD+wrDlGKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJf/F4UL; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJf/F4UL"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66807ba2f0fso4562805d50.3
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 03:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785752086; cv=none;
        d=google.com; s=arc-20260327;
        b=KNA62hvwWvTKjAqCHkJgzHf+IED1U/j7jPS61hrWokLU43Ci9LuaWmsgOUEzghJNtm
         jkAdRKViAhxYbPkuBql8aWVvzX85jf9NK+FH7z1yqZPPwi4CwzAuAAPKbu/8vbc/lTvP
         S0Hjz+Ke2WvsoUHcwsLhevIvYwfoNN8bm6xdW9Qq+oeSfDVxNlOylVnYfavSRKKgzkYa
         TxTO7TVIm7o3gyRxuTPKatYRUdnulejLFdHa1lSNR2iO+8tkjrP+UsJ3F0r7UipaRAV7
         PWJCVavCZO09O/CcPZNMO/j90cXMg/4dQWr2tgkKhorOVJVvZfaSfgl0CWq5Ui3XOVkm
         2BZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BzmVrf3A5yS5pBlOOrTATRIeczmTdyqSxUxktv0y96U=;
        fh=FWM9lHjBraw64J1actj3TBwFs2Cs739fUYuurhFfQj0=;
        b=JhMuc8PsNp5/4bU0h7/SEC4JMa5JAq8v7H0c6jQGleYSFpZOUE26/vpu2BTt9dD5xI
         5yspoNDMOGH1OKv/x3nibp4eO/Nzzj+sR0GqC6qO6+dj0ypBdzgUihqvCIVu7NBySIFU
         YR3pNrnziFcZ+BjbXOa8qym6MgZb56ZPTqVAv/J2vHjRnFfVkmgyv6BOkSTVhP9Wpt0M
         tiqR1Mo8ulOok0A5aO+CMWeJIxwZDQrrt4oEoJfUztlLOGC8SZKyMYJ25BI0KI+oMblt
         5UlSafiFBFXRoDVnPMdwkT/0G6J96Q07oZtXuFXbkw6Y3QX1rgl5Nh0Pddey3KKaDZBu
         Dz6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785752086; x=1786356886; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BzmVrf3A5yS5pBlOOrTATRIeczmTdyqSxUxktv0y96U=;
        b=eJf/F4ULf+4f76f8Q/NN/yD7rLBvEv6Zim1LMt8046dW/OeU1xjUtqrIZfVlSERmN1
         7Qd1Z4Z+KWEHVv7clMkcwonP6sygNbnTfNd31lx0Jbl1Qiav/Ldkf4kFXsyIrbI7foMk
         lFsWnV7XotIMAR/1rB7mU/0RcQ0PBWerMI4W+HVREg7CwIy+tXXtbD4S8IVMcr47/BIX
         2sBWNzQMWbnbYIUncUzhfCYnxWm9bxzba6xqwp65Qs676u78TUfgNNbED8WePG5DiaID
         nLdpMDWL9u77jl8sEubLn0dCZP9V3S7Sgkt5LQewzr4vDY/9fVZTcT42g+suUham/e07
         KJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752086; x=1786356886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BzmVrf3A5yS5pBlOOrTATRIeczmTdyqSxUxktv0y96U=;
        b=fdvrhI//gQZQHsnQrQBbcvm263+Q7Iu1iQU4iwDcCpSAoMy+bOfg/HryznXR5OsnbO
         ifj5V8LDCmiKf2cP9T+hefN7t4sSxiX0a+y64W+i84PavZmoxkYDZGU3ripa2imqflG9
         bK5XDRueENkqk7wUPcDu4nkAoEd0TTidtYZmWi5Z107SWaG9wmc/o+mB4weSikQ7Dhrj
         zXuyCvZ5XESrwtm76RW3goYAJRCaU7J6L5EMLwB22xpLVjaW5LK9NIhHmGXCRPmbVFTp
         iB486XBudfhxUN7fI5PLqwik2Olj4bZUuY72uTnlMv6ABIhwPmzLw1cyklzpxVI8lgpO
         RTJw==
X-Forwarded-Encrypted: i=1; AHgh+RoHvneW8O7d7rjnU7SdXx76Md1HK/3fPj2QIGkb9vKt0ZGJHi//c4jeDl7hz8QdM5a7fts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxt63rA0G0vvz2dd9x4nHG8oxvk2i4m0EVKMBOK76ZACCT9j1j
	Q0ngP+5inE9Af3D4dUfxXg499ucfAUfZib1XpJPVDt6rEDyW/Hx33yO/Jma5QdON15TTMYelMUw
	VDotV3FyNUUS8fS0lK51tinjYjI8E+Tk=
X-Gm-Gg: AR+sD13bawngO3dXNNZzExX43B82jt6MQmret6Mj5YnBdzs+CIN16g9eH76raLRTt6g
	j1J/dN4aixVT5u+FojomgXeKXKFoUD7qGg0uTOZ8gQ3od6RkhUk9UrUr91aET89J6lxWI1GM9W2
	ZxW8dgRqFe/xnQvFQ26v3sx+FlrdESrFdxh7AHQhhzwNLjkkDr9Qs5O9T05ByrsaB4QxDSfV6FE
	LJK0S+VDSi+3eX4pkgg3r5GabK258yeBECXgHUbiN6ZZHI6eEL4AiYo52E3PvT6KDCVevqx8o/z
	I3OF10NA55NPC3zsZBXHS4eE8SWmk1uZ/hV0SPRDMHY00BvEgT0bVffU2j4G/cG8Lou3wy329W1
	pk+XnUuDxxvZwyYsWct2vRMQ=
X-Received: by 2002:a05:690e:4810:b0:664:f064:f663 with SMTP id
 956f58d0204a3-6694f15a12cmr8115341d50.28.1785752085633; Mon, 03 Aug 2026
 03:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
 <20260731032357.6114-3-sun.jian.kdev@gmail.com> <80687d9c-9c27-494c-b3f2-efd0230b1895@gmail.com>
 <CABFUUZGTJptpOKKAeU3ThibmPpXize4Eud2=EBX-vqaX3YH4pg@mail.gmail.com> <anBUWIxmURvbr04i@lore-desk>
In-Reply-To: <anBUWIxmURvbr04i@lore-desk>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 3 Aug 2026 18:14:34 +0800
X-Gm-Features: AUfX_mzdeHrInwG6bTPBGc0xnW3lweBnwEFe9T99a8tN3R763lJ6zfwZrV1QoDY
Message-ID: <CABFUUZGYauuj1EpwzfhwWrqQY8zaE7SFk-UAbwxy3qCbEDWKjg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] veth: fix skb length accounting after XDP frag adjustment
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Krishna Kumar <krikku@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	maciej.fijalkowski@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 4:42=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
>
> > On Sat, Aug 1, 2026 at 12:14=E2=80=AFAM Mohsin Bashir <mohsin.bashr@gma=
il.com> wrote:
> > >
> > >
> > >
> > > On 7/30/26 8:23 PM, Sun Jian wrote:
> > > > veth exposes non-linear skb fragments through an xdp_buff. If an XD=
P
> > > > program adjusts the fragment area, veth_xdp_rcv_skb() copies
> > > > xdp_frags_size back to skb->data_len but leaves skb->len containing=
 the
> > > > old fragment contribution.
> > > >
> > > > After a fragment shrink, this makes skb_headlen() larger than the a=
ctual
> > > > linear area. In the reproduced UDP receive path, __skb_datagram_ite=
r()
> > > > copied 1024 bytes past the actual linear tail to userspace, startin=
g at
> > > > struct skb_shared_info. The copied bytes included the affected skb'=
s
> > > > nr_frags, xdp_frags_size and a kernel pointer from
> > > > skb_shinfo(skb)->frags[0]. Real packet data was displaced by the sa=
me
> > > > amount and truncated at the end.
> > > >
> > > > Subtract the old data_len before replacing it and add the new data_=
len
> > > > afterwards, keeping skb->len and skb->data_len synchronized.
> > > >
> > > > The fragment accounting must run before the linear tail adjustment:
> > > > when bpf_xdp_adjust_tail() shrinks the packet into the linear area =
it
> > > > releases all fragments, and __skb_put() requires skb->data_len =3D=
=3D 0
> > > > by that point.
> > > >
> > > > A 60000-byte UDP datagram on a veth pair with MTU 64000 was shorten=
ed by
> > > > 1024 bytes from its fragment area. Before the fix, all 10 runs prod=
uced
> > > > corrupted payloads. After the fix, all 10 runs matched the expected
> > > > payload exactly.
> > > >
> > > > Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to acc=
ept non-linear skb")
> > > > Cc: stable@vger.kernel.org
> > > > Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
> > > > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > > > ---
> > > >   drivers/net/veth.c | 23 +++++++++++++++--------
> > > >   1 file changed, 15 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > > index 00e34afd858e..348391e87e14 100644
> > > > --- a/drivers/net/veth.c
> > > > +++ b/drivers/net/veth.c
> > > > @@ -865,18 +865,25 @@ static struct sk_buff *veth_xdp_rcv_skb(struc=
t veth_rq *rq,
> > > >
> > > >       skb_reset_mac_header(skb);
> > > >
> > > > -     /* check if bpf_xdp_adjust_tail was used */
> > > > -     off =3D xdp->data_end - orig_data_end;
> > > > -     if (off !=3D 0)
> > > > -             __skb_put(skb, off); /* positive on grow, negative on=
 shrink */
> > > > -
> > > >       /* XDP frag metadata (e.g. nr_frags) are updated in eBPF help=
ers
> > > > -      * (e.g. bpf_xdp_adjust_tail), we need to update data_len her=
e.
> > > > +      * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contri=
bution
> > > > +      * from skb->len before updating data_len, then add the new o=
ne back.
> > > > +      * This must precede the linear tail adjustment below: a chan=
ged
> > > > +      * data_end implies that no fragments remain, and __skb_put()=
 requires
> > > > +      * a linear skb.
> > > >        */
> > > > -     if (xdp_buff_has_frags(xdp))
> > > > +     skb->len -=3D skb->data_len;
> > > > +     if (xdp_buff_has_frags(xdp)) {
> > > >               skb->data_len =3D skb_shinfo(skb)->xdp_frags_size;
> > > > -     else
> > > > +             skb->len +=3D skb->data_len;
> > > > +     } else {
> > > >               skb->data_len =3D 0;
> > > > +     }
> > > > +
> > > > +     /* check if bpf_xdp_adjust_tail was used */
> > > > +     off =3D xdp->data_end - orig_data_end;
> > > > +     if (off !=3D 0)
> > > > +             __skb_put(skb, off); /* positive on grow, negative on=
 shrink */
> > > >
> > > >       skb->protocol =3D eth_type_trans(skb, rq->dev);
> > > >
> > >
> > > I am most likely missing something here but what happens if we have
> > > frags and we attempt to advance data_end while leaving some frags
> > > present (e.g., bpf_xdp_pull_data())? Looks like, in that case we woul=
d
> > > issue __skb_put(skb, off) with off > 0 and we would hit
> > > SKB_LINEAR_ASSERT() because skb is still non-linear?
> >
> > Hi Mohsin,
> >
> > Thanks for catching this. You're right that bpf_xdp_pull_data() can adv=
ance
> > data_end while leaving frags present. I'll investigate this path and fo=
llow up.
> >
> > Thanks,
> > Sun Jian
>
Hi Lorenzo,

> I guess we should implement the same approach used in
> bpf_prog_run_generic_xdp(), something like:
>
>         if (off) {
>                 skb_set_tail_pointer();
>                 skb->len +=3D off;
>         }
Yes, that makes sense. I confirmed Mohsin's case: bpf_xdp_pull_data()
can advance data_end while keeping frags, so the current v2 can hit
SKB_LINEAR_ASSERT() through __skb_put() on a non-linear skb.

I tested the skb_set_tail_pointer() + skb->len update approach locally
with a forced-tailroom reproducer, and it fixes that path. I will fold
this into v3.

Thanks,
Sun Jian
>
> Regards,
> Lorenzo
