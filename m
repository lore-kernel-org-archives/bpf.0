Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792523005;
	b=mnTiYH32Mh7tsIGwPIYJiYqS0H78PYvwCSqePgCfT8C0z2Rp4UQTcPnwkZIekmnSLrxz
	 wjn32v/ZmaorgMKIdVdQ9FTiernK2kwg2yPOuqVlkhNNLjaT5hDU8u707C0Pu4+PgO0p0
	 rM2EBELchQW7IkG8seLiRNwfITx51eioiPQLOtatHIY7F5ylXRdVX+A9fDOoQ1svT8kvo
	 gkKjNkVifLrLYwX+CUvToqqmejRnBsmf0hT9mjhHxyDhTfDur/i4TFC9usjg2XU+5OScl
	 NRNGBhWoVMfZkJyqweotLVv/5hOhe7Qz6GI9T/9gKROMnrIidZsud29MI7h0IHHCTKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523005;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XW2XawDSDFkTSk897IfBcZxxEG8qyMFEO8Acjxpagfo=;
	b=v7PITfHPjBlhyXy5rvIqTOzsxJcHk2kpPhUv1dEQUO9RMiH7MHZhbaesEwVuWUNOh7/I
	 HvbGQhTq0ZEhHNBya4vLUJX79eNHnogdsvqkcRi586C+iz+SPl4lpqmIYh58G+C88lr6/
	 T6DFME34RyKlBZCO+Kgz0Z/AxIdh1xOczzT6+GCNYMF5YkWxCi+kvMtz1NZu6ENtuQqM+
	 QSNrBd0Mg0BQmJMBsJfdUqVQ0GFbxSMdq+2ZT9HTphlVZXok4Gev8s9/AmTWcj+m/xr6Y
	 jbjXS0FD1mSwmBQyufyCLREIHXSNQRl+yoTtpGsVv+cuA7x+N17bMVSCId49AHgzJBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2468606A328
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 19:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2468606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df54150dfso2729278f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 12:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523003; x=1793127803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XW2XawDSDFkTSk897IfBcZxxEG8qyMFEO8Acjxpagfo=;
        b=LoVmw8KwPbZ8XXqeMq37x5x0pf4PGRWE7/gR3D2G9F3eriz2XjLytL6KMI7xJijaA3
         ZZhB2OqgM3zc1WEkA/IJd+SghR2Ad1P2OSpjJH0gtGU2sUNVy2p1FnYrEo/aLxFG5X0g
         8058rNxhdq/pmwpE7165bJ51tc0roywofGhWAKYf7gH/oCZGdcpbvF1f+9m3fvTPDHL5
         cXhwS5UtHhVvOhc38BMl/MWXoarCGrnJbJCQn7un7qhYODct1F4JNX2b6pcbwLWSmmnk
         Wv1fLZ3iBvkxGZfvkU/gUOhcwNVrUEcSPCqjWyNUIHOdrdLzFofYc1E5a0CvEM0WdOT6
         hTfw==
X-Forwarded-Encrypted: i=1; AKwUvBxYAjWStmoBRdt+TZhcFHmr0vrFrCgPfh6713ZTofrMMpTWAKqj+J/6g2hBuJf9eCx0P9Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+dyX/42f5Z4xb/pC++ilAlwGdrFnyc2ZMl5Ab/9bV+VpeVleI
	0Kp8ShNbtw2eU0ExKO40qiTvfl8nt5OW3qXyvNuyduOvU+DgwUrCuUTOFzh4MLQ4sLA=
X-Gm-Gg: AYBFou05gwPErelr/VZVL0xpE+VlLIbaLMYk9Sw9nK2n9ZLFJfbE3V0JWHgwzkMs1Ux
	62ypYSt4j13tkjZ8i7Xz7puGq/5bymRXWupYPBDXzkMOcDQU8tOWA6fPrerDQOxHiCJR5o6FClc
	h3tY7b2I8hGIZSETe1XUOLxq8tQN0iNfLZZb4aAXGbBLvx7c3r9R6Ma4GoqrzNuRDT3hTi1RChZ
	AudK92LwzhQ8U/CTm6ovrCyNcxbMvYxzdtqX6olwgyBcwqheJqNnWoz8PiUmOMq1vUDIfI/EBCK
	BZLvrSEBO2FGdE94y6Qrmq+YPyRSL2fFXKhOxR5FhYDYsEWUHVmqo/jRDTOD37W5U+tgtCV1XFj
	dx+GmppJUNoR+pnwIeYK5ov/RSImjyL5RAoQd8PGv906FcCUSUk7ivFniDLy+2y3Nwt98eUWCFv
	b3ULmmGsYZ6i+pYYgLSijTEqmKE4FZCWxXDQDvKNsh/WaP1xIYJRpItCTv7LfLp2IpMVkc
X-Received: by 2002:a05:6000:1ac9:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e07f99197mr25786391f8f.39.1792523003036;
        Tue, 20 Oct 2026 12:03:23 -0700 (PDT)
Received: from lake ([2a02:810d:d09:1b65:a3ee:29e0:454d:c31e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm279157f8f.23.2026.10.20.12.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:03:22 -0700 (PDT)
From: Grische <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Grische <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 1/3] net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
Date: Tue, 20 Oct 2026 21:03:16 +0200
Message-ID: <20261020190319.884375-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020190319.884375-1-opensource@grische.xyz>
References: <20261020190319.884375-1-opensource@grische.xyz>
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

Commit ee0aace5f844 ("net: stmmac: Correctly handle Rx checksum offload
errors") taught stmmac_rx() to honour the csum_none status, but
stmmac_dispatch_skb_zc() still ignores it and sets CHECKSUM_UNNECESSARY
for every IP frame whenever the checksum offload engine (CoE) is
enabled.

Since commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from
dropping checksum-error packets") dwmac4 delivers such frames instead of
dropping them, so this path receives them.

Mark the skb CHECKSUM_NONE when csum_none is set, as stmmac_rx() does.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Cc: <stable@vger.kernel.org>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Grische <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9741f97fa37a..32810f949245 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5463,7 +5463,7 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 
 static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 				   struct dma_desc *p, struct dma_desc *np,
-				   struct xdp_buff *xdp)
+				   struct xdp_buff *xdp, int status)
 {
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
@@ -5488,7 +5488,8 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 		stmmac_rx_vlan(priv->dev, skb);
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+	    (status & csum_none))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5698,7 +5699,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 		switch (res) {
 		case STMMAC_XDP_PASS:
-			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp);
+			stmmac_dispatch_skb_zc(priv, queue, p, np, buf->xdp,
+					       status);
 			xsk_buff_free(buf->xdp);
 			break;
 		case STMMAC_XDP_CONSUMED:
-- 
2.54.0

