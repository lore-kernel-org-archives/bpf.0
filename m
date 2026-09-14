Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF533D331E
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392292; cv=none; b=urL2mtKb1Tz7OYqQ5YdVZIqK/syEunh8t/J/krO/69nU5Rm8tORwcpgsOrrnG3fb3fCez4IT5HY7Kxetw+3u9BcRVd1Nv0LLLvl/RXlANRntO7ELZTIOB3YqeFRk4XCz0NYNGjXSl53hBLP/KuSLBzFIuvudG6QozIAzPoW00Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392292; c=relaxed/simple;
	bh=UqYDz3isuuYVfrkh54nfY19YRyEzImAvcT6idYQHOv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8oXOy+W9Ik4pNMuRTGi8rm89DaPobsKpf4UUc3ZCoUwafK/6slV6BbCxFuEPRMOhVZE8vRDHNpuEZakAOPF0PjTwc5ry7efvnRwFigi+Zg5IWo+tJwdhE1QMTHsB+alpalCuAzZAnL1Nv57h0YMXIUYzukWTiSCzVh7/wSbXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMuI4loU; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMuI4loU"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so14340525e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392288; x=1789997088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3o9mIYttZBwGmKRb9EO65f+rf5cFcFCJOvlLAMAIKzI=;
        b=cMuI4loUIFguNIP8Rxv3y9o4XwI9LZj9f8X4dbelzTQi85gDzG08YOm62CIVI6bplj
         9tuyudgayhGwpEMEYyrFSNXAhvlmN3m9X+k0Nx71OmAI855qE+fgOb6KwcORWN6JJkr/
         87ptwReu3jaKgnMVWhAZtVI9tzKvw5g4S3y2p2faMKH5sGrOIf1clnzrVRULsgzIgZbm
         6EJRQWxKdh9zzF25mU4FbJA3+kbUW4IRbqWM9V7G0FTKtmVcAT1Z+yHqCNwTCk7JyHNY
         4cm/rTooM2jDuR5LrP9WC0w/d/23/B8shGS0lUOKdDzA32Lrr5NVimmdRGGwwonwPc6S
         andw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392288; x=1789997088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3o9mIYttZBwGmKRb9EO65f+rf5cFcFCJOvlLAMAIKzI=;
        b=XU9AtnNCPLN5HUenocglWP+uvtD3Wdt2pk9QfduKBmM3ZdzEAq24YcAg8vxsVEXMrB
         ta9fVMR5mTz7exQVOya9FXbpfiZ6IAumTBRTcAV5axKhUXXkuMgc9nHsx/y78YvR4TJd
         qimH9bove91pdX3S4CE/q4LeyATN07SA/zyRLCvtRLrSWdQX99+dXi2IdUFbPSuc1iYr
         dggZ10BLf21BOlhB4HXflO0XC+0YsnJT4QuizDdU4lUR2l9v1ex00Q9Z34MBBAXnpEYb
         E9cJlQxQUVpn6qJLeGGj98/3GAUTVB7uQM/LSeH6nWKXdoJ5GrYrbTUgdTbQv7hcfQun
         jBqA==
X-Gm-Message-State: AFuF++lu16QwhSRiqMjTPmC5lI1e2608T/CVCzEQpDHsJ+8C752g7gYq
	3GDnyG5KqTZWYU7mjrNuADGxrctcHbO469l1hc1hBB+RaGJ3cdBn0nxloxogJLOQ
X-Gm-Gg: AYBFou1PYg9cD1yuN0zB8WrPvWgb0TQvDxElBP/Z/yGngtwPeJ7QkAxnXf+WehV35IW
	wKwPp9v3iTIkVzBx4ABplNptLmAsTVzjscVHyCpSmRitTT3atoIDUBP22XHCHw+a9pgcixkFgmQ
	a5ZAoRxIkFFCDovV1CbxKuXMhRiQMeN7Q9HzhHISDORkUpnuOlcm1lHs3BEc/0kcikrBU0PX2x2
	2xgiVTzHxLkAG17jJ46wDqLzmsD95X13MBUZ17SqF0G9MLqLt2OxP/3uO8QRNcbWWsHJu4W7PQv
	TUD5t0cSE3O6BuNDNfcPZz8Fxi2Y+4TzsP9DY9em3rMN2mdb+h8HFjwxmYqSZnGvo3xnrmo/N86
	NjaCpXeZU0y8vZDMX8uQRwfZDaaDA83JW3jFq8Lyu4C5rum5lzMvU3eahUviQ7LY6YZ56cFvlgj
	h7sj4VACwuu8OqPuCNl0TBCugo5qJISGluvoD0MwgfjIgyWjq+O3tQ87Sp+Thoe8KZYAly5a7Fl
	zy01gAInLy7BgyKD+FwY633Ur71A+o7KBWjEO8sVvVrwaqIfP1l7pU8d1HAVzjvsUFs6FTcFEtj
	L5exyK0/tNZnXKUivLc0US8vBNMrWkEYbHg9Lw==
