Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEDBC10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E7F218D8
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfB1XTV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:19:21 -0500
Received: from www62.your-server.de ([213.133.104.62]:52342 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbfB1XTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:19:09 -0500
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzUxD-0000lZ-Bv; Fri, 01 Mar 2019 00:19:03 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch, yhs@fb.com,
        andriin@fb.com, jakub.kicinski@netronome.com, lmb@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 2/7] bpf: add program side {rd,wr}only support
Date:   Fri,  1 Mar 2019 00:18:24 +0100
Message-Id: <20190228231829.11993-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190228231829.11993-1-daniel@iogearbox.net>
References: <20190228231829.11993-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This work adds two new map creation flags BPF_F_RDONLY_PROG
and BPF_F_WRONLY_PROG in order to allow for read-only or
write-only BPF maps from a BPF program side.

Today we have BPF_F_RDONLY and BPF_F_WRONLY, but this only
applies to system call side, meaning the BPF program has full
read/write access to the map as usual while bpf(2) calls with
map fd can either only read or write into the map depending
on the flags. BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG allows
for the exact opposite such that verifier is going to reject
program loads if write into a read-only map or a read into a
write-only map is detected.

We've enabled this generic map extension to various non-special
maps holding normal user data: array, hash, lru, lpm, local
storage, queue and stack. Further map types could be followed
up in future depending on use-case. Main use case here is to
forbid writes into .rodata map values from verifier side.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/bpf.h           | 18 ++++++++++++++++++
 include/uapi/linux/bpf.h      | 10 +++++++++-
 kernel/bpf/arraymap.c         |  2 +-
 kernel/bpf/hashtab.c          |  2 +-
 kernel/bpf/local_storage.c    |  2 +-
 kernel/bpf/lpm_trie.c         |  2 +-
 kernel/bpf/queue_stack_maps.c |  3 +--
 kernel/bpf/verifier.c         | 30 +++++++++++++++++++++++++++++-
 8 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdcc6e2a9977..3f74194dd4f6 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -427,6 +427,24 @@ struct bpf_array {
 	};
 };
 
