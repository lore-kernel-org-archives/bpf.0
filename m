Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCD38A719
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772901274; cv=none; b=YtVWLfxWZiljmckaPTTcuiHYoHq7H3bCKNFgG47nolmmVP38a3+0OY26Dkzpodlap8pp/Rp3i2f0QoAg0DhsIGqP8FTEcyhz0iGCweNwLJI/NXdN+31Sq17n9YRioN+fTieUmyjogmsRc5c9M/oqnmnDnFXYnqjO9LynnP5vWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772901274; c=relaxed/simple;
	bh=TanHhOYEtuKFFolNKHEneRF1CLOPB8FiyE4E1WsqtUs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JNvOZgM/1OTFoqTtZL7rYFFmnew30F2wSgY6lvCzKzzg8hDOrKLe9aG0APmCyc50akLNCnt4lc56andcszv5kuHIXjzNn2QBxmM6JjG71ZMfQCHkrseDU56UDimLo9f1yWSrJnkrSYf8YDGztk+eAuObIqZSasyZtLXB3P+w65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcPZd08O; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcPZd08O"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5090e08dcfcso8267131cf.0
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 08:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772901271; x=1773506071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B/L2NtnWYT3/D//o5Owk0t4WwkSxK6Eq0HsnAyfct5U=;
        b=HcPZd08O+354eiyTJukeC5QRk128OI0FT/1OMmZaAn6QkboaVjpEUFW+JTSQt5Aaq8
         jVEmM1ZRx1ncZjSYdcESh4InB/oUjR7tYgG2hxsNjRUnCkGk5t+x3/W/th1bfiF2qfPc
         oKG7foZQLSzUZXkTIoIGRSz0A1hyNmqEvoXb1xedkJB+NGS1ha/6B/4IzEZG4cKVjOWB
         AE3sM1xan58vlIFBPn5cpru2jwwrloMnizXigiZit6/foFkD/nLUkjLxCE72wwcsFhYd
         7GpGuhBXFZYals1m47BYv5TeylSPt7OLXXg4HXtPj2gWNG95t2w1r4Vt9mJjlcaA3RCo
         OfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772901271; x=1773506071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/L2NtnWYT3/D//o5Owk0t4WwkSxK6Eq0HsnAyfct5U=;
        b=froaoL/YVHGgRhlXwyWipLuDaa+vwEV90oNrxmu7kPXGlJag4Z37DHUhyndSkFV8wO
         aZY91y7PM0UG/IoDiRo+Qh1FyiWkYfBvvlswD+2jXJj1koFtj0CBmomytHwDl/5+25d/
         UX4ww5GWbKXL865qrZoWACXdndCIJJvRG7X4m9uEhqxcy37fegiO+X9iH+xB8sd//t75
         POK7JnGtTGIXGUb1b2oklKBHRGs3PSYi3uyXltbBLqD0aYWn4uwe7nvkKwyZ6/TK8akf
         F54Q1umDbvuoyMiy5fEIGx8qqSr+BXMNdrQ1WD16dtWRqI2xTz/Tfxmbtqr+dxEMZd3F
         L7yw==
X-Forwarded-Encrypted: i=1; AJvYcCW9nx8rNP6dWCkqpvoCDgugkDqe7CFq8WuQtEqu+JIp8sQc3526GrmraiVEKGSD805JDpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiV0R/BD1KbNXkn7j1qxDSlQGYEhCA0Rvl+W8NKPEkuKs9VQkt
	Jf/JGkPMcgGB9+O9khCnIWnQnpULzhviQT6uEHh1Ueqycnt768GR41KkRXfTiEpNnudqobdbcYO
	KKSgxQYV3sHrXgw==
