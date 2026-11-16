Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842898;
	b=Tcbu8Pe4e7jtEGaubwUOP/R7lqhl7JzJeSjklx4fjeduRX4pRboB42jf2JVb2cvMYSL+
	 IB7cmnVSzNSN/Fqrh+zFTn2bDgpBEFOvP2hMF6n6/w50MNyfYW1k0ykPrVYH0QALquEsC
	 8UXePGXw/hA4pZBGuy2osK/q1jbMcdO7Ho/s2CqCsci667prUFDRro6npvWYRmoDWwBcf
	 xHy3tX78L8P85a1kcss7f7tqctGc7xRAZcA4qrfn8GF9JTCzSTixnQK7TpmLC0QqcexE1
	 Xq6z/egz+I74q5bLutaAs6O9aWcwbJb6Th8zwjEH1TArWmYoHlNI90zT79INTEKeUbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842898;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iqKvB+emDfqgDeawoRz91zCC3ucZzG2yHGHfVHQexHc=;
	b=tPBgd1/q9d8zCxcIkLcZkHlXy82q4JmbUpxIaIZ1aKe5azHH21atDoyz0SW9SXiCs27w
	 m0VAk/zAsSITomEq46tC65UqQb6JdC3jyYxg+PMl0fRj8wGnGgjjW2/x+fXy6PgNs5RBk
	 an91lHrtQOKNVRP9JhMklx/O7X+Uct3K/q3pylMVfQB3+btDgfPfZTZcbN0gQQa8+U7FX
	 D7VNPMgKJov9aXJqDrbJAXlOWbpdKldOKwjORDAQ29eFb6GuzKc8H0Hz+PpZ34LjFuM5c
	 NlksvQxYGqxgQdZfz3taWXJblrfU4dD8BR8U4hbrmb6d6vRlvpAKe5/fOFcSBwZPX+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ILIeJuEa;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C49606A882
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0C49606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ILIeJuEa
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1899309a91.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 07:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794842896; x=1795447696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqKvB+emDfqgDeawoRz91zCC3ucZzG2yHGHfVHQexHc=;
        b=ILIeJuEaguhQsnAKdXOdKx4tw1BZ1WG5hcwNykwjkyn7jVVrqU/8LH1O0CVU3Q4AG/
         LBcfic+05jZBbXVb2OOM/9blvWQnnM2OJ9TBNsWSUTxQnwkzJI1B0/0WpyqQ16TBMP+/
         +n2DtkJ6wciPa7xsEwksxjy+ej4dzCom/db6evLyl4/rjSAi2/WLZmug6KZU36XKf0iF
         DlVQJlJpyISiTbEWA0PwwJ43RBaxiaL4yOTJZBd5mPJ8GFZ5tRoq/SI23iBIoQ/Sk8jQ
         2SNGZHqubNJiiIedt3Ekhjk1r5oQIoNotdMLcUvelbRLHPRMikkuJRHIg8Biz8H8Z5uu
         ElTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794842896; x=1795447696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iqKvB+emDfqgDeawoRz91zCC3ucZzG2yHGHfVHQexHc=;
        b=AKR8pqW0C9LWwZTOB7v+KtV0E9P4pIJhvuSgeIK5spAUZHDtTXkSzSwj97ir6BaDrV
         caTjI5KYxih2W0QFlrL8nU+BKSMoU+XdJn/C2+xoqKD2PmmVN6Nr3vkziR6KIQKoLSmh
         IfTc+rBZPTBUUfvdO38/7jUkUJAH+wCYqPF1Yg6fN34S7y6MYtBEf2V6gMVNbSsf4uXU
         TiIYCFKG/CF1ovt0ubvjhfNQaGjs7/ETtvY2E36cbHe1c3gmvW0tUdqN7mN/sDryltod
         QpPsu6PNNuy+kpF4j9sU9kFFnekcKjS31e2tbCEO2vMaQoUM7FaX+3EQcGKNo1X8ATCb
         FGGQ==
