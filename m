Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E402391853;
	Mon, 28 Sep 2026 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635012; cv=none; b=P4383raE4qlgTJRuXDJhic7QeYffHvt0temS4sQqtUhSygFv6o78S2hNDuTBhOCWnyJEebmqsLEDotLUwfFqtlZUVWKSY8QBU/Ms6E9z/TIyIQ1x9MprvPJEqEBA15/5+7zmHiXrsDdX19YSS51sqt9xISQYB2h2umPtcspyU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635012; c=relaxed/simple;
	bh=G2Y7pbmvU8146v907vw1zTOyt9dL0MtZDpMzoQBpk+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGbhct/yZe5sA09ZjP3JFTCEZnSEPu+HoCKNrVAj3yY2n6x4iJubXEqIxJUFlQ/m8NrwOtGhd/StpGN5FrOD2GjlLPQBuaFiZZrKcdieB7sR0JcNdizycFvgZgS/qYhyzyOBcW0Y2+8NKII9nBXHBlSrBjue00sMkIek++Kx92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwsN+dYc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwsN+dYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA961F00898;
	Mon, 28 Sep 2026 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635011;
	bh=HSYyPdpjYHI/b0wdGZwoyvmy2hkBppxxjzPayDgOX/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MwsN+dYcZWsS6TPVzGdFDSrhyAOBxncIC/LJuroFWgfjQProJHZnGTFgZByIFsdjo
	 az6jsKigT57GpR7aVNYW/Qvwd+VVBzKV7S/yqB8fuvenuNRrp/iPv28A5SRT3CuEoI
	 BIIQRKCADmGbCaD1uUg+irD/2ceJ5v41z8brUcWyUKu3Hub260zRA4qvspD8QFEVj7
	 OnTC7IpMtMxTU3TRGoE9bJy9+R+Cp9B/Oi2B7e/lqshwKFsntVO0KNEQlYE8qNwwvz
	 qGZlzot+FSkDfkhElnP8D69TiE3sqKwOE/uegBbBvXVJcNVj51+ZCzKnOo9r5Awr/H
	 /N/qMfy5rnTkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	emil@etsalapatis.com,
	liuhangbin@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] net: record XDP programs propagated to lower devices
Date: Mon, 28 Sep 2026 15:36:44 -0700
Message-ID: <20260928223648.2739371-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928223648.2739371-1-kuba@kernel.org>
References: <20260928223648.2739371-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An upper device installs its XDP program on each lower with
dev_xdp_propagate(), which calls ndo_bpf() directly and records nothing
in the lower's xdp_state[]. netif_xdp_propagate() open-codes two of the
checks dev_xdp_install() makes, but the lower still looks program-free
to everything else, so the checks made in the opposite direction miss it
entirely:

  ethtool -G $slave tcp-data-split on

is refused by dev_xdp_sb_prog_count() for a device running a
single-buffer XDP program, but not for a bond slave running the bond's,
even though netif_xdp_propagate() would have refused to install that
same program had header-data split been on already. Binding a memory
provider has the same asymmetry. The lower does not report the program
over rtnetlink either, so it is invisible to userspace as well.

Install it into xdp_state[] like any other program and mark it with
xdp_from_upper, rather than tracking it separately. Every existing user
of dev_xdp_prog_count() and dev_xdp_sb_prog_count() then gets the right
answer with no changes. The flag is only needed where the owner matters:
bonding reads it to tell a slave's own program apart from the one it
pushed down, both to refuse enslaving such a device and to let the
bond-wide program be replaced, and dev_xdp_attach() reads it to keep the
program from being replaced or removed behind the upper's back.

The lower now holds its own reference, as it does for a program of its
own; the upper's per-lower reference for the driver is unchanged.

While here, refuse to propagate onto a device which has a program of its
own, matching dev_xdp_install(). Bonding checks this before enslaving
and before installing, netvsc does not and would silently replace the
VF's program.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/netdevice.h       |   7 +++
 drivers/net/bonding/bond_main.c |   4 +-
 net/core/dev.c                  | 101 +++++++++++++++++++++++---------
 3 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d037faff7c44..512e3a21d0bd 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2517,6 +2517,12 @@ struct net_device {
 	unsigned long		change_proto_down:1;
 	unsigned long		netns_immutable:1;
 	unsigned long		fcoe_mtu:1;
+	/**
+	 * @xdp_from_upper: the program in @xdp_state was installed by an
+	 *	upper device with netif_xdp_propagate(); it belongs to the
+	 *	upper and can't be replaced or removed through this device.
+	 */
+	unsigned long		xdp_from_upper:1;
 
 	struct list_head	net_notifier_list;
 
@@ -4418,6 +4424,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+bool dev_xdp_has_own_prog(struct net_device *dev);
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u8 dev_xdp_sb_prog_count(struct net_device *dev);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index de2489c3d9bf..a62fff94fea3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2315,7 +2315,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			.extack  = extack,
 		};
 
-		if (dev_xdp_prog_count(slave_dev) > 0) {
+		if (dev_xdp_has_own_prog(slave_dev)) {
 			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
 				     "Slave has XDP program loaded, please unload before enslaving");
 			res = -EOPNOTSUPP;
@@ -5715,7 +5715,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			goto err;
 		}
 
