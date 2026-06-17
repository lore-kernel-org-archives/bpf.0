Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B33B8139
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781727735; cv=none; b=ckz2THvfPbu9g8gBH2NnAYZxO+IT5XGd6vIh9np8UrTmyztU21ZgpcHKUgZ2tHb3TLO77+du4C8yew1Co58t7YnE+7jsK5BiBBRsMa4iiUMF2JYlXfsQVwWz7iCHGSq42aej6BRmc8HNuK8HhWO2WgXS/5zULIMTsGkboSw5n5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781727735; c=relaxed/simple;
	bh=CceglT3qlCWH4/jTzpi9DWCh866J7068WN2/OhvFVKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IKg1jx7EkK8SyFOFBahbSVSCaLbBeFqdcb/XOdQ2fbpYyKxnIpn5FCQ0pO8QU394Gm/2IpKWrPhF0xpXabpluo/c8AefvtX5QOwN/TJ8MDcN7e1x2itAkuyU/DGqeZIScepqrtjqJgtHNAlJNtR8XgObb7SanjqNHxqf6/8DddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=amAb0OIv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="amAb0OIv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781727730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bFbB1BtfczxDB+uTNT4qTGVZYo6BQXoVhZaGmDWFja4=;
	b=amAb0OIvInfXWf4o2w+HJ/T068r7UoZcCTSudJaDxT5hZfiBMINHEYeQ8cAqMRg3iJKM/E
	RT36vA4HAan0H+wug1L0XuHSxyIWCiM8cq/56X//0l5pyUgMGRNAOS958zWEEj188Xe0Lz
	Ee4BduE0YQNFbT45bLzYHlcaEh4+K3M=
From: JP Kobryn <jp.kobryn@linux.dev>
To: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm/bpf_memcontrol: mark BPF memcg kfuncs static
Date: Wed, 17 Jun 2026 13:21:47 -0700
Message-ID: <20260617202147.78347-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kfuncs in bpf_memcontrol.c are not called by in-kernel C code. They are
only referenced by BPF programs and resolved through BTF.

Since no external linkage is needed, mark these functions static.

Fixes: 5904db9891f8 ("mm: introduce BPF kfuncs to deal with memcg pointers")
Fixes: 5c7db3239c9f ("mm: introduce bpf_get_root_mem_cgroup() BPF kfunc")
Fixes: 99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistics and events")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606150332.Xy4Egd9s-lkp@intel.com/
Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
---
 mm/bpf_memcontrol.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 716df49d7647..eff79bb2c758 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -20,7 +20,7 @@ __bpf_kfunc_start_defs();
  *
  * Return: A pointer to the root memory cgroup.
  */
-__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
+__bpf_kfunc static struct mem_cgroup *bpf_get_root_mem_cgroup(void)
 {
 	if (mem_cgroup_disabled())
 		return NULL;
@@ -41,7 +41,7 @@ __bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
  * Return: A pointer to a mem_cgroup structure after bumping
  * the corresponding css's reference counter.
  */
-__bpf_kfunc struct mem_cgroup *
+__bpf_kfunc static struct mem_cgroup *
 bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = NULL;
@@ -75,7 +75,7 @@ bpf_get_mem_cgroup(struct cgroup_subsys_state *css)
  * Releases a previously acquired memcg reference.
  * Implements KF_RELEASE semantics.
  */
-__bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
+__bpf_kfunc static void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
 {
 	css_put(&memcg->css);
 }
@@ -89,8 +89,8 @@ __bpf_kfunc void bpf_put_mem_cgroup(struct mem_cgroup *memcg)
  *
  * Return: The current value of the corresponding events counter.
  */
-__bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
-						   enum vm_event_item event)
+__bpf_kfunc static unsigned long
+bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg, enum vm_event_item event)
 {
 	if (unlikely(!memcg_vm_event_item_valid(event)))
 		return (unsigned long)-1;
@@ -110,7 +110,7 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_vm_events(struct mem_cgroup *memcg,
  *
  * Return: The current memory cgroup size in bytes.
  */
-__bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
+__bpf_kfunc static unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
 {
 	return page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
@@ -122,8 +122,8 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
  *
  * Return: The current value of the memory event counter.
  */
-__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
-						       enum memcg_memory_event event)
+__bpf_kfunc static unsigned long
+bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg, enum memcg_memory_event event)
 {
 	if (unlikely(event >= MEMCG_NR_MEMORY_EVENTS))
 		return (unsigned long)-1;
@@ -140,7 +140,8 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
  *
  * Return: The value of the page state counter in bytes.
  */
-__bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
+__bpf_kfunc static unsigned long
+bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, int idx)
 {
 	if (unlikely(!memcg_stat_item_valid(idx)))
 		return (unsigned long)-1;
@@ -154,7 +155,7 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_page_state(struct mem_cgroup *memcg, in
  *
  * Propagate memory cgroup's statistics up the cgroup tree.
  */
-__bpf_kfunc void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
+__bpf_kfunc static void bpf_mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
 	mem_cgroup_flush_stats(memcg);
 }
-- 
2.54.0

