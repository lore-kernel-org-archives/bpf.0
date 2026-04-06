Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAAADF59;
	Mon,  6 Apr 2026 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775464611; cv=none; b=mLc9WPNSUFC+3HG/VXnsTjjtDQKHriKa813XZp1UETx7wEmtnUFoijMaJ6P8gG5hzxhQ2aMMAZT+BLupOOpKD10zv3nmK6VnbVLWpFPCcMcK/VAb/ncKpM07oZgDzKPJL4a73P60/L0dwv8OnzJr/LFrC+Yw3ASUFSQeFF2wUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775464611; c=relaxed/simple;
	bh=ri4uMS/KrOihwfk1tdAsaoeSGbvKn7z1/rOtieOz1p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq4aBhAY1HkN1mSASitGYK7kNrWfX2MFgBSRoVv+qR2B+zVKl1mtyxYNSQ8MkZpVnH/gADHUic9bM6oCZku3aKw3sqweks0OAAWXHzyfvQZD769JPtHshFXN3mM2Q5339uCGXW14H78CSfD7m9ABIE2G+QUlm9+jdQ5qgPQZhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YP87nV+m; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="YP87nV+m"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CF367A58A6;
	Mon,  6 Apr 2026 10:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775464601; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ngTZtnOjuZpY0cNDN0ZDTj9+cB6W9wq0AXZPvWPzKCc=;
	b=YP87nV+mG//xewi96Ks/XhAH2Ia87jEeAI/qRbIWL+tgoYTKovwmfZU09/sqPioQSwABTw
	En2ozH21ovCLh0FCWZBnxIOgfxljXfvQbbIUgRzWkccssyLR2SIXzUH9wR6cqJ4JyISZ0j
	viXQj98rch8y5pIs/AvquHez1PlJW7JjcWpyu+kVhgh0T3iuyZjXRgTSsvKLrUzGedO3Se
	oTi/MiXzIGA5a1tSbRur6wIoWaos4tpoO9GPAqNF0CeQSO+/j010EWfv8g77zAOIfaquSa
	eQWE8pDMSfVCq5pJ14x0kqa9bxxm+6jNoxbu+I/lBGfBoMLqjmIeTyDoq8HzCw==
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
Subject: [PATCH net-next v6 7/7] net: bcmgenet: reject MTU changes incompatible with XDP
Date: Mon,  6 Apr 2026 10:35:31 +0200
Message-ID: <20260406083536.839517-8-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406083536.839517-1-nb@tipi-net.de>
References: <20260406083536.839517-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add a minimal ndo_change_mtu that rejects MTU values too large for
single-page XDP buffers when an XDP program is attached. Without this,
users could change the MTU at runtime and break the XDP buffer layout.

When no XDP program is attached, any MTU change is accepted, matching
the existing behavior without ndo_change_mtu.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 7d0c9a848331..46998703560b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4092,6 +4092,20 @@ static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
 	return sent;
 }
 
+static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+
+	if (priv->xdp_prog && new_mtu > PAGE_SIZE - GENET_RX_HEADROOM -
+	    SKB_DATA_ALIGN(sizeof(struct skb_shared_info))) {
+		netdev_warn(dev, "MTU too large for single-page XDP buffer\n");
+		return -EINVAL;
+	}
+
+	WRITE_ONCE(dev->mtu, new_mtu);
+	return 0;
+}
+
 static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_open		= bcmgenet_open,
 	.ndo_stop		= bcmgenet_close,
@@ -4102,6 +4116,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
+	.ndo_change_mtu		= bcmgenet_change_mtu,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
 	.ndo_bpf		= bcmgenet_xdp,
 	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,
-- 
2.51.0

