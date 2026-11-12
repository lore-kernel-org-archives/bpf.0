Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527436;
	b=mTSWcqht2b1tf1jGBfjVG28YwQJZ+lbFawr4PoLGxih6BZAVoEk3q11a0wxK4WZHZ1sF
	 2V8n+L3hpA4SQ6ZYsgdmErNs1TnG7hkguR5XFZjcl+fkr+rL/KMmNxLIQVn6GUEPFpmgA
	 NwUPqWaA+Eo6Qm2gODYPs0KncGJXRx92hmoBmoiILxkThuLc1RvD+jAAVJKkeM/FRb6Zy
	 V8Tr3PGD2rNvzEKt8VQtMlF7cIR1dhrJH0gMgimdnRryTctsO8GoG/TBYxfLUSWmpKbIM
	 KkdilwcAKgPg7pt7pvyYWCywsfrkjKcqeN8OXwpXYr18bZCFPRukla2Q2MEkZP3aoRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OgzU3k33Tnnr37lsyBIiZLhrbjVj9P/R6FmRS+arNPQ=;
	b=L99krfVbVsYvWQXJglXezTs00h5qIBy0uJW4CDDMaayYcf6uUEe2HHvzjwKXVpv8702j
	 KhBt74j76ldJ/IMZ8Q5zNZiXH0gDVqu6SkS8o4BX56S/O7TjnnOKHgArmEmIWhO5Z5C1f
	 wvHF8KATaPJeNtbilc5QT8+u8qWqm8jJWywj4uhtq2INUDwxv5oSU8ScbMu1PB+FfKApt
	 9ckdJ1C9ooshrMWVuKt783z6aP/3YnPT6dqPGxUr5wwBv6Trs2rgk/9r8r24OSYPuNl1u
	 uAWVNc69rk2oq8IZNkNs6QFuRstM8Du9uKimhuDvesXaoLZ95FJTG5gxJD+qbCJes4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kle7n5xF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008C1606A897;
	Thu, 12 Nov 2026 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kle7n5xF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE531F000CA;
	Thu, 12 Nov 2026 23:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527435;
	bh=OgzU3k33Tnnr37lsyBIiZLhrbjVj9P/R6FmRS+arNPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kle7n5xFmSBGTiPF3XNw//4NjSsU2BSmBLREYKM1kqxuBRTkTkN+2xQTUKiep9lR7
	 m5rBHU/7s3TOe1/fx1Q1fKRqYj1xP3rN0ip5TQte3I6awUUbMMrrSr/qBIeJC7Q0cI
	 NXGCPXqTKtfxXFnKT4Xniktj0uCZxhO6URDnyXO+CdV5iqkgYG7Ep20VPNuNae7blX
	 ZzVbyRt3/ZyOf6XEFtVnyW6xgNLkvzcRerYmajAtqvCFklhgd0puztXU4J0HLzcNmP
	 x2F9r+fUO/38X2mSkd4YdhIzn4OZrJtgkwXmBYA7BRuRG1jD+spLu5Mc2CByDY7huZ
	 +yW9Wd8BBo9Bg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	haiyangz@microsoft.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] net: record XDP programs propagated to lower devices
Date: Thu, 12 Nov 2026 15:50:25 -0800
Message-ID: <20261112235027.4072149-4-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112235027.4072149-1-kuba@kernel.org>
References: <20261112235027.4072149-1-kuba@kernel.org>
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
xdp_from_upper, rather than tracking it separately. Every other user of
dev_xdp_prog_count() and dev_xdp_sb_prog_count() then gets the right
answer with no changes. The flag is only needed where the owner matters:
bonding and netvsc read it to tell a lower's own program apart from the
one they pushed down, to refuse taking over such a device, and to let
their own program be replaced and taken back, and dev_xdp_attach() reads
it to keep the program from being replaced or removed behind the upper's
back.

The lower now holds its own reference and its own registration with the
XDP dispatcher, as it does for a program of its own, so that tearing it
down through dev_xdp_uninstall() when the lower goes away first stays
balanced. The upper's per-lower reference for the driver is unchanged.

