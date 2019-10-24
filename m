Return-Path: <SRS0=HE6e=YR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7B8CA9EBC
	for <bpf@archiver.kernel.org>; Thu, 24 Oct 2019 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4762070B
	for <bpf@archiver.kernel.org>; Thu, 24 Oct 2019 14:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502842AbfJXOZL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:25:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:11525 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732393AbfJXOZK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 10:25:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 07:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="373233573"
Received: from ranger.igk.intel.com ([10.102.21.164])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2019 07:25:07 -0700
From:   Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Subject: [PATCH bpf-next 1/2] xsk: store struct xdp_sock as a flexible array member of the XSKMAP
Date:   Thu, 24 Oct 2019 09:19:30 +0200
Message-Id: <20191024071931.3628-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024071931.3628-1-maciej.fijalkowski@intel.com>
References: <20191024071931.3628-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

Prior this commit, the array storing XDP socket instances were stored
in a separate allocated array of the XSKMAP. Now, we store the sockets
as a flexible array member in a similar fashion as the arraymap. Doing
so, we do less pointer chasing in the lookup.

Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 kernel/bpf/xskmap.c | 57 ++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/xskmap.c b/kernel/bpf/xskmap.c
index 82a1ffe15dfa..86e3027d4605 100644
--- a/kernel/bpf/xskmap.c
+++ b/kernel/bpf/xskmap.c
@@ -11,9 +11,9 @@
 
 struct xsk_map {
 	struct bpf_map map;
-	struct xdp_sock **xsk_map;
 	struct list_head __percpu *flush_list;
 	spinlock_t lock; /* Synchronize map updates */
+	struct xdp_sock *xsk_map[];
 };
 
 int xsk_map_inc(struct xsk_map *map)
@@ -80,9 +80,11 @@ static void xsk_map_sock_delete(struct xdp_sock *xs,
 
 static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 {
+	int cpu, err, numa_node = bpf_map_attr_numa_node(attr);
+	struct bpf_map_memory mem;
 	struct xsk_map *m;
-	int cpu, err;
-	u64 cost;
+	u32 max_entries;
+	u64 cost, size;
 
 	if (!capable(CAP_NET_ADMIN))
 		return ERR_PTR(-EPERM);
@@ -92,44 +94,36 @@ static struct bpf_map *xsk_map_alloc(union bpf_attr *attr)
 	    attr->map_flags & ~(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY))
 		return ERR_PTR(-EINVAL);
 
-	m = kzalloc(sizeof(*m), GFP_USER);
-	if (!m)
-		return ERR_PTR(-ENOMEM);
+	max_entries = attr->max_entries;
 
-	bpf_map_init_from_attr(&m->map, attr);
-	spin_lock_init(&m->lock);
+	size = sizeof(*m) + max_entries * sizeof(m->xsk_map[0]);
+	cost = size + sizeof(struct list_head) * num_possible_cpus();
 
-	cost = (u64)m->map.max_entries * sizeof(struct xdp_sock *);
-	cost += sizeof(struct list_head) * num_possible_cpus();
+	err = bpf_map_charge_init(&mem, cost);
+	if (err < 0)
+		return ERR_PTR(err);
 
-	/* Notice returns -EPERM on if map size is larger than memlock limit */
-	err = bpf_map_charge_init(&m->map.memory, cost);
-	if (err)
-		goto free_m;
+	m = bpf_map_area_alloc(size, numa_node);
+	if (!m) {
+		bpf_map_charge_finish(&mem);
+		return ERR_PTR(-ENOMEM);
+	}
 
-	err = -ENOMEM;
+	bpf_map_init_from_attr(&m->map, attr);
+	bpf_map_charge_move(&m->map.memory, &mem);
+	spin_lock_init(&m->lock);
 
 	m->flush_list = alloc_percpu(struct list_head);
-	if (!m->flush_list)
-		goto free_charge;
+	if (!m->flush_list) {
+		bpf_map_charge_finish(&m->map.memory);
+		bpf_map_area_free(m);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	for_each_possible_cpu(cpu)
 		INIT_LIST_HEAD(per_cpu_ptr(m->flush_list, cpu));
 
-	m->xsk_map = bpf_map_area_alloc(m->map.max_entries *
-					sizeof(struct xdp_sock *),
-					m->map.numa_node);
-	if (!m->xsk_map)
-		goto free_percpu;
 	return &m->map;
-
-free_percpu:
-	free_percpu(m->flush_list);
-free_charge:
-	bpf_map_charge_finish(&m->map.memory);
-free_m:
-	kfree(m);
-	return ERR_PTR(err);
 }
 
 static void xsk_map_free(struct bpf_map *map)
@@ -139,8 +133,7 @@ static void xsk_map_free(struct bpf_map *map)
 	bpf_clear_redirect_map(map);
 	synchronize_net();
 	free_percpu(m->flush_list);
-	bpf_map_area_free(m->xsk_map);
-	kfree(m);
+	bpf_map_area_free(m);
 }
 
 static int xsk_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
-- 
2.20.1

