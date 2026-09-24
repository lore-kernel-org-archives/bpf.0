Received: from mta1.migadu.com (out-195.mta1.migadu.com [95.215.58.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56E40B0EE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790237927; cv=none; b=sxJ+fqVICGH5uNFOe3TCaTtcNM2Vacsw68opmAaTNEys5Owf5it3tHkzu4EskQ6CLCbjwbvy4x1rrr5wYe8sgoOXxk/gM+fddY6DlMmxftoIZ7FlMpnLrZZC5j9QXFzTmdjmPdCi4d8jHNjYOc2Uf1SZdPUeE+HrS8gRLlXGV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790237927; c=relaxed/simple;
	bh=hiZm/fDY1BSL9L8Z/AeOAzDlzCsEcbpWsqTMEAbyvN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nx7tJoGDuLcvZ09FRXvH9/0QzrtsbigCxLH+kL040VIeDotNp9uN7YRdIJeSwwuvHLic91FGO5yWnvCIUg9PjItkfjaeWKRC+fX+T/4A83O0PhJVMcdUoapddUXIfpc+atEWk4wf4h5JlVk/Mrj6sJcWWvsqRBS08tPG2selJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sir291UN; arc=none smtp.client-ip=95.215.58.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sir291UN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hiZm/fDY1BSL9L8Z/AeOAzDlzCsEcbpWsqTMEAbyvN8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790237923; v=1; x=1790842723;
 b=Sir291UN9YzEVhOComA3klq9auchE5Wgtks/D2/SrsyTWgwsIwoH3jaMsZV731iTLcMIuPB/
 S0WWtttKyT6tsKordtkto1GdTAJT7b7/pZvw8ua5HYymNEhbVkOWbdOBofbYIVxpCpXLRaHHLhM
 +D+rDGv6ktRA89r4ehj1Ip1c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d3ded82f82490e85;
	Thu, 24 Sep 2026 08:18:43 +0000
X-Mizu-Trace-ID: d3ded82f82490e85
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2] bpf: cpumap: fix use-after-free of dev_rx on netdev unregister
Date: Thu, 24 Sep 2026 16:18:27 +0800
Message-ID: <20260924081828.26575-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. The ring holds the ingress device with no reference.

Native XDP stores it in the frame:

	cpu_map_enqueue()
		xdpf->dev_rx = dev_rx;
		bq_enqueue()

Generic XDP queues the skb as is, skb->dev is the ingress device:

	cpu_map_generic_redirect()
		ptr_ring_produce(rcpu->queue, skb);

Both sit in rcpu->queue until the kthread runs.

2. The kthread builds the skb from that pointer and hands it to the
stack, skb->dev has no reference either:

	cpu_map_kthread_run()
		__xdp_build_skb_from_frame()
			eth_type_trans()	/* sets skb->dev */
		gro_receive_skb()

The cpumap XDP prog uses it too, as rxq.dev and in xdp_do_redirect().

3. If the device is torn down while the frames wait in the ring, the
pointer is stale. Nothing in unregister knows about the ring:
flush_all_backlogs() only walks the softnet backlog, synchronize_net()
does not wait for a kthread, and no reference stops free_netdev().
Seen with a veth in a netns, XDP redirect to a cpumap entry, and
"ip link del" while the kthread was not scheduled:

  BUG: KASAN: slab-use-after-free in eth_type_trans+0x4d9/0x590
  Read of size 8 at addr ffff888100634500 by task cpumap/1/map:2/623
  Call Trace:
   <TASK>
   dump_stack_lvl+0x91/0xf0
   print_report+0xd1/0x630
   kasan_report+0xf3/0x130
   __asan_report_load8_noabort+0x14/0x30
   eth_type_trans+0x4d9/0x590
   __xdp_build_skb_from_frame+0x311/0x860
   cpu_map_kthread_run+0x852/0x1ca0
   kthread+0x3a2/0x4d0
   ret_from_fork+0x619/0x8e0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 609:
   __kvmalloc_node_noprof+0x382/0xae0
   alloc_netdev_mqs+0x8a/0x12c0
   rtnl_create_link+0xad5/0xf10
   veth_newlink+0x214/0xb50
   rtnl_newlink+0xd60/0x2640
   rtnetlink_rcv_msg+0x74a/0xc30
   netlink_rcv_skb+0x147/0x400

  Freed by task 631:
   kfree+0x282/0x660
   kvfree+0x31/0x40
   netdev_release+0x6d/0x90
   device_release+0xce/0x250
   kobject_put+0x18d/0x4f0
   netdev_run_todo+0x7fb/0x10f0
   rtnl_dellink+0x392/0xc10
   rtnetlink_rcv_msg+0x74a/0xc30
   netlink_rcv_skb+0x147/0x400

The easy fix is a reference per frame:

	cpu_map_enqueue()
		xdpf->dev_rx = dev_rx;
		dev_hold()
	cpu_map_kthread_run()
		gro_receive_skb()
		dev_put()

GRO is the problem. The skb may stay in rcpu->gro after
gro_receive_skb(), and even after cpu_map_gro_flush() some skbs stay,
flush_old only pushes the old ones. So we can't tell which skbs really
left, and so can't tell when to dev_put(). Doing it right needs a hook
in the GRO core path. Not worth it.

So use the netdev notifier and let the kthread finish its work before
the device is freed:

1. On NETDEV_UNREGISTER, take the ring size and ask the kthread to
   consume that many frames, or until the ring is empty. After that,
   every frame that was in the ring has been handled by the stack or
   dropped. The device is closed, so no new frames for it can show up.
2. The kthread wakes the notifier once it got there. The device is
   still alive until then, so the frames go up the stack as usual.
   Nothing is dropped and frames of other devices are not told apart,
   unlike flush_backlog(), which only frees the skbs of that device.
3. On the last round of the drain, flush GRO fully, flush_old is 0.
   Every other round keeps the flush logic as is.

Entry teardown stops the kthread under the same mutex and unlinks the
entry after that, so an unregister can't slip in while the ring still
has frames, and the notifier never waits on a kthread that is gone.

One hole is left: the cpumap prog may redirect the frame to another
cpumap entry, and that ring may have reported done already. So while
the device is unregistering, drop on XDP_REDIRECT instead. That check
only runs when the prog picks XDP_REDIRECT. The check, the redirect and
the flush are one RCU read section, and unregister does
synchronize_net() before the notifier runs, so a frame that passed the
check is in the target ring before the drain starts.

The notifier has to ask every entry, a cpumap entry is not tied to a
netns and any device can feed it. So an unregister anywhere drains
every ring in the system, once per device, with RTNL held. That is
bounded: qsize is capped at 16384, each entry consumes at most one
ring plus a GRO flush, and the kthreads do it in parallel. Those
frames had to be consumed anyway. Nothing changes on the hot path,
the kthread reads one field per batch.

Fixes: 1c601d829ab0 ("bpf: cpumap xdp_buff to skb conversion and allocation")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2 -> v3: point Fixes at the commit that stores and uses dev_rx, spell
out in the message that the drain under RTNL is bounded by qsize.
v2: https://lore.kernel.org/bpf/20260922121022.256777-1-jiayuan.chen@linux.dev/
v1 -> v2: stop the kthread under cpu_map_mutex in entry teardown, so an
unregister can't miss frames still in the ring. Reword the message,
trim comments.
v1: https://lore.kernel.org/bpf/DLKA28VU4GIV.I4EVTT076Y5Q@gmail.com/

Local review asked about the full GRO flush handing skbs of the
unregistering device to RPS after flush_all_backlogs() ran. That can't
happen: enqueue_to_backlog() drops skbs whose device is not running,
and dev_close() cleared that before reg_state changed.

Local review also flagged that a full GRO flush can hand a PTP packet to
skb_defer_rx_timestamp(), which keeps skb->dev in the PHY driver's
queue. That needs dev->phydev, which phy_disconnect() clears on
dev_close(), before reg_state changes. Anything queued before that is
owned by the PHY driver, same as on the normal NAPI path. Not a cpumap
issue, so not handled here.
---
 kernel/bpf/cpumap.c | 93 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 5e59ab896f058..0c9647f28034d 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -74,8 +74,15 @@ struct bpf_cpu_map_entry {
 
 	struct completion kthread_running;
 	struct rcu_work free_work;
+
+	struct list_head list;
+	wait_queue_head_t drain_wq;
+	u32 drain_left; /* frames to consume, see cpu_map_netdev_event() */
 };
 
+static LIST_HEAD(cpu_map_list);
+static DEFINE_MUTEX(cpu_map_mutex);
+
 struct bpf_cpu_map {
 	struct bpf_map map;
 	/* Below members specific for map type */
@@ -136,6 +143,12 @@ static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 	}
 }
 
