Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.245
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901604;
	b=rybxHAx/+nxlcW3zDRvQhgY+Kc4KEum9aJr1iV63Qp60lFm23QY3LTtMLhgUyC/pDSFe
	 2GhGWH3S4KHTNYtc4e5QDPv0Ncycn4atRtzx+s1rsQ1wqmiYCuH8rJ7wrZITMnUQrZBE2
	 0Bb4Fh2BTI4I7tgDFDsGDFlibMJd0rRVcsxdIjD2TEt54v/92mi3PEZBjfZPcIGa/acmi
	 9BkejW0IrbmtI04Uc6pqQy9xQKRpp+HUWPgZvz9JDjgLz894yDPf8HE5PI3P0ckqJS++H
	 D8WovjWqk4navoRs352idxTp2mjJGwXzBfMMUq6IDek3IBGbdG1Fgt0s12bjxNUoXtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901604;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y1d1FftDUJ4wgKXXJwpEPGI85Z2rsXSWSvVPReVHO5Q=;
	b=fi3tLiArVMTHeFg/bp1P5uWXXKj2hulaJjXBN/N0OLodwVLGpyRL+Jd49ynB22ndqPaQ
	 t3Gm52HYYR8ePyaTE+rM6Z7M3I4XMxDmJme8XBdFLLZSvBh7VqB+f3PZS6hEirHRDdhA5
	 sITkemDLkmXWcXRJgYpROmJuxtGorPbSue5jX4en7a0HIzSCgRMv32tfdcNOf7soR8vF/
	 gqKuyh0LdYR5ftnGSa8yWz7hUuzbywnGVbXNAn78VysNt6JRVUeh1T706hoOb7Iq1WMLQ
	 qA0vEbalf17xK1Y0nQsit9g72/loo85VUmlctAlFBKM5LNRyaBHZD3hv5spNlPVgByA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nHTGG67i;
	arc=none smtp.remote-ip=91.218.175.245
Received: from mta0.migadu.com (out-245.mta0.migadu.com [91.218.175.245])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9012606A33F
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9012606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nHTGG67i
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZG2TTcXn4C9BpgPPnNJ4Qfhp/qLphVv/NMtZrIzisUg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901602; v=1; x=1794506402;
 b=nHTGG67i3Z+sEFwrVZD7oqwcuSvfC4JFvvSdr2DXBISrAOjJZduHRT/L4OWOQrM5f7OYom0f
 IXeJGJ8EbewS3sLmrs1GO3grJ7CKSiLtpTBrCHe6ftMAllgdZDEgyX+FJXNLVpHU43Ne2JINmxM
 q6teufb8nyW1BflnOY20kcoc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id fd9dbcd62283ea3a;
	Thu, 05 Nov 2026 18:00:01 +0000
X-Mizu-Trace-ID: fd9dbcd62283ea3a
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 07/17] libbpf, bpftool, resolve_btfids: Dump kflagged BTF tags as is
Date: Thu,  5 Nov 2026 10:58:35 -0700
Message-ID: <20261105175845.30357-8-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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

btf_dump wraps the strings of kflagged decl and type tags in an
attribute specifier, so such a tag can only stand for an __attribute__.

Print the strings as is instead. A tag can then carry any annotation,
including an identifier whose definition is left to the consumer of the
dump, such as a macro defined by a generated header.

resolve_btfids, the only in-tree producer of kflagged tags in kernel
BTF, tags arena pointers in kfunc prototypes with "address_space(1)".
Make it encode the complete specifier, __attribute__((address_space(1))).

