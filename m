Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794838144;
	b=iG1h0+A5M6kS66hekSttzCmMT37MzZ99cfixpItxuqXopOrCSLveSMGHyC7J9PF1omrt
	 3M0HWon2dg78OlcZUUmgHI63kqdNO1FExJYcn44w9pmlVkrqzPImD4LACvdPXYtDUVceR
	 6qjxJJYteQuw3S76CGZHuKf+uplr1bhsT9ZNEBgZf3S5lcXlsNUmiKRrj2SPyif0rVGay
	 nTzgnWvA6GbA/skT/wbLyWsIUJH93sdJqDXZzqmRCxhtTqR9j4HoxB4Gz4FEp7I4iXgOe
	 RPbnRl1sGhkWP8V/6uOdf2RWKCcjROMIiC2gu5ygMYl1omSj90JakmppyuD3iF2a8pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794838144;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U+kI0NsJYRH+LSM4mZJ4JtJDKQmYSW0KTBOTKB6ReYg=;
	b=JHbw46Ai1R9DWk70sorv9bTgV618bGqN5HsivhQFqXl/qko2AitmqQPvGzRV621+aVLY
	 NlUBeW556GKgMfujfDYKQbBpVGDIO2Wbd+Az7guPIr56P8uztcRJBPdlf6GKmL48ZrZtd
	 TIE6kr9E+fUBlPLU2GtE4GmJ1Ige+XCMjW/RYHomxGqT2PGFAQkAWqq+9RImg4geVh1Qu
	 NKx6Ll8F4sEQ2tOdIp7ch5dhPY4Gql5ClRXIQcHFL0vYMxWWA2cUNABNG8ZVrP55xSCYh
	 XuqB9Zs3JO971H2vvjfNbz5LFF6vZ12BBDsQoC1GpW66CoLbNWYyG2btqTW40kuNkLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+2eEMgt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB47606A332;
	Mon, 16 Nov 2026 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+2eEMgt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9743A1F000C4;
	Mon, 16 Nov 2026 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794838144;
	bh=U+kI0NsJYRH+LSM4mZJ4JtJDKQmYSW0KTBOTKB6ReYg=;
	h=From:To:Cc:Subject:Date;
	b=U+2eEMgtWKb54c5VXqgbLIgwKOkPC4jO4S9FUx/Hii8fAg3t47EyGTYYf1W2+a1xg
	 KqtMQ7QSvu8wQIukENGzncqUf/hk0TcTHUgnUxaRz61eT/cAviBkiA1UHM8kUiKadR
	 U9ZaivT9RdlZmPZaepVrebP67w1gQZESwE0Yf/KuTrC9jlzD15hrAd5g6XKQb4QpV6
	 LksuYhAD40xeIK/jN2EzRCb6SjejSh0EOzR5mDVY2xjXMq1Ni89IUcwfGAJIKXJp4O
	 9QvTsVsgHGxIrE1vh2ce++Bypt7Zfg8vixJpOjgDTinpCIsTAvyx+iSuys2ka37D5k
	 lOhrEJvANOcSw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2] net: stmmac: Disable checksum insertion for XDP frame TX
Date: Mon, 16 Nov 2026 21:48:48 +0800
Message-ID: <20261116134848.4793-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmmac enables TX checksum insertion for XDP frames whenever the queue
supports it. XDP frames carry no TX checksum offload request, so this
can overwrite a checksum already present in the packet.

dwmac can only do HW checksum for normal particular packets
layouts, such as TCP, UDP etc. The stmmac_has_ip_ethertype() has
well demostrated this limitation. Different with normal tx where the
common stack supplies the skb->ip_summed metadata, XDP path doesn't
have the necessary metadata. So to make the XDP always work properly
when transmiting arbitrary Eth frames, dwmac HW csum needs to be
disabled by default.

Pass false to stmmac_prepare_tx_desc() when transmitting an XDP frame
so that the packet is sent with its checksum fields unchanged.

Fixes: be8b38a722e6 ("net: stmmac: Add support for XDP_TX action")
Fixes: 8b278a5b69a2 ("net: stmmac: Add support for XDP_REDIRECT action")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---

since v1:
 - rebase against latest rcN
 - update the commit msg

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3014f9c7c3e6..0545f086212e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5284,7 +5284,6 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_frame(xdpf);
 	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
-	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;
 	unsigned int txq_thr = STMMAC_TX_THRESH(priv);
 	unsigned int first_entry = tx_q->cur_tx;
 	unsigned int entry = tx_q->cur_tx;
@@ -5306,14 +5305,6 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		return STMMAC_XDP_CONSUMED;
 	}
 
-	/* Disable TX checksum offload for jumbo frames on cores where
-	 * checksum insertion is broken for oversized frames, matching the
-	 * stmmac_fix_features() workaround used by the skb path.
-	 */
-	if (priv->plat->bugged_jumbo &&
-	    xdp_get_frame_len(xdpf) > ETH_FRAME_LEN)
-		csum = false;
-
 	while (true) {
 		skb_frag_t *frag = i ? &sinfo->frags[i - 1] : NULL;
 		int len = frag ? skb_frag_size(frag) : xdpf->len;
@@ -5353,7 +5344,7 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
 		stmmac_set_tx_dma_entry(tx_q, entry, buf_type, dma_addr, len,
 					dma_map && frag);
 		stmmac_set_desc_addr(priv, desc, dma_addr);
-		stmmac_prepare_tx_desc(priv, desc, !i, len, csum,
+		stmmac_prepare_tx_desc(priv, desc, !i, len, false,
 				       priv->descriptor_mode, !!i, last_frame,
 				       xdp_get_frame_len(xdpf));
 		tx_q->xdpf[entry] = last_frame ? xdpf : NULL;
-- 
2.55.0

