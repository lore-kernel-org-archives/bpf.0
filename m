Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7EB3C109F
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638936; cv=pass; b=bbiqBW1XyZhdWNPUtV0Pc3ktH0KnjcsBIK56k82jwXLQUDcNIE9I6jRLyRhHtA0KLuFCPWKWZM8OYPAWKhCVsV57rMKGCU+KWHtyE0biQpnmyoc29LSGTUPgVC3x+5DafwRKUgorZRdilapPFMWGPAurwWu8PVZGhsPC7wQzyD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638936; c=relaxed/simple;
	bh=1XJycN1eKzm1slwbyQsbcSHLl6wYSi/yDaumlrFerJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phmiaFzIjMm4/RSIC2bTIfXJvU0B63LV8eW1WKDrrZqCrwKJJkrwwXy6hhoD6UWHRZOaKtANCOFeVKQDm12CLguNVFXa2vmXpPw600lFNm7EjCa0pzM49B/ENUSnas/INeWyu21dGhC/bnsW98RWVcdjEpT6TBl2fSwEXk7kwx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp7dOIcG; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp7dOIcG"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a14f6613fdso47297101fa.0
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 23:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787638932; cv=none;
        d=google.com; s=arc-20260327;
        b=aKROJEt9abqR58jvjIsu77pLJYi57F3eE5AWWduXTVbDyRHW1vW/r0d+ffNnSfIls4
         MR9jVAUfECStVz+2IX1GVRwj/4cAvuiN4RM9Y8QWOKhI0dhoFnXjpXkBmgwERJeH8iu2
         GL8M6ifvjZlU2AO0ZEoRzKMfDMU9nyHKSHelozECYy8iQzweuZdfT60KdvSPKvs9eiMN
         CJphWS32k+rShBU989SMHaBYqlOOyzKdYSr7s4vs57VSvnGkj/lM1iVLHSu+xFhORldl
         0DukIEcCXZ9UTD5wBCYMGcBYPwa3ZcRQuQmB/pcZRud/wvnhaDQQpnjGsaPQEvxfGar2
         Kx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lmfxIomckmLv6QtHhQG41G6LPwKSajfTzLUuEWwyKE4=;
        fh=tXznerIKAIj4AlzLq8BB8FRO/VOAClgbFVW+aGPcWUM=;
        b=aTYaYeZu3iP3cA4xr6AGZ+5ib90cNsqAMBZ7HFw8Tr0Nq36odEQzx08AdYhk6t2GeM
         K0UoyitHWcMaido9eRr3kOX+jWNhBuHmZrUNQKmeFk1XICqFllXfcYr+fkstlmC1EUod
         cqEi8LoaRZR8bo/moJFujXTk+gOcVrLibyGVLcgOSISkm9IWptx+Dqpt4cJlp1jo4N5u
         l20rfLcw0DLG2BOGkIXwEAk6e3MoZE7IuIarsnw6myc1vLP9hP7KhFEJbzmr9YVshmpM
         Qk9sITznWUbNZ3OjpTmML3WDU3KjVI6V06ha9RJ/YwdVmT78eFwUvXpLIwQcqmAFIls5
         4LJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787638932; x=1788243732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmfxIomckmLv6QtHhQG41G6LPwKSajfTzLUuEWwyKE4=;
        b=kp7dOIcGaWAm6eyKL7k4efqwBdupV5Yug+k5mKsz4o0gnfhi4GOEZWpp8IkOUmviVQ
         JW3WvjYO0eJrxbdUzjfHFV3YqFXL/4FvmwHAlHxmn/aLjH8cJ1Ucw7Qti8Dk8vCqNNlF
         ks/OBA9FQyEOeAm7f1t0BHQggiJbCs9+Hgt8H1fBkjX74HjzsRDKw8il68BEL6eF4KFy
         GBgCp3tAvmU5W11dQcpM8vwEvrzdurhByaZgIfpnQZ82W/r4hVry1N8D9qHt6djOl/nW
         bHVsz0VqGx4vEWbNzVOT0UHrOg8ZSF9b8z3435AIVP3NxiD9POqPK+Ma6Ud8HKKhH1j2
         HwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787638932; x=1788243732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmfxIomckmLv6QtHhQG41G6LPwKSajfTzLUuEWwyKE4=;
        b=n17E32ctFsJf7q3Z+yDLkOYyTDztUd23novV1CV1touEAWfWIMaHIPEQYx/9xjhu+u
         GF4O6jk4D3g4KWzi2pCHlqGDx/Z2IveN9PvQ2MibX+AaefSJ6UsJqLSx06Gh/WEIbheT
         2s+9Ntd6qxSCy8OCAvBZTxdE3BiwiHmtiFk/lQNuwug5ZwG4LdWQnh9UTxIK73/frRDT
         nrPUwPLGGFlWjsq3U5rWsUoNMN69SVukb0Wmp5vsLGD4630bymnXufBwimVL1AapJ4TP
         MALT9CMwuxQf3jr9Ah/IjW11Fq5yWnJ7JckW59NoIxKkYiBC8+NOP0pHmInf6B/gGJum
         XbwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6QiMQDRJJx3dRewK8Ma1p7zR08qR8JsXrBa1R5wzU4+HAfGa6CnkzjO5ZBhFq6wpKrrc=@vger.kernel.org
