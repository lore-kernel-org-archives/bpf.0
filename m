Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44105271A9A;
	Fri,  5 Jun 2026 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674323; cv=none; b=saGgkB5cUyHWP2qnsf6InCyQZXu9lQvar1UqruCH4fxNsmopugBtg6tV/1enLVyvAjak+L9pDtIrFFwk8sJoGqZP4bityKsObSueZmIlkE00YNNyRfXD7Y6Z+C8NC1SWF2ckRPYDbo9r67KdanI0yQT1wTb+/z+owdGX4oaYjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674323; c=relaxed/simple;
	bh=X3uWoFTL43TKtRaGf/jtjolAY6UPFdTmz02blP+KP3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GojeYA/r/2+EyeEdPaVfUhE0IGcLmPeXqB2E4t8lBlMp4R7w02AyWLMt5sKsoyLU4vziNH294IM2DWT5xYveiy5owfXucxoobdJrvwRiY4dpDh7dvHsfgJwG2U6zalY7AqPLEGUdIXzACTLivKGXeLC1N/03jiJWahrSyh0yAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=D60BYEjk; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="D60BYEjk"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id B8D6524028A;
	Fri, 05 Jun 2026 17:45:19 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 207F424016A;
	Fri,  5 Jun 2026 17:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780674318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZoTVEgLNauvougTiOOzgJ66IRmD3vjDkLm4JeWlu9kI=;
	b=D60BYEjk3nlxKyYQznfyNV18znoglvdY4E4vOnDfGSjiRiY1rnymQyP8RoHR6NHMNnjdgr
	4rziNYiLctFGUb/h6QdUtHbwTuMDRBF7jYFLnn3mWvdsN9Ok4GT8trdluOBZqSrVVHBE8m
	+tAIVswRIiTChWPLhc87MTqPAAa0ZV4ol/PDw/9cGbq4wOgDTofpoLQx8aT6Vn2FlAD6+G
	eE767qG70nsEyVe3Vy5jfLSqqXshuz9vZavcZYnDDWsVj9rk3MxK8Vz4eVFg7FVqYBaziY
	2YQOTp/ejfPV5TQZ8VPGWs1eAJuGSCPhITyWGdUGFJLqD7K9DHdz9jM2x/3a8Q==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 600232400A5;
	Fri,  5 Jun 2026 17:45:15 +0200 (CEST)
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
Subject: [PATCH net v4 1/4] net: mvpp2: sync RX data at the hardware packet offset
Date: Fri,  5 Jun 2026 17:44:54 +0200
Message-ID: <20260605154457.163304-2-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605154457.163304-1-mail@tk154.de>
References: <20260605154457.163304-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 83efb2
X-Rspamd-UID: ebefe1

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

