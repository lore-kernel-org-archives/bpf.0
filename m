Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F31305688;
	Fri,  5 Jun 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674325; cv=none; b=Xcz/HMfsl0JbuxRumQ1PVdIMn1DRcphdNQhTcvtOYQoLOigmyw66wfU50uP6+r4BKdT4DjvdZGPYWnp5L0H5z7TOJ4WqrRGdlbtESRX74bWZ/Brtsdv1vCDoSphFJbSYOivcOSCIuF3uMkqm7xnEectXBcf1ZYs0AHZQ8wEojFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674325; c=relaxed/simple;
	bh=2no5ts4uR+BRFpbAeaMDuXoBtDm87qzy992Y6dadpc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPXlm+Txab86HTS4gfdeA4ef684BCEzfSGnGarXiiIVHZAwiw35NK+PtVIZjE38vOCHLehMSPGzKcbYN7rCGPdSJeLngMzmET4Kj1VY/nwSJgt53mTSbWmxORKX0+fIBv1uZTHDkIC4/vkRWZwhe1WcqY9SPieyThbBO9/P+0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=hxFnlaRt; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="hxFnlaRt"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 65CD8240066;
	Fri, 05 Jun 2026 17:45:21 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id C1D712400A5;
	Fri,  5 Jun 2026 17:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780674319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1Ioe8uKiJIxbIqpXcCQ8i5GRjn3ORGyOB/YwWZ/fog=;
	b=hxFnlaRtSecyRKobeTkEFLMloV1wrTtkMFdXkKVRocTI5P1J5bz2XRfTtPgeMtl+znS2fg
	NRw272UVfOsdBGONnLK/0CZF78lK7PtFM9z2KrXxFXPN4LDX8S+QDiY5Qe/0HipLgop15c
	Y0dzYdw11BiBu15RtK2Ys3gS4S1aLgqhSVwT9WJ8pOxEkHOHW8n3TOmRUUpk+WAkWwk3CM
	hC6ZPrfIKOpmaIa1tEJvF/wOAH2XugLHE0SVU/W5JiOAL8lKGoHXd9AWvZgvFkdg/ZPhn9
	BeDVhlkkjEKP3662bNsMH89hRk5g9qg9sDdehUUD5y6WmJ6zfgtmkxHWDBOgbA==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 39044240282;
	Fri,  5 Jun 2026 17:45:18 +0200 (CEST)
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
Subject: [PATCH net v4 2/4] net: mvpp2: limit XDP frame size to the RX buffer
Date: Fri,  5 Jun 2026 17:44:55 +0200
Message-ID: <20260605154457.163304-3-mail@tk154.de>
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
X-Rspamd-UID: b70272
X-Rspamd-UID: 7c431c

mvpp2 has short and long BM pools, and short pool buffers can be smaller
than PAGE_SIZE. The XDP path nevertheless initializes every xdp_buff with
PAGE_SIZE as frame size.

XDP helpers use frame_sz to validate tail growth and to derive the hard
end of the data area. Advertising PAGE_SIZE for short buffers can let
bpf_xdp_adjust_tail() grow a packet past the real allocation, corrupting
memory or later tripping skb tailroom checks.

Initialize the XDP buffer with bm_pool->frag_size so XDP tailroom matches
the actual buffer backing the packet.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 92a701f4fe3f..3372ed27cc8d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3979,7 +3979,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			else
 				xdp_rxq = &rxq->xdp_rxq_long;
 
-			xdp_init_buff(&xdp, PAGE_SIZE, xdp_rxq);
+			xdp_init_buff(&xdp, bm_pool->frag_size, xdp_rxq);
 			xdp_prepare_buff(&xdp, data,
 					 MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM,
 					 rx_bytes, true);
-- 
2.54.0

