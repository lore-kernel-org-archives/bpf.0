Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE66477E23
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806694; cv=none; b=Ul4UsvtReYWS6rSb521rCvIJ+6yct9WQ0OAIiqMrV3/j9vuwgHEcQbq6rW15Fch0+v39X8X3w7/Nv3qfR0yITs7y5FS/pzFYIzHXY3dey0lNi1TCvQsXyNdHFOnfkGnuqzJu54PFkoOdgBRqk6t5BggDAYK2oDPk9yyaSEdywXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806694; c=relaxed/simple;
	bh=8dxMAz/3bVniLT9GlqZAEGuXrm/1/vBKQ5LFvnkTugg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qcTtW7bCJ3Q4Q5Wvb78Aj2mqkFZUksRMfQ/LvyFstiyReGcuUbYsoH38ITH+K9BzzbK6LkAbbdZT65yMqXMFYE12PT0vdyG42K2rJZgZYHo2hLzhZ5f5B/mqTrvb2KRs87Acfkm68Hb3GJRU7g1VPbK6PR7b03nhiAvKodSYt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9jSPJND; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9jSPJND"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-82395ae2ea8so1414319a34.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806692; x=1792411492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mHvTL1gZeI43MeOEN91Zyrc10MwgGLl2JxNH17x0Xk=;
        b=Q9jSPJNDx1Tkq8AcV5u+537hlyXVR8kKjCwQEK36RpH0rr7qxmkh8U6gUm6d3rTR3Q
         WBeTNXCS+WVyW8G/7wGywAW2B94VNaeNeC8+bqbYle7dHdV/msE/iqS8qGKtKRBflWPq
         GV6oHkK1MvGz4TAkwVPUbQhSk7m1tsCQy3ptu5Jj/6HmB8AYH8WSw0Sc66j5VRuQgb1b
         VFMTnq+DjFEIbGAkYoooG3obOfSGwMc4VK7JZWAim6d63ACeWuSx5KfYPW46V7MScpQ+
         3Qs2x/6QKqTWoN+f0PM1v5arYEtZpkD0CYU6VoY2+u8wO+lH/wK57EAB6EKV8IXh9LKt
         xPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806692; x=1792411492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4mHvTL1gZeI43MeOEN91Zyrc10MwgGLl2JxNH17x0Xk=;
        b=v4TdZuk3ckKAa6mEXJQdAiURAa0/TN4BXe2Llf0xetV2yYk7LURrEUCGWzWAZ93KeX
         pa9Sra/m2r4I5AxZ9NrXAbd5wohsXw5P0z2uQk4w9By4o8R3lBJHJJYWJ82lI35YQ/0U
         hKzurWD/GnAdgwq34vyfdMOOLOo1nVVrIlU5P2CY69S21VxPLZJx+d6BIukY2t1wKpB1
         a/G+8v/M0vDuhKxx0BP7y4LdZHRhelC/wT/0x5yMKYnwKOIP1Xj8ptUTQXbJnbgeDeVA
         1oYgptodVdMD1q3wOU880WPFRCncbE/f35yiPfWwaw+LohCFVzhP86Y6G5wIZknHus/G
         m4Rw==
X-Forwarded-Encrypted: i=1; AKwUvBzbNU6AEGeVxJ2PiY4ZyDHpxB06NB7uN0/HmE6DFzwShCKp3GahX76ZjSRrdrSuaZ6AKLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKV2XPO3eWlAUr3/oKjpRoq8fUAsGjxFXjoK1kRyd1ObX7aiqmT
	OgUMtfHgIEp50InxEhfHp+Hdsree8DsAUdeSTxJInjxlxX79vE6TVPEZ
