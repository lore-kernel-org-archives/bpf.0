Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADB4418CB
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981215; cv=none; b=EbKeGrr+KImBBKce90Q1ScKifcH2WLRYgNZo8H6SmzoA00gNNFK0/XzKRxJDFI9btBdGsHo+cPTz8o32hgloFtghfudjI96EM5Qc/6oF8Hchrfr/jNYvOySgebZFsEsOo2UhP9Ezsh+OAhoeytmp7AYqas+3T/+J6f33IpwxRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981215; c=relaxed/simple;
	bh=rZnQ0PMm5VL4yJDMsgFBeVz/bwBhBp//OxksLjQFeTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnjEpLZxfIek6eSd6jWM37A7wXP7tw7idArQWOX0/4AoCCQR2kh0M8qxS84TeaWGfur3BXh/FGEMW+aBRHCpcfpa6fhc2KJ5+xCGw7/VCr5GAfx3ObiYCOJvJk5gLdufsTjmMtynUnVZZ14JoZQuVgcKAcCgEmSZkXThJAAoT+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPwgBaNu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPwgBaNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786981212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yrE2WAVTHnPnWE47D/Jo1uItQLgBcbb0nvrz/JTSGds=;
	b=MPwgBaNuA90+R9wFsDk2PCv+heOIv3yac09c6ETnDzisf0LzZTgGbTf73P2PX8Ma7dcDGV
	I9WLFY0Woo7/dn+2eSrq4j+sCJusVqfR1btja7Ze7OVbHf8Z+tz+X+mUdZr4jbsyff9fW/
	cCSzg4+Ke/bnutlQwZACLj466AylEXY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-tdlr0MPgMfuVlCyx285NRw-1; Mon,
 17 Aug 2026 11:40:09 -0400
X-MC-Unique: tdlr0MPgMfuVlCyx285NRw-1
X-Mimecast-MFC-AGG-ID: tdlr0MPgMfuVlCyx285NRw_1786981206
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E3271955BC5;
	Mon, 17 Aug 2026 15:40:06 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.143])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2100422;
	Mon, 17 Aug 2026 15:40:00 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Doruk Tan Ozturk <doruk@0sec.ai>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] xsk: reset the mac header in the generic Tx path
Date: Mon, 17 Aug 2026 17:39:57 +0200
Message-ID: <20260817153957.3177627-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

__dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does not,
so a frame taking the qdisc bypass path reaches ndo_start_xmit() with
the sentinel left by __finalize_skb_around() and skb_mac_header() points
65535 bytes past skb->head.

The packet socket reaches it through packet_direct_xmit(), and
packet_parse_headers() was taught to anchor the header by
commit c2707480cfbf ("net/packet: reset the MAC header on the
packet-socket transmit path"). AF_XDP reaches it through
__xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.

ice reads eth->h_proto through skb_mac_header() on its ordinary Tx path.
On an E810 every one of 2817224 AF_XDP frames reached the driver with the
sentinel still in place, so the ethertype never came from the frame. With
this patch all 5757920 frames of the same test carried the correct 0x88b5.
An AF_PACKET sender on the same port read 0x88b5 in both runs.

On a KFENCE kernel that read lands inside the pool and gets reported as a
use after free of an unrelated object, 387 times in a 180 s run:

	BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xddb/0x1650 [ice]
	 ice_xmit_frame_ring+0xddb/0x1650 [ice]
	 __dev_direct_xmit+0x347/0x4d0
	 __xsk_generic_xmit+0xc13/0x1e70
	 __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
	 xsk_sendmsg+0x6c/0x90

Rerunning the same reproducer on the same E810 with this patch applied
produced no reports and no bad reads.

Anchor the header in xsk_skb_init_misc(), which runs once per skb for
both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not a
real header, but it stays in bounds and no such driver reads it.

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 net/xdp/xsk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4b640..885427392cb6b3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
 	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
+	skb_reset_mac_header(skb);
 	return 0;
 }
 
-- 
2.54.0

