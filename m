Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC5423A85
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577279; cv=pass; b=PDViDosOpX3rC3mg6IZ9P2hXWm4Xey8fKmnf6uPW9VeTzDm/29ecMmd3ACW3XhuB1xbU+FLInyxuay/HY2XXVE3+d9iVUQBJvsG8y+an9egEoQ7ljwB+7XLSY9srbgrReB3MvsinqKKPuY+UPiBrntHhl6vsSizrNnMWj+Qummo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577279; c=relaxed/simple;
	bh=H9ESRqbYFKIzVphlKxi6kHHfLBQ/3zka1Lcl3k+zGKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJ+hdfTqmMsHG7DlHt0ZVj0XuHu51XtkxwajVZeqHvPTKOJIAtLPzYzIZRum2+B6SP3Lo6M2uuSzqJwi1IhOy7+EeqVEDT3+Po9VjCkuvcZTup4ljwA5hr2Q+Ykw5CXQ1rkxupmUyt+ytpMXlkgiSNEHqZhcWKW1lpYDyTP3i0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NYrFf1gd; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYrFf1gd"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-841f1dfc30fso61490477b3.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 06:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787577272; cv=none;
        d=google.com; s=arc-20260327;
        b=lNXYLXIRfzISlXzRE+xncF9AHhvDpQvczi5xGrzqlTfdb4g3sWdkxEheC0ooPqWYKF
         g/vNH6tdBAHhydwp6nYadjSQEIfIwG/sS/ztjZum+D2pMES5khoqAMoX2zB6CLN1sQlg
         Vt9o+9qhPtKqBDneSfiy2NvYXXrGZxZ0rQTwEMxiOzvFvlEI1gB9JWXSI4eIxaWAOu8U
         GYknT59d2fw5tXbZmjFnAd83Hrp4uCx8ewxTzQEyuUjTWeC1vvThEALlkdRLD2Dp/lW5
         mQqRL8A6AJsqS0CoXwE9KnQoFhiKZ55T5MsO3Yd/zOZnrZdRgwvrno1zyWOJGkWoklRf
         Z/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m4A5oM0s12UDxTBgx5tT3y/RZNqLbYSEaj9e4gxD5is=;
        fh=HzqyG/YIgusRQkCSZ0HndiveuBBxKFoDZUOQ6zi95oM=;
        b=NsmYkj9D/Y1aXCarp+5+2hoUdKdUkCa9jalz4lkdmKTyZlk2fOhiWBHHskFKR4xipa
         1w++zS7eRl9861vwRpd/uGunFtQt2HlfitKoFnsg/lrpgUWPaj+8V7zelPV7sI7yBBeR
         WrwhZCXQmW0YnKh/p7dNrTjokySikqi27s3izLu5vlt+D8yAB1T8eokdZu1EOn1Yn7bx
         i0CrGgl1FTWWXi+925Z8VmIxKncYBmznWphDHGQhBPVLYc3ZXodtFV/MQ1v29uIUUAqO
         PW2dDldtDj+f9TER8ETJM8Q8iDVq3yf11c77+bXmLzwI7jqvGaJ/xIPkihjWAp2lJN0Y
         gDfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787577272; x=1788182072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m4A5oM0s12UDxTBgx5tT3y/RZNqLbYSEaj9e4gxD5is=;
        b=NYrFf1gdnDspYhhpfZzvi0hq3PA6KoNtaG0H+Uwt9KNnzRhkIZn6/CorKt9XW19cP8
         7VU7kYHSC5EowFgyyB4u9iHu498KFRLTvyYQ8iI7Cb2UKJc2v2E+DhxnGpueV7lD/dvg
         n/h0/68+2g1sVlmJfIekaHJoPDElJxLTb3g5ooCIDJYIf2U7V+uO2vu383QfocC/Tm2u
         8yGNs291H77pD7d3Q5P0Pu4dFGyXPHGfiYN4aA0kKhcdyEtRZymOOOgJIjzRIs8SRK0S
         TKlSSNQCm4oatjI6KnM4HysOdhDgSUEBvNYezuNplR/C+CXf8pZ3Fnuv8WBVCW9UF9Qn
         lP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577272; x=1788182072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m4A5oM0s12UDxTBgx5tT3y/RZNqLbYSEaj9e4gxD5is=;
        b=Bgw8tozecewCQmw0Q6rUXn1+p+LCgFQ2VntB42gp3x6nU2FFm0DuYcUfHWQvLlNyWX
         U2Gagv0d4ui2biqEp/mlOAdrSVfLvWFZ1TMNhHuEYSOARx5LXJsdjBC+/nY7TQtmPNi/
         sTnAYFKsFa4FAFC7Y+OFcO7iLUIGbPe/RFCxJbRt3E8DOnoMmrYhQs+n/WjYG1zqUDPB
         58s0U+MdtegRIZ8OOMQ0gAj79XjwlQ5XNtsd2NzI4Qk0OIVyBAvWjmLiFswPeHQumndt
         a+kjW/PyNQGtNbSN/vY5VsCL73JNMmruI4F7UnzfWFGo1MxRnefzXa+neofz5P/t5+vi
         1Muw==
