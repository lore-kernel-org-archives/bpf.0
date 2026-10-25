Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792957270;
	b=mYZQU23wq764z5A5oD8zdqWszn2IfdBod5T2XwTx8Fn70CnCaq9isupG2FYfjXEnMnqO
	 X17T8B+xZPsEoc4Yf8fFF+IHX1EySOyS4dAiTraGcU6PNzefTBF8jBgN1pO1vFEOx7vE8
	 UN7KKI4eRvP/2kYL995H0Ls/0+OUAET91LUO5hY1PtJNUKj+RnHOfkcFgBPdPHtjPTb0k
	 zprf9Qm8BcOUjXE2e7+hFmyLSv/c+7fRABEOXSt1Aw/KMtlpUY9S7tg/1BTIq/a07tsBm
	 OgZfLCWE8JiQ995lB9cmI0fDIqvuFOuIu+mZb680YILBXXNqnIoKG7a881ovEGugeIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957270;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/ZjG9Xr/HMX/i7oEyIrYTz+RcRkHVl/XZuBXEaWa+5I=;
	b=2M9fuC0V3AZoQ8NTEjcHOQURztSSQcwCrLduuT/9iStZtSzCPsf/0ckqNGRvjEjwUoSL
	 uXeMr0uDSqFYWPxnY5j9+UU6C5cV4mjQGxcIyJTe/6Ej5MJ03U7XIFxHnkDjK6nKxIBwk
	 HoUswrXcGVhQhVAoaqO63qQY7KoKWsSivLxiPya+3gpkmoHc2VlZvpcM4EdCgXmJixwKy
	 jKxErbEDqlQ3+qFFUl9v4CqCgjs0Oi6bJwJZxqmRkbg/HuhH/tHqxiQGXh8WQg3Mk8psT
	 4AImZOHNWGZK6MkwJO5oxoTXSnB8SxFdhZ6Ua/I7ATCfgL7hhLRlPGsljHsUylIz2Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gpios/A9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68A606A31B
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gpios/A9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461401F031E0
	for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792957269;
	bh=/ZjG9Xr/HMX/i7oEyIrYTz+RcRkHVl/XZuBXEaWa+5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gpios/A9gSMoFlsDvZvnQHGLFQUe/zFMno7I9/mf9JZ0tE+O3UYT2vYbPp/SClDHa
	 YWf976KgiTRSk0fCB1c/WMQ7I/mPg2nJPPMx2c4/vHE5FNsoZPFDFGhyEpBCIVPTIv
	 7F2/Z+GdzFgcb7lAT+BKovQOJBu6b5hAAQDuLUY9ynyUPYi/CrStc8fOzxnScRIxIV
	 EaYRQIfwC/niuZuF2oLYLszDu1bVChXQuGPL5Qgvl2hRDboSbYLuNon2fsvWaIQARY
	 ZiNAWxYqUBvtqbjTEKlRmXSInMw7rw7Wr8KrcZ2lbD9IjgxWO7rTojxuy7wvgucK7x
	 tUMGMz10gOrNw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-46556b9e02cso1597641fac.1
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 12:41:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw/yHky7tL84UAnJ/pEYi9dOSl9hl4HWy1lLHdh+l1Gt86Ljc16bzCai4Ktx34LeWB0Cj4=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0fWtWn/eloSfjEQ08ZqF9WlM6e4sUduePUzr+Rnjdi23GUV5v
	CQpcZlWwsfOe/VlkFGoSI5m6M8bYoBvLdtj29wm2QOtBxN/4rgGwzlKornw9PbagqkHHkrW4pNt
	XOs4pQ1gIM1OdEcaxxhvObazuiQbFaTo=
X-Received: by 2002:a05:6870:7014:b0:48f:e0f6:bfef with SMTP id
 586e51a60fabf-4a83fa78ea7mr2212450fac.27.1792957268483; Sun, 25 Oct 2026
 12:41:08 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
 <179290180493.3134.5235549211177646736@kernel.org> <20261025124546-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261025124546-mutt-send-email-mst@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 20:40:57 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqk9Gq5=JKk7j=uK9oNbCd7GCcHUm8BmgZ4hGCqjjo45g@mail.gmail.com>
