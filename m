Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516058;
	b=lb0QxBHxDOXzJm+tOETWR8P4atenACb0MykYnS6EVsjVjqcxkjETDFBewSD1P6Hbc1V/
	 uqgkDcu1e8laF9/xpHKVP3+JZmuWye6v1GBxuNhgPBi9uH+knh+zDZotoPPnPYrTFh+ay
	 DVPfpp+hPeN4s/1S+cjrDQD6OKWZTm+UQfgD8O4DzhqRQoGUqWssIIc2CJ5aTyOz6+H2U
	 7aK00+Xkqcq0e8vu3NJ7Aq3m3WRNXNSvZh9Hu0TbZTgPOSyF8T31ocCK1UyX7ZGPSiBK+
	 vNHILNLvFGstH7qD1NRII8f6GCHukDT9/OMUpY+7C4FSbiLbLXBrnghP4QIhsHSkWQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TLrth8wLEh6vpvKNPNp2R9KWAwbTv3cJENXtlUTu6CY=;
	b=bTzOuQRfHvlVL5/hWSZi62DSdVo9SZs5z/pbgkrEB6ntOEzY13NYaz497Qn8CnXTDGRs
	 7jleWaeXIgn5UU+zexUdcmFBGOTa1QII5W8Joj/QhZACDdtRLZ/Drh3Z949ZZ+GKY6g/I
	 cH4pIi7wUrE1oBQe0Jfn9701Jgv9Cbp6cSSLGBFOSt+ADWrgaaODyzIgl3TSsfDy01NU0
	 v49ExpWG7Y2c1AEzIhSdEq2FYtMnrLjDtymXMgjbhn7OtKmc/HL4HFzO+8OFJ2J7EMNtj
	 L46yeg7pMh0Dy5Ijz+bRrB5HaYttaCXDC/hji0pyOIOEiLeWQdG/x3IMZa+8qv4knpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mbczJFVI;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9986F606A32A
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9986F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mbczJFVI
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53644b28706so2060491cf.3
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516056; x=1795120856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TLrth8wLEh6vpvKNPNp2R9KWAwbTv3cJENXtlUTu6CY=;
        b=mbczJFVI6lxSCHSzDPA39M3ymXrEkoYc3GnzC0664YAwPder3+PBBzXgIE6dZiynSg
         VZDA6De4JxOAbqtVTkNMdPBJc7LOGvwUVoIya50ouUcJwlTIP3VC10DqdbuQFMR0yF5r
         Z3DUeB2qS7ti4pHqfgijSIB3Evw4EQTEnrmxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516056; x=1795120856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TLrth8wLEh6vpvKNPNp2R9KWAwbTv3cJENXtlUTu6CY=;
        b=YLpDXj0Dkdaef4DpBoglUAs5/O4PX6wu6PahczNnkHK4bfP8SpC+/i+K9+3XRy4GVn
         AOfZ7oMf4r8gBzTTsEDC4RyjsJx5e/qV9EgDc8SaulNPcE+q7Yr0iUcB8uEKa0PCjtSP
         /NjFhzYgH7yHCTd2Wb73iQVoS+TYbBiy9y2SDnGqRJ2lU8+0qvcgDF1yO5nojzbvn8YH
         FCldJwi2s6FAKK5k2G+XW3YakH20GUqb3Az8r5tQ6g8+4aPC/E271D7knh6Gz9JLpq7N
         tI4hZIEbRf2+oisT35Wm3oC/K0uLr+TiLmwLSFTfd5D6LhKQt4HyoOzuxacQIRp75hHv
         4BKg==
X-Forwarded-Encrypted: i=1; AL+hErGbIeC0bVQBcQlJ9ICInJORK7WhTTF8Tcc+shek07AZOpOvJbbOgHNfm8XLFBW8aqm/JT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BukHz5iaLJKjAJW2PDe1jKREwO27TyQB6AoKbr+y9lmHAMazK
	YV7nH7qretz2ww/85conDFiYxO/amutH1gXS+uCfq0VGKaaI6CL79MzAkG0Szn80CQ==
X-Gm-Gg: AYBFou1Ox5/4ZOcmcp9e53YaeoBOMgReX9vEIT44/kBrLPHcJOelf6MUmz/VnasEw6O
	n+nTP7FaPeRUHfhusL6GR7Pa835wxj0wgH7ENK9DBOV0nIb3wUZT86FVXQzSvqZ6gkUygv+ve1L
	qE8fCL0VeHyZYtMNs9tU4xAFqy5L/3g0L4Keimi/65wdRdKrqbaoLeK6JC4SHLg/XBsGYhJR6Lo
	NRgKagZHujN6j8/fNglIu2CStsSR3mh6pjkh12eNxy1wYYpWZeaIqhO8XTRo6CBAq3tU4YdvBMJ
	U0CSxOQHrpDAU1/P5o+ILy1VUb2ZBcIaRP9XeFY3g4ifNh+Rqo9K1ouBeUDrvoMDUW7wK11hIc5
	K7SF/mQqY8l+E/biow3erpTc9PIE40/Rs0MCq1i1u+e/0c+9KntX6b5fVarkhuq8ZT6Rh7m6kg2
	2s12//8vgFhZbUqEPmW3vECix8f49fVD6TKq6RbzCOVkc8sGIl7plZE3ze4EozAfbgDicH0Vqcm
	SU+dKgd/d2dp3chgxhwvtOJAh6kFUH/UHp14LpcHr9JXWKGpFeAmTdzu0VgMN5800sewfsY2dhm
	/+ruRdcsK49j1zt90ZnQ+z3wSR7fM4Pu3TEEv1pAKyZtFkILTnWC5hqrI3JfjzWbBHtnnOorFZ4
	=