X-Gm-Message-State: AFuF++lUEGcSijhoxMdrjtswN3Ya9FLEvN9r77UEdEKZfIRnt5mYUfMl
	tQpyk829Dr/7MqXnOkBnPXb/ENG7BrhNX6VD9UQNEueNwbNUezh4b13IrObdRmNJgpbV56pdCWL
	vOUEpZlnKFWJN9Vipt4XgbJr7nQkP5oQ=
X-Gm-Gg: AR+sD119t7COHtONxPTIxJ2zvqFM4dKmRX5clX7gp5/oGyCU+drko6U86gbk1/nxq+1
	FBw6SkKFj5n0eHdOlyh6RMCvBFxZQxVeeJBNAoeFjGe53SfP+MrNjvTMYkL7U6sNzDitRvQwSgP
	EJjDB/7K9E60QjYofo8arE0DhKRmMWVAQXbKdNlFKTBaYnT3qXHqSi4kFRz4C/vf+41p8XMGIwE
	qPvAGd0ouQU8kfJfCJDPj4TOwomU0TBaeEV69fJOh3Uvde3LW25OvJIes90V5kaGz/FUfDz76xY
	2acs6tq5pS8tuQuZVR9uD02PI6/ljcPo50cDHDAbiNNoO3hIdiNYLXVITUmkzXcrVKpahQ8CbXV
	uO/rMsYwYwConJ1f8xsomCuuT5bV05CYnHyXudtK3ZwaCJ5/ksgGeYZOuJEA=
X-Received: by 2002:a05:651c:3242:b0:3a1:11d3:173e with SMTP id
 38308e7fff4ca-3a1ef41de62mr8160691fa.14.1787638932016; Mon, 24 Aug 2026
 23:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817153957.3177627-1-poros@redhat.com> <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
 <CAL+tcoBX+3_oiy5KCtnBkjEdmDgzY6PYAT2oOqDSLXezDCFfHw@mail.gmail.com> <CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com>
In-Reply-To: <CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Aug 2026 14:21:34 +0800
X-Gm-Features: AcwNN1V7KGrHTI3nUtkITBErK4SK8jYm4mBMcZcrHQYCTHlnZyUa999e2sIfyTc
Message-ID: <CAL+tcoB80wATncgNQDnWS6-W+VxqiANph1ogGz6zLv0TKLxG1g@mail.gmail.com>
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
To: Eric Dumazet <edumazet@google.com>
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

On Mon, Aug 24, 2026 at 9:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Aug 24, 2026 at 2:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Fri, Aug 21, 2026 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Mon, Aug 17, 2026 at 5:40=E2=80=AFPM Petr Oros <poros@redhat.com> =
wrote:
> > > >
> > > > __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does=
 not,