-		if (dev_xdp_prog_count(slave_dev) > 0) {
+		if (dev_xdp_has_own_prog(slave_dev)) {
 			SLAVE_NL_ERR(dev, slave_dev, extack,
 				     "Slave has XDP program loaded, please unload before enslaving");
 			err = -EOPNOTSUPP;
diff --git a/net/core/dev.c b/net/core/dev.c
index f660fccfc0db..096d1dedebfd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10330,6 +10330,15 @@ u8 dev_xdp_prog_count(struct net_device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_xdp_prog_count);
 
+/* Does the device have an XDP program, and was it installed directly on the
+ * device rather than propagated down by an upper with netif_xdp_propagate()?
+ */
+bool dev_xdp_has_own_prog(struct net_device *dev)
+{
+	return dev_xdp_prog_count(dev) && !dev->xdp_from_upper;
+}
+EXPORT_SYMBOL_GPL(dev_xdp_has_own_prog);
+
 u8 dev_xdp_sb_prog_count(struct net_device *dev)
 {
 	u8 count = 0;
@@ -10342,35 +10351,6 @@ u8 dev_xdp_sb_prog_count(struct net_device *dev)
 	return count;
 }
 
-int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
-{
-	if (!dev->netdev_ops->ndo_bpf)
-		return -EOPNOTSUPP;
-
-	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
-	    bpf->command == XDP_SETUP_PROG &&
-	    bpf->prog && !bpf->prog->aux->xdp_has_frags) {
-		NL_SET_ERR_MSG(bpf->extack,
-			       "unable to propagate XDP to device using tcp-data-split");
-		return -EBUSY;
-	}
-
-	if (dev_get_min_mp_channel_count(dev)) {
-		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
-		return -EBUSY;
-	}
-
-	return dev->netdev_ops->ndo_bpf(dev, bpf);
-}
-EXPORT_SYMBOL_GPL(netif_xdp_propagate);
-
-u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
-{
-	struct bpf_prog *prog = dev_xdp_prog(dev, mode);
-
-	return prog ? prog->aux->id : 0;
-}
-
 static void dev_xdp_set_link(struct net_device *dev, enum bpf_xdp_mode mode,
 			     struct bpf_xdp_link *link)
 {
@@ -10385,6 +10365,63 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
 	dev->xdp_state[mode].prog = prog;
 }
 
+int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
+{
+	struct bpf_prog *old_prog;
+	int err;
+
+	if (!dev->netdev_ops->ndo_bpf)
+		return -EOPNOTSUPP;
+
+	/* we have more work to do for setup, bypass for other commands */
+	if (bpf->command != XDP_SETUP_PROG)
+		return dev->netdev_ops->ndo_bpf(dev, bpf);
+
+	if (bpf->prog && dev_xdp_has_own_prog(dev)) {
+		NL_SET_ERR_MSG(bpf->extack,
+			       "unable to propagate XDP to device with an XDP program of its own");
+		return -EBUSY;
+	}
+
+	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    bpf->prog && !bpf->prog->aux->xdp_has_frags) {
+		NL_SET_ERR_MSG(bpf->extack,
+			       "unable to propagate XDP to device using tcp-data-split");
+		return -EBUSY;
+	}
+
+	if (dev_get_min_mp_channel_count(dev)) {
+		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
+		return -EBUSY;
+	}
+
+	err = dev->netdev_ops->ndo_bpf(dev, bpf);
+	if (err)
+		return err;
+
+	/* Record it like a program of our own, so that everything which asks
+	 * whether XDP is running here gets the right answer. @xdp_from_upper
+	 * keeps the two apart where it matters.
+	 */
+	old_prog = dev_xdp_prog(dev, XDP_MODE_DRV);
+	if (bpf->prog)
+		bpf_prog_inc(bpf->prog);
+	dev_xdp_set_prog(dev, XDP_MODE_DRV, bpf->prog);
+	dev->xdp_from_upper = !!bpf->prog;
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(netif_xdp_propagate);
+
+u32 dev_xdp_prog_id(struct net_device *dev, enum bpf_xdp_mode mode)
+{
+	struct bpf_prog *prog = dev_xdp_prog(dev, mode);
+
+	return prog ? prog->aux->id : 0;
+}
+
 static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 			   bpf_op_t bpf_op, struct netlink_ext_ack *extack,
 			   u32 flags, struct bpf_prog *prog)
@@ -10492,6 +10529,7 @@ static void dev_xdp_uninstall(struct net_device *dev)
 
 		dev_xdp_set_link(dev, mode, NULL);
 	}
+	dev->xdp_from_upper = 0;
 }
 
 static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack,
@@ -10532,6 +10570,11 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 		NL_SET_ERR_MSG(extack, "XDP_FLAGS_REPLACE is not specified");
 		return -EINVAL;
 	}
+	/* the program belongs to an upper device */
+	if (dev->xdp_from_upper) {
+		NL_SET_ERR_MSG(extack, "Can't replace an XDP program installed by an upper device");
+		return -EBUSY;
+	}
 
 	mode = dev_xdp_mode(dev, flags);
 	/* can't replace attached link */
-- 
2.55.0