X-Received: by 2002:a05:600c:6217:b0:49e:6bc7:4e1b with SMTP id 5b1f17b1804b1-49e7a656ca0mr30261585e9.15.1789392287560;
        Mon, 14 Sep 2026 06:24:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35f3d9sm26379728f8f.35.2026.09.14.06.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:24:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: Bound ownership depth through local kptrs and graph roots
Date: Mon, 14 Sep 2026 15:24:42 +0200
Message-ID: <20260914132444.2564218-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914132444.2564218-1-memxor@gmail.com>
References: <20260914132444.2564218-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8679; i=memxor@gmail.com; h=from:subject; bh=UqYDz3isuuYVfrkh54nfY19YRyEzImAvcT6idYQHOv8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv51ynzzGfIfPj8jXXOoh0lOUZMVy3eZvzefoMvsvQXG 4fyvqmOHaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZhIVQHDP+1HPWnrlUJV9nWp dN1Nq4huDDi+IPGeaa7e6/3VNh8+VjEyTCldzLJbP2Lisz937sxmbk9fWTMj0Sh/o5RFjkbEG/M 6fgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Program-allocated objects can own other local objects through referenced
kptrs. bpf_obj_free_fields() follows those pointers through
__bpf_obj_drop_impl() synchronously, before the object storage is freed
through RCU. A self-referential local kptr type therefore permits arbitrarily
deep object chains, and dropping the head can exhaust the kernel stack.
Long acyclic type chains have the same problem.

btf_check_and_fixup_fields() still assumes referenced kptrs only point to
kernel types and checks ownership through list and rbtree roots only. Its
existing rule is sufficient for graph-only cycles: the target of each graph
edge must contain a node, so every type in a cycle has both a root and a
node. The rule rejects such a type owning another root, breaking every
cycle. It also limits graph-only chains to three types, or two if the first
type contains a node, and conservatively rejects longer acyclic chains.
The missing local-kptr edges, rather than a missed graph-only cycle, are the
bug introduced by support for bpf_kptr_xchg() into local kptrs.

Replace that restriction with one bounded ownership walk covering graph
roots and local referenced kptrs. Run it after all BTF records have been
fixed up, reject cycles and paths deeper than eight record-bearing types,
and cache each type's suffix depth while checking it against the remaining
budget. This also permits the longer acyclic graph-only layouts rejected
by the old rule; update their existing BTF tests accordingly.

Keep the bound independent of MAX_CALL_FRAMES because recursive destruction
can run below a BPF call chain. A plain local pointee without special-field
metadata adds only a final non-recursing drop. Non-owning kptrs and
kernel-BTF kptrs do not recurse through local records and remain outside the
walk. Include local percpu-kptr edges too, although allocation of percpu
objects with special fields is currently forbidden, so that relaxing that
restriction cannot bypass the ownership bound.

btf_check_and_fixup_fields() continues to initialize graph_root.value_rec,
including for separately allocated map records. The ownership relationships
belong to immutable program BTF and only need validation at BTF load time.

Fixes: b0966c724584 ("bpf: Support bpf_kptr_xchg into local kptr")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c                              | 134 +++++++++++-------
 .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
 2 files changed, 88 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7daf4c286c9b..92217a14b9d3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4284,13 +4284,10 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
 {
 	int i;
 
-	/* There are three types that signify ownership of some other type:
-	 *  kptr_ref, bpf_list_head, bpf_rb_root.
-	 * kptr_ref only supports storing kernel types, which can't store
-	 * references to program allocated local types.
-	 *
-	 * Hence we only need to ensure that bpf_{list_head,rb_root} ownership
-	 * does not form cycles.
+	/*
+	 * Check fields which require the complete BTF and initialize runtime
+	 * metadata. Ownership relationships are validated after every record has
+	 * been fixed up.
 	 */
 	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & (BPF_GRAPH_ROOT | BPF_UPTR)))
 		return 0;
@@ -4321,51 +4318,88 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
 		if (!meta)
 			return -EFAULT;
 		rec->fields[i].graph_root.value_rec = meta->record;
+	}
+	return 0;
+}
 
