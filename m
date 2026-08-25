Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1638B7D4
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 05:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635435; cv=none; b=LhERSRuVxSGwDtolDy2uX6qDhLd2WqMkR2Dm+23N2wrvAWJwNXmgwBk2dz89DheZ6oXaqkB2XU3oZejfaExm1CwrpeUuFO+X+T9VNkxDOEVJZ0E0GuIw2hYxC4JaoVvX7qRm5FI4fr7Vs2ww8WjeIxrhnx2KDQV1F37yIM4o060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635435; c=relaxed/simple;
	bh=d3aO4V0vD69y29p/81I8EOU4Lf6+WyM4Fc9GEBJ3SWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a211NJJ+vIBi9YAx2hTei2R239pk2NVqBoqJb19pggSCmACg92WW0GNJw8HNoDZgHjCzLZn059yn7VR2cewiFB/CqM8pOkBDAAFAR+94rXY+6ifhj8NJZ852vDa+DvrMWhXa7ZzDcB5JT8TBgTBODpaVNu0BRpbG5E22p8TV92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQWtWfru; arc=none smtp.client-ip=95.215.58.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQWtWfru"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=d3aO4V0vD69y29p/81I8EOU4Lf6+WyM4Fc9GEBJ3SWo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787635431; v=1; x=1788240231;
 b=oQWtWfruGf3mpge1Rz4GwfCJRvFopwHrz42Bi9c45Xrysj5fS/oalqLOP48hKf19U86ZRMSd
 MH/wcnnncz284rlhwjR1Gd48C4AR09qaQl8oG2si+VqIxex62xf7U/XfvE3XAVS500g+G2rMi6v
 YHrhhbmQmxe829OX55f/K6l4=
X-Envelope-To: bpf@vger.kernel.org
Received: from ctao-book.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 5837b4b97ec2bdc0;
	Tue, 25 Aug 2026 05:23:51 +0000
X-Mizu-Trace-ID: 5837b4b97ec2bdc0
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	void@manifault.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	michalblk@google.com,
	suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] sched_ext: Allow ops.cgroup_set_weight/idle() to be sleepable
Date: Tue, 25 Aug 2026 13:23:36 +0800
Message-ID: <20260825052336.46746-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

ops.cgroup_set_weight() and ops.cgroup_set_idle() are delivered from
scx_group_set_weight() and scx_group_set_idle(), which run from the
cpu.weight (and v1 cpu.shares) and cpu.idle cgroup interface write paths
in process context. Both hold percpu_down_read(&scx_cgroup_ops_rwsem),
whose read side may sleep. The call sites are therefore sleepable, like
ops.cgroup_set_bandwidth(), which was recently added to the sleepable
allow-list.

bpf_scx_check_member() rejects a sleepable program on any member not on
its allow-list, so a BPF scheduler cannot allocate -- which is sleepable
-- when a cgroup's weight or idle state changes at runtime. Add
cgroup_set_weight() and cgroup_set_idle() to the allow-list so these
callbacks can allocate on demand, and document that they may block.

Also add the matching compatibility markers, so userspace can detect
this support via BTF, mirroring
scx_compat_marker_cgroup_set_bandwidth_may_sleep().

To size the alternative, a scheduler that gives each cgroup a
dedicated idle DSQ must create it in ops.cgroup_init() for every
cgroup up front. In a VM with 2000 cgroups that is 2000+ standing
DSQs, each a struct scx_dispatch_q plus a per-CPU area. With the
allow-list entries the same scheduler can create the DSQ lazily on
the first cpu.idle=1 write of a cgroup: 4 allocations for the 4
cgroups marked idle at runtime, and repeated cpu.idle writes do not re-allocate. Verified with a probe scheduler on an
unpatched kernel (load rejected with -EINVAL) and on a patched one.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 kernel/sched/ext/ext.c      | 18 ++++++++++++++++++
 kernel/sched/ext/internal.h |  9 +++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index b646711a45fe..53b888f5a6c5 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8079,7 +8079,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
 	case offsetof(struct sched_ext_ops, cgroup_init):
 	case offsetof(struct sched_ext_ops, cgroup_exit):
 	case offsetof(struct sched_ext_ops, cgroup_prep_move):
+	case offsetof(struct sched_ext_ops, cgroup_set_weight):
 	case offsetof(struct sched_ext_ops, cgroup_set_bandwidth):
+	case offsetof(struct sched_ext_ops, cgroup_set_idle):
 #endif
 	case offsetof(struct sched_ext_ops, cpu_online):
 	case offsetof(struct sched_ext_ops, cpu_offline):
@@ -11055,3 +11057,19 @@ __initcall(scx_init);
 #ifdef CONFIG_EXT_GROUP_SCHED
 DEFINE_SCX_COMPAT_MARKER(cgroup_set_bandwidth_may_sleep);
 #endif	/* CONFIG_EXT_GROUP_SCHED */
+
+/*
+ * scx_compat_marker_cgroup_set_weight_may_sleep: advertises that
+ * ops.cgroup_set_weight() may be implemented as a sleepable callback.
+ */
+#ifdef CONFIG_EXT_GROUP_SCHED
+DEFINE_SCX_COMPAT_MARKER(cgroup_set_weight_may_sleep);
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+
+/*
+ * scx_compat_marker_cgroup_set_idle_may_sleep: advertises that
+ * ops.cgroup_set_idle() may be implemented as a sleepable callback.
+ */
+#ifdef CONFIG_EXT_GROUP_SCHED
+DEFINE_SCX_COMPAT_MARKER(cgroup_set_idle_may_sleep);
+#endif	/* CONFIG_EXT_GROUP_SCHED */
diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
index 53e136a47924..f81d03de2d3c 100644
--- a/kernel/sched/ext/internal.h
+++ b/kernel/sched/ext/internal.h
@@ -736,7 +736,7 @@ struct sched_ext_ops {
 	 * @cgrp: cgroup whose weight is being updated
 	 * @weight: new weight [1..10000]
 	 *
-	 * Update @cgrp's weight to @weight.
+	 * Update @cgrp's weight to @weight. This operation may block.
 	 *
 	 * Knobs of a cgroup belong to the parent, so the set_* ops are
 	 * delivered to @cgrp's parent's sched. That sched may never have seen
@@ -773,9 +773,10 @@ struct sched_ext_ops {
 	 * @cgrp: cgroup whose idle state is being updated
 	 * @idle: whether the cgroup is entering or exiting idle state
 	 *
-	 * Update @cgrp's idle state to @idle. This callback is invoked when
-	 * a cgroup transitions between idle and non-idle states, allowing the
-	 * BPF scheduler to adjust its behavior accordingly.
+	 * Update @cgrp's idle state to @idle. This operation may block. This
+	 * callback is invoked when a cgroup transitions between idle and
+	 * non-idle states, allowing the BPF scheduler to adjust its behavior
+	 * accordingly.
 	 *
 	 * Delivery follows the same rule as cgroup_set_weight().
 	 */
-- 
2.43.0

