Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5210B2E8DE3
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599277; cv=none; b=o1QZRhe+d2cMav+x4iy5n4fif70l1B0rRbg8tzI7GPdsG3x7AGNbEq8SZ0m/NmumI65MBqwwKPopg1Tj/2iY/Nb5APTAaM4G2eqwtSOFYnADU6j3Hhr+2KpunVaFgwmbBNVElmJUfw8IHYJV4Wdobtsqo8fG3oySjn0aQUPF6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599277; c=relaxed/simple;
	bh=2nh5oVCehdk5Ly3uRWlsvCjBBkd/uTnS1uCg10aVcTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo+d3kFsacK895ta7vQXP7uYTfs95HSv0LIU87480XXUBYTSo6GJDfXKsdWYIqZXX6Jj0zxZPrpH96IdV2pdMTbO1rdkOkuKh9bCK06wFY9H5l19+LD5A2mMx/1NqhxBAgSyUboHTD8wgMnHsOjavj1yKErpVdi8EDRZDiUSlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQW5Tixv; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQW5Tixv"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-49cd71f9909so3436325e9.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788599273; x=1789204073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCKqqQ7KegEwXPKpFJ7cEy5Gca73Ef8WhjPeF4r1zFU=;
        b=PQW5TixvCbPNE4XQs1PCWZnMYZzE7c6dL7eAn5Gsuzoo5QM1RGe62+4Si3NhGOZv17
         TlXfLmmCLq7ikocBpmsevNDI9u6m4U2BU65lkATLtPLQxqVjidienKnTIEgrcC8Tqacu
         Ux5HOt+uU3ZUpwv8rdKS9YlW0f4GwYmNJTXU2aBtAyH9pLv5EmWu6wV7HtLO+WIMhijF
         BDZA6Rc1tqh5xJc0aQYeNa61srkRf9rEvWsLZz/R4Nc/5yUMoPo1mjsdqex+IlE4a1Ag
         EL6p6RSEOcG5YzCLBD1RmXNgxdn1TEnlZ0wh8zt9qtgQ/mYKzcJtEXO9CZUvuIQe07tB
         ByuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788599273; x=1789204073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qCKqqQ7KegEwXPKpFJ7cEy5Gca73Ef8WhjPeF4r1zFU=;
        b=mweB3L+/wht0s6JdBG9psjZfhQ2UaB8HNcsBXdBw2k8tiCnLaBcirzWfM0KTTamhm0
         fG/rXMB1dfXbXCzwKlvu4XEFnchdJrVhst1dMFsXQ/E9bP2QREoxvUb2s5oQQYvV0KI4
         3NEIDXbhyiuucgfHPVu+Q/TTBmKPmY8g5VJEDI7S7LSt+nVg9zTc0Vxq1m28yquX0Fti
         LVg1pX2wqw2thwMMbMpDKsPdjVmy49lDocGYEy7aPi/PX+EtPsJ3bAvw5W4fLuKXg61E
         UGBx2Oj/s+n07tsdIajxdMzHSjh0+H7t+aDAwmD5cpegCwynC5tQnJqshiD7VsAQqHpc
         VPIg==
X-Gm-Message-State: AFuF++kH0bsU5p+rXgSBcA5IbZbOQoKKfgk++OYt5oynrAQEaAS+5Jzm
	U9mQUUMFZY90jlUZV00sJT+IcuvTrUrW4np775GULIpVjsUaLDs2peAn4FZD9hTM
