Received: from mta0.migadu.com (out-56.mta0.migadu.com [91.218.175.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13BC2C235E
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725593; cv=none; b=rJmqg12ImiqU1ghNToMMATsmEUecLf7e61DF2T+8oAFEZ5HkjyobLiBcu7rkznDr4t4AsK4/iezeqmn6K2AqnDrGbnkdD3OtLizcxbJ4l/LdllecoF2PvSOMnWnLA/yLs4o6cytfPZYsLkNriwYknPHZuNNR3QTdkPNJ3C4zr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725593; c=relaxed/simple;
	bh=3jNZoGWoMx6y4SUyv7mphNTWcDduINsJwfMCZvNq78o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMJFuPpxHuOmKNW6X7DjZfu/bzV6wpntwv/8sEbyFg0Mos6jRc6z6P7KsnpxVw2L0c2VXPZG38ZzjqKTmdyYeZ2DVREhZy8Hbi3Pt0wZUQhtY1fMMtUSFbbs+OggL3EBaJzEwKxvcnTk8UUiNQi3MRtuacfi0Wq3Wzh1V6BPCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MaLfUup2; arc=none smtp.client-ip=91.218.175.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MaLfUup2"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=3jNZoGWoMx6y4SUyv7mphNTWcDduINsJwfMCZvNq78o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790725588; v=1; x=1791330388;
 b=MaLfUup27ECAry5oVCiisSS0fOmtDT2vNsYGdeHm9a60vhkgt2fVGB55YDQeDfrR+HYINMah
 dxiFwL69tfdynEvLgtXJTpHEAETkWEH1WM4v2r2YVolyRlui8jgJlPFSE5Q59VdYUWz9e33maoa
 EjLpOe6FROtY96dFieOfAWPA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2633d52f4a5e0b38;
	Tue, 29 Sep 2026 23:46:28 +0000
X-Mizu-Trace-ID: 2633d52f4a5e0b38
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v2 2/5] libbpf: Render decl_tags in btf_dump
Date: Tue, 29 Sep 2026 16:46:05 -0700
Message-ID: <20260929234608.48503-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260929234608.48503-1-ihor.solodrai@linux.dev>
References: <20260929234608.48503-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BTF_KIND_DECL_TAG is an attribute on a declaration: with kind_flag=0
the tag name is the argument of a btf_decl_tag(), and with kind_flag=1
it encodes a complete __attribute__.

When doing btf_dump, render both forms at every declaration btf_dump
emits - a record, a record member and a typedef:

	struct foo { ... } __attribute__((bar));
	struct foo { int a __attribute__((bar)); };
	typedef struct { ... } __attribute__((bar)) foo_t;

A decl tag is a standalone type pointing at its target. Build an
index of decl tags in btf_dump_resize(). Keep it as a flat array
sorted by (target ID, tag ID). This allows for a stable emission order
in btf_dump_emit_decl_tags().

btf_dump_emit_decl_tags() binary searches for where the target's
entries would begin and walks tags while the target matches. A record
shares its target with its members, so the component_idx is matched
there.

A record attribute goes after the closing brace, where
__attribute__((packed)) already goes. A member attribute goes after
the bit-field width: clang rejects one between the declarator and the
':'. A typedef takes it after the declarator, so a typedef of an
anonymous record can carry two groups at once, one binding to the
record and one to the typedef.

This closes a generic gap in btf_dump, which silently dropped every
decl tag it was given.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 94 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index e0293e6d3492..996e61b5f11f 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -77,6 +77,11 @@ struct btf_dump_data {
 	bool is_array_char;
 };
 
+struct decl_tag_desc {
+	__u32 target_id;
+	__u32 tag_id;
+};
+
 struct btf_dump {
 	const struct btf *btf;
 	btf_dump_printf_fn_t printf_fn;
@@ -93,6 +98,11 @@ struct btf_dump {
 	const char **cached_names;
 	size_t cached_names_cap;
 
+	/* decl tags, sorted by (target ID, tag ID) */
+	struct decl_tag_desc *decl_tags;
+	size_t decl_tag_cnt;
+	size_t decl_tag_cap;
+
 	/* topo-sorted list of dependent type definitions */
 	__u32 *emit_queue;
 	int emit_queue_cap;
@@ -192,9 +202,34 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	return libbpf_err_ptr(err);
 }
 
+static int btf_dump_cmp_decl_tags(const void *a, const void *b)
+{
+	const struct decl_tag_desc *x = a, *y = b;
+
+	if (x->target_id != y->target_id)
+		return x->target_id < y->target_id ? -1 : 1;
+	if (x->tag_id != y->tag_id)
+		return x->tag_id < y->tag_id ? -1 : 1;
+	return 0;
+}
+
+static int btf_dump_push_decl_tag(struct btf_dump *d, __u32 id, const struct btf_type *t)
+{
+	if (libbpf_ensure_mem((void **)&d->decl_tags, &d->decl_tag_cap,
+			      sizeof(*d->decl_tags), d->decl_tag_cnt + 1))
+		return -ENOMEM;
+
+	d->decl_tags[d->decl_tag_cnt++] = (struct decl_tag_desc) {
+		.target_id = t->type,
+		.tag_id = id,
+	};
+	return 0;
+}
+
 static int btf_dump_resize(struct btf_dump *d)
 {
 	int err, last_id = btf__type_cnt(d->btf) - 1;
+	size_t cnt = d->decl_tag_cnt;
 	const struct btf_type *t;
 	__u32 i;
 
@@ -219,11 +254,25 @@ static int btf_dump_resize(struct btf_dump *d)
 
 		err = btf_dump_mark_referenced(d, t);
 		if (err)
-			return err;
+			goto out_err;
+
+		if (btf_is_decl_tag(t)) {
+			err = btf_dump_push_decl_tag(d, i, t);
+			if (err)
+				goto out_err;
+		}
 	}
 
+	if (d->decl_tag_cnt != cnt)
+		qsort(d->decl_tags, d->decl_tag_cnt, sizeof(*d->decl_tags),
+		      btf_dump_cmp_decl_tags);
+
 	d->last_id = last_id;
 	return 0;
+
+out_err:
+	d->decl_tag_cnt = cnt;
+	return err;
 }
 
 static void btf_dump_free_names(struct hashmap *map)
@@ -256,6 +305,7 @@ void btf_dump__free(struct btf_dump *d)
 		}
 	}
 	free(d->cached_names);
