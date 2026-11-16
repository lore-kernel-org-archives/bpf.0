Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825413;
	b=OF+twg4iNrlcSyKCiyNJ6YrTzS+/GFFBiMmC/4AiMdFjfNEAWKfCPnN5s5VE+wz8aABA
	 idx+X68rs4lOsSwGbPezzuIAectUqvmwqzNuXqQahlzUlHmVRJ6UlMFQlunqVypb/rqIh
	 DFZuvRxtRaq+C/gw8WaXqN8D3jq0hoCeMY55gla37bEIwe5lLODvZLK7j4TSeHHzwLJRd
	 z2ohF9ZcIRuTEVlCHDVMKj9tgL1wnXanbr7CZZFBHIymO6zrbb/PW/7d+V/i3erYltGMK
	 UPiW7CME0JKukpxTANfGCg4XmhCYw+TtOpcSRwtjRicVrGpdkVRqLzXmW4t0YDX6/xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=opkasNgH5N2ElWKTLtDlU79vyZanUWteaYR8uJXKCIE=;
	b=jIDQk0SigcA65fwfv7uERTlDYPdQYw4XrlMtGm9rB+0YCm6XVJVvfmcfc4RZBOmH8Sb1
	 GqwFSmpekbaaS9ZiqseszyAtNUR5O9hAxCcLRe1OZcFYrWfIAEdYiYwEkP0ShppFG35+G
	 E7+7GBhUsubiy+vONmFzZTt4r+6MLucSg3aY4DNsdVABzpbDggh2ktkPRBHwBcNIkqE+u
	 ZmEl0n3IpYGjSwENKWRS2jn74gpDRsC5CRjpht65lx1EbODipiof2xPvk/fLwGNLsOSkM
	 j2OVI6Mrpra8HH8rFJeVMMtFzmJnB/c1k5bbigDTn+M1S3kstRyzMI2wyXdNX/t3s0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qNy1jVqW;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6AC606A332
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C6AC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qNy1jVqW
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-536717a4d83so35663481cf.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 02:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794825412; x=1795430212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=opkasNgH5N2ElWKTLtDlU79vyZanUWteaYR8uJXKCIE=;
        b=qNy1jVqW6L9/5zG4gg7sEdmDaV5qrCkIrOMT60lMGphvhx75VTvRFFRnCXrKjWR2Zv
         TBRLQ5q67oU4GX5Ux67P/OHxvbvP9xVTZsWlnyJHyASSZAToHpFGFehpZFvDNdClwGNx
         n7SfBm+L2DGwfTH9oyOf5ZdA/wdkH0XydmsRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825412; x=1795430212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=opkasNgH5N2ElWKTLtDlU79vyZanUWteaYR8uJXKCIE=;
        b=ZYIkMm65EAqPYY2BLoDLGjz1JmJDloMGaaYIU5Lj6BvcEXirzAEqr4IYapyBgtKA5x
         KTQ3tL3BwF3oNgkIt+qKa2IIM4YvcMiKf5bFk5lA3tlX5aoqChPcjVhYIm5TQzBEt9iR
         RB7hsGfuxWHfjI7rZZcH7T/ob434WJP/tv6tLfLgQURGpyLJJ94oY6Z0MeIdi0zlSdSL
         mE3YZUvdmC64UcWo64QDcNvcjTKJ2kOgZchx2Kk+B+1MrVZq+JZ/0NCbgL4I2ZDHhrXK
         10wP0bmNduAfJCoQfeyCmPiYJgHYC378SxEVgI/+lSIJF+9JOgLlgiWkzTipKXBzAbU6
         VNKw==
X-Forwarded-Encrypted: i=1; AL+hErFHEm0FUcZU8gUVvmTDRqsbp4+XxnhUZ7FF85q0xRve95WeZtE5v4sRlWDlewKEmTc8W28=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9+KQYGR5ChY2JjP4XZnwWWd4qd9z84nCSULYgUsfDI7a2sYUr
	CL4MgGJOQ1RoDLe150V9VhZCk7F371PirS36VsH0z/SIJV+2WF1NdRuHMHGJbAHLIw==
