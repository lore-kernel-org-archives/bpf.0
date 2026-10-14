Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85D565104
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002840; cv=none; b=Z/pn3Z/bKDuamf3eV7lfTAuk04k5DCVNRXLOB7suMrZzZxCAG6MGICBzqy74zp0mauhMIN2+WKd+NwcvttH0kiYfZEw+eUctriHm1Kq4HTN+7ia7gTjl1ar1gRu5ITp8CLYbS8Mg0uXDPhZe6rpu3l62+SqeUPA/nFPrgEbEkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002840; c=relaxed/simple;
	bh=/sDi7HIsx/bYASmJoVclnjRDXtNkZuaHYuJuvQyPZQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VQjHy9R7XhpfEERcxAEwzQtEcvd0D1S2aByf1OsWQojmJEsoVk0KZPXCcPZalMQKp6sy9GDi7EZbHPqZxXq6TWe9plaZJwlOg0tnCwlN6VvCn6vtP1gj0Ee5lfuEM2qhz4NDrhOwcRmXgfTi31ur2sYGAUagpKtSwItZCM+NFo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeTdbXt4; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeTdbXt4"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-49e0ee9e7afso1420054fac.2
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792002837; x=1792607637; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Z2E7pmsMMG7kkmYzB5uMqTLRrXawygd2jz4XpEAkRM=;
        b=PeTdbXt4Kdp0lPPTVTEPWXc6A4IA44zQcKj++T9dbsBUwACEYCpBXTAdLEsIRDHsur
         FCYouaIH0oXsHwgD5GnVgJis/8+btipTICwz0YdH90BPHFVnPX8PWDdt77XruFZEFH6K
         8dZ5cTYvgnJ0ChAA2Q80l+DotAWej41P56QwIFiKDJsSln3IX5zVV6S5E2E9LsUgwdTU
         YoU6PH36nzzghs5Ir4ksN/jzZk/E9Ep5Zb65tc0s7JcO66zX+kWpfH0TaQTRmeQhb9J8
         zD+fhCON+hrUgGlK3V1bxwtmbLtbMDccQEdYulSgQCRefdQexwnlalTpk4tHlxQ7tXgs
         mLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792002837; x=1792607637;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8Z2E7pmsMMG7kkmYzB5uMqTLRrXawygd2jz4XpEAkRM=;
        b=DBSVaeL/tokq6BG+UsycdtIErwhas9I2kkEyBL9U1lJCTdJAtAFW8aUDC6oEIzN6me
         hY7hAP8+2cLKe7dlKQ8qkjd0AGfmB4lbU7dMklJmhKDB7kmzYw27T1xFCtcTbYhi7a9f
         b6+HfsdGvwXmRCGdaJ2yhfxXaRLwmKe9FeSlrDUvr26fu7/GkIZBOUPsgduJpDWovNIX
         hK/azuEsjb8DOyy2BBDBn3On2IuLWUwbLmuOj+4V8MrzYMNMtab0nlK+EK4TGGPf162L
         FRsfvXqS6A2x6yF1JJgyNkVbv6eXGaOlCDE50wdpQ32V38EPKIj6hNlV/A1PXtg2AgJd
         aMaw==
X-Gm-Message-State: AFq9FYI+tzNV3vEPu8pl83MVGkR+ntLk7edjA7yKN36pTCBt0b4qnRTK
	12q65YC/Tr11dFBaNHJFVVBVcA6eutOG6IrShgufq/VeIr9X+tZP+XwZ
X-Gm-Gg: AYBFou08Sf/kdN0xNkacPf6RU7soCEpALeq09twUlahQ9TyMEsP03YZw3erK3gC+qPc
	qQv2v1tpWdQKbAWoTWswuGRW3oI8jKPyICe++muKj2CwUhBolkdWG3cvVoxYkV3/IqlE79ZNRWB
	JOPkN6mT52IAZjSGpFEiUoFmGcSoe8fBDr5cMY3Syc8UN3cmS05iSxLG9HV3FmJT07/GOv97/we
	g7dIXR5q2PJzQCMp+DKu7aK59U6CftRUCdjd0ayPFJElMbXKLuOKl2NTbVwaIws1t2chKZTKKms
	GWw4vXUVY6OpCXjd+K7A/RDHAwuzztDZL9vO6M2TT9b1ahelSozPL0es44CSArJDoHCBqZZPa63
	G9OqecxsNlrMWGu/NLOwyJhNsrpkz/6MJB6wj6alNUEXDonWVaVN4gz8H2RorolYF8eP9FVhZ8p
	6m3WSoYuav+FZE1tyMBPRx03ZNInSS0+uvj4PKGvaATHf7PzFr55fBi3SfZXXwBCXNAwqMG1tRa
	07tBuZ3lgnW7WDAFKJ9zjrqKWM8liGU3bdizdSJAkzkRMyKGpfN93tLpjEU0D/J5oKBjr7Q3m0N
	kMcjT1+EFsu0tas7SxcpJWNngPSgTbNx+s62FnKQb5QKicgVYeAgZGN+EB6fbjHynap3D3/awHA
	qkWpuI3gFdhTeIrz23dXT
