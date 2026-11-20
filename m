Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193760;
	b=IHwcqHuZhFZRRCcjMZPsWE2SoFwB3gti5FIl0yClMR1oKe0cUkv7d104Z+oGKSIy8tOE
	 i+Jw15ebUclVZBECUNHn9IaJib+F2ZQnFgG+gzCw6osYYrnAz7k/Hjx6QON5nDgFMETSu
	 v6L7grewk83Z1iIq3Dr9Cg6fwViv65basb4zyBYihKjILxPq4kicvf43u9ZypQHEbz0bd
	 qrExrYDdZjX2IJOI5vLf5/u9XTaERog+lHYjZQ9+N4P3aWS9NLPnR2P77fMXq6LxHYBBZ
	 zX1vIrn3KstwrwNXStkvOD/WPeqp3z9ywrWihO1UFphB+tbDTglnkrfU39XF07OAosQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193760;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e+Et1QkyQpw8ACVi1b3VK5MQFSTIOgA8OXmYXl4I2mQ=;
	b=HJH3iE35L7IRKkgt8r9KETekBAOYNf8+IINmXNekd+J353xxxe+ClgKM2K1fTfb1u6tv
	 VrSY6D+TtGZ/Sd0cjPoxWo7RtU9rFBVFXID6WBGYX2lrQV2mEoj2koAWP5ebprPHyf0pC
	 M/481SMpjv0ZD0mnEK2Gl94x+l/Hw2QdF+fZwvbwGbGN/iYE6HIbfv6G2RwEJSCej0y8e
	 ugmOvDnb5LiyJS9LWG1s5GCWAgfaSa1dTA/YGiJrmlQc8x38H+4jgG1EJ7G4OxiBwH2HV
	 jL+LmwnqI7Oj8NJm34YvFpiRfMKXE373UVmEiQoxbiSx53SGiPqAwa8cFLGvQqjiWcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.178
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A460A261E
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 16:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43A460A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id D880D59328DF2; Fri, 20 Nov 2026 08:55:50 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 2/3] selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values
Date: Fri, 20 Nov 2026 08:55:50 -0800
Message-ID: <20261120165550.2074913-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261120165540.2074139-1-yonghong.song@linux.dev>
References: <20261120165540.2074139-1-yonghong.song@linux.dev>
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

Test the extension of unsigned 32-bit enum values in CO-RE relocations
from the previous patch.

test_core_reloc_enumval gets an optional local enum with values out of
the range of int, i.e., an unsigned 4-byte enum, whose values clang
emits zero-extended in the ld_imm64 of the relocations. The enumval
target has the same enum with different values, 0x80000001 and
0xffffffff, which are expected zero-extended in the 64-bit outputs.

GCC's __builtin_preserve_enum_value() returns int, so storing the value
of enum named_uint_enum into a long field sign-extends it, and uint_val1
would read back as 0xffffffff80000001. Convert the result to unsigned
int for GCC to get the enumerator value. Clang still stores the 64-bit
relocated value, so its upper 32 bits keep being checked.

Without the fix, the check of the original value fails, and the whole
object is refused:

  libbpf: prog 'test_core_enumval': relo #11: unexpected insn #53 (LDIMM6=
4)
          value: got 2147483648, exp 18446744071562067968 -> 184467440715=
62067969
  libbpf: prog 'test_core_enumval': relo #11: failed to patch insn #53: -=
EINVAL
  #122/71  core_reloc/enumval:FAIL

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/core_reloc.c     |  2 ++
 .../selftests/bpf/progs/core_reloc_types.h    |  8 +++++++
 .../bpf/progs/test_core_reloc_enumval.c       | 21 +++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index 80432c4656b5..98b3c5fb1028 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -904,6 +904,8 @@ static const struct core_reloc_test_case test_cases[]=
 =3D {
 		.named_val2 =3D 2,
 		.anon_val1 =3D 0x10,
 		.anon_val2 =3D 0x20,
+		.uint_val1 =3D 0x80000001,
+		.uint_val2 =3D 0xffffffff,
 	}),
 	ENUMVAL_CASE(enumval___diff, {
 		.named_val1_exists =3D true,
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
index 5760ae015e09..6d758e74bd58 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -1215,6 +1215,8 @@ struct core_reloc_enumval_output {
 	int named_val2;
 	int anon_val1;
 	int anon_val2;
+	long uint_val1;
+	long uint_val2;
 };
=20
 struct core_reloc_enum64val_output {
@@ -1243,9 +1245,15 @@ typedef enum {
 	ANON_ENUM_VAL3 =3D 0x30,
 } anon_enum;
=20
+enum named_uint_enum {
+	UINT_ENUM_VAL1 =3D 0x80000001,
+	UINT_ENUM_VAL2 =3D 0xffffffff,
+};
+
 struct core_reloc_enumval {
 	enum named_enum f1;
 	anon_enum f2;
+	enum named_uint_enum f3;
 };
=20
 enum named_unsigned_enum64 {
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c =
b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
index e7ef3dada2bf..8b8abbaaf533 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
@@ -27,6 +27,12 @@ typedef enum {
 	ANON_ENUM_VAL3 =3D 0x30,
 } anon_enum;
=20
+/* 4-byte enum with values out of the range of int, so it is unsigned */
+enum named_uint_enum {
+	UINT_ENUM_VAL1 =3D 0x80000000,
+	UINT_ENUM_VAL2 =3D 0xfffffff0,
+};
+
 struct core_reloc_enumval_output {
 	bool named_val1_exists;
 	bool named_val2_exists;
@@ -39,8 +45,17 @@ struct core_reloc_enumval_output {
 	int named_val2;
 	int anon_val1;
 	int anon_val2;
+	long uint_val1;
+	long uint_val2;
 };
=20
+#ifdef __clang__
+#define UINT_ENUM_VALUE(v) bpf_core_enum_value(enum named_uint_enum, v)
+#else
+/* GCC's __builtin_preserve_enum_value() returns int */
+#define UINT_ENUM_VALUE(v) ((unsigned int)bpf_core_enum_value(enum named=
_uint_enum, v))
+#endif
+
 SEC("raw_tracepoint/sys_enter")
 int test_core_enumval(void *ctx)
 {
@@ -64,6 +79,12 @@ int test_core_enumval(void *ctx)
 	out->anon_val1 =3D bpf_core_enum_value(anon, ANON_ENUM_VAL1);
 	out->anon_val2 =3D bpf_core_enum_value(anon, ANON_ENUM_VAL2);
 	/* ANON_ENUM_VAL3 value is optional */
+
+	/* enum named_uint_enum is optional */
+	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL1))
+		out->uint_val1 =3D UINT_ENUM_VALUE(UINT_ENUM_VAL1);
+	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL2))
+		out->uint_val2 =3D UINT_ENUM_VALUE(UINT_ENUM_VAL2);
 #else
 	data.skip =3D true;
 #endif
--=20
2.53.1-Meta