An upper is expected to propagate NULL before it unlinks, but the lower
may refuse it - bonding and netvsc then only warn, and the program keeps
running. So when the master unlinks, let the device own whatever is left
rather than leave it with nobody allowed to remove it.

While here, refuse to propagate onto a device which has a program of its
own, the counterpart of the new check in dev_xdp_attach(). Bonding and
netvsc already check for this before taking a device over and before
installing.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - register the lower's program with the XDP dispatcher as well, so
   that dev_xdp_uninstall() of the lower stays balanced
 - let the device own a program left behind when its master unlinks
 - refuse removing the device's own program too, not only replacing it
 - assert the lower's ops lock in netif_xdp_propagate()
 - convert netvsc's checks of its VF to dev_xdp_has_own_prog()
 - split out moving dev_xdp_set_link() and dev_xdp_set_prog() up
v1: https://lore.kernel.org/20260928223648.2739371-2-kuba@kernel.org
---
 .../networking/net_cachelines/net_device.rst  |  1 +
 include/linux/netdevice.h                     |  7 +++
 drivers/net/bonding/bond_main.c               |  4 +-
 drivers/net/hyperv/netvsc_bpf.c               |  2 +-
 drivers/net/hyperv/netvsc_drv.c               |  5 +-
 net/core/dev.c                                | 49 ++++++++++++++++++-
 6 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 8eceaa80b686..7620d3fcb8dc 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -169,6 +169,7 @@ unsigned_long:1                     see_all_hwtstamp_requests
 unsigned_long:1                     change_proto_down
 unsigned_long:1                     netns_immutable
 unsigned_long:1                     fcoe_mtu
+unsigned_long:1                     xdp_from_upper
 struct list_head                    net_notifier_list
 struct macsec_ops*                  macsec_ops
 struct udp_tunnel_nic_info*         udp_tunnel_nic_info
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f18bafb4efe2..670fe869a875 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2531,6 +2531,12 @@ struct net_device {
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
 
@@ -4445,6 +4451,7 @@ struct sk_buff *dev_hard_start_xmit(struct sk_buff *skb, struct net_device *dev,
 
 int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 u8 dev_xdp_prog_count(struct net_device *dev);
+bool dev_xdp_has_own_prog(struct net_device *dev);
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 int dev_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf);
 u8 dev_xdp_sb_prog_count(struct net_device *dev);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 9249a79a168e..167503d1fd15 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2327,7 +2327,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			.extack  = extack,
 		};
 
-		if (dev_xdp_prog_count(slave_dev) > 0) {
+		if (dev_xdp_has_own_prog(slave_dev)) {
 			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
 				     "Slave has XDP program loaded, please unload before enslaving");
 			res = -EOPNOTSUPP;
@@ -5736,7 +5736,7 @@ static int bond_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			goto err;
 		}
 
