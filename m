Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC33793CB;
	Thu, 16 Apr 2026 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318509; cv=none; b=ocsT8iX3VZggwL2l8kttNz3XryboI394TvFBmMCInNQD1mf1Vq2GgYMGMqlnLHSLDvGfkBgHL+icS1gnodwrnAJ5gkgkni5oMFtHFxRU4LGSFPdmuMLMNIrswaSUuajKOOCuBc4+V+bJNXuHPL3arse8SgpK7L+ITV1HYJYJVoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318509; c=relaxed/simple;
	bh=/sr1gp+8osRxv1Kdpu5BA24lxa7W7rdV8Lvsayp3oZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB23lPtwAZGxzG4LNIbhKu84L01M/wR6O+TTiJF8G6ehjt7syky1GR+gMt+7rKhpV3Q3DR0Gy1Gdz941V0o38GI1nVDtuX+X4ihNmoZI90JPPU++sBSnckk3JWBkQt1SqMQjA5V45z60GdFBDy/gOmf0fc4k0S1V2wXVrrh8JNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=o0rvcaVu; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="o0rvcaVu"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93A31A384A;
	Thu, 16 Apr 2026 07:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1776318500; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1ri5NiV70JW9wf0XT4tPsyNqYt/zDzgv4j2CdT3IOd0=;
	b=o0rvcaVuK5wHhUps4iM0cCZxs6q+CNdMo/tMSbttfNS24hoTYoSG5jcGoO8ClgVW4domnt
	qd0a5EeFm4eqDRLlUIifEOYFKmRKI5nJKbPJQV42MVE88SbpJN4/6rk+n/99Kre42R8IP3
	YvAVALthvv+evYSjwOOlk7j06rOs0wAu5c38gFf+r0pbpzKdlN1AgYzZRErlmQLjdVRSyt
	yLp4z9FoeO2bR9AQ6NhINvaRx7IqIhF50QRDvcPjBSmPQ95v78hCn4IFor2WDHgRF+AysW
	M+VktHa1Y67C0jaKFFJ5nlQBAG23mNAuaOb0jal8JsplVxuayius93aNYXadFA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 2/7] net: bcmgenet: register xdp_rxq_info for each RX ring
Date: Thu, 16 Apr 2026 07:47:34 +0200
Message-ID: <20260416054743.1289191-3-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416054743.1289191-1-nb@tipi-net.de>
References: <20260416054743.1289191-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Register an xdp_rxq_info per RX ring and associate it with the ring's
page_pool via MEM_TYPE_PAGE_POOL. This is required infrastructure for
XDP program execution: the XDP framework needs to know the memory model
backing each RX queue for correct page lifecycle management.

No functional change - XDP programs are not yet attached or executed.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 18 ++++++++++++++++++
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 94732414b48b..dd00196b9d4b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2778,7 +2778,23 @@ static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
 		return err;
 	}
 
+	err = xdp_rxq_info_reg(&ring->xdp_rxq, priv->dev, ring->index, 0);
+	if (err)
+		goto err_free_pp;
+
+	err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 ring->page_pool);
+	if (err)
+		goto err_unreg_rxq;
+
 	return 0;
+
+err_unreg_rxq:
+	xdp_rxq_info_unreg(&ring->xdp_rxq);
+err_free_pp:
+	page_pool_destroy(ring->page_pool);
+	ring->page_pool = NULL;
+	return err;
 }
 
 /* Initialize a RDMA ring */
@@ -2807,6 +2823,7 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 	if (ret) {
 		for (i = 0; i < ring->size; i++)
 			bcmgenet_free_rx_cb(ring->cbs + i, ring->page_pool);
+		xdp_rxq_info_unreg(&ring->xdp_rxq);
 		page_pool_destroy(ring->page_pool);
 		ring->page_pool = NULL;
 		return ret;
@@ -3012,6 +3029,7 @@ static void bcmgenet_destroy_rx_page_pools(struct bcmgenet_priv *priv)
 	for (i = 0; i <= priv->hw_params->rx_queues; ++i) {
 		ring = &priv->rx_rings[i];
 		if (ring->page_pool) {
+			xdp_rxq_info_unreg(&ring->xdp_rxq);
 			page_pool_destroy(ring->page_pool);
 			ring->page_pool = NULL;
 		}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 11a0ec563a89..82a6d29f481d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -16,6 +16,7 @@
 #include <linux/dim.h>
 #include <linux/ethtool.h>
 #include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #include "../unimac.h"
 
@@ -579,6 +580,7 @@ struct bcmgenet_rx_ring {
 	u32		rx_max_coalesced_frames;
 	u32		rx_coalesce_usecs;
 	struct page_pool *page_pool;
+	struct xdp_rxq_info xdp_rxq;
 	struct bcmgenet_priv *priv;
 };
 
-- 
2.51.0

