Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7633B2D06
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725597; cv=none; b=HvAlo4gq5X+3K0qHXfyvLdePmNziqCTATLzOY0flshC5vpTlaT5t7+1zdfoNvnpaJDDy1F6zj4saovlZTzaOrpr+tqQZGNAlMywBwdqeV7pbfb9qxNJ5M0YDmAMOAY6AUvxbSiLgMSphbGEeBfDgbEZflROIaK5obSbEVPdYG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725597; c=relaxed/simple;
	bh=z6V6HaxUlxmuAOH4MHKe9E43qb1V2tbqINw3tqOFyQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9+7ekTIQ41NexQXodhN50QpwehvwdORBR16C/gRsuOif7yxQzM0RmFwp919M0SIe7mfTwAl7o3Qk2rAloGoc5SzXaElf60kKgdyih2mRkuTsjoPIhoAvXzz95yFOph0pWoJlCj50TBm1UVzMX8StvSdHILWLzov3Sg6Lyf10kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aHnIihvT; arc=none smtp.client-ip=91.218.175.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aHnIihvT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z6V6HaxUlxmuAOH4MHKe9E43qb1V2tbqINw3tqOFyQQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790725593; v=1; x=1791330393;
 b=aHnIihvTQ4bgo49d9LXYqUX0nK+2oDH9J3+RReMbTVkI3azO0XiHBgDigvJzYtAciT/upg5I
 SSb2tR0xBoc+i0Cng9Ds47zvGLNgZVrLAVByR6s05WvKn/napN5y/Hf259jSP2mNsqQ/e0yb5CP
 xKxAiDv+tBbAlgYkq+dVBtCg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7b746779c746f165;
	Tue, 29 Sep 2026 23:46:33 +0000
X-Mizu-Trace-ID: 7b746779c746f165
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Test btf_dump rendering of decl_tags
Date: Tue, 29 Sep 2026 16:46:07 -0700
Message-ID: <20260929234608.48503-5-ihor.solodrai@linux.dev>
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

Cover the decl tag rendering the libbpf patch added. One subtest
builds a BTF with every shape that renders, plus two that must not:

 - a named record with both forms of tag
 - a typedef'd anonymous record, whose attribute precedes the declarator
 - a union
 - a record that also carries the derived packed attribute
 - an anonymous record inlined at a member
 - two records whose tags are added in reverse target order, which is
   what pins the sort: without it the records lose their attributes
 - attributes on a var and on a func, which btf_dump never declares

The incremental subtest's second round adds an attribute to the new
struct, pinning the later-walk indexing of appended types.

A separate subtest covers members. A member attribute and a record one
share a key in the index, so it checks they do not leak into each
other's position, over a function pointer, an array and a bit-field -
declarators the attribute has to follow rather than precede.

Another covers typedefs, including a typedef of an anonymous record
carrying three groups at once, binding to the member, the record and
the typedef.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 276 +++++++++++++++++-
 1 file changed, 275 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 838f7232f591..17fa44cb9c91 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -310,6 +310,8 @@ static void test_btf_dump_incremental(void)
 	ASSERT_OK(err, "field_ok");
 	err = btf__add_field(btf, "s", 6, 64, 0);
 	ASSERT_OK(err, "field_ok");
