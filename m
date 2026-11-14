Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663406;
	b=ZvsxQCOaxXXGWiqrqvwRaRKPNdYK/OH892x/3Wpw/cToVmbS9YJY9BzWbzjPAG0orPlA
	 smTjJBS6OzyyuRDduzA5BeEX2+bkCRoOu+3w/L/7upTQvr9rSeM4nRhEVFHm+RbOZzd16
	 TR8B//kUjfyyQbui/qfahl/XCnYDYhkHlvcKxtjac2plelem5cmeKytlboeSGRLp0Tf17
	 pHFzzq9isurVk2fLhbUlQZeecV4NrY6kbfUpiZhpOBziiKsUnVEj3zvgRekL030NLESKo
	 od1Uz1S6rxrbGdteuBkGGAPYHUm9JnRpkKOTgFm4isTg9f+X1P06jS+KyqOCsLEuz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
	b=icximc5rndojfRWPROssBshA00pVJL182+ORRW51fkOUT8ZD18IVX+yJIAo8F4T+QfRs
	 buNe5plO+1botnvhlyceodEfh3YDR9XXOAA2AQL+0erX0PMI+M1LG2246p1+cCYMtHuZJ
	 9BH2HwuNPKjyX+j+S1okdrxNisBI1kuEGJBNJWxIVk8U4jlJwZlFr8BUiZjkyUa6wXk9P
	 7Umep78xGIILqUhMXLbOghMt4jlGWCQOlLP+jStM+0m/lDcSackAZYLtfv2iLmjMvI2/S
	 FyW6JRNT5vShzAueOTeRwlEfREUnddsRIGsDVdbv/5jmg/pWSSn8y9czYozZNTJqWig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	dkim=pass header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=RLiTW4j2;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E8606A339
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 13:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC4E8606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grische.xyz header.i=@grische.xyz header.a=rsa-sha256 header.s=google header.b=RLiTW4j2
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-498f5fa5103so780394f8f.2
        for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grische.xyz; s=google; t=1794663404; x=1795268204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
        b=RLiTW4j2PZ22Di6wXigCid5UZFJoV8dam7pEz8ccG+3BR1ZeTpnU/jNYAdUaF6+GKV
         i4u/7Ahng6orsr62b4sAutMAc49qkZhOwoBVIUV7+sQMzQ/RECJlhxBglurbIjPkJ7c1
         80jVIZDhu7AB1+KcwjFjddolobsJ/sVfAdM2BVtyRYJ8rONTqblrO3dBwr6f6esVg1Ek
         sBFq+16x+IvjNW+wRQYuZxLo9ySeio0fArjTkHjGFAnz2LVbcyXrgkANCZHgChnkDoA9
         5QNoMASS08Vn34NZb9IBUnhw0jMaxOUbNcHwbUBD8oKt7dUPJgFjGvNz3Cs1ZB0H/DXb
         jRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794663404; x=1795268204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kasbafd3T9Fhrw7R0Nr/dFHUF4ChKeJYhTGf2AiF+Y=;
        b=CCtRwuOhH1dmds0/zueBMRqvQtTHIXJgCkUciDpIYdDusW+3dDJlQ1IG0SeMI68cZ7
         XhwI2wxhi7ZIVhodshmRQg0RUb0Lk/E5Aq/ETcb/6hxEi4Hk6AN78RBy5nEPfmc3DEX4
         8rpuJUhicqTPJ8rIeRWrPRRsO6MPRJn1lromgS7Rh1WF0TpYmfotGH5SlBkMYPp33U/M
         5GwsMSEVRLTHCPoA9vLKbie9a0seykTQMsN8j0ZhXS4RYIdBD0ivNbqwMkyiFcnfWl75
         50tzDFFXLA6vcjbsy6J0C2JXqsjSePNCVoTuQLT45JTRxIKqfvNVVJ1nyueqdpgNqRvW
         MZzg==
X-Forwarded-Encrypted: i=1; AL+hErHSpOi30f1y9+qzkE6S53ZLjJmDPfCTXJq/T/xUjZSxyaWFTjHBxeab4M6ACQr1bRGwaIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eroaeSBD7IywwBHlNF6ZaaJ/vMPf1/wcFPdZ7uoY4Z+cT+M9N
	I58EgsYRA3GbiFgWLrNqWP2HBE+Nh2Uq1ioH25JqHzifb6RlsKmClu9BD5OJC3r3NW8=
X-Gm-Gg: AYBFou0ina58aR7Bdi5T4LqWKFGyeuJ6UD5aSsyspYBC11CEuj94aKTO5Is0Cd8ZDKI
	+pRhd/Y6tCkX9oXWnAZDrecQx5rxdNDCNqZtLZ8wRs/6RlPXRqe1LSfnYmZw0FHdoQ/Di7sDwbt
	nOAlbUvNt62oo/R4cSjrGownM04CoxmebWLu1AznURiopUE2DobjRNrWM1YCvItodP4DDZXUq8S
	RISM71rijxCkjwJf5WymTCmhW+t9hTdMYzzSunKeL63fgrQUiuMTYHyqBMf+KIfB17psI8Pid/q
	mNu/ohS4Dtgc7ACGS4VrHye1Whc0mSGj+pr4AWdW+mUv5i0FRMTsgxnur5zRWNVj/6pj/nemj2L
	wTqS53dNuqQ3q0fxAh2YnY8SD5WPHFYLMsUl5WQSX5Q8iE9/Cl4FlIj76YXvhGgW2wv197dRo2l
	SfoQ5ebzuftxx8G5JjNkX4bwpUcBqjACRxU1WdPoOVPasRlJYA9d8KG8ZldxET0alKsdwb24T4S
	Zf3vOMOr7e7lb9JiAlkaXq9hgdUNJJtuGlcamSgfM0K+wEsmaC/4+BeQcoQrZ6KMQEP+usIXkSP
	nK6w/BEDEH+H2XrQl+vNj5nYRgqvVcG+d0MJ0+N5r6X3B6w=
X-Received: by 2002:a5d:5f03:0:b0:491:e062:383d with SMTP id ffacd0b85a97d-49c7390fb5emr10908010f8f.57.1794663404019;
        Sat, 14 Nov 2026 05:36:44 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:1a41:5e41:61a6:f0b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d69c21a17sm6657866f8f.50.2026.11.14.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 05:36:43 -0800 (PST)
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
Subject: [PATCH net v3 1/3] net: stmmac: honour Rx checksum errors in the AF_XDP zero-copy path
Date: Sat, 14 Nov 2026 14:36:37 +0100
Message-ID: <20261114133640.3285413-2-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261114133640.3285413-1-opensource@grische.xyz>
References: <20261114133640.3285413-1-opensource@grische.xyz>
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

