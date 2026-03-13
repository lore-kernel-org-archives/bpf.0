Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626EE30596D;
	Fri, 13 Mar 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395479; cv=none; b=fsVkmsvdmldAc1CWNceG/UII6HjZ+8cS5mOjdQhU1UkmMle+vkwEDR9ojyMqYn1cZikgmlDqUnPSrh+Il0VJZ+b9fjt2Fxw227YoqZKyYg/7aK4baI/70gUVKWUI2+y7QsZGROTQ9Yj9DoSALIcCiwND6+NiBOqdTtgcdsGMg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395479; c=relaxed/simple;
	bh=qbxEzDjTq8HPyB1USGf7av5jbb5T/ZQfAV8b5W/QnjY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ciag55bvDDJa6HR9yG+ugvIu8AtSthXNp2SjvJXWmXuI0X6RzNmTIU2SwMPfS05NJtp3VolwGAyM3FRAlT391Aupl+UR3fUqRXJgsRyMKKCvupLj1Uj+naGO5vayQmSNj0qtvw05WGN3MHJsSxXxReaT6zxvUae3B22bYeKfOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ng1NtnHX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ng1NtnHX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9p0rSsXOHVPiLPE9YB/i36bApTaz8+E8i1mIA/i01iU=; b=ng1NtnHXdcGB13nYO7cWqw3FOM
	dRjsZkIFuvM9Kt0KhXC+709SjM5jiciGxveNXkDj2FDct2GYYh4h5qEP77VeaN76P8jBBdAjVeg5J
	Zr9KZlzKEwuUQ5ignMn19VdeJYKVbUmFMDXM+dqL1Et35rN36af47JwM28h3Hennr+m4wvuqmpFrV
	TmXFttXUGrC+C8lO27UQHrkOvNrWYUEyWM7ggrNhqEllY8U389L5Rz/X+REs8zStRYI9NrFPF0yqI
	wvOMsqIyzkGpWdM9lhdO96qFibE0gQuTO3qY4ioxOAYGWt4FAHOwPAJpV/mTLYmSrCvuVDh0Eiw3/
	w4izRfGw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36402 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0zAo-000000000cp-05sD;
	Fri, 13 Mar 2026 09:51:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0zAn-0000000D4FA-01WH;
	Fri, 13 Mar 2026 09:51:13 +0000
In-Reply-To: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
References: <abPdzyXJHqt5v3bi@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v3 03/15] net: stmmac: clean up
 stmmac_clear_rx_descriptors()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0zAn-0000000D4FA-01WH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 13 Mar 2026 09:51:13 +0000

The two paths calling stmmac_init_rx_desc() are identical apart from
the way the pointer to the descriptor is fetched. Split this out.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0dcf4a31e314..765b168df50d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1514,20 +1514,20 @@ static void stmmac_clear_rx_descriptors(struct stmmac_priv *priv,
 					u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+	struct dma_desc *desc;
 	int i;
 
 	/* Clear the RX descriptors */
-	for (i = 0; i < dma_conf->dma_rx_size; i++)
+	for (i = 0; i < dma_conf->dma_rx_size; i++) {
 		if (priv->extend_desc)
-			stmmac_init_rx_desc(priv, &rx_q->dma_erx[i].basic,
-					priv->use_riwt, priv->mode,
-					(i == dma_conf->dma_rx_size - 1),
-					dma_conf->dma_buf_sz);
+			desc = &rx_q->dma_erx[i].basic;
 		else
-			stmmac_init_rx_desc(priv, &rx_q->dma_rx[i],
-					priv->use_riwt, priv->mode,
-					(i == dma_conf->dma_rx_size - 1),
-					dma_conf->dma_buf_sz);
+			desc = &rx_q->dma_rx[i];
+
+		stmmac_init_rx_desc(priv, desc, priv->use_riwt, priv->mode,
+				    (i == dma_conf->dma_rx_size - 1),
+				    dma_conf->dma_buf_sz);
+	}
 }
 
 /**
-- 
2.47.3

