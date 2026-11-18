Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044269;
	b=MI1uzKpU94j9jWizIHp2tVEsgKktjXdzSWdVnAbg9kw82b8pWYu6VwtUylFI0e8u0pib
	 8nw2G+j3P92LCo3faJ7SVHexMrxi7uKXKMwgqiY6Ra9AhAd0ziG78+/ypKc6Wn8MDs7sK
	 LrmPl2fFhoGLX9NhAb+YROgXP3ttZBpYvHg6OUaR8mWNJyZXFQpQgMX08foVcMHVUdwLl
	 RYr3CzLjy5TP6AKFWtrwzGz8l0JEI3FvDrB77Sdw6M6U5j34ZfSdi3ZWfkZV8TtEpW0Cw
	 JhyC8BMBhiOe1LCsQBlUNSzRtPf089koAW2b1pyfCV5wKdZXB5XTTic0xmf9DpYimHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BSCa59sPJ/PSZfMTVFZuayrd2SH02jn2s/5XOxmFNtM=;
	b=F0ck5suWrmbuHcQY+rf51JYpxohsObmgzuK55A3WD+WTUFv1yxHHockq78+v+F1hy2Dv
	 XNnA3PUfEZNfEidPoeI1tLlg3X4cp/5tTGq1zkxH/27UO+jHpuyKSd9HHecZnBFgGPso5
	 J7/UiU/4typ4EwHZLGR57KLxLjIvJN/stHAFyowgHbOhL0hPNMzLoK0cMymw4K4cEXpBS
	 N60KcHQQ8uOW2IXVP3qfbThSpb913AcSqmvgckd6s/Ovw5JPKM4UQC1Xy5VHw9UPu+8L+
	 2ZHcGaBPIFlGLJya+RUiMP7m6O4lyI3c8TScHUt779aOh2Ji/xH43bISgoWzLNFgxZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayTrHnCo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45783606A32C;
	Wed, 18 Nov 2026 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ayTrHnCo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9016C1F000C9;
	Wed, 18 Nov 2026 23:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044269;
	bh=BSCa59sPJ/PSZfMTVFZuayrd2SH02jn2s/5XOxmFNtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayTrHnCoFeBBil7bSuDZjmnbE1M64UrIRQj1MkXyFQjpSQ/vUCud0XFPCeZMhBaV6
	 SCy0MofY2ikikERAIjGc3G39JNhGJN8E8REpYzp3C6s11yq2qCwUW06jhRr7tJJkXy
	 dDFa967q5tVVVjF26stEpVfr2UchqYibrGAo9dfnOkzeDsR10g1z8qDinqk+CIWj/3
	 fAWhlkWJ/sCv+9dUKf/T6TJ4R/BPxJWHwzHEVaFQ41Z5RvzbEB0w9ndvQzoyIe2J8I
	 FprG+p6b6snt2G1acc1u9FCnRi2pO0mH2XamgFQDcwBsRNS4/NT/4qtODsFODPjWXt
	 1HlEXZNX3m7IA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	manishc@marvell.com,
	joshwash@google.com,
	hramamurthy@google.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	daniel@iogearbox.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	przemyslaw.kitszel@intel.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/8] net: stop making HW-GRO depend on SW GRO
Date: Wed, 18 Nov 2026 15:23:08 -0800
Message-ID: <20261118232315.3593731-2-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118232315.3593731-1-kuba@kernel.org>
References: <20261118232315.3593731-1-kuba@kernel.org>
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

bnxt, qede and bnx2x clear NETIF_F_GRO_HW whenever NETIF_F_GRO is off.
Nothing in the stack needs that. HW-GRO'd skbs arrive already coalesced
with gso_size set, exactly like LRO frames, and LRO never depended on
the software GRO bit. netif_elide_gro() only gates the software path,
and the in-driver consumers of the offload key off the feature bit
itself, not off NETIF_F_GRO.

The coupling gets in the way of exercising the offload on its own:
turning SW GRO off to isolate HW GRO takes HW GRO down with it on these
three drivers, which is why the GRO selftests carry a generic XDP hack.
The core only ever constrained GRO_HW on RXCSUM, RXFCS and LRO, and the
other HW-GRO capable drivers do not couple the two either.

User visible change: "ethtool -K $dev gro off" no longer implies
"rx-gro-hw off" on bnxt, qede and bnx2x.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 3 ---
 drivers/net/ethernet/qlogic/qede/qede_filter.c  | 3 +--
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 6fb0619731ae..5686c4ecb944 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4934,7 +4934,7 @@ netdev_features_t bnx2x_fix_features(struct net_device *dev,
 	if (!(features & NETIF_F_RXCSUM))
 		features &= ~NETIF_F_LRO;
 
-	if (!(features & NETIF_F_GRO) || !bnx2x_mtu_allows_gro(dev->mtu))
+	if (!bnx2x_mtu_allows_gro(dev->mtu))
 		features &= ~NETIF_F_GRO_HW;
 	if (features & NETIF_F_GRO_HW)
 		features &= ~NETIF_F_LRO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6846a27bfef4..27c53db2c9e4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14092,9 +14092,6 @@ static netdev_features_t bnxt_fix_features(struct net_device *dev,
 	if ((bp->flags & BNXT_FLAG_NO_AGG_RINGS) || bp->xdp_prog)
 		features &= ~(NETIF_F_LRO | NETIF_F_GRO_HW);
 
-	if (!(features & NETIF_F_GRO))
-		features &= ~NETIF_F_GRO_HW;
-
 	if (features & NETIF_F_GRO_HW)
 		features &= ~NETIF_F_LRO;
 
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 5bf32f1034e0..d0e203167e35 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -915,8 +915,7 @@ netdev_features_t qede_fix_features(struct net_device *dev,
 {
 	struct qede_dev *edev = netdev_priv(dev);
 
-	if (edev->xdp_prog || edev->ndev->mtu > PAGE_SIZE ||
-	    !(features & NETIF_F_GRO))
+	if (edev->xdp_prog || edev->ndev->mtu > PAGE_SIZE)
 		features &= ~NETIF_F_GRO_HW;
 
 	return features;
-- 
2.56.1