+#define BPF_MAP_CAN_READ	BIT(0)
+#define BPF_MAP_CAN_WRITE	BIT(1)
+
+static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
+{
+	u32 access_flags = map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
+
+	/* Combination of BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG is
+	 * not possible.
+	 */
+	if (access_flags & BPF_F_RDONLY_PROG)
+		return BPF_MAP_CAN_READ;
+	else if (access_flags & BPF_F_WRONLY_PROG)
+		return BPF_MAP_CAN_WRITE;
+	else
+		return BPF_MAP_CAN_READ | BPF_MAP_CAN_WRITE;
+}
+
 #define MAX_TAIL_CALL_CNT 32
 
 struct bpf_event_entry {
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8884072e1a46..04b26f59b413 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -287,7 +287,7 @@ enum bpf_attach_type {
 
 #define BPF_OBJ_NAME_LEN 16U
 
-/* Flags for accessing BPF object */
+/* Flags for accessing BPF object from syscall side. */
 #define BPF_F_RDONLY		(1U << 3)
 #define BPF_F_WRONLY		(1U << 4)
 
@@ -297,6 +297,14 @@ enum bpf_attach_type {
 /* Zero-initialize hash function seed. This should only be used for testing. */
 #define BPF_F_ZERO_SEED		(1U << 6)
 
+/* Flags for accessing BPF object from program side. */
+#define BPF_F_RDONLY_PROG	(1U << 7)
+#define BPF_F_WRONLY_PROG	(1U << 8)
+#define BPF_F_ACCESS_MASK	(BPF_F_RDONLY |		\
+				 BPF_F_RDONLY_PROG |	\
+				 BPF_F_WRONLY |		\
+				 BPF_F_WRONLY_PROG)
+
 /* flags for BPF_PROG_QUERY */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3e5969c0c979..076dc3d77faf 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -22,7 +22,7 @@
 #include "map_in_map.h"
 
 #define ARRAY_CREATE_FLAG_MASK \
-	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
+	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
 
 static void bpf_array_free_percpu(struct bpf_array *array)
 {
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index fed15cf94dca..ab9d51ac80e1 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -23,7 +23,7 @@
 
 #define HTAB_CREATE_FLAG_MASK						\
 	(BPF_F_NO_PREALLOC | BPF_F_NO_COMMON_LRU | BPF_F_NUMA_NODE |	\
-	 BPF_F_RDONLY | BPF_F_WRONLY | BPF_F_ZERO_SEED)
+	 BPF_F_ACCESS_MASK | BPF_F_ZERO_SEED)
 
 struct bucket {
 	struct hlist_nulls_head head;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 6b572e2de7fb..3ffe3259da00 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -14,7 +14,7 @@ DEFINE_PER_CPU(struct bpf_cgroup_storage*, bpf_cgroup_storage[MAX_BPF_CGROUP_STO
 #ifdef CONFIG_CGROUP_BPF
 
 #define LOCAL_STORAGE_CREATE_FLAG_MASK					\
-	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
+	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
 
 struct bpf_cgroup_storage_map {
 	struct bpf_map map;
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index abf1002080df..79c75b1626b8 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -537,7 +537,7 @@ static int trie_delete_elem(struct bpf_map *map, void *_key)
 #define LPM_KEY_SIZE_MIN	LPM_KEY_SIZE(LPM_DATA_SIZE_MIN)
 
 #define LPM_CREATE_FLAG_MASK	(BPF_F_NO_PREALLOC | BPF_F_NUMA_NODE |	\
-				 BPF_F_RDONLY | BPF_F_WRONLY)
+				 BPF_F_ACCESS_MASK)
 
 static struct bpf_map *trie_alloc(union bpf_attr *attr)
 {
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index b384ea9f3254..1eb9ceef075c 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -11,8 +11,7 @@
 #include "percpu_freelist.h"
 
 #define QUEUE_STACK_CREATE_FLAG_MASK \
-	(BPF_F_NUMA_NODE | BPF_F_RDONLY | BPF_F_WRONLY)
-
+	(BPF_F_NUMA_NODE | BPF_F_ACCESS_MASK)
 
 struct bpf_queue_stack {
 	struct bpf_map map;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3ad05dda6e9d..cdd2cb01f789 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1429,6 +1429,28 @@ static int check_stack_access(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int check_map_access_type(struct bpf_verifier_env *env, u32 regno,
+				 int off, int size, enum bpf_access_type type)
+{
+	struct bpf_reg_state *regs = cur_regs(env);
+	struct bpf_map *map = regs[regno].map_ptr;
+	u32 cap = bpf_map_flags_to_cap(map);
+
+	if (type == BPF_WRITE && !(cap & BPF_MAP_CAN_WRITE)) {
+		verbose(env, "write into map forbidden, value_size=%d off=%d size=%d\n",
+			map->value_size, off, size);
+		return -EACCES;
+	}
+
+	if (type == BPF_READ && !(cap & BPF_MAP_CAN_READ)) {
+		verbose(env, "read into map forbidden, value_size=%d off=%d size=%d\n",
+			map->value_size, off, size);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
 /* check read/write into map element returned by bpf_map_lookup_elem() */
 static int __check_map_access(struct bpf_verifier_env *env, u32 regno, int off,
 			      int size, bool zero_size_allowed)
@@ -2014,7 +2036,9 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			verbose(env, "R%d leaks addr into map\n", value_regno);
 			return -EACCES;
 		}
-
+		err = check_map_access_type(env, regno, off, size, t);
+		if (err)
+			return err;
 		err = check_map_access(env, regno, off, size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
@@ -2250,6 +2274,10 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 		return check_packet_access(env, regno, reg->off, access_size,
 					   zero_size_allowed);
 	case PTR_TO_MAP_VALUE:
+		if (check_map_access_type(env, regno, reg->off, access_size,
+					  meta && meta->raw_mode ? BPF_WRITE :
+					  BPF_READ))
+			return -EACCES;
 		return check_map_access(env, regno, reg->off, access_size,
 					zero_size_allowed);
 	default: /* scalar_value|ptr_to_stack or invalid ptr */
-- 
2.17.1

