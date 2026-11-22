Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309281;
	b=mINqom4vp/MIZpD5DhqDReiz2NagJ3r7bI8x3G5GkeTFyZ4vvE4MeZ+lAW/lItfQqxyS
	 CYPV7s1blXVFA0CUU5RGPi6bFjfIDCLilXrZRnnCdyW0bkKkR0CRi+tFlErmESZzYH8nh
	 tfQmnOyK/X2e7qf9s6f4yeo3n/5oQi0wSaWnFbVt9MaqxjpkyI3G0ov+JeiDqBu3oK7yr
	 bgZy0wn+XCumK3ROKl5RzgjoDNVMYUW+9hKohNMtjz4ajEHrFy06Sqki6gxP0jM3BqxdB
	 LucFyl/Wotxp9kFNgpCRBRFKPog5rjBl69Mp/uFFqVV+0ncvr3YUlA2xXPatgw5PSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bFEqN5x1u6mmqUn7tga+YGKoxU+qbiuPE3EXrlE1dd0=;
	b=WFOpBX1uJu6sL9lFhHliBAB9LgcknTRNExZqrCXpXAIJVyPSBfNCNeKgxt9C3tyo1Rpi
	 y1V0f7R9OUiiXjzGRjZL9BpjDI1lhvAQYvv3UC00sqYcEfFz7ElD6YU5aXdvMsPCxskFJ
	 P/rFXRSkTd+1gjHQ1lmjoVjjXhV+Fbw1qy1QSF96pX1SRTTMpYV+Nf3E5QyDFY2cq/eAr
	 3tBj44EEhhBebAZiwti578HYzAFiyFTvloC2EnLNZxVWpCYcoVt8N10D/ZvNHhouPZh3K
	 HNTdB5wsuNzoFcBbxumOLVhDdP/27O/434VPP75p8w1NR08sKsr2I4tqUYyd4StQSdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPgAYALZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505E606A6A6;
	Sun, 22 Nov 2026 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPgAYALZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6B21F000E0;
	Sun, 22 Nov 2026 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309281;
	bh=bFEqN5x1u6mmqUn7tga+YGKoxU+qbiuPE3EXrlE1dd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPgAYALZ5/G6ArhRNo1BYhdTbq8j1B398v2u8pw1/DezVEkqKlQuaMZEt4MoCLBZs
	 mL21z7HEq7l/GyUA4S6pm6wDab4UM7HxRgmeCQOP8lUnNHITE0LJb+Sq4oZXad0dZF
	 YuyKErCpug+cQWtFOey1nAKh2o1gzF19K+Pn0qmCj50Yt5lO2wYZEe36RzZbkkykKQ
	 70GP+b7YrEVGqgaiGkjKsLgRFCETTVdY05JN07i9ua/XX5Mya5lt1pTAVkQp9il0WB
	 7kriMAGPmrvbbCt8uGuAFjdPG5+psLJVwHmZLd1YbcyJ55PxlcmYoTzbYqOil7kn6R
	 dltIwxIEYbGTw==
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
Subject: [PATCH net-next v2 5/9] net: state the "XDP excludes LRO" rule in the core
Date: Sat, 21 Nov 2026 17:01:08 -0800
Message-ID: <20261122010112.1471146-6-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no change
v1: https://lore.kernel.org/20261118232315.3593731-5-kuba@kernel.org
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
index 5d38cdb6c326..308501d384b6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6639,7 +6639,6 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 			static_branch_dec(&generic_xdp_needed_key);
 		} else if (new && !old) {
 			static_branch_inc(&generic_xdp_needed_key);
-			netif_disable_lro(dev);
 		}
 		break;
 
@@ -10599,26 +10598,35 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
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
 
@@ -10686,7 +10694,7 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 
 	if (old_prog) {
 		bpf_prog_put(old_prog);
-		/* The last program is gone, HW-GRO may be available again */
+		/* No program left, HW-GRO and LRO may be available again */
 		if (!bpf->prog)
 			netdev_update_features(dev);
 	}
@@ -10924,7 +10932,7 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	dev->xdp_pending = 0;
 	if (cur_prog) {
 		bpf_prog_put(cur_prog);
-		/* The last program is gone, HW-GRO may be available again */
+		/* No program left, HW-GRO and LRO may be available again */
 		if (!new_prog)
 			netdev_update_features(dev);
 	}
@@ -11436,9 +11444,9 @@ int __netdev_update_features(struct net_device *dev)
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

