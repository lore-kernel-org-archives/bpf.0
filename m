Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.238
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403259;
	b=2z9b3ugjnyA2brEs66vwA6qiOqcZGZoLl7HcVectcP20NXmqnuuugN4Nkin//DTPGFs4
	 DTJ9+6OjJj3LFnUX8MNV7i8FVo8QW1zZgZlQ4QtLpeRfh5k5YTKbK0Y0ICmBVLJHhPMfy
	 Uy8zWFJbKk+Vk0znxiTRsGcywrexkWcTOoHWll/3RG4FM3N3n2x/fR7lWqlo4s+B7D6hr
	 GIeYFJ4Wh4ZS4DI6htJsbVIfhsxYTUl8Z7zTb65T95j77Rl/s7E2NrKDnKXfQS4X89dd3
	 uTx9aXFc7/kEmRG5ZEZHT5HGlOx5e+NRVEdKsSdNARTosUEKMKiTr61+4D1Tlnnk3fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403259;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3EypTRb7cNJl+viQhL/BoRXM94JQZ+XfFIw4kOb+gxM=;
	b=vz+I+oPBkydGbyG0gr01KoGEkbZF8Me52F+AvHGAD8BC6oRrZJsPoxONAzZ1V3wQ381P
	 UHVkpHM7LaqIQHVGQkPK1/0wZvW4r81l2nBh4WKe3FSv3GY8JUu4WPmsyH5XAXSlFPrMH
	 Gl8tr/XrgbmbmItLDzGXMAuDRzwbSGLBLt78ZvRXgjLY4pDmWLBpIe3iCFgmBcRdCJXyf
	 +mQxhZfmlSTA6OXs02gqD3iGYACvLNjXe9UqUSexQ7vaW5Tsu1tJAgyTKww7Sn2EgG8A7
	 3OS8H0NOspCAeUWh6wqq37PZWfdf3HMEXEcHcWkgUBU3eIRnbP5a/ZBjpN7Sc2Q4Bmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PPQwkgR6;
	arc=none smtp.remote-ip=95.215.58.238