X-Gm-Message-State: APuU4Z8pT/Ae/KmkCm7xu5tAHk7KV6trvw7Hb/Bts3H51/2wKcC4uqe4
	XFehakFXqmxOAPnbgPLE0tkjGPgEvrD2l+j9vlwJ95QkF1+fjIOxrxLkBE9oSw==
X-Gm-Gg: AZFdTZdM0m3ZISYGkeEz3cjFlV5927q/9vKN1+qNUIzDn+UArCfsUP1/ehZiOIOMUcE
	QSw4rk/X+Bk3P7QfYmjiH3F/ye8ICe3MzWQ8aCTnM/CFDk5onYl850a2ELF2RjbhJTpqbe7jL5E
	f2BqaKFIn/fzvTJLuUSY8cXQ1sAHRnBY2X4K7O/g41P+waNaI0DCZ8J+H8j8Sh0Ziw560JXMkSB
	+1UrbbbtyQC+lSWmjA79dkZW0lduBwRSmP24pUIZ0n8dbK8AOK1MSKOJJd4J6mK1HE272zS6dJo
	QmOHHfhFihHw/0QBhLRBxVHuXmqhvGEj6hkyWwFRXHMkeL7rEoqYuq5jRzTBGoovilIb7HMiHcW
	YoBaxcVHfN437GU5EJxUwQViFjosK98p1YUn+fhr4pjX4zfTpxUIkENneSnHPsRTaQRwaaV3E72
	S78IH6r3s3P9CRE8emqz73cRVi7gLykCzMpiq3uPtCLIq20SWjhAKnmE0EkIcbGM/4LFAblqaOT
	p3dsxuFIxYX1Yq19q2IwTLaye5CzuMMd7GzfRxAplpJmEiQCdmS5Y17edn7WCpkMbIutsSNQo+9
	IPES6htSDmVXSdwx9h4aECsReJoR+U/Z72R3StyB0Pq9D91SMWpmO9IBIIUY9VDClHPPGTpcoDN
	+z/SLZfDJiXq8iVvFAACkjXHQTXfik4cqhs+s0y6HRcNpXKQ5G7llCla6nMiSA9lv93DHi0Ol7g
	==
X-Received: by 2002:a17:90b:184b:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b1b0ccf45cmr7233668a91.30.1794842895675;
        Mon, 16 Nov 2026 07:28:15 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec66f4csm17704529a91.14.2026.11.16.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:28:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 17/21] bpf: Walk each type once when looking for special fields
Date: Mon, 16 Nov 2026 15:26:22 +0000
Message-ID: <20261116152626.4032587-18-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

The walk enters a struct again for each member of that type. With three
members on each level it takes 3^depth steps, in recursion, and cannot be
killed. Only the limit of 32 levels ends it.

Enter a struct once and copy the fields that were found:

  struct in  { kptr p; };
  struct out { struct in a; long x; struct in b[2]; };
               enter 'in'           copy from a, twice

The walk has its own stack, so the depth is free. The table of fields
grows, so BTF_FIELDS_MAX goes away. Fields are found in order and do not
overlap: look them up with a binary search.

A map value with 12 kptrs had no record at all. It has one now, so the
rules for special fields apply: the map needs CAP_BPF, and it cannot be
mmaped or BPF_F_RDONLY_PROG.

The size of a record is bounded by the size of what it describes. For a
map it is value_size. An allocated object has 4096 bytes, that is 512
fields. A struct with more gets no record when the BTF is loaded.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h                           |   5 -
 include/linux/bpf_verifier.h                  |  15 +
 kernel/bpf/btf.c                              | 334 ++++++++----------
 kernel/bpf/syscall.c                          |   6 +-
 kernel/bpf/verifier.c                         |  67 ++--
 .../selftests/bpf/progs/cpumask_common.h      |   3 -
 .../selftests/bpf/progs/cpumask_failure.c     |   5 +-
 7 files changed, 197 insertions(+), 238 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 16dd9b3d6f33..a5ad08b7937c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -193,11 +193,6 @@ struct bpf_map_ops {
 	const struct bpf_iter_seq_info *iter_seq_info;
 };
 
