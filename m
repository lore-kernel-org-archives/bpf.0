Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B887C4360F
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE6F2133D
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 22:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BK8Alomk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbfB0WrC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:47:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730189AbfB0Wqy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 27 Feb 2019 17:46:54 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1RMbOta005758
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hSIwi9nxKoxtoVYzn/ZKlLIJ1IWoCePZKtrycLWhdOY=;
 b=BK8Alomkzw/ju+xCK/+n4yFSRhA/rBKYjTI18i+3lKOVdi6Ld+rqPAUtRCq3YT4Pi5W1
 kDbcsaD1HI6fDxzYKMWF8FoQfeGTOVHgk2hCuQLddQlbN9hVEvIKbz2PV8MVZ1JVUHNh
 Gj1gbbXPgdYs6hhzVii6ZDnnmA2GHd4q4P0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2qx25v89r7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 14:46:50 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 27 Feb 2019 14:46:49 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id 99228C07CCD2; Wed, 27 Feb 2019 14:46:47 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 3/5] btf: allow to customize dedup hash table size
Date:   Wed, 27 Feb 2019 14:46:39 -0800
Message-ID: <20190227224642.1069138-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227224642.1069138-1-andriin@fb.com>
References: <20190227224642.1069138-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Default size of dedup table (16k) is good enough for most binaries, even
typical vmlinux images. But there are cases of binaries with huge amount
of BTF types (e.g., allyesconfig variants of kernel), which benefit from
having bigger dedup table size to lower amount of unnecessary hash
collisions. Tools like pahole, thus, can tune this parameter to reach
optimal performance.

This change also serves double purpose of allowing tests to force hash
collisions to test some corner cases, used in follow up patch.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/btf.c | 43 ++++++++++++++++++++++++++-----------------
 tools/lib/bpf/btf.h |  1 +
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 68b50e9bbde1..6bbb710216e6 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1070,8 +1070,7 @@ int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
 	return err;
 }
 
-#define BTF_DEDUP_TABLE_SIZE_LOG 14
-#define BTF_DEDUP_TABLE_MOD ((1 << BTF_DEDUP_TABLE_SIZE_LOG) - 1)
+#define BTF_DEDUP_TABLE_DEFAULT_SIZE (1 << 14)
 #define BTF_UNPROCESSED_ID ((__u32)-1)
 #define BTF_IN_PROGRESS_ID ((__u32)-2)
 
@@ -1128,18 +1127,21 @@ static inline __u32 hash_combine(__u32 h, __u32 value)
 #undef GOLDEN_RATIO_PRIME
 }
 
-#define for_each_hash_node(table, hash, node) \
-	for (node = table[hash & BTF_DEDUP_TABLE_MOD]; node; node = node->next)
+#define for_each_dedup_cand(d, hash, node) \
+	for (node = d->dedup_table[hash & (d->opts.dedup_table_size - 1)]; \
+	     node;							   \
+	     node = node->next)
 
 static int btf_dedup_table_add(struct btf_dedup *d, __u32 hash, __u32 type_id)
 {
 	struct btf_dedup_node *node = malloc(sizeof(struct btf_dedup_node));
+	int bucket = hash & (d->opts.dedup_table_size - 1);
 
 	if (!node)
 		return -ENOMEM;
 	node->type_id = type_id;
-	node->next = d->dedup_table[hash & BTF_DEDUP_TABLE_MOD];
-	d->dedup_table[hash & BTF_DEDUP_TABLE_MOD] = node;
+	node->next = d->dedup_table[bucket];
+	d->dedup_table[bucket] = node;
 	return 0;
 }
 
@@ -1177,7 +1179,7 @@ static void btf_dedup_table_free(struct btf_dedup *d)
 	if (!d->dedup_table)
 		return;
 
-	for (i = 0; i < (1 << BTF_DEDUP_TABLE_SIZE_LOG); i++) {
+	for (i = 0; i < d->opts.dedup_table_size; i++) {
 		while (d->dedup_table[i]) {
 			tmp = d->dedup_table[i];
 			d->dedup_table[i] = tmp->next;
@@ -1221,10 +1223,19 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
 	if (!d)
 		return ERR_PTR(-ENOMEM);
 
+	d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;
+	/* ensure table size is power of two and limit to 2G */
+	d->opts.dedup_table_size = opts && opts->dedup_table_size
+		? opts->dedup_table_size
+		: BTF_DEDUP_TABLE_DEFAULT_SIZE;
+	for (i = 0; i < 31 && (1 << i) < d->opts.dedup_table_size;  i++)
+		;
+	d->opts.dedup_table_size = 1 << i;
+
 	d->btf = btf;
 	d->btf_ext = btf_ext;
 
-	d->dedup_table = calloc(1 << BTF_DEDUP_TABLE_SIZE_LOG,
+	d->dedup_table = calloc(d->opts.dedup_table_size,
 				sizeof(struct btf_dedup_node *));
 	if (!d->dedup_table) {
 		err = -ENOMEM;
@@ -1249,8 +1260,6 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
 	for (i = 0; i <= btf->nr_types; i++)
 		d->hypot_map[i] = BTF_UNPROCESSED_ID;
 
-	d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;
-
 done:
 	if (err) {
 		btf_dedup_free(d);
@@ -1824,7 +1833,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 
 	case BTF_KIND_INT:
 		h = btf_hash_int(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_int(t, cand)) {
 				new_id = cand_node->type_id;
@@ -1835,7 +1844,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 
 	case BTF_KIND_ENUM:
 		h = btf_hash_enum(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_enum(t, cand)) {
 				new_id = cand_node->type_id;
@@ -1846,7 +1855,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 
 	case BTF_KIND_FWD:
 		h = btf_hash_common(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_common(t, cand)) {
 				new_id = cand_node->type_id;
@@ -2263,7 +2272,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 		return 0;
 
 	h = btf_hash_struct(t);
-	for_each_hash_node(d->dedup_table, h, cand_node) {
+	for_each_dedup_cand(d, h, cand_node) {
 		int eq;
 
 		btf_dedup_clear_hypot_map(d);
@@ -2349,7 +2358,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 		t->type = ref_type_id;
 
 		h = btf_hash_common(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_common(t, cand)) {
 				new_id = cand_node->type_id;
@@ -2372,7 +2381,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 		info->index_type = ref_type_id;
 
 		h = btf_hash_array(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_array(t, cand)) {
 				new_id = cand_node->type_id;
@@ -2403,7 +2412,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 		}
 
 		h = btf_hash_fnproto(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_fnproto(t, cand)) {
 				new_id = cand_node->type_id;
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index b60bb7cf5fff..28a1e1e59861 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -90,6 +90,7 @@ LIBBPF_API __u32 btf_ext__func_info_rec_size(const struct btf_ext *btf_ext);
 LIBBPF_API __u32 btf_ext__line_info_rec_size(const struct btf_ext *btf_ext);
 
 struct btf_dedup_opts {
+	unsigned int dedup_table_size;
 	bool dont_resolve_fwds;
 };
 
-- 
2.17.1

