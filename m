Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F421402442
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572704; cv=none; b=MTBsFGMzrLU4gB7hZQowoVs4ZRgJND1QCCgkI1QEnmNdoqc9Rf/v6d9vxbEtEEi/Kzcud8c1qUhpJ6UdluifEm0cfTkuBdmfeSca87wP+zNlupq7qrOW/dUdKUkLI9f/UafKoVitvVOvKo1hW+P9CN7JizkIWYNw5I8LQcNkddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572704; c=relaxed/simple;
	bh=LyyIlg3QPX1rQJHGpgzEqbAUkTXPZTiK+PQ73NyhaYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJobvaBZ2GulXm1uDLP6Yo1zt+8YaD9lUInfyRQ+lXSRfstBVL6u/6piHKMn/OGeZmst8KHg715edOzpc7CihkdMdosKdE1yyHfv1kqYLvpjqahfgzR8OezBXroommEVw505sXuJvBvdTGgdOtjESInyViRYQtH6mC2887ZKiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSR8395E; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSR8395E"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c85a2c012e5so232840a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780572702; x=1781177502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWJU4AISHJoKW2jVY+HLmgCpe1wG/GRzkKLWOkBA9NQ=;
        b=pSR8395EYeg876uScrRj3WexBnuPB3+AmQJttzO2xqjXClIJWFxNcK5EDBg1mmy5K7
         HxcqDZGkfbgPECLth7Y0RmlQhvoJM3LRJkS6piZOUU99xRikWKe/xfw/l4LmaKixw73R
         9unVJ/uRhnbI5kLnaVwe2PNIvhHQKWvb+De+++RwLXAlxdllDbCYN4nMGcErDp+DcSEH
         MNzyYS0YYRdA2NPPHmRxGNbuXTTqNtwg8X9KvIGQHWgCcEPIa7H9mLEZUCveiQZ24apR
         QV69GuwFDgEkuwFCKZIEy5RzeHfZWw9oz+8xSnuX0Q+vq1P/SwteIrHXQDRY92pvPNRL
         MA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572702; x=1781177502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWJU4AISHJoKW2jVY+HLmgCpe1wG/GRzkKLWOkBA9NQ=;
        b=Iit8/G26Z9yf9opnQcqSaBsVWXQ5hINn721WlMtYIvqMj1mTv3kVo06GeWJk/E9OKn
         SACF00hEb4g2HffGp3i0jJP3Rs87cQbSxZHaDyCebHw6vpnopvHLutt5S9s9q2jlTSm5
         0bUUKoLfD593wLCBQxw8/GDRy/DxbSiroy1tRmXwxhaAPazI7hjN9zGLDCn7Bofm9bjp
         SoepzyWruKYlSkhLBIjbKaOpz8bwMw3t/eLVlnRSQe/+heN8lbrnyw7ODYqiITZvF/97
         mQ2ANpfwzBA7/P+oPe9Q+HUmG6gAsBG6RQoHOqOVekyHIAq7n6NABJMabAqgRdrYY2Lc
         kKjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kkF3xh6ceCvO2Eq2S1sp7iZ9D+1RUsCyKXo9icoWAXVzVzRtmcEHijFa6tLMQeUl9XVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyqKE5N07a0xyxl3gYT7Yxu3mInT03HCWO/9vG9gk6J5L/U0j7
	QrJVlwb8yoVyEiPcYS1zQEBhIG1z2lc56elJYZPJBJG5UVEGElrOg4Um
X-Gm-Gg: Acq92OHI91+ue0xkfxueDgmi0jUyOGTTyfOOhDYodi13lj6Ymk0oxPwMPvJTdLbEhS+
	kMaRIobPeAL/rmmOyZlMFd6yN/nevQskKfz6NUJ5/CCpKKjw/Sx2k0YpZ1UeQ+6F2hjZ18+QGwg
	PFRtvto5kzA3BViLLBlxDVg/76IdDA9bkfkgVi1fKFtnngSze63GCE5JsfxDrpDWDCQDZxsAR5y
	5i0QoswyhLZqDNKOKKAKR2kY05SsER5oPvzE3OfZbZyg+6Vz8XkIz1IHlQyPoeI6LSelaXcvFWM
	2ncJyOHoEqSPLgWQ9BD9OYHmtyXV9s2L5Lv078v+K+yJWbBpuGBhDCsQL+J3ztQ50QS/B7VRhZg
	lEOFEaKGDJtY5IFMKcb2tyIUnTuysx7CdtBHcox+XU/Kw+Z5mYrUDHsiQDZ2xpgUZF3jAJhaYVh
	8CVVzcDrt7/fpsnOOkN7OJ0gMtoAg=
X-Received: by 2002:a05:6a21:2212:b0:3a2:f7bd:a9a5 with SMTP id adf61e73a8af0-3b4979e946fmr8507751637.38.1780572702468;
        Thu, 04 Jun 2026 04:31:42 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221c3e4sm6124968b3a.5.2026.06.04.04.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 04:31:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] net: lan966x: restore XDP RXQ page pool on reload failure
Date: Thu,  4 Jun 2026 19:28:46 +0800
Message-ID: <20260604112846.1420908-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lan966x_fdma_rx_alloc_page_pool() registers the newly allocated page pool
with each port's XDP RXQ. During an FDMA reload, this registration is
performed before fdma_alloc_coherent() is called.

If fdma_alloc_coherent() fails, lan966x_fdma_rx_alloc() destroys the new
page pool and returns an error. The reload rollback path restores
rx->page_pool and rx->fdma to their old values, but it does not restore
the per-port XDP RXQ mem model registration. As a result, the XDP RXQ
state can remain associated with the page pool from the failed allocation
attempt while the RX state has been rolled back to the old page pool.

Restore the old page pool registration for each port's XDP RXQ in the
reload rollback path before RX is started again, so the XDP RXQ state
matches the restored RX state.

Fixes: 59c3d55a946c ("net: lan966x: fix use-after-free and leak in lan966x_fdma_reload()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 .../net/ethernet/microchip/lan966x/lan966x_fdma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index f8ce735a7fc0..76654b44baf2 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -855,6 +855,21 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
 restore:
 	lan966x->rx.page_pool = page_pool;
 	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
+	/*
+	 * lan966x_fdma_rx_alloc_page_pool() registered the new pool with
+	 * each port's XDP RXQ before the allocation failed. The new pool is
+	 * destroyed by lan966x_fdma_rx_alloc(), so restore the old pool's
+	 * registration before restarting RX.
+	 */
+	for (int i = 0; i < lan966x->num_phys_ports; i++) {
+		if (!lan966x->ports[i])
+			continue;
+
+		xdp_rxq_info_unreg_mem_model(&lan966x->ports[i]->xdp_rxq);
+		xdp_rxq_info_reg_mem_model(&lan966x->ports[i]->xdp_rxq,
+					   MEM_TYPE_PAGE_POOL, page_pool);
+	}
+
 	lan966x_fdma_rx_start(&lan966x->rx);
 
 	lan966x_fdma_wakeup_netdev(lan966x);
-- 
2.43.0

