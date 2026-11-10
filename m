Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281399;
	b=fZy21hwnTjudfVX0GxjiG1K4kKmLGtBrHwT+L4dMuwNUnWdM12jUWE5yrxuhb1M3f/yt
	 omJqpgmF7tkgEyObvCR5lSLSf5e6xsM2Lgg8tjHWoWvlpriOES1Juo/DsURQhLSeqeO+A
	 JaD8pxFlqhLIoVxeuhEVqiyM/rpVNpv7QpHtC86QJrr0G/ab83r/qwKuoW+vlwZRYYR0Q
	 AySF9dD+C+qOaxMVM+3i/xApzpk5xQSq0c5DbEslpDteqD/2UKv9JfNEOpG82pz1p9Yzk
	 0Q48on93EqcGg+pRNAl+eOgaeGwUykwyNOdMeV/2w0xJXcDJQOMwgAVadOBGYmvD/3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281399;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TXLX0Ahxuhi7Ry1DtDpYVsi3P/H10gWiQkGDuBbmQyY=;
	b=Q80M8Fe2RzDgazIWSI4xw7421HS1HQKs5ZFisJLA7QIobuEe9z8U8E1jCtkNXfbyroB+
	 muGR1+/j96jEEA8XJYp1NtVwd+PMr8hM7qq0x+o6cMCXfMgcqMBTxt6IEnmhjGp9BllpZ
	 8m5V89QYrx1ercbhKuQklQ3stwpF45ed6NNFxTOFNesQHocFbHgQD7crw5A09LMCfF2LU
	 pH63uO7tV4Pst9n+Ee9SteatJ21WnqXw31qcR4bfybqI7PA3ni0kHCjYi+C3Hxr0Dp9VG
	 1zhn4wyBqxlRN+zLo2Y3CSS6nz0XB/GJFQ/okZp2ZjC5/OCnmyeD8KLCNtyvbb0YHCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oN4rBKQq;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64679606A325
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64679606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oN4rBKQq
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b271e573adso595361b3a.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 19:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794281399; x=1794886199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TXLX0Ahxuhi7Ry1DtDpYVsi3P/H10gWiQkGDuBbmQyY=;
        b=oN4rBKQqmhWh8bVqvI15GTnKGIeVWB+Rnxx5533fecVRQ9hEhRab83Fto5QBSZ2hrX
         9y9vrYq3sXfAkLOCndTF+tO8mbv2N/lEFdW0X3OowjoOLFWU5JEFTScnkahrsTVfJwkp
         a4fe1LpL5OvfSDDVtgUsi1gMm9GkNqG/e82K8bZbC9bsQt9/8vqPU3NfioWhUCvHuen8
         UsT7sVbgp9oGip2yytfF3m4fY7MhPtWbVjkNe7p2ApXqsogO+zOvVdb2r6gRr4Mp/BGx
         yZFDA2pQu3kqqarXWhMgcSrXLAnnu5amhMnmNOo1M6Nau0IhtPikNTo3L53m7U9pNvGL
         XGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794281399; x=1794886199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TXLX0Ahxuhi7Ry1DtDpYVsi3P/H10gWiQkGDuBbmQyY=;
        b=QMcyBHISMtpAm7ufJFCV+6MVc5coYEA17uamguErlrHgybi90kVEaLyPAP//u4ypA9
         WlCmQE1iHtID67DCZagFr3szMzEYnWCThAgQw++DEH8lZAbgeQDaBOctDYRIhyXDbQ2+
         rI9cq4RDZJl7Y45lVNpbPFiMlX9WtlErQqPXoLWuLH07MgatPAUo8Danc4XCvSBRw0b+
         BZ0Nrs7cQDcb/QGGhgcbxaoMEfxrcz7HvKKMuzegtQBeUbkK3rtTcpPVtjn1YImNr1y3
         u/33XP724CuUhjPn8LIGurPx5UrGpuQ1MOxuCtQkhZG1DphNlkk2yN0JrRQbDVuzOBgx
         HU8A==
X-Gm-Message-State: APuU4Z+2pT9x9xjS8oWgcmxp5JCdC4liLCd8WGfWN1e6kVl3bq9C95pA
	ECk/T2Vnrcg8bBlQ3ghgnD/kjrJSahTrh76RZ07MAKaVs6LxaqY+bq67
