Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855734;
	b=hNch6R+HLh/+R44VdeQOb+EXolRvRO3A6n+I9Et1Mp2jtOsu+GqZ9c/D+pRKa1sGWYdo
	 xg5tyMIPPwRCwBOXex8rMmd9owdEwfe08YjxErH6zTt4I/Ki2+2meDnooG2JXzdvMMb7H
	 3P1bpq9HrLj0ubpSFx84FnOI0AW3S+wJ0J5ZBkGB2gkXG5dv/IqM4OnGfd8nxN7QDp8O+
	 kS2jv47VyMS/oqargAbbjbU7P/e9kEtYhlm/HaAmR6n4JNYpHDB/QwUnA31H+W0x9FAjQ
	 sSoL4Oks3McETUTKyzT2oaNumboeohNJPiLlrJbPuehruycgS4x34KMDGY7HAMyNz5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=76cSr5ASB4p2FBI2t721H4rduiQm/5IlEam8wJnUY/8=;
	b=VhF2R39LdGxs2UQQj8FKYnTHeNw4lpR085RbkpRfWCXw7Z5RC6hYd37ZJqihminwi1kd
	 IeTC7qPB9VifsqjG+0emaPgt0pys/9uhvuFhB96LZgzZGnydDWNIGi0KbBTcSGIjf5cC3
	 x0Scx7Ne2GsLYtKDNT2Y18m9l9CFmla+XUfeKsFvjst95KsB+HgjrSvTg2yth0xgUxiTX
	 4KZWSOoJZYJFzaIVOva1qCzvJj28T6mLmAB7uxkNeXmu/bkQO2G+WM9nN+E9fviQdeVpk
	 kuk+nCwAOO+ptgh7XcVl9iIpbNWRCD2yplbH1dSKTAE+/UaKM/7AZAD56pJid/zK/MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qxs0qrn3;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDE606A331
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 19:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FDDE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qxs0qrn3
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9906870a9baso2809564241.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794855733; x=1795460533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76cSr5ASB4p2FBI2t721H4rduiQm/5IlEam8wJnUY/8=;
        b=qxs0qrn3dgb1zsdklNg242xDnCbM+NI3+2SXgTwG+gQqB70oc1q9dPdxxFKBsMOHrt
         wLW7CIUCOQUBNZ7gTear1MUL362SvN0UODQxCfxSlUsWT1LtoYYfbICrujaJKvNmuYvq
         21QwXlrNUMSvr9JOUb+BwCPCzSgohNx7Tl8gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855733; x=1795460533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=76cSr5ASB4p2FBI2t721H4rduiQm/5IlEam8wJnUY/8=;
        b=rfNXe4ATFVTyCA6yf2T+7+wZQYakSnxL02V4hpeyiFHqUA7tr6jHtIbc0KeCzJf65U
         Sk3an5mZ/vcZGFFuH5BORW86tbsvtK7AihH/19YUzeg30oY+tiu2Dxe1Bt3HOHXcTxD6
         BqVkHtoQRO5FdbZHuG+0VHIJNgKxaiu5WH3N9u+zn6Tx6Uz5xNMKEFI4Uj3JLTMO59X5
         i/KIML+qS/aqxvsiux+DnzOB/13KYnu2hWulyAo9GF8iEpt3p5hBJ5pwfCh7rkWkeHdw
         SeChHtfSH6FSYxBpr/SN6PotSEcki0FvcMRGMT9w0TgEv8WacHQIFa56RWUT/fYNE+hu
         DThA==
X-Forwarded-Encrypted: i=1; AL+hErEvDxbYbxuehcUayoGjXMLIolgD/PorFty6zUrMs9LT7x0p3LgdYYwt6hLDTozyn3kaXdY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6nm3l8wyZNyIHbPJdC/9hNgR+vJcUW3xEtU2ppwt7RpOWEZEQ
	WmS4wKAjoGcxyNk3nskHK8vjWKomvYszM5bEXOEd1h3E/BV1CEhq5UDoI5tWsjhlFQ==
X-Gm-Gg: AYBFou2Im4s9OXieHFGmjkTYMlIQ/7wZtIuGl/2rUo3/NfMuTWdYKrYqX+LtFNL2HCC
	SaFutqsZmVItSSbcF+Of5WKReQEXsQPkAzXxo8VfOwXT0GagBEjjtzIAXP91g0Un0yEcm2aXeCv
	mqRVPKhEmKCLzq9pI2Kbw6jwHrbGTXVRL/Okb4+X56RWc4NHAsN7PAoMbW/sStK1CIFKEFSZRTl
	BDhyWjToWUFRJaKOC3Lr4FRVbOhq32+QoWI2K3Jl2bwanTiiO4dZQN1aF/wc1IynYNGoG8peK8A
	iiI+K1wTPBfADBAJwLg75bTvbo5RGl1L9AQaGzolsf2AwUn6MpMwQl/j4YRoZvUWKn/nJ5BBC8+
	TdeoedZwTzvyfftFhCpJJ7Jid2Udj/gCHsbR1A1PNKwqtJZ+ro8Y6PdehoV2kb2baL0xeHOkSpX
	4tHETZ+CqNQ2Yes7/iir+dQ/WrekehrWA8Mlseub8QNtuXn0KuSF3TnzyUZ1qSs/HtgiZn/U2Ck
	YsjaLSXL2A2PB5Rb6OoO6GkMlo1vgQ3fsNDa2Wv5dudZw2lL+zH6R0cZt12BhyIV+lTQde60P+c
	fHooz0+L78vo6SJyppiZB4SVDLCNzwzfrvwt1hCiBpIUEWV9WTz0FSBtL3CvampkNNba2b1b1fE
	=
