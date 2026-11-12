Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527434;
	b=YbR5sq883SELSfNtUhwjvs0pbB4ANNVgnfkBnVlt55Qj+LyQdkiF4sf2YbcEyEZJRdjI
	 YlWqtdUt+aLFbQF6yrvv9+W2tUNtqIIm5QYA4uUO7puDyuUB1m0JxIqh61RuKhNm7e+Gp
	 UgOXCA3k3mI8PfuOa6pL0aLxb6o0RWeMXBQBH22t11lxQxe9SXg8YThD19B6tS5TlDweD
	 T4k8SBPoYwLsHAWMBIBhAQZKPHhwLRPp/kaAxjRTaBiewfLTUg4fRHwJ+KM44d5zc9Oeg
	 OwG9czWPHd032okF/xtgBD/ARSL411XYx1D7JKdPCePAjdE5/bLzfqQjiOJOA+bqdfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ihCBkfqaIdNV+ymo3RhKa9CO83kd4/k7iZNLY62D9OE=;
	b=ReM/+YEejjHKEiPpRguiLVDiJ5XqNR4M2ydLOSKrFycDuesHseiwIoLHj98nXzGZ3KBh
	 NHPsPiZeuHjYnrx5pG2dSB1gMIhp3FQgJcd07VOovR7JSncbg9CWJXoxSHmqcCEMyjHkO
	 JZl4PGaykMMiJAnK4yCFnWo2hEL8tPbhzwjzWUt3PbUyt8fesSd9mWlQstQ2lJv5wL+CZ
	 2DUAPkNjTroOHilfPxLo8hUaJBBg41o7yxnnWU5iZNr+6sZpAnus2vOfaScPDE6srNOIX
	 tWBcvB6irlXxXvdSDsJ5cOP3bGYuYi+AVQIXv6u/I0SoqS5k6n0JGY3nhUufu1U1i/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZqwBcKZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650B606A332;
	Thu, 12 Nov 2026 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZqwBcKZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118901F000C6;
	Thu, 12 Nov 2026 23:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527434;
	bh=ihCBkfqaIdNV+ymo3RhKa9CO83kd4/k7iZNLY62D9OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JZqwBcKZGBYMWZVNKFFInQxMJf9qCVMt3kIrxBCTBULd3HQVSzfaHFkgvl8wbXdbp
	 u3yZEtJvYVq81H5aMKulnvnzlcJZDkk1l7C8L46V9UjRWSsNPjg5+BXgQf/NrRPs1+
	 mIxouNyTQQ3V7uddqCVvZ1a2dy7UGvPfqTVsVv/rNQI1Qq7at06l6WtwDQb4KFi91a
	 B+ZdBrR6gDCAhJZ1Bt9Ch/oJMYEOuL+a6RwZFi+Gb+6Kmu5weBsbk5WEXeM2K+GtKp
	 iB+XqzClxVnaZegjlixLwjlVDTlaaEEnIi8dAUzDnudIweA72RpTbv+3RdHIY6ji0A
	 KBIOREpIjHtJg==
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
Subject: [PATCH net-next 1/5] net: don't safety-check device features for XDP uninstall
Date: Thu, 12 Nov 2026 15:50:23 -0800
Message-ID: <20261112235027.4072149-2-kuba@kernel.org>
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

Commit ad27ed7d2309 ("bpf, xdp: move offload check into dev_xdp_install()")
lifted the safety checks from dev_xdp_attach() to dev_xdp_install()
to cover more paths. Since all these checks are prog
related they are under one big "if (prog)".

Lift the pre-existing checks under "if (prog)" as well,
and do the same thing in netif_xdp_propagate().
This way we don't have to worry about triggering WARN()s
on cleanup paths mistakenly trying to un-install a program
when there is none, and failing because device has a memory
provider.

This is a refactoring / consistency cleanup, later patches
don't depend on this change.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index a230ecce9327..a5120da879d1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10580,17 +10580,23 @@ int netif_xdp_propagate(struct net_device *dev, struct netdev_bpf *bpf)
 	if (!dev->netdev_ops->ndo_bpf)
 		return -EOPNOTSUPP;
 
-	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
-	    bpf->command == XDP_SETUP_PROG &&
-	    bpf->prog && !bpf->prog->aux->xdp_has_frags) {
-		NL_SET_ERR_MSG(bpf->extack,
-			       "unable to propagate XDP to device using tcp-data-split");
-		return -EBUSY;
-	}
+	/* setup requires extra handling, bypass those for other commands */
+	if (bpf->command != XDP_SETUP_PROG)
+		return dev->netdev_ops->ndo_bpf(dev, bpf);
 
-	if (dev_get_min_mp_channel_count(dev)) {
-		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
-		return -EBUSY;
+	if (bpf->prog) {
+		if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+		    !bpf->prog->aux->xdp_has_frags) {
+			NL_SET_ERR_MSG(bpf->extack,
+				       "unable to propagate XDP to device using tcp-data-split");
+			return -EBUSY;
+		}
+
+		if (dev_get_min_mp_channel_count(dev)) {
+			NL_SET_ERR_MSG(bpf->extack,
+				       "unable to propagate XDP to device using memory provider");
+			return -EBUSY;
+		}
 	}
 
 	return dev->netdev_ops->ndo_bpf(dev, bpf);
@@ -10656,17 +10662,17 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 			NL_SET_ERR_MSG(extack, "BPF_XDP_CPUMAP programs can not be attached to a device");
 			return -EINVAL;
 		}
-	}
-
-	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
-	    prog && !prog->aux->xdp_has_frags) {
-		NL_SET_ERR_MSG(extack, "unable to install XDP to device using tcp-data-split");
-		return -EBUSY;
-	}
-
-	if (dev_get_min_mp_channel_count(dev)) {
-		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
-		return -EBUSY;
+		if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+		    !prog->aux->xdp_has_frags) {
+			NL_SET_ERR_MSG(extack,
+				       "unable to install XDP to device using tcp-data-split");
+			return -EBUSY;
+		}
+		if (dev_get_min_mp_channel_count(dev)) {
+			NL_SET_ERR_MSG(extack,
+				       "unable to install XDP to device using memory provider");
+			return -EBUSY;
+		}
 	}
 
 	memset(&xdp, 0, sizeof(xdp));
-- 
2.56.0

