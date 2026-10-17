Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E421D5B0
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200792; cv=none; b=pdH+pfVlKk6PU0/9C2MAM+Eaagi1JD47tF5rcLDtgAb8zdqi2vEyyVkcf0DswLCTE9SRz7vunRYZwD5ZkYHiDbBBRyqyWpnXz+fZdOCuVh4MSwpjDA1ORGA2yzd/p37Gl6g8gBq8IL3Ig1dH/zQgmtE6s5iGMoEOskV6XigTATU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200792; c=relaxed/simple;
	bh=3NNCGH5ryw+BpbquvEdcLuzcP9h3hRy3kqLMJgFGGJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zq6W9T3ZoDjkN1k9sYgQfrxtKFNkuF/EHdUQnv2Atf0n6QckT/UwWGT+U10ho6wNaJObMdVeWqMk71sjjVgR7VxmvVk6kMIfXcUgW2FX2Z5vOmwvOCPc2iyZM4i5o7faWsXHYLmcO6omIzJwc+pMpGbJs1pOjYUaqWWO85ZLRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMma02vy; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMma02vy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e99b1e5b4cso2150125ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200791; x=1792805591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WG4JK4jcwaSqli0Rkxkj+xPO6Y6Xri8N8nem+swVpHc=;
        b=GMma02vysLaGsBDOf9eyE7/Ofsi3NbYCGhSScHVg96vDhZV1YZAEhk/sKgybqQNBJ1
         e7rgvhKdUeR9dYHheSb/i1CM/Bwdiz6eJjVCDyjetr6kqFj5/YASNuhjJBm9BWKZS1C6
         AK+/JhdIrVz0fNtp1MjLPdD2nOW/e54/a/DxoLju/ga5u7HMkEJ9Fe5R5wB0UQUUHWKn
         BUSMY9YbpcG2wk5IqgJUbIfwNhQaLY4Ovs7qqjez5SRUIBv7eGPh5ltinPrlyJXJkjSN
         xYE73poyrErFnPFEACajOuLXURMs2xYblBYrrlByLjIMmkRLppjIfDSa1Lg/O83+Znzz
         gigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200791; x=1792805591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WG4JK4jcwaSqli0Rkxkj+xPO6Y6Xri8N8nem+swVpHc=;
        b=wpUzC8mi8A31xtoz1ItLkJFR2hLmaTmiJXRsWeL8mtKehHy5hbtgdKfWRz/rirl2G/
         Elu13rY5NELL2ISYr+NpDBDAOng2hUTK1yG+h8QerS/xCn1awc1CmDTQ8cdqKeM3Cw5S
         bIy8m77b9Gtgx/uZ61oTGmg97PRkxvGBZSUZ26S37oVyI0FbgEdcUKJHDW8TEHP/ZRJh
         1afN5iEuDIHEonvnLwntU7iPNdMZo9oUHxznLkltKIuFXghbkUBJYrFUf/VtmKX9yvs4
         wsC8CT6983BqhEjwRqxJMQ5+sZ0ipFBXNWvoTw3bXHXyssUN8pLUcg/WhMM1lGhKxIwO
         WNeA==
X-Gm-Message-State: AFq9FYLA8yOJ71kBJNhlnwIwAd4VWnCa7Z8dXUGG6gnU94gftJQmTHtk
	6bVQxY10QDbTo6C5y1N4vRFMUfKoteslI9xZmZkWspkvp80SnpZj/2j8W6uZwlyf
X-Gm-Gg: AYBFou2nCRKnCt2EXezlhisXCYKBL1jsMkRlUxE9oTx1EmkRNMT/f5eEelWjiDAIi3e
	oFPqeRG8mdzUIcGm4OEInPVqXVjJzEpBIlKQDGWTKBQ9etYBM/c4SdMuT1sXtOA1LqYDukwXZUP
	tdeviJPkfsSPPYwKK61zyeAKCHmcz17aV8/dTREYDbiKiSUtITlUWK9KcGV8PU+LfB6kUmxHJAU
	QRS8ohzscrqjsXQAkJpoHJKJymKveSxeHIjsSSdDP+/9UN/2ERlN0NVLnb/AgvSpf6DUXlb0Q7N
	qkCRCG/nIKYVr9Un/3aFi0f6wnb+WdGRJ42cXmdt8fR2HvOJX7Z3SvGpVj20k/GeyMbTN194Ocu
	RfIsDswpd7Kw2npADv1Q1BXitE+YbqOQ49TOEEZ5VXweLd8DC/HecURNivU8M1NowjY6EY2xMoG
	5sR8px/A3/FGMzrzqHY6xDB6ygNE1Ran8/kkkGvm52lyrbBYUNp20IH6zcVdjaUY9dWsJKhIquC
	W5VwfBgBqdLSIX+C6PRoS++lhUidyvMetVdwhtsuvxTQmwD7qZboqvwczxS5zefCJ177mjk8Igb
	VPqUAgqsreY3KIo+WEZFodJ6HQUhN8iwyoLClctNiSA=
X-Received: by 2002:a17:903:2f88:b0:2e9:5ed2:c3a3 with SMTP id d9443c01a7336-2e9a6c1f257mr13693255ad.37.1792200790499;
        Fri, 16 Oct 2026 18:33:10 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b98a9sm17657715ad.74.2026.10.16.18.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:33:09 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 32/38] bpf, cpumap: Hold the device of frames in the queue
