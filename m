Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD089472783
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915865; cv=none; b=DfbexNQ6+ZGeeU003qfh6MLltvd6pTaRRE6p21m0n88e2vGcPghpZXPJcqZH98sqJ9lmBLO8NG9RS4y26Tapq7HQjn+f8qTW00zdLzYY+5qIssNmZ+mO8rk9SBcGw4gBgKO9R4xcuVV3/pDGBZdyl6sgnv9JvCEqA+tdJC8eRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915865; c=relaxed/simple;
	bh=7if6Umjv6zt+eB/TyjHQ2M8+DtW8+u3VSI2lHM1qgmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T80FsUa+b/VSoIqvfzKeiEiKsS+JZll+Ds2CZiOjasloIgLL6cX3QubaEYRRw0pUi2H97l7OZ2hfar9G+KNuayp8MJ+UKinSI2bVESTmdO+1Fj4QwFjVelVVQ5HG/9jo5fPEHklDBnbtDk7QmpQXOVUxv93Xs0v/lsHEmNstS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqJNxkBs; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqJNxkBs"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6f5a0893610so165234eaf.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791915862; x=1792520662; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CrakmgXMtdoVnoNgswFtoyyOjaZ8kjF18Znv/ag/z9w=;
        b=XqJNxkBsJHmlkDK7nYs+PNCHCQJa23Y7cWpCHDeNvhK7Es7tLulS6PKfJB02UK7Bxg
         nIbnXoO2DYtt7D6NT5r000Fu8/dAVduYFnVNLN4s8sLGY/r8EjpHrDYxenEHrC4zC+i5
         UE04Trw2u4fBsa9XtSSVgRpw6mMzWPYC+de3xee7m180tNvJOXzhtQvr7RhUJmjcX7hn
         QAMAbtV/GpyepXnGNPqiTCUtdNT+iTMAB1L1VPckO7Tu9apF/hSW9WZFq8fQUwvQ+/8E
         +1v5G5ZO+N6zZpOV2EOCRdUam5Q0zcbOR6ns5xnsigKTakc8a/82Eb6Wre2taNNNMv3G
         GRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791915862; x=1792520662;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CrakmgXMtdoVnoNgswFtoyyOjaZ8kjF18Znv/ag/z9w=;
        b=ZeQfvO/hGROp/d40s2UpwRhN00rzqzldPtk7m+pz/B+uU5A+KOiWIiNXh6llBIgPeP
         tpYh8/vz2+n4S1NXwendE2UWKKaHJJC7HQJH8MKxMNwZx5QGn3fuFMd9MVaNqZRlvBBL
         IQsjdpaIFy1QksfGaAZ5GmC9hO1sqGWUhR+i8M1qySRyTdU4GotHfAw6IkBr0RFwx7FY
         yzZrtazob/ryqeTdbvG0o5q+KdFPdg+q5oUa5WEQbikQRDEz37tsU20HIY6HTeRKbsPH
         79ozulSKpUUGgdiPIdir2qdzhhO5mCep9pnxOFewrfDqwEktiTwr+EoN7oAXZHv6RsNr
         v5sw==
X-Gm-Message-State: AFq9FYKGPszSmgIt6QPFUK7uJ+qv9KmoCb7NE+ye3+BpXAfK49PYWxys
	TapoiO7Luye2w92jJVpsGqG//2y4gIUT1DTaNhpohPMAWB3rFs/wY4Wc
X-Gm-Gg: AYBFou2MefYnHOY83QENJF3VJbzGXh3AR5bILQJyLJj8LDCwo71EXvUwOaaKzZAeNZi
	0rQ8NtPCS84RKXKB692v0jYB3jX8n7Sk+9BipZkZ/4fYEOi6+GIjF+cwGcLslHs1bEFkwP5iWj7
	E88RLvhmAzUcO3zre1k3RCKkBZGqsstCiLm/13/xaufYBeS86CARcbk01qCD27S7YFVAhkRVBho
	FKNiOIpqb7YQgx3G4WkWA6DlNfSCVswW5e9Al+DNj7lo+Ey7IF9XGg7+ZupIw681jBaz+T1gclg
	Zh9Sc5z3EnEL62k/ywpRsVo5rTNrYC22msEglhkunBg0qNq2I1Vl4t4PAcU0nhtDVD/djdfTDy1
	npqgbGJp1xObuy8LeIFFT/yTf68X9TXM6oj1picaiBHlyCTtTb9FjlNr5gslr/IvNExCyN+vXDQ
	JskSh0GLKsgpr6fXOdCdJKygv61bAaNX+a9+NuwKpqXuX0qBXdp5IUl7Dts5H4bF4/rTrIQIeRW
	pJlx/iMcCLc4P1Swtb8y3tO+KrinYFDQfe6kXjzk488nZyex8ZJk0UfSHtwihenfDimSdHBT+Os
	ZODU5SlcH3eyFaEllBOihUW1UhtswG4P9nJoZqGplKGqmEmq0ar6o82EJ2fC05BARI3avkrDW+Z
	0gnxOMCtKu8dlVo1DJn2NSw==
