Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792608472;
	b=080kKrI+/VA7asxrdjAX1GchOiX+ccRRY+yvAfmBuA9we9fYCcT2X52encIj1rdx6SBZ
	 EsgBPNthjzMZy5ndkg9wjy0y9zCPDjE8ODx81juzWMgBrBkygEv7TadSwgNHUUvNND9ff
	 oXsKC9vHon2ZqHlk8prezHLibUJuypgq++OQTdzqye+eOknApbTYIsRsdYMJGcYW45j8+
	 TTHlLYtbXtZj7dk7sLdHwzah0muRg2TKEF8BOSdKOizvlgcHABDcVnOezShOQJ6R8s198
	 5d7htbI+glWnNfwevI6NX2MqgVM4nR/RZYZhXLuBEfgHmRCKrFYoNX1kycju6meKdDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608472;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YnDsoLj5+AQd01dBHph+QKt/wDaj4pOQ+Pmx3aP0pWE=;
	b=fv+USVLi912oQjLO6Pcap0Q9WN14pAZhKuQ7YPhpl0uF8gLQmQl4mFcZJUnKkYkNJoue
	 xmdO45+0shwKJ58VEETRR8cZlf8iw3GcKPUw5Hy68JexGEgt9riSJpRVAudxMjpm+/HT/
	 Dum4mbFCVXsSV0N7ihew93LH6oLNBSNOCj10DH+fTqCwA6fQ17V0S95drCQOm63PHpylQ
	 JnSos77WP6nQ3YYGwoyhXjyxphiZY04OqxpE+EDRMgJcLO5h9ZkGt1agLHzJiS0Y6Ev73
	 nA+p8hss463i260RvZXmUPGX2VBdlHEWkO+L3nldNI/C5RitOh3jHYB4sUWpMcZv/gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720EE606A31E
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C37D1F000D2
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608472;
	bh=YnDsoLj5+AQd01dBHph+QKt/wDaj4pOQ+Pmx3aP0pWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PCE2q5W284PVQditrBgCAowG2x6ghrmhq09kRvD8BVhoLfv7Aez8fHZNuOIy5L3Fs
	 lzQcBMXv7wbjvTZFov3via2YxXqMEiW4tsDXpNLQfu0Opt6WkX50+Jrm7Wxfr4J+PL
	 Nh9ZzdwPkNrCEBKB0wyLmtrt03pgn/LWq4TusK42J04eoGt9yYkYB7gKxsR9ob2Fur
	 y93LhTP7lrBpFfIMJMo2PnrRcNonQzYJUpBSuJLr8uFl14X9AJPxsyMULEy9raEaer
	 T0Eygvi3iDXnmRMjCbw5E19ljt9d1Bhvosx4fWBZi4A3PqtPSnrWm+FyQGnH++Mm1u
	 UCuWkNKrnzpsw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a77761ff8aso532104fac.2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:47:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBydqTIkwFrn1Sjo/tv49gjw2IRzj+U94bLlxnPuzwfGAFwZzgfslNVrhIP6W67qwUprsVQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgA1nD2FeaVtbSUyX2yGL08A4E9GU28EOIbrVCgntWY4bXccef
	QFATtKbtz3cOvFfvobNkQYf5Aro2TmzisJoTTbkQmXiL5jiv5FQm8nfMH7+HPRtCEsu2L6iQZQO
	ZS8fB8tiJEfo7oJvRsb7z2McmOspxvAg=
X-Received: by 2002:a05:6870:468c:b0:41b:e633:baf4 with SMTP id
 586e51a60fabf-4a7dbf43b07mr2060959fac.3.1792608471281; Wed, 21 Oct 2026
 11:47:51 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021180329.26358-1-nick.simo@gmail.com> <20261021180329.26358-4-nick.simo@gmail.com>
 <CAL4Wiiq6Jy1XPtkrA-Ge2N+voJrE86DWPJp_jXwHJG3ZgMvPaQ@mail.gmail.com>
