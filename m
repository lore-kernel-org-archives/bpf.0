Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352444;
	b=HI7ra9WbnvxUmZOBRFi0XCewCweAEqdq6GUyPN26IZDP6KrlVu0XWfok1Y8QOIlpgs9J
	 D0vyZQlAmJOWGVvQZDKXaOE1iQL1TLDaHn7nMjWqXX3wmz+ulg2N+m0aR+T7EMJJOaf35
	 qffvbZEx4FmTiI+eVbfZpZJztBX3zN/K2OxPT4Y3KjseJf1Xi17wa7qEqPFYNj5ZwllMD
	 gntPKKiEIPkwbB5PF/yNRU5H4WHJf6x7xbPTmdGCdi+WTIo4I0T0wrNUeH78DYJ/AW12X
	 ZamLOTqJWNRLKukwE3Ujr9R/+Kcm7eytXNUJFA0qfGsQA0krMQmVmmQiQPG4jpcK8kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352444;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XpPOMbTanyLL1MaVenpd+9dFSgUty7k/DJCEJhgMbaA=;
	b=NQvqAAwczmXtOOAuZ8Xv16KiyvvYUTHr/Zxwqv2bSZhC80RvCE4EC9RZJxYYvGPiAe6F
	 dtitme0PuZS84P4QecM2bYbMFfm8waAPtjHfjJyVdBRCEex+yB152m/Gqr0YBWhMzhnlb
	 TgFiDGzSrALZEcdW87Dv9WdD+DqNCV9A0/4fAWDnW1ShRv3haHvr4toWlbg81+uHLV6Gu
	 fpXbD4Mj/nZg/d/mhBpipSctbd6JG+42tb7Xtk5PTLe0qMXic6bCkKKYSaXSh/w8dCRYB
	 bKtwYx0oHKNOtvKTG6TuQWlXAcJlxpJwYAJ9VhwE7DbUdKSoL3k+WbjXSTu//ooQ6IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drCZPP2U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12390606A31A;
	Fri, 30 Oct 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drCZPP2U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AF21F000C1;
	Fri, 30 Oct 2026 09:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793352443;
	bh=XpPOMbTanyLL1MaVenpd+9dFSgUty7k/DJCEJhgMbaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=drCZPP2UoLwd6pJnJTRElBjdiOrYo5djwqv/8kmgGvy8OYOLb0gSQ7vZj+lQ5UH0b
	 mjF9SOlH2i0L+ILKPoeeFXezH/3vwbauPRaxohqxE3oNfVQ6qWnFPuBvLhdtQ7uXO5
	 +yVtHYhm3rwTIyHv5sO+9Rwgx9axsm6Ivrhun81tWIwoT48FCL5OiCWUu4BJ07Tg6J
	 HWLCDq/vtHaAfdP1uzfMFQRQJeCWz5pl0ptX2yVWLMY11ug88zcSCWZ9jTY3aUuxtJ
	 9Ql4bLFGPvUSSwhZNDWaIM+2+0yHU42J8PGJyOVZIJz/JtfaNEhftD3Mtumr/KNzBZ
	 +cI+rvLL0K3Og==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Jason Xing <kerneljasonxing@gmail.com>
Cc: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>,
 Vladimir Oltean <olteanv@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
In-Reply-To: <CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com>
References: <20260817153957.3177627-1-poros@redhat.com>
 <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
 <CAL+tcoBX+3_oiy5KCtnBkjEdmDgzY6PYAT2oOqDSLXezDCFfHw@mail.gmail.com>
 <CANn89i+aacS2PfaMXnimzGgbCLz-JSnqo6QyoS122Gf+kxya3w@mail.gmail.com>
Date: Fri, 30 Oct 2026 10:27:20 +0100
Message-ID: <87o6cb4jyf.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Poking this thread again.

Eric Dumazet <edumazet@google.com> writes:

> On Mon, Aug 24, 2026 at 2:47=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
>>
>> On Fri, Aug 21, 2026 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
>> >
>> > On Mon, Aug 17, 2026 at 5:40=E2=80=AFPM Petr Oros <poros@redhat.com> w=
rote:
>> > >
>> > > __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does =
not,
>> > > so a frame taking the qdisc bypass path reaches ndo_start_xmit() with
>> > > the sentinel left by __finalize_skb_around() and skb_mac_header() po=
ints
>> > > 65535 bytes past skb->head.
>> > >
>> > > The packet socket reaches it through packet_direct_xmit(), and
>> > > packet_parse_headers() was taught to anchor the header by
>> > > commit c2707480cfbf ("net/packet: reset the MAC header on the
>> > > packet-socket transmit path"). AF_XDP reaches it through
>> > > __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
>> > >
>> > > ice reads eth->h_proto through skb_mac_header() on its ordinary Tx p=
ath.
>> > > On an E810 every one of 2817224 AF_XDP frames reached the driver wit=
h the
>> > > sentinel still in place, so the ethertype never came from the frame.=
 With
>> > > this patch all 5757920 frames of the same test carried the correct 0=
x88b5.
>> > > An AF_PACKET sender on the same port read 0x88b5 in both runs.
>> > >
>> > > On a KFENCE kernel that read lands inside the pool and gets reported=
 as a
>> > > use after free of an unrelated object, 387 times in a 180 s run:
>> > >
>> > >         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xdd=
b/0x1650 [ice]
>> > >          ice_xmit_frame_ring+0xddb/0x1650 [ice]
>> > >          __dev_direct_xmit+0x347/0x4d0
>> > >          __xsk_generic_xmit+0xc13/0x1e70
>> > >          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
>> > >          xsk_sendmsg+0x6c/0x90
>> > >
>> > > Rerunning the same reproducer on the same E810 with this patch appli=
ed
>> > > produced no reports and no bad reads.
>> > >
>> > > Anchor the header in xsk_skb_init_misc(), which runs once per skb for
>> > > both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not a
>> > > real header, but it stays in bounds and no such driver reads it.
>> > >
>> > > Fixes: 35fcde7f8deb ("xsk: support for Tx")
>> > > Signed-off-by: Petr Oros <poros@redhat.com>
>> > > ---
>> > >  net/xdp/xsk.c | 1 +
>> > >  1 file changed, 1 insertion(+)
>> > >
>> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
>> > > index 7855ee09c4b640..885427392cb6b3 100644
>> > > --- a/net/xdp/xsk.c
>> > > +++ b/net/xdp/xsk.c
>> > > @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb=
, struct xdp_sock *xs,
>> > >         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
>> > >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
>> > >         skb->destructor =3D xsk_destruct_skb;
>> > > +       skb_reset_mac_header(skb);
>> >
>> > I don't know, I had at some point the goal of removing our dependency
>> > on mac header in ndo_start_xmit(),
>> > as this must be skb->data.
>> >
>> > ice could use skb_eth_hdr() instead of eth_hdr() or skb_mac_header()
>> > and save few cycles.
>> >
>> > Some drivers call skb_reset_mac_header(skb), this is really a mess.
>> >
>> > With AI these days, it should not be too hard to completely remove our
>> > dependency on mac_header.
>> >
>>
>> I saw the status has been changed to 'rejected'. Why is that, I
>> wonder? I think it's just a fix that can be done in xsk like
>> skb_reset_network_header() that I'm going to add.
>>
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
>
> Work in net-next would presumably audit / change all drivers to not
> rely on mac_header
> being set (This I can do when net-next reopens)
>
> Then we can remove skb_reset_mac_header(skb) from __dev_queue_xmit()
> and __dev_direct_xmit(), and from dpaa_tx() / dpaa_tx_extended()

To clarify Eric's view: is the proposed TX contract that mac_header need
not be initialized on entry to __dev_direct_xmit(), and rely on
skb->data is at L2? What about skb->protocol and skb->network_header?
For example, netkit L2 resets MAC locally, but relies on the existing
protocol for peer RX, and its attached BPF can consume the existing
network offset. (We just hit that internally for a packet sent from
XSK/skb.)

...checksum-offload checks in __dev_direct_xmit() aside, since TX
validation can also consume metadata before ndo_start_xmit().


Bj=C3=B6rn
