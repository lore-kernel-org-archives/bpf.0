Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189396;
	b=j46/FDVqxe/JrymiTzJQOFNsdGnFUlQP01ZD1LoxLAybhNUN+Y0r4L06kKDXfiCDCG5M
	 brEuqoNQXumjsiPqtH5FMIOTvhf5zWXrK12tCn8RYEyZocHUkeeRzSSXkHZ87lBhWBMtn
	 Av+DlKQ/CGOWNWJa9EEBLuDLGS9jHFU4mGCNL1Z7RW7G7rdVKtFX1dJMZqx3E4dBReT/t
	 fhL/L1iwBeViSk3BJIr14eaPOqPCTWuod6i288kbbiK+G26Yr3GW5igUmYlbW2vNl8bef
	 43MnHVmpUBVIyfDj84dAq5DN26BWjSpPAjFZZQ9LiHuxWABvd5XURC1EEKEVApg7sBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189396;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=skDAf6P5lMgExY8BT13Y0yOZuZ/PE0d0HM9IStj4YTI=;
	b=asMQjECrTnezcxPGoas5S2fm2c8yfTnjRS2uRbHkfrhOTL4wlTqEfEPp+BxD9PyUg9GR
	 qBBZ9H1NwbluWWDAhBQkq5RLhP1oqgOpg488oIvKuL+P9RHrNwvPHlvDNLpR0pPUUpEmb
	 gbwNbP2clR3d7nCL9uf39jjHbgcaIwTgWOh7mN8UB3NeBJDGosfDPx9BF5688DZRKip/l
	 0JPzMuTFD343QRhuLHvBZZnuajogK1bCAUV7Ef3w3hoCQyCAM2e3ZsgIpJgxo1+3/iGQo
	 CJZvW7hX+swzRuS6/NA+hoJCueUjHgwIY60N+UnEuu7MXzwm3BBIVq8BiHWvQoG0gig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GDB2RJq2;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C706606A33D
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C706606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GDB2RJq2
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-537548b811aso8494391cf.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795189394; x=1795794194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skDAf6P5lMgExY8BT13Y0yOZuZ/PE0d0HM9IStj4YTI=;
        b=GDB2RJq2D5tIv1MFCjPnPyGivBJ5YV2zQrS+IwFDnzFKZdJ6bCoM+PmK2uUUeM4s6e
         64Mhlppqq8H8JC4tXzrliaR9JwB0YIbrH6+zEw3hWa6F3tm7oaG0JKskmqNv3hOdU7Xl
         lnKnx7bGcd6BgipP6X+xp271I742oq7hW06PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189394; x=1795794194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=skDAf6P5lMgExY8BT13Y0yOZuZ/PE0d0HM9IStj4YTI=;
        b=Iv+vUDj1PcT3e93je9pMRjiZFRw1zIiSkPkAlRXBu+yrRrBwsSq9BJKb7MFQRkCrs1
         1xVte9pEZb+e/Y0VTGNKtplMWOVCJBrCI54lRzZ2qz9VSUTZdEwabFV/jpB/ZZRuTBRn
         Ikxdb5akFjE/Hw6DrqV86sTlyAvDZH9yc0jyFyLkzFObEPkGGgeZZpvvugvz0P8qPcK+
         XsgHUNlE2v2QfdW7kUzGEdVDCFaWR2wMoxJ3U07FYB91PYmlHgPJYGQ2vD1vL0TxHQDu
         7sPsW586OxBO4YPgYL/geCub89E9Vk1TmJGl/+KkqIhH3g864BSR7E0ZGT2W3N7GdJZ9
         NT3g==
X-Forwarded-Encrypted: i=1; AL+hErH+eBEOuP11Fn5J9n8jvGw4nZya1OZTqwOx6oWlGuzKUcqFHEpAAL+6ge+3PHj9PYzCoBk=@vger.kernel.org
X-Gm-Message-State: APuU4Z95vG8Kb7tnAHnRYebjfxk7Kbw9tdlcgTwIYhcN8VUrr9YxuD1G
	Jb0YuT952QEfEG7oZF7Md8Ilz+Lz7cOc/9CIgX1Npyvy0KVqNwsnnAICZgYyzGoP9g==
X-Gm-Gg: AZFdTZcHYcIUUdAl882OFTr6PZhostrjainDpFsU6FLXXAVLptfWolFdxOr4KU5PuF/
	f6W8yo1IYNTm8iqMu9zAZXbwXzZEjQimoxnucmt5G+T5Gx5OG6RvxxgoMunMY5nD3kBehEhFizX
	+yDd+DwkU5M/RinDVxY0ueBHgKg3+lo87Q7QK1NjluSkpVDhyHgOPeeeSyPdsbD68pFkBbRUT8l
	MpZlvrdPm1/tQJMLPmOujyuuG10KAbSDF0pjmlnHUp6SFes9UMWWlB7Pwo5JL7rM6ewF76+WJ2J
	UD8JiKB8SShAeIqT1kKw5NYoNY94vdfPi9IBFE9z4eyoKxlI0iBS7JCVDkAYHntr9sClikQ+aWt
	eoLPaQcYQqVlcVvoN1r2roe4+mGTrVjxuoZ9lwo06AS5+eGxMrH/HwqrQku9pAv2wOcQiimMyEp
	NJKXbJYgrD22OVZzq6moK3aq0NQJ88c0vVBtw3TJgMrPTz47tCc29bJXOKgCdMB0w7gUvKpSggg
	MuRvmt9x2BAbmqRgQ0PbZ0vSpz+VJcAAkEl8Qo4x3EXxocp8+48hgu1d1hkwKBLyI+PzRyPgLCc
	5kolizI7KADdiPVvs4PSvbBTVn71k+BZkw27gb4Z7anjyFGx7c48Ixz9QerBKCXR2CcZXyb5+Nq
	I58y/