X-Forwarded-Encrypted: i=1; AHgh+RqheSS/XXuNmbnDPzrRsj21ZUqi0rFOen1fkqEY+prAILUST7EyrUohbCjoNa3ZLzCT4z4=@vger.kernel.org
X-Gm-Message-State: AFuF++m+L3hjyfXnTxFGFyYbZAKqFgS4Qw6qkdC1wMFpQhKSmN45XY/C
	pvQq8E/VcPFK+HB9N1oVBnfR1/vxO7UstXAlpmQadsPDKktrSLAPePWumPPkZEAAq1CXfiGkPvh
	twyAsxh7zrM4UMfg60ktYpFWkVI8MincbOwkKXxY5
X-Gm-Gg: AR+sD11KzEy/S8qAFq0LHoYwp2lW5/0z3iIWU10+wxMK45I54CYR7NSmBkGh7OCzpuC
	8/R2GNQODd9yto5nUHHgmBfgKugtj3cM24cs5HcFaOcID3LGs7dHG7P338KXRtV3vGYY4A48Wtr
	L/t/Sq5XDRnWuEgO3To3vRlUmq+bTAV1H10iBdqkK4fznbRWWNW7clX9n+h7Pk+P5l5EGmGkuAd
	Nrd5RiPoEQ5gD4YuZC//v25YIlm6Nb01KSQOq74SvSxwp3tmoq0wjBkMuL84YpLafaUOWBoQHe9
	swMMoNfJ2E/FA7Y633uMQt834l+47V6DVx/bu1u5X261hItWMq9ZzKFWp8rYBhob4dEBc/iGLeR
	ysmB4WPpdGAYdQqDKkVjBPij/aoo8v/dA4Od9JiRsfjU5HaBo8c7eWNYRDKBa4+KSP9k=
X-Received: by 2002:a05:690c:e681:10b0:80e:c332:1796 with SMTP id
 00721157ae682-8470b3d3316mr89912227b3.10.1787577271496; Mon, 24 Aug 2026
 06:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817153957.3177627-1-poros@redhat.com> <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
 <CAL+tcoBX+3_oiy5KCtnBkjEdmDgzY6PYAT2oOqDSLXezDCFfHw@mail.gmail.com>
