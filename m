Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211430;
	b=hVGoMa0xKW1uAxUTYnV7EnU1rPxHANkKzQjIrUm3z/AQtJvxREL7B9UhHc7thV5gdADj
	 BDzcoG44iYK6ZB69Juug1JUkJEW2ZZ2nMHo6fQr2mXuxBy0GuOH50lkQcsJvvXL9JLSXW
	 vKR5URadG9AIPZcDgo30mTo11jU9RK0/WH9p732eJ7NwzEbzb5wONzJRUWbSJzh9+Y0t7
	 zMXi0yLdu6sdSHA+8MFLodIdv5MmH28tZBpLm7wsYWmFJYrHo/JVAu9E4K13gLeiMbmy7
	 yyQMJTwRccLw/fvNN4A1JOTkOgX9VM0b8CdznTLryRTA+4AoZBdjxPHtFxpskObsJ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211430;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3r6Oem1VP8WKmOv5fB4zxrLUZwlo7qeVcnw4NnCpCg8=;
	b=3FzcLzJ09N3h+H2DBrtYrGLbASXEGquBkoJb8LYyEIkKYlcsK5ka30nxo7M9pgIzO/f5
	 2rsNQUCDyjjOmF1i9wHT2XJElGeIxvK0Um8KwzMZwA125OGfvzulkORHIm4yUTBPwgNqu
	 GwjrwOiFTRC+5MqteUnvOQdcrKA+xNENY26ukk8FvM9rfcVHNTU6MzW6X0t1vudGYT6gp
	 BU86ogdsHyK5Z6ZHRmjvL/YVlavWl1VrnT6pfQjGyfa3mm9qxt856tmO7arXBpzJKWSzd
	 3As9AMkc6fQATZrG7vrKg//LEC72rZlAwnKse0tL7K85GZcb3qSmfrctf7EiNro7EEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.181
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2C360A2609
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB2C360A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id DE6105940555D; Fri, 20 Nov 2026 13:50:12 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Test CO-RE relocations of signed enum values without kflag
Date: Fri, 20 Nov 2026 13:50:12 -0800
Message-ID: <20261120215012.870499-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261120214957.868409-1-yonghong.song@linux.dev>
References: <20261120214957.868409-1-yonghong.song@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The libbpf fix takes a 32-bit target enum value with the kflag 0 as
signed if the local enum is signed, since the BTF of a kernel before
v6.0 has the kflag 0 on every enum, signed or not. Test it.

test_core_reloc_enumval gets an optional signed local enum,
named_int_enum, with the values -1 and 1, so the enum is signed while
one of its values is not negative. The enumval target has the same enum
with the values -2 and -3, which are expected sign-extended in the
64-bit outputs.

The new test case enumval___no_kflag has the same target types, but its
target BTF gets the kflag of every enum cleared, as in the BTF of a
kernel before v6.0. The signed enum then gets its signedness from the
local enum. The test writes the modified BTF to a temporary file: one
it creates itself in core_reloc, or the one btfgen already created in
core_reloc_btfgen. The cleanup now removes the temporary file if the
test case clears the kflag, not only if btfgen runs.

GCC's __builtin_preserve_enum_value() returns int, so with GCC the
stores sign-extend the values anyway.

Without taking the signedness from the local enum, the upper 32 bits of
both values are zero in enumval___no_kflag:

  run_core_reloc_tests:FAIL:check_result input/output data don't match
  output byte #44: EXP 0xff GOT 0x00
  ...
  output byte #55: EXP 0xff GOT 0x00
  #122/72  core_reloc/enumval___no_kflag:FAIL

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 90 ++++++++++++++++++-
 .../btf__core_reloc_enumval___no_kflag.c      |  3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 16 ++++
 .../bpf/progs/test_core_reloc_enumval.c       | 14 +++
 4 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___no_kflag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index 98b3c5fb1028..1c502e7f0c60 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -370,6 +370,14 @@ static int duration =3D 0;
 	.fails =3D true,							\
 }