+	free(d->decl_tags);
 	free(d->emit_queue);
 	free(d->decl_stack);
 	btf_dump_free_names(d->type_names);
@@ -968,6 +1018,44 @@ static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
 			btf_dump_type_name(d, id));
 }
 
+static void btf_dump_emit_decl_tag(struct btf_dump *d, const struct btf_type *t)
+{
+	const char *name = btf_name_of(d, t->name_off);
+
+	if (btf_kflag(t))
+		btf_dump_printf(d, " __attribute__((%s))", name);
+	else
+		btf_dump_printf(d, " __attribute__((btf_decl_tag(\"%s\")))", name);
+}
+
+/*
+ * btf_dump_resize() keeps d->decl_tags sorted by (target ID, tag ID), so the
+ * tags of one type form a run that binary search finds the start of, in a
+ * fixed order so that the same BTF always renders the same C.
+ */
+static void btf_dump_emit_decl_tags(struct btf_dump *d, __u32 id, int comp_idx)
+{
+	size_t i, lo = 0, hi = d->decl_tag_cnt, mid;
+	const struct btf_type *t;
+
+	/* lower bound on target_id */
+	while (lo < hi) {
+		mid = lo + (hi - lo) / 2;
+
+		if (d->decl_tags[mid].target_id < id)
+			lo = mid + 1;
+		else
+			hi = mid;
+	}
+
+	for (i = lo; i < d->decl_tag_cnt && d->decl_tags[i].target_id == id; i++) {
+		t = btf__type_by_id(d->btf, d->decl_tags[i].tag_id);
+
+		if (btf_decl_tag(t)->component_idx == comp_idx)
+			btf_dump_emit_decl_tag(d, t);
+	}
+}
+
 static void btf_dump_emit_struct_def(struct btf_dump *d,
 				     __u32 id,
 				     const struct btf_type *t,
@@ -1013,6 +1101,8 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 			prev_bitfield = false;
 		}
 
+		/* after the bit-field width */
+		btf_dump_emit_decl_tags(d, id, i);
 		btf_dump_printf(d, ";");
 	}
 
@@ -1032,6 +1122,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	}
 	if (packed)
 		btf_dump_printf(d, " __attribute__((packed))");
+	btf_dump_emit_decl_tags(d, id, -1);
 }
 
 static const char *missing_base_types[][2] = {
@@ -1209,6 +1300,7 @@ static void btf_dump_emit_typedef_def(struct btf_dump *d, __u32 id,
 
 	btf_dump_printf(d, "typedef ");
 	btf_dump_emit_type_decl(d, t->type, name, lvl);
+	btf_dump_emit_decl_tags(d, id, -1);
 }
 
 static int btf_dump_push_decl_stack_id(struct btf_dump *d, __u32 id)
-- 
2.50.1

