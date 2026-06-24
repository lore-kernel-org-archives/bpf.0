Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3483D30F55B
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782262570; cv=none; b=I0ljluDsSRZr8x/2zqFTDoCiAzfRm29hkiujR1EUoi796TZJr05XlQKatUrEAnt/SWpGwYFacytcnBnAb3mfRdx79wV+HLJUb+CJflym8S5xceRz1ZpVmWLv0w6f8cSRgTmABJiIfpN1L7J9mJR/ybKfnlixh7R5mYyq3BXzE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782262570; c=relaxed/simple;
	bh=+7TkUY/zUWYPDsrx32FOFjIfpXHnbnVOpCRnlBVNDCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCGRgGtAakBDcthR33HVxo3fOEkrlqx0fR82Mo5q9syVC1548Nz++eT0fmRFSo8Kp860Eg8LWUIQIpFPwIqd1YzA6tKQVuxCGEHjWv1x3iP4p006OBvDVDSW9EkL8cTP/nan1Dyw62z5e2ozOF62SUrGnsBm2/zRjROEOazoVF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ext2MKSH; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ext2MKSH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782262567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAZjiRbwpkyuNiWenvzRyt/YOz7UBDMwH7gPLMm4K8k=;
	b=Ext2MKSHXv9Uf1RtUUENTPQfTYGPHA7+5Hht69Q2sKYrtTV9QDpX4rVbvl9vvIhE5EAMxr
	2nqa3elEwTU53OAemHIBCEhXibz/35kw/9yVtNQOvA4UMhY4JvGyDtl9ianbuL1BIKoc2S
	Uc5PXv1AvhpP9S9BqvhTwFvbP68Dnko=
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
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Modernize resolve_btfids test scaffolding
Date: Tue, 23 Jun 2026 17:55:44 -0700
Message-ID: <20260624005546.1818483-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260624005546.1818483-1-ihor.solodrai@linux.dev>
References: <20260624005546.1818483-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Refactor resolve_btfids test in order to:
  * use newer ASSERT_* macros instead of CHECK
  * extend the lifetime of loaded BTF to enable additional checks
  * cleanup unused/unnecessary code

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/resolve_btfids.c | 59 +++++++------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 41dfaaabb73f..a26adf404d7e 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -10,7 +10,7 @@
 #include <linux/btf_ids.h>
 #include "test_progs.h"
 
-static int duration;
+#define BTF_DATA_FILE "resolve_btfids.test.o.BTF"
 
 struct symbol {
 	const char	*name;
@@ -70,10 +70,8 @@ __resolve_symbol(struct btf *btf, int type_id)
 	unsigned int i;
 
 	type = btf__type_by_id(btf, type_id);
-	if (!type) {
-		PRINT_FAIL("Failed to get type for ID %d\n", type_id);
+	if (!ASSERT_OK_PTR(type, "btf__type_by_id"))
 		return -1;
-	}
 
 	for (i = 0; i < ARRAY_SIZE(test_symbols); i++) {
 		if (test_symbols[i].id >= 0)
@@ -83,10 +81,8 @@ __resolve_symbol(struct btf *btf, int type_id)
 			continue;
 
 		str = btf__name_by_offset(btf, type->name_off);
-		if (!str) {
-			PRINT_FAIL("Failed to get name for BTF ID %d\n", type_id);
+		if (!ASSERT_OK_PTR(str, "btf__name_by_offset"))
 			return -1;
-		}
 
 		if (!strcmp(str, test_symbols[i].name))
 			test_symbols[i].id = type_id;
@@ -95,25 +91,15 @@ __resolve_symbol(struct btf *btf, int type_id)
 	return 0;
 }
 
-static int resolve_symbols(void)
+static int resolve_symbols(struct btf *btf)
 {
-	struct btf *btf;
+	__u32 nr = btf__type_cnt(btf);
 	int type_id;
-	__u32 nr;
-
-	btf = btf__parse_raw("resolve_btfids.test.o.BTF");
-	if (CHECK(libbpf_get_error(btf), "resolve",
-		  "Failed to load BTF from resolve_btfids.test.o.BTF\n"))
-		return -1;
-
-	nr = btf__type_cnt(btf);
 
 	for (type_id = 1; type_id < nr; type_id++) {
 		if (__resolve_symbol(btf, type_id))
-			break;
+			return -1;
 	}
-
-	btf__free(btf);
 	return 0;
 }
 
@@ -121,25 +107,22 @@ void test_resolve_btfids(void)
 {
 	__u32 *test_list, *test_lists[] = { test_list_local, test_list_global };
 	unsigned int i, j;
-	int ret = 0;
+	struct btf *btf;
 
-	if (resolve_symbols())
+	btf = btf__parse_raw(BTF_DATA_FILE);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
 		return;
 
+	if (resolve_symbols(btf))
+		goto out;
+
 	/* Check BTF_ID_LIST(test_list_local) and
 	 * BTF_ID_LIST_GLOBAL(test_list_global) IDs
 	 */
 	for (j = 0; j < ARRAY_SIZE(test_lists); j++) {
 		test_list = test_lists[j];
-		for (i = 0; i < ARRAY_SIZE(test_symbols); i++) {
-			ret = CHECK(test_list[i] != test_symbols[i].id,
-				    "id_check",
-				    "wrong ID for %s (%d != %d)\n",
-				    test_symbols[i].name,
-				    test_list[i], test_symbols[i].id);
-			if (ret)
-				return;
-		}
+		for (i = 0; i < ARRAY_SIZE(test_symbols); i++)
+			ASSERT_EQ(test_list[i], test_symbols[i].id, test_symbols[i].name);
 	}
 
 	/* Check BTF_SET_START(test_set) IDs */
@@ -153,15 +136,13 @@ void test_resolve_btfids(void)
 			break;
 		}
 
-		ret = CHECK(!found, "id_check",
-			    "ID %d not found in test_symbols\n",
-			    test_set.ids[i]);
-		if (ret)
+		if (!ASSERT_TRUE(found, "id_in_test_symbols"))
 			break;
 
-		if (i > 0) {
-			if (!ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check"))
-				return;
-		}
+		if (i > 0)
+			ASSERT_LE(test_set.ids[i - 1], test_set.ids[i], "sort_check");
 	}
+
+out:
+	btf__free(btf);
 }
-- 
2.54.0