Date: Sat, 17 Oct 2026 01:24:45 +0000
Message-ID: <20261017012451.364800-24-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A frame that is redirected to another CPU waits in the queue of the cpumap
entry with a plain pointer to the device it came from, and an skb from
generic XDP with skb->dev.  Nothing keeps that device.  Closing and
unregistering it waits for its NAPI and for RCU, but not for the kthread
of the entry.  If the kthread is late by more than that, since its CPU is
busy with something of a higher priority, it builds skbs for a device that
has been freed and hands them to the stack:

  BUG: KASAN: use-after-free in dev_gro_receive+0x1f51/0x2b30
  Read of size 8 at addr ffff88800a7340b0 by task cpumap/1/map:1/54

Take a reference to the device for each entry of the queue.  The kthread
cannot drop it at the end of the batch, since its GRO node may keep the skb
for longer.  Let it note the devices and drop the references behind a full
GRO flush, which it does whenever the queue is empty, and from now on also
when it has noted about 2048 of them.

A device whose frames are stuck in a queue is now unregistered only when
the kthread has got to them.  RTNL is not held meanwhile, but if the device
goes with its network namespace, the cleanup of all namespaces waits.

Fixes: 1c601d829ab0 ("bpf: cpumap xdp_buff to skb conversion and allocation")
Fixes: 11941f8a8536 ("bpf: cpumap: Implement generic cpumap")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cpumap.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 5e59ab896f05..eb87131b1bef 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -45,6 +45,7 @@
  */
 
 #define CPU_MAP_BULK_SIZE 8  /* 8 == one cacheline on 64-bit archs */
+#define CPU_MAP_HELD_DEVS 2048
 struct bpf_cpu_map_entry;
 struct bpf_cpu_map;
 
@@ -74,6 +75,13 @@ struct bpf_cpu_map_entry {
 
 	struct completion kthread_running;
 	struct rcu_work free_work;
+
+	/*
+	 * Every frame and skb in the queue holds a reference to its device.
+	 * The kthread keeps it until nothing is left in GRO.
+	 */
+	struct net_device *held[CPU_MAP_HELD_DEVS];
+	u32 nr_held;
 };
 
 struct bpf_cpu_map {
@@ -129,9 +137,11 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 		WARN_ON_ONCE(1);
 		if (unlikely(__ptr_test_bit(0, &ptr))) {
 			__ptr_clear_bit(0, &ptr);
+			dev_put(((struct sk_buff *)ptr)->dev);
 			kfree_skb(ptr);
 			continue;
 		}
+		dev_put(((struct xdp_frame *)ptr)->dev_rx);
 		xdp_return_frame(ptr);
 	}
 }
@@ -311,7 +321,7 @@ static int cpu_map_kthread_run(void *data)
 		void *frames[CPUMAP_BATCH];
 		void *skbs[CPUMAP_BATCH];
 		u32 i, n, m;
-		bool empty;
+		bool empty, full;
 
 		/* Release CPU reschedule checks */
 		if (__ptr_ring_empty(rcpu->queue)) {
@@ -344,10 +354,12 @@ static int cpu_map_kthread_run(void *data)
 				struct sk_buff *skb = f;
 
 				__ptr_clear_bit(0, &skb);
+				rcpu->held[rcpu->nr_held++] = skb->dev;
 				skbs[ret.skb_n++] = skb;
 				continue;
 			}
 
+			rcpu->held[rcpu->nr_held++] = ((struct xdp_frame *)f)->dev_rx;
 			frames[ret.xdp_n++] = f;
 			page = virt_to_page(f);
 
@@ -398,10 +410,13 @@ static int cpu_map_kthread_run(void *data)
 		/* Flush either every 64 packets or in case of empty ring */
 		packets += n;
 		empty = __ptr_ring_empty(rcpu->queue);
-		if (packets >= NAPI_POLL_WEIGHT || empty) {
-			cpu_map_gro_flush(rcpu, empty);
+		full = empty || rcpu->nr_held > CPU_MAP_HELD_DEVS - CPUMAP_BATCH;
+		if (packets >= NAPI_POLL_WEIGHT || full) {
+			cpu_map_gro_flush(rcpu, full);
 			packets = 0;
 		}
+		while (full && rcpu->nr_held)
+			dev_put(rcpu->held[--rcpu->nr_held]);
 
 		local_bh_enable(); /* resched point, may call do_softirq() */
 	}
@@ -738,12 +753,14 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
 
 	for (i = 0; i < bq->count; i++) {
 		struct xdp_frame *xdpf = bq->q[i];
-		int err;
 
-		err = __ptr_ring_produce(q, xdpf);
-		if (err) {
+		if (__ptr_ring_full(q)) {
 			drops++;
 			xdp_return_frame_rx_napi(xdpf);
+		} else {
+			/* The device cannot go before the flush, from now on it can */
+			dev_hold(xdpf->dev_rx);
+			__ptr_ring_produce(q, xdpf);
 		}
 		processed++;
 	}
@@ -807,11 +824,15 @@ int cpu_map_generic_redirect(struct bpf_cpu_map_entry *rcpu,
 
 	__skb_pull(skb, skb->mac_len);
 	skb_set_redirected(skb, false);
+	dev_hold(skb->dev);
 	__ptr_set_bit(0, &skb);
 
 	ret = ptr_ring_produce(rcpu->queue, skb);
-	if (ret < 0)
+	if (ret < 0) {
+		__ptr_clear_bit(0, &skb);
+		dev_put(skb->dev);
 		goto trace;
+	}
 
 	wake_up_process(rcpu->kthread);
 trace:
-- 
2.55.0

