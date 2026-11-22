Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309282;
	b=knGeNdxKQ9g6m00VgyB6CGynL9HivHuKr/K5mq8UTAy19GIPOYVib5XC7HpvmUvnkAdG
	 wmAmjmQMKcGdTvuWkTovTAAnlaQPHCYjWuX7dCn0jLdO4AzeB8vRVJxN+pp5LaT14mk0a
	 DHqdWs/pyIbI7hXDlKCoKfHCP9HiCP/xh1xGAFjBuSJ3zOCfeSvtLYb3bEbwwFprZfePp
	 zdPAbXM+la59Or9Mj9nlhCO783P1lpq2OEogNR9SVOeX58T+Km+2xEnTfYKaO2/vCcOP1
	 lhGUNTX48s6VE9gnhtIGPsRQQH9QH8lI6Sy66rJ5n32gwT+ypdCsZzN+/AXAnDChOqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tXjeZU5GSs/uz0hKlC0URJrZHP/eBhjfdOTv8TzdxBI=;
	b=L3KW7YMP89OtJmXXZ/Gk87queKaqSLzDNZY3BEnaea5WR5Kehsr2U57qOHqeR0dJmx1J
	 CimN8WbJ+36iKVCdL/J+7eyJeP0yZMEL8j+xbzeTNg9/Dvuuylu32z5GgVJrojy88/uOd
	 n04CP/QpYBqD3FRdo+7O+ABV5hdHOGj+e7g11cA7oAEnzG2aPCNUs3NhYNN6wO2zM4bwb
	 feX6SUhSaZc1F5R7S0806F8WNLXA1g08KjYNubIPJSwltis7I0rZfdwlVHvCuVSqVqLNS
	 HApVJg12ZcatzDDoC4OwE42gH7zxNP0kYzLVGEnZrxJ6JY1p2WtiKqzO10CwoPkq+xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXyRtWqu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177D606A33F;
	Sun, 22 Nov 2026 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OXyRtWqu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537981F000D0;
	Sun, 22 Nov 2026 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309281;
	bh=tXjeZU5GSs/uz0hKlC0URJrZHP/eBhjfdOTv8TzdxBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OXyRtWqu1BaINOKsbnlFoJ2y0Gvp7BI0djrH3TmiqcsghgQpgfSsnXBDT7seZ/TnP
	 j2zQ5vS6aBifB92XgDGp1Mznl+y1Kg7VlmD+OZKwrTgG0bCIthcfBx53hvN7oTFcgx
	 YVZuYCJm9IJMvynQfzrYPIENKh2y/168AGh7fhb5KelgDXWoGNYZKwssaUVugByKaR
	 4+f6hNvRQ02rwvLmqEeQBC29EgaEK/9Efe7LyygoBnN61eWslITZA7frjh/iCnB9Nq
	 ksSmGnodvQVCDjnjjuZTYBk0Jnmz7filLsTrikJQQ1vWHvFDJ16dbiN1z3Nu5tNMNK
	 Q93O7NxqUUbmw==
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
Subject: [PATCH net-next v2 6/9] eth: mlx5e: drop the now-dead HW-GRO and LRO vs XDP handling
Date: Sat, 21 Nov 2026 17:01:09 -0800
Message-ID: <20261122010112.1471146-7-kuba@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122010112.1471146-1-kuba@kernel.org>
References: <20261122010112.1471146-1-kuba@kernel.org>
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

The core clears HW-GRO and LRO before ndo_bpf runs and keeps them off
for as long as a program is attached. mlx5e_fix_features() never sees
either with params->xdp_prog set, and packet merge is always off by the
time mlx5e_xdp_set() gets called, packet_merge.type only follows the two
feature handlers. If tcp-data-split keeps HW-GRO on, the core refuses
the attach with -EBUSY before calling the driver.

The netdev_update_features() call at the end of mlx5e_xdp_set() was
there to apply and release the XDP clause of mlx5e_fix_features().
The core recomputes the features itself, on detach after the program
is gone.

XDP features were only advertised with packet merge off, matching
the old refusal. Key them off tcp-data-split instead, the only setting
under which the attach is still refused.

