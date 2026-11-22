Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309280;
	b=vbg+ZOejhx1GMCB7wHNdvPM9cTburMXQa+N4YmQeEg6w8k7bsOrW/ahD1aigTpGXr0Hi
	 Qvyy+MN04YDcH2vymyu4I6sMj1IWxwUQNhZhpMwwTUhJhSMQ9Y9oiHE5m66PF9tN95kys
	 UxYGl/uTQ1hh+D1TTKVAPH6gFFcig6aep1wdStUGmAgeDoIyMev5mjzrM98P5vuhWdKTV
	 m1jEsR/gYtKohdZlAA3lfKdFwzZzZMtJ1TakrQaLZwh1K7xIYFCT5LXwpNVbVC/5KNGb5
	 bEfVLDyPVFAm+4pAPwb8hV/O0S2nrP18aY1D1kEEYJdK9rJjUMl0+XxjHcVHoUJH4Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309280;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=quVP7eFuOB6NCi/gMfUaz9aG5iZL2P/TFfQvezix6f0=;
	b=eKD93FBbIh5NQ9OMr6ibgF9+jFDe8YMtIOFkNObruVsxMAdjGu1aG6J/mwbYgovJjyhA
	 78dX71Kp2bwdAIblDd4ZQ4o+cYw1LdqEodx/LkKmJTmBfHnOgcPhRxZmx9WuTDiFVODfB
	 7n4z0PHxdYjneEREJDXLTs+B5jX+nKvqdofcpOvhfi+ygdDcl+aulmDAgBoSKURhVhp+F
	 mclIRyAmy/8qvOJvyN9x8ItwP0bN9J4BKJhEaQdRWTlrs838DNP8JF1qLgLbV/io/NXw3
	 f/JETygCpGef+WYyNVdUvx33O3BvcrSP1FR1mXbdCQJd9PhN2PWtwURHG2/WGsVv1HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqAmX3sm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5D1606A68C;
	Sun, 22 Nov 2026 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqAmX3sm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7371F000D8;
	Sun, 22 Nov 2026 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795309280;
	bh=quVP7eFuOB6NCi/gMfUaz9aG5iZL2P/TFfQvezix6f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YqAmX3smMMsbUMC+CDRI1AIv2gscCDdWBtyKKFtNs+kgRrITQFXTBwevU0FLgqxh5
	 956/CmEHV2fx/mA2dj1e37OZwFkqLTGmB7Q+g4f1HU30K8YOrwC/drnszhNU6fpNB8
	 6eZcCbngSK4n09d2m8YI7k7ONeOvWyiU4rlpfD5DaB3om3rv36dj5d+rPerVC5tgPH
	 qf7UEKue4R519F92HCOHhjwhcICji5nD3nJbttAZmdAXDfgQilAtkK1Yg32Yvl27HS
	 Wp8eGDZ3B2aOYdaDgQFuY7r+UslTWRVzEQzn376h5uz3vTX5kNVrH0OYpqT+XP3K3n
	 tjZq128jiZNyA==
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
Subject: [PATCH net-next v2 4/9] net: state the "XDP excludes HW-GRO" rule in the core
Date: Sat, 21 Nov 2026 17:01:07 -0800
Message-ID: <20261122010112.1471146-5-kuba@kernel.org>
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

XDP has to see the frames as the wire delivered them, so HW-GRO must be
off while a program is attached. Drivers currently open-code that policy,
and they diverge: mlx5, gve and virtio_net refuse the attach, bnxt and
qede clear the feature from ndo_fix_features(), and idpf does nothing
at all and happily runs RSC under XDP.

Clear HW-GRO in __netdev_update_features(), and make sure XDP setup
paths refresh the features.

Take extra care to make sure the disablement actually works, some
drivers add the feature back in ndo_fix_features, even when removed
from wanted features (mlx5 does for header-data-split).

