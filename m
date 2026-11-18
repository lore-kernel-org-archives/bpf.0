Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795044271;
	b=2IsWVH5CrMPyMi/JrHljpsqeaCpr8YtAL2SqT2HO//zQhN4ZW0vd6upaFd3gqu6mstIH
	 br06I/kR5P+zfiX3kAJoDj1eTY4MnevIbUzLP3z9KJcdLjykqvZf7ZNpWTAW+zTFYAOLL
	 eCPanaoyFtJXndqJx+q6dcYNwHux/VwynKIfRPaNqq9w1kbr8HhejUO+ooj2Z/YZzhqhS
	 v7AQ+7Q1Oroqc5p2/NIxYMfAi8y77yG7cxfDc7jWrcn7+VLTtC1RkvGz43CCXhergUxAk
	 Evu3J8w1ou8l7A5MCkFCyYG1VuG1oNvYDUa3368WXGwzhHLMkRytnlIVvmyEKjhp0hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2cX+33nV+FJfyCFvhyskkQZjXGS54FWoUvMVnP4tcYU=;
	b=cW2UHK0YXUF5pTYxSvLj62Kb051HMYrgmISvqtgU349cI79scYmEP2OZg2l6+gKNkQuZ
	 1pkpFl4CHFxMl0BbxZahDY/n0bdxeW0I1JsLiajozmRu9Nr5EFekLdRooM8Qu9FoLPDLL
	 /uXid+it6zkhBBQzka0FjFDGvQcxDc8ceRM8lDQjT1o7iX2cvW4mN4CWBblwoO+UwYj2G
	 ubBJl/0lheKab8V/DHTnTOyrfFDvmcq+WkyYVR5CfD86bxaiYhN5OWCgrM8qabQQdluyL
	 sNnQbSn0kg+SkWDpubCi7Jcfvhe1Mg/SMEPsf5c2/wUeIOFoC8Xztyfm8vjwSwQvbmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cWx8/nkd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EE60A260B;
	Wed, 18 Nov 2026 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWx8/nkd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77501F000CF;
	Wed, 18 Nov 2026 23:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795044271;
	bh=2cX+33nV+FJfyCFvhyskkQZjXGS54FWoUvMVnP4tcYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cWx8/nkdnJ3QZmy3m7Fy0XemfkN3/vdfK3XEmKnlyF0BcoUWeJDeU2LQdihxaeu5B
	 SBrCGVqPgoWjIuIMdXMUEw6DbeBtZq+I8bt2slQQ6cREwFXei1z43cEaGFi6b25nPy
	 6YLFKM96dOsQ+KzuZcV10ReOFN85MYm33lRcBtKg/orGy575AV0LknV2pYwHA1FIRj
	 uCAT3RoZMTFmCofCWPqwwGylbZdHtDULaWk1moHvZi63h5DZq2gNZN9o7bTFYu3rV1
	 OJ9aiJXwsbonOJ9z3M5t9tD1iQi0aNdvDFbe8NWWXgU9ZfpSZ3La1fc9PEkCP9AGNx
	 hJwF9oo7P/ADA==
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
Subject: [PATCH net-next 4/8] net: state the "XDP excludes LRO" rule in the core
Date: Wed, 18 Nov 2026 15:23:11 -0800
Message-ID: <20261118232315.3593731-5-kuba@kernel.org>
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

LRO is the older take on the same thing as HW-GRO. And similarly to
HW-GRO XDP cannot be handed post-LRO frames. Drivers open-code
the exclusion just like they did for HW-GRO, and disagree just the
same: mlx5 and netvsc refuse the attach, bnxt and ixgbe clear the feature
from ndo_fix_features(), vmxnet3 writes dev->features behind the core's
back, and atlantic only minds single-buffer programs. Clear LRO next to
HW-GRO, with the same ordering and the same refusal if a driver insists
on keeping it.

atlantic loses LRO under a multi-buffer program now as well. XDP_TX and
redirect can't carry the GSO metadata of a coalesced frame, however
many buffers it spans.

Drop netif_disable_lro() from generic_xdp_install(), like the previous
patch dropped dev_disable_gro_hw(). The core covers the device itself,
and LRO no longer stays off after the detach.

This changes the behavior for lower devices. netif_disable_lro() walked
them, dev_disable_gro_hw() never did. And unlike HW-GRO, LRO is in
NETIF_F_UPPER_DISABLES, an upper which loses it clears it from the
wanted_features of its lowers for good. bond and team carry LRO only to
hand it down, so a program on a bond still turns LRO off on the slaves,
and they don't get it back after the detach. Making sure lowers don't
coalesce is a separate problem, for HW-GRO and LRO alike.