X-Gm-Gg: AYBFou20G9cZ1beSDpt6BrwNhaqN4ycr+mNYGFLSwvstzCtZ5PzDZfcMvkxBvS0vW4Q
	nZIsCbZy1Hr6eO+kQJ9G/76TRvrmMYeaAUWFp+QGRPxTrwkOooFSmnLOzboo/YUd8ka1jD5gSXP
	D0kstuJiVpLKt1iAjzUZ/Br2keim8ihoOyVA8ra4tgAeAu2Aye8ajKTcl1q2md1iYJ7lLnzPApl
	irS2Y0wQVRrBcOOoGmvjhOPEy77KaZytk90oLeZn/8cU10AgjyjJI/MGvDQoYnd6rpi0SUOUKZS
	kppnRNCjkiJUJPhWE601q8CSRo0N60esI2HrkZgksToqodaoX3pszXOoPq4oJXhaa5d1YU7NL6g
	9lt5HTRAWXiCr8GBpHpnGPVsiBoqe0xI5qyn8tjTNi8DX+2h+/ikj7jb0Hr9TR9PUymYnmGUOEG
	s9kLwGZtxd837nP3CxVOWS+6Lxf8B/oTjLaPIYCq+2gceHTKevXMyByPy//TVXrnFVwGF7ssmtZ
	CLpIPHl3fWWLtHjI5Rp0wXWzqm82crzEIMPN0gZBS61q6gJhAz0M9E0F+fO7wNf+pD9wjiIBTq4
	TAkwBG4seBzyJDHpzBYxoF7vKlushh3fCs9tipwfqr3uynLu73H3JXX1my9HLKQhe30viS4YN9/
	8BI+675B8LxOyjNjsBbQSlXk8
X-Received: by 2002:a05:6a00:390b:b0:8a0:6905:248 with SMTP id d2e1a72fcca58-8ba83bd70bamr1752498b3a.3.1794281398643;
        Mon, 09 Nov 2026 19:29:58 -0800 (PST)
Received: from localhost.localdomain ([240e:46d:1d00:5ed4:58d0:d294:d44c:6ae8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab21835fsm336973b3a.42.2026.11.09.19.29.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:29:57 -0800 (PST)
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
	lizhe.67@bytedance.com,
	ziy@nvidia.com,
	mgorman@suse.de
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v4 2/4] sched: sample NUMA balancing mode once per path
Date: Tue, 10 Nov 2026 11:29:11 +0800
Message-ID: <20261110032913.71974-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261110032913.71974-1-laoar.shao@gmail.com>
References: <20261110032913.71974-1-laoar.shao@gmail.com>
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

Take one snapshot per path and pass it down.

No functional change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/fair.c | 77 ++++++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 672dda541458..18b976a47afa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1422,7 +1422,8 @@ static inline int get_sched_cache_scale(int mul)
 	return (1 + (tol - 1) * mul);
 }
 