-		if (dev_xdp_prog_count(slave_dev) > 0) {
+		if (dev_xdp_has_own_prog(slave_dev)) {
 			SLAVE_NL_ERR(dev, slave_dev, extack,
 				     "Slave has XDP program loaded, please unload before enslaving");
 			err = -EOPNOTSUPP;
diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
index 14bb520b44ed..fa6be9c71c81 100644
--- a/drivers/net/hyperv/netvsc_bpf.c
+++ b/drivers/net/hyperv/netvsc_bpf.c
@@ -228,7 +228,7 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
 		/* The VF's own program is not ours: refuse to install over
 		 * it, as bonding does, and leave it be on removal.
 		 */
-		if (vf_netdev && dev_xdp_prog_count(vf_netdev)) {
+		if (vf_netdev && dev_xdp_has_own_prog(vf_netdev)) {
 			if (bpf->prog) {
 				NL_SET_ERR_MSG_MOD(extack,
 						   "VF has an XDP program of its own");
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 61109ff9927f..6fb5c21b88dc 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2332,7 +2332,7 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
 		return NOTIFY_DONE;
 
 	prog = netvsc_xdp_get(netvsc_dev);
-	if (prog && dev_xdp_prog_count(vf_netdev)) {
+	if (prog && dev_xdp_has_own_prog(vf_netdev)) {
 		netdev_warn(ndev, "not using VF %s, it has an XDP program attached\n",
 			    vf_netdev->name);
 		return NOTIFY_DONE;
@@ -2485,7 +2485,8 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 	 * reach netvsc, but leave a program of the VF's own be.
 	 */
 	nvdev = rtnl_dereference(net_device_ctx->nvdev);
-	if (nvdev && netvsc_xdp_get(nvdev) && !dev_xdp_prog_count(vf_netdev)) {
+	if (nvdev && netvsc_xdp_get(nvdev) &&
+	    !dev_xdp_has_own_prog(vf_netdev)) {
 		netdev_lock_ops(vf_netdev);
 		ret = netvsc_vf_setxdp(vf_netdev, NULL);
 		netdev_unlock_ops(vf_netdev);
diff --git a/net/core/dev.c b/net/core/dev.c
index 69ee4342f43e..3a520c798d4a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9326,6 +9326,9 @@ static void __netdev_upper_dev_unlink(struct net_device *dev,
 
 	__netdev_adjacent_dev_unlink_neighbour(dev, upper_dev);
 
+	if (changeupper_info.master)
+		dev->xdp_from_upper = 0;
+
 	call_netdevice_notifiers_info(NETDEV_CHANGEUPPER,
 				      &changeupper_info.info);
 
@@ -10561,6 +10564,15 @@ u8 dev_xdp_prog_count(struct net_device *dev)
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
 	struct bpf_prog *prog;
@@ -10591,6 +10603,11 @@ static void dev_xdp_set_prog(struct net_device *dev, enum bpf_xdp_mode mode,
 
 int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 {
+	struct bpf_prog *old_prog;
+	int err;
+
+	netdev_assert_locked_ops_compat(dev);
+
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
 
@@ -10598,6 +10615,12 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	if (bpf->command != XDP_SETUP_PROG)
 		return dev->netdev_ops->ndo_bpf(dev, bpf);
 
+	if (dev_xdp_has_own_prog(dev)) {
+		NL_SET_ERR_MSG(bpf->extack,
+			       "unable to propagate XDP to device with an XDP program of its own");
+		return -EBUSY;
+	}
+
 	if (bpf->prog) {
 		if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 		    !bpf->prog->aux->xdp_has_frags) {
@@ -10613,7 +10636,26 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 		}
 	}
 
-	return dev->netdev_ops->ndo_bpf(dev, bpf);
+	err = dev->netdev_ops->ndo_bpf(dev, bpf);
+	if (err)
+		return err;
+	if (bpf->prog)
+		bpf_prog_inc(bpf->prog);
+
+	/* Record it like a program of our own, so that everything which asks
+	 * whether XDP is running here gets the right answer. @xdp_from_upper
+	 * keeps the two apart where it matters. Register it with the
+	 * dispatcher too, dev_xdp_uninstall() will drop it from there if this
+	 * device goes away first.
+	 */
+	old_prog = dev_xdp_prog(dev, XDP_MODE_DRV);
+	bpf_prog_change_xdp(old_prog, bpf->prog);
+	dev_xdp_set_prog(dev, XDP_MODE_DRV, bpf->prog);
+	dev->xdp_from_upper = !!bpf->prog;
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(netif_xdp_propagate);
 
@@ -10731,6 +10773,7 @@ static void dev_xdp_uninstall(struct net_device *dev)
 
 		dev_xdp_set_link(dev, mode, NULL);
 	}
+	dev->xdp_from_upper = 0;
 }
 
 static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack,
@@ -10773,6 +10816,10 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 	}
 
 	mode = dev_xdp_mode(dev, flags);
+	if (dev->xdp_from_upper) {
+		NL_SET_ERR_MSG(extack, "Can't replace an XDP program installed by an upper device");
+		return -EBUSY;
+	}
 	/* can't replace attached link */
 	if (dev_xdp_link(dev, mode)) {
 		NL_SET_ERR_MSG(extack, "Can't replace active BPF XDP link");
-- 
2.56.0

