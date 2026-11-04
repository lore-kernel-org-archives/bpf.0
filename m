Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805569;
	b=M1t8yLC9XCtwJ0QkXfUEqnI6LrtJq39Kk31dHMGxMTN6dCm0Mca7IVTw2XlawqO2+jTs
	 uDrd5X4OahvW0cn20ab8j3MDQI/0GG3GBAPlrFaTicCY3GcgtupI2uI4VEgRwcYHp2Qg0
	 +qnYJaJi3ie/swopRjI6E04Ros1s2uHE7aqUy9AsYBJmH0aoDA47EK4ySNDmW9V4cXQd1
	 9vvKLwgVTYWsf4Q1WalP/XYzekvA9QWN/vD+LwgBhoc7xw5LKpH34uZo/NINC5re9jkON
	 dcKssTxcJTR7nYfQSR7FI8oCSqziD6yu03LCHg2EasGORTBLrgaCiKXZNwjl538fRQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805569;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
	b=33rIHFdbng1WBu1vW8AYF8MkEUe4UsvvZ7DE9q3jLVuEEbisNcapYsT3mrIIDnEZ8ILv
	 IXqJeXM58E9sUJCz32MBp3unAaZRzG8IqC/q9kKHvJCIlaAW54kgzwzyORM4qlZ1sZNn7
	 EaNyR0GAwSuCHh74WuufxmlSW2GKv40hn2SLg0Ljj9rY1hqImbHJEf0ZzvOTAHHWBaL5T
	 lCme/4HgkafDkp+JN686XOvZ5Q0x7lrVGqIGF7UznOMdY5k0JMHllXaLWzqjuHjgkj1CG
	 eeHb59JuCEdHinstcdLadICimnSzdWqpJFsspy7O1pN5yiLo4O0PAHbNvEAVuONpW0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA7606EE98
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 15:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94DA7606EE98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-490d59c3edaso163397f8f.1
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 07:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805568; x=1794410368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
        b=i7Q78ZprDnPswg8RYB3NIZZfjbbLqIw3jPZd+K1WLD8cKePzmT084VcxOx8BkvEmrF
         vtoqsTCMvyGWEjczMCCLJFwHgoT1IYCLuRoyV/i9Ohuk1zFgZDK8dafxf3K11Pa3aRRa
         zKQOLxnMX7TLNee9WZjTYdLI0H//hTlr15W0rViK9r0/3wBdJ9ejtn/OWR/ibZ4QRYhx
         QQf8mFISuh9SbxdiYGLAWTU0TmG/d+W8EYgUbLV8d3H7M+XPutKDYsecuhFbqgIyR7s3
         uzH6XVfLr7BjwW+A6btXjYSldqy7ZT1QaBYDSVxSbYFsdkNXbD9aeeHZa3inMJnadCYX
         lWlQ==
X-Forwarded-Encrypted: i=1; AKwUvBykkNTsbw+NmlOzyEfAu4zw4q37oIH7MR1OkDNQZwCpoifHUH1d8J9R+5Ltp/tT2bfmzSc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8158DNOMbbnB4yvUeN6PdKMiCW2H37bcHARk/ogYtVhGMF+XKe
	DNE0WvXYUrwGH/au5k4E+3SOP4EZFF98rlW1HNrIhD0kFWV9K6ihYqfDc2+X2gQ5gNA=
X-Gm-Gg: AYBFou0DjhU33VpxhusxBnYGnp+1LwhT6OSKS2Ou91wcb9JuBDze8n9jHlfRL/8raV2
	k8qvOGJaYhFeK5GLq2sVDNU+9ecpOBHe8YEv62WxUmNMKT2QBA7ClH6NaHlVpjaw861Nkf2jwLE
	KOiHUtq8o41krgrbQEscGNbpW2f1QStj1x0gm9789OYJsJI/y1UXviXwIPPVzBoK+NxfZZtIbu4
	W4JuQD6Jal2YKzdM6gdJYaZtRPEP3ppHOxmoXm5jFpAHCREqhU37e9ncso7Z1tnMdtBA3Da1wF8
	eeqpg6aDPWpaqiuHgbnj1d2Df+r8EKQCuxLUXz+IBKB0S8eZYnogLFIGwnZw86dElo5XVyVDf87
	zRyycJQNB7jLGlSvwG1kp6WDS+B4zVnhP9EC07yWg2uEX5neHPKN9AuQbn1eyvfFebYyJkvA/fK
	zqsAB8GMokkXT6Tl/bCLRAwFYQYxpiSnaVd8nPfs3zND/l6GhR71u1BtpzH2M2v2jnSA2guK+cK
	I+7BSKJ+r4cuK19lDqanNFKr+U383huLBN3I5j5Q0QoyetHvjoeazpp7fjIKB6p86M4/9j9dkCa
	glL3K52XGwQbXfaiOtstnTfpwQ==
X-Received: by 2002:adf:e18c:0:b0:48e:eb:56c5 with SMTP id ffacd0b85a97d-48e6e2c1d83mr40340920f8f.8.1793805567922;
        Wed, 04 Nov 2026 07:19:27 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm4639812f8f.19.2026.11.04.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:19:26 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Christian Schmidbauer <opensource@grische.xyz>,
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
Subject: [PATCH net v2 1/3] net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
Date: Wed,  4 Nov 2026 16:19:11 +0100
Message-ID: <20261104151914.2651241-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104151914.2651241-1-opensource@grische.xyz>
References: <20261104151914.2651241-1-opensource@grische.xyz>
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
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7ffed295eb14..3e5803db19b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5547,7 +5547,7 @@ static struct sk_buff *stmmac_construct_skb_zc(struct stmmac_channel *ch,
 
 static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 				   struct dma_desc *p, struct dma_desc *np,
-				   struct xdp_buff *xdp)
+				   struct xdp_buff *xdp, int status)
 {
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
@@ -5575,7 +5575,8 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
-	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
+	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
+	    (status & csum_none))
 		skb_checksum_none_assert(skb);
 	else
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5789,7 +5790,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
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

