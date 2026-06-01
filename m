Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842B35F179
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352365; cv=none; b=ojdK7ky54cWVbHKAPqizqpANsD3SvfMWXV6MdhntgDT17SsGdJyB3yk76dizvquCM4CNWXoPO9bDzJpICFV5YKBHxzC3TCEsUto+VrwMCfdZOU4FWKTlJYO5/znvuUq4P5SgFaXNOCWDE8Os8oLqTyQTebnFzFL3e0gF1Cq4gNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352365; c=relaxed/simple;
	bh=A1BTapHrWobGi+HgVK2ibNAn2ju7dUsLwFyZedW8rZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W13HBUiDA/TSzYz8dsvWuFd3Iuk0HsLHRxbcVWTjX/w+XJWsSRCOyCWWWG3sKt1JQ2LJ1EZSIAh3wo6v19mOQJPYl11z9f6ZmN0KrRdv+OLokd8fdLd0M7klWePTZV1WMmRL09L3bKICtwCo/x8Gn11ka4hGosc6H7dflzU5a2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y9DRNYD9; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y9DRNYD9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780352362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7YVlVJfp2x3II7qf9UOjIYvltj+9joO9la+cBQQJ5U=;
	b=Y9DRNYD9cgD58h1L0GGCOqYKQvFkHvIvD3doF+KyL8cFDSXH/exmURpx2fhZUCfGyDZOSK
	6YXLAMepR6KdZABuTZpq3zpF274gNZJaJNruvpVjuAFiT8CSLga4kbNhGH2hZGXJ+fxWfJ
	vC2VnZCcbkouTxBJUhcNgXWhW+dIylg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v1 12/14] selftests/bpf: Verify arena type tags in resolve_btfids test
Date: Mon,  1 Jun 2026 15:18:03 -0700
Message-ID: <20260601221805.821394-13-ihor.solodrai@linux.dev>
In-Reply-To: <20260601221805.821394-1-ihor.solodrai@linux.dev>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend test_resolve_btfids() to assert that resolve_btfids emits the
address_space(1) type attribute (a BTF_KIND_TYPE_TAG with kflag=1) on
the return type and/or arguments of kfuncs marked with KF_ARENA_RET,
KF_ARENA_ARG1 or KF_ARENA_ARG2.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 59 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/btf_data.c  | 10 ++++
 2 files changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index eeda4e3b6a7f..6449b551fde1 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -13,6 +13,15 @@
 #ifndef KF_FASTCALL
 #define KF_FASTCALL (1 << 12)
 #endif
+#ifndef KF_ARENA_RET
+#define KF_ARENA_RET  (1 << 13)
+#endif
+#ifndef KF_ARENA_ARG1
+#define KF_ARENA_ARG1 (1 << 14)
+#endif
+#ifndef KF_ARENA_ARG2
+#define KF_ARENA_ARG2 (1 << 15)
+#endif
 
 struct symbol {
 	const char	*name;
@@ -39,6 +48,8 @@ struct kfunc_symbol {
 static struct kfunc_symbol kfunc_symbols[] = {
 	{ "kfunc_a", -1, 0 },
 	{ "kfunc_b", -1, KF_FASTCALL },
+	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2 },
+	{ "kfunc_d", -1, KF_ARENA_ARG2 },
 };
 
 /* Align the .BTF_ids section to 4 bytes */
@@ -95,6 +106,8 @@ BTF_SET_END(test_set)
 BTF_KFUNCS_START(test_kfunc_set)
 BTF_ID_FLAGS(func, kfunc_a)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
+BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
 BTF_KFUNCS_END(test_kfunc_set)
 
 #pragma GCC visibility pop
@@ -178,6 +191,22 @@ static bool btf_has_decl_tag(struct btf *btf, const char *tag_name, s32 target_i
 	return false;
 }
 
+/* True if @id is PTR -> TYPE_TAG(kflag=1, "address_space(1)") -> pointee */
+static bool is_arena_tagged_ptr(struct btf *btf, __u32 id)
+{
+	const struct btf_type *ptr, *tag;
+	const char *name;
+
+	ptr = btf__type_by_id(btf, id);
+	if (!ptr || !btf_is_ptr(ptr))
+		return false;
+	tag = btf__type_by_id(btf, ptr->type);
+	if (!tag || !btf_is_type_tag(tag) || !btf_kflag(tag))
+		return false;
+	name = btf__name_by_offset(btf, tag->name_off);
+	return name && strcmp(name, "address_space(1)") == 0;
+}
+
 void test_resolve_btfids(void)
 {
 	__u32 *test_list, *test_lists[] = { test_list_local, test_list_global };
@@ -253,6 +282,36 @@ void test_resolve_btfids(void)
 						     kfunc_symbols[i].id),
 				    kfunc_symbols[i].name);
 
+	/* Check resolve_btfids wrapped exactly the arena-flagged return/args with
+	 * the address_space(1) type attribute, and left other pointers/returns
+	 * untouched.
+	 */
+	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
+		const struct btf_type *fn, *proto;
+		const struct btf_param *params;
+		const char *name = kfunc_symbols[i].name;
+		u32 fl = kfunc_symbols[i].flags;
+		__u32 nr;
+
+		fn = btf__type_by_id(btf, kfunc_symbols[i].id);
+		if (!ASSERT_TRUE(fn && btf_is_func(fn), name))
+			continue;
+		proto = btf__type_by_id(btf, fn->type);
+		if (!ASSERT_TRUE(proto && btf_is_func_proto(proto), name))
+			continue;
+		params = btf_params(proto);
+		nr = btf_vlen(proto);
+
+		ASSERT_EQ(is_arena_tagged_ptr(btf, proto->type),
+			  !!(fl & KF_ARENA_RET), name);
+		if (nr > 0)
+			ASSERT_EQ(is_arena_tagged_ptr(btf, params[0].type),
+				  !!(fl & KF_ARENA_ARG1), name);
+		if (nr > 1)
+			ASSERT_EQ(is_arena_tagged_ptr(btf, params[1].type),
+				  !!(fl & KF_ARENA_ARG2), name);
+	}
+
 out:
 	btf__free(btf);
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_data.c b/tools/testing/selftests/bpf/progs/btf_data.c
index 8587658012c3..ec34f7a6e038 100644
--- a/tools/testing/selftests/bpf/progs/btf_data.c
+++ b/tools/testing/selftests/bpf/progs/btf_data.c
@@ -58,3 +58,13 @@ int kfunc_b(struct root_struct *root)
 {
 	return 0;
 }
+
+struct root_struct *kfunc_c(struct root_struct *a, struct root_struct *b)
+{
+	return a;
+}
+
+int kfunc_d(struct root_struct *a, struct root_struct *b)
+{
+	return 0;
+}
-- 
2.54.0