This change also removes the warn-only check dev_disable_gro_hw()
performed. On mlx5 with tcp-data-split on, attaching a multi-buf
generic XDP program reached generic_xdp_install(), whose
dev_disable_gro_hw() cleared wanted_features, recomputed, saw
mlx5e_fix_features() put NETIF_F_GRO_HW straight back, and splatted:

  ------------[ cut here ]------------
  netdevice: eth0: failed to disable GRO_HW!
  WARNING: net/core/dev.c:1880 at generic_xdp_install+0x135/0x190, CPU#53: ip/667
  RIP: 0010:generic_xdp_install+0x17a/0x190
  Call Trace:
   <TASK>
   dev_xdp_install+0x2aa/0x380
   dev_xdp_attach+0x41f/0x460
   dev_change_xdp_fd+0xbb/0x110
   do_setlink+0xfb9/0x1030
   rtnl_newlink+0x9f5/0xaf0
   rtnetlink_rcv_msg+0x442/0x490
   netlink_rcv_skb+0x16a/0x1a0
   netlink_unicast+0x1fc/0x320
   netlink_sendmsg+0x2d6/0x380

and then attached anyway, leaving XDP looking at coalesced frames.
The device also lost the bit from wanted_features for good, so HW-GRO
never came back after detach - on mlx5 that took header-data split
with it, and with it devmem and io_uring zero-copy Rx.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2: no change
v1: https://lore.kernel.org/20261118232315.3593731-4-kuba@kernel.org
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  6 ++
 net/core/dev.c                                | 97 ++++++++++++++-----
 3 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 7620d3fcb8dc..25cf02a184ec 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -169,6 +169,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
+unsigned_long:1                     xdp_pending
 unsigned_long:1                     xdp_from_upper
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0325c6f2a7d1..049538b13e61 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2531,6 +2531,12 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	/**
+	 * @xdp_pending: an XDP program is being installed, but is not in
+	 *	@xdp_state yet. Most users should access it implicitly via
+	 *	helpers like dev_xdp_prog_count(), rather than directly.
+	 */
+	unsigned long		xdp_pending:1;
 	/**
 	 * @xdp_from_upper: the program in @xdp_state was installed by an
 	 *	upper device with netif_xdp_propagate(); it belongs to the
diff --git a/net/core/dev.c b/net/core/dev.c
index 4ca8a9f5a7a5..5d38cdb6c326 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1902,23 +1902,6 @@ void netif_disable_lro(struct net_device *dev)
 	}
 }
 
-/**
- *	dev_disable_gro_hw - disable HW Generic Receive Offload on a device
- *	@dev: device
- *
- *	Disable HW Generic Receive Offload (GRO_HW) on a net device.  Must be
- *	called under RTNL.  This is needed if Generic XDP is installed on
- *	the device.
- */
-static void dev_disable_gro_hw(struct net_device *dev)
-{
-	dev->wanted_features &= ~NETIF_F_GRO_HW;
-	netdev_update_features(dev);
-
-	if (unlikely(dev->features & NETIF_F_GRO_HW))
-		netdev_WARN(dev, "failed to disable GRO_HW!\n");
-}
-
 const char *netdev_cmd_to_name(enum netdev_cmd cmd)
 {
 #define N(val) 						\
@@ -6657,7 +6640,6 @@ static int generic_xdp_install(struct net_device *dev, struct netdev_bpf *xdp)
 		} else if (new && !old) {
 			static_branch_inc(&generic_xdp_needed_key);
 			netif_disable_lro(dev);
-			dev_disable_gro_hw(dev);
 		}
 		break;
 
@@ -10576,7 +10558,7 @@ u8 dev_xdp_prog_count(struct net_device *dev)
 	for (i = 0; i < __MAX_XDP_MODE; i++)
 		if (dev->xdp_state[i].prog || dev->xdp_state[i].link)
 			count++;
-	return count;
+	return count ?: !!dev->xdp_pending;
 }
 EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
 
@@ -10617,6 +10599,32 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
 	dev->xdp_state[mode].prog = prog;
 }
 
