Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2A4CDDE7
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545740; cv=none; b=goPOWAjZqDXpJzfzTOL6KeWHNjjGpeiuSEseY/BNGCKYbq+EXwf4adUQOucuFuWe2/+VDRguEsrrUsg5n87g8qDeSFkpKwGvu6hQW3n2AYqmR6tSPoU4AB7ZXo7z+sCoKMl3faHtoTBlGIaN74tLjN4stCWEQ4On3ElQfSjXgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545740; c=relaxed/simple;
	bh=oftSqSNxAmSJGZwtSUlMSlBmKCJvlrKpmxylbOgxbn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Il7IlTMeO0i5LIjZPbwuvxDFWxwVDQLBCLLiPS546JWg35fV3h1UhZu0vj6Rghoz7/m1kZzFhS2FBzEiK0338XGq2iJoxyj8wl5rZmldmnRoXwMfZgn/jW9O8nNJa7LjftS9YYtsUaVv3hbxcRE/+gtknzGc0sdM7npDXVBzVFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZfz8JWQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZfz8JWQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-82395ae2ea8so5351206a34.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 04:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791545725; x=1792150525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4mdbNaS2RRyeKNgKYK6YRPUChL14pwWX8aLwe3X11A=;
        b=pZfz8JWQWggEL7SdNrDVoBwOMeOCY2sb9EnSVCR5mJsjKWjxf2TL03XIA2Bt1nDqvu
         +gWiwMUcd4YLw7XuC4Q7NtMngUEu1Ggyz/9ewhG2Z77o5tSXVq75IHMGNZaWCSm5dlgb
         NBpABAcL4wKxButzxjYxr63/a7lHPsmEAzFIYM8qdj2Dh2icoz04q0XPMgfgDnLEpb/5
         GFEQui4TzejvGdvh17/3p8o12+2D2+IxFaWxjrfl4Hfygagzqpu3j01/1qyzoIwViA5s
         kA50P1J2cSI7m7B4eKQAhfMYq5nHrQ5/WvEX4zh4JdPWmMgkSAFM12S8jHXL2yHvFKbi
         bMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791545725; x=1792150525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4mdbNaS2RRyeKNgKYK6YRPUChL14pwWX8aLwe3X11A=;
        b=PCU59kNPoK0NYUh4qIKgtWHlyz/6HlF1KRIjIIVmeXaUIzbQF8rGZcTFENa+zHmMsD
         xPLKJSjMW/g3aJAVEvX8uwJF6BYghp7gyKOfIHrctoYv0i3MUkFFETXiNGqn5bNLeZHN
         j5Lk2/b/OGL6kNsHj4q7H74JNRx2du6xtKWKhCn+r1UDJHl119hIJgN612MoyEZyVubY
         A5bropLuhycqDK2dl97w61F8FzwoRJkCOhXnkKx0vOHhBKbWSCDwd8epJ/QyDrbiT8II
         toOj7VB1JvK8RUKgawFCN+VLvx6zizztXdQTyUhEJC97DAc4rxHJnzEtHuHhpLF7uBxy
         infQ==
X-Forwarded-Encrypted: i=1; AKwUvBxM54ImveJoQAQuP5d/7X5IqIkO3WbQvO4VWLX6TirCIvQ05lPP1yPCR9gt0gSmibqPqag=@vger.kernel.org
X-Gm-Message-State: AFuF++k6rSNeS145yJuonKR0u4DoT56Laj6IFmWeYuNMaZ7pyTn8a80L
	iuvV83vTBM68Sigz46KFGl46jS0C5NpR2gujgNGIzydKWs1xPqIlHExQ
X-Gm-Gg: AYBFou0ABOs/V7f+AzLqCFe/QBUBBF/ojkACdPMldNTW8WsCJ7DAbeZsjP4V82mfu+W
	6Ut8InZZb9IoiJBLJrjFqr56cDRJWzj29B738mbeh36ooNAaS7El5x8dv2SYiA4LKRhZRuOMTA0
	fn9aowsZ6hF1BD3k/2Yv45REhI46e8309kiHih7/wd2QDQgbohxeKvRcvkr0Ar6JcQSfOW/Bjj9
	ErrK8b2zQuwdJ/7qx2hkiLBFeyi7cy8mHLMEeGRI6RvHPXjk6U+ysoWEkFpw8I+PkYibnvpiJXs
	BT0OmRWv6LPd/cUWlcmD+cGE9BRvGWTBN6zjQ/8Tsdf65EfXWAemUOJcGzbd6FWOGxcHx57GJJK
	WWG0bQaWgVAcIhaoWk8MNf0SR4LSr6ZiBlFgLVvGqNC+hjSQqk1CmYm+cZnqxOeLlZ50dq8QDIM
	yaG6F8241y557F+qJ5Bo9+SqamqtBEW8qF+9sIn/hduJcX7s4peyV77MVjqqEdwshlWYE=