=20
+#define ENUMVAL_NO_KFLAG_CASE(name, ...) {				\
+	ENUMVAL_CASE_COMMON(name),					\
+	.output =3D STRUCT_TO_CHAR_PTR(core_reloc_enumval_output)		\
+			__VA_ARGS__,					\
+	.output_len =3D sizeof(struct core_reloc_enumval_output),		\
+	.clear_enum_kflag =3D true,					\
+}
+
 #define ENUM64VAL_CASE_COMMON(name)					\
 	.case_name =3D #name,						\
 	.bpf_obj_file =3D "test_core_reloc_enum64val.bpf.o",		\
@@ -406,6 +414,7 @@ struct core_reloc_test_case {
 	bool run_btfgen_fails;
 	bool needs_testmod;
 	bool relaxed_core_relocs;
+	bool clear_enum_kflag;
 	const char *prog_name;
 	const char *raw_tp_name;
 	setup_test_fn setup;
@@ -906,6 +915,24 @@ static const struct core_reloc_test_case test_cases[=
] =3D {
 		.anon_val2 =3D 0x20,
 		.uint_val1 =3D 0x80000001,
 		.uint_val2 =3D 0xffffffff,
+		.int_val1 =3D -2,
+		.int_val2 =3D -3,
+	}),
+	ENUMVAL_NO_KFLAG_CASE(enumval___no_kflag, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D true,
+		.anon_val1_exists =3D true,
+		.anon_val2_exists =3D true,
+		.anon_val3_exists =3D true,
+		.named_val1 =3D 1,
+		.named_val2 =3D 2,
+		.anon_val1 =3D 0x10,
+		.anon_val2 =3D 0x20,
+		.uint_val1 =3D 0x80000001,
+		.uint_val2 =3D 0xffffffff,
+		.int_val1 =3D -2,
+		.int_val2 =3D -3,
 	}),
 	ENUMVAL_CASE(enumval___diff, {
 		.named_val1_exists =3D true,
@@ -999,6 +1026,46 @@ static int run_btfgen(const char *src_btf, const ch=
ar *dst_btf, const char *objp
 	return run_bpftool_command(args);
 }
=20
+/*
+ * Write the BTF of src to dst with the kflag of every enum cleared, as =
in the
+ * BTF of a kernel before v6.0, where the kflag 0 doesn't mean unsigned.
+ */
+static int write_btf_no_enum_kflag(const char *src, const char *dst)
+{
+	const void *raw_data;
+	struct btf_type *t;
+	struct btf *btf;
+	__u32 i, n, raw_sz;
+	FILE *f =3D NULL;
+	int err =3D -1;
+
+	btf =3D btf__parse(src, NULL);
+	if (!ASSERT_OK_PTR(btf, "btf_parse"))
+		return -1;
+
+	n =3D btf__type_cnt(btf);
+	for (i =3D 1; i < n; i++) {
+		t =3D (struct btf_type *)btf__type_by_id(btf, i);
+		if (btf_is_enum(t))
+			t->info &=3D ~(1U << 31); /* the kflag */
+	}
+
+	raw_data =3D btf__raw_data(btf, &raw_sz);
+	if (!ASSERT_OK_PTR(raw_data, "btf_raw_data"))
+		goto out;
+	f =3D fopen(dst, "w");
+	if (!ASSERT_OK_PTR(f, "btf_fopen"))
+		goto out;
+	if (!ASSERT_EQ(fwrite(raw_data, 1, raw_sz, f), raw_sz, "btf_write"))
+		goto out;
+	err =3D 0;
+out:
+	if (f)
+		fclose(f);
+	btf__free(btf);
+	return err;
+}
+
 static void run_core_reloc_tests(bool use_btfgen)
 {
 	const size_t mmap_sz =3D roundup_page(sizeof(struct data));
@@ -1050,6 +1117,25 @@ static void run_core_reloc_tests(bool use_btfgen)
 			test_case->btf_src_file =3D btf_file;
 		}
=20
+		/*
+		 * Without btfgen, create the temporary file here; with btfgen,
+		 * rewrite the one btfgen made.
+		 */
+		if (test_case->clear_enum_kflag) {
+			if (!use_btfgen) {
+				fd =3D mkstemp(btf_file);
+				if (!ASSERT_GE(fd, 0, "btf_tmp"))
+					continue;
+				close(fd); /* we only need the path */
+			}
+			err =3D write_btf_no_enum_kflag(test_case->btf_src_file, btf_file);
+			if (err) {
+				remove(btf_file);
+				continue;
+			}
+			test_case->btf_src_file =3D btf_file;
+		}
+
 		if (test_case->setup) {
 			err =3D test_case->setup(test_case);
 			if (CHECK(err, "test_setup", "test #%d setup failed: %d\n", i, err))
@@ -1141,8 +1227,8 @@ static void run_core_reloc_tests(bool use_btfgen)
 			CHECK_FAIL(munmap(mmap_data, mmap_sz));
 			mmap_data =3D NULL;
 		}
-		if (use_btfgen)
-			remove(test_case->btf_src_file);
+		if (use_btfgen || test_case->clear_enum_kflag)
+			remove(btf_file);
 		bpf_link__destroy(link);
 		link =3D NULL;
 		bpf_object__close(obj);
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
no_kflag.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
no_kflag.c
new file mode 100644
index 000000000000..f34e3e342efb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___no_kfla=
g.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___no_kflag x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
index 6d758e74bd58..35beb76068bd 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -1217,6 +1217,8 @@ struct core_reloc_enumval_output {
 	int anon_val2;
 	long uint_val1;
 	long uint_val2;
+	long int_val1;
+	long int_val2;
 };
=20
 struct core_reloc_enum64val_output {
@@ -1250,10 +1252,24 @@ enum named_uint_enum {
 	UINT_ENUM_VAL2 =3D 0xffffffff,
 };
=20
+enum named_int_enum {
+	INT_ENUM_VAL1 =3D -2,
+	INT_ENUM_VAL2 =3D -3,
+};
+
 struct core_reloc_enumval {
 	enum named_enum f1;
 	anon_enum f2;
 	enum named_uint_enum f3;
+	enum named_int_enum f4;
+};
+
+/* the same types, whose BTF gets the kflag of every enum cleared */
+struct core_reloc_enumval___no_kflag {
+	enum named_enum f1;
+	anon_enum f2;
+	enum named_uint_enum f3;
+	enum named_int_enum f4;
 };
=20
 enum named_unsigned_enum64 {
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c =
b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
index 8b8abbaaf533..a524e5028c77 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
@@ -33,6 +33,12 @@ enum named_uint_enum {
 	UINT_ENUM_VAL2 =3D 0xfffffff0,
 };
=20
+/* signed 4-byte enum, with a non-negative value too */
+enum named_int_enum {
+	INT_ENUM_VAL1 =3D -1,
+	INT_ENUM_VAL2 =3D 1,
+};
+
 struct core_reloc_enumval_output {
 	bool named_val1_exists;
 	bool named_val2_exists;
@@ -47,6 +53,8 @@ struct core_reloc_enumval_output {
 	int anon_val2;
 	long uint_val1;
 	long uint_val2;
+	long int_val1;
+	long int_val2;
 };
=20
 #ifdef __clang__
@@ -85,6 +93,12 @@ int test_core_enumval(void *ctx)
 		out->uint_val1 =3D UINT_ENUM_VALUE(UINT_ENUM_VAL1);
 	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL2))
 		out->uint_val2 =3D UINT_ENUM_VALUE(UINT_ENUM_VAL2);
+
+	/* enum named_int_enum is optional */
+	if (bpf_core_enum_value_exists(enum named_int_enum, INT_ENUM_VAL1))
+		out->int_val1 =3D bpf_core_enum_value(enum named_int_enum, INT_ENUM_VA=
L1);
+	if (bpf_core_enum_value_exists(enum named_int_enum, INT_ENUM_VAL2))
+		out->int_val2 =3D bpf_core_enum_value(enum named_int_enum, INT_ENUM_VA=
L2);
 #else
 	data.skip =3D true;
 #endif
--=20
2.53.1-Meta

