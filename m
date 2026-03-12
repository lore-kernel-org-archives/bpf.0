Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6A83C2764;
	Thu, 12 Mar 2026 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310185; cv=none; b=tDrWTcZm4Mk/TgC3aeMeHnFuTTPUOLDUkh6XcIPkgFh1uPNrZj9HidNL5dJUtpW5F17HikcDJzb+Rd0MxjDK/f9dRBpA1NMKKTnwYK4Q4DYTI4upyvJDC2EfKYE2UQKrQVOSngK2NQQ8pq0BlLvKSK/fYshpasz0ARFRsbWpBdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310185; c=relaxed/simple;
	bh=ZWq64joZ2HzysBWsR0irO48NxLG3PCjk88eimnNVwaI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=KCv5A5lN4NWbXBIZkOvrzkLV26/sC8feAi5m70rp5gqbuFTQJZZMmKLYJQosBVpmjwexQ1TEhu4BQA8947YjhuRinJ4cUJwq8Gorvj3VQpEGyowUZGnWqOpWUiPiIsVGxvzJRFtvlDzmHEMKfOs5JR9GJG2ZN+20MxElVATTAv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bGfLDBxt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bGfLDBxt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5rpidXVVDoCtCkRYl0DmYJZsfgbhv+B1m4hTkd40PP4=; b=bGfLDBxtgQ8jChCSiB8OJy+kgE
	cbiW5FAmHjttGZrh7YGDvEW368zNk5PTOX9w4rPWfdlRiK8G7XmZYh6GINw5102rtcsFvj1SNc4VX
	wBabFF5rNogd3DKtMqNiIQDGuC4PRrV3IsPjc3U82U7efNutd4FCdIXaLwGOpETaYfFiiFaVMUKHy
	b0WgYk8oXLcUHO5PlGWF1sFMHnKUUf49fmlsk1XkrMfxF7bFia0lWubj6Fq25N7VWi5Hhqd9GXEYO
	X1DTy18neBJQBpxguh70tv/zQl7Zx2XrtoZqulmQqOX8yvLQSef1gZaGMQEZTalfimzoHfthMTxL5
	KIsb5WRg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60642 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w0cyy-000000007ZN-2TlF;
	Thu, 12 Mar 2026 10:09:33 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w0cyu-0000000CzGZ-2poX;
	Thu, 12 Mar 2026 10:09:28 +0000
In-Reply-To: <abKQWloxp9_4OuJh@shell.armlinux.org.uk>
References: <abKQWloxp9_4OuJh@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 08/15] net: stmmac: use consistent tests for
 receive buffer size
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w0cyu-0000000CzGZ-2poX@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Mar 2026 10:09:28 +0000

Two out of the three sites that set the receive buffer size (via
stmmac_set_dma_bfsize()) check for rx_q->xsk_pool &&
rx_q->buf_alloc_num. One uses just rx_q->xsk_pool.

Discussing with Yoong Siang Song, the conclusion is that
stmmac_dma_operation_mode() is missing the rx_q->buf_alloc_num
check. Add this check.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1d40168ec68d..787b02c2607a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2612,7 +2612,7 @@ static void stmmac_dma_operation_mode(struct stmmac_priv *priv)
 		stmmac_dma_rx_mode(priv, priv->ioaddr, rxmode, chan,
 				rxfifosz, qmode);
 
-		if (rx_q->xsk_pool) {
+		if (rx_q->xsk_pool && rx_q->buf_alloc_num) {
 			buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
 			stmmac_set_dma_bfsize(priv, priv->ioaddr,
 					      buf_size,
-- 
2.47.3