Kernel BTF produced before this change carries the bare string, which
does not compile when printed as is. pahole emitted it from
commit 21cb33c7e065 ("kbuild, bpf: Enable --btf_features=attributes"),
and resolve_btfids from commit 27a78c2e7eee ("resolve_btfids: Process
KF_ARENA_* flags in resolve_btfids").

In the split BTF that bpftool dumps C through, attach a kflagged decl
tag with the complete specifier to each such type tag, which btf_dump
prints in its place. The input stays unmodified, and module BTF, whose
base holds the vmlinux arena kfuncs, is handled the same way.

A C dump of new kernel BTF by an older bpftool, built with libbpf 1.6
or later, nests the attribute specifier in the arena kfunc prototypes,
which does not compile.

Update the BTF reference, kfunc documentation, libbpf API comments and
existing tests to match.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 Documentation/bpf/btf.rst                     | 14 +--
 Documentation/bpf/kfuncs.rst                  |  3 +-
 tools/bpf/bpftool/btf.c                       | 43 +++++++++
 tools/bpf/resolve_btfids/main.c               |  2 +-
 tools/lib/bpf/btf.c                           |  6 +-
 tools/lib/bpf/btf_dump.c                      |  4 +-
 .../selftests/bpf/prog_tests/btf_dump.c       | 89 +++++++++++--------
 .../selftests/bpf/prog_tests/resolve_btfids.c |  4 +-
 8 files changed, 112 insertions(+), 53 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index ea0d699749af..99833048de60 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -506,10 +506,11 @@ If ``info.kind_flag`` is 0, then this is a normal decl tag, and the
 ``name_off`` encodes btf_decl_tag attribute string.
 
 If ``info.kind_flag`` is 1, then the decl tag represents an arbitrary
-__attribute__. In this case, ``name_off`` encodes a string
-representing the attribute-list of the attribute specifier. For
-example, for an ``__attribute__((aligned(4)))`` the string's contents
-is ``aligned(4)``.
+annotation. ``name_off`` encodes the complete annotation string, which
+``btf_dump`` prints unchanged at the declaration. For example, an attribute
+specifier is encoded as ``__attribute__((aligned(4)))``, including the
+wrapper. A macro can be encoded as its identifier, leaving its definition
+to the generated header or its user.
 
 ``btf_dump`` also accepts decl tags that reference a ``type_tag``, as
 described under ``BTF_KIND_TYPE_TAG``.
@@ -542,8 +543,9 @@ normal type tag, and the ``name_off`` encodes btf_type_tag attribute
 string.
 
 If ``info.kind_flag`` is 1, then the type tag represents an arbitrary
-__attribute__, and the ``name_off`` encodes a string representing the
-attribute-list of the attribute specifier.
+annotation. As with decl tags, ``name_off`` encodes the complete annotation
+string, which ``btf_dump`` prints unchanged. An attribute specifier must
+include its wrapper, for example ``__attribute__((address_space(1)))``.
 
 ``btf_dump`` prints decl tags that reference a type tag, with
 ``btf_decl_tag.component_idx`` of ``-1``, in place of that type tag. They
diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 901c37504217..87b3c4e4bea2 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -567,7 +567,8 @@ At kernel build time the ``resolve_btfids`` tool finds all kfuncs declared with
 For each kfunc it emits a ``bpf_kfunc`` BTF decl tag, a ``bpf_fastcall`` decl
 tag when the kfunc is flagged ``KF_FASTCALL``, and the ``address_space(1)`` type
 attribute on the return value and/or arguments that use arena pointers (see
-sections 2.3.8 and 2.8).
+sections 2.3.8 and 2.8). The type tag stores the complete
+``__attribute__((address_space(1)))`` specifier with ``kind_flag`` set.
 
 2.7  Specifying no-cast aliases with ___init
 --------------------------------------------
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index a438b5a03f5a..b4516361a3fe 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -1092,6 +1092,45 @@ static struct sort_datum *sort_btf_c(const struct btf *btf)
 	return datums;
 }
 