In-Reply-To: <CAL+tcoBX+3_oiy5KCtnBkjEdmDgzY6PYAT2oOqDSLXezDCFfHw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Aug 2026 15:14:20 +0200
X-Gm-Features: AcwNN1Uv9lIX3zmkxdB3EjIqAVKKZ0pLsVj08EKSHGvCV-nTg0FsVN0v-Sg6ExE
Message-ID: <CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com>
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 2:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Aug 21, 2026 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Aug 17, 2026 at 5:40=E2=80=AFPM Petr Oros <poros@redhat.com> wr=
ote:
> > >
> > > __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does n=
ot,
> > > so a frame taking the qdisc bypass path reaches ndo_start_xmit() with
> > > the sentinel left by __finalize_skb_around() and skb_mac_header() poi=
nts
> > > 65535 bytes past skb->head.
> > >
> > > The packet socket reaches it through packet_direct_xmit(), and
> > > packet_parse_headers() was taught to anchor the header by
> > > commit c2707480cfbf ("net/packet: reset the MAC header on the
> > > packet-socket transmit path"). AF_XDP reaches it through
> > > __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
> > >
> > > ice reads eth->h_proto through skb_mac_header() on its ordinary Tx pa=
th.
> > > On an E810 every one of 2817224 AF_XDP frames reached the driver with=
 the
> > > sentinel still in place, so the ethertype never came from the frame. =
With
> > > this patch all 5757920 frames of the same test carried the correct 0x=
88b5.
> > > An AF_PACKET sender on the same port read 0x88b5 in both runs.
> > >
> > > On a KFENCE kernel that read lands inside the pool and gets reported =
as a
> > > use after free of an unrelated object, 387 times in a 180 s run:
> > >
> > >         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xddb=
/0x1650 [ice]
> > >          ice_xmit_frame_ring+0xddb/0x1650 [ice]
> > >          __dev_direct_xmit+0x347/0x4d0
> > >          __xsk_generic_xmit+0xc13/0x1e70
> > >          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
> > >          xsk_sendmsg+0x6c/0x90
> > >
> > > Rerunning the same reproducer on the same E810 with this patch applie=
d
> > > produced no reports and no bad reads.
> > >
> > > Anchor the header in xsk_skb_init_misc(), which runs once per skb for
> > > both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not a
> > > real header, but it stays in bounds and no such driver reads it.
> > >
> > > Fixes: 35fcde7f8deb ("xsk: support for Tx")
> > > Signed-off-by: Petr Oros <poros@redhat.com>
> > > ---
> > >  net/xdp/xsk.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 7855ee09c4b640..885427392cb6b3 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb,=
 struct xdp_sock *xs,
> > >         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
> > >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> > >         skb->destructor =3D xsk_destruct_skb;
> > > +       skb_reset_mac_header(skb);
> >
> > I don't know, I had at some point the goal of removing our dependency
> > on mac header in ndo_start_xmit(),
> > as this must be skb->data.
> >
> > ice could use skb_eth_hdr() instead of eth_hdr() or skb_mac_header()
> > and save few cycles.
> >
> > Some drivers call skb_reset_mac_header(skb), this is really a mess.
> >
> > With AI these days, it should not be too hard to completely remove our
> > dependency on mac_header.
> >
>
> I saw the status has been changed to 'rejected'. Why is that, I
> wonder? I think it's just a fix that can be done in xsk like
> skb_reset_network_header() that I'm going to add.
>

skb_reset_network_header() is orthogonal.

Patching net/xdp/xsk.c (and follow-up network header resets) only covers on=
e
caller while leaving the core issue open.

The discrepancy is that __dev_queue_xmit() unconditionally executes
skb_reset_mac_header(skb), whereas __dev_direct_xmit() does not.

As a result, other paths bypassing qdisc hit the exact same out-of-bounds r=
ead
in ice. For example, AF_PACKET with PACKET_QDISC_BYPASS only resets mac_hea=
der
in packet_parse_headers() under:

if ((!skb->protocol || skb->protocol =3D=3D htons(ETH_P_ALL)) &&
   sock->type =3D=3D SOCK_RAW) {
skb_reset_mac_header(skb);
...
}

Any PACKET_QDISC_BYPASS socket using SOCK_DGRAM or SOCK_RAW with an explici=
t
protocol (e.g. ETH_P_IP) sends an skb with mac_header unset (0xffff sentine=
l)
directly into ndo_start_xmit().

If the core stack was expected to guarantee mac_header for direct xmit, tha=
t
reset belongs in __dev_direct_xmit(), not duplicated in xsk, packet,
selftests, etc.

Work in net-next would presumably audit / change all drivers to not
rely on mac_header
being set (This I can do when net-next reopens)

Then we can remove skb_reset_mac_header(skb) from __dev_queue_xmit()
and __dev_direct_xmit(), and from dpaa_tx() / dpaa_tx_extended()
