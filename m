Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034723F9F4F;
	Wed,  6 May 2026 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061405; cv=none; b=RZ3LkyE6HoQfW/BhEa5GF6DQCCSt0aG7siLumOJ93g4eCgYThnrIoz7xuYXFePiH8PnwdfYzoSDcsoLcU7zkdnOc1K4Yup5UPGEk65R85D92BahajLq577gfYbpYU5g5iGFMuXEA+Kh3bCrD8FjxsixgkOM9m1Z5uGrGELsHVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061405; c=relaxed/simple;
	bh=i4b29kb5a/XMebP4vH5gtQdeyfZIpvycSMwV1kmFiYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBZHWHOtlaRa16Kqeig1DNT1gD6tRlT/ZJPLG65kyP5FzYqVSF0JUm9A2z3KVniMGiKonmhoybQLoNLbeGVnyIekX/LMDxBWEOWtzEnyjhrk0TcdWHLFQSqZNKlyqsL8u9c9gjS5//5246tx8myrRIKQ/5qte9WglkO3LfPzePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VdFNn7mO; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VdFNn7mO"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F9CCA50CD;
	Wed,  6 May 2026 11:56:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1778061371; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=1gBHfWci9FiNcluIaLhYXqnpOD0nhtzCOMGm24dX1Ic=;
	b=VdFNn7mOwU8hq9o4KWTKiS//BdbhYw5GatZTxFjYwk64TKL4OTgSpct3oJye0xbSkROatK
	m60mJZPblsnmjbL+bbFXqabj71pZTqB819c6kLwnFgjJwennXtQxHxy3WtmoG1Xv7yKsMf
	Mfi/r4Ig7oNpBjvbMf7xsaDgrTpFsM7mtsUnesuMhoibay3Seqhmeg2niP94RuVuHq0AYC
	JLVa3DIAX1PNha05494CWKxHbnq9LT0R1QMzUMi+rs1DnwKfEHj2as2WCI6BvMdfelzPqI
	+0KZskbIczCidUCx3F1NuFMwk/nfPiKlfq6PbdGqiIMcB1qyoR02N4HpOCvRKg==
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
	Mohsin Bashir <hmohsin@meta.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v9 7/7] net: bcmgenet: reject MTU changes incompatible with XDP
Date: Wed,  6 May 2026 11:55:50 +0200
Message-ID: <20260506095553.55357-8-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260506095553.55357-1-nb@tipi-net.de>
References: <20260506095553.55357-1-nb@tipi-net.de>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 359a297a25e6..6ef76e93d9ad 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4095,6 +4095,20 @@ static int bcmgenet_xdp_xmit(struct net_device *dev, int num_frames,
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
@@ -4105,6 +4119,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
+	.ndo_change_mtu		= bcmgenet_change_mtu,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
 	.ndo_bpf		= bcmgenet_xdp,
 	.ndo_xdp_xmit		= bcmgenet_xdp_xmit,
-- 
2.51.0