+/*
+ * Kernel BTF keeps its type tags as the kernel expects them. Decl tags in
+ * the dump split choose how btf_dump prints them.
+ */
+static const struct {
+	bool kflag;
+	const char *name;
+	const char *override;
+} btf_c_type_tags[] = {
+	/* the arena attribute in older kernel BTF */
+	{ true, "address_space(1)", "__attribute__((address_space(1)))" },
+};
+
+static int btf_c_annotate_type_tags(struct btf *btf)
+{
+	__u32 i, cnt = btf__type_cnt(btf);
+	size_t j;
+	int err;
+
+	for (i = 1; i < cnt; i++) {
+		const struct btf_type *t = btf__type_by_id(btf, i);
+		const char *name;
+
+		if (!btf_is_type_tag(t))
+			continue;
+		name = btf__name_by_offset(btf, t->name_off);
+		for (j = 0; j < ARRAY_SIZE(btf_c_type_tags); j++) {
+			if (btf_kflag(t) != btf_c_type_tags[j].kflag ||
+			    strcmp(name, btf_c_type_tags[j].name))
+				continue;
+			err = btf__add_decl_attr(btf, btf_c_type_tags[j].override, i, -1);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int dump_btf_c(struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt, bool sort_dump)
 {
@@ -1110,6 +1149,10 @@ static int dump_btf_c(struct btf *btf,
 	if (ptr_sz)
 		btf__set_pointer_size(split, ptr_sz);
 
+	err = btf_c_annotate_type_tags(split);
+	if (err)
+		goto done;
+
 	d = btf_dump__new(split, btf_dump_printf, NULL, NULL);
 	if (!d) {
 		err = -errno;
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 5ad547356303..c16dd93fa6d4 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -204,7 +204,7 @@ struct btf_links {
 #define KF_ARENA_ARG2	(1 << 15)
 #define KF_IMPLICIT_ARGS (1 << 16)
 #define KF_IMPL_SUFFIX "_impl"
-#define TYPE_ATTR_ARENA "address_space(1)"
+#define TYPE_ATTR_ARENA "__attribute__((address_space(1)))"
 #define PARAM_SUFFIX_ARENA "__arena"
 #define PARAM_SUFFIX_ARENA_NULLABLE "__arena__nullable"
 
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 5786232c1fea..0984a8ccb526 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3078,7 +3078,8 @@ int btf__add_type_tag(struct btf *btf, const char *value, int ref_type_id)
  * Append new BTF_KIND_TYPE_TAG type with:
  *   - *value*, non-empty/non-NULL tag value;
  *   - *ref_type_id* - referenced type ID, it might not exist yet;
- * Set info->kflag to 1, indicating this tag is an __attribute__
+ * The kind flag is set; btf_dump prints *value* unchanged.
+ * Attribute specifiers must include the __attribute__((...)) wrapper.
  * Returns:
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
@@ -3413,7 +3414,8 @@ int btf__add_decl_tag(struct btf *btf, const char *value, int ref_type_id,
  *   - *ref_type_id* - referenced type ID, it might not exist yet;
  *   - *component_idx* - -1 for tagging reference type, otherwise struct/union
  *     member or function argument index;
- * Set info->kflag to 1, indicating this tag is an __attribute__
+ * The kind flag is set; btf_dump prints *value* unchanged.
+ * Attribute specifiers must include the __attribute__((...)) wrapper.
  * Returns:
  *   - >0, type ID of newly added BTF type;
  *   - <0, on error.
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index c12c3c248407..fcd97aa90589 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1023,7 +1023,7 @@ static void btf_dump_emit_decl_tag(struct btf_dump *d, const struct btf_type *t)
 	const char *name = btf_name_of(d, t->name_off);
 
 	if (btf_kflag(t))
-		btf_dump_printf(d, " __attribute__((%s))", name);
+		btf_dump_printf(d, " %s", name);
 	else
 		btf_dump_printf(d, " __attribute__((btf_decl_tag(\"%s\")))", name);
 }
@@ -1602,7 +1602,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 				break;
 			name = btf_name_of(d, t->name_off);
 			if (btf_kflag(t))
-				btf_dump_printf(d, " __attribute__((%s))", name);
+				btf_dump_printf(d, " %s", name);
 			else
 				btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
 			break;
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 5a5ee001ac8b..ee8ccefc2a45 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -320,11 +320,12 @@ static void test_btf_dump_incremental(void)
 "		Y___2 = 1,\n"
 "	} y;\n"
 "	struct s s;\n"
-"} __attribute__((round2));\n\n", "c_dump1");
+"} round2;\n\n", "c_dump1");
 
 	test_ctx__free(&t);
 }
 
+/* Bare annotation names in the tag tests stand for user-defined macros. */
 static void test_btf_dump_decl_tags(void)
 {
 	struct test_ctx t = {};
@@ -339,14 +340,14 @@ static void test_btf_dump_decl_tags(void)
 	/*
 	 * Generate BTF corresponding to the following C code:
 	 *
-	 * struct s1 { int f; } __attribute__((attr1))
+	 * struct s1 { int f; } __attribute__((aligned(4), packed))
 	 *                      __attribute__((btf_decl_tag("plain_tag")));
-	 * typedef struct { int f; } __attribute__((a1)) __attribute__((a2)) t1;
-	 * union u1 { int f; } __attribute__((uattr));
-	 * struct p1 { char c; int i; } __attribute__((packed)) __attribute__((pattr));
-	 * struct outer { struct { int g; } __attribute__((inner)) in; };
-	 * struct s2 { int f; } __attribute__((on_s2));
-	 * struct s3 { int f; } __attribute__((on_s3));
+	 * typedef struct { int f; } a1 a2 t1;
+	 * union u1 { int f; } uattr;
+	 * struct p1 { char c; int i; } __attribute__((packed)) pattr;
+	 * struct outer { struct { int g; } inner in; };
+	 * struct s2 { int f; } on_s2;
+	 * struct s3 { int f; } on_s3;
 	 *
 	 * plus attributes on a var and a func, which btf_dump does not declare.
 	 */
@@ -355,12 +356,13 @@ static void test_btf_dump_decl_tags(void)
 	id = btf__add_int(btf, "char", 1, BTF_INT_CHAR);
 	ASSERT_EQ(id, 2, "char_id");
 
-	/* a named record with one attribute of each form */
+	/* a complete attribute specifier next to a normal decl tag */
 	id = btf__add_struct(btf, "s1", 4);
 	ASSERT_EQ(id, 3, "s1_id");
 	ASSERT_OK(btf__add_field(btf, "f", 1, 0, 0), "s1_field");
-	ASSERT_EQ(btf__add_decl_attr(btf, "attr1", 3, -1), 4, "s1_attr");
-	/* no kflag: rendered as a btf_decl_tag(), not as a bare attribute */
+	ASSERT_EQ(btf__add_decl_attr(btf, "__attribute__((aligned(4), packed))", 3, -1),
+		  4, "s1_attr");
+	/* no kflag: rendered as a btf_decl_tag() */
 	ASSERT_EQ(btf__add_decl_tag(btf, "plain_tag", 3, -1), 5, "s1_plain_tag");
 
 	/*
@@ -428,34 +430,34 @@ static void test_btf_dump_decl_tags(void)
 	test_ctx__dump_and_compare(&t,
 "struct s1 {\n"
 "	int f;\n"
-"} __attribute__((attr1)) __attribute__((btf_decl_tag(\"plain_tag\")));\n"
+"} __attribute__((aligned(4), packed)) __attribute__((btf_decl_tag(\"plain_tag\")));\n"
 "\n"
 "typedef struct {\n"
 "	int f;\n"
-"} __attribute__((a1)) __attribute__((a2)) t1;\n"
+"} a1 a2 t1;\n"
 "\n"
 "union u1 {\n"
 "	int f;\n"
-"} __attribute__((uattr));\n"
+"} uattr;\n"
 "\n"
 "struct p1 {\n"
 "	char c;\n"
 "	int i;\n"
-"} __attribute__((packed)) __attribute__((pattr));\n"
+"} __attribute__((packed)) pattr;\n"
 "\n"
 "struct outer {\n"
 "	struct {\n"
 "		int g;\n"
-"	} __attribute__((inner)) in;\n"
+"	} inner in;\n"
 "};\n"
 "\n"
 "struct s2 {\n"
 "	int f;\n"
-"} __attribute__((on_s2));\n"
+"} on_s2;\n"
 "\n"
 "struct s3 {\n"
 "	int f;\n"
-"} __attribute__((on_s3));\n"
+"} on_s3;\n"
 "\n", "dump_and_compare");
 
 	test_ctx__free(&t);
@@ -481,12 +483,12 @@ static void test_btf_dump_decl_tags_members(void)
 	 * Generate BTF corresponding to the following C code:
 	 *
 	 * struct m1 {
-	 *	int (*fp)(void) __attribute__((fp_attr));
+	 *	int (*fp)(void) fp_attr;
 	 *	int a;
-	 *	int b __attribute__((b1)) __attribute__((b2));
-	 *	int arr[4] __attribute__((arr_attr));
-	 * } __attribute__((rec));
-	 * struct bits { int x : 3 __attribute__((x_attr)); int y : 29; };
+	 *	int b b1 b2;
+	 *	int arr[4] arr_attr;
+	 * } rec;
+	 * struct bits { int x : 3 x_attr; int y : 29; };
 	 */
 	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
 	ASSERT_EQ(id, 1, "int_id");
@@ -520,14 +522,14 @@ static void test_btf_dump_decl_tags_members(void)
 
 	test_ctx__dump_and_compare(&t,
 "struct m1 {\n"
-"	int (*fp)(void) __attribute__((fp_attr));\n"
+"	int (*fp)(void) fp_attr;\n"
 "	int a;\n"
-"	int b __attribute__((b1)) __attribute__((b2));\n"
-"	int arr[4] __attribute__((arr_attr));\n"
-"} __attribute__((rec));\n"
+"	int b b1 b2;\n"
+"	int arr[4] arr_attr;\n"
+"} rec;\n"
 "\n"
 "struct bits {\n"
-"	int x: 3 __attribute__((x_attr));\n"
+"	int x: 3 x_attr;\n"
 "	int y: 29;\n"
 "};\n"
 "\n", "dump_and_compare");
@@ -554,18 +556,18 @@ static void test_btf_dump_decl_tags_typedef(void)
 	/*
 	 * Generate BTF corresponding to the following C code:
 	 *
-	 * typedef int td __attribute__((t1))
+	 * typedef int td t1
 	 *                __attribute__((btf_decl_tag("t2")));
 	 * typedef struct {
-	 *	int f __attribute__((memb_attr));
-	 * } __attribute__((rec_attr)) both __attribute__((both_attr));
+	 *	int f memb_attr;
+	 * } rec_attr both both_attr;
 	 */
 	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
 	ASSERT_EQ(id, 1, "int_id");
 	id = btf__add_typedef(btf, "td", 1);
 	ASSERT_EQ(id, 2, "td_id");
 	ASSERT_EQ(btf__add_decl_attr(btf, "t1", 2, -1), 3, "td_attr1");
-	/* no kflag: rendered as a btf_decl_tag(), not as a bare attribute */
+	/* no kflag: rendered as a btf_decl_tag() */
 	ASSERT_EQ(btf__add_decl_tag(btf, "t2", 2, -1), 4, "td_attr2");
 
 	id = btf__add_struct(btf, NULL, 4);
@@ -578,11 +580,11 @@ static void test_btf_dump_decl_tags_typedef(void)
 	ASSERT_EQ(btf__add_decl_attr(btf, "both_attr", 8, -1), 9, "both_attr");
 
 	test_ctx__dump_and_compare(&t,
-"typedef int td __attribute__((t1)) __attribute__((btf_decl_tag(\"t2\")));\n"
+"typedef int td t1 __attribute__((btf_decl_tag(\"t2\")));\n"
 "\n"
 "typedef struct {\n"
-"	int f __attribute__((memb_attr));\n"
-"} __attribute__((rec_attr)) both __attribute__((both_attr));\n"
+"	int f memb_attr;\n"
+"} rec_attr both both_attr;\n"
 "\n", "dump_and_compare");
 
 	test_ctx__free(&t);
@@ -603,7 +605,8 @@ static void test_btf_dump_type_tags(void)
 	 *
 	 * struct s {
 	 *   void __attribute__((btf_type_tag(\"void_tag\"))) *p1;
-	 *   void __attribute__((void_attr)) *p2;
+	 *   void __attribute__((aligned(8))) *p2;
+	 *   void __type_marker *p3;
 	 * };
 	 *
 	 */
@@ -613,22 +616,30 @@ static void test_btf_dump_type_tags(void)
 	id = btf__add_ptr(btf, id);
 	ASSERT_EQ(id, 2, "void_ptr_id1");
 
-	id = btf__add_type_attr(btf, "void_attr", 0);
+	id = btf__add_type_attr(btf, "__attribute__((aligned(8)))", 0);
 	ASSERT_EQ(id, 3, "type_attr_id");
 	id = btf__add_ptr(btf, id);
 	ASSERT_EQ(id, 4, "void_ptr_id2");
 
+	id = btf__add_type_attr(btf, "__type_marker", 0);
+	ASSERT_EQ(id, 5, "type_marker_id");
+	id = btf__add_ptr(btf, id);
+	ASSERT_EQ(id, 6, "void_ptr_id3");
+
 	id = btf__add_struct(btf, "s", 8);
-	ASSERT_EQ(id, 5, "struct_id");
+	ASSERT_EQ(id, 7, "struct_id");
 	err = btf__add_field(btf, "p1", 2, 0, 0);
 	ASSERT_OK(err, "field_ok1");
 	err = btf__add_field(btf, "p2", 4, 0, 0);
 	ASSERT_OK(err, "field_ok2");
+	err = btf__add_field(btf, "p3", 6, 0, 0);
+	ASSERT_OK(err, "field_ok3");
 
 	test_ctx__dump_and_compare(&t,
 "struct s {\n"
 "	void __attribute__((btf_type_tag(\"void_tag\"))) *p1;\n"
-"	void __attribute__((void_attr)) *p2;\n"
+"	void __attribute__((aligned(8))) *p2;\n"
+"	void __type_marker *p3;\n"
 "};\n\n", "dump_and_compare");
 
 	test_ctx__free(&t);
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index 3f9949e8227d..e96b209f3fe0 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -14,7 +14,7 @@
 
 #define DECL_TAG_FASTCALL "bpf_fastcall"
 #define DECL_TAG_KFUNC "bpf_kfunc"
-#define TYPE_ATTR_ARENA "address_space(1)"
+#define TYPE_ATTR_ARENA "__attribute__((address_space(1)))"
 #define ARENA_ARG(n) (1U << (n))
 
 #ifndef KF_FASTCALL
@@ -239,7 +239,7 @@ static void check_kfunc_set(struct btf_id_set8 *set)
 	}
 }
 
-/* True if @id is PTR -> TYPE_TAG(kflag=1, "address_space(1)") -> pointee */
+/* True if @id is PTR -> TYPE_TAG(kflag=1, TYPE_ATTR_ARENA) -> pointee */
 static bool is_arena_tagged_ptr(struct btf *btf, __u32 id)
 {
 	const struct btf_type *ptr, *tag;
-- 
2.56.0