-		/* We need to set value_rec for all root types, but no need
-		 * to check ownership cycle for a type unless it's also a
-		 * node type.
-		 */
-		if (!(rec->field_mask & BPF_GRAPH_NODE))
+static int btf_owned_type_idx(const struct btf *btf, struct btf_struct_metas *tab,
+			      const struct btf_field *field)
+{
+	struct btf_struct_meta *meta;
+	u32 btf_id;
+
+	if (field->type & BPF_GRAPH_ROOT) {
+		btf_id = field->graph_root.value_btf_id;
+	} else if (field->type == BPF_KPTR_REF || field->type == BPF_KPTR_PERCPU) {
+		if (btf_is_kernel(field->kptr.btf))
+			return -ENOENT;
+		btf_id = field->kptr.btf_id;
+	} else {
+		return -ENOENT;
+	}
+
+	meta = btf_find_struct_meta(btf, btf_id);
+	if (!meta)
+		return field->type & BPF_GRAPH_ROOT ? -EFAULT : -ENOENT;
+	return meta - tab->types;
+}
+
+/*
+ * Each ownership edge adds kernel frames through bpf_obj_free_fields() and
+ * __bpf_obj_drop_impl(). Keep the bound deliberately small because object
+ * destruction can itself run below a BPF call chain. A final pointee without
+ * special fields is not present in the struct metadata table and adds only a
+ * non-recursing drop.
+ */
+#define BTF_MAX_OWNERSHIP_DEPTH 8
+
+static int btf_ownership_depth(const struct btf *btf,
+			       struct btf_struct_metas *tab, u8 *depth,
+			       int idx, int depth_left)
+{
+	const struct btf_record *rec = tab->types[idx].record;
+	int i, ret, max_depth = 0;
+
+	if (!depth_left)
+		return -ELOOP;
+	if (depth[idx])
+		goto done;
+
+	for (i = 0; i < rec->cnt; i++) {
+		ret = btf_owned_type_idx(btf, tab, &rec->fields[i]);
+		if (ret == -ENOENT)
 			continue;
+		if (ret < 0)
+			return ret;
+		ret = btf_ownership_depth(btf, tab, depth, ret, depth_left - 1);
+		if (ret < 0)
+			return ret;
+		max_depth = max(max_depth, ret);
+	}
+	depth[idx] = max_depth + 1;
+done:
+	return depth[idx] > depth_left ? -ELOOP : depth[idx];
+}
 
-		/* We need to ensure ownership acyclicity among all types. The
-		 * proper way to do it would be to topologically sort all BTF
-		 * IDs based on the ownership edges, since there can be multiple
-		 * bpf_{list_head,rb_node} in a type. Instead, we use the
-		 * following resaoning:
-		 *
-		 * - A type can only be owned by another type in user BTF if it
-		 *   has a bpf_{list,rb}_node. Let's call these node types.
-		 * - A type can only _own_ another type in user BTF if it has a
-		 *   bpf_{list_head,rb_root}. Let's call these root types.
-		 *
-		 * We ensure that if a type is both a root and node, its
-		 * element types cannot be root types.
-		 *
-		 * To ensure acyclicity:
-		 *
-		 * When A is an root type but not a node, its ownership
-		 * chain can be:
-		 *	A -> B -> C
-		 * Where:
-		 * - A is an root, e.g. has bpf_rb_root.
-		 * - B is both a root and node, e.g. has bpf_rb_node and
-		 *   bpf_list_head.
-		 * - C is only an root, e.g. has bpf_list_node
-		 *
-		 * When A is both a root and node, some other type already
-		 * owns it in the BTF domain, hence it can not own
-		 * another root type through any of the ownership edges.
-		 *	A -> B
-		 * Where:
-		 * - A is both an root and node.
-		 * - B is only an node.
-		 */
-		if (meta->record->field_mask & BPF_GRAPH_ROOT)
-			return -ELOOP;
+static int btf_check_ownership_depth(const struct btf *btf,
+				     struct btf_struct_metas *tab)
+{
+	u8 *depth;
+	int i, ret = 0;
+
+	depth = kvcalloc(tab->cnt, sizeof(*depth), GFP_KERNEL | __GFP_NOWARN);
+	if (!depth)
+		return -ENOMEM;
+
+	for (i = 0; i < tab->cnt; i++) {
+		ret = btf_ownership_depth(btf, tab, depth, i,
+					  BTF_MAX_OWNERSHIP_DEPTH);
+		if (ret < 0)
+			break;
+		ret = 0;
 	}
-	return 0;
+	kvfree(depth);
+	return ret;
 }
 
 static void __btf_struct_show(const struct btf *btf, const struct btf_type *t,
@@ -6060,6 +6094,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 			if (err < 0)
 				goto errout_meta;
 		}
+
+		err = btf_check_ownership_depth(btf, struct_meta_tab);
+		if (err < 0)
+			goto errout_meta;
 	}
 
 	err = bpf_log_attr_finalize(attr_log, &env->log);
diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index c3d133c6a00d..52fabbee3dd5 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -714,7 +714,7 @@ static void test_btf(void)
 			break;
 
 		err = btf__load_into_kernel(btf);
-		ASSERT_EQ(err, -ELOOP, "check btf");
+		ASSERT_EQ(err, 0, "check btf");
 		btf__free(btf);
 		break;
 	}
@@ -773,7 +773,7 @@ static void test_btf(void)
 			break;
 
 		err = btf__load_into_kernel(btf);
-		ASSERT_EQ(err, -ELOOP, "check btf");
+		ASSERT_EQ(err, 0, "check btf");
 		btf__free(btf);
 		break;
 	}
-- 
2.53.0

