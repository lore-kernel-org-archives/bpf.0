Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022370;
	b=NvHw3JVBgttlXQkCpCEAWQdhSd+JDNjBwR1f8mZTKMQAPK5HcVYvcoNvrIVH0U0glP1R
	 DzB7BZwGraIGoqTPpb9uIJ2cXqb+vscglB3hffspvcXSwHr9/SDGpPfHizY5HS1UNHpm3
	 HWYKR+uP4LP0QI6aS0sCGcTNY1vh+jl7uo63met+jXsYX4eSA5pKw4S/am4j+QUMh3NRD
	 b/dGBkZogtcXqwXItw3CEW7kiUDAkzWdqlF+jq54C65pQ+7HipSY0HGtbX5DeK3QIl6ft
	 RCkofFWTICvnoYlYJMjSGJsV21qCFpe+Ulypa7UAtRHg3osuHfASDNVFFp+HJQHRSDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022370;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer;
	bh=GhY/28Yn/ud2ccGboL9xC2pKRNqAHewytUqjxU4O5WU=;
	b=5YlBhAGiRj3lZAEv3c0trSE7nshQ0OKlJMAWzPff6vBogStto7YY3TANXK3nHcWmopt6
	 TP7eh9qfi7TJx/WXKXwS+oeknwJSo3g4bqERiV13SVO8Xmr4Wb/dm9HyjMXr8xXgpGfsj
	 DR2UTyBVim9aHZ0CiwxICT+cvhb+L+Q7bl3xEsflj6E5xDeXzkTE3m0cGk+QtxRUpQrAB
	 FKTXNP0XVOy+Q6CQd0G/an/ge4KBoeo8pJCgyilHXT3m82xIC2yehnjxECV5XSqQZNmx+
	 0+uj7zEhrcnzYPjQjmSdYmya8BkJzrco34Tnq2Dj9t1BI31Jxt/dWE7hehkRPOLVu4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b="hwXrQz5/";
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43736606A31A;
	Mon, 26 Oct 2026 13:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43736606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=hwXrQz5/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793022369; x=1824558369;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=mpVulLhW/J1wiSpnQFCPLG/nKiZWuBvxpRr1vibRC5Y=;
  b=hwXrQz5/dN8XzEGG5L1KYZwHjZFiMJ1ZLoRFUgq2VshzxKK6peb5ZY9G
   5VsgsAoVZEnImu7tw0X7ZhDAhotBYVDjkio1XTa5z/Js+4TPNlgiAF9IA
   6rgLpdBIfiuoR7UhsePypnN3DXjgbbjDwnYnI2qfJX+opmYi1zYL2nidk
   uJKblVrwaLfaADqZDxmcvVjtQOogxO36+9+Ga+Fmla3xniucW5NfUF2Fm
   wVgji5pMP6QP72wLKZyIhppz0LA9lUxoc5BVGisdVR6iRv7tlRuVnDdEH
   v5r4VhJW9Sqda4hs9GC0vJLCEZurRD91cxAdGWzU2bsBrGkqXGtG23B7d
   w==;
X-CSE-ConnectionGUID: 8tcnwDJMTE2FbPxMW/ycJw==
X-CSE-MsgGUID: +ByVT+VkRL2KXIVln1+Zdg==
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="296988065"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2026 06:46:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 26 Oct 2026 06:46:07 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 26 Oct 2026 06:46:04 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 26 Oct 2026 14:45:58 +0100
Subject: [PATCH net] net: lan966x: don't disable hardirqs in fdma tx clear
 path
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261026-lan966x-fdma-tx-clear-hardirq-v1-1-5f70f026a2e4@microchip.com>
X-B4-Tracking: v=1; b=H4sIAJVZ32oC/x3MwQqDMAwA0F+RnBeoVarbrwwPwUQNuG5LRQriv
 1s8vss7IImpJHhVB5jsmvQbC+pHBeNCcRZULgbvfKidb3Cl+Awh48Qfwi3juAoZLmSs9se26Xx
 Lrg/sGMrxM5k03/8bomwwnOcFqKxNtnQAAAA=
X-Change-ID: 20261023-lan966x-fdma-tx-clear-hardirq-43724a086d0d
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
X-Mailer: b4 0.14.3

lan966x_fdma_tx_clear_buf() runs from the NAPI poll and frees the
buffers of completed tx DCBs with napi_consume_skb(),
page_pool_recycle_direct() and xdp_return_frame_bulk(), under
lan966x->tx_lock.

Before this patch, the lock is taken with spin_lock_irqsave(), so the
buffers are freed with hardirqs disabled. RX skbs are marked for
page_pool recycling, so when such an skb is forwarded back out and its
tx completion frees it here, the free path reaches __page_pool_put_page(),
which warns via lockdep_assert_no_hardirq().

Take tx_lock with a plain spin_lock(), as the other tx_lock users,
lan966x_port_xmit() and lan966x_fdma_xmit_xdpf(), already do.
tx_clear_buf() runs from the NAPI poll, so disabling hardirqs there is
not needed.

Found with lockdep enabled (CONFIG_PROVE_LOCKING), which the assert
depends on. Reproduced on a lan9668 board by redirecting received frames
out of another port with tc mirred.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index a7940eca5df31..a92bd0590b460 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -336,14 +336,13 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 	struct lan966x_tx_dcb_buf *dcb_buf;
 	struct fdma *fdma = &tx->fdma;
 	struct xdp_frame_bulk bq;
-	unsigned long flags;
 	bool clear = false;
 	struct fdma_db *db;
 	int i;
 
 	xdp_frame_bulk_init(&bq);
 
-	spin_lock_irqsave(&lan966x->tx_lock, flags);
+	spin_lock(&lan966x->tx_lock);
 	for (i = 0; i < fdma->n_dcbs; ++i) {
 		dcb_buf = &tx->dcbs_buf[i];
 
@@ -388,7 +387,7 @@ static void lan966x_fdma_tx_clear_buf(struct lan966x *lan966x, int weight)
 	if (clear)
 		lan966x_fdma_wakeup_netdev(lan966x);
 
-	spin_unlock_irqrestore(&lan966x->tx_lock, flags);
+	spin_unlock(&lan966x->tx_lock);
 }
 
 static int lan966x_fdma_rx_check_frame(struct lan966x_rx *rx, u64 *src_port)

---
base-commit: 6430fb7f1cc4e329e386521b7b208df443de92f2
change-id: 20261023-lan966x-fdma-tx-clear-hardirq-43724a086d0d

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>

