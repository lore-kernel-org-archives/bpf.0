Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA659C4360F
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945B720700
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDCSX3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:23:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:55386 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfDCSX3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 14:23:29 -0400
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBkXj-0006DF-P2; Wed, 03 Apr 2019 20:23:23 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, joe@wand.net.nz, yhs@fb.com,
        andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 07/15] bpf: allow for key-less BTF in array map
Date:   Wed,  3 Apr 2019 20:22:58 +0200
Message-Id: <2ee9fa3052abb17dde737add2726c86b5e18385b.1554314902.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Given we'll be reusing BPF array maps for global data/bss/rodata
sections, we need a way to associate BTF DataSec type as its map
value type. In usual cases we have this ugly BPF_ANNOTATE_KV_PAIR()
macro hack e.g. via 38d5d3b3d5db ("bpf: Introduce BPF_ANNOTATE_KV_PAIR")
to get initial map to type association going. While more use cases
for it are discouraged, this also won't work for global data since
the use of array map is a BPF loader detail and therefore unknown
at compilation time. For array maps with just a single entry we make
an exception in terms of BTF in that key type is declared optional
if value type is of DataSec type. Latter LLVM is guaranteed to emit
and it also aligns with how we regard global data maps as just a
plain buffer area reusing existing map facilities for allowing things
like introspection with existing tools.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/btf.h        |  2 ++
 kernel/bpf/arraymap.c      | 15 ++++++++++++++-
 kernel/bpf/btf.c           |  7 ++++++-
 kernel/bpf/local_storage.c |  2 ++
 kernel/bpf/lpm_trie.c      |  3 +++
 kernel/bpf/syscall.c       | 15 +++++++++++----
 6 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 455d31b..747ac99 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -51,6 +51,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
 			   const struct btf_member *m,
 			   u32 expected_offset, u32 expected_size);
 int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
+const struct btf_type *btf_type_void_get(void);
+bool btf_type_is_void(const struct btf_type *t);
 
 #ifdef CONFIG_BPF_SYSCALL
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 411626f..282ddce 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -388,7 +388,8 @@ static void array_map_seq_show_elem(struct bpf_map *map, void *key,
 		return;
 	}
 
-	seq_printf(m, "%u: ", *(u32 *)key);
+	if (map->btf_key_type_id)
+		seq_printf(m, "%u: ", *(u32 *)key);
 	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
 	seq_puts(m, "\n");
 
@@ -425,6 +426,18 @@ static int array_map_check_btf(const struct bpf_map *map,
 {
 	u32 int_data;
 
+	/* One exception for keyless BTF: .bss/.data/.rodata map */
+	if (btf_type_is_void(key_type)) {
+		if (map->map_type != BPF_MAP_TYPE_ARRAY ||
+		    map->max_entries != 1)
+			return -EINVAL;
+
+		if (BTF_INFO_KIND(value_type->info) != BTF_KIND_DATASEC)
+			return -EINVAL;
+
+		return 0;
+	}
+
 	if (BTF_INFO_KIND(key_type->info) != BTF_KIND_INT)
 		return -EINVAL;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5c9285c..85aab99 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -327,7 +327,12 @@ static bool btf_type_is_modifier(const struct btf_type *t)
 	return false;
 }
 
-static bool btf_type_is_void(const struct btf_type *t)
+const struct btf_type *btf_type_void_get(void)
+{
+	return &btf_void;
+}
+
+bool btf_type_is_void(const struct btf_type *t)
 {
 	return t == &btf_void;
 }
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 980e8f1..5e3a0f8 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -338,6 +338,8 @@ static int cgroup_storage_check_btf(const struct bpf_map *map,
 	 *	__u32	attach_type;
 	 * };
 	 */
+	if (btf_type_is_void(key_type))
+		return -EINVAL;
 
 	/*
 	 * Key_type must be a structure with two fields.
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index e61630c..182378f 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -734,6 +734,9 @@ static int trie_check_btf(const struct bpf_map *map,
 			  const struct btf_type *key_type,
 			  const struct btf_type *value_type)
 {
+	if (btf_type_is_void(key_type))
+		return -EINVAL;
+
 	/* Keys must have struct bpf_lpm_trie_key embedded. */
 	return BTF_INFO_KIND(key_type->info) != BTF_KIND_STRUCT ?
 	       -EINVAL : 0;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dcff630..c4c9efa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -494,9 +494,16 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	u32 key_size, value_size;
 	int ret = 0;
 
-	key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
-	if (!key_type || key_size != map->key_size)
-		return -EINVAL;
+	/* Some maps allow key to be unspecified. */
+	if (btf_key_id) {
+		key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
+		if (!key_type || key_size != map->key_size)
+			return -EINVAL;
+	} else {
+		key_type = btf_type_void_get();
+		if (!map->ops->map_check_btf)
+			return -EINVAL;
+	}
 
 	value_type = btf_type_id_size(btf, &btf_value_id, &value_size);
 	if (!value_type || value_size != map->value_size)
@@ -564,7 +571,7 @@ static int map_create(union bpf_attr *attr)
 	if (attr->btf_key_type_id || attr->btf_value_type_id) {
 		struct btf *btf;
 
-		if (!attr->btf_key_type_id || !attr->btf_value_type_id) {
+		if (!attr->btf_value_type_id) {
 			err = -EINVAL;
 			goto free_map_nouncharge;
 		}
-- 
2.9.5

