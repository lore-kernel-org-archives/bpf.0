Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90F4848B5
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392178; cv=none; b=UVMKfMcnVC8+kAnKIMqIt3kRDuwzzWh43F9JS8ODee4VYSSblzZ32AZsI4pVCDWqMrtR6zZrHZ4YpawZa37PYnPzq8uBXXAzumRAaGsgkMH9Fd+h4xu3SbUxvYosD03rQ3mHP81oDdq16f5kNwK/P/maccopANBBjP9Z7rGZMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392178; c=relaxed/simple;
	bh=FVM7pKIlCsv6cOKlPCWC5RaYQw1mZD6RfZwB8huYaq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWjX9Ta2YbN9mGyAHW8av6NSRAMOH9bBXL5H7URx1HCRunZIdYCV6W0EuLGu6vsmwuguGn7p1orEAiws8/pTZIR8ck5pCkEJFiDv01s5B0I4fSaDTxsx/9yv9VjBTjE9KhhJM3dQJslYBZa7+cc7Fr+RZvlLZMFxddFCcVzGN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXW0VP1j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXW0VP1j"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8897e83332fso1394608b3a.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 23:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792392175; x=1792996975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zn+seGJGD/ryx0jBfvBnoaTE/c0alNVdxFqtcQz078=;
        b=iXW0VP1jdkjEwbpZsr/1Zf55aOoM3Yn+TmCRXyOVTyEUxU0DXr9fpkTzBE6uyMFPiC
         oYCSvI186u2TbVkFdpwl0JRH3nirGSYIFfTYJjNMLEwfvXYW/HVvpLa9IDtAeUSo9lxS
         fqq6KPB3+NtVvpUudgL+toMeL+BvOlzsU+gllO+j30T7NmI3PsVCR4sGsle4ebVDhIwc
         Wt3VoiBLR5TA/WJEZw+I4nstxcy+EtP1WGSEnQDCyDDF58Z6sjkK20CJd3Q0vtPhWbwm
         exCa1hKhXSGfK0Ke/CItLbVZcAoaFQ+MwAXI/CYutuswbqnmNhG5qHM/nAJUAJukHSim
         dN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792392175; x=1792996975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zn+seGJGD/ryx0jBfvBnoaTE/c0alNVdxFqtcQz078=;
        b=DD8aQ7tbJIC0BbSBAxPX3RyByibBsyqyQJ/t4esUHSBsPNdHqL/qljLbwBAnNB1y1F
         86BM9RSfCAUm+uZQz9VkxRHvv1fnMMKaEr8lvIsaUH3FoOpvJqLxHttFbF/ejCZSdWpk
         O69vqYiD+kl/XVrRMIQa69G0neMF5kZkE3vYtOJE4crESDM8/cIJlPGxjYWcO/Kp7xTG
         htDWvKspZSwqZlQidGiHNUckW49oEEg+CNx/ggBGOji/yc7D8KyE1hWRSNcw6mJcP8eh
         npVJRrg7F0BvUfF1FWR6asf/5CH39Q9e/11dpWioncE5R9y080RYWL9A2IbE9+wF6PGC
         jVrg==
X-Gm-Message-State: AFq9FYLOcxJXtWn1qg9rWgx5E3/7n5xkiCe7crl+LcK9ryfJ0LUhYYGJ
	eQA2UKx+rQVILjmaDYYa4HQDDLXT02MIS1xbUO1qu0ZQHyhCLUJNzgOj