X-Received: from qtuu11-n2.prod.google.com ([2002:a05:622a:aa4b:20b0:501:1ae8:35f9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5fd0:0:b0:4ee:1e63:a4e0 with SMTP id d75a77b69052e-508f4976c0fmr80792051cf.74.1772901271483;
 Sat, 07 Mar 2026 08:34:31 -0800 (PST)
Date: Sat,  7 Mar 2026 16:34:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307163430.470644-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net/sched: do not reset queues in graft operations
From: Eric Dumazet <edumazet@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yunsheng Lin <linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Following typical script is extremely disruptive,
because each graft operation calls dev_deactivate()
which resets all the queues of the device.

QPARAM="limit 100000 flow_limit 1000 buckets 4096"
TXQS=64
for ETH in eth1
do
 tc qd del dev $ETH root 2>/dev/null
 tc qd add dev $ETH root handle 1: mq
 for i in `seq 1 $TXQS`
 do
   slot=$( printf %x $(( i )) )
   tc qd add dev $ETH parent 1:$slot fq $QPARAM
 done
done

One can add "ip link set dev $ETH down/up" to reduce the disruption time:

QPARAM="limit 100000 flow_limit 1000 buckets 4096"
TXQS=64
for ETH in eth1
do
 ip link set dev $ETH down
 tc qd del dev $ETH root 2>/dev/null
 tc qd add dev $ETH root handle 1: mq
 for i in `seq 1 $TXQS`
 do
   slot=$( printf %x $(( i )) )
   tc qd add dev $ETH parent 1:$slot fq $QPARAM
 done
 ip link set dev $ETH up
done

Or we can add a @reset_needed flag to dev_deactivate() and
dev_deactivate_many().

This flag is set to true at device dismantle or linkwatch_do_dev(),
and to false for graft operations.

In the future, we might only stop one queue instead of the whole
device, ie call dev_deactivate_queue() instead of dev_deactivate().

I think the problem (quadratic behavior) was added in commit
2fb541c862c9 ("net: sch_generic: aviod concurrent reset and enqueue op
for lockless qdisc") but this does not look serious enough to deserve
risky backports.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
---
v2: clarified the changelog
    added kdoc missing part (kernel build bots)

 include/net/sch_generic.h |  4 ++--
 net/core/dev.c            |  2 +-
 net/core/link_watch.c     |  2 +-
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_generic.c   | 20 ++++++++++++--------
 net/sched/sch_htb.c       |  4 ++--
 net/sched/sch_mq.c        |  2 +-
 net/sched/sch_mqprio.c    |  2 +-
 net/sched/sch_taprio.c    |  2 +-
 9 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c355300893a3921740cf6b919cc58de953cd610c..16beba40914ee5a9454f9eec2ad6e600543c89f2 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -710,8 +710,8 @@ void dev_qdisc_change_real_num_tx(struct net_device *dev,
 void dev_init_scheduler(struct net_device *dev);
 void dev_shutdown(struct net_device *dev);
 void dev_activate(struct net_device *dev);
-void dev_deactivate(struct net_device *dev);
-void dev_deactivate_many(struct list_head *head);
+void dev_deactivate(struct net_device *dev, bool reset_needed);
+void dev_deactivate_many(struct list_head *head, bool reset_needed);
 struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev_queue,
 			      struct Qdisc *qdisc);
 void qdisc_reset(struct Qdisc *qdisc);
diff --git a/net/core/dev.c b/net/core/dev.c
index 203dc36aaed55e706f5d978ec02c6bf48201e3d4..6fc9350f0be8756ae849d5b0ca9b222055d96ced 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1756,7 +1756,7 @@ static void __dev_close_many(struct list_head *head)
 		smp_mb__after_atomic(); /* Commit netif_running(). */
 	}
 
-	dev_deactivate_many(head);
+	dev_deactivate_many(head, true);
 
 	list_for_each_entry(dev, head, close_list) {
 		const struct net_device_ops *ops = dev->netdev_ops;
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 25c455c10a01cf535d6a7d2952d51434fe462690..ff2c1d4538efbc89cd49d8d8477542a6e7bacbad 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -181,7 +181,7 @@ static void linkwatch_do_dev(struct net_device *dev)
 		if (netif_carrier_ok(dev))
 			dev_activate(dev);
 		else
-			dev_deactivate(dev);
+			dev_deactivate(dev, true);
 
 		netif_state_change(dev);
 	}
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index cc43e3f7574fae203989f5c28b4934f0720e64c2..c0bab092ea809955b3a5aaa08c169bca55cfaf7f 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1120,7 +1120,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		}
 
 		if (dev->flags & IFF_UP)
-			dev_deactivate(dev);
+			dev_deactivate(dev, false);
 
 		qdisc_offload_graft_root(dev, new, old, extack);
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 556e0d8003161d3dfe68e484f6349714cf989c0c..d4fe907c4ad5895b1dda5249c55e4c1e0168023e 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1370,11 +1370,12 @@ static bool some_qdisc_is_busy(struct net_device *dev)
 /**
  * 	dev_deactivate_many - deactivate transmissions on several devices
  * 	@head: list of devices to deactivate
+ *	@reset_needed: qdisc should be reset if true.
  *
  *	This function returns only when all outstanding transmissions
  *	have completed, unless all devices are in dismantle phase.
  */
-void dev_deactivate_many(struct list_head *head)
+void dev_deactivate_many(struct list_head *head, bool reset_needed)
 {
 	bool sync_needed = false;
 	struct net_device *dev;
@@ -1393,11 +1394,14 @@ void dev_deactivate_many(struct list_head *head)
 	if (sync_needed)
 		synchronize_net();
 
-	list_for_each_entry(dev, head, close_list) {
-		netdev_for_each_tx_queue(dev, dev_reset_queue, NULL);
+	if (reset_needed) {
+		list_for_each_entry(dev, head, close_list) {
+			netdev_for_each_tx_queue(dev, dev_reset_queue, NULL);
 
-		if (dev_ingress_queue(dev))
-			dev_reset_queue(dev, dev_ingress_queue(dev), NULL);
+			if (dev_ingress_queue(dev))
+				dev_reset_queue(dev, dev_ingress_queue(dev),
+						NULL);
+		}
 	}
 
 	/* Wait for outstanding qdisc_run calls. */
@@ -1412,12 +1416,12 @@ void dev_deactivate_many(struct list_head *head)
 	}
 }
 
-void dev_deactivate(struct net_device *dev)
+void dev_deactivate(struct net_device *dev, bool reset_needed)
 {
 	LIST_HEAD(single);
 
 	list_add(&dev->close_list, &single);
-	dev_deactivate_many(&single);
+	dev_deactivate_many(&single, reset_needed);
 	list_del(&single);
 }
 EXPORT_SYMBOL(dev_deactivate);
@@ -1473,7 +1477,7 @@ int dev_qdisc_change_tx_queue_len(struct net_device *dev)
 	int ret = 0;
 
 	if (up)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		ret = qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index cf6cd4ccfa2029d9a45e35d6780520290690732d..eb12381795ce1bb0f3b8c5f502e16ad64c4408c8 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1387,7 +1387,7 @@ htb_graft_helper(struct netdev_queue *dev_queue, struct Qdisc *new_q)
 	struct Qdisc *old_q;
 
 	if (dev->flags & IFF_UP)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 	old_q = dev_graft_qdisc(dev_queue, new_q);
 	if (new_q)
 		new_q->flags |= TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
@@ -1421,7 +1421,7 @@ static void htb_offload_move_qdisc(struct Qdisc *sch, struct htb_class *cl_old,
 		struct Qdisc *qdisc;
 
 		if (dev->flags & IFF_UP)
-			dev_deactivate(dev);
+			dev_deactivate(dev, false);
 		qdisc = dev_graft_qdisc(queue_old, NULL);
 		WARN_ON(qdisc != cl_old->leaf.q);
 	}
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index 0ed199fa18f04a06197116b6ab64ff3647dbace9..a0133a7b9d3b09a0d2a6064234c8fdef60dbf955 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -201,7 +201,7 @@ static int mq_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
 	struct net_device *dev = qdisc_dev(sch);
 
 	if (dev->flags & IFF_UP)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 
 	*old = dev_graft_qdisc(dev_queue, new);
 	if (new)
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index b83276409416fabeccc441e5127211632ddcfedb..002add5ce9e0ab04a6260495d1bec02983c2a204 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -469,7 +469,7 @@ static int mqprio_graft(struct Qdisc *sch, unsigned long cl, struct Qdisc *new,
 		return -EINVAL;
 
 	if (dev->flags & IFF_UP)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 
 	*old = dev_graft_qdisc(dev_queue, new);
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index f721c03514f6008ecc59fe4c4ca4a082099dc125..8e375281195061da848fb2bfaf79cf125afccac0 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -2184,7 +2184,7 @@ static int taprio_graft(struct Qdisc *sch, unsigned long cl,
 		return -EINVAL;
 
 	if (dev->flags & IFF_UP)
-		dev_deactivate(dev);
+		dev_deactivate(dev, false);
 
 	/* In offload mode, the child Qdisc is directly attached to the netdev
 	 * TX queue, and thus, we need to keep its refcount elevated in order
-- 
2.53.0.473.g4a7958ca14-goog

