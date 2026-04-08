Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85833D47DE
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661038; cv=none; b=WLCXubwjVPuFdZ1tVgLpaYRi0Udqw1jxu2tOf9eH/F3eMyuyzQBcSMHWl4jN6QZ2vCMYftkKgjp17IJZvlIrOmXVQzwodfrsXNKqeXhk29Z0vcDzVvJxfumifsNJtXEFcfK90x+bW8UoeTF2f3v61VgWCEDRd7e4pq0NNpG/f4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661038; c=relaxed/simple;
	bh=TaCCij6ps2UrWqYDrUq4xeU6QuyAuSpabjRvYBuvheQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mr01TbRy5EAH/slvd3UePPB5toWUukWHIdElZ2SRTHZPTu3Bg5I4iHliStqbzOPfHO5RGLcTPORckhl7PzyHPR51lA2xsbC9tSCk9Y0r7w1yPiu8KLRTERkDEHWsHaJOUD0yIIhp/x3DbkBoH1nq9/c/ubRK9xJndWF5fe5NUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQiFCel3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQiFCel3"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a041eae5so34567355e9.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775661035; x=1776265835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWuVsGBhS7BQ7SAP19FbwixcKwunuVkCRK0XAHExISI=;
        b=MQiFCel31+bVw29twnl15ltHefyWS0PLe5Z8VakzYra0YAGvIiEOok3Y525SEpoaMK
         dNOeV2o3nvsHOlr6qgCj/dt9xp257cklm3G3iIHyye+qtKjS3GfJZQWRDorEHxq0D7gq
         I3k+Ai9ZjswLq5BmiWYw5sglh4EVcgwAC+dgc1MYFdDOx3waF20R0WTm2ZDTwGESIABF
         mNV8o2GAZf1NM3OiorF1atcoiKmVrkp7ByhKECOK2fE1706ZoeXb5DIQM0eQRaoQAzLr
         PscgzZJ5rcewQPFbE4XwHvFEgr7vn67rdFLYKa/j800uByW/5xJWeOWI+vF/5qE3an2k
         rVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661035; x=1776265835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OWuVsGBhS7BQ7SAP19FbwixcKwunuVkCRK0XAHExISI=;
        b=oQKOpNVRhJI6cXz6YQyGmilAjmlCrVHOyL/5B4g4T27fkmiD2dEqo9a8gB96IOt4Ok
         2ceY0Oaav7X1Tmm7OUra9NlFKZPQfUQRy+qx9/+eLCXznaG9UGDkujyhyYXOt9obnD8Q
         7W43VEuLyEQY+OfEXTXNdKPA3nUQFpnyhlr7jKnZBmEWLzimQoAdfs9jc5WmhvsiMsDo
         35ejXZyyulqVN83AmPbT5fi0wUzb4SdyCE7jTAv6g1bbGAFHQqf0CSeAeoAKJpl4eytM
         f7Y93nCNM7sEDgLWYnzD+LcCIgcUeVTqy5PjTXX9eUx4ZVtmN8KRtqv83zSEhZmA0E33
         psaA==
X-Gm-Message-State: AOJu0YzK5PLzjmN+NANimvrHWw3BgQe6/eFbzfFPQ6HswEYqn6ZoGZqp
	J2/PS4c4Gh/BCJrDTlwJ8cRD8pMIh14OkgRE0e6BerdXTu8I8XuG7eUH
X-Gm-Gg: AeBDietKGT0cwuXUwQ+J0XuZILVcQrpgB4nO7H2BoGZFA5hqyGacyCYuDF1mB/QPDiG
	vczdReXMCjLA0cGo4pz4Zy5QiZPgdH5wIeIK/y8wBMDjQOY6JpN46lSbqV1dAOSv3b2m2AdN+T1
	SmLr2peeR/GLb+ytUJb+4kTIVm82/hHbKo1QwDmlWJIDuJDyhJdnnR7vNpiNGxexbRx/PNT/A+x
	fvHqcERu+3D9QQKloukplgtOsdXtTclsxuxw3iiRv0RjMH/mGdpGmYcoucUfma/WcYXBfipZuVR
	wxjPydXq42fWjIgzzIHdH0oAZxBhV8gGflHM6RlWYKc1p658tViI3TPkk1nd9864OC+IRCs4qMz
	M50EEbk9kJprd8f0f5EM5VWJbXvJ4oRXHicCFjiJtTnYrE9UT0em75/IQB+gG4ZSDSvtaNmbJ1e
	l8xEBxNZNjyYhK
X-Received: by 2002:a05:600c:348d:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488be2155c0mr109549885e9.8.1775661035069;
        Wed, 08 Apr 2026 08:10:35 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a3d6944bsm361413865e9.11.2026.04.08.08.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:34 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 08 Apr 2026 08:10:07 -0700