+	/* attribute on a type added after the first dump: the later walk indexes it */
+	ASSERT_EQ(btf__add_decl_attr(btf, "round2", 7, -1), 8, "round2_attr");
 
 	test_ctx__dump_and_compare(&t,
 "struct s___2 {\n"
@@ -318,7 +320,270 @@ static void test_btf_dump_incremental(void)
 "		Y___2 = 1,\n"
 "	} y;\n"
 "	struct s s;\n"
-"};\n\n" , "c_dump1");
+"} __attribute__((round2));\n\n", "c_dump1");
+
+	test_ctx__free(&t);
+}
+
+static void test_btf_dump_decl_tags(void)
+{
+	struct test_ctx t = {};
+	struct btf *btf;
+	int id;
+
+	if (test_ctx__init(&t))
+		return;
+
+	btf = t.btf;
+
+	/*
+	 * Generate BTF corresponding to the following C code:
+	 *
+	 * struct s1 { int f; } __attribute__((attr1))
+	 *                      __attribute__((btf_decl_tag("plain_tag")));
+	 * typedef struct { int f; } __attribute__((a1)) __attribute__((a2)) t1;
+	 * union u1 { int f; } __attribute__((uattr));
+	 * struct p1 { char c; int i; } __attribute__((packed)) __attribute__((pattr));
+	 * struct outer { struct { int g; } __attribute__((inner)) in; };
+	 * struct s2 { int f; } __attribute__((on_s2));
+	 * struct s3 { int f; } __attribute__((on_s3));
+	 *
+	 * plus attributes on a var and a func, which btf_dump does not declare.
+	 */
+	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	ASSERT_EQ(id, 1, "int_id");
+	id = btf__add_int(btf, "char", 1, BTF_INT_CHAR);
+	ASSERT_EQ(id, 2, "char_id");
+
+	/* a named record with one attribute of each form */
+	id = btf__add_struct(btf, "s1", 4);
+	ASSERT_EQ(id, 3, "s1_id");
+	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s1_field");
+	ASSERT_EQ(btf__add_decl_attr(btf, "attr1", 3, -1), 4, "s1_attr");
+	/* no kflag: rendered as a btf_decl_tag(), not as a bare attribute */
+	ASSERT_EQ(btf__add_decl_tag(btf, "plain_tag", 3, -1), 5, "s1_plain_tag");
+
+	/*
+	 * an anonymous record behind a typedef, with two attributes. This is
+	 * the case that cannot be expressed by a caller appending to the dump:
+	 * the attribute has to go before the declarator.
+	 */
+	id = btf__add_struct(btf, NULL, 4);
+	ASSERT_EQ(id, 6, "anon_id");
+	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "anon_field");
+	ASSERT_EQ(btf__add_decl_attr(btf, "a1", 6, -1), 7, "anon_attr1");
+	ASSERT_EQ(btf__add_decl_attr(btf, "a2", 6, -1), 8, "anon_attr2");
+	id = btf__add_typedef(btf, "t1", 6);
+	ASSERT_EQ(id, 9, "typedef_id");
+
+	/* unions are records too */
+	id = btf__add_union(btf, "u1", 4);
+	ASSERT_EQ(id, 10, "u1_id");
+	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "u1_field");
+	ASSERT_EQ(btf__add_decl_attr(btf, "uattr", 10, -1), 11, "u1_attr");
+
+	/* composes with the packed attribute, which is derived from layout */
+	id = btf__add_struct(btf, "p1", 5);
+	ASSERT_EQ(id, 12, "p1_id");
+	ASSERT_OK(btf__add_field(btf, "c", 2, 0, 0), "p1_field_c");
+	ASSERT_OK(btf__add_field(btf, "i", 1, 8, 0), "p1_field_i");
+	ASSERT_EQ(btf__add_decl_attr(btf, "pattr", 12, -1), 13, "p1_attr");
+
+	/* an anonymous record inlined at a member, the third emission position */
+	id = btf__add_struct(btf, NULL, 4);
+	ASSERT_EQ(id, 14, "inner_id");
+	ASSERT_OK(btf__add_field(btf, "g", 1, 0, 0), "inner_field");
+	ASSERT_EQ(btf__add_decl_attr(btf, "inner", 14, -1), 15, "inner_attr");
+	id = btf__add_struct(btf, "outer", 4);
+	ASSERT_EQ(id, 16, "outer_id");
+	ASSERT_OK(btf__add_field(btf, "in", 14, 0, 0), "outer_field");
+
+	/* not rendered: a var has no declaration in the C output */
+	id = btf__add_var(btf, "v", BTF_VAR_GLOBAL_ALLOCATED, 3);
+	ASSERT_EQ(id, 17, "var_id");
+	ASSERT_EQ(btf__add_decl_attr(btf, "var_attr", 17, -1), 18, "var_attr");
+	/* not rendered: neither does a func */
+	id = btf__add_func_proto(btf, 1);
+	ASSERT_EQ(id, 19, "proto_id");
+	id = btf__add_func(btf, "fn", BTF_FUNC_GLOBAL, 19);
+	ASSERT_EQ(id, 20, "func_id");
+	ASSERT_EQ(btf__add_decl_attr(btf, "func_attr", 20, -1), 21, "func_attr");
+
+	/*
+	 * Tags added in reverse target order: the tag with the lower type ID
+	 * names the record with the higher one, so the index is in emission
+	 * order only once btf_dump_resize() has sorted it. Without the sort
+	 * the lookups land outside their runs and the records lose their
+	 * attributes.
+	 */
+	id = btf__add_struct(btf, "s2", 4);
+	ASSERT_EQ(id, 22, "s2_id");
+	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s2_field");
+	id = btf__add_struct(btf, "s3", 4);
+	ASSERT_EQ(id, 23, "s3_id");
+	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s3_field");
+	ASSERT_EQ(btf__add_decl_attr(btf, "on_s3", 23, -1), 24, "s3_attr");
+	ASSERT_EQ(btf__add_decl_attr(btf, "on_s2", 22, -1), 25, "s2_attr");
+
+	test_ctx__dump_and_compare(&t,
+"struct s1 {\n"
+"	int f;\n"
+"} __attribute__((attr1)) __attribute__((btf_decl_tag(\"plain_tag\")));\n"
+"\n"
+"typedef struct {\n"
+"	int f;\n"
+"} __attribute__((a1)) __attribute__((a2)) t1;\n"
+"\n"
+"union u1 {\n"
+"	int f;\n"
+"} __attribute__((uattr));\n"
+"\n"
+"struct p1 {\n"
+"	char c;\n"
+"	int i;\n"
+"} __attribute__((packed)) __attribute__((pattr));\n"
+"\n"
+"struct outer {\n"
+"	struct {\n"
+"		int g;\n"
+"	} __attribute__((inner)) in;\n"
+"};\n"
+"\n"
+"struct s2 {\n"
+"	int f;\n"
+"} __attribute__((on_s2));\n"
+"\n"
+"struct s3 {\n"
+"	int f;\n"
+"} __attribute__((on_s3));\n"
+"\n", "dump_and_compare");
+
+	test_ctx__free(&t);
+}
+
+/*
+ * An attribute on a member is emitted at the member declaration, and one on
+ * the record at the closing brace. Both are keyed by the record in the index,
+ * so this also checks that they do not leak into each other's position.
+ */
+static void test_btf_dump_decl_tags_members(void)
+{
+	struct test_ctx t = {};
+	struct btf *btf;
+	int id;
+
+	if (test_ctx__init(&t))
+		return;
+
+	btf = t.btf;
+
+	/*
+	 * Generate BTF corresponding to the following C code:
+	 *
+	 * struct m1 {
+	 *	int (*fp)(void) __attribute__((fp_attr));
+	 *	int a;
+	 *	int b __attribute__((b1)) __attribute__((b2));
+	 *	int arr[4] __attribute__((arr_attr));
+	 * } __attribute__((rec));
+	 * struct bits { int x : 3 __attribute__((x_attr)); int y : 29; };
+	 */
+	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	ASSERT_EQ(id, 1, "int_id");
+	id = btf__add_array(btf, 1, 1, 4);
+	ASSERT_EQ(id, 2, "array_id");
+	id = btf__add_func_proto(btf, 1);
+	ASSERT_EQ(id, 3, "proto_id");
+	id = btf__add_ptr(btf, 3);
+	ASSERT_EQ(id, 4, "ptr_id");
+
+	id = btf__add_struct(btf, "m1", 32);
+	ASSERT_EQ(id, 5, "m1_id");
+	ASSERT_OK(btf__add_field(btf, "fp", 4, 0, 0), "m1_fp");
+	ASSERT_OK(btf__add_field(btf, "a", 1, 64, 0), "m1_a");
+	ASSERT_OK(btf__add_field(btf, "b", 1, 96, 0), "m1_b");
+	ASSERT_OK(btf__add_field(btf, "arr", 2, 128, 0), "m1_arr");
+	ASSERT_EQ(btf__add_decl_attr(btf, "rec", 5, -1), 6, "m1_rec_attr");
+	/* the attribute follows the whole declarator, pointer and array alike */
+	ASSERT_EQ(btf__add_decl_attr(btf, "fp_attr", 5, 0), 7, "m1_fp_attr");
+	/* two on one member, to pin the ordering */
+	ASSERT_EQ(btf__add_decl_attr(btf, "b1", 5, 2), 8, "m1_b1");
+	ASSERT_EQ(btf__add_decl_attr(btf, "b2", 5, 2), 9, "m1_b2");
+	ASSERT_EQ(btf__add_decl_attr(btf, "arr_attr", 5, 3), 10, "m1_arr_attr");
+
+	/* a bit-field: the attribute has to follow the width */
+	id = btf__add_struct(btf, "bits", 4);
+	ASSERT_EQ(id, 11, "bits_id");
+	ASSERT_OK(btf__add_field(btf, "x", 1, 0, 3), "bits_x");
+	ASSERT_OK(btf__add_field(btf, "y", 1, 3, 29), "bits_y");
+	ASSERT_EQ(btf__add_decl_attr(btf, "x_attr", 11, 0), 12, "bits_x_attr");
+
+	test_ctx__dump_and_compare(&t,
+"struct m1 {\n"
+"	int (*fp)(void) __attribute__((fp_attr));\n"
+"	int a;\n"
+"	int b __attribute__((b1)) __attribute__((b2));\n"
+"	int arr[4] __attribute__((arr_attr));\n"
+"} __attribute__((rec));\n"
+"\n"
+"struct bits {\n"
+"	int x: 3 __attribute__((x_attr));\n"
+"	int y: 29;\n"
+"};\n"
+"\n", "dump_and_compare");
+
+	test_ctx__free(&t);
+}
+
+/*
+ * A typedef is the third and last kind btf_dump declares. Its attributes go
+ * after the declarator, so a typedef of an anonymous record can carry three
+ * groups in one declaration, binding to three different entities.
+ */
+static void test_btf_dump_decl_tags_typedef(void)
+{
+	struct test_ctx t = {};
+	struct btf *btf;
+	int id;
+
+	if (test_ctx__init(&t))
+		return;
+
+	btf = t.btf;
+
+	/*
+	 * Generate BTF corresponding to the following C code:
+	 *
+	 * typedef int td __attribute__((t1))
+	 *                __attribute__((btf_decl_tag("t2")));
+	 * typedef struct {
+	 *	int f __attribute__((memb_attr));
+	 * } __attribute__((rec_attr)) both __attribute__((both_attr));
+	 */
+	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	ASSERT_EQ(id, 1, "int_id");
+	id = btf__add_typedef(btf, "td", 1);
+	ASSERT_EQ(id, 2, "td_id");
+	ASSERT_EQ(btf__add_decl_attr(btf, "t1", 2, -1), 3, "td_attr1");
+	/* no kflag: rendered as a btf_decl_tag(), not as a bare attribute */
+	ASSERT_EQ(btf__add_decl_tag(btf, "t2", 2, -1), 4, "td_attr2");
+
+	id = btf__add_struct(btf, NULL, 4);
+	ASSERT_EQ(id, 5, "anon_id");
+	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "anon_field");
+	ASSERT_EQ(btf__add_decl_attr(btf, "rec_attr", 5, -1), 6, "anon_rec_attr");
+	ASSERT_EQ(btf__add_decl_attr(btf, "memb_attr", 5, 0), 7, "anon_memb_attr");
+	id = btf__add_typedef(btf, "both", 5);
+	ASSERT_EQ(id, 8, "both_id");
+	ASSERT_EQ(btf__add_decl_attr(btf, "both_attr", 8, -1), 9, "both_attr");
+
+	test_ctx__dump_and_compare(&t,
+"typedef int td __attribute__((t1)) __attribute__((btf_decl_tag(\"t2\")));\n"
+"\n"
+"typedef struct {\n"
+"	int f __attribute__((memb_attr));\n"
+"} __attribute__((rec_attr)) both __attribute__((both_attr));\n"
+"\n", "dump_and_compare");
 
 	test_ctx__free(&t);
 }
@@ -1104,6 +1369,15 @@ void test_btf_dump() {
 	if (test__start_subtest("btf_dump: incremental"))
 		test_btf_dump_incremental();
 
+	if (test__start_subtest("btf_dump: decl_tags"))
+		test_btf_dump_decl_tags();
+
+	if (test__start_subtest("btf_dump: decl_tags_members"))
+		test_btf_dump_decl_tags_members();
+
+	if (test__start_subtest("btf_dump: decl_tags_typedef"))
+		test_btf_dump_decl_tags_typedef();
+
 	if (test__start_subtest("btf_dump: type_tags"))
 		test_btf_dump_type_tags();
 
-- 
2.50.1