X-Received: by 2002:a05:6830:6816:b0:806:1e7:4167 with SMTP id 46e09a7af769-83095843911mr1267831a34.13.1791545724799;
        Fri, 09 Oct 2026 04:35:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3e016sm1452421a34.17.2026.10.09.04.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:35:23 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 09 Oct 2026 04:35:07 -0700
Subject: [PATCH net-next 4/4] eth: mpnic: count Rx allocation failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-mpnic-counters3-v1-4-7dc7644cc500@gmail.com>
References: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
In-Reply-To: <20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com>
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

Count both skb allocation failures and page pool allocation failures per
queue, and report them through the queue stats API. The bdq allocation
failures are added to the skb allocation failures when reporting to core
and folded into base stats during aggregation, because the qstats API
doesn't support reporting them separately.

Page pool allocation failures are also counted when the BDQs are first
filled in ndo_open, which runs in process context. mpnic_fill() disables
BH around the fill, so the u64_stats update happens with preemption
disabled.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 24 ++++++++++++++++++++++-
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  1 +
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 27 +++++++++++++++++++++++---
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  4 ++++
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
index 9e262f939c79..7fdf57f70151 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.c
@@ -147,14 +147,29 @@ static const struct net_device_ops mpnic_netdev_ops = {
 	.ndo_get_stats64	= mpnic_get_stats64,
 };
 
