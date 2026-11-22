Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309283;
	b=G0vw8cPqHo0JxsvOelWUenV3VtLOfuA7sdhy2LU/EUk9mjFuDTPadCN3SSLr5MBw1Yvu
	 NKGGLZyljcL+uTW4sDEmmOY8m4q/8zG3EV1VfPazUAbWYi3WDVnbSIQeMH4ZlgZlTXSRq
	 93GkVhQ2wwacDRJ2Ifw//ziXMNSU6xVIbUhTobqA0vXLpB7BDBs0nRaNzhoiK6l3E8uzT
	 Wdfk9vM3muZJSazVhUyyTWHQFq6Yuf/iaUrr88PP/EZXjyGKxGIoqFjlvIb94iAQhQX3g
	 LHQsI49lT8xpdgqasoVi6AxIHKCFjLz1tvvA5SwhA9H65eJvb+yCmADs8xTGib9Pptg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+tP7aLEqgrF6Dk34MyWOjGQHbDw+6X3cY1fgK9v3OcA=;
	b=mxBmHQmuvhYVBvhKGhk46S5GN4sumpet/3cX0jIdKdgBZ0s39sgzwKgh64dZOvZSbW6Q
	 xlau/xwv8ENEJ/VykJvrmJtIUXuL18OYH7abft1QPk5H3/bzigZ2uAa+vX8S+XmJVJhDf
	 1X25hyeVQEWJjARy+CWyuGMYOhXcccFTncCBnwYwYWPVWNxn7/CJ+MrAGq4eyc6kC6dFP
	 ia67zRb4qNYef21L2jJd475OGBcVEy+emtyi98JmQUY/AYAHR5kd7BtE6hE1tOPU/3Umr
	 bxuNk9K/BSKznC6QjYDYWoLASnHlI4CwzWtS5XZ1bHuRI+4eiFbmYxP1kDIrHlBx2bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISUqcG6e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F570606A690;
	Sun, 22 Nov 2026 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ISUqcG6e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984C71F000C0;
	Sun, 22 Nov 2026 01:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309283;
	bh=+tP7aLEqgrF6Dk34MyWOjGQHbDw+6X3cY1fgK9v3OcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ISUqcG6eRgkVab+M2uBYKVpli3cBKQFb7+UDNgU87QYDF2YNfkpzuqDfP/ZFaD8lB
	 Mr8a7dmdF7Ywy9E9oqn/I/YmNZYUIEtO47lo1jHAVjHORtcyjupCSyR9WNYrxvzfch
	 mI9IPRIK4NwMTyYs4gYoagssI83QZMdTsGty605NR8qHTIjdzx/n7v3C75dGRcPEae
	 xOv3sD8M1G960VSa9/sZtD3AT8a2/JYzJtx7GssFwri8PIMU5ywFxupkHYj04WqU20
	 zGz/RrH8xSSfZ9QcsINQHB0GXlKaf5nWE7DAhheJH2Rf+QoUKmOaFqE1Pg4NZ9RTIk
	 fCS1LxvtkMSeQ==
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
Subject: [PATCH net-next v2 8/9] eth: qede: drop the now-dead HW-GRO vs XDP handling
Date: Sat, 21 Nov 2026 17:01:11 -0800
Message-ID: <20261122010112.1471146-9-kuba@kernel.org>
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

The core clears HW-GRO before ndo_bpf runs and keeps it off for as long
as a program is attached, which makes two bits of qede dead:

 - the xdp_prog check in qede_fix_features();
 - qede_set_features() skipping the reload when a program is attached,
   HW-GRO can't change while edev->xdp_prog is set any more.

qede_alloc_mem_rxq() clearing NETIF_F_GRO_HW from dev->features directly
has to stay. Firmware recovery re-runs qede_init_ndev(), which rewrites
dev->features with HW-GRO on, and nothing recomputes them. The direct
write no longer leaves HW-GRO off after the program is removed, the core
recomputes the features on detach.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - keep clearing NETIF_F_GRO_HW in qede_alloc_mem_rxq(), FW recovery
   needs it
v1: https://lore.kernel.org/20261118232315.3593731-8-kuba@kernel.org
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index d0e203167e35..9c68579c5b33 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -915,7 +915,7 @@ netdev_features_t qede_fix_features(struct net_device *dev,
 {
 	struct qede_dev *edev = netdev_priv(dev);
 
-	if (edev->xdp_prog || edev->ndev->mtu > PAGE_SIZE)
+	if (edev->ndev->mtu > PAGE_SIZE)
 		features &= ~NETIF_F_GRO_HW;
 
 	return features;
@@ -936,15 +936,8 @@ int qede_set_features(struct net_device *dev, netdev_features_t features)
 		args.u.features = features;
 		args.func = &qede_set_features_reload;
 
-		/* Make sure that we definitely need to reload.
-		 * In case of an eBPF attached program, there will be no FW
-		 * aggregations, so no need to actually reload.
-		 */
 		__qede_lock(edev);
-		if (edev->xdp_prog)
-			args.func(edev, &args);
-		else
-			qede_reload(edev, &args, true);
+		qede_reload(edev, &args, true);
 		__qede_unlock(edev);
 
 		return 1;
-- 
2.56.1