-enum {
-	/* Support at most 11 fields in a BTF type */
-	BTF_FIELDS_MAX	   = 11,
-};
-
 enum btf_field_type {
 	BPF_SPIN_LOCK  = (1 << 0),
 	BPF_TIMER      = (1 << 1),
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index a11cbf75a8fc..f45c18b3cfa2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1975,6 +1975,21 @@ static inline int bpf_head_guard_target(const struct bpf_verifier_env *env, int
 }
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
 
+/* The first field that ends behind 'off'. The fields are sorted and do not overlap. */
+static inline u32 btf_record_first_field(const struct btf_record *rec, s64 off)
+{
+	u32 l = 0, r = rec->cnt, m;
+
+	while (l < r) {
+		m = (l + r) / 2;
+		if (rec->fields[m].offset + rec->fields[m].size <= off)
+			l = m + 1;
+		else
+			r = m;
+	}
+	return l;
+}
+
 /* Kinds of member a by-value struct or union may be composed of. */
 enum btf_member_kind {
 	BTF_MEMBER_SCALAR	= BIT(0), /* an int or an enum */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9bb98a1c1072..f97b8e754863 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3836,106 +3836,106 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 	return type;
 }
 
-/* Repeat a number of fields for a specified number of times.
+/*
+ * A walk over the members of a type and of the structs in it. A struct is entered once.
+ * The next member of that type gets a copy of the fields that were found:
  *
- * Copy the fields starting from the first field and repeat them for
- * repeat_cnt times. The fields are repeated by adding the offset of each
- * field with
- *   (i + 1) * elem_size
- * where i is the repeat index and elem_size is the size of an element.
+ *   struct in  { kptr p; };
+ *   struct out { struct in a; long x; struct in b[2]; };
+ *                enter 'in'           copy from a, twice
  */
-static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
-			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
-{
-	u32 i, j, total_cnt, total_repeats;
-	u32 cur;
-
-	/* Ensure not repeating fields that should not be repeated. */
-	for (i = 0; i < field_cnt; i++) {
-		switch (info[i].type) {
-		case BPF_KPTR_UNREF:
-		case BPF_KPTR_REF:
-		case BPF_KPTR_PERCPU:
-		case BPF_UPTR:
-		case BPF_LIST_HEAD:
-		case BPF_RB_ROOT:
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
+struct btf_field_walk {
+	struct btf_field_info *info;
+	u32 cnt;
+	u32 field_mask;
+	u32 seen_mask;
+	struct btf_field_scope {
+		const struct btf_type *t;
+		u32 off;	/* in the outer type */
+		u32 nelems;
+		u32 first;	/* its fields in 'info' */
+		u32 cnt;
+		u32 next;	/* member to look at */
+		u32 parent;
+	} *scopes;
+	u32 scope;		/* the current one */
+	struct bpf_index index;	/* address of the type -> scope */
+};
 
-	if (check_add_overflow(repeat_cnt, 1, &total_repeats) ||
-	    check_mul_overflow(field_cnt, total_repeats, &total_cnt) ||
-	    total_cnt > (u32)info_cnt)
-		return -E2BIG;
+/* An allocated object has 4096 bytes at most */
+#define BTF_OBJ_FIELDS_MAX (SZ_4K / sizeof(u64))
 
-	cur = field_cnt;
-	for (i = 0; i < repeat_cnt; i++) {
-		memcpy(&info[cur], &info[0], field_cnt * sizeof(info[0]));
-		for (j = 0; j < field_cnt; j++)
-			info[cur++].off += (i + 1) * elem_size;
-	}
+static int btf_add_field(struct btf_field_walk *w, struct btf_field_info info)
+{
+	struct btf_field_info *last = w->cnt ? &w->info[w->cnt - 1] : NULL;
 
+	if (last && info.off < last->off + btf_field_type_size(last->type))
+		return -EEXIST;
+	if ((w->field_mask & BPF_GRAPH_NODE) && w->cnt == BTF_OBJ_FIELDS_MAX)
+		return -EFBIG;
+	if (bpf_must_abort())
+		return -EINTR;
+	if (!bpf_table_next(w->info, w->cnt))
+		return -ENOMEM;
+	w->info[w->cnt++] = info;
 	return 0;
 }
 
-static int btf_find_struct_field(const struct btf *btf,
-				 const struct btf_type *t, u32 field_mask,
-				 struct btf_field_info *info, int info_cnt,
-				 u32 level, u32 *seen_mask);
-
-/* Find special fields in the struct type of a field.
- *
- * This function is used to find fields of special types that is not a
- * global variable or a direct field of a struct type. It also handles the
- * repetition if it is the element type of an array.
- */
-static int btf_find_nested_struct(const struct btf *btf, const struct btf_type *t,
-				  u32 off, u32 nelems,
-				  u32 field_mask, struct btf_field_info *info,
-				  int info_cnt, u32 level, u32 *seen_mask)
+/* Copy 'cnt' fields from 'first' on to 'nelems' elements. The first copy is 'by' bytes off. */
+static int btf_repeat_fields(struct btf_field_walk *w, u32 first, u32 cnt, u32 by,
+			     u32 nelems, u32 elem_size, bool array)
 {
-	int ret, err, i;
-
-	level++;
-	if (level >= MAX_RESOLVE_DEPTH)
-		return -E2BIG;
-
-	ret = btf_find_struct_field(btf, t, field_mask, info, info_cnt, level, seen_mask);
+	struct btf_field_info info;
+	u32 i, j;
+	int err;
 
-	if (ret <= 0)
-		return ret;
+	for (i = 0; i < nelems && cnt; i++, by += elem_size) {
+		for (j = first; j < first + cnt; j++) {
+			info = w->info[j];
+			info.off += by;
+			if (array && !(info.type & (BPF_KPTR | BPF_UPTR | BPF_GRAPH_ROOT)))
+				return -EINVAL;
+			if (info.type & w->seen_mask)
+				return -E2BIG;
+			err = btf_add_field(w, info);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
 
-	/* Shift the offsets of the nested struct fields to the offsets
-	 * related to the container.
-	 */
-	for (i = 0; i < ret; i++)
-		info[i].off += off;
+static int btf_enter_struct(struct btf_field_walk *w, const struct btf_type *t, u32 off, u32 nelems)
+{
+	int i = bpf_index_find(&w->index, (unsigned long)t);
+	struct btf_field_scope *s;
 
-	if (nelems > 1) {
-		err = btf_repeat_fields(info, info_cnt, ret, nelems - 1, t->size);
-		if (err == 0)
-			ret *= nelems;
-		else
-			ret = err;
+	if (i >= 0) {
+		s = &w->scopes[i];
+		return btf_repeat_fields(w, s->first, s->cnt, off - s->off, nelems, t->size,
+					 nelems > 1);
 	}
-
-	return ret;
+	i = w->index.cnt;
+	s = bpf_table_next(w->scopes, i);
+	if (!s || bpf_index_add(&w->index, (unsigned long)t, i))
+		return -ENOMEM;
+	*s = (struct btf_field_scope){
+		.t = t, .off = off, .nelems = nelems, .first = w->cnt, .parent = w->scope,
+	};
+	w->scope = i;
+	return 0;
 }
 
 static int btf_find_field_one(const struct btf *btf,
 			      const struct btf_type *var,
 			      const struct btf_type *var_type,
 			      int var_idx,
-			      u32 off, u32 expected_size,
-			      u32 field_mask, u32 *seen_mask,
-			      struct btf_field_info *info, int info_cnt,
-			      u32 level)
+			      u32 base, u32 off, u32 expected_size,
+			      struct btf_field_walk *w)
 {
 	int ret, align, sz, field_type;
-	struct btf_field_info tmp;
 	const struct btf_array *array;
+	struct btf_field_info info;
 	u32 i, nelems = 1;
 
 	/* Walk into array types to find the element type and the number of
@@ -3952,15 +3952,13 @@ static int btf_find_field_one(const struct btf *btf,
 		return 0;
 
 	field_type = btf_get_field_type(btf, var_type,
-					field_mask, seen_mask, &align, &sz);
+					w->field_mask, &w->seen_mask, &align, &sz);
 	/* Look into variables of struct types */
 	if (!field_type && __btf_type_is_struct(var_type)) {
 		sz = var_type->size;
 		if (expected_size && expected_size != sz * nelems)
 			return 0;
-		ret = btf_find_nested_struct(btf, var_type, off, nelems, field_mask,
-					     &info[0], info_cnt, level, seen_mask);
-		return ret;
+		return btf_enter_struct(w, var_type, base + off, nelems);
 	}
 
 	if (field_type == 0)
@@ -3972,6 +3970,7 @@ static int btf_find_field_one(const struct btf *btf,
 		return 0;
 	if (off % align)
 		return 0;
+	off += base;
 
 	switch (field_type) {
 	case BPF_SPIN_LOCK:
@@ -3983,8 +3982,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_REFCOUNT:
 	case BPF_TASK_WORK:
 	case BPF_RCU_HEAD:
-		ret = btf_find_struct(btf, var_type, off, sz, field_type,
-				      info_cnt ? &info[0] : &tmp);
+		ret = btf_find_struct(btf, var_type, off, sz, field_type, &info);
 		if (ret < 0)
 			return ret;
 		break;
@@ -3992,17 +3990,14 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
-		ret = btf_find_kptr(btf, var_type, off, sz,
-				    info_cnt ? &info[0] : &tmp, field_mask);
+		ret = btf_find_kptr(btf, var_type, off, sz, &info, w->field_mask);
 		if (ret < 0)
 			return ret;
 		break;
 	case BPF_LIST_HEAD:
 	case BPF_RB_ROOT:
 		ret = btf_find_graph_root(btf, var, var_type,
-					  var_idx, off, sz,
-					  info_cnt ? &info[0] : &tmp,
-					  field_type);
+					  var_idx, off, sz, &info, field_type);
 		if (ret < 0)
 			return ret;
 		break;
@@ -4012,81 +4007,51 @@ static int btf_find_field_one(const struct btf *btf,
 
 	if (ret == BTF_FIELD_IGNORE)
 		return 0;
-	if (!info_cnt)
-		return -E2BIG;
-	if (nelems > 1) {
-		ret = btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
-		if (ret < 0)
-			return ret;
-	}
-	return nelems;
+	return btf_add_field(w, info) ?:
+	       btf_repeat_fields(w, w->cnt - 1, 1, sz, nelems - 1, sz, true);
 }
 
-static int btf_find_struct_field(const struct btf *btf,
-				 const struct btf_type *t, u32 field_mask,
-				 struct btf_field_info *info, int info_cnt,
-				 u32 level, u32 *seen_mask)
+static int btf_find_field(const struct btf *btf, const struct btf_type *t,
+			  struct btf_field_walk *w)
 {
-	int ret, idx = 0;
+	const struct btf_var_secinfo *vsi;
 	const struct btf_member *member;
+	struct btf_field_scope *s;
+	const struct btf_type *var;
 	u32 i, off;
+	int err;
 
-	for_each_member(i, t, member) {
-		const struct btf_type *member_type = btf_type_by_id(btf,
-								    member->type);
-
-		off = __btf_member_bit_offset(t, member);
-		if (off % 8)
-			/* valid C code cannot generate such BTF */
-			return -EINVAL;
-		off /= 8;
-
-		ret = btf_find_field_one(btf, t, member_type, i,
-					 off, 0,
-					 field_mask, seen_mask,
-					 &info[idx], info_cnt - idx, level);
-		if (ret < 0)
-			return ret;
-		idx += ret;
-	}
-	return idx;
-}
-
-static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
-				u32 field_mask, struct btf_field_info *info,
-				int info_cnt, u32 level, u32 *seen_mask)
-{
-	int ret, idx = 0;
-	const struct btf_var_secinfo *vsi;
-	u32 i, off;
+	if (!__btf_type_is_struct(t) && !btf_type_is_datasec(t))
+		return -EINVAL;
 
-	for_each_vsi(i, t, vsi) {
-		const struct btf_type *var = btf_type_by_id(btf, vsi->type);
-		const struct btf_type *var_type = btf_type_by_id(btf, var->type);
-
-		off = vsi->offset;
-		ret = btf_find_field_one(btf, var, var_type, -1, off, vsi->size,
-					 field_mask, seen_mask,
-					 &info[idx], info_cnt - idx,
-					 level);
-		if (ret < 0)
-			return ret;
-		idx += ret;
+	for (err = btf_enter_struct(w, t, 0, 1); !err;) {
+		if (bpf_must_abort())
+			return -EINTR;
+		s = &w->scopes[w->scope];
+		i = s->next++;
+		if (i == btf_type_vlen(s->t)) {
+			if (!w->scope)
+				break;
+			s->cnt = w->cnt - s->first;
+			w->scope = s->parent;
+			err = btf_repeat_fields(w, s->first, s->cnt, s->t->size, s->nelems - 1,
+						s->t->size, true);
+		} else if (btf_type_is_datasec(s->t)) {
+			vsi = btf_type_var_secinfo(s->t) + i;
+			var = btf_type_by_id(btf, vsi->type);
+			err = btf_find_field_one(btf, var, btf_type_by_id(btf, var->type), -1,
+						 0, vsi->offset, vsi->size, w);
+		} else {
+			member = btf_type_member(s->t) + i;
+			off = __btf_member_bit_offset(s->t, member);
+			if (off % 8)
+				/* valid C code cannot generate such BTF */
+				return -EINVAL;
+			err = btf_find_field_one(btf, s->t, btf_type_by_id(btf, member->type), i,
+						 s->off, off / 8, 0, w);
+		}
 	}
-	return idx;
-}
-
-static int btf_find_field(const struct btf *btf, const struct btf_type *t,
-			  u32 field_mask, struct btf_field_info *info,
-			  int info_cnt)
-{
-	u32 seen_mask = 0;
-
-	if (__btf_type_is_struct(t))
-		return btf_find_struct_field(btf, t, field_mask, info, info_cnt, 0, &seen_mask);
-	else if (btf_type_is_datasec(t))
-		return btf_find_datasec_var(btf, t, field_mask, info, info_cnt, 0, &seen_mask);
-	return -EINVAL;
+	return err;
 }
 
 /* Callers have to ensure the life cycle of btf if it is program BTF */
@@ -4238,37 +4203,29 @@ static int btf_parse_rb_root(const struct btf *btf, struct btf_field *field,
 					    __alignof__(struct bpf_rb_node));
 }
 
-static int btf_field_cmp(const void *_a, const void *_b, const void *priv)
-{
-	const struct btf_field *a = (const struct btf_field *)_a;
-	const struct btf_field *b = (const struct btf_field *)_b;
-
-	if (a->offset < b->offset)
-		return -1;
-	else if (a->offset > b->offset)
-		return 1;
-	return 0;
-}
-
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size)
 {
-	struct btf_field_info info_arr[BTF_FIELDS_MAX];
-	u32 next_off = 0, field_type_size;
+	struct btf_field_info *info_arr __free(kvfree) = NULL;
+	struct btf_field_walk w = { .field_mask = field_mask };
+	u32 field_type_size;
 	struct btf_record *rec;
 	int ret, i, cnt;
 
-	ret = btf_find_field(btf, t, field_mask, info_arr, ARRAY_SIZE(info_arr));
+	ret = btf_find_field(btf, t, &w);
+	kvfree(w.scopes);
+	kvfree(w.index.slots);
+	info_arr = w.info;
 	if (ret < 0)
 		return ERR_PTR(ret);
-	if (!ret)
+	if (!w.cnt)
 		return NULL;
 
-	cnt = ret;
+	cnt = w.cnt;
 	/* This needs to be kzalloc to zero out padding and unused fields, see
 	 * comment in btf_record_equal.
 	 */
-	rec = kzalloc_flex(*rec, fields, cnt, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	rec = kvzalloc_flex(*rec, fields, cnt, BPF_VERIFIER_GFP);
 	if (!rec)
 		return ERR_PTR(-ENOMEM);
 
@@ -4286,11 +4243,10 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			ret = -EFAULT;
 			goto end;
 		}
-		if (info_arr[i].off < next_off) {
-			ret = -EEXIST;
+		if (bpf_must_abort()) {
+			ret = -EINTR;
 			goto end;
 		}
-		next_off = info_arr[i].off + field_type_size;
 
 		rec->field_mask |= info_arr[i].type;
 		rec->fields[i].offset = info_arr[i].off;
@@ -4379,9 +4335,6 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		goto end;
 	}
 
-	sort_r(rec->fields, rec->cnt, sizeof(struct btf_field), btf_field_cmp,
-	       NULL, rec);
-
 	return rec;
 end:
 	btf_record_free(rec);
@@ -6369,6 +6322,10 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 			ret = -EINVAL;
 			goto free_aof;
 		}
+		if (bpf_must_abort()) {
+			ret = -EINTR;
+			goto free_aof;
+		}
 
 		ret = btf_find_kptr(btf, t, 0, 0, &tmp, BPF_KPTR);
 		if (ret != BTF_FIELD_FOUND)
@@ -6426,6 +6383,9 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
 						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
 						  BPF_KPTR, t->size);
+		/* It cannot be allocated. A map has its own record. */
+		if (record == ERR_PTR(-EFBIG))
+			continue;
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
@@ -8170,15 +8130,11 @@ int btf_struct_access(struct bpf_verifier_log *log,
 		if (!meta)
 			break;
 		rec = meta->record;
-		for (i = 0; i < rec->cnt; i++) {
-			struct btf_field *field = &rec->fields[i];
-			u32 offset = field->offset;
-			if (off < offset + field->size && offset < off + size) {
-				bpf_log(log,
-					"direct access to %s is disallowed\n",
-					btf_field_type_name(field->type));
-				return -EACCES;
-			}
+		i = btf_record_first_field(rec, off);
+		if (i < rec->cnt && rec->fields[i].offset < off + size) {
+			bpf_log(log, "direct access to %s is disallowed\n",
+				btf_field_type_name(rec->fields[i].type));
+			return -EACCES;
 		}
 		break;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 237c47139e2b..ec8e78792911 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -703,7 +703,7 @@ void btf_record_free(struct btf_record *rec)
 			continue;
 		}
 	}
-	kfree(rec);
+	kvfree(rec);
 }
 
 void bpf_map_free_record(struct bpf_map *map)
@@ -721,7 +721,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 	if (IS_ERR_OR_NULL(rec))
 		return NULL;
 	size = struct_size(rec, fields, rec->cnt);
-	new_rec = kmemdup(rec, size, GFP_KERNEL | __GFP_NOWARN);
+	new_rec = kvmemdup(rec, size, BPF_VERIFIER_GFP);
 	if (!new_rec)
 		return ERR_PTR(-ENOMEM);
 	/* Do a deep copy of the btf_record */
@@ -1293,6 +1293,8 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
 				       BPF_TASK_WORK | BPF_RCU_HEAD,
 				       map->value_size);
+	if (map->record == ERR_PTR(-ENOMEM) || map->record == ERR_PTR(-EINTR))
+		return PTR_ERR(map->record);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dde8de6b116e..1a8e5a108a68 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4839,48 +4839,43 @@ static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg_state *
 	if (IS_ERR_OR_NULL(map->record))
 		return 0;
 	rec = map->record;
-	for (i = 0; i < rec->cnt; i++) {
+	/* If any part of a field can be touched by load/store, reject this program. */
+	for (i = btf_record_first_field(rec, reg_smin(reg) + off);
+	     i < rec->cnt && rec->fields[i].offset < reg_umax(reg) + off + size; i++) {
 		struct btf_field *field = &rec->fields[i];
 		u32 p = field->offset;
 
-		/* If any part of a field  can be touched by load/store, reject
-		 * this program. To check that [x1, x2) overlaps with [y1, y2),
-		 * it is sufficient to check x1 < y2 && y1 < x2.
-		 */
-		if (reg_smin(reg) + off < p + field->size &&
-		    p < reg_umax(reg) + off + size) {
-			switch (field->type) {
-			case BPF_KPTR_UNREF:
-			case BPF_KPTR_REF:
-			case BPF_KPTR_PERCPU:
-			case BPF_UPTR:
-				if (src != ACCESS_DIRECT) {
-					verbose(env, "%s cannot be accessed indirectly by helper\n",
-						btf_field_type_name(field->type));
-					return -EACCES;
-				}
-				if (!tnum_is_const(reg->var_off)) {
-					verbose(env, "%s access cannot have variable offset\n",
-						btf_field_type_name(field->type));
-					return -EACCES;
-				}
-				if (p != off + reg->var_off.value) {
-					verbose(env, "%s access misaligned expected=%u off=%llu\n",
-						btf_field_type_name(field->type),
-						p, off + reg->var_off.value);
-					return -EACCES;
-				}
-				if (size != bpf_size_to_bytes(BPF_DW)) {
-					verbose(env, "%s access size must be BPF_DW\n",
-						btf_field_type_name(field->type));
-					return -EACCES;
-				}
-				break;
-			default:
-				verbose(env, "%s cannot be accessed directly by load/store\n",
+		switch (field->type) {
+		case BPF_KPTR_UNREF:
+		case BPF_KPTR_REF:
+		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
+			if (src != ACCESS_DIRECT) {
+				verbose(env, "%s cannot be accessed indirectly by helper\n",
 					btf_field_type_name(field->type));
 				return -EACCES;
 			}
+			if (!tnum_is_const(reg->var_off)) {
+				verbose(env, "%s access cannot have variable offset\n",
+					btf_field_type_name(field->type));
+				return -EACCES;
+			}
+			if (p != off + reg->var_off.value) {
+				verbose(env, "%s access misaligned expected=%u off=%llu\n",
+					btf_field_type_name(field->type),
+					p, off + reg->var_off.value);
+				return -EACCES;
+			}
+			if (size != bpf_size_to_bytes(BPF_DW)) {
+				verbose(env, "%s access size must be BPF_DW\n",
+					btf_field_type_name(field->type));
+				return -EACCES;
+			}
+			break;
+		default:
+			verbose(env, "%s cannot be accessed directly by load/store\n",
+				btf_field_type_name(field->type));
+			return -EACCES;
 		}
 	}
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 8fe01308d210..03edad35aa13 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -7,9 +7,6 @@
 #include "errno.h"
 #include <stdbool.h>
 
-/* Should use BTF_FIELDS_MAX, but it is not always available in vmlinux.h,
- * so use the hard-coded number as a workaround.
- */
 #define CPUMASK_KPTR_FIELDS_MAX 11
 
 int err;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index 2a58209eb8be..47967f960bbc 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -15,7 +15,6 @@ struct kptr_nested_array_2 {
 };
 
 struct kptr_nested_array_1 {
-	/* Make btf_parse_fields() in map_create() return -E2BIG */
 	struct kptr_nested_array_2 d_2[CPUMASK_KPTR_FIELDS_MAX + 1];
 };
 
@@ -213,8 +212,8 @@ int BPF_PROG(test_global_mask_rcu_no_null_check, struct task_struct *task, u64 c
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("has no valid kptr")
-int BPF_PROG(test_invalid_nested_array, struct task_struct *task, u64 clone_flags)
+__success
+int BPF_PROG(test_big_nested_array, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *local, *prev;
 
-- 
2.55.0

