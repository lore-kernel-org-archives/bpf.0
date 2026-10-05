Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368F34D9F7F
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791224248; cv=none; b=mJ/H8kp/NSukUts1RrC9h3CNYTaLGyQAIpVnUsT921oJiP/PXkacbwd4WOHndcn0YmqI/0FmP2ljAtVuzP59yxGy53oxQBMbitfjZwHvUVJvIxi6xj1mWLjj7rCrjkqOJv/zXsYP5J0tCDHvWT43mfkQBk718XhQqP0wUZzkNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791224248; c=relaxed/simple;
	bh=SlfT5CpG1gfS0O6dGhXo30NrXX/THyrTJARh8LcTSNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aW7gBbw7/V/NQ6kwfg8rIBpsvafBInyp0v/sjjI39U0WpXUxZUtYhiJDjD0Z/PrNQNNmoqP4nLToKuQ9wiDveHVwe3QzO4P8l4ce+4FzegPr+je1de0ufq/TPy8YTfpZiIxNfNtpgqf+nVAlF9ipA5svhaRyM0+uyN+h/xq5xS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHc1A6mP; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHc1A6mP"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-493cf6d8e60so735397fac.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791224245; x=1791829045; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rouq59a9OyBo1EeAraKbx0994ONwMJ1+oA66imSzKao=;
        b=GHc1A6mPFwU1mQCKMjDNf+uUGZeU4DFLIqQ7sdz8bjBTnPFJ7011JJxtO0nZSKYktG
         3+6QSHWijl+eWp4uyM4l+2MkUUet/D7BhKuSrHvAorUIXPSDrzlufyLMvXSpDG5MrT8z
         1aYh2GxWSaz4MBe4I3Xz9OE+GyS/1zDejvxEP9UCwonjxMISA4hIKV1+nFjNprKUvbQl
         mwmu98xVsf3m6cZBGx+kxMZHpfPJfdIJWF6F2k6+RUFCBwT2qeessGg3fB4vOSI47JKh
         UJcMNe0vmB6azLj/KxovSf9Vwmq/SmnoH4K4Ay0Lg+gqw2UvQndHI/5UHti7zR8HYN0Z
         9KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791224245; x=1791829045;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rouq59a9OyBo1EeAraKbx0994ONwMJ1+oA66imSzKao=;
        b=P97TYZVrXaOR/91c5PDj4/rcuUPWjliI9wTfhQCwE1LQ5hjjr9bc/4XB0URxyAArhY
         BTv4wje01RC4sDleilcX38mNhJxYA47p/3rMb3zWzGzOyWp9WcXzKUbvHIt8upFa2eoo
         pKGFcrAGNywEiLXDGg2I02AUrC7P9wuGq8boCDwgV+GEb2AV6rk+u6y8ZLgeF7ETAepI
         z2kXW/ddeEAym0Kae+H279n4wv6ErdJmhXxN35VBu8M6VYAjBd3tNUkLzXhCpVeOLfkf
         o0EEAwRv65eRNvn5OwH7oyJjNK/zCwP52EIVjonRT36DrDFsSEdnOGJMuTcaU7EC/qZf
         6Zbw==
X-Forwarded-Encrypted: i=1; AKwUvBy3Lm1VSGBVApDGhhrYdXOW4gZo0jd3CnUY3hP97hzSPwW/ieZSy41Ya6KNc+rqXnOV7dw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcmgUACe+t7bv1tUXIw2ibISq9+7ltDs64Q/MVj3l9W8DWyTXK
	e0dAIWFACMb3u5uV8zCpRBJXn9crUysW5WGcwqX5RMTJ0JFuqp9gDenQ
X-Gm-Gg: AYBFou2ZiTr9QF5qqEoOWrGqwPLZb9iIKxYSwrn76qQqswqcNWig14DCUblLLOfqthy
	9Rar2waXNlTgNqynurNVYWjNz93QHLSQzN7Ht+serZeNieHjsQtnmdqKH+1w/qornO40g63EAmF
	cgWdCWN4i99Ph5qBEXCT/1BqIlAJksSTE76Ki0rz3MrByeUbjX40s4P6V+FTyr5uw8rcRSRHDyn
	gEJ9JUsJRKa2D6DwTjxz1G2kJfETqJ9u7nOYJmSj0WYCn9XDlyFslnQkAA1axC0XQF/gvyY1IPi
	g0FR/0B0HPeA9cO4sA2vD3ODaHKJU4RdkXV2gixDsA5mozobwVRmmTIZJH6IvdQRsMmu/AqO5vo
	lu6yuNMDV2TSb0k18yXdR6wW13glN9GTp4yC0tsyH34dwU+3xwj6BrxRaUHmN1Y+LspvTN0mWEy
	HMfe7ty5DFETZZR14yvP/oKDLH/LwGFJuGPPihXailmnUYXkbUxT2tFnff/RDD/3Lx1qwjyoB07
	fU6a73DKu8IeBj4U/wliRUby2F5LyyDFCfHplllgR6moMWamyaUbPZDbGL4IfJQfuzKlYOdWZ0r
	ZTr+KjPFv/PSpVV/Op8oVbFbqtWsxtP/aBpr8eblq+csyJnqJGM1iKSj1/m1C65czn3iIh+dhDB
	1y2RJngKCKsxpRVH/xe7zgg==
