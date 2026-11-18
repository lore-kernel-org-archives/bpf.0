Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044272;
	b=sEbIufDY7oCqVQjTIO3jRBDgvH3MuCDkgfbv66NZNqX6uwenmsRh7s/6dcSqvj+fgvgU
	 N38SnHLeQRvbUglkLC1KUsM9IyVQHrygAIsRVJadJM4pX8B8jwHK+06Hf6Mlk2DCg1LY3
	 sM47YRu3QKtEKKIsiNZ3NwmMlqG7Pdzg4s9yQMapiAwzAcgOCE8rC3P2PK1szVou4ztjK
	 SZEDW+UaGp7JloIdisPPGJkQS+Lvhlb97m8mKlOX7I0Vo+wJI4Tg3i3r00Of3Dy6cbQ3b
	 nF5+Wjnp7cBXRaBvDFjdS4OeD+2qKawxOlAOoM4wbzrJ5B+SmQH9b3VwFd5UY/JeJmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044272;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rav6v48qD7cYLa24exBaWsIPllVCGyuXU88Mz1O+RVk=;
	b=cHB48U0g2YU/DciVs67JhBXbJgK/bVDkRNfAoHdtc2iU4Gffxp/9fjuemJDAiPd8K2DN
	 P6HpK/dmz72OM5gg07taB1ISGaPWHfxqPB86JpSzX17/qy4nxbwBy/T2Zb8WHqHsvKmpT
	 FJgP6DdKj6ZoFoyvKvyBe7lmnC9PBcP7cMNfzHnEj7OG36+KYdbjynU73gY0tPbik/8hS
	 LooCN8ZBzJBVSSyUAXCoxWkHKLYKGN9OYtAjZdYLzX1E2XXLuOlE+o/s+PuFvT1FVHWls
	 LGYGEzEVrRBnS+yZGjE5O1b1NPwgMAyIt2jY/6ZW5so6Wvf+1c2B3FUzwSOTV1SbSYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZAqmhA/H";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE660A262D;
	Wed, 18 Nov 2026 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZAqmhA/H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED031F000C9;
	Wed, 18 Nov 2026 23:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044271;
	bh=rav6v48qD7cYLa24exBaWsIPllVCGyuXU88Mz1O+RVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAqmhA/HQdNYmU+1yvuVKyC1fcm1QSrXThuSecwXI5wEDaJH9kh7hlrmH7CU6RXrv
	 vjUxq8XJJJi8lDRzSwCte3NahxmvRmt+EB7YfXyBa23wYjSeIxHbbTjLepf6Y18h3b
	 ZFefTmd3QWcXqYDT5a2MeKxp1JZHyj4J9xmMkpk1yIxyIF/CoEn3lvK6jat9eB5tF3
	 nT/Oxm8CflUNwYZrtfCKN5BytuE4dJOxLJ/TiM8u5Xeet9qF1M3Wd9YRc7aJKWuwC2
	 GCT5iy4Snfnmz34hiYeHV6ZfiVbcstrP/dcTHkSIX2P6KsJYPIKb/SzEY6II5Lo9S3
	 2DHBsMkfZq1yQ==
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
Subject: [PATCH net-next 5/8] eth: mlx5e: drop the now-dead HW-GRO and LRO vs XDP handling
Date: Wed, 18 Nov 2026 15:23:12 -0800
Message-ID: <20261118232315.3593731-6-kuba@kernel.org>
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

The core clears HW-GRO and LRO before ndo_bpf runs and keeps them off
for as long as a program is attached. mlx5e_fix_features() never sees
either with params->xdp_prog set, and packet merge is always off by the
time mlx5e_xdp_set() gets called, packet_merge.type only follows the two
feature handlers. If tcp-data-split keeps HW-GRO on, the core refuses
the attach with -EBUSY before calling the driver.

The AF_XDP check stays, the core doesn't know about XSK pools.

This does change user visible behavior: attaching XDP with HW-GRO or LRO
on used to fail with -EINVAL and now succeeds with them turned off.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 32 ++-----------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index d8563f863844..e462dfc725ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4585,17 +4585,6 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
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
@@ -5177,20 +5166,6 @@ static void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)
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
@@ -5215,10 +5190,9 @@ static int mlx5e_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
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
-- 
2.56.1

