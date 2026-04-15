Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE943CE4A0
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241669; cv=none; b=THh2YTa8ugIUPf0qOW7ZWv3P50VFRdTzHkunDX2D7jFG6TyQkNemgAFDLILJmG5TgDwhR5UQMmmgz1kYihyDP+1Kvle/vzP0gZfMM2zvFsaA5bhr0fRDbv+28LjdCkG/OzjOj3XhvLGv2GIB3+4sQ38K7tW6KhAwHmum8xtENNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241669; c=relaxed/simple;
	bh=GU1eAqavAuB3nXSt8AIaen1ww/JyQ0mvjIhZ+nlyXwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGASCUwmVnsvKNR3t8jnK0OHrj80rDmf0i+iNtkJ0A7Yr2WPH896bwiMVdmMj6zbpQi9DlbDos+uFxR4AKeay3iRmLV4RWzwnj38+1A4p61U272i4EsOZNsNMHAglTekImf3MLTtYQcRUm6abR297DdVWKhUWlKkewqv4yKGdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoWSBZlV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoWSBZlV"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so2547702a12.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241666; x=1776846466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ccbok634eicd39AbWwkSVkudGCXxX/XXj+0cLS09lj8=;
        b=RoWSBZlV4jnYQrKnn5K0qzJrjoEHuo0LLhtLL/zQhH3LK7fnaEcHT1u48Yg61kOZ6a
         0N70EVp5Q+nRyBo8v/h4O6+JgOkmsii87QeiCrHHOdEaOzlbAFWdUYpLgC29iJt+EnId
         A+4C6plNO2MwSPgmbFjb6tF31UjOuTEAwvXmZiYW4XjDxPbzsQ8+D0pOSCax7b9sULZP
         +4zs+HeoCysp0IZc+IhRvB7dtkhixF63ZinfkuQ3CebHq7gQUxP8svT63WoBG1d6rPu/
         4dQ/sLIfTAbJ7PaleBYU/3CRxCdZ9zpll4hAwDJNkB82Y0BOTQvDuhJPPaDPCdIrVn6X
         OqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241666; x=1776846466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ccbok634eicd39AbWwkSVkudGCXxX/XXj+0cLS09lj8=;
        b=TiRirupwA6IsH4+yxSjk8tvfH0h70orttChascpNX1xE9NHi7Dq7c/WW3XzeCdpdKy
         yaGNhK12OfpfKnLWfVZlbre1TXx10q+pgsMo8E8mCKIC9y/SwllQJhACJIdHVst4TtkA
         /pVnLc8vS2iiiVq1SOn7fglWUdkFZfsaGeQODYAkQnQui9nRErhkrwgT4aQS8r5heIby
         k+Vg5VSKXeqwLVhZ4RHjDJS8n4c9UU8QdMeO/0hg+ZiJwgplBhq7DKUx2212T7w7GdL7
         VJ/FgdEtonmFLPKzKCwHUxvwxt89uf/y9/qfdtpXEIclM5lLFJD97Enfogm3rQcoelXH
         dObg==
X-Gm-Message-State: AOJu0YzCPDOylPldtZDFNAPtl+kE0TRHaCxIEUa0wNfqxtHji6/yhfZH
	W4+VoH/i0C7gF2EDGcp6mktOdMy6/B4Hp+8KLZJAI7IDhngq4Gl5I4Bq
X-Gm-Gg: AeBDievcUBhRTZ5z8jhIe/czVY4l7LphYZ+oiTAmYq4RSiJCoRXeNZXqMHiPshT7HMu
	SULfNxE2DAad2RhC0lw+tZxro7h04BsXnMc6wMD3H3iaI7AK0UQqFukJL9WTq9KdLwgyJmHjwgT
	NhhtgK/MSs3IH8OQZjcxV9ZSx1xXiOCq5l2berLMPrplrgMq4qtpmeapilngj7nYvYkU61ZIeRm
	JPG06lrNedVTpUNjbuMY11dnMpzIKUStVEQRSZwRzjLkVfngz+XYP9fUuEWDRDklAX+rpyrczUD
	V/pU8137cxv/nLvCuNokUGaCPsi1SfqgWQ9XUDefGRPo2nvCLqSqgiy8sW0JxVuK0b1aWClVV2q
	NDDEUtkcPp7Kte6/chsO6bMu8yszKhTlk31cVjR/OlR5ONj7MjuPqOIDaMNPkDjwQWvasXSWdas
	0+xnBtcTZJaMEcgW0SXbvMG/MMG9BVS4MxOhtMhtzMSN2E7Ig9WkiOcOl2cp4J9DMjh8Xxxj/Fj
	SJYnNzc
X-Received: by 2002:a17:902:db03:b0:2b0:b41e:c5c3 with SMTP id d9443c01a7336-2b2d5a49e22mr228059505ad.29.1776241665993;
        Wed, 15 Apr 2026 01:27:45 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:45 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 07/14] xsk: try to skip validating skb list in xmit path
Date: Wed, 15 Apr 2026 16:26:47 +0800
Message-Id: <20260415082654.21026-8-kerneljasonxing@gmail.com>
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

This patch moves the SG check ahead, which is the only place we need to
handle very carefully because either in xsk_build_skb_zerocopy() or in
multi-buffer mode nr_frags (in skb_needs_linearize()) is used[1].

In most cases, for xsk, it's totally not needed to validate and check
the skb in validate_xmit_skb_list() that adds numerous checks in the
extremely hot path. In this kind of workload, even the overhead of
mathematical operations is not trivial.

Performance-wise, I run './xdpsock -i enp2s0f0np0 -t  -S -s 64' on 1Gb/sec
ixgbe driver to verify. It stably goes up by 5.48%

[1]: https://lore.kernel.org/all/20251125115754.46793-1-kerneljasonxing@gmail.com/

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a6abd621a7f3..aa38993b9dd4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4899,6 +4899,7 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 	u16 queue_id = xs->queue_id;
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, queue_id);
 	struct sk_buff_head *send_queue = &xs->batch.send_queue;
+	bool need_validate = !(dev->features & NETIF_F_SG);
 	int ret = NETDEV_TX_BUSY;
 	struct sk_buff *skb;
 	bool more = true;
@@ -4906,15 +4907,17 @@ int xsk_direct_xmit_batch(struct xdp_sock *xs, struct net_device *dev)
 	local_bh_disable();
 	HARD_TX_LOCK(dev, txq, smp_processor_id());
 	while ((skb = __skb_dequeue(send_queue)) != NULL) {
-		struct sk_buff *orig_skb = skb;
-		bool again = false;
-
-		skb = validate_xmit_skb_list(skb, dev, &again);
-		if (skb != orig_skb) {
-			dev_core_stats_tx_dropped_inc(dev);
-			kfree_skb_list(skb);
-			ret = NET_XMIT_DROP;
-			break;
+		if (unlikely(need_validate)) {
+			struct sk_buff *orig_skb = skb;
+			bool again = false;
+
+			skb = validate_xmit_skb_list(skb, dev, &again);
+			if (skb != orig_skb) {
+				dev_core_stats_tx_dropped_inc(dev);
+				kfree_skb_list(skb);
+				ret = NET_XMIT_DROP;
+				break;
+			}
 		}
 
 		if (netif_xmit_frozen_or_drv_stopped(txq)) {
-- 
2.41.3

