Received: from out-182.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3C827F72C
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072862; cv=none; b=g6SdD/EDdnPbPZ93DdRptb82ufOK4Sy3K9TksK4CI+mV2S0Bs4b/wcn/y2gkVdU85Z0LLrYHkltsik1SMXSXFmOMaTakmVSObLwoTvpUpc0P4+729CAiDc77tf2++0yQcN2lMCWPXZ4scIv+II5i/BvfJb3MwgB2734MZKZ9nUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072862; c=relaxed/simple;
	bh=xSzbN/1n7bB74DcSH9XAWyvO4Xy0ZDYX+qhJP1549fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHqqNyLUWLI39wg+gjUrwxdFfUwYNI3LIxtjRbiyRGDGIfNENMEwvHYIuSzDgTuDtXC0GxSsE195Akf89KH4yIxiRjkU7RK4QQU31YqGyPT+cqSNoH3z7q/XyiwK2HCIn3WTpvBOWmo7pX5MUcFX+96prqwAJBt64IsigFGLYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=smxcQwSl; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="smxcQwSl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786072858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZWv+rGYRs3lV4Ag4P5kX4Y+Z0eWNGqtg0mLw3hiTk8=;
	b=smxcQwSle9bcJx6ulTulo8jIiP3DheblH8dgabIV0o5FHzyNtmg0sqCsmP8CoI4YEHk4Pp
	fQP5AMR+HR4aicVJYIutgETWUtaiK/E0zudgAwgh6FI3MCU+nWPCxBUVW3TsS7DPZGB/ah
	SiD7f5Y+p4Dqk2X0IBqZYNb5H1UB0Gg=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 3/6] selftests/bpf: Verify arena type tags in resolve_btfids test
Date: Thu,  6 Aug 2026 20:20:26 -0700
Message-ID: <20260807032029.78092-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260807032029.78092-1-ihor.solodrai@linux.dev>
References: <20260807032029.78092-1-ihor.solodrai@linux.dev>
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
the return type and/or arguments of kfuncs marked KF_ARENA_RET,
KF_ARENA_ARG1 or KF_ARENA_ARG2.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 66 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/btf_data.c  | 10 +++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index ac51fd454821..8482f00046d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -12,9 +12,20 @@
 
 #define BTF_DATA_FILE "resolve_btfids.test.o.BTF"
 
+#define TYPE_ATTR_ARENA "address_space(1)"
+
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
@@ -41,6 +52,8 @@ struct kfunc_symbol {
 static struct kfunc_symbol kfunc_symbols[] = {
 	{ "kfunc_a", -1, 0 },
 	{ "kfunc_b", -1, KF_FASTCALL },
+	{ "kfunc_c", -1, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2 },
+	{ "kfunc_d", -1, KF_ARENA_ARG2 },
 };
 
 /* Align the .BTF_ids section to 4 bytes */
@@ -88,6 +101,8 @@ BTF_SET_END(test_set)
 BTF_KFUNCS_START(test_kfunc_set)
 BTF_ID_FLAGS(func, kfunc_a)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
+BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
 BTF_KFUNCS_END(test_kfunc_set)
 
 /*
@@ -95,6 +110,8 @@ BTF_KFUNCS_END(test_kfunc_set)
  * actually sort at least one of the two sets.
  */
 BTF_KFUNCS_START(test_kfunc_set_rev)
+BTF_ID_FLAGS(func, kfunc_d, KF_ARENA_ARG2)
+BTF_ID_FLAGS(func, kfunc_c, KF_ARENA_RET | KF_ARENA_ARG1 | KF_ARENA_ARG2)
 BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
 BTF_ID_FLAGS(func, kfunc_a)
 BTF_KFUNCS_END(test_kfunc_set_rev)
@@ -184,6 +201,22 @@ static void check_kfunc_set(struct btf_id_set8 *set)
 	}
 }
 
+/* True if @id is PTR -> TYPE_TAG(kflag=1, "address_space(1)") -> pointee */
+static bool is_arena_tagged_ptr(struct btf *btf, __u32 id)
+{
+	const struct btf_type *ptr, *tag;
+	const char *name;
+
+	ptr = btf__type_by_id(btf, id);
+	if (!btf_is_ptr(ptr))
+		return false;
+	tag = btf__type_by_id(btf, ptr->type);
+	if (!btf_is_type_tag(tag) || !btf_kflag(tag))
+		return false;
+	name = btf__name_by_offset(btf, tag->name_off);
+	return strcmp(name, TYPE_ATTR_ARENA) == 0;
+}
+
 void test_resolve_btfids(void)
 {
 	__u32 *test_list, *test_lists[] = { test_list_local, test_list_global };
@@ -227,6 +260,39 @@ void test_resolve_btfids(void)
 	check_kfunc_set(&test_kfunc_set);
 	check_kfunc_set(&test_kfunc_set_rev);
 
+	/*
+	 * Check resolve_btfids wrapped exactly the arena-flagged return/args
+	 * with the address_space(1) type attribute, and left other
+	 * pointers/returns untouched.
+	 */
+	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
+		const struct btf_type *fn, *proto;
+		const struct btf_param *params;
+		const char *name = kfunc_symbols[i].name;
+		u32 fl = kfunc_symbols[i].flags;
+		__u32 nr;
+
+		fn = btf__type_by_id(btf, kfunc_symbols[i].id);
+		if (!ASSERT_TRUE(btf_is_func(fn), name))
+			continue;
+		proto = btf__type_by_id(btf, fn->type);
+		if (!ASSERT_TRUE(btf_is_func_proto(proto), name))
+			continue;
+		params = btf_params(proto);
+		nr = btf_vlen(proto);
+
+		ASSERT_EQ(is_arena_tagged_ptr(btf, proto->type),
+			  !!(fl & KF_ARENA_RET), name);
+		if (nr > 0) {
+			ASSERT_EQ(is_arena_tagged_ptr(btf, params[0].type),
+				  !!(fl & KF_ARENA_ARG1), name);
+		}
+		if (nr > 1) {
+			ASSERT_EQ(is_arena_tagged_ptr(btf, params[1].type),
+				  !!(fl & KF_ARENA_ARG2), name);
+		}
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
2.55.0