X-Gm-Gg: AYBFou071xhk9v57b+OY7AKaQMcJYJFP2zcC+zHhVJDf9C1uF8so2cT7eYpTIUdPdmg
	y0d/iV8mvtNDhwqUC1BjbW4iF8EtqEfhJdNiBqIuuNVovGifMm9TwU2KsBoop4hWyk7BPKF7gtG
	TgBELEtjwGR2ynuPhT/lMsYyCnb2lgmGu2/CG05tjiUy1ysJtuaMWmSexwRMl97cDFwNylAVH2z
	ClAg58GLhf7kbfT2pevidxqLPYA/NDXrHdzeJsj0zSXvmpusaWdgIUeXwFFDRgUohaqRoCzRw/C
	hjTMZrhSkOKw53Kwl6Ebk9u433kWu7oUU/y2/moUGHAR8x7MqUUtlXWL62jykNUuFrxEuj3zFCp
	LiXsb65wNa7StBjpb9XE8LuncBNuzBb2XyFiMSlQqjX9DMwjybiLu1068DWJUbKmyGDXOQuz4OT
	W1Tai+hSRiId2yceQovwCsjZbg186y+Aw54MjIVbqcW5Nu4ekkWHUaJVCxupYk9C/KOHwTKCLUA
	8atbBoxUCSR0XQERCDll9WtugrDiBiGX4Xq7V1AG+sqnJIu69akw9ohoFuwObS4rKkIp4RiUh16
	YfBRpFosBMaFBSU40s5sCxFGcd1Dp0SdpNKbViiYSWZ60iCCVitlpO9Xhca65cMOpi76zIreQJs
	=
X-Received: by 2002:a05:622a:58cd:b0:535:a5fb:67fd with SMTP id d75a77b69052e-55aca05b3aamr157894831cf.73.1794825412136;
        Mon, 16 Nov 2026 02:36:52 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad14f1ecasm77778651cf.24.2026.11.16.02.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:36:51 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5 2/3] net: neighbour: reinject a parked skb through a headerless output device
Date: Mon, 16 Nov 2026 05:36:42 -0500
Message-Id: <QDISC-6HS9.v5.r0.20261116052927-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v5.r0.20261116052927@mojatatu.com>
References: <QDISC-6HS9.v5.r0.20261116052927@mojatatu.com>
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

The issue:
neigh_update_process_arp_queue() drains a neighbour's arp_queue and
reinjects every skb through READ_ONCE(n1->output)(n1, skb), where n1 is
the top-level neighbour re-looked-up from the skb's dst, not the neighbour
the skb was queued on. skb->dev is whatever the producer left there.
Note: skb->dev and n1->dev are not guaranteed to be equal.

When n1->dev has no header_ops, arp_constructor() and ndisc_constructor()
install neigh_direct_output(), a plain dev_queue_xmit() that transmits on
skb->dev and builds no link header. Such an output sends the skb out
whatever device skb->dev names, not out n1->dev, so a producer that
parked the skb naming a lower device has it leave without the link header
its own transmit path builds.

sch_teql is the producer that hits this: it parks the skb on the slave's
neighbour while the top-level neighbour is the master's, so skb->dev and
n1->dev differ and the reinjection has to come back through the master to
leave with a header. It names the slave on purpose, so that a parked skb
does not outlive the master it came from.

This half was split out of the sch_teql fix on review, so that the
neighbour restore carries its own commit log and its own Cc set.

The Fix:
Put skb->dev back to n1->dev before the output call when that device
builds no link header, so a headerless output transmits on the device the
neighbour belongs to, whatever the producer left in skb->dev.

A forward that steers the skb to another device, nft fwd ... neigh or
bpf_redirect_neigh() with explicit nexthop parameters, parks it with the
dst of the original route still attached. When the original route is
itself a headerless device this gate matches there and the skb goes back
out the original device, running its egress hook a second time. Those
forwards supply their own device and nexthop and do not consult the
retained dst, so dropping it at those two sites is where that is fixed;
that is a separate change to the producers.

Conditions to recreate the bug:
CONFIG_NET_SCH_TEQL=m and CONFIG_VETH=y, run as root. This is the
neighbour half of the sch_teql parked-skb fix, reached once sch_teql parks
the skb naming the slave: create a veth pair, make one end a teql slave,
give the master an address and a route, flush the slave's neighbour entry
and send one packet:

  ip link add v0 type veth peer name v0p
  ip link set v0 up;  ip link set v0p up
  tc qdisc add dev v0 root teql0
  ip link set teql0 up
  ip addr add 10.0.0.1/24 dev teql0
  ip route add 10.0.0.99/32 dev teql0
  ip neigh flush dev v0
  ping -I teql0 -c 1 10.0.0.99

The packet parks on v0's arp_queue. When the solicitation resolves,
neigh_update_process_arp_queue() reinjects it; without this change it
leaves v0 directly, with no link header, and never reaches the peer.

The window that frees the master, and the unload recipe that shows it,
are in the sch_teql patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/neighbour.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d6e9c7c59a89..1b556fa17c57 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct neighbour *neigh)
 			if (n2)
 				n1 = n2;
 		}
+		/* headerless output transmits on skb->dev, not n1->dev */
+		if (!n1->dev->header_ops)
+			skb->dev = n1->dev;
 		READ_ONCE(n1->output)(n1, skb);
 		if (n2)
 			neigh_release(n2);
-- 
2.34.1

