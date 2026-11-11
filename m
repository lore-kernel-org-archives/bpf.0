Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410260;
	b=Z4iL48knW2obdAO+q5ZFOJEzL6DZbyNMSfdtEqj78UEjlRZ//o3UwG4k2LIrMwo1PMc+
	 T15jdQzdVd+0IMkR4olRfMHHhNOGCjbWqh6o6/ZqVNh0IZX6uK0haqa+ZCr7R+zkXJLht
	 fb+89nAmkSxqKf5r0Zo3YMl1r973lo73lUnylwGWAbxKbXCL1/mTGnWyd2zmr7vwZwPRo
	 OmdGhkmyC3Ct0mDxdb6jd3PV2MUK/y4qCjt9C6EsRh+PCPrQpMMK31Dq0UBXTqoDSbnbh
	 X7LNsoTcokZwBvJLDMelJ6WRykwK/PoqBEiF4JACnztVOzCrWjf0MdmPhIxo5Sdq8EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9NkKTdy7E+fn5loOIr0xMLoCRO488mmeRzTGz2rZ+m0=;
	b=NPZJ+U5VlCns7l/w1IoVc2cArr+i4+AzlXd1qsLUaFtAodx2cxMZ+R39RaZ43a6SqNR7
	 coSliUyVhvzmQ62SzJC/KJDtYGH7lwTLTUt9y0awqtZ9bNqHBKKqsJr5HOeNgASgiS/8A
	 inaz0c0V66A3t+etvNdOefcCki2zMp92JWXM/zELcI99Ft1JpWed6YZvA1K07wNbFEJZ+
	 Um4TTLye1ry34ytW+tt3SbeEKPUZbwe8z4Fr4k0TE7FYAOnKzp7TgBgdq2/PdWOrbQ0qd
	 uvgLWDEQeCUeRgeR7XIKRYqWZ/S2j/eC0v/xei2VdW/sR0UhI8epFJ+RPJWl4kBoh0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="gy2kD1/w";
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD9606A889
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FCD9606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=gy2kD1/w
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b32bbd39d5so26647517b3.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794410258; x=1795015058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9NkKTdy7E+fn5loOIr0xMLoCRO488mmeRzTGz2rZ+m0=;
        b=gy2kD1/w4DIhUOEdGxhot8FE5VMhvVUwaVJVxe1qDF2iqog973btkpOVJze7aMXSNJ
         Ge3OeASUMNahxRXOJb0x3sFdddKEfL/Hxg8nGJOP1o9LKDB9xsXXrGHlpcilSTZYKsue
         kv7lkjEYiIbt8gTaeCDhVj7sEzn3FCg2Drafc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410258; x=1795015058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9NkKTdy7E+fn5loOIr0xMLoCRO488mmeRzTGz2rZ+m0=;
        b=nBRKjwXh5Jzr3QHkylPA6AU3tGMix4oCwk5+hVAq0kwwRP+Gk+TgGW4KAC7fpk91BM
         ANVNPMrkoYBFjDqrRk08Iv7HutSGJrZcVFd45ljZyYZjCQT//cMFiRgtEHAxZdIj8Te+
         fl6YvYH4crvDfWOiBvWztedDsrXjbhKsyxwlS+ecgBzxox30qXqo5sjGHj6o9S6IJwS8
         2DIPd9nzonWWSWAsGP5m8B/Hz//e8PS+q+KVz6C7e1pVCupDlNZzEiOGLSFDEDGlGsrl
         POKLwzX8UvMml1d/12lz1LiWVq4JwqyX7YAw6ZGfqKYyN/FnIWxJdq5wHyseM8/fkNSU
         hcjw==
X-Forwarded-Encrypted: i=1; AL+hErHX+qUBgJid9xBWKKo5yaazl010SrFzkX6h8cdpva1RaTzM5OmJA9Ivnu20MtYNYRT/w5U=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TZt3T2gKz2l2Uaxf7+LFmZIF4Km3gAwh7t/fALShtNqrE9LLX
	UEU8JSBB+Tczwm8KbOZd1qRM0dzudr7WxKzdepNIfjKe6pnU68Zjsy5Qiqlf4et2xg==
X-Gm-Gg: AYBFou1YX5LMQKlfVBriYXn2NFGrNiHO49JJSTDvbIkK570mpzEDlu1eeIpcaLaklLz
	oyV8tgmKeqGi+EfDSbZA55l4H3t83NvC85mO1AZ+Y4AUDbewMx/xulbEUggcYbj/eMUZuBeWZee
	hWCely49vOLippaehsYmiXB6r33wt7M0u2OzFPBYeLPVVIIZ5juukXL9lzECGTduXvQKYcQM2n0
	wMHVtnIUkpFP6T4qDbvd17ompa0usNP5tBHCaME5I9hPCMjGYjnT65sysW5faYNc2Ymk52/D8F4
	ngFiR60JMZnnzR+9ULTVNJZ+V2SoUEmIyQekiZo+G2W3Xs6nH+ZZqrUpZIm0hdhhjZtu1igtwqI
	jAKukXrHGVEAxgQoMACt6wYVYVqxDUy2Rhwn5CEwC5iNE8V6MVk8ij63V8mTBY9Q4YErHK4QSk2
	RBCUOSJYxaY3NlR6xNVAfGpOG5R6DfhbB9BTudAc8PJUVuEnkz8RsFnyLrlND9ehcwDPUH4l7j0
	rDkiJ+Y3I22r0gt3pjZAhPcSihC/MBRqn8LqcFLRNv3z+s/lqEBhXKSEAleSPW9ZHleJDwBXqLX
	VDus5l+pn9mS4VvEI5kYbmA8Xhxan5aZZsCYd0IDg2V23cKakeid7cCdYKqvnW82Bv1zKRgwkHW
	YLdZoH3TQq1EDbA==
X-Received: by 2002:a05:690c:7482:b0:8b0:aba3:a3e2 with SMTP id 00721157ae682-8b3a80803bdmr21116337b3.37.1794410258561;
        Wed, 11 Nov 2026 07:17:38 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm46499187b3.27.2026.11.11.07.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:17:38 -0800 (PST)
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
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/3] net: neighbour: reinject a parked skb through a headerless output device
Date: Wed, 11 Nov 2026 10:17:29 -0500
Message-Id: <QDISC-6HS9.v4.r0.20261111094338-2@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
References: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com>
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
index d6e9c7c59a89..541cf699abae 100644
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