X-Gm-Gg: AYBFou0kPAlpI/oJrNHN27ATHhxExBgJXKia9PyP+eI7VLr+kh6QvMAnQ5fFszG9CNP
	xB6tKa4w7pjrxHACJGoGy7ubtZXl6iKYOH3SvJMkC/iMzqMABhJz1khAYJsyjmQYwTdXrvW3oTx
	w42F5OHWo4xCywjsPzYJfvDTwtq+XzLm18JOfyhrvkPLzgvoTK8ZlkRCUGwsMpi2wyigZdhxCwC
	CoUfd8zvQSRH2z8lDSfHn7TXVwlDJ0CLsXLjYOU4cpw5591yY7p1GxY3Y0IaicI71TYT0yvE53p
	mxFWnaRS+w4cfe6Bte62XFHqasEoYD7HtopWYBY6c8idukLBJf6zGAfp65eZjimwCXXw3mT1P+T
	VTgutSRcGK2aKGaaj9zTr3f/oRyT5NAKRiPBpGa5LE236F1lv3HkzTI8pT2RDtZ1qUT++n8XoH1
	HhjfhCwZ5pyUeB5qR8iFDR2p8ImjU1lNJ+nK0pqdEeEhkAOPdP3dO9KQ/0dEmjznkoDUg=
X-Received: by 2002:a05:6820:8185:b0:6de:2f70:dae3 with SMTP id 006d021491bc7-6ef0f7a3622mr7157468eaf.29.1791806691967;
        Mon, 12 Oct 2026 05:04:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a858aa3esm9471911fac.12.2026.10.12.05.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:04:51 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Mon, 12 Oct 2026 05:04:35 -0700
Subject: [PATCH net-next v2 2/4] eth: mpnic: report per-queue stats
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mpnic-counters3-v2-2-8afba81c2d5a@gmail.com>
References: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
In-Reply-To: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Expose the per-ring packet and byte counters through the queue stats
API. Counters for deactivated rings are reported through the base stats.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 73 ++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 5164475a0f94..c2f4a326a8f0 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include <linux/types.h>
+#include <net/netdev_lock.h>
 
 #include "mpnic.h"
 #include "mpnic_netdev.h"
@@ -146,6 +147,77 @@ static const struct net_device_ops mpnic_netdev_ops = {
 	.ndo_get_stats64	= mpnic_get_stats64,
 };
 
+static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_rx *rx)
+{
+	struct mpnic_net *mpn = netdev_priv(dev);
+	struct mpnic_ring *rxr = mpn->rx[idx];
+	struct mpnic_queue_stats *stats;
+	unsigned int start;
+	u64 bytes, packets;
+
+	if (!rxr)
+		return;
+
+	stats = &rxr->stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		bytes = u64_stats_read(&stats->rcq.bytes);
+		packets = u64_stats_read(&stats->rcq.packets);
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+	rx->bytes = bytes;
+	rx->packets = packets;
+}
+
+static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
+				     struct netdev_queue_stats_tx *tx)
+{
+	struct mpnic_net *mpn = netdev_priv(dev);
+	struct mpnic_ring *txr = mpn->tx[idx];
+	struct mpnic_queue_stats *stats;
+	struct mpnic_q_triad *qt;
+	unsigned int start;
+	u64 bytes, packets;
+
+	if (!txr)
+		return;
+
+	qt = container_of(txr, struct mpnic_q_triad, sub0);
+
+	stats = &qt->cmpl.stats;
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		bytes = u64_stats_read(&stats->tcq.bytes);
+		packets = u64_stats_read(&stats->tcq.packets);
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+	tx->bytes = bytes;
+	tx->packets = packets;
+}
+
+static void mpnic_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	struct mpnic_net *mpn = netdev_priv(dev);
+	struct mpnic_base_stats *base;
+
+	base = netdev_lock_dereference(mpn->stats.base, dev);
+
+	tx->bytes = base->tx.bytes;
+	tx->packets = base->tx.packets;
+
+	rx->bytes = base->rx.bytes;
+	rx->packets = base->rx.packets;
+}
+
+static const struct netdev_stat_ops mpnic_stat_ops = {
+	.get_queue_stats_rx	= mpnic_get_queue_stats_rx,
+	.get_queue_stats_tx	= mpnic_get_queue_stats_tx,
+	.get_base_stats		= mpnic_get_base_stats,
+};
+
 /**
  * mpnic_netdev_free - Free the netdev associated with mpnic
  * @mpd: Driver specific structure to free netdev from
@@ -176,6 +248,7 @@ struct net_device *mpnic_netdev_alloc(struct mpnic_dev *mpd)
 	mpd->netdev = netdev;
 
 	netdev->netdev_ops = &mpnic_netdev_ops;
+	netdev->stat_ops = &mpnic_stat_ops;
 	netdev->request_ops_lock = true;
 
 	mpn = netdev_priv(netdev);

-- 
2.52.0

