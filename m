Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E943AB29B;
	Sun,  7 Jun 2026 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840258; cv=none; b=Hnzh/gqt3RXRL3JcoazJStIboEM4ogYPhuz/xmgc9LWy9SFhSngMglVeA+X77SgYeXEYW5oYRn0R4sUQ6Kum3MAbyLQwX9GZ3/CZLjoB4Jn6xfhddogh9crKWJxsceeBeI0LkYTsXZbHcoLMZ1qs1VAlHX6tH/x9B8l/j5cxOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840258; c=relaxed/simple;
	bh=X3uWoFTL43TKtRaGf/jtjolAY6UPFdTmz02blP+KP3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwlDAEhdQ7qBmltR57pW/1tqeBDnr8+4ZcyviCsa/bNkjcso8Yy1lqwTx9oVTnfaIdS3eLloVvPcJP9wSrYq4pn96+Lr7B2G+j/uuNy2MZQGd+mOEvOB6Wrlj+zffH79VctqVE/7tLOIbZdRVvocAIYTm0dA3wJFj+R8itD6Kck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=TXaWS21o; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="TXaWS21o"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 53592240A68;
	Sun, 07 Jun 2026 15:50:48 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id AA2B92400A5;
	Sun,  7 Jun 2026 15:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780840246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoTVEgLNauvougTiOOzgJ66IRmD3vjDkLm4JeWlu9kI=;
	b=TXaWS21oCWtVX3l4sBRulW/BY7MGYKzjzG/HOvnKrRSiXTIJr9lVTT8RLb+7lCWRkkBX1j
	7Vr9aSZ8wtA2U8u507HngIXU8l32pGtJY0aGnoQGFz8JSqaYh2npfrOncYko2oG8Caad+H
	utL4xkv8S4dZBa8GjjboJyxOzQKU4wUa4Hw67b0QjIhsqb2C3XM+RuZPOjOm4bq9UR1sI4
	jP/TycnRnbM0fyIm1aHNeIcisWWZKMFX/zXFq9U2IGFpQgy00P2nIeyxgbHKEKe/AWtSL+
	2euE2NIY8Es1e6MtJtx7qMBnmlSmAKM5JuSLlKF7uTHkOX4q94hTGlbJ8JR4ig==
Received: from Til-Notebook.lan (unknown [IPv6:2a00:1f:5743:3300:7fdc:421c:b21a:ba71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 229622402EB;
	Sun,  7 Jun 2026 15:50:42 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	mcroce@redhat.com,
	sven.auhagen@voleatech.de,
	lorenzo@kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v5 1/4] net: mvpp2: sync RX data at the hardware packet offset
Date: Sun,  7 Jun 2026 15:49:40 +0200
Message-ID: <20260607134943.21996-2-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607134943.21996-1-mail@tk154.de>
References: <20260607134943.21996-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 0604b1
X-Rspamd-UID: c8c35f

mvpp2 programs the RX queue packet offset, so hardware writes received
data at dma_addr + MVPP2_SKB_HEADROOM. The current CPU sync starts at
dma_addr and only covers rx_bytes + MVPP2_MH_SIZE bytes, which syncs the
unused headroom and misses the same number of bytes at the packet tail.

On non-coherent DMA systems this can leave the CPU reading stale cache
contents for the end of the received frame.

Use dma_sync_single_range_for_cpu() with MVPP2_SKB_HEADROOM as the range
offset so the sync covers the Marvell header and packet data actually
written by hardware.

Fixes: e1921168bbd4 ("mvpp2: sync only the received frame")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f442b874bb59..92a701f4fe3f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3946,9 +3946,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			dma_dir = DMA_FROM_DEVICE;
 		}
 
-		dma_sync_single_for_cpu(dev->dev.parent, dma_addr,
-					rx_bytes + MVPP2_MH_SIZE,
-					dma_dir);
+		dma_sync_single_range_for_cpu(dev->dev.parent, dma_addr,
+					      MVPP2_SKB_HEADROOM,
+					      rx_bytes + MVPP2_MH_SIZE,
+					      dma_dir);
 
 		/* Buffer header not supported */
 		if (rx_status & MVPP2_RXD_BUF_HDR)
-- 
2.54.0