X-Gm-Gg: AYBFou20ykmntuEJV2pD4dfwqs3et3L26MdTN2dRWOLwPN5VAj0RPA0IlMHBCB9PG6H
	AV5F0e7Oou0E9XSS5k/TvjCGeKE4A5ePeYY7ZDMxKm+IWg4+uroMDJs5HRtzdnN1lBU5i1m7PtJ
	scTLFZy1G+2oUDVuZaZ7QqowpsuYdY0ctoZHyR/tQnjj0Ia+twhsUqPKPmueI73ZaTzvNuR5VLo
	2wcHzQTK0zS67TIFYRaW/sMJDyAHQP5VLpDLJLb5kfXEOAUy726gFdH6GzMphsWH6leHdjDK+7M
	W/qVopguHWl0HZRLUdH1RigvEubo9oyDgeamJN94m22RjfS/gvQp7Ypn7DQdPLp9q0sVTP7+XSh
	7MZFBT0kRgW4OUM1FPoJh2GWlgOeQKzTi7WD4NNJ+VRTUo2u7wr1cC6K1SRJ5WFzhhOr6aYyQP4
	jbRnxmSQNg3puGQhxscQ4NCnAG7O0wRhkxr8zBKsZWv+4CuyhpIka5eWeWi5W8+mJxxRzHYAkef
	mzBvcHeV4bwMKO/0xCr+MZ7ST1l+4e43zgkNL4QemLZNR0DFaWZb2gytbYTUmHrDiEAFw==
X-Received: by 2002:a05:6a21:62cc:b0:3e2:28f0:b360 with SMTP id adf61e73a8af0-3e228f0b803mr4007553637.0.1792392175487;
        Sun, 18 Oct 2026 23:42:55 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2100:3fed:6938:3f14:63eb:c479])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a3a592sm3688960a12.30.2026.10.18.23.42.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 23:42:54 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	gourry@gourry.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yu.c.chen@intel.com,
	zhao1.liu@intel.com,
	tim.c.chen@linux.intel.com,
	lizhe.67@bytedance.com
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH v3 bpf-next 3/5] sched: add helpers for numa balancing
Date: Mon, 19 Oct 2026 14:41:55 +0800
Message-ID: <20261019064157.29885-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261019064157.29885-1-laoar.shao@gmail.com>
References: <20261019064157.29885-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new helpers task_numab_enabled(), numab_in_tiering_mode() and
numab_in_normal_mode() are introduced to replace the scattered direct
accesses to the sched_numa_balancing static key and the
sysctl_numa_balancing_mode bitmask.

No functional change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/sched/numa_balancing.h | 33 ++++++++++++++++++++++++++++
 kernel/sched/fair.c                  | 31 +++++++++++++-------------
 kernel/sched/sched.h                 |  1 -
 mm/memory-tiers.c                    |  3 ++-
 mm/mempolicy.c                       |  3 +--
 mm/migrate.c                         |  7 +++---
 mm/vmscan.c                          |  6 ++---
 7 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched/numa_balancing.h b/include/linux/sched/numa_balancing.h
index 52b22c5c396d..36de57f7fb06 100644
--- a/include/linux/sched/numa_balancing.h
+++ b/include/linux/sched/numa_balancing.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/sched/sysctl.h>
 
 #define TNF_MIGRATED	0x01
 #define TNF_NO_GROUP	0x02
@@ -32,6 +33,26 @@ extern void set_numabalancing_state(bool enabled);
 extern void task_numa_free(struct task_struct *p, bool final);
 bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 				int src_nid, int dst_cpu);
+
+extern struct static_key_false sched_numa_balancing;
+
+/* Whether NUMA balancing applies to @p. */
+static inline bool task_numab_enabled(struct task_struct *p)
+{
+	return static_branch_likely(&sched_numa_balancing);
+}
+
+/* Whether NUMA balancing is in memory tiering mode. */
+static inline bool numab_in_tiering_mode(void)
+{
+	return sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING;
+}
+
+/* Whether NUMA balancing is in normal mode. */
+static inline bool numab_in_normal_mode(void)
+{
+	return sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL;
+}
 #else
 static inline void task_numa_fault(int last_node, int node, int pages,
 				   int flags)
@@ -52,6 +73,18 @@ static inline bool should_numa_migrate_memory(struct task_struct *p,
 {
 	return true;
 }
+static inline bool task_numab_enabled(struct task_struct *p)
+{
+	return false;
+}
+static inline bool numab_in_tiering_mode(void)
+{
+	return false;
+}
+static inline bool numab_in_normal_mode(void)
+{
+	return false;
+}
 #endif
 
 #endif /* _LINUX_SCHED_NUMA_BALANCING_H */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 71dc47d6114d..066818498c76 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -39,6 +39,7 @@
 #include <linux/sched/cputime.h>
 #include <linux/sched/isolation.h>
 #include <linux/sched/nohz.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/sched/prio.h>
 #include <linux/static_call.h>
 
@@ -1478,7 +1479,8 @@ static inline int get_sched_cache_scale(int mul)
 	return (1 + (tol - 1) * mul);
 }
 
