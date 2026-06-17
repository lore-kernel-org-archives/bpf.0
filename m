Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9233C4143
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730412; cv=none; b=Y2f7KpIUm8tsHuBay8tfo6+1DyniLBSji0bL9NXswJg77KOnG8ZLYS7JpgAnpZe7TWWkKXrFKlLbCcg33OcfGMnL0DYEskIJqhXbv7dKd0QOTsy8ab37s9JBPpiWkRHhDJ6Idw7WNgzJ0CmH7BjRw/MujaH4kdygvxMvFkMCUjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730412; c=relaxed/simple;
	bh=UsLRWizmJD/j+me0VGA8nzedKMT1qJozG11itdx8V/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZkxS02LBauGcJJiK7PtYGWcFjFhenNtCwcIJ3ot8LqkTF9/ilw60Q1nwy889hNfyxHnPnfZU0zDXXTOjTQdrEcVLZi+VqnVd374oJULJe/OjVSir1GmWtLBRPusqKaSD8pq7L6Xs73bfSDQ2xegnEyGZwWgMHGcPB3mjtT/Gs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mUUXs337; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mUUXs337"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781730408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VmCjjXa4qanQEpt4giFSiHv8IlU+/sggKY3vLCYRE8E=;
	b=mUUXs337EwnpeEluxbZdMpU47Mx3lSAkzn+LekprbCntH3z6wYyv+ed7KJC0Dd5sWbpiMM
	RUzVZDg1osGkoACZSU5WDJB48eoDc0KYKR7aIjy1zZMAMCRStiqUk9UNmwvihzt7L2C+kV
	PjWTS16di5U9n2pNy8fS8M7CR5tj4nk=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Add kfunc set test to resolve_btfids
Date: Wed, 17 Jun 2026 14:06:19 -0700
Message-ID: <20260617210619.1562858-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260617210619.1562858-1-ihor.solodrai@linux.dev>
References: <20260617210619.1562858-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extend the resolve_btfids selftest to cover kfunc sets defined with
BTF_KFUNCS_START/BTF_KFUNCS_END.

The test verifies that resolve_btfids correctly processes BTF_ID_FLAGS,
resolves function IDs, and checks the kfunc set is sorted.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 63 ++++++++++++++++---
 tools/testing/selftests/bpf/progs/btf_data.c  | 10 +++
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 6bcadee50bb8..65ede3ac5845 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -12,6 +12,10 @@
 
 #define BTF_DATA_FILE "resolve_btfids.test.o.BTF"
 
+#ifndef KF_FASTCALL
+#define KF_FASTCALL (1 << 12)
+#endif
+
 struct symbol {
 	const char	*name;
 	int		 type;
@@ -28,6 +32,17 @@ struct symbol test_symbols[] = {
 	{ "func",    BTF_KIND_FUNC,    -1 },
 };
 
+struct kfunc_symbol {
+	const char	*name;
+	s32		 id;
+	u32		 flags;
+};
+
+static struct kfunc_symbol kfunc_symbols[] = {
+	{ "kfunc_a", -1, 0 },
+	{ "kfunc_b", -1, KF_FASTCALL },
+};
+
 /* Align the .BTF_ids section to 4 bytes */
 asm (
 ".pushsection " BTF_IDS_SECTION " ,\"a\"; \n"
@@ -35,9 +50,9 @@ asm (
 ".popsection;                             \n");
 
 /*
- * test_list_local and test_set are .local symbols placed in .BTF_ids by
- * inline asm, and are read here directly by C name. To the compiler they
- * are plain, default-visibility extern objects.
+ * test_list_local, test_set and test_kfunc_set are .local symbols placed
+ * in .BTF_ids by inline asm, and are read here directly by C name. To the
+ * compiler they are plain, default-visibility extern objects.
  *
  * When test_progs is linked as a position-independent executable (PIE),
  * taking the address of such an extern is routed through the GOT. The
@@ -69,6 +84,11 @@ BTF_ID(struct,  S)
 BTF_ID(union,   U)
 BTF_ID(func,    func)
 BTF_SET_END(test_set)
+
+BTF_KFUNCS_START(test_kfunc_set)
+BTF_ID_FLAGS(func, kfunc_a)
+BTF_ID_FLAGS(func, kfunc_b, KF_FASTCALL)
+BTF_KFUNCS_END(test_kfunc_set)
 #pragma GCC visibility pop
 
 extern __u32 test_list_global[];
@@ -92,6 +112,8 @@ __resolve_symbol(struct btf *btf, int type_id)
 	if (!ASSERT_OK_PTR(type, "btf__type_by_id"))
 		return -1;
 
+	str = btf__name_by_offset(btf, type->name_off);
+
 	for (i = 0; i < ARRAY_SIZE(test_symbols); i++) {
 		if (test_symbols[i].id >= 0)
 			continue;
@@ -99,14 +121,20 @@ __resolve_symbol(struct btf *btf, int type_id)
 		if (BTF_INFO_KIND(type->info) != test_symbols[i].type)
 			continue;
 
-		str = btf__name_by_offset(btf, type->name_off);
-		if (!ASSERT_OK_PTR(str, "btf__name_by_offset"))
-			return -1;
-
 		if (!strcmp(str, test_symbols[i].name))
 			test_symbols[i].id = type_id;
 	}
 
+	if (!btf_is_func(type))
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
+		if (kfunc_symbols[i].id >= 0)
+			continue;
+		if (!strcmp(str, kfunc_symbols[i].name))
+			kfunc_symbols[i].id = type_id;
+	}
+
 	return 0;
 }
 
@@ -161,6 +189,27 @@ void test_resolve_btfids(void)
 			ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check");
 	}
 
+	/* Check BTF_KFUNCS_START(test_kfunc_set) */
+	ASSERT_EQ(test_kfunc_set.flags, BTF_SET8_KFUNCS, "kfunc_set_flags");
+	ASSERT_EQ(test_kfunc_set.cnt, ARRAY_SIZE(kfunc_symbols), "kfunc_set_cnt");
+
+	for (i = 0; i < test_kfunc_set.cnt; i++) {
+		for (j = 0; j < ARRAY_SIZE(kfunc_symbols); j++) {
+			if (kfunc_symbols[j].id == (s32)test_kfunc_set.pairs[i].id) {
+				ASSERT_EQ(test_kfunc_set.pairs[i].flags,
+					  kfunc_symbols[j].flags, "kfunc_flags_check");
+				break;
+			}
+		}
+
+		ASSERT_TRUE(j < ARRAY_SIZE(kfunc_symbols), "kfunc_id_found");
+
+		if (i > 0) {
+			ASSERT_LE(test_kfunc_set.pairs[i - 1].id,
+				  test_kfunc_set.pairs[i].id, "kfunc_sort_check");
+		}
+	}
+
 out:
 	btf__free(btf);
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_data.c b/tools/testing/selftests/bpf/progs/btf_data.c
index baa525275bde..8587658012c3 100644
--- a/tools/testing/selftests/bpf/progs/btf_data.c
+++ b/tools/testing/selftests/bpf/progs/btf_data.c
@@ -48,3 +48,13 @@ int func(struct root_struct *root)
 {
 	return 0;
 }
+
+int kfunc_a(struct root_struct *root)
+{
+	return 0;
+}
+
+int kfunc_b(struct root_struct *root)
+{
+	return 0;
+}
-- 
2.54.0