X-Received: by 2002:a05:622a:13c7:b0:55d:2f53:4e7e with SMTP id d75a77b69052e-55d76a5fa45mr64115931cf.68.1795189394179;
        Fri, 20 Nov 2026 07:43:14 -0800 (PST)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm25429451cf.2.2026.11.20.07.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:43:13 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net-next 1/1] net: neighbour: skip the stale dst lookup for a redirected skb
Date: Fri, 20 Nov 2026 10:42:59 -0500
Message-Id: <CORE-J9UK.v1.r0.20261120103344-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-J9UK.v1.r0.20261120103344@mojatatu.com>
References: <CORE-J9UK.v1.r0.20261120103344@mojatatu.com>
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

Alexei Starovoitov suggested guarding the re-lookup in
neigh_update_process_arp_queue() with the skb's device instead of changing
every producer that steers a packet to another device. This is that guard.

The issue:
neigh_update_process_arp_queue() re-looks the neighbour up from the skb's
dst, because shapers, eql and sch_teql can output a packet through a
different neigh object and it has to be reinjected at the top of the path.
A packet steered to another device by bpf_redirect_neigh(), or by an nft
"fwd ... device" rule, is parked on that device's neighbour while its dst
is still the route that named the device it arrived on. The lookup returns
the neighbour of that route, so the drained frame leaves the parking
device with the arrived-on device's source address and that route's
neighbour as the destination.

The Fix:
Skip the lookup when skb->dev is already neigh->dev; the parking neighbour
is the top-level one in that case and can reinject the packet itself. A
dst that is a route via another device, which is the sch_teql shape, still
takes the lookup.

Some context:
A route for one device is a normal thing to find on a frame that leaves
another one; bpf_redirect() and mirred have always produced it, and the
packet has to keep it for the xfrm, tunnel and lwtstate consumers further
down. lwtstate, NBMA tunnels, the route realm and ICMP errors are
unaffected, and the fast path does not change.

Conditions to recreate the bug:
Two network namespaces joined by two veth pairs, va/vb in the first and
va_peer/vb_peer in the second. vb_peer carries no address, so the
neighbour for its side stays unresolved.

    ip netns add ns1
    ip netns add ns2
    ip link add va type veth peer name va_peer
    ip link add vb type veth peer name vb_peer
    ip link set va netns ns1
    ip link set va_peer netns ns2
    ip link set vb netns ns1
    ip link set vb_peer netns ns2
    ip -n ns1 link set va address 02:aa:00:00:00:01
    ip -n ns1 link set vb address 02:bb:00:00:00:01
    ip -n ns1 addr add 10.10.0.1/24 dev va
    ip -n ns1 addr add 10.1.0.1/24 dev vb
    ip -n ns2 addr add 10.10.0.2/24 dev va_peer
    ip -n ns1 link set va up
    ip -n ns1 link set vb up
    ip -n ns2 link set va_peer up
    ip -n ns2 link set vb_peer up
    ip -n ns1 neigh replace 10.10.0.2 lladdr 02:aa:00:00:00:ab dev va nud permanent
    ip netns exec ns1 nft add table netdev t
    ip netns exec ns1 nft "add chain netdev t c { type filter hook egress device va priority 0; policy accept; }"
    ip netns exec ns1 nft add rule netdev t c fwd ip to 10.1.0.2 device vb

One packet to 10.10.0.2 egresses va and the rule steers it through vb to
10.1.0.2, whose neighbour is incomplete, so it is parked there with va's
route. A cls_bpf program returning

    struct bpf_redir_neigh nh = { .nh_family = AF_INET,
                                  .ipv4_nh = htonl(0x0a010002) };

    return bpf_redirect_neigh(vb, &nh, sizeof(nh), 0);

in the same hook produces the same park. Making that neighbour valid
drains the queue:

    ip -n ns1 neigh replace 10.1.0.2 lladdr 02:bb:00:00:00:cd dev vb nud permanent

The single frame that leaves vb_peer carries 02:aa:00:00:00:01 as its
source and 02:aa:00:00:00:ab as its destination instead of vb's own
addresses.

Link: https://lore.kernel.org/netdev/DMX7RM93TMGR.AXFN4YJ55REF@gmail.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/neighbour.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 887d2e35cd04..219dc89716f8 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1334,9 +1334,11 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 		 * the packet in the output path.  So what we need to do
 		 * here is re-lookup the top-level neigh in the path so
 		 * we can reinject the packet there.
+		 * When skb->dev is neigh->dev 'neigh' is the top-level one.
+		 * dst can be a route via another device after a redirect.
 		 */
 		n2 = NULL;
-		if (dst &&
+		if (dst && skb->dev != neigh->dev &&
 		    READ_ONCE(dst->obsolete) != DST_OBSOLETE_DEAD) {
 			n2 = dst_neigh_lookup_skb(dst, skb);
 			if (n2)
-- 
2.43.0