-static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
+static bool exceed_llc_capacity(struct sched_cache_group *grp, struct task_struct *p,
+				int cpu)
 {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned long llc, footprint;
@@ -1491,7 +1493,7 @@ static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
 	if (!sd)
 		return true;
 
-	if (static_branch_likely(&sched_numa_balancing)) {
+	if (task_numab_enabled(p)) {
 		/*
 		 * TBD: RDT exclusive LLC ways reserved should be
 		 * excluded.
@@ -1879,7 +1881,7 @@ static int get_pref_llc(struct task_struct *p, struct sched_cache_group *grp)
 		 * than sched_setnuma() at least -- and thus the
 		 * conflict only exists for a short period of time.
 		 */
-		if (static_branch_likely(&sched_numa_balancing) &&
+		if (task_numab_enabled(p) &&
 		    p->numa_preferred_nid >= 0 &&
 		    cpu_to_node(mm_sched_cpu) != p->numa_preferred_nid)
 			mm_sched_llc = -1;
@@ -1932,7 +1934,7 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	 */
 	if ((long)(epoch - READ_ONCE(grp->epoch)) > llc_epoch_affinity_timeout ||
 	    invalid_llc_nr(grp, p, cpu_of(rq)) ||
-	    exceed_llc_capacity(grp, cpu_of(rq))) {
+	    exceed_llc_capacity(grp, p, cpu_of(rq))) {
 		if (READ_ONCE(grp->cpu) != -1)
 			WRITE_ONCE(grp->cpu, -1);
 	}
@@ -1980,7 +1982,7 @@ static void get_scan_cpumasks(cpumask_var_t cpus, struct task_struct *p,
 #ifdef CONFIG_NUMA_BALANCING
 	int cpu, curr_cpu, nid, pref_nid;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!task_numab_enabled(p))
 		goto out;
 
 	cpu = READ_ONCE(grp->cpu);
@@ -2076,7 +2078,7 @@ static void task_cache_work(struct callback_head *work)
 
 	curr_cpu = task_cpu(p);
 	if (invalid_llc_nr(grp, p, curr_cpu) ||
-	    exceed_llc_capacity(grp, curr_cpu)) {
+	    exceed_llc_capacity(grp, p, curr_cpu)) {
 		if (READ_ONCE(grp->cpu) != -1)
 			WRITE_ONCE(grp->cpu, -1);
 
@@ -2963,8 +2965,8 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = folio_xchg_last_cpupid(folio, this_cpupid);
 
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
-	    !node_is_toptier(src_nid) && !cpupid_valid(last_cpupid))
+	if (!(numab_in_tiering_mode()) && !node_is_toptier(src_nid) &&
+	    !cpupid_valid(last_cpupid))
 		return false;
 
 	/*
@@ -4194,7 +4196,7 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	struct numa_group *ng;
 	int priv;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!task_numab_enabled(p))
 		return;
 
 	/* for example, ksmd faulting in a user's mm */
@@ -4206,8 +4208,7 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	 * node for memory tiering mode.
 	 */
 	if (!node_is_toptier(mem_node) &&
-	    (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ||
-	     !cpupid_valid(last_cpupid)))
+	    (numab_in_tiering_mode() || !cpupid_valid(last_cpupid)))
 		return;
 
 	/* Allocate buffer to track faults on a per-node basis */
@@ -4665,7 +4666,7 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	int src_nid = cpu_to_node(task_cpu(p));
 	int dst_nid = cpu_to_node(new_cpu);
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!task_numab_enabled(p))
 		return;
 
 	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
@@ -10697,7 +10698,7 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!task_numab_enabled(p))
 		return 0;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
@@ -10960,7 +10961,7 @@ static enum llc_mig can_migrate_llc_task(struct lb_env *env,
 
 	/* skip cache aware load balance for too many threads */
 	if (invalid_llc_nr(grp, p, dst_cpu) ||
-	    exceed_llc_capacity(grp, dst_cpu)) {
+	    exceed_llc_capacity(grp, p, dst_cpu)) {
 		if (READ_ONCE(grp->cpu) != -1)
 			WRITE_ONCE(grp->cpu, -1);
 		return mig_unrestricted;
@@ -15351,7 +15352,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (queued)
 		return;
 
-	if (static_branch_likely(&sched_numa_balancing))
+	if (task_numab_enabled(curr))
 		task_tick_numa(rq, curr);
 
 	task_tick_cache(rq, curr);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf8..38e21c8c57dd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2465,7 +2465,6 @@ extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 
 #endif /* !CONFIG_JUMP_LABEL */
 
-extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
 
 static inline u64 global_rt_period(void)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 54851d8a195b..9009b164edc2 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -6,6 +6,7 @@
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/sched/sysctl.h>
 
 #include "internal.h"
@@ -64,7 +65,7 @@ static const struct bus_type memory_tier_subsys = {
  */
 bool folio_use_access_time(struct folio *folio)
 {
-	return (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) &&
+	return numab_in_tiering_mode() &&
 	       !node_is_toptier(folio_nid(folio));
 }
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 79053ece02cd..442c93079fb0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -871,8 +871,7 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	 * Skip scanning top tier node if normal numa
 	 * balancing is disabled
 	 */
-	if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
-	    node_is_toptier(nid))
+	if (!numab_in_normal_mode() && node_is_toptier(nid))
 		return false;
 
 	if (folio_use_access_time(folio))
diff --git a/mm/migrate.c b/mm/migrate.c
index 15b45832bcfa..a622df9a9b42 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -41,6 +41,7 @@
 #include <linux/ptrace.h>
 #include <linux/memory.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched/numa_balancing.h>
 #include <linux/memory-tiers.h>
 #include <linux/pagewalk.h>
 
@@ -818,7 +819,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 	 * memory node, reset cpupid, because that is used to record
 	 * page access time in slow memory node.
 	 */
-	if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING) {
+	if (numab_in_tiering_mode()) {
 		bool f_toptier = node_is_toptier(folio_nid(folio));
 		bool t_toptier = node_is_toptier(folio_nid(newfolio));
 
@@ -2718,7 +2719,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 	if (!migrate_balanced_pgdat(pgdat, nr_pages)) {
 		int z;
 
-		if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
+		if (!numab_in_tiering_mode())
 			return -EAGAIN;
 		for (z = pgdat->nr_zones - 1; z >= 0; z--) {
 			if (managed_zone(pgdat->node_zones + z))
@@ -2770,7 +2771,7 @@ int migrate_misplaced_folio(struct folio *folio, int node)
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
 		count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded);
-		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
+		if ((numab_in_tiering_mode())
 		    && !node_is_toptier(folio_nid(folio))
 		    && node_is_toptier(node))
 			mod_lruvec_state(lruvec, PGPROMOTE_SUCCESS, nr_succeeded);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f11491ee9ed5..17455255fc30 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -65,6 +65,7 @@
 
 #include <linux/swapops.h>
 #include <linux/sched/sysctl.h>
+#include <linux/sched/numa_balancing.h>
 
 #include "internal.h"
 #include "page_alloc.h"
@@ -5029,8 +5030,7 @@ static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
 	if (!current_is_kswapd() || sc->order)
 		return false;
 
-	mark = sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ?
-	       WMARK_PROMO : WMARK_HIGH;
+	mark = numab_in_tiering_mode() ? WMARK_PROMO : WMARK_HIGH;
 
 	for (i = 0; i <= sc->reclaim_idx; i++) {
 		struct zone *zone = lruvec_pgdat(lruvec)->node_zones + i;
@@ -6974,7 +6974,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 		enum zone_stat_item item;
 		unsigned long free_pages;
 
-		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
+		if (numab_in_tiering_mode())
 			mark = promo_wmark_pages(zone);
 		else
 			mark = high_wmark_pages(zone);
-- 
2.52.0