-static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
+static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu,
+				bool numab_enabled)
 {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned long llc, footprint;
@@ -1435,7 +1436,7 @@ static bool exceed_llc_capacity(struct sched_cache_group *grp, int cpu)
 	if (!sd)
 		return true;
 
-	if (task_numab_enabled()) {
+	if (numab_enabled) {
 		/*
 		 * TBD: RDT exclusive LLC ways reserved should be
 		 * excluded.
@@ -1801,7 +1802,8 @@ static unsigned long fraction_mm_sched(struct rq *rq,
 	return div64_u64(NICE_0_LOAD * pcpu_sched->runtime, rq->cpu_runtime + 1);
 }
 
-static int get_pref_llc(struct task_struct *p, struct sched_cache_group *grp)
+static int get_pref_llc(struct task_struct *p, struct sched_cache_group *grp,
+			bool numab_enabled)
 {
 	int mm_sched_llc = -1, mm_sched_cpu;
 
@@ -1823,7 +1825,7 @@ static int get_pref_llc(struct task_struct *p, struct sched_cache_group *grp)
 		 * than sched_setnuma() at least -- and thus the
 		 * conflict only exists for a short period of time.
 		 */
-		if (task_numab_enabled() &&
+		if (numab_enabled &&
 		    p->numa_preferred_nid >= 0 &&
 		    cpu_to_node(mm_sched_cpu) != p->numa_preferred_nid)
 			mm_sched_llc = -1;
@@ -1842,6 +1844,7 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	struct sched_cache_time *pcpu_sched;
 	int mm_sched_llc = -1;
 	unsigned long epoch;
+	bool numab_enabled;
 
 	if (!sched_cache_enabled())
 		return;
@@ -1875,14 +1878,19 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
 	 * its preferred state.
 	 */
 	if ((long)(epoch - READ_ONCE(grp->epoch)) > llc_epoch_affinity_timeout ||
-	    invalid_llc_nr(grp, p, cpu_of(rq)) ||
-	    exceed_llc_capacity(grp, cpu_of(rq))) {
+	    invalid_llc_nr(grp, p, cpu_of(rq))) {
 		if (READ_ONCE(grp->cpu) != -1)
 			WRITE_ONCE(grp->cpu, -1);
+	} else {
+		numab_enabled = task_numab_enabled();
+		if (exceed_llc_capacity(grp, cpu_of(rq), numab_enabled)) {
+			if (READ_ONCE(grp->cpu) != -1)
+				WRITE_ONCE(grp->cpu, -1);
+		} else {
+			mm_sched_llc = get_pref_llc(p, grp, numab_enabled);
+		}
 	}
 
-	mm_sched_llc = get_pref_llc(p, grp);
-
 	/* task not on rq accounted later in account_entity_enqueue() */
 	if (task_running_on_cpu(rq->cpu, p) &&
 	    READ_ONCE(p->preferred_llc) != mm_sched_llc) {
@@ -1919,12 +1927,12 @@ static void task_tick_cache(struct rq *rq, struct task_struct *p)
 }
 
 static void get_scan_cpumasks(cpumask_var_t cpus, struct task_struct *p,
-			      struct sched_cache_group *grp)
+			      struct sched_cache_group *grp, bool numab_enabled)
 {
 #ifdef CONFIG_NUMA_BALANCING
 	int cpu, curr_cpu, nid, pref_nid;
 
-	if (!task_numab_enabled())
+	if (!numab_enabled)
 		goto out;
 
 	cpu = READ_ONCE(grp->cpu);
@@ -1991,6 +1999,7 @@ static void task_cache_work(struct callback_head *work)
 	struct task_struct *p = current, *cur;
 	unsigned long curr_m_a_occ = 0;
 	unsigned long m_a_occ = 0;
+	bool numab_enabled;
 
 	WARN_ON_ONCE(work != &p->cache_work);
 
@@ -2019,11 +2028,16 @@ static void task_cache_work(struct callback_head *work)
 		return;
 
 	curr_cpu = task_cpu(p);
-	if (invalid_llc_nr(grp, p, curr_cpu) ||
-	    exceed_llc_capacity(grp, curr_cpu)) {
+	if (invalid_llc_nr(grp, p, curr_cpu)) {
 		if (READ_ONCE(grp->cpu) != -1)
 			WRITE_ONCE(grp->cpu, -1);
+		return;
+	}
 
+	numab_enabled = task_numab_enabled();
+	if (exceed_llc_capacity(grp, curr_cpu, numab_enabled)) {
+		if (READ_ONCE(grp->cpu) != -1)
+			WRITE_ONCE(grp->cpu, -1);
 		return;
 	}
 
@@ -2033,7 +2047,7 @@ static void task_cache_work(struct callback_head *work)
 	scoped_guard (cpus_read_lock) {
 		guard(rcu)();
 
-		get_scan_cpumasks(cpus, p, grp);
+		get_scan_cpumasks(cpus, p, grp, numab_enabled);
 
 		for_each_cpu(cpu, cpus) {
 			/* XXX sched_cluster_active */
@@ -2138,7 +2152,8 @@ void init_sched_mm(struct task_struct *p) { }
 static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
 
 static inline int get_pref_llc(struct task_struct *p,
-			       struct sched_cache_group *grp)
+			       struct sched_cache_group *grp,
+			       bool numab_enabled)
 {
 	return -1;
 }
@@ -2867,6 +2882,9 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	struct numa_group *ng = deref_curr_numa_group(p);
 	int dst_nid = cpu_to_node(dst_cpu);
 	int last_cpupid, this_cpupid;
+	bool tiering;
+
+	tiering = numab_in_tiering_mode();
 
 	/*
 	 * Cannot migrate to memoryless nodes.
@@ -2878,7 +2896,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	 * The pages in slow memory node should be migrated according
 	 * to hot/cold instead of private/shared.
 	 */
-	if (folio_use_access_time(folio)) {
+	if (tiering && !node_is_toptier(folio_nid(folio))) {
 		struct pglist_data *pgdat;
 		unsigned long rate_limit;
 		unsigned int latency, th, def_th;
@@ -2907,7 +2925,7 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
 	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
 	last_cpupid = folio_xchg_last_cpupid(folio, this_cpupid);
 
-	if (!numab_in_tiering_mode() && !node_is_toptier(src_nid) &&
+	if (!tiering && !node_is_toptier(src_nid) &&
 	    !cpupid_valid(last_cpupid))
 		return false;
 
@@ -10696,13 +10714,14 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
  * Returns 0, if task migration is not affected by locality.
  * Returns a negative value, if task migration improves locality i.e migration preferred.
  */
-static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
+static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env,
+				      bool numab_enabled)
 {
 	struct numa_group *numa_group = rcu_dereference_all(p->numa_group);
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
-	if (!task_numab_enabled())
+	if (!numab_enabled)
 		return 0;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
@@ -10744,7 +10763,8 @@ static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 
 #else /* !CONFIG_NUMA_BALANCING: */
 static inline long migrate_degrades_locality(struct task_struct *p,
-					     struct lb_env *env)
+					     struct lb_env *env,
+					     bool numab_enabled)
 {
 	return 0;
 }
@@ -10946,7 +10966,8 @@ static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
  * destination LLC in terms of cache aware load balance.
  */
 static enum llc_mig can_migrate_llc_task(struct lb_env *env,
-					 struct task_struct *p)
+					 struct task_struct *p,
+					 bool numab_enabled)
 {
 	struct sched_cache_group *grp;
 	bool to_pref;
@@ -10971,7 +10992,7 @@ static enum llc_mig can_migrate_llc_task(struct lb_env *env,
 
 	/* skip cache aware load balance for too many threads */
 	if (invalid_llc_nr(grp, p, dst_cpu) ||
-	    exceed_llc_capacity(grp, dst_cpu)) {
+	    exceed_llc_capacity(grp, dst_cpu, numab_enabled)) {
 		if (READ_ONCE(grp->cpu) != -1)
 			WRITE_ONCE(grp->cpu, -1);
 		return mig_unrestricted;
@@ -11060,7 +11081,8 @@ migrate_llc_task_wrong_dst(struct task_struct *p, struct lb_env *env)
  * Check if migrating task p from env->src_cpu to
  * env->dst_cpu breaks LLC localiy.
  */
-static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
+static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env,
+				 bool numab_enabled)
 {
 	if (!sched_cache_enabled())
 		return false;
@@ -11087,7 +11109,7 @@ static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
 	if (migrate_llc_task_wrong_dst(p, env))
 		return true;
 
-	if (can_migrate_llc_task(env, p) != mig_forbid)
+	if (can_migrate_llc_task(env, p, numab_enabled) != mig_forbid)
 		return false;
 
 	return true;
@@ -11113,7 +11135,8 @@ migrate_llc_task_wrong_dst(struct task_struct *p, struct lb_env *env)
 }
 
 static inline bool
-migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
+migrate_degrades_llc(struct task_struct *p, struct lb_env *env,
+		     bool numab_enabled)
 {
 	return false;
 }
@@ -11125,6 +11148,7 @@ static
 int can_migrate_task(struct task_struct *p, struct lb_env *env)
 {
 	long degrades, hot;
+	bool numab_enabled;
 
 	lockdep_assert_rq_held(env->src_rq);
 	if (p->sched_task_hot)
@@ -11213,14 +11237,15 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (env->flags & LBF_ACTIVE_LB)
 		return !migrate_llc_task_wrong_dst(p, env);
 
-	degrades = migrate_degrades_locality(p, env);
+	numab_enabled = task_numab_enabled();
+	degrades = migrate_degrades_locality(p, env, numab_enabled);
 	if (!degrades) {
 		/*
 		 * If the NUMA locality is not broken,
 		 * further check if migration would hurt
 		 * LLC locality.
 		 */
-		if (migrate_degrades_llc(p, env)) {
+		if (migrate_degrades_llc(p, env, numab_enabled)) {
 			/*
 			 * If regular load balancing fails to pull a task
 			 * due to LLC locality, this is expected behavior
-- 
2.52.0

