Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044274;
	b=hJVODXeJsBL+aaFOiqk1yWat+2/oOae+KN8fi3eLHLcdFFHGxyDhsQ6oK24jJMcaov/J
	 UOj0u1B3m8y7FKtsrjIEM+lwO1eD8+KzVVTlZaAAOaQMtH85cHWeid9XqGUC2fn5ioS5Y
	 kRHrE78Oaw+pPEq52cOq1/fPsmtVKyy8xSp8vCt1R2TINM0CJqjdyZPEtdBGfZpng8767
	 4v65GI0NzXQyEE5rWlobEhMpdsjy6mF8VYWTwYYAz8eNYPEInJpVZbG5k7Y4z7jhAcqmV
	 4hE+b6URGUEW/S8ZzvWCiKPlBJyTnsGWyOoOmi44nWcCDb3gs8XJCpKPsnzr5rVaiNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fgsdcO4ceTyInzcJdtVRddqvxepwU6JaTVCwA65yP7w=;
	b=p8cqZ+X1cipbpHyDNdrJ79ahJqW6DFkr+Ex/vbci3oDmSzeE0RxFbh0wp8r6Z2Inr5HV
	 M5hGi/Eqr9iqZ1C9IqWa7rp35i3j2AZJpHL3dV0JBhrjv9zaJTrLqrvANfNRs40cascYA
	 dM95kHd67pv4BN8GaHmDj5Gut89pa1+GytphM5PxQP3an3qy5Vgm8Rk3GT1Cdau3ywc1A
	 WTIBGgT4Q6DELhgmIPjgB8St1/+9aj48FOnMxkIsmbdX5c5euHlb6PpM/5oZ6mkc1IGBI
	 4c6KNmFvmKx61GjH2fCxO/H9ET3K/TwglqBOsdGuLPS9HsoiwnQa2P040vd9RWGu/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkdr8mb5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7A60A2611;
	Wed, 18 Nov 2026 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nkdr8mb5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E2F1F000CC;
	Wed, 18 Nov 2026 23:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044274;
	bh=fgsdcO4ceTyInzcJdtVRddqvxepwU6JaTVCwA65yP7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nkdr8mb549Xvw8Qr7KmixcWkI3liQ4mGasVtS3awitJ/p4806gxUH6gfG+KbXOM/+
	 jHpb+oe3IKkPGCs4elrOSG6BdIC5f2ohtq/ildJhzBEJ1sIvewN2llaOd5KVig4NEI
	 bQUa9+Hy10Hg+rCIxy3EakmIu1+6kYAit9ocN8/6TvKVwmzh90xjaGYxKtuJU/KjSJ
	 vp/haQClNMYl3Aogr8VtzmlgFVVLKcXscUItmt9VjwpjIUivXtL8+6bnE8uCZaoSFQ
	 03NxoyyemxYadHMoPAlC+MF4yQRgnrMAkO/RJWdwCf9H+1SHI5QvbnJzZxm0lTw+wj
	 EJfsciKm+TgJw==
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
Subject: [PATCH net-next 8/8] eth: gve: drop the now-dead HW-GRO vs XDP interlock
Date: Wed, 18 Nov 2026 15:23:15 -0800
Message-ID: <20261118232315.3593731-9-kuba@kernel.org>
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

The core clears NETIF_F_GRO_HW before ndo_bpf runs and refuses to turn
it back on while a program is attached, so neither of these can fire
any more. That holds for a program an upper device pushes down as well,
which is why this comes last - gve_verify_xdp_configuration() was the
only thing standing between a bonded gve port and XDP running with RSC
still on.

The user visible behavior changes as intended: attaching XDP to a gve
device with HW-GRO on used to fail with -EOPNOTSUPP and now succeeds
with HW-GRO turned off, which is what bnxt and qede have always done.
The header-data split refusal right below keys off
priv->header_split_enabled and stays.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/google/gve/gve_main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 0ee69bc11d83..8b65b8119662 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1798,12 +1798,6 @@ static int gve_verify_xdp_configuration(struct net_device *dev,
 	struct gve_priv *priv = netdev_priv(dev);
 	u16 max_xdp_mtu;
 
-	if (dev->features & NETIF_F_GRO_HW) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "XDP is not supported when HW-GRO is on.");
-		return -EOPNOTSUPP;
-	}
-
 	if (priv->header_split_enabled) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "XDP is not supported when header-data split is enabled.");
@@ -2212,12 +2206,6 @@ static int gve_set_features(struct net_device *netdev,
 	if ((netdev->features & NETIF_F_GRO_HW) !=
 	    (features & NETIF_F_GRO_HW)) {
 		netdev->features ^= NETIF_F_GRO_HW;
-		if (priv->xdp_prog && (netdev->features & NETIF_F_GRO_HW)) {
-			netdev_warn(netdev,
-				    "HW-GRO is not supported when XDP is on.");
-			err = -EOPNOTSUPP;
-			goto revert_features;
-		}
 		if (netif_running(netdev)) {
 			err = gve_adjust_config(priv, &tx_alloc_cfg, &rx_alloc_cfg);
 			if (err)
-- 
2.56.1