X-Received: by 2002:a05:6102:2c8d:b0:7cc:cb56:bf83 with SMTP id ada2fe7eead31-7d64d6cb8d8mr4202827137.12.1794855716942;
        Mon, 16 Nov 2026 11:01:56 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d453casm91997386d6.10.2026.11.16.11.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:01:54 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v4 4/4] bpf: drop the stale dst when redirecting to an explicit nexthop
Date: Mon, 16 Nov 2026 14:01:41 -0500
Message-Id: <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com>
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

This is a followup of the review of the teql arp-queue fix as reported
by Sashiko.

The issue:
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() install a dst for
the redirect target only when the program lets the helper do the FIB
lookup. With BPF_F_NEXTHOP the program supplies the nexthop, the lookup is
skipped, and whatever dst the packet arrived with stays attached while
bpf_out_neigh_v{4,6}() switch skb->dev to the target device. If that
device's neighbour is incomplete the packet is parked on its arp_queue with
the original route's dst; draining the queue re-looks the neighbour up from
that dst and builds the frame with the original device's link-layer header,
then transmits it on the target device.

The Fix:
Release the dst when the nexthop is supplied, so the queue drain keeps the
target device's parking neighbour and the frame carries that device's
addresses.

The release goes through skb_dst_drop_keep_metadata(), so encapsulation
parameters a route carries are handed over to a metadata dst instead of
being lost, and a metadata dst already on the packet is left in place. Both
wrappers take their existing drop path when that copy cannot be allocated,
so a packet is never sent with the stale route.

What the target device's transmit path still sees:
The released dst is the route of the device the packet arrived on, and the
packet leaves through the redirect target, so consumers of that route on
the way out lose it:

  - a tunnel with no configured remote takes its outer endpoint from the
    route, as it does for the netfilter producer: ip_tunnel_xmit() reads
    the route's next hop, and ip6_tnl_xmit() and sit derive it from the
    route as well. A redirected packet whose route carried no encapsulation
    parameters is left with no dst, so it is counted as a transmit error
    and dropped instead of being encapsulated towards an endpoint that
    belongs to another device's path.
  - the route realm goes with it, so nft meta rtclassid, nft rt classid
    and bpf_get_route_realm() stop matching on that packet.
  - encapsulation parameters are not lost: they moved onto the metadata
    dst, so a tunnel or an xfrm interface downstream still builds its outer
    header.

Taking the outer endpoint or the realm from another device's route is the
same cross-device reuse this patch removes at the neighbour lookup.

One consumer is older than this series. When a tunnel cannot take an
endpoint from the skb, ip_tunnel_xmit() and ip6_tnl_xmit() fall back to
skb_rtable(), a container_of() over whatever dst the skb carries, and a
metadata dst is not an rtable. That fallback is reachable without this
series: a tc-bpf program that calls bpf_skb_set_tunnel_key() with no
remote already hands an NBMA tunnel such a dst. The release here can leave
one behind as well, when the parameters a route carries are not usable for
the payload. The cast is repaired separately.

Conditions to recreate the bug:
Two network namespaces, A (10.10.0.1/24) and B (10.1.0.1/24) in one, their
veth peers in the other with only A's peer addressed (10.10.0.2/24) so B's
nexthop cannot be resolved by ARP. Resolve A's neighbour for 10.10.0.2 as
permanent and attach a cls_bpf egress program to A, with vb the index of B:

    struct bpf_redir_neigh nh = { .nh_family = AF_INET,
                                  .ipv4_nh = htonl(0x0a010002) };

    return bpf_redirect_neigh(vb, &nh, sizeof(nh), 0);

Send one packet to 10.10.0.2. It is parked on B's incomplete neighbour
for 10.1.0.2; once that neighbour becomes valid the frame leaves B
carrying A's source address and A's neighbour as the destination.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v3 -> v4 (commit-log change only; the diff is unchanged from v3):
- Add the section on what the target device's transmit path still sees
  once the route is released: the NBMA tunnel drop with its
  transmit-error count, the realm readers that stop matching, and the
  encapsulation parameters that are preserved.
- Note that the skb_rtable() cast in ip_tunnel_xmit() and ip6_tnl_xmit()
  is older than this series and is repaired separately. Considered
  comments from Sashiko (nipa).

 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index bd98d29ed7f8..ae5346d6abd2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2318,6 +2318,8 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 		skb_dst_set(skb, dst);
 	} else if (nh->nh_family != AF_INET6) {
 		goto out_drop;
+	} else if (!skb_dst_drop_keep_metadata(skb)) {
+		goto out_drop;
 	}
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
@@ -2433,6 +2435,8 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 		skb_dst_drop(skb);
 		skb_dst_set(skb, &rt->dst);
+	} else if (!skb_dst_drop_keep_metadata(skb)) {
+		goto out_drop;
 	}
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
-- 
2.43.0

