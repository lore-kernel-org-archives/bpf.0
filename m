Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044273;
	b=c6x6A+qASyT1vx4A0ZYdA73lr3cbXlAemQcuR3iXmRHcWeAg0yPqbaV8nULjx2QMd8i0
	 eK0VUfMiWMQHjIEprMNFwn9CzIGi22GiRJKtL1ov/eZWtm4TIbltY8lchhDOSAO95cHIp
	 pswmxCCfTFDGFM1cYfXH0wW5ppjoLgcFaMKwHhswCHd7uBNrXgbrQW0U28fsge43LuDN3
	 OYsBOtSMOBX/TK8G7XAEf7gZex9GxutzYVr8MDc0++wOSuchUZ5D0XQMpynxJENDjKmvE
	 xAym6YoHodRyw2go6Vlt1lppbAfmWyOuo9ka+6jrKk3XuRmGVBGCihmbuT39VPkUR0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044273;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vi/WasS0CpRGjKcIMOrhTUSVMrXdYfJHtXqklKK25fA=;
	b=b6cju6mIIYtcW4MpdDs5vXAvw06v/de/0PPQ3akdKTRmXAMm9iKEyCG68TU6NG+V4Wmc
	 TrIou/5abtUdS578oRJqEgHR3ve52k2CTi9/scgZQk5HDOgaZog91bXbfioaamMUaqh6C
	 f9R/DY4RZln77O66PPDsbRQ/L6geBaECQY9a61vD2ZrhgxQw2Kx3wletit5hIjiGlxfVt
	 rCIhR8ZWs3k2EoE1I12J7WyGQ8vSMxIpUHjdhb7OfklrKBU/z4Cisz3U+GBYEBgoAR5tG
	 dkU9SmFLyrWJnsIcAXPQHn6VNKpfAvGnoPllTkjMo6cbJp8HKB3prVU4XMn6QrR5/Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg1N+8C4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719B60A2600;
	Wed, 18 Nov 2026 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg1N+8C4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06FC1F000C7;
	Wed, 18 Nov 2026 23:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044273;
	bh=vi/WasS0CpRGjKcIMOrhTUSVMrXdYfJHtXqklKK25fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lg1N+8C4AdGju8lTyYqQy6oHAEcYfiPJNE/XjFp4wemAwXezHm8OJDXHw4XwMkF7o
	 yxlDGiGeqx4HOp5UaeCHVlZlP76IKAbHftmleV77x/IIsOseP9Sc7MxELwz//KKOSz
	 oLbK8JWVKIu/GfTGGfRu+R7HIvFtYTtA42J0Am6ieRmzyB5myt9QUGUUgT5zf6NNlh
	 Q6DORxt3C1AGFym3QjbETQ33Zd2zL8hNgcZfUN7uJucHiZJ5r/lHOUFGAK/KC0+BsL
	 k2GtNmO3DSCySxe8PDRx74pSorVTq7oUlT1IP59CZ7omUlwsE901y6Oyx9lCaP9l9E
	 dLBvEoXZM2TQQ==
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
Subject: [PATCH net-next 7/8] eth: qede: drop the now-dead HW-GRO vs XDP handling
Date: Wed, 18 Nov 2026 15:23:14 -0800
Message-ID: <20261118232315.3593731-8-kuba@kernel.org>
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

The core clears HW-GRO before ndo_bpf runs and keeps it off for as long
as a program is attached, which makes three bits of qede dead:

 - the xdp_prog check in qede_fix_features();
 - qede_alloc_mem_rxq() clearing NETIF_F_GRO_HW from dev->features
   directly, the feature is already off by the time the reload for
   the program allocates the rings;
 - qede_set_features() skipping the reload when a program is attached,
   HW-GRO can't change while edev->xdp_prog is set any more.

The direct write in qede_alloc_mem_rxq() is also why HW-GRO used to
stay off after the program was removed - nothing recomputed the
features. The core does that on detach now.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/qlogic/qede/qede_filter.c | 11 ++---------
 drivers/net/ethernet/qlogic/qede/qede_main.c   |  1 -
 2 files changed, 2 insertions(+), 10 deletions(-)

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
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 7ed17faced54..b24baf0e808e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -1571,7 +1571,6 @@ static int qede_alloc_mem_rxq(struct qede_dev *edev, struct qede_rx_queue *rxq)
 		rxq->rx_buf_seg_size = roundup_pow_of_two(size);
 	} else {
 		rxq->rx_buf_seg_size = PAGE_SIZE;
-		edev->ndev->features &= ~NETIF_F_GRO_HW;
 	}
 
 	/* Allocate the parallel driver ring for Rx buffers */
-- 
2.56.1