X-Received: by 2002:a05:6870:524f:b0:48f:e0f6:c465 with SMTP id 586e51a60fabf-49e15e5c8c3mr10012930fac.51.1791224244819;
        Mon, 05 Oct 2026 11:17:24 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49e16d60931sm10358053fac.4.2026.10.05.11.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 11:17:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 05 Oct 2026 12:17:21 -0600
Subject: [PATCH net v2] xsk: freeze deferred pool teardown without blocking
 unregister
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261005-xsk-suspend-teardown-v2-1-2d87228f4329@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OwQ6CMBBEf4Xs2ZqlaGk5+R/Gw1IWbZSibUWN4
 d9t0LNzm9nsm3lD5OA4QlO8IfDkoht9NnJVgD2RP7JwXfYgUSo0FYpnPIt4j1f2nUhMoRsfXhi
 UvdEb1NZUkF+vgXv3XLB78Jzg8A0D3+65Iv0uLUUWdhwGl5qCsnpdMxnT6lopa0gTIdcl0Uaya
 q2mbSVxYZ1cTGN4LbOncoH9XziVohSkLFltscKWd8eB3GWd2+Ewz/MHKiuLHQkBAAA=
X-Change-ID: 20260930-xsk-suspend-teardown-902f98408c93
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
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

Track assigned pools per netdev under RTNL and detach remaining pools
after the notifier socket walk, including copy-mode pools. This also
covers leased queues without scanning pools from unrelated devices or
network namespaces. Remove the entry on assignment failure and normal
teardown. The deferred worker still owns the pool and later observes
the cleared device pointer, avoiding a second driver detach or put.

The lifetime problem was identified by code inspection of the deferred
release and system-sleep paths.

Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from umem")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Track assigned pools per netdev instead of scanning a global pool list.
- Keep deferred releases visible across queue changes and queue leases.
- Rebase onto current net.
- Link to v1: https://patch.msgid.link/20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com

To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: Magnus Karlsson <magnus.karlsson@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@fomichev.me>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Jesper Dangaard Brouer <hawk@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>
To: Björn Töpel <bjorn@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org
---
 include/linux/netdevice.h   |  5 +++++
 include/net/xsk_buff_pool.h |  3 +++
 net/xdp/xsk.c               |  5 +++++
 net/xdp/xsk_buff_pool.c     | 25 ++++++++++++++++++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3cff2174dc03..72091938f6e6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2545,6 +2545,11 @@ struct net_device {
 	/* protected by rtnl_lock */
 	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
 
+#ifdef CONFIG_XDP_SOCKETS
+	/** @xsk_pools: assigned AF_XDP pools, protected by rtnl_lock */
+	struct hlist_head	xsk_pools;
+#endif
+
 	u8 dev_addr_shadow[MAX_ADDR_LEN];
 	netdevice_tracker	linkwatch_dev_tracker;
 	netdevice_tracker	watchdog_dev_tracker;
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index a7df573784fd..5cc2f61d7fdf 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -48,6 +48,8 @@ struct xsk_buff_pool {
 	struct device *dev;
 	struct net_device *netdev;
 	struct list_head xsk_tx_list;
+	/* Assigned pools, including deferred releases; protected by RTNL. */
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
index 9d2d94f1fb75..c4d722008670 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
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
@@ -265,6 +270,8 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		err = 0; /* fallback to copy mode */
 	if (err) {
 		xsk_clear_pool_at_qid(netdev, queue_id);
+		hlist_del(&pool->dev_node);
+		pool->netdev = NULL;
 		dev_put(netdev);
 	}
 	return err;
@@ -291,17 +298,29 @@ void xp_clear_dev(struct xsk_buff_pool *pool)
 {
 	struct net_device *netdev = pool->netdev;
 
+	ASSERT_RTNL();
 	if (!pool->netdev)
 		return;
 
 	netdev_lock_ops(netdev);
 	xp_disable_drv_zc(pool);
 	xsk_clear_pool_at_qid(pool->netdev, pool->queue_id);
+	hlist_del(&pool->dev_node);
 	pool->netdev = NULL;
 	netdev_unlock_ops(netdev);
 	dev_put(netdev);
 }
 
+void xp_clear_dev_all(struct net_device *dev)
+{
+	struct xsk_buff_pool *pool;
+	struct hlist_node *next;
+
+	ASSERT_RTNL();
+	hlist_for_each_entry_safe(pool, next, &dev->xsk_pools, dev_node)
+		xp_clear_dev(pool);
+}
+
 static void xp_release_deferred(struct work_struct *work)
 {
 	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,
@@ -337,7 +356,11 @@ bool xp_put_pool(struct xsk_buff_pool *pool)
 
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
base-commit: aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320
change-id: 20260930-xsk-suspend-teardown-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