In-Reply-To: <CAL4Wiiq6Jy1XPtkrA-Ge2N+voJrE86DWPJp_jXwHJG3ZgMvPaQ@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 20:47:40 +0200
X-Gmail-Original-Message-ID: <CAL4WiirCmk_rZBhaXmmgHSHiUjeBSt5hPoRn6Q+AXUGYVNXRaA@mail.gmail.com>
X-Gm-Features: AclHuK_w1MCGAcXeLJ8-ObeAgP1aNKiT6XMtPrlEiDBmrYgivjjG-o5TUvwD7FQ
Message-ID: <CAL4WiirCmk_rZBhaXmmgHSHiUjeBSt5hPoRn6Q+AXUGYVNXRaA@mail.gmail.com>
Subject: Re: [PATCH net 3/3] ipv6: validate checksum_start before fragmenting
To: Nick Simpson <nick.simo@gmail.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
	Phil Sutter <phil@nwl.cc>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Song Yoong Siang <yoong.siang.song@intel.com>, 
	Rusty Russell <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, 
	Sridhar Samudrala <sri@us.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 20:20, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
> Le mer. 21 oct. 2026 =C3=A0 20:05, Nick Simpson <nick.simo@gmail.com> a =
=C3=A9crit :
> >
> > ip6_fragment() and br_ip6_fragment() complete CHECKSUM_PARTIAL skbs wit=
h
> > skb_checksum_help() without checking where csum_start points. After
> > reassembly by nf_defrag_ipv6, the IPv6 header has moved forward by the
> > 8 bytes of the fragment header while csum_start has not, so a
> > CHECKSUM_PARTIAL skb from an untrusted source (tun/tap or packet socket=
s
> > with a virtio_net_hdr, or AF_XDP TX metadata) can have csum_start insid=
e
> > the IPv6 header, and the checksum is then written into a header that th=
e
> > forward hook has already accepted. When csum_start lies before the
> > network header, skb_checksum_help() warns.
> >
> > Add the IPv6 counterpart of ip_check_csum_start() from
> > commit 6785011f8b16 ("ipv4: validate checksum_start before completing
> > checksum") to the two IPv6 fragmentation paths: refuse to complete a
> > checksum that starts inside the unfragmentable part of the packet (the
> > IPv6 header and the extension headers before the fragment header) and
> > drop the packet instead.
> >
> > For IPv4, ip_check_csum_start() is also called from nfnetlink_queue,
> > xt_CHECKSUM and xfrm_output; their IPv6 counterparts are not changed
> > here. A reassembled packet that is not fragmented again, such as an
> > atomic fragment, and an unfragmented packet whose checksum is completed
> > at egress are not covered either; those have to be handled where the
> > CHECKSUM_PARTIAL skb is created, or by a check at reassembly time.
>
> Then let's do that, instead of adding checks to every consumer.
>
> A CHECKSUM_PARTIAL fragment is meaningless: the L4 checksum covers the
> whole datagram, and our own stack completes it before fragmenting
> (ip_do_fragment(), ip6_fragment()). Only untrusted injectors produce
> them. Yet inet_frag_reasm_finish() keeps the reassembled skb
> CHECKSUM_PARTIAL when all fragments are.
>
> Downgrading CHECKSUM_PARTIAL to CHECKSUM_NONE in inet_frag_reasm_finish()
> covers IPv4, IPv6, nf_defrag_ipv6 (and the bridge path) in one place;
> the bogus L4 checksum is then verified and the packet dropped.
>
>

Scratch that suggestion, it would be one more consumer-side check.

The fix belongs where CHECKSUM_PARTIAL skbs are created, and Michael
is already doing this for virtio_net_hdr sources (tun, tap, packet
sockets, virtio_net):

https://lore.kernel.org/netdev/cover.1792411304.git.mst@redhat.com/

In particular "net: resolve uncommon partial checksums at ingress":
https://lore.kernel.org/netdev/9c08d12b3a7819ae03ded6a154e4f908276e93d4.179=
2411304.git.mst@redhat.com/
CHECKSUM_PARTIAL is only kept when csum_start/csum_offset match a
parsed TCP or UDP header, and fragments are explicitly refused
(ip_is_fragment(), IP6_FH_F_FRAG): their checksum is completed at
ingress, before any protocol processing.

Your patch 1/3 applies the same rule to AF_XDP copy mode, and already
links to Michael's patch.

With both, no untrusted source can feed a CHECKSUM_PARTIAL fragment
to reassembly, nor an unfragmented packet with a bogus csum_start, so
neither this patch nor a reassembly change is needed.

Once the ingress validation is merged, the ip_check_csum_start() calls
added by commit 6785011f8b16 can be removed as well.