> > > > so a frame taking the qdisc bypass path reaches ndo_start_xmit() wi=
th
> > > > the sentinel left by __finalize_skb_around() and skb_mac_header() p=
oints
> > > > 65535 bytes past skb->head.
> > > >
> > > > The packet socket reaches it through packet_direct_xmit(), and
> > > > packet_parse_headers() was taught to anchor the header by
> > > > commit c2707480cfbf ("net/packet: reset the MAC header on the
> > > > packet-socket transmit path"). AF_XDP reaches it through
> > > > __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
> > > >
> > > > ice reads eth->h_proto through skb_mac_header() on its ordinary Tx =
path.
> > > > On an E810 every one of 2817224 AF_XDP frames reached the driver wi=
th the
> > > > sentinel still in place, so the ethertype never came from the frame=
. With
> > > > this patch all 5757920 frames of the same test carried the correct =
0x88b5.
> > > > An AF_PACKET sender on the same port read 0x88b5 in both runs.
> > > >
> > > > On a KFENCE kernel that read lands inside the pool and gets reporte=
d as a
> > > > use after free of an unrelated object, 387 times in a 180 s run:
> > > >
> > > >         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xd=
db/0x1650 [ice]
> > > >          ice_xmit_frame_ring+0xddb/0x1650 [ice]
> > > >          __dev_direct_xmit+0x347/0x4d0
> > > >          __xsk_generic_xmit+0xc13/0x1e70
> > > >          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
> > > >          xsk_sendmsg+0x6c/0x90
> > > >
> > > > Rerunning the same reproducer on the same E810 with this patch appl=
ied
> > > > produced no reports and no bad reads.
> > > >
> > > > Anchor the header in xsk_skb_init_misc(), which runs once per skb f=
or
> > > > both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not=
 a
> > > > real header, but it stays in bounds and no such driver reads it.
> > > >
> > > > Fixes: 35fcde7f8deb ("xsk: support for Tx")
> > > > Signed-off-by: Petr Oros <poros@redhat.com>
> > > > ---
> > > >  net/xdp/xsk.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 7855ee09c4b640..885427392cb6b3 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *sk=
b, struct xdp_sock *xs,
> > > >         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
> > > >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> > > >         skb->destructor =3D xsk_destruct_skb;
> > > > +       skb_reset_mac_header(skb);
> > >
> > > I don't know, I had at some point the goal of removing our dependency
> > > on mac header in ndo_start_xmit(),
> > > as this must be skb->data.
> > >
> > > ice could use skb_eth_hdr() instead of eth_hdr() or skb_mac_header()
> > > and save few cycles.
> > >
> > > Some drivers call skb_reset_mac_header(skb), this is really a mess.
> > >
> > > With AI these days, it should not be too hard to completely remove ou=
r
> > > dependency on mac_header.
> > >
> >
> > I saw the status has been changed to 'rejected'. Why is that, I
> > wonder? I think it's just a fix that can be done in xsk like
> > skb_reset_network_header() that I'm going to add.
> >
>
> skb_reset_network_header() is orthogonal.
>
> Patching net/xdp/xsk.c (and follow-up network header resets) only covers =
one
> caller while leaving the core issue open.
>
> The discrepancy is that __dev_queue_xmit() unconditionally executes
> skb_reset_mac_header(skb), whereas __dev_direct_xmit() does not.
>
> As a result, other paths bypassing qdisc hit the exact same out-of-bounds=
 read
> in ice. For example, AF_PACKET with PACKET_QDISC_BYPASS only resets mac_h=
eader
> in packet_parse_headers() under:
>
> if ((!skb->protocol || skb->protocol =3D=3D htons(ETH_P_ALL)) &&
>    sock->type =3D=3D SOCK_RAW) {
> skb_reset_mac_header(skb);
> ...
> }
>
> Any PACKET_QDISC_BYPASS socket using SOCK_DGRAM or SOCK_RAW with an expli=
cit
> protocol (e.g. ETH_P_IP) sends an skb with mac_header unset (0xffff senti=
nel)
> directly into ndo_start_xmit().
>
> If the core stack was expected to guarantee mac_header for direct xmit, t=
hat
> reset belongs in __dev_direct_xmit(), not duplicated in xsk, packet,
> selftests, etc.

Spot on. That's a general approach.

>
> Work in net-next would presumably audit / change all drivers to not
> rely on mac_header
> being set (This I can do when net-next reopens)
>
> Then we can remove skb_reset_mac_header(skb) from __dev_queue_xmit()
> and __dev_direct_xmit(), and from dpaa_tx() / dpaa_tx_extended()

Thanks, Eric.

But my minor confusion is that the current patch still holds for the
older stable kernels, right? So it seems reasonable to accept it in
this way since it targets the net branch?

Thanks,
Jason