+static u64 mpnic_bdq_alloc_failed(struct mpnic_ring *bdq)
+{
+	struct mpnic_queue_stats *stats = &bdq->stats;
+	unsigned int start;
+	u64 alloc_failed;
+
+	do {
+		start = u64_stats_fetch_begin(&stats->syncp);
+		alloc_failed = u64_stats_read(&stats->bdq.alloc_failed);
+	} while (u64_stats_fetch_retry(&stats->syncp, start));
+
+	return alloc_failed;
+}
+
 static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
 				     struct netdev_queue_stats_rx *rx)
 {
 	struct mpnic_net *mpn = netdev_priv(dev);
 	struct mpnic_ring *rxr = mpn->rx[idx];
+	u64 bytes, packets, alloc_failed;
 	struct mpnic_queue_stats *stats;
+	struct mpnic_q_triad *qt;
 	unsigned int start;
-	u64 bytes, packets;
 
 	if (!rxr)
 		return;
@@ -164,10 +179,16 @@ static void mpnic_get_queue_stats_rx(struct net_device *dev, int idx,
 		start = u64_stats_fetch_begin(&stats->syncp);
 		bytes = u64_stats_read(&stats->rcq.bytes);
 		packets = u64_stats_read(&stats->rcq.packets);
+		alloc_failed = u64_stats_read(&stats->rcq.alloc_failed);
 	} while (u64_stats_fetch_retry(&stats->syncp, start));
 
+	qt = container_of(rxr, struct mpnic_q_triad, cmpl);
+	alloc_failed += mpnic_bdq_alloc_failed(&qt->sub0);
+	alloc_failed += mpnic_bdq_alloc_failed(&qt->sub1);
+
 	rx->bytes = bytes;
 	rx->packets = packets;
+	rx->alloc_fail = alloc_failed;
 }
 
 static void mpnic_get_queue_stats_tx(struct net_device *dev, int idx,
@@ -221,6 +242,7 @@ static void mpnic_get_base_stats(struct net_device *dev,
 
 	rx->bytes = base->rx.bytes;
 	rx->packets = base->rx.packets;
+	rx->alloc_fail = base->rx.alloc_failed;
 }
 
 static const struct netdev_stat_ops mpnic_stat_ops = {
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
index 0d1ee66dd86c..6711766ebc3c 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_netdev.h
@@ -23,6 +23,7 @@ struct mpnic_base_stats {
 		u64 packets;
 		u64 bytes;
 		u64 dropped;
+		u64 alloc_failed;
 		u64 errors;
 	} rx;
 
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
index 35129fc149e2..91b897d766a8 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.c
@@ -409,8 +409,12 @@ static unsigned int __mpnic_fill_bdq(struct mpnic_ring *bdq)
 		struct page *page;
 
 		page = page_pool_dev_alloc_pages(bdq->page_pool);
-		if (!page)
+		if (!page) {
+			u64_stats_update_begin(&bdq->stats.syncp);
+			u64_stats_inc(&bdq->stats.bdq.alloc_failed);
+			u64_stats_update_end(&bdq->stats.syncp);
 			break;
+		}
 
 		bdq->rx_buf[i] = page;
 		mpnic_bd_prep(bdq, i, page);
@@ -598,6 +602,7 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 	unsigned int packets = 0, bytes = 0, dropped = 0, errors = 0;
 	struct mpnic_ring *rcq = &qt->cmpl;
 	struct mpnic_rcq_state *state;
+	unsigned int alloc_failed = 0;
 	__le64 *raw_rcd, done;
 	u32 head = rcq->head;
 
@@ -633,6 +638,7 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 				   !state->pkt.add_frag_failed)) {
 				pkt_bytes = xdp_get_buff_len(&state->pkt.buff);
 				skb = xdp_build_skb_from_buff(&state->pkt.buff);
+				alloc_failed += !skb;
 			}
 
 			if (likely(skb)) {
@@ -667,6 +673,7 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 	u64_stats_add(&rcq->stats.rcq.packets, packets - dropped - errors);
 	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
 	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
+	u64_stats_add(&rcq->stats.rcq.alloc_failed, alloc_failed);
 	u64_stats_add(&rcq->stats.rcq.errors, errors);
 	u64_stats_update_end(&rcq->stats.syncp);
 
@@ -727,12 +734,19 @@ static void mpnic_aggregate_ring_tcq_counters(struct mpnic_base_stats *base,
 	base->tx.wake += u64_stats_read(&tcq->stats.tcq.wake);
 }
 
+static void mpnic_aggregate_ring_bdq_counters(struct mpnic_base_stats *base,
+					      struct mpnic_ring *bdq)
+{
+	base->rx.alloc_failed += u64_stats_read(&bdq->stats.bdq.alloc_failed);
+}
+
 static void mpnic_aggregate_ring_rcq_counters(struct mpnic_base_stats *base,
 					      struct mpnic_ring *rcq)
 {
 	base->rx.packets += u64_stats_read(&rcq->stats.rcq.packets);
 	base->rx.bytes += u64_stats_read(&rcq->stats.rcq.bytes);
 	base->rx.dropped += u64_stats_read(&rcq->stats.rcq.dropped);
+	base->rx.alloc_failed += u64_stats_read(&rcq->stats.rcq.alloc_failed);
 	base->rx.errors += u64_stats_read(&rcq->stats.rcq.errors);
 }
 
@@ -769,8 +783,13 @@ void mpnic_stats_fold_rings(struct mpnic_net *mpn)
 			mpnic_aggregate_ring_tcq_counters(new, &qt->cmpl);
 		}
 
-		for (j = 0; j < nv->rxt_count; j++, t++)
-			mpnic_aggregate_ring_rcq_counters(new, &nv->qt[t].cmpl);
+		for (j = 0; j < nv->rxt_count; j++, t++) {
+			struct mpnic_q_triad *qt = &nv->qt[t];
+
+			mpnic_aggregate_ring_bdq_counters(new, &qt->sub0);
+			mpnic_aggregate_ring_bdq_counters(new, &qt->sub1);
+			mpnic_aggregate_ring_rcq_counters(new, &qt->cmpl);
+		}
 	}
 
 	rcu_assign_pointer(mpn->stats.base, new);
@@ -1496,7 +1515,9 @@ void mpnic_fill(struct mpnic_net *mpn)
 			state->hdr.idx = UINT_MAX;
 			state->payld.idx = UINT_MAX;
 
+			local_bh_disable();
 			mpnic_fill_qt_bdqs(qt);
+			local_bh_enable();
 		}
 	}
 }
diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
index 764e78918b8f..52492e3f484f 100644
--- a/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
+++ b/drivers/net/ethernet/meta/mpnic/mpnic_txrx.h
@@ -100,8 +100,12 @@ struct mpnic_queue_stats {
 			u64_stats_t packets;
 			u64_stats_t bytes;
 			u64_stats_t dropped;
+			u64_stats_t alloc_failed;
 			u64_stats_t errors;
 		} rcq;
+		struct {
+			u64_stats_t alloc_failed;
+		} bdq;
 	};
 	struct u64_stats_sync syncp;
 };

-- 
2.52.0