+/* Try to clear HW-GRO before the driver reconfigures for XDP.
+ * Driver may add features back in via ndo_fix_features(), due to feature
+ * dependencies. In that case we can't run XDP at all.
+ */
+static int dev_xdp_clear_rx_agg(struct net_device *dev,
+				struct netlink_ext_ack *extack)
+{
+	if (!(dev->features & NETIF_F_GRO_HW))
+		return 0;
+	if (!(dev->hw_features & NETIF_F_GRO_HW)) {
+		NL_SET_ERR_MSG(extack,
+			       "unable to disable HW-GRO, fixed on");
+		return -EOPNOTSUPP;
+	}
+
+	netdev_update_features(dev);
+
+	if (dev->features & NETIF_F_GRO_HW) {
+		NL_SET_ERR_MSG(extack,
+			       "unable to disable HW-GRO, required by another feature");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
 	struct bpf_prog *old_prog;
@@ -10650,11 +10658,17 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 				       "unable to propagate XDP to device using memory provider");
 			return -EBUSY;
 		}
+
+		dev->xdp_pending = 1;
+
+		err = dev_xdp_clear_rx_agg(dev, bpf->extack);
+		if (err)
+			goto err_clear_pending;
 	}
 
 	err = dev->netdev_ops->ndo_bpf(dev, bpf);
 	if (err)
-		return err;
+		goto err_clear_pending;
 	if (bpf->prog)
 		bpf_prog_inc(bpf->prog);
 
@@ -10667,11 +10681,22 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	old_prog = dev_xdp_prog(dev, XDP_MODE_DRV);
 	bpf_prog_change_xdp(old_prog, bpf->prog);
 	dev_xdp_set_prog(dev, XDP_MODE_DRV, bpf->prog);
+	dev->xdp_pending = 0;
 	dev->xdp_from_upper = !!bpf->prog;
-	if (old_prog)
+
+	if (old_prog) {
 		bpf_prog_put(old_prog);
+		/* The last program is gone, HW-GRO may be available again */
+		if (!bpf->prog)
+			netdev_update_features(dev);
+	}
 
 	return 0;
+
+err_clear_pending:
+	dev->xdp_pending = 0;
+	netdev_update_features(dev);
+	return err;
 }
 EXPORT_SYMBOL_GPL(netif_xdp_propagate);
 
@@ -10880,19 +10905,36 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			return -EOPNOTSUPP;
 		}
 
+		if (new_prog) {
+			dev->xdp_pending = 1;
+			err = dev_xdp_clear_rx_agg(dev, extack);
+			if (err)
+				goto err_clear_pending;
+		}
+
 		err = dev_xdp_install(dev, mode, bpf_op, extack, flags, new_prog);
 		if (err)
-			return err;
+			goto err_clear_pending;
 	}
 
 	if (link)
 		dev_xdp_set_link(dev, mode, link);
 	else
 		dev_xdp_set_prog(dev, mode, new_prog);
-	if (cur_prog)
+	dev->xdp_pending = 0;
+	if (cur_prog) {
 		bpf_prog_put(cur_prog);
+		/* The last program is gone, HW-GRO may be available again */
+		if (!new_prog)
+			netdev_update_features(dev);
+	}
 
 	return 0;
+
+err_clear_pending:
+	dev->xdp_pending = 0;
+	netdev_update_features(dev);
+	return err;
 }
 
 static int dev_xdp_attach_link(struct net_device *dev,
@@ -10918,6 +10960,7 @@ static int dev_xdp_detach_link(struct net_device *dev,
 	bpf_op = dev_xdp_bpf_op(dev, mode);
 	WARN_ON(dev_xdp_install(dev, mode, bpf_op, NULL, 0, NULL));
 	dev_xdp_set_link(dev, mode, NULL);
+	netdev_update_features(dev);
 	return 0;
 }
 
@@ -11390,6 +11433,14 @@ int __netdev_update_features(struct net_device *dev)
 
 	features = netdev_get_wanted_features(dev);
 
+	/* GRO_HW may be added back in via ndo_fix_features e.g. if driver needs
+	 * it to honor the HDS config, clear it before the fix features call.
+	 */
+	if ((features & NETIF_F_GRO_HW) && dev_xdp_prog_count(dev)) {
+		netdev_dbg(dev, "Dropping HW-GRO feature since XDP is attached.\n");
+		features &= ~NETIF_F_GRO_HW;
+	}
+
 	if (dev->netdev_ops->ndo_fix_features)
 		features = dev->netdev_ops->ndo_fix_features(dev, features);
 
-- 
2.56.1