X-Gm-Gg: AYBFou0+Tn/c/prps/0ttJFPsPnjgJcKLAhUQlweyazB5kQzPiWkwjOIyI5ZnTiik67
	FZJ4U4HV/alDnUvVKBJW71TxJAkmwALgAhpyzTU+P/xX2T2UTtV5FJQk5Rsd9+cRdw1F78gmvBn
	DSV7piy68n9WRxiUatPmGWKDB/wwrZaz9QazkULwOAGBfgxDcp0W6X78YAJVO14vg/oBzl3aV/Q
	fmYg7H0dNh4W0gbyj5VYPI+sAlG4iPWUeYJ0EhIPv84TD83NXB0CYi6Y7osS8TtKJyMQkxpPQ0S
	8CsumEh9pMfSZ76DS9l+f20GqEPC2vMqK9jboZ7QbsvJq3TrDbOcFHJivB/4eBHPhueJibEPREy
	oiJdneH4tu+scr+yfixyUtV03jgzVzmObLRZ7sSGHk5MPCPl04DSLJ1SDUmS6CCV7R+7klfLmhp
	iZFqHoJiQjtX85q1Sgh9wFvtudwdXFG08/UB5y4MY8fYF3YDCOYnBmOVeCH7pC8UYMwKPcLKf5m
	BnYM/YxF54EZecnsXIiD6hlCEh2DIh9WfOpRsnzehJDrRXpLIyna6fNDiuK6DbeBbmZ1wtGphnA
	ZboaP1S4lFbdOVQa80/jyzP/P/0=
X-Received: by 2002:a05:600c:c4aa:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49cf8241a84mr183630275e9.9.1788599273342;
        Sat, 05 Sep 2026 02:07:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm9859877f8f.4.2026.09.05.02.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:07:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/3] bpf: Validate graph ownership with a bounded walk
Date: Sat,  5 Sep 2026 11:07:46 +0200
Message-ID: <20260905090750.4064411-2-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905090750.4064411-1-memxor@gmail.com>
References: <20260905090750.4064411-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6990; i=memxor@gmail.com; h=from:subject; bh=2nh5oVCehdk5Ly3uRWlsvCjBBkd/uTnS1uCg10aVcTk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2rfdxTcoBvp8zM78Wb/x+bl7O4yluhiFlS/L/+iw3z voSsepoRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZiz8jIMONWjOjccy03w9Pm mCuV6D/jffH1iLrfhaBTST7vCkUYkhn+F6k+XxJ+1oOlTIHryQXj4uQ5B7bpmUlsjJ+WxOX0NNm JFwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

btf_check_and_fixup_fields() prevents graph ownership cycles with a
one-hop restriction: a type that contains both a graph root and node cannot
own another root type. This limits graph ownership chains to three types,
but also rejects longer acyclic relationships.

All struct metadata is available once field fixups finish. Move ownership
validation out of the per-record fixup helper and walk graph-root type
relationships directly at BTF load time. Reject cycles and chains deeper
than eight record-bearing types, which keeps recursive destruction bounded
while permitting safe acyclic layouts.

Keep the depth limit independent of MAX_CALL_FRAMES because graph teardown
can run beneath a BPF call chain. btf_check_and_fixup_fields() continues to
initialize graph_root.value_rec, including for the separately allocated map
record. The ownership relationship itself belongs to the immutable BTF and
therefore only needs validation once during BTF load.

Update the graph BTF tests to accept the two acyclic relationships that the
old approximation rejected.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c                              | 126 +++++++++++-------
 .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
 2 files changed, 80 insertions(+), 50 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9c2cab08bb79..2a458499a236 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4269,13 +4269,10 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
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
@@ -4306,51 +4303,80 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
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
+	if (!(field->type & BPF_GRAPH_ROOT))
+		return -ENOENT;
+	btf_id = field->graph_root.value_btf_id;
+	meta = btf_find_struct_meta(btf, btf_id);
+	if (!meta)
+		return -EFAULT;
+	return meta - tab->types;
+}
+
+/*
+ * Each graph ownership edge adds kernel frames through
+ * bpf_obj_free_fields() and __bpf_obj_drop_impl(). Keep the bound
+ * deliberately small because object destruction can itself run below a BPF
+ * call chain.
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
@@ -6045,6 +6071,10 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
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