X-Gm-Features: AclHuK8DDEtJU8OQu3ulpdptWl65cK4vWpgyXH294HkBKAHMWmRkO2A5xVy3Bd4
Message-ID: <CAL4Wiiqk9Gq5=JKk7j=uK9oNbCd7GCcHUm8BmgZ4hGCqjjo45g@mail.gmail.com>
Subject: Re: [PATCH net v3] net: gso: validate transport header before
 computing segment length
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, linux-kernel@vger.kernel.org, 
	willemb@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, maxk@qualcomm.com, rusty@rustcorp.com.au, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 25 oct. 2026 =C3=A0 17:51, Michael S. Tsirkin <mst@redhat.com> a =
=C3=A9crit :
>
> On Sun, Oct 25, 2026 at 04:16:44AM +0000, netdev-bot+sashiko@kernel.org w=
rote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [High] The patch is incomplete for the producer its own commit messag=
e
> >   names.
> >
> > --
> >
> > net: gso: validate transport header before computing segment length
> >
> > This patch makes the GSO segment length helpers in net/core/gso.c check
> > the TCP header before they read it. If the transport header is unset, o=
r
> > the TCP header is not in the linear data, skb_gso_validate_network_len(=
)
> > and skb_gso_validate_mac_len() now report that the skb does not fit. It
> > also adds two helpers, skb_inner_transport_header_was_set() and
> > skb_transport_header_linear(), to include/linux/skbuff.h.
> >
> > > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > index d6894f463bf43..11c8b295bd260 100644
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> >
> > [ ... ]
> >
> > > @@ -3250,6 +3257,29 @@ static inline int skb_transport_offset(const s=
truct sk_buff *skb)
> > >     return skb_transport_header(skb) - skb->data;
> > >  }
> > >
> > > +/* Is the (inner) transport header, as specified by
> > > + * skb->transport_header/inner_transport_header, in the linear data?
> > > + */
> > > +static inline bool skb_transport_header_linear(const struct sk_buff =
*skb,
> > > +                                          unsigned int hlen)
> > > +{
> > > +   int thoff;
> > > +
> > > +   if (!skb_transport_header_was_set(skb))
> > > +           return false;
> > > +
> > > +   if (skb->encapsulation) {
> > > +           if (!skb_inner_transport_header_was_set(skb))
> > > +                   return false;
> > > +
> > > +           thoff =3D skb_inner_transport_offset(skb);
> > > +   } else {
> > > +           thoff =3D skb_transport_offset(skb);
> > > +   }
> > > +
> > > +   return thoff >=3D 0 && thoff + hlen <=3D skb_headlen(skb);
> >
> > [Severity: High]
> >
> > The commit message names bpf_skb_adjust_room() as a way to leave a bad
> > transport header behind. It also says:
> >
> >     Qdisc length estimation has carried a guard against exactly this si=
nce
> >
> > Is that guard enough for the bpf_skb_adjust_room() case? In
> > qdisc_pkt_len_segs_init(), the only check is for an unset transport
> > header. Nothing there matches the thoff >=3D 0 check added here:
> >
> > net/core/dev.c:qdisc_pkt_len_segs_init() {
> >     ...
> >       if (!skb->encapsulation) {
> >               if (unlikely(!skb_transport_header_was_set(skb)))
> >                       return SKB_NOT_DROPPED_YET;
> >               hdr_len =3D skb_transport_offset(skb);
> >       } else {
> >               hdr_len =3D skb_inner_transport_offset(skb);
> >       }
> >       /* + transport layer */
> >       if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
> >               const struct tcphdr *th;
> >
> >               if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
> >                       return SKB_DROP_REASON_SKB_BAD_GSO;
> >
> >               th =3D (const struct tcphdr *)(skb->data + hdr_len);
> >               tlen =3D __tcp_hdrlen(th);
> >     ...
> > }
> >
> > bpf_skb_net_hdr_pop() moves mac_header and network_header forward. It
> > leaves transport_header where it was, unless it was equal to
> > network_header:
> >
> > net/core/filter.c:bpf_skb_net_hdr_pop() {
> >     ...
> >               skb->mac_header +=3D len;
> >               skb->network_header +=3D len;
> >               if (trans_same)
> >                       skb->transport_header =3D skb->network_header;
> >     ...
> > }
> >
> > When the DECAP_L4 or DECAP_IPXIP flags remove the last tunnel GSO bit,
> > bpf_skb_net_shrink() also clears skb->encapsulation.
> >
> > Take a locally VXLAN-encapsulated TCP TSO skb whose transport_header
> > points at the outer UDP header. If a tc program calls
> > bpf_skb_adjust_room(skb, -50, BPF_ADJ_ROOM_MAC,
> > BPF_F_ADJ_ROOM_DECAP_L4_UDP | ...), the transport offset ends up at -16
> > and encapsulation is 0.
> >
> > A simpler BPF_ADJ_ROOM_NET shrink of 40 bytes on a plain Ethernet/IPv4
> > TSO skb gives an offset of -6.
> >
> > If the program then redirects to egress with bpf_redirect(), this path
> > runs before any of the validators hardened in this patch:
> >
> > __bpf_tx_skb()
> >   dev_queue_xmit()
> >     __dev_queue_xmit()
> >       qdisc_pkt_len_segs_init()
> >
> > In that function hdr_len is an unsigned int, so -16 becomes 0xfffffff0.
> > hdr_len + sizeof(struct tcphdr) is then truncated to 4 when passed as t=
he
> > unsigned int len argument of pskb_may_pull(), so the pull succeeds.
> >
> > Wouldn't __tcp_hdrlen(th) then read about 4GB past skb->data on 64-bit?
> >
> > Should qdisc_pkt_len_segs_init() get the same check, for example by
> > using skb_transport_header_linear()? If not, could the commit message
> > be changed so it does not say the qdisc path already guards against
> > this?
> >
> > > +}
> > > +
> > >  static inline u32 skb_network_header_len(const struct sk_buff *skb)
> > >  {
> > >     DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
> >
> > [ ... ]
> >
>
>
> Indeed. Not nice.
>
> Eric, you seem to have strong opinions about how to fix these
> bugs, so, before I spend time testing: a fix like the below, acceptable?

The report looks valid, but this patches _one_ consumer of a broken
transport_header, not its _producer_.

bpf_skb_net_hdr_pop() adjusts mac_header and network_header, but leaves
transport_header alone unless it was equal to network_header. If the
popped region covers the transport header (BPF_ADJ_ROOM_NET shrink,
or a DECAP_* shrink in BPF_ADJ_ROOM_MAC mode), we keep a stale offset.
It can be negative, or positive and pointing to the wrong bytes.

qdisc_pkt_len_segs_init() is only one reader. TSO drivers
(skb_tcp_all_headers(), tcp_hdr() in ndo_features_check()/ndo_start_xmit())
and the GSO validators would read the same stale offset.
A 'hdr_len < 0' test does not catch the positive case either.

bpf_skb_net_grow() already sets the transport header properly,
the shrink side should do the same. Something like (untested):

diff --git a/net/core/filter.c b/net/core/filter.c
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 {
        bool trans_same =3D skb->transport_header =3D=3D skb->network_heade=
r;
+       bool trans_popped =3D false;
        int ret;

+       if (!trans_same && skb_transport_header_was_set(skb)) {
+               int thoff =3D skb_transport_offset(skb);
+
+               trans_popped =3D thoff >=3D (int)off && thoff < (int)(off +=
 len);
+       }
+
        /* Same here, __skb_push()/__skb_pull() pair not needed. */
        ret =3D bpf_skb_generic_pop(skb, off, len);
        if (likely(!ret)) {
                skb->mac_header +=3D len;
                skb->network_header +=3D len;
                if (trans_same)
                        skb->transport_header =3D skb->network_header;
+               else if (trans_popped)
+                       skb_set_transport_header(skb, off);
        }

        return ret;
 }

For the decap case, BPF folks might prefer to restore the transport header
from skb->inner_transport_header when skb->encapsulation is cleared.
