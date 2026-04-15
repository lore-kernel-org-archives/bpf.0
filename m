Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DCC3CF03E
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241656; cv=none; b=ZYlY3tOe0c+qsgRcNLroAis4Bc4wiWA0YYyx0kYmMRy4gdx446TQFVPgf2UaPd6KAFqWIDQ2wTajzvx6ikjuVtVLMmipGo0mDq8EvhQeze1wIFMSrq2uQVQnAWQ8TAXkKiFZIQQ3fdoRicmz5w05RqjEstHsFQZldkIq6/VoQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241656; c=relaxed/simple;
	bh=w3ecYzeaYIX144bVqfj87tUxIv4KDadRulXpFJ/Fy+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+Y/T/tvNWMUwv5CQtptdP/8CXCOBYvk2uaei41ZmL0lBphd1YdPeSMs+HVY5hDBeB6qt7Jr2dMYFRm79ra2e/zQCOYYYuvpQ7wmHXxiVdJGkrwAdZhcKiOqXJXI5YST30TZZ9ubBjI+FTAixIE8dBYvMllzMyb0nAjlAzKbEMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVGWEQsW; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVGWEQsW"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c795f096fa5so47866a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241654; x=1776846454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HPTqFxSpqPQ2VPcQ/yN5CAn5MjWpzRzTPnq/lPxxAM=;
        b=SVGWEQsWW8PCfLBa3t+5vAwDgtq09Ia9s0y7qw8d5hAp8d1NbzP0cbObFlXTzpGMOF
         9DRhWeInJWLIlCIw1vMaM7n3Dhl2R5dRKK4dLFxoao84b9K9vlcokKt5TJGfmf8QzTVT
         8xuwUS6LRuVMRTUX6Eip7QRqT04bwYkRKzN7mBlMYe8GmK1xbfklmv2TtE/cS2gDmwpZ
         O8+tDDWnT3mF5617Cd9F060F8FTzAggKCmph18XsW7OQXdLH6HEcr6mWPHYUV9WInx/B
         MqfTx8xY2dL+ow/cSHXF7bEQZB6QZ0cKHwUCq2SnZjhrIyEOdWaQCHv/f8/S5voE3IDl
         12pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241654; x=1776846454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2HPTqFxSpqPQ2VPcQ/yN5CAn5MjWpzRzTPnq/lPxxAM=;
        b=OWFPzwb8fRbaakZjMcdwPUjJ4b0/guayKYSWORbtFt9uBJiLotLbtT4amdjFt2l1q+
         9XVH2lG3dyQqOEHlgRGkeykjP0z28zk505rHpcNLaifRy0ygQ94hQQpoJB7RChFwMobo
         T/30x3j6Z1FaMYif4+FCv7bsqkbD2Vm13qT9Wq2cjlFdtZ/3GVg3BtHn2FKa8SayYPB8
         8guheitM9BYV/VnZMj3gCAOMrcPUayZMPbsEOwsRUCu5yb2zPiXkU0chSkbUikv51nL8
         SV1cC3fOtoGNXBGzobmqe0i/kaYoQ2CA+aCHtuEoHHcu8M8g0VrliJGFpnsQeCJRFwKh
         DjXg==
X-Gm-Message-State: AOJu0Yx+J0YGdHb8JBYqsubMVIirL/3aJ9qs0myl3IuZ3iMmttGHMwQJ
	5xPlBRKQjbX7MqVhMkFfKWaY+eJxroYa64jGf19hcE+1qKt9e+RGZU5o
X-Gm-Gg: AeBDiesmHkkBY31Fqzu3KpUS4mSQEfdPVwymAOYImttL5tjssiJH88fk6LNFgaQqnKk
	akospDungkwKOVBe7fV4ZMbfT7zAP9H5CSGf7ikOOD/JIFn7ERyDlmqhco6nH0KZy7ckKRlxzY5
	fPRK1+F+0g9d4kFVAlwgvSPtH6MZ6s73boJX11i9WHQT8B2cHKl+LkEDq31YXp88zGWzXz0hiZz
	Yw4GEKh93M7WxZNYl7l+00Mu7eME5f7Krfr9089GCMPvCKOK/5pYnswW/c2PgD38hzx6mXZaRh7
	PpziccWn523FyjtgKFa6WNg2dsO5ciOqJOLX4JqN+lrEb51kt0oZbiTRX6ui1ACvtGdeXR+5L9d
	MJ6IGswLGNX814GJ5OLChdD0FwRVsQ+hyJ/+6jQu6ybmlo81CWgJKTLWaySvuYSF1bp5ri6VYsl
	v8HklkBqE1UR1tJxf4zs6aNlDx4KP7zwTgT3cgKnw79ECwIARds6zYA6xAlFjywQHvY4FntYG/Y
	FbpZLpw
X-Received: by 2002:a17:903:2785:b0:2b2:45b7:306e with SMTP id d9443c01a7336-2b2d593683cmr144363155ad.3.1776241653713;
        Wed, 15 Apr 2026 01:27:33 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:32 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH RFC net-next v4 05/14] xsk: add direct xmit in batch function
Date: Wed, 15 Apr 2026 16:26:45 +0800
Message-Id: <20260415082654.21026-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add batch xmit logic.

Only grabbing the lock and disable bottom half once and sent all
the aggregated packets in one loop. Via skb->list, the already built
skbs can be handled one by one.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  1 +
 net/core/dev.c         | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 2151aab8f0a1..0609e3b04279 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -141,6 +141,7 @@ struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			      struct sk_buff *allocated_skb,
 			      struct xdp_desc *desc);
 int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
+int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev);
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
diff --git a/net/core/dev.c b/net/core/dev.c
index 4519f0e59beb..e33a2406d8ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -163,6 +163,7 @@
 #include <net/page_pool/memory_provider.h>
 #include <net/rps.h>
 #include <linux/phy_link_topology.h>
+#include <net/xdp_sock.h>
 
 #include "dev.h"
 #include "devmem.h"
@@ -4893,6 +4894,46 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 }
 EXPORT_SYMBOL(__dev_queue_xmit);
 
+int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
+{
+	u16 queue_id = xs->queue_id;
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_id);
+	struct sk_buff_head *send_queue = &xs->batch.send_queue;
+	int ret = NETDEV_TX_BUSY;
+	struct sk_buff *skb;
+
+	local_bh_disable();
+	HARD_TX_LOCK(dev, txq, smp_processor_id());
+	while ((skb = __skb_dequeue(send_queue)) != NULL) {
+		struct sk_buff *orig_skb = skb;
+		bool again = false;
+
+		skb = validate_xmit_skb_list(skb, dev, &again);
+		if (skb != orig_skb) {
+			dev_core_stats_tx_dropped_inc(dev);
+			kfree_skb_list(skb);
+			ret = NET_XMIT_DROP;
+			break;
+		}
+
+		if (netif_xmit_frozen_or_drv_stopped(txq)) {
+			__skb_queue_head(send_queue, skb);
+			break;
+		}
+		skb_set_queue_mapping(skb, queue_id);
+		ret = netdev_start_xmit(skb, dev, txq, false);
+		if (ret != NETDEV_TX_OK) {
+			if (ret == NETDEV_TX_BUSY)
+				__skb_queue_head(send_queue, skb);
+			break;
+		}
+	}
+	HARD_TX_UNLOCK(dev, txq);
+	local_bh_enable();
+
+	return ret;
+}
+
 int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
 	struct net_device *dev = skb->dev;
-- 
2.41.3

