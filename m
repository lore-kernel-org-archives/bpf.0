Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5E246C841
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278637; cv=none; b=UBAlV91zZFKgKqJGzBH2UYRmtCl9wXqA82Pc1hhoFJoMyflbGyXRWH11qJsR5YNdvMoY2ktCrG8t2+V/xI87BG5HxMWZe3Cm5tE9y7turDysdr1kbrpMh/G2EPtV5p1wZ/I6+wDr+l2tGgzVxaUVKt+JlMhkvlIoZIABzkF24+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278637; c=relaxed/simple;
	bh=3NNCGH5ryw+BpbquvEdcLuzcP9h3hRy3kqLMJgFGGJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzS+qQweDOQwxPVYchpK4Gzf6nkFKIgTfcm1ZBm+ZEZxNMY1JYJ8iQsYftiuNskak1HNHb3BPTGxh2ZRPsDZoHEDMz2/33UpYnWcYiKimLs3/Fi5UVyFLdB9wCY555lLZ5n54jGh6RN+b87Hq68ZlC5bZlhtpBX8xSMhaiqIfCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/3w4+yN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/3w4+yN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e5378b281aso4014125ad.2
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278635; x=1792883435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WG4JK4jcwaSqli0Rkxkj+xPO6Y6Xri8N8nem+swVpHc=;
        b=H/3w4+yNqxNvcTWlEZ7B9vhAKhjN0fQEgKd4o+UF9vgdcDwXJk6o9swH6U1etAjcs0
         XBwCXEl4S+dtGLwS6REBvlLyMc8gedN6E0R+eouWQhWtOJvdlTP2zzucZ0b1IV2q6UOR
         RgWLpnZ8tMJvang0oREbcV+0ssqu+yte4Y7ObrDj2P1qYkuzuqiv7sAu0KH+7viR+KvW
         dxeaxHdX+p8Qago9ij8QX8gEjOCxcJyF4xKAvUdsIVAdB7r9Gf+qsHEOA8KyyFkUwMGS
         e0cIAHInCPOXAAq8hc4MXHI+8oapOr5BoA+wepue59dChS2cJBcEkiBqeuJOswiKYbnh
         o4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278635; x=1792883435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WG4JK4jcwaSqli0Rkxkj+xPO6Y6Xri8N8nem+swVpHc=;
        b=bferlArztTqd7gFzzkFWiQd4Na/h6Aaw29nfhw94h8wTly6YOSdjKPO6/RbE3TSbsB
         kWNrU0ZE4Kg1AZQZNV62pkMtGr30GUiyh6q6Arjf05hEIxO1H3B5i0yUOFN6JqQ8WU2D
         AZUlSaKsT+mmYvn8WdRsJmlbsICDAU2NdyB//c+ggQc2NfuDvwfzTtkmTWGu2YouyFMX
         fXtAPcotZOX1XYWeXBgJRhnwwPiut5ziPOw1f4hdSkYeaOAvRZnio7sPgJTVYumHkFnM
         hRsnTVttTOYBb+VBUafesnEdSYG/gVC1unPdq1YLLxqM5NNuvY8ts7dVTJ4E0hdQctDA
         NCyQ==
X-Gm-Message-State: AFq9FYKxNbt7lwZDFJX5+zwkyzyAfcXeytVHpzxKtjq539NedLj5aP/f
	XuDp4F7E/I3YheX57TBzys5f5TgQC+HHZto6dTd7x+laOPg3b1FgEfKZlYQU6g==
X-Gm-Gg: AYBFou3qeXhgjwaEJpW0KBxftVKPhdQJgdGRggbSiUuOLqjsoLUsiIpFSR7imhSiqsR
	su7XKgNoh7pxEhBe70+xdcNWd0KuxdEcBwRGzLr1mwIvLQNPY+vrqj1Z9Blm7qQwn+bVXDsYnch
	WAyUnOFJTEgpcoVstaPw/eV5SYYNvBzmF+eqC7anfPNFrzGxyd4vEtCLpQRyeJ7/zsvmXQy4pDG
	tVzSYEmRIRyDdzZb427ePZ1G7Ja+9uVUtzAMr/2zWm9ereiCMRL1qQhvxAo7Jno7JdM39RqPffM
	qfwX+wyx0TrqlaHtNurvRmrCvCmt1tAHj1bccVZlXGZRRbBiW2PxSo2rSbrEBdQI0VU02WOA6FA
	ELylHOl9Gogd2LxsP6FKDQkCzpDcLRe7Cc5QJr1N+ZBzw8EJH4ye9otDirV0nq9BF1Z2C477/1l
	O0zSZydXGAvZjGHNCnBXEPMqO1hMJkrlahM822KpMdHfIilRjNWmW0aqHP6EAFNQ3VxZzu5a0En
	dBh279Ooq87xruTyJ2mx3uFZ8CGU/q7/zfKnTNUv7jVWutySXNA80Pi6a6ZT+YV0Oj/8E04alph
	7PMymn9xLOZLEVBkLIGl68VAYgCK0JyqmtadwWbjIgTqkhjah7RxXwM=
X-Received: by 2002:a17:902:f641:b0:2e6:7c6:8d40 with SMTP id d9443c01a7336-2e9a69e8f85mr34941425ad.27.1792278635391;
        Sat, 17 Oct 2026 16:10:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8775besm23860955ad.51.2026.10.17.16.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:35 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 07/16] bpf, cpumap: Hold the device of frames in the queue
Date: Sat, 17 Oct 2026 23:09:41 +0000
Message-ID: <20261017230950.802052-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
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