X-Received: by 2002:a05:6820:4c13:b0:6d7:4142:8b8c with SMTP id 006d021491bc7-6ef0fa9d818mr9965327eaf.64.1791915861931;
        Tue, 13 Oct 2026 11:24:21 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6eef6e22b46sm12627103eaf.0.2026.10.13.11.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 11:24:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 12:24:19 -0600
Subject: [PATCH net v3] xsk: freeze deferred pool teardown without blocking
 unregister
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ7CIBAF0Ks0rMVMh1rBlfcwLhCmLVFpAxVrm
 t5d0oVxo8s/P/P+zCIFR5EdipkFSi663ucgNgUznfYtcWdzZghYgxLAp3jl8REH8paPpIPtn54
 rwEbJCqRRguXXIVDjppU9MU8jO+dj5+LYh9c6lcq1+q+mkpdc10YbaUDAhY7tXbvb1vT3FUz4Q
 UqA3Q8EM4JW7hFlUwlU38iyLG/bi9SeAgEAAA==
X-Change-ID: 20260930-xsk-suspend-teardown-902f98408c93
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: bpf@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Deferred pool destruction calls ndo_bpf() under RTNL. system_wq is
not frozen during system sleep, so that callback can run after a
device has suspended and gated its clocks. Use system_freezable_wq
so running destruction finishes before device suspend and new work
waits until process thaw.

Keep assigned pools visible to NETDEV_UNREGISTER independently of
the socket list. A released socket has already left that list, but
its final pool put can queue destruction after workqueues freeze.
A resume-time unregister would then wait for a device reference
whose release cannot run until the resume completes.

Track assigned pools per netdev with netdev operations locking and detach
remaining pools after the notifier socket walk, including copy-mode pools.
This also covers leased queues without scanning pools from unrelated
devices or network namespaces. Remove the entry on assignment failure and
normal teardown. The deferred worker still owns the pool and later observes
the cleared device pointer, avoiding a second driver detach or put.

The lifetime problem was identified by code inspection of the deferred
release and system-sleep paths.

Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from umem")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v3:
- Protect the per-netdev pool list with netdev operations locking, as
  requested by Stanislav Fomichev and Björn Töpel.
- Assert operations locking for copy-mode assignment too, and share a
  locked detach helper so unregister holds the lock across the pool walk.
- Rebase onto current net.
- Link to v2: https://patch.msgid.link/20261005-xsk-suspend-teardown-v2-1-2d87228f4329@gmail.com

