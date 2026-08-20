Received: from mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87A24B28
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 00:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184425; cv=none; b=Y6mFad5SPMXKLmoLPQZlaJQqJRZlwJ670BalTEHFRBIQzGelmgbZt1gstcydJHzzmtV/xdIfCEo+m/VgJQPxWOf5/qwgWTIln2T7uRk3IFUuh6uydAwkUoXQonPoGNoizdp9HebiOA0UHMzBntAutaNL24k9+5ZLd1YaYGiXgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184425; c=relaxed/simple;
	bh=ABIoBjSE2emDABJEZS3XwipYH1/oMpbFlTN+TvgCZ14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGJSJ05LGn3OyiDB8i7czWjPBq99EqgA5bgGPQp8brjZyggDdZ5MLPPC+tzqEp0SWXEwtAQAXz0cyRnYWGmG50YvaaKQ/GYauFC87aeJMWS53vRo6JBsJVOXxbmcQwkZyu/cRty0tJy0gTw+3N9YMHbvSnwJcT0yCl/79z/l6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WF3Nd2kd; arc=none smtp.client-ip=95.215.58.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WF3Nd2kd"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ABIoBjSE2emDABJEZS3XwipYH1/oMpbFlTN+TvgCZ14=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787184421; v=1; x=1787789221;
 b=WF3Nd2kdhPDc7nV/rvlQXUzn8zzMWzTkvYujWfxKaqfsudHQ8RIzTRyoPXfp4p1ESAA1lFyD
 iUXKF9FgjAOTfHY6gUX6TpcPffk0pnfqFDT+qOhwGc51xqVN2Pz1jCQdcn4b+C2IsL9DWokdDIi
 NSFhtL1XQBV3rGlnaZ16YiLQ=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::5:942a)
	by mta11.migadu.com with ESMTPS id 516f7423daf147aa;
	Thu, 20 Aug 2026 00:07:01 +0000
X-Mizu-Trace-ID: 516f7423daf147aa
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v1 4/4] selftests/bpf: Check that sorting preserves types in bpftool dump
Date: Wed, 19 Aug 2026 17:06:27 -0700
Message-ID: <20260820000627.3826188-5-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorting the C dump is meant to make generated headers diffable. The
sorted and unsorted dumps of the same BTF have to emit the same types.

Extend the fixture with a few more top-level definitions, including
anonymous enums, and add a subtest comparing how many types are
emitted with or without sort.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 78 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
index 53bb7065b3ca..28059820ea0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -53,15 +53,18 @@ static char *dump_c(const char *path, bool sorted)
 
 /*
  * struct holey { int c; <32 bit hole> int tail; };
+ * enum { E0 = 1 }; enum { E1 = 2 }; enum { E2 = 3 };
+ * struct s { int f; };
+ * union u { int f; };
  *
  * One record with a hole, and a 4-byte long to pad it with. How records
- * themselves are rendered is already covered by the build, so the fixture does
- * not need to be more elaborate than that.
+ * themselves are rendered is already covered by the build.
+ * The anonymous enums matter to the sorting subtest.
  */
 static struct btf *mk_btf(void)
 {
 	struct btf *btf;
-	int id, err;
+	int id, err, i;
 
 	btf = btf__new_empty();
 	if (!ASSERT_OK_PTR(btf, "new_empty"))
@@ -87,6 +90,36 @@ static struct btf *mk_btf(void)
 	if (!ASSERT_OK(err, "holey_tail"))
 		goto err_out;
 
+	for (i = 0; i < 3; i++) {
+		char name[16];
+
+		snprintf(name, sizeof(name), "E%d", i);
+
+		id = btf__add_enum(btf, NULL, 4);
+		if (!ASSERT_GT(id, 0, "anon_enum"))
+			goto err_out;
+
+		err = btf__add_enum_value(btf, name, i + 1);
+		if (!ASSERT_OK(err, "enum_val"))
+			goto err_out;
+	}
+
+	id = btf__add_struct(btf, "s", 4);
+	if (!ASSERT_GT(id, 0, "struct_s"))
+		goto err_out;
+
+	err = btf__add_field(btf, "f", 1, 0, 0);
+	if (!ASSERT_OK(err, "s_field"))
+		goto err_out;
+
+	id = btf__add_union(btf, "u", 4);
+	if (!ASSERT_GT(id, 0, "union_u"))
+		goto err_out;
+
+	err = btf__add_field(btf, "f", 1, 0, 0);
+	if (!ASSERT_OK(err, "u_field"))
+		goto err_out;
+
 	btf__set_pointer_size(btf, 4);
 
 	return btf;
@@ -95,6 +128,42 @@ static struct btf *mk_btf(void)
 	return NULL;
 }
 
+static int count_substr(const char *haystack, const char *needle)
+{
+	const char *p = haystack;
+	int n = 0;
+
+	for (; (p = strstr(p, needle)); p++)
+		n++;
+
+	return n;
+}
+
+static void test_sort_preserves_types(const char *path)
+{
+	char *sorted = NULL, *unsorted = NULL;
+	int n_sorted, n_unsorted;
+
+	sorted = dump_c(path, true);
+	unsorted = dump_c(path, false);
+	if (!sorted || !unsorted)
+		goto out;
+
+	/*
+	 * Count definitions by the closing brace in their first column. Counting
+	 * "struct"/"union"/"enum" openers instead would also count forward
+	 * declarations, and which types need one depends on emission order.
+	 */
+	n_unsorted = count_substr(unsorted, "\n}");
+	n_sorted = count_substr(sorted, "\n}");
+	ASSERT_GT(n_unsorted, 0, "types_emitted");
+	ASSERT_EQ(n_sorted, n_unsorted, "same_type_count");
+
+out:
+	free(sorted);
+	free(unsorted);
+}
+
 /*
  * Check only what the selftests build cannot:
  *   - bpf_helpers.h defines __ksym and __weak as well, and no program uses
@@ -145,6 +214,9 @@ void test_bpftool_btf_dump(void)
 	if (test__start_subtest("c_unsorted"))
 		test_dump(path, false);
 
+	if (test__start_subtest("c_sort_preserves_types"))
+		test_sort_preserves_types(path);
+
 	unlink(path);
 out:
 	btf__free(btf);
-- 
2.55.0