Subject: [PATCH RFC bpf-next v2 02/18] bpf: Add resizable hashtab skeleton
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-rhash-v2-2-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
In-Reply-To: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com, herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775661028; l=6246;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=/Nk5DrRFCKtFQZV3GU2hd56HHRpfo6Dyeasbtqthpv0=;
 b=BFThyQJbCtr13aVtBr+bJQ/qTratVeO7GdS23SX1R6lDIvYNX7QcI92PBkeNWuEwP35Upi25R
 5/xVzFKgfd8Cz75FPNglGGmNIp2qIU1clNGrym7qIuGsIrtvqyj/og2
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Added a skeleton for resizable hashtab. Actual implementation follows
in the next patches of the series.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf_types.h |   1 +
 kernel/bpf/hashtab.c      | 166 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index b13de31e163f..56e4c3f983d3 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -134,6 +134,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_BLOOM_FILTER, bloom_filter_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_USER_RINGBUF, user_ringbuf_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARENA, arena_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_INSN_ARRAY, insn_array_map_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_RHASH, rhtab_map_ops)
 
 BPF_LINK_TYPE(BPF_LINK_TYPE_RAW_TRACEPOINT, raw_tracepoint)
 BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index bc6bc8bb871d..9e7806814fec 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -9,6 +9,7 @@
 #include <linux/rculist_nulls.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/random.h>
+#include <linux/rhashtable.h>
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/btf_ids.h>
@@ -418,6 +419,7 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	bool percpu_lru = (attr->map_flags & BPF_F_NO_COMMON_LRU);
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
 	bool zero_seed = (attr->map_flags & BPF_F_ZERO_SEED);
+	bool resizable = attr->map_type == BPF_MAP_TYPE_RHASH;
 	int numa_node = bpf_map_attr_numa_node(attr);
 
 	BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=
@@ -459,6 +461,9 @@ static int htab_map_alloc_check(union bpf_attr *attr)
 	if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
 		return -E2BIG;
 
+	if (resizable && percpu_lru)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2735,3 +2740,164 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 };
+
+struct rhtab_elem {
+	struct rhash_head node;
+	/* key bytes, then value bytes follow */
+	u8 data[] __aligned(8);
+};
+
+struct bpf_rhtab {
+	struct bpf_map map;
+	struct rhashtable ht;
+	struct rhashtable_params params;
+	struct bpf_mem_alloc ma;
+	u32 elem_size;
+};
+
+static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static int rhtab_map_alloc_check(union bpf_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+
+static void rhtab_map_free(struct bpf_map *map)
+{
+}
+
+static void *rhtab_map_lookup_elem(struct bpf_map *map, void *key) __must_hold(RCU)
+{
+	return NULL;
+}
+
+static long rhtab_map_delete_elem(struct bpf_map *map, void *key)
+{
+	return -EOPNOTSUPP;
+}
+
+static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static void rhtab_map_free_internal_structs(struct bpf_map *map)
+{
+}
+
+static int rhtab_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
+{
+	return -EOPNOTSUPP;
+}
+
+static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	return -EOPNOTSUPP;
+}
+
+static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
+{
+}
+
+static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
+				void *callback_ctx, u64 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static u64 rhtab_map_mem_usage(const struct bpf_map *map)
+{
+	return 0;
+}
+
+static int rhtab_map_lookup_batch(struct bpf_map *map, const union bpf_attr *attr,
+				  union bpf_attr __user *uattr)
+{
+	return 0;
+}
+
+static int rhtab_map_lookup_and_delete_batch(struct bpf_map *map, const union bpf_attr *attr,
+					     union bpf_attr __user *uattr)
+{
+	return 0;
+}
+
+struct bpf_iter_seq_rhash_map_info {
+	struct bpf_map *map;
+	struct bpf_rhtab *rhtab;
+	struct rhashtable_iter iter;
+	u32 skip_elems;
+	bool iter_active;
+};
+
+static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	return NULL;
+}
+
+static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return NULL;
+}
+
+static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
+{
+	return 0;
+}
+
+static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
+{
+}
+
+static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_info *aux)
+{
+	return 0;
+}
+
+static void bpf_iter_fini_rhash_map(void *priv_data)
+{
+}
+
+static const struct seq_operations bpf_rhash_map_seq_ops = {
+	.start = bpf_rhash_map_seq_start,
+	.next = bpf_rhash_map_seq_next,
+	.stop = bpf_rhash_map_seq_stop,
+	.show = bpf_rhash_map_seq_show,
+};
+
+static const struct bpf_iter_seq_info rhash_iter_seq_info = {
+	.seq_ops = &bpf_rhash_map_seq_ops,
+	.init_seq_private = bpf_iter_init_rhash_map,
+	.fini_seq_private = bpf_iter_fini_rhash_map,
+	.seq_priv_size = sizeof(struct bpf_iter_seq_rhash_map_info),
+};
+
+BTF_ID_LIST_SINGLE(rhtab_map_btf_ids, struct, bpf_rhtab)
+const struct bpf_map_ops rhtab_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = rhtab_map_alloc_check,
+	.map_alloc = rhtab_map_alloc,
+	.map_free = rhtab_map_free,
+	.map_get_next_key = rhtab_map_get_next_key,
+	.map_release_uref = rhtab_map_free_internal_structs,
+	.map_lookup_elem = rhtab_map_lookup_elem,
+	.map_lookup_and_delete_elem = rhtab_map_lookup_and_delete_elem,
+	.map_update_elem = rhtab_map_update_elem,
+	.map_delete_elem = rhtab_map_delete_elem,
+	.map_gen_lookup = rhtab_map_gen_lookup,
+	.map_seq_show_elem = rhtab_map_seq_show_elem,
+	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_for_each_callback = bpf_each_rhash_elem,
+	.map_mem_usage = rhtab_map_mem_usage,
+	BATCH_OPS(rhtab),
+	.map_btf_id = &rhtab_map_btf_ids[0],
+	.iter_seq_info = &rhash_iter_seq_info,
+};

-- 
2.52.0