+/* cpumap to cpumap redirect, the target ring may be done draining already */
+static bool cpu_map_dev_unregistering(const struct net_device *dev)
+{
+	return unlikely(READ_ONCE(dev->reg_state) != NETREG_REGISTERED);
+}
+
 static u32 cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 				    void **skbs, u32 skb_n,
 				    struct xdp_cpumap_stats *stats)
@@ -153,6 +166,11 @@ static u32 cpu_map_bpf_prog_run_skb(struct bpf_cpu_map_entry *rcpu,
 			skbs[pass++] = skb;
 			break;
 		case XDP_REDIRECT:
+			if (cpu_map_dev_unregistering(skb->dev)) {
+				kfree_skb(skb);
+				stats->drop++;
+				break;
+			}
 			err = xdp_do_generic_redirect(skb->dev, skb, &xdp,
 						      rcpu->prog);
 			if (unlikely(err)) {
@@ -213,6 +231,11 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 			}
 			break;
 		case XDP_REDIRECT:
+			if (cpu_map_dev_unregistering(xdpf->dev_rx)) {
+				xdp_return_frame(xdpf);
+				stats->drop++;
+				break;
+			}
 			err = xdp_do_redirect(xdpf->dev_rx, &xdp,
 					      rcpu->prog);
 			if (unlikely(err)) {
@@ -310,14 +333,16 @@ static int cpu_map_kthread_run(void *data)
 		struct cpu_map_ret ret = { };
 		void *frames[CPUMAP_BATCH];
 		void *skbs[CPUMAP_BATCH];
-		u32 i, n, m;
+		bool drained = false;
+		u32 i, n, m, left;
 		bool empty;
 
 		/* Release CPU reschedule checks */
 		if (__ptr_ring_empty(rcpu->queue)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			/* Recheck to avoid lost wake-up */
-			if (__ptr_ring_empty(rcpu->queue)) {
+			if (__ptr_ring_empty(rcpu->queue) &&
+			    !READ_ONCE(rcpu->drain_left)) {
 				schedule();
 				sched = 1;
 				last_qs = jiffies;
@@ -398,10 +423,23 @@ static int cpu_map_kthread_run(void *data)
 		/* Flush either every 64 packets or in case of empty ring */
 		packets += n;
 		empty = __ptr_ring_empty(rcpu->queue);
-		if (packets >= NAPI_POLL_WEIGHT || empty) {
-			cpu_map_gro_flush(rcpu, empty);
+		left = READ_ONCE(rcpu->drain_left);
+		if (unlikely(left)) {
+			/* We are draining, drained is true on the last round */
+			left -= min(n, left);
+			drained = empty || !left;
+			if (!drained)
+				WRITE_ONCE(rcpu->drain_left, left);
+		}
+		if (packets >= NAPI_POLL_WEIGHT || empty || drained) {
+			cpu_map_gro_flush(rcpu, empty || drained);
 			packets = 0;
 		}
+		/* Only report back once GRO is flushed too */
+		if (unlikely(drained)) {
+			WRITE_ONCE(rcpu->drain_left, 0);
+			wake_up(&rcpu->drain_wq);
+		}
 
 		local_bh_enable(); /* resched point, may call do_softirq() */
 	}
@@ -473,6 +511,7 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	rcpu->map_id = map->id;
 	rcpu->value.qsize  = value->qsize;
 	gro_init(&rcpu->gro);
+	init_waitqueue_head(&rcpu->drain_wq);
 
 	if (fd > 0) {
 		err = __cpu_map_load_bpf_program(rcpu, map, fd);
@@ -500,6 +539,10 @@ __cpu_map_entry_alloc(struct bpf_map *map, struct bpf_cpumap_val *value,
 	 */
 	wait_for_completion(&rcpu->kthread_running);
 
+	mutex_lock(&cpu_map_mutex);
+	list_add_tail(&rcpu->list, &cpu_map_list);
+	mutex_unlock(&cpu_map_mutex);
+
 	return rcpu;
 
 free_prog:
@@ -530,9 +573,13 @@ static void __cpu_map_entry_free(struct work_struct *work)
 
 	/* kthread_stop will wake_up_process and wait for it to complete.
 	 * cpu_map_kthread_run() makes sure the pointer ring is empty
-	 * before exiting.
+	 * before exiting. Under the mutex, so the notifier sees either the
+	 * frames or no entry.
 	 */
+	mutex_lock(&cpu_map_mutex);
 	kthread_stop(rcpu->kthread);
+	list_del(&rcpu->list);
+	mutex_unlock(&cpu_map_mutex);
 
 	if (rcpu->prog)
 		bpf_prog_put(rcpu->prog);
@@ -832,3 +879,39 @@ void __cpu_map_flush(struct list_head *flush_list)
 		wake_up_process(bq->obj->kthread);
 	}
 }
+
+/* Frames in the ring and skbs in GRO hold a raw pointer to the ingress
+ * device, make every kthread consume them before the device is freed.
+ */
+static int cpu_map_netdev_event(struct notifier_block *nb,
+				unsigned long event, void *ptr)
+{
+	struct bpf_cpu_map_entry *rcpu;
+
+	if (event != NETDEV_UNREGISTER)
+		return NOTIFY_OK;
+
+	mutex_lock(&cpu_map_mutex);
+	list_for_each_entry(rcpu, &cpu_map_list, list) {
+		/* the whole ring, plus a batch already pulled out */
+		WRITE_ONCE(rcpu->drain_left, rcpu->queue->size + CPUMAP_BATCH);
+		wake_up_process(rcpu->kthread);
+	}
+	list_for_each_entry(rcpu, &cpu_map_list, list)
+		wait_event(rcpu->drain_wq, !READ_ONCE(rcpu->drain_left));
+	mutex_unlock(&cpu_map_mutex);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpu_map_notifier = {
+	.notifier_call = cpu_map_netdev_event,
+};
+
+static int __init cpu_map_init(void)
+{
+	register_netdevice_notifier(&cpu_map_notifier);
+
+	return 0;
+}
+subsys_initcall(cpu_map_init);
-- 
2.43.0

