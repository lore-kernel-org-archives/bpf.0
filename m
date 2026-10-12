Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC354854FB
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806702; cv=none; b=apNejKEv6DcBNQe9zroi00dM2APNdOyYXeGlSXp+xzM3NHV9a369ORNyg3VfVRu61ed8E2aKKX6dFW8hpL6lYZHXD9wHFMHBmhzH1CY3G9A5xajJdDJ+BCXQfedSXrgboKFw/qjRkqsszBv+Bbm/HHhv5uiP7Qb3CW2o2RMDszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806702; c=relaxed/simple;
	bh=QSL5j8mwHkOb/fsPq/nsPWAIlZUAQnKGZepjVSSkOvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayScjcjLcuaK+zlxxBV7q/AqzxlWa/2NtN2ph5JwQvfdeuvqDceFTk8HYTAjzVhvdTd+nwnkJi1/ztZ/DLUsy/YuRALB9Hm6avSO0Xci5Lw8zoHGjegcnFHrYraAdKRRRf8kLyq2fB7+Toe2bfXH3UHHoOdJExUNJhJD9cdZVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIcciU/L; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIcciU/L"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6f74f6b46abso265729eaf.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806700; x=1792411500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOCVm+71XoqyxTpz9zzVrcgymq0GHJGa2kvf/gkuOvs=;
        b=mIcciU/LyWsKZFbc1xigqD60bO04kJIqsZ9HijSjbT8UyLglNa6FZ09WPR5EuE3Nw5
         J/MVzxmXQg/VwjXQSUimlOi2OjNWS6ER24p/RFw3QLDedmWv/Rv0jQy133YehffmlWJx
         ekP8HH7zaaieWxjb0yFmVwlQn6c9lGE3qK7N8g5fZ8KHU8zo2Yjz5dOj4ww8VKoatLt+
         +NN+FjharBAjO1I61h3g6PROws5OAsWg3vo/CLbBaANUtIyypqik5aLEEQkxrfkq3YBm
         8NFQkr6ggM+w/rXIsw9YmmlXZsJbwm+YHGVnhh2CGzptTIxJ/zIgcPDzCqQagv/3XSHA
         fP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806700; x=1792411500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qOCVm+71XoqyxTpz9zzVrcgymq0GHJGa2kvf/gkuOvs=;
        b=PICFCJxaYlVM2etf+sYs/ru3gI4klvi9AkUI117xYe18fM9nEnu8gDYjOqaeZ2/n18
         v/DBdf/vDyuc6SH0SotRW1AEDJYpIQnnghCAtoWt47emPdEYdD7kbueYdXV+ldb8TuFK
         PN7HXMD9elUWodFWAQnxenvnO3Z08yFT9ZO4d9bjm65lnl2D10S93ghvc4pPXeYugk79
         3s9OKgN0sydMCorEfzkPwEl7cQwk1FuVFR0U50Nyklmcjq03IC1ca9a8jn0B9VwybRRN
         jdOVyfA6WzD9wAgPJreHmOs7uOqs8f9kuiTms+qC63h5zGUAAEFuBEkqaED64FCnpYWp
         eJ8w==
X-Forwarded-Encrypted: i=1; AKwUvBxTJcm3+OO+T0PwhPYf/+IVESTxb6hKwrfAIgyVTL4KN4f/zU6KFXQOqNQKar0PIl0utdc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI2cDiN/OZfkqQJ1pMGwbj1H4ZWJ7v71M08YoRbOStESdRiS/m9
	a1uv0J1qrjUZ9Ydl7C9+yteKuZ6CAQ9Rs6m9SPyb1Ume4pAm2yzDkmdj
X-Gm-Gg: AYBFou1FBOSdUfn5EIDCqX1om0/FyOV2cYTPV5ZSKYmttqZS+8Ta/V+dhMiT+O34pDJ
	zVdr3l5lgLNcRI2omaSxf550938fAy4CvaeDJH70gVRrzH7gulzW5LMVsTWCD+ROqzo0HiH38bw
	gMKUQVVczBuMUR0wM2bvK3tDJfgkKH/hM6jxvcaHXJfTlfW21VoT+K3aufCReVZW9LB/P5VljcX
	vXEa6CLrWIHPwjPLBXwr+D7OYpAk8wHSNhK8gG3e9d+ClvlJwcUOcji6D0c5hTRLfu5bhoZcPKt
	aC3kLVjn9kJs4ohitF12nyT3MZROGAqn1JDZ/nmo/TNvrRzPEx9uUVZ7xB3unKAoCwxjqro4AlX
	OIdjioLnczTeIgbXIQAk4Z4G1Ts8GN0+fl+MecZvfJr33ec76eVTEh1ZgdtuYpHBAGKuafg5yTZ
	fcWwsDVvJwcf7X+146NIHjK11OOrvCSxth3lIW8I0LV0Y+AbbvcWHQsC6dzeaI850vzsUdXA==
X-Received: by 2002:a05:6820:c0cb:20b0:6f8:728d:cc2 with SMTP id 006d021491bc7-6f8728d1172mr185384eaf.27.1791806699864;
        Mon, 12 Oct 2026 05:04:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6f8a470726asm200442eaf.3.2026.10.12.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:04:59 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Mon, 12 Oct 2026 05:04:37 -0700
Subject: [PATCH net-next v2 4/4] eth: mpnic: count Rx allocation failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-mpnic-counters3-v2-4-8afba81c2d5a@gmail.com>
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
index 931e1031a180..93abdec44642 100644
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
 
@@ -632,6 +637,7 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 				   !state->pkt.add_frag_failed)) {
 				bytes += xdp_get_buff_len(&state->pkt.buff);
 				skb = xdp_build_skb_from_buff(&state->pkt.buff);
+				alloc_failed += !skb;
 			}
 
 			if (likely(skb)) {
@@ -665,6 +671,7 @@ static int mpnic_clean_rcq(struct mpnic_napi_vector *nv,
 	u64_stats_add(&rcq->stats.rcq.packets, packets - errors);
 	u64_stats_add(&rcq->stats.rcq.bytes, bytes);
 	u64_stats_add(&rcq->stats.rcq.dropped, dropped);
+	u64_stats_add(&rcq->stats.rcq.alloc_failed, alloc_failed);
 	u64_stats_add(&rcq->stats.rcq.errors, errors);
 	u64_stats_update_end(&rcq->stats.syncp);
 
@@ -725,12 +732,19 @@ static void mpnic_aggregate_ring_tcq_counters(struct mpnic_base_stats *base,
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
 
@@ -767,8 +781,13 @@ void mpnic_stats_fold_rings(struct mpnic_net *mpn)
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
@@ -1494,7 +1513,9 @@ void mpnic_fill(struct mpnic_net *mpn)
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