LRO state with the program [attached / after it's detached], netdevsim
as the single device, bond of two vmxnet3 ports:

  program on    device   w/o patch    w/ patch
  ------------  -------  -----------  ---------
  dev, native   dev      on  / on `1  off / on
  dev, generic  dev      off / off    off / on
  bond, native  bond     on  / on     off / on
                slaves   off / off`2  off / off
  bond, generic bond     off / off    off / on
                slaves   off / off    off / off

 `1 netdevsim ignores LRO under XDP, real drivers turned it off one
    way or another
 `2 vmxnet3 clears LRO from dev->features by itself and nothing turns
    it back on, bnxt slaves would get it back

Ideally we'd want [off / on] (XDP disables LRO, LRO comes back once
XDP is cleared). But the two "off"s after detach on slaves are not
worth the complexity IMHO.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdev_features.h |  6 ++++++
 net/core/dev.c                  | 36 ++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 8eb6b8033606..62a05df8ee68 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -234,6 +234,12 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
  */
 #define NETIF_F_UPPER_DISABLES	NETIF_F_LRO
 
+/*
+ * Receive offloads which coalesce frames. XDP has to see the frames as the
+ * wire delivered them, so these are disabled while a program is attached.
+ */
+#define NETIF_F_XDP_DISABLES	(NETIF_F_GRO_HW | NETIF_F_LRO)
+
 /* changeable features with no special hardware requirements */
 #define NETIF_F_SOFT_FEATURES	(NETIF_F_GSO | NETIF_F_GRO)
 
diff --git a/net/core/dev.c b/net/core/dev.c
index c0bb5eb9fdea..2b9c7aac0969 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6634,7 +6634,6 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 			static_branch_dec(&generic_xdp_needed_key);
 		} else if (new && !old) {
 			static_branch_inc(&generic_xdp_needed_key);
-			netif_disable_lro(dev);
 		}
 		break;
 
@@ -10594,26 +10593,35 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
 	dev->xdp_state[mode].prog = prog;
 }
 
-/* Try to clear HW-GRO before the driver reconfigures for XDP.
+static const char *dev_xdp_rx_agg_name(netdev_features_t features)
+{
+	return features & NETIF_F_GRO_HW ? "HW-GRO" : "LRO";
+}
+
+/* Try to clear HW-GRO and LRO before the driver reconfigures for XDP.
  * Driver may add features back in via ndo_fix_features(), due to feature
  * dependencies. In that case we can't run XDP at all.
  */
 static int dev_xdp_clear_rx_agg(struct net_device *dev,
 				struct netlink_ext_ack *extack)
 {
-	if (!(dev->features & NETIF_F_GRO_HW))
+	netdev_features_t agg = dev->features & NETIF_F_XDP_DISABLES;
+
+	if (!agg)
 		return 0;
-	if (!(dev->hw_features & NETIF_F_GRO_HW)) {
-		NL_SET_ERR_MSG(extack,
-			       "unable to disable HW-GRO, fixed on");
+	if (agg & ~dev->hw_features) {
+		NL_SET_ERR_MSG_FMT(extack, "unable to disable %s, fixed on",
+				   dev_xdp_rx_agg_name(agg & ~dev->hw_features));
 		return -EOPNOTSUPP;
 	}
 
 	netdev_update_features(dev);
 
-	if (dev->features & NETIF_F_GRO_HW) {
-		NL_SET_ERR_MSG(extack,
-			       "unable to disable HW-GRO, required by another feature");
+	agg = dev->features & NETIF_F_XDP_DISABLES;
+	if (agg) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "unable to disable %s, required by another feature",
+				   dev_xdp_rx_agg_name(agg));
 		return -EBUSY;
 	}
 
@@ -10681,7 +10689,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	if (old_prog) {
 		bpf_prog_put(old_prog);
-		/* The last program is gone, HW-GRO may be available again */
+		/* No program left, HW-GRO and LRO may be available again */
 		if (!bpf->prog)
 			netdev_update_features(dev);
 	}
@@ -10919,7 +10927,7 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	dev->xdp_pending = 0;
 	if (cur_prog) {
 		bpf_prog_put(cur_prog);
-		/* The last program is gone, HW-GRO may be available again */
+		/* No program left, HW-GRO and LRO may be available again */
 		if (!new_prog)
 			netdev_update_features(dev);
 	}
@@ -11431,9 +11439,9 @@ int __netdev_update_features(struct net_device *dev)
 	/* GRO_HW may be added back in via ndo_fix_features e.g. if driver needs
 	 * it to honor the HDS config, clear it before the fix features call.
 	 */
-	if ((features & NETIF_F_GRO_HW) && dev_xdp_prog_count(dev)) {
-		netdev_dbg(dev, "Dropping HW-GRO feature since XDP is attached.\n");
-		features &= ~NETIF_F_GRO_HW;
+	if ((features & NETIF_F_XDP_DISABLES) && dev_xdp_prog_count(dev)) {
+		netdev_dbg(dev, "Dropping HW-GRO and LRO features since XDP is attached.\n");
+		features &= ~NETIF_F_XDP_DISABLES;
 	}
 
 	if (dev->netdev_ops->ndo_fix_features)
-- 
2.56.1