The AF_XDP check stays, the core doesn't know about XSK pools.

This does change user visible behavior: attaching XDP with HW-GRO or LRO
on used to fail with -EINVAL and now succeeds with them turned off.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - drop the netdev_update_features() call from mlx5e_xdp_set() (Dragos)
 - key XDP features off tcp-data-split rather than packet merge (Dragos)
v1: https://lore.kernel.org/20261118232315.3593731-6-kuba@kernel.org
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  8 +++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 40 +++----------------
 2 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 8e7c748caf2d..da224ad3dea9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -488,9 +488,13 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 	if (err)
 		return err;
 
-	/* Might need to adjust HW-GRO if it was kept on/off due to hds. */
-	if (dev->cfg->hds_config != kernel_param->tcp_data_split)
+	/* Might need to adjust HW-GRO if it was kept on/off due to hds.
+	 * XDP features depend on hds as well.
+	 */
+	if (dev->cfg->hds_config != kernel_param->tcp_data_split) {
 		netdev_update_features(priv->netdev);
+		mlx5e_set_xdp_feature(priv);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 06a8a4be4be7..08568137d044 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4487,12 +4487,14 @@ static int mlx5e_handle_feature(struct net_device *netdev,
 
 void mlx5e_set_xdp_feature(struct mlx5e_priv *priv)
 {
+	struct netdev_config *cfg = priv->netdev->cfg_pending;
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
 	xdp_features_t val = 0;
 
+	/* XDP can't run with HW-GRO, and tcp-data-split keeps HW-GRO on */
 	if (netdev->netdev_ops->ndo_bpf &&
-	    params->packet_merge.type == MLX5E_PACKET_MERGE_NONE)
+	    cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED)
 		val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		      NETDEV_XDP_ACT_XSK_ZEROCOPY |
 		      NETDEV_XDP_ACT_RX_SG;
@@ -4604,17 +4606,6 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 		}
 	}
 
-	if (params->xdp_prog) {
-		if (features & NETIF_F_LRO) {
-			netdev_warn(netdev, "LRO is incompatible with XDP\n");
-			features &= ~NETIF_F_LRO;
-		}
-		if (features & NETIF_F_GRO_HW) {
-			netdev_warn(netdev, "HW GRO is incompatible with XDP\n");
-			features &= ~NETIF_F_GRO_HW;
-		}
-	}
-
 	if (priv->xsk.refcnt) {
 		if (features & NETIF_F_LRO) {
 			netdev_warn(netdev, "LRO is incompatible with AF_XDP (%u XSKs are active)\n",
@@ -5203,20 +5194,6 @@ static void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	queue_work(priv->wq, &priv->tx_timeout_work);
 }
 
-static int mlx5e_xdp_allowed(struct net_device *netdev, struct mlx5_core_dev *mdev,
-			     struct mlx5e_params *params)
-{
-	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
-		netdev_warn(netdev, "can't set XDP while HW-GRO/LRO is on, disable them first\n");
-		return -EINVAL;
-	}
-
-	if (!mlx5e_params_validate_xdp(netdev, mdev, params))
-		return -EINVAL;
-
-	return 0;
-}
-
 static void mlx5e_rq_replace_xdp_prog(struct mlx5e_rq *rq, struct bpf_prog *prog)
 {
 	struct bpf_prog *old_prog;
@@ -5241,10 +5218,9 @@ static int mlx5e_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
 	new_params = priv->channels.params;
 	new_params.xdp_prog = prog;
 
-	if (prog) {
-		err = mlx5e_xdp_allowed(netdev, priv->mdev, &new_params);
-		if (err)
-			goto unlock;
+	if (prog && !mlx5e_params_validate_xdp(netdev, priv->mdev, &new_params)) {
+		err = -EINVAL;
+		goto unlock;
 	}
 
 	/* no need for full reset when exchanging programs */
@@ -5279,10 +5255,6 @@ static int mlx5e_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
 unlock:
 	mutex_unlock(&priv->state_lock);
 
-	/* Need to fix some features. */
-	if (!err)
-		netdev_update_features(netdev);
-
 	return err;
 }
 
-- 
2.56.1