Changes in v2:
- Track assigned pools per netdev instead of scanning a global pool list.
- Keep deferred releases visible across queue changes and queue leases.
- Rebase onto current net.
- Link to v1: https://patch.msgid.link/20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com
---
 include/linux/netdevice.h   |  5 +++++
 include/net/xsk_buff_pool.h |  3 +++
 net/xdp/xsk.c               |  5 +++++
 net/xdp/xsk_buff_pool.c     | 46 ++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3cff2174dc03..ac257221c7c5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2545,6 +2545,11 @@ struct net_device {
 	/* protected by rtnl_lock */
 	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
 
+#ifdef CONFIG_XDP_SOCKETS
+	/** @xsk_pools: assigned AF_XDP pools, ops protected */
+	struct hlist_head	xsk_pools;
+#endif
+
 	u8 dev_addr_shadow[MAX_ADDR_LEN];
 	netdevice_tracker	linkwatch_dev_tracker;
 	netdevice_tracker	watchdog_dev_tracker;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index a7df573784fd..02e89350faf9 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -48,6 +48,8 @@ struct xsk_buff_pool {
 	struct device *dev;
 	struct net_device *netdev;
 	struct list_head xsk_tx_list;
+	/* Assigned pools, including deferred releases; ops protected. */
+	struct hlist_node dev_node;
 	/* Protects modifications to the xsk_tx_list */
 	spinlock_t xsk_tx_list_lock;
 	refcount_t users;
@@ -119,6 +121,7 @@ bool xp_put_pool(struct xsk_buff_pool *pool);
 void xp_clear_dev(struct xsk_buff_pool *pool);
 void xp_add_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
 void xp_del_xsk(struct xsk_buff_pool *pool, struct xdp_sock *xs);
+void xp_clear_dev_all(struct net_device *dev);
 
 /* AF_XDP, and XDP core. */
 void xp_free(struct xdp_buff_xsk *xskb);
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 33475b180ea6..781ba46eb152 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -2145,6 +2145,11 @@ static int xsk_notifier(struct notifier_block *this,
 			mutex_unlock(&xs->mutex);
 		}
 		mutex_unlock(&net->xdp.lock);
+		/*
+		 * A released socket is no longer on xdp.list. Its pool can still
+		 * hold a device reference on the frozen release workqueue.
+		 */
+		xp_clear_dev_all(dev);
 		break;
 	}
 	return NOTIFY_DONE;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 9d2d94f1fb75..5b9dcafd6882 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -173,6 +173,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	int err = 0;
 
 	ASSERT_RTNL();
+	netdev_assert_locked_ops_compat(netdev);
 
 	force_zc = flags & XDP_ZEROCOPY;
 	force_copy = flags & XDP_COPY;
@@ -204,6 +205,11 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	pool->cached_need_wakeup = XDP_WAKEUP_TX;
 
 	dev_hold(netdev);
+	/*
+	 * Socket removal precedes the final pool put. Keep the pool visible to
+	 * NETDEV_UNREGISTER even while release work is waiting for process thaw.
+	 */
+	hlist_add_head(&pool->dev_node, &netdev->xsk_pools);
 
 	if (force_copy)
 		/* For copy-mode, we are done. */
@@ -244,7 +250,6 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
 
-	netdev_assert_locked_ops_compat(netdev);
 	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
 	if (err)
 		goto err_unreg_pool;
@@ -265,6 +270,8 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		err = 0; /* fallback to copy mode */
 	if (err) {
 		xsk_clear_pool_at_qid(netdev, queue_id);
+		hlist_del(&pool->dev_node);
+		pool->netdev = NULL;
 		dev_put(netdev);
 	}
 	return err;
@@ -287,19 +294,40 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
 	return xp_assign_dev(pool, dev, queue_id, flags);
 }
 
+static void __xp_clear_dev(struct xsk_buff_pool *pool)
+{
+	struct net_device *netdev = pool->netdev;
+
+	netdev_assert_locked_ops_compat(netdev);
+	xp_disable_drv_zc(pool);
+	xsk_clear_pool_at_qid(netdev, pool->queue_id);
+	hlist_del(&pool->dev_node);
+	pool->netdev = NULL;
+	dev_put(netdev);
+}
+
 void xp_clear_dev(struct xsk_buff_pool *pool)
 {
 	struct net_device *netdev = pool->netdev;
 
-	if (!pool->netdev)
+	if (!netdev)
 		return;
 
 	netdev_lock_ops(netdev);
-	xp_disable_drv_zc(pool);
-	xsk_clear_pool_at_qid(pool->netdev, pool->queue_id);
-	pool->netdev = NULL;
+	__xp_clear_dev(pool);
 	netdev_unlock_ops(netdev);
-	dev_put(netdev);
+}
+
+void xp_clear_dev_all(struct net_device *dev)
+{
+	struct xsk_buff_pool *pool;
+	struct hlist_node *next;
+
+	netdev_lock_ops(dev);
+	netdev_assert_locked_ops_compat(dev);
+	hlist_for_each_entry_safe(pool, next, &dev->xsk_pools, dev_node)
+		__xp_clear_dev(pool);
+	netdev_unlock_ops(dev);
 }
 
 static void xp_release_deferred(struct work_struct *work)
@@ -337,7 +365,11 @@ bool xp_put_pool(struct xsk_buff_pool *pool)
 
 	if (refcount_dec_and_test(&pool->users)) {
 		INIT_WORK(&pool->work, xp_release_deferred);
-		schedule_work(&pool->work);
+		/*
+		 * Teardown calls ndo_bpf(), which may need powered hardware.
+		 * RTNL alone does not exclude the device's system PM callbacks.
+		 */
+		queue_work(system_freezable_wq, &pool->work);
 		return true;
 	}
 

---
base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
change-id: 20260930-xsk-suspend-teardown-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