X-Received: by 2002:ac8:5a54:0:b0:530:1b1:72be with SMTP id d75a77b69052e-55ac7b55b58mr10360831cf.40.1794516056428;
        Thu, 12 Nov 2026 12:40:56 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:40:55 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Sashiko <sashiko-bot@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 0/4] net: drop the stale dst when steering to another device
Date: Thu, 12 Nov 2026 15:40:45 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset is created to address constant whining by both sashikos
about this being an issue when fixing a UAF on a teql issue, see:
https://lore.kernel.org/netdev/QDISC-6HS9.v4.r0.20261111094338@mojatatu.com/

Two producers steer a packet to a network device of their choosing and
then hand it to the neighbour layer for link-layer resolution:

  3/4 netfilter: the neighbour variant of nft `fwd`, on the netdev egress
      hook
  4/4 bpf: `bpf_redirect_neigh()` when the program supplies the nexthop

Both rewrite `skb->dev` to the target device and leave the skb's dst
pointing at the route the packet arrived through. When the target
device's neighbour for the nexthop is incomplete the packet is parked on
that neighbour's arp_queue, and draining the queue re-looks the neighbour
up from the stale dst. The frame is therefore built with the original
device's link-layer header and then transmitted on the target device: the
packet leaves with another device's addresses, and the sender never
learns that its nexthop was unreachable.

This is explicit: the steer-to-another-device path never worked in this
respect, so there is nothing here to regress. Both producers shipped with
`skb->dev` swapped to the target device and the route's dst still
attached, and the arp_queue drain has re-derived the neighbour from that
dst for as long as either producer has existed; the invariant "the skb's
dst describes where the skb is going", which the routing path keeps when
it steers, was never established for these two entry points. With no
commit to anchor with a `Fixes:` tag and no crash, UAF or lockup
involved, the series targets net-next and does not nominate `Cc: stable`:
a backport would change long-standing redirect behaviour for no
crash-class benefit.

More context: this came out of the review of the fix for a parked skb
being resolved against the wrong device in sch_teql, posted separately and
not part of this series. The neighbour code's queue drain is doing the
right thing there, it re-derives the neighbour from the skb, so the repair
belongs with the producers rather than with the drain path. Both
producers are fixed in the same series so neither is left behind; each
patch that changes a producer carries its own reproduction recipe.

The reproduction for both arms is a pair of veth devices, one of them
with an unresolved neighbour, plus a capture on the target's peer: the
captured frame's source and destination addresses name the device whose
neighbour was used to build it.

v2 drops the dst only when it describes a route, and keeps what the route
carries (thanks to Pablo for catching this). A `DST_METADATA` dst is the
tunnel template a tunnel helper attached to the packet, not a route, and
dropping it would discard the encapsulation parameters, so it is left in
place. A route carries encapsulation parameters too when it was installed
with an ip, ip6 or xfrm encapsulation; 2/4 adds a helper that moves them
onto a metadata dst before the route is released, so a producer that
steers into an external tunnel device still finds them in
`skb_tunnel_info()`, and one that steers into a `collect_md` xfrm interface
still finds its `if_id` and underlying device. Neither case weakens the fix:
a metadata dst resolves neighbours through `dst_blackhole_ops`, whose lookup
returns NULL, so the queue drain keeps the parking (target-device) neighbour
exactly as it does with no dst at all.

1/4 is a prerequisite on the xfrm path turned up after Pablo's comment.
The interface that consumes that metadata puts the original route back on the
skb before the xfrm lookup, which needs its family, and installing a
reference counted route over a dst slot that is still occupied trips the
slot assertion; the slot is cleared first. The same overwrite is in the
tc-bpf helper that attaches the metadata, so both sites are fixed in that patch.

Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/20261026160747.283702-1-horms@kernel.org/
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v4.r0.20261111094338@mojatatu.com/
Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/

---
v1 -> v2:
- Do not drop a dst that is not a route: a DST_METADATA dst is the tunnel
  template a tunnel helper attached to the packet, and dropping it discards
  the encapsulation parameters (Pablo Neira Ayuso).
- Keep a route's encapsulation parameters as well: a route installed with an
  ip, ip6 or xfrm encapsulation carries them in dst->lwtstate, which a drop
  would discard before a downstream tunnel or xfrm device could use them.
  The dst release now goes through a helper that moves them onto a metadata
  dst first (new 2/4).
- Fix the dst slot the xfrm consumer restores: a collect_md xfrm interface
  puts the original route back before the xfrm lookup, and installing it
  over a dst that is still there trips the slot assertion.  New 1/4 clears
  the slot first at both that site and in the tc-bpf helper that attaches
  the metadata.

Jamal Hadi Salim (4):
  net: xfrm: interface: restore dst_orig on every xfrm interface
  net: dst: keep the LWT metadata of a dropped route
  netfilter: nft_fwd_netdev: drop the stale dst when steering to a
    device
  bpf: drop the stale dst when redirecting to an explicit nexthop

 include/net/dst_metadata.h     |  1 +
 include/net/xfrm.h             |  2 -
 net/core/dst.c                 | 72 ++++++++++++++++++++++++++++++++++
 net/core/filter.c              | 12 ++----
 net/netfilter/nft_fwd_netdev.c |  6 +++
 net/xfrm/xfrm_interface_bpf.c  | 16 +++-----
 net/xfrm/xfrm_interface_core.c | 22 ++++++-----
 7 files changed, 100 insertions(+), 31 deletions(-)

-- 
2.43.0

