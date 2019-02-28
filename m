Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09C4C10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7118920830
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hQIL/UhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfB1Xbe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:31:34 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726631AbfB1Xbd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Feb 2019 18:31:33 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x1SNSZwg002203
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=9i1lDDyiX6EYz4yom4CayHQJIy/EVoB//AM7hzboX+Y=;
 b=hQIL/UhCpTx/g3J+cH+P8vjP7cEY93pto7noJQkUEQlRfxEJPLQfQ4s55GKfcfjTfem/
 MXiZMP2WquPNKWhnhCyso4/o1IE4+uQAhFZDvg53V8UuaOfRQdcgXweQgvqpDZTlmV6e
 bDWReDEgN3KkFLqb51uiVpq/+JXt02OVys8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2qxrh085ca-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 15:31:31 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 28 Feb 2019 15:31:28 -0800
Received: by devvm7221.prn2.facebook.com (Postfix, from userid 137359)
        id D1921C155DDE; Thu, 28 Feb 2019 15:31:26 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devvm7221.prn2.facebook.com
To:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>, <ast@fb.com>,
        <acme@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <songliubraving@fb.com>
CC:     Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next 3/5] btf: allow to customize dedup hash table size
Date:   Thu, 28 Feb 2019 15:31:23 -0800
Message-ID: <20190228233125.1013080-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228233125.1013080-1-andriin@fb.com>
References: <20190228233125.1013080-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
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
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/btf.c | 53 ++++++++++++++++++++++++++++++---------------
 tools/lib/bpf/btf.h |  1 +
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 68b50e9bbde1..0f83f99211c6 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1070,8 +1070,8 @@ int btf__dedup(struct btf *btf, struct btf_ext *btf_ext,
 	return err;
 }
 
-#define BTF_DEDUP_TABLE_SIZE_LOG 14
-#define BTF_DEDUP_TABLE_MOD ((1 << BTF_DEDUP_TABLE_SIZE_LOG) - 1)
+#define BTF_DEDUP_TABLE_DEFAULT_SIZE (1 << 14)
+#define BTF_DEDUP_TABLE_MAX_SIZE_LOG 31
 #define BTF_UNPROCESSED_ID ((__u32)-1)
 #define BTF_IN_PROGRESS_ID ((__u32)-2)
 
@@ -1128,18 +1128,21 @@ static inline __u32 hash_combine(__u32 h, __u32 value)
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
 
@@ -1177,7 +1180,7 @@ static void btf_dedup_table_free(struct btf_dedup *d)
 	if (!d->dedup_table)
 		return;
 
-	for (i = 0; i < (1 << BTF_DEDUP_TABLE_SIZE_LOG); i++) {
+	for (i = 0; i < d->opts.dedup_table_size; i++) {
 		while (d->dedup_table[i]) {
 			tmp = d->dedup_table[i];
 			d->dedup_table[i] = tmp->next;
@@ -1212,19 +1215,37 @@ static void btf_dedup_free(struct btf_dedup *d)
 	free(d);
 }
 
+/* Find closest power of two >= to size, capped at 2^max_size_log */
+static __u32 roundup_pow2_max(__u32 size, int max_size_log)
+{
+	int i;
+
+	for (i = 0; i < max_size_log  && (1U << i) < size;  i++)
+		;
+	return 1U << i;
+}
+
+
 static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
 				       const struct btf_dedup_opts *opts)
 {
 	struct btf_dedup *d = calloc(1, sizeof(struct btf_dedup));
 	int i, err = 0;
+	__u32 sz;
 
 	if (!d)
 		return ERR_PTR(-ENOMEM);
 
+	d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;
+	sz = opts && opts->dedup_table_size ? opts->dedup_table_size
+					    : BTF_DEDUP_TABLE_DEFAULT_SIZE;
+	sz = roundup_pow2_max(sz, BTF_DEDUP_TABLE_MAX_SIZE_LOG);
+	d->opts.dedup_table_size = sz;
+
 	d->btf = btf;
 	d->btf_ext = btf_ext;
 
-	d->dedup_table = calloc(1 << BTF_DEDUP_TABLE_SIZE_LOG,
+	d->dedup_table = calloc(d->opts.dedup_table_size,
 				sizeof(struct btf_dedup_node *));
 	if (!d->dedup_table) {
 		err = -ENOMEM;
@@ -1249,8 +1270,6 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, struct btf_ext *btf_ext,
 	for (i = 0; i <= btf->nr_types; i++)
 		d->hypot_map[i] = BTF_UNPROCESSED_ID;
 
-	d->opts.dont_resolve_fwds = opts && opts->dont_resolve_fwds;
-
 done:
 	if (err) {
 		btf_dedup_free(d);
@@ -1824,7 +1843,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 
 	case BTF_KIND_INT:
 		h = btf_hash_int(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_int(t, cand)) {
 				new_id = cand_node->type_id;
@@ -1835,7 +1854,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 
 	case BTF_KIND_ENUM:
 		h = btf_hash_enum(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_enum(t, cand)) {
 				new_id = cand_node->type_id;
@@ -1846,7 +1865,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 
 	case BTF_KIND_FWD:
 		h = btf_hash_common(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_common(t, cand)) {
 				new_id = cand_node->type_id;
@@ -2263,7 +2282,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 		return 0;
 
 	h = btf_hash_struct(t);
-	for_each_hash_node(d->dedup_table, h, cand_node) {
+	for_each_dedup_cand(d, h, cand_node) {
 		int eq;
 
 		btf_dedup_clear_hypot_map(d);
@@ -2349,7 +2368,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 		t->type = ref_type_id;
 
 		h = btf_hash_common(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_common(t, cand)) {
 				new_id = cand_node->type_id;
@@ -2372,7 +2391,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 		info->index_type = ref_type_id;
 
 		h = btf_hash_array(t);
-		for_each_hash_node(d->dedup_table, h, cand_node) {
+		for_each_dedup_cand(d, h, cand_node) {
 			cand = d->btf->types[cand_node->type_id];
 			if (btf_equal_array(t, cand)) {
 				new_id = cand_node->type_id;
@@ -2403,7 +2422,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
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