X-Received: by 2002:a05:6871:2e81:b0:488:b68c:681a with SMTP id 586e51a60fabf-4a2a88cf33dmr13119867fac.38.1792002837397;
        Wed, 14 Oct 2026 11:33:57 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfbca439sm2609137fac.8.2026.10.14.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 11:33:55 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 14 Oct 2026 12:33:48 -0600
Subject: [PATCH net v4] xsk: freeze deferred pool teardown without blocking
 unregister
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-xsk-suspend-teardown-v4-1-27795582e4a3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ7CIBAF0Ks0rMUMQ23BlfcwLpBOlWhpA7XWm
 N5dwsIYE13++Zn3nyxScBTZtniyQJOLrvcplKuC2bPxJ+KuSZkhYAVaAp/jhcdbHMg3fCQTmv7
 uuQZstSpBWS1Zeh0CtW7O7J55GtkhHc8ujn145KlJ5Oq/OgkuuKmsscqChCPtTp1x17XtuwxO+
 EYEwOYHggnBRtWIqi0l6m9EfiBC/kBkRqoj1RWgLutPZFmWF2BgPkxHAQAA
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
 linux-kernel@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>
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
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
Assisted-by: Codex:gpt-6-astra

Changes in v4:
- Drop the redundant ASSERT_RTNL() in xp_assign_dev() and the extra
  operations-lock assertion in xp_clear_dev_all(), as requested by
  Stanislav Fomichev.
- Add the Reviewed-by tags from Björn Töpel and Jason Xing and the
  Acked-by tag from Stanislav Fomichev.
- Link to v3: https://patch.msgid.link/20261013-xsk-suspend-teardown-v3-1-2d6be7602947@gmail.com

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
 net/xdp/xsk_buff_pool.c     | 46 +++++++++++++++++++++++++++++++++++++--------
 4 files changed, 51 insertions(+), 8 deletions(-)

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
index 9d2d94f1fb75..0ebd4d46f7ab 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -172,7 +172,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	u32 frame_size;
 	int err = 0;
 
-	ASSERT_RTNL();
+	netdev_assert_locked_ops_compat(netdev);
 
 	force_zc = flags & XDP_ZEROCOPY;
 	force_copy = flags & XDP_COPY;
@@ -204,6 +204,11 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	pool->cached_need_wakeup = XDP_WAKEUP_TX;
 
 	dev_hold(netdev);
+	/*
+	 * Socket removal precedes the final pool put. Keep the pool visible to
+	 * NETDEV_UNREGISTER even while release work is waiting for process thaw.
+	 */
+	hlist_add_head(&pool->dev_node, &netdev->xsk_pools);
 
 	if (force_copy)
 		/* For copy-mode, we are done. */
@@ -244,7 +249,6 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
 
-	netdev_assert_locked_ops_compat(netdev);
 	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
 	if (err)
 		goto err_unreg_pool;
@@ -265,6 +269,8 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		err = 0; /* fallback to copy mode */
 	if (err) {
 		xsk_clear_pool_at_qid(netdev, queue_id);
+		hlist_del(&pool->dev_node);
+		pool->netdev = NULL;
 		dev_put(netdev);
 	}
 	return err;
@@ -287,19 +293,39 @@ int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
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
+	hlist_for_each_entry_safe(pool, next, &dev->xsk_pools, dev_node)
+		__xp_clear_dev(pool);
+	netdev_unlock_ops(dev);
 }
 
 static void xp_release_deferred(struct work_struct *work)
@@ -337,7 +363,11 @@ bool xp_put_pool(struct xsk_buff_pool *pool)
 
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

