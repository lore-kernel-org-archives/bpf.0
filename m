Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F01494806;
	Mon, 28 Sep 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635013; cv=none; b=nvvzo3TGhIwW+BbnGfL5AcKoFhOk41Rs0KY9jCPYqPNhXCv9rMfzRMiM1avZqjGhB3IBbi3QyNhuW2UQMEHKSvtFcp2iiVHCE8OAA+xFnHQ9Aj+LwdXDXh0agr2OsP5TC3NB6p+oMkghawGbIG4jXM03e301mmeM15IGhg+iMKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635013; c=relaxed/simple;
	bh=1WrYFfmoNkL+ykKOGZ+vNNdKeJwGCDEX9k7Gi7WgcQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u87cb+JQcWSJyPaXaqJ+Oq/sKgFt23qXVVYT3knZIhtx71mQu97fyRI/U/B4ZwZPSNznmZB4110xIp+4pMlU4WfoAnGgh8CAJvZ2idD88zoFI58eEsu89VIL9JlIs+nhKJGUHMLoP7makZQbW0s1SRcnJp2XPp8VTIH3NqpGsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBW1jb9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBW1jb9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886C51F00893;
	Mon, 28 Sep 2026 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635012;
	bh=OLUf1naNsJELLhXEIqR1tqlxMSBY5TYxmmwXG0pchco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBW1jb9aQ/5LIE7l0F+5CsYJMl2aWihMHAKaTveZfL59MD5fCKmZIhZTggJFlZeQH
	 II2XB4DUglGnYxi/IVbsHJCvflQcpsFG00ILHhccCw1YmjnEsKcgrPBbi6w8MZS27s
	 3MLtSDCdpVwO8ve068IJMurr+8L9K+g5e6SROUbYnWRlhNk9LJgp9+Ao7Sg8vT3GEG
	 hG4nRu2hn0CNriXpCExXX5q89K+NP4s600Gl6HNjyIHEBwKHHu2zmZoIB98On8Ekf6
	 lQfTR7GZb6P1NphuscKYEGUGzF4J15Izdnq6sGAXdm2hponJE84/69yWiS0/ftH8dw
	 E7gaUE8dZz4YA==
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
Subject: [PATCH net-next 2/5] netdevsim: add ndo_xdp_xmit
Date: Mon, 28 Sep 2026 15:36:45 -0700
Message-ID: <20260928223648.2739371-3-kuba@kernel.org>
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

Bonding refuses a slave which has no ndo_xdp_xmit once the bond runs an
XDP program, so netdevsim can't currently be enslaved into an XDP bond
and the propagation of XDP down to lower devices has no test coverage
at all.

There is no data path behind it. netdevsim does not advertise
NETDEV_XDP_ACT_NDO_XMIT, so nothing should be redirecting frames here;
anything which does anyway is counted and freed rather than dropped
silently.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/netdevsim/netdev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index eebc02ccc4a9..3790b6eb4083 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -185,6 +185,25 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+/* Do not advertise NETDEV_XDP_ACT_NDO_XMIT, no real datapath.
+ * This is a "stub" which allows netdevsim to be put under a bond with XDP.
+ */
+static int nsim_xdp_xmit(struct net_device *dev, int n,
+			 struct xdp_frame **frames, u32 flags)
+{
+	int i;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	for (i = 0; i < n; i++) {
+		dev_dstats_tx_dropped(dev);
+		xdp_return_frame(frames[i]);
+	}
+
+	return n;
+}
+
 static netdev_tx_t nsim_start_xmit_vf(struct sk_buff *skb,
 				      struct net_device *dev)
 {
@@ -651,6 +670,7 @@ static const struct net_device_ops nsim_netdev_ops = {
 	.ndo_set_features	= nsim_set_features,
 	.ndo_get_iflink		= nsim_get_iflink,
 	.ndo_bpf		= nsim_bpf,
+	.ndo_xdp_xmit		= nsim_xdp_xmit,
 	.ndo_open		= nsim_open,
 	.ndo_stop		= nsim_stop,
 	.ndo_vlan_rx_add_vid	= nsim_vlan_rx_add_vid,
-- 
2.55.0