Received: from mta1.migadu.com (out-238.mta1.migadu.com [95.215.58.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245B606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F245B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PPQwkgR6
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P0CARyTpjO/HgMgzeIXpZEtUxt8sPLEyR6jpEDkOTlU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403255; v=1; x=1794008055;
 b=PPQwkgR6uMzqXKZ8RulQg2IFOZTd5uRHB8OHk4zFn1WACWbtJVtKNFeLHT+09jq/hi60XBhR
 OW4r70zv2LvRfbVMDD8Ep1v0CXXAjblMhaK4IF8XozJy7i2m6SWOnhOP27wrRvITGsZK1X0aLFu
 biGZ4wS/rzvGfegqKK+2ZTKw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1a274865103c9d15;
	Fri, 30 Oct 2026 23:34:15 +0000
X-Mizu-Trace-ID: 1a274865103c9d15
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
Subject: [PATCH bpf-next v3 02/13] libbpf: Dump kflagged BTF tags as is
Date: Fri, 30 Oct 2026 16:33:44 -0700
Message-ID: <20261030233355.1836749-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
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

btf_dump wraps kflagged decl and type tag strings in an attribute
specifier. This unnecessarily limits how a BTF tag can be interpreted
by the consumers: only as an __attribute__.

Drop this limitation by printing the BTF tag's (with kflag=1) string
directly. This allows to dump an arbitrary identifier, and the
definition of that identifier can then be controlled by the end
consumer of the dump.

This change is backwards incompatible for the consumers expecting
__attribute__ wrapping to be applied by libbpf on dump. In-tree, only
resolve_btfids applying address_space(1) attribute is affected.

Fix resolve_btfids to encode the complete arena attribute specifier
with the renderer change.

Update the existing attribute tests.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/bpf/resolve_btfids/main.c               |  2 +-
 tools/lib/bpf/btf_dump.c                      |  4 +-
 .../selftests/bpf/prog_tests/btf_dump.c       | 91 +++++++++++--------
 .../selftests/bpf/prog_tests/btf_write.c      |  4 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |  4 +-
 5 files changed, 58 insertions(+), 47 deletions(-)

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
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index ea9a34db4c00..faa9aee52d74 100644
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
@@ -1594,7 +1594,7 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			btf_dump_emit_mods(d, decls);
 			name = btf_name_of(d, t->name_off);
 			if (btf_kflag(t))
-				btf_dump_printf(d, " __attribute__((%s))", name);
+				btf_dump_printf(d, " %s", name);
 			else if (strcmp(name, "arena") == 0)
 				/* the tag denotes a pointer into the BPF arena address space */
 				btf_dump_printf(d, " __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\")))");
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index dbef014f75ac..3b9cf564c35d 100644
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
 
+/* Bare annotation names in these fixtures stand for user-defined macros. */
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
@@ -603,8 +605,9 @@ static void test_btf_dump_type_tags(void)
 	 *
 	 * struct s {
 	 *   void __attribute__((btf_type_tag(\"void_tag\"))) *p1;
-	 *   void __attribute__((void_attr)) *p2;
+	 *   void __attribute__((aligned(8))) *p2;
 	 *   void __arena *p3;
+	 *   void __type_marker *p4;
 	 * };
 	 *
 	 * The arena tag is rendered with the address space it denotes.
@@ -615,7 +618,7 @@ static void test_btf_dump_type_tags(void)
 	id = btf__add_ptr(btf, id);
 	ASSERT_EQ(id, 2, "void_ptr_id1");
 
-	id = btf__add_type_attr(btf, "void_attr", 0);
+	id = btf__add_type_attr(btf, "__attribute__((aligned(8)))", 0);
 	ASSERT_EQ(id, 3, "type_attr_id");
 	id = btf__add_ptr(btf, id);
 	ASSERT_EQ(id, 4, "void_ptr_id2");
@@ -625,20 +628,28 @@ static void test_btf_dump_type_tags(void)
 	id = btf__add_ptr(btf, id);
 	ASSERT_EQ(id, 6, "void_ptr_id3");
 
-	id = btf__add_struct(btf, "s", 24);
-	ASSERT_EQ(id, 7, "struct_id");
+	id = btf__add_type_attr(btf, "__type_marker", 0);
+	ASSERT_EQ(id, 7, "type_marker_id");
+	id = btf__add_ptr(btf, id);
+	ASSERT_EQ(id, 8, "void_ptr_id4");
+
+	id = btf__add_struct(btf, "s", 32);
+	ASSERT_EQ(id, 9, "struct_id");
 	err = btf__add_field(btf, "p1", 2, 0, 0);
 	ASSERT_OK(err, "field_ok1");
 	err = btf__add_field(btf, "p2", 4, 64, 0);
 	ASSERT_OK(err, "field_ok2");
 	err = btf__add_field(btf, "p3", 6, 128, 0);
 	ASSERT_OK(err, "field_ok3");
+	err = btf__add_field(btf, "p4", 8, 192, 0);
+	ASSERT_OK(err, "field_ok4");
 
 	test_ctx__dump_and_compare(&t,
 "struct s {\n"
 "	void __attribute__((btf_type_tag(\"void_tag\"))) *p1;\n"
-"	void __attribute__((void_attr)) *p2;\n"
+"	void __attribute__((aligned(8))) *p2;\n"
 "	void __attribute__((address_space(1))) __attribute__((btf_type_tag(\"arena\"))) *p3;\n"
+"	void __type_marker *p4;\n"
 "};\n\n", "dump_and_compare");
 
 	test_ctx__free(&t);
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/testing/selftests/bpf/prog_tests/btf_write.c
index 3bed3a28c06a..9d295ea22b33 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -620,7 +620,7 @@ static void test_btf_attrs(void)
 
 	btf__add_decl_tag(btf, "tag", 2, -1);
 	btf__add_decl_attr(btf, "tag", 2, -1);
-	btf__add_decl_attr(btf, "member_attr", 2, 0);
+	btf__add_decl_attr(btf, "__attribute__((aligned(4)))", 2, 0);
 	btf__add_type_tag(btf, "tag", 1);
 	btf__add_type_attr(btf, "tag", 1);
 
@@ -631,7 +631,7 @@ static void test_btf_attrs(void)
 		"\t'f' type_id=1 bits_offset=0",
 		"[3] DECL_TAG 'tag' type_id=2 component_idx=-1",
 		"[4] DECL_TAG 'tag' type_id=2 component_idx=-1 kflag=1",
-		"[5] DECL_TAG 'member_attr' type_id=2 component_idx=0 kflag=1",
+		"[5] DECL_TAG '__attribute__((aligned(4)))' type_id=2 component_idx=0 kflag=1",
 		"[6] TYPE_TAG 'tag' type_id=1",
 		"[7] TYPE_TAG 'tag' type_id=1 kflag=1");
 
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

