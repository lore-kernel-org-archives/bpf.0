Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715786;
	b=o4my0yrF5mvnik0LKFlgbYI8hrvh+UQpihInPQc9LOdevfVFVgzstEoXg6jN1VOIOaow
	 8sTOtQriXH6AxXDuCmgLHPtmtML5opoFn10IT1XXaH6d3r2j3cd9TR4n3XfAk4Nj8G1WE
	 AeYmNEZXjfZA6qF8ovG76/J6YOLkrRXiQqaOpSTfvSdNHNlyVcGJM5Z901+zg4NNEzoRN
	 FhK4toZTRo/B8+/o5uAs2cpINez67gI+Zj7Kj4pnZJUxO142QEYdtHmyn6vCIhK8fDGS9
	 WQOYKrmfnrFnvBREBdjkEQkHYWd8qiSxYnk23ibRaaeK/hRxOMla15Jz//LKYnRLC6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715786;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=opxYNoy6HoZG17lCo8v/5fbf6VjWBBtNt4OPGt4njB8=;
	b=JM+Tn5X+OTBS757BfLM+w+nXAMsNgky2KCqasYX5aCX1y76/ryntelxXXXyDaMAMgJs+
	 /txyv9gsqgno+JsyKOtXeBReiMVJermoLOJYpvW4Gy9aA+swNDwXoz3j3MzHt7GtP2DrX
	 wRX//HituMqL0WxIijBA2+hoLJOGB+80k+H+s4kWIM5o85ODaVJ0jOPjrEakhzBuCG5PW
	 KCXuIoNv2mizL4lqnpIjgOTRBFfm8Ttujc2h/zQDxi0Uer5IQKoChiCKfEuakDzn46iOl
	 tu53pV/cdjt5DvNVH2xCSqfpiu+scdqlFN4xkQfXYd3Y0D+ey6xLfsX9M+VA2BHqR7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.179
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE932606A32A
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 17:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE932606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 0879459E04796; Thu, 26 Nov 2026 09:56:13 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/3] selftests/bpf: Test enum value relocations within the local enumerator range
Date: Thu, 26 Nov 2026 09:56:12 -0800
Message-ID: <20261126175613.1883881-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261126175602.1882988-1-yonghong.song@linux.dev>
References: <20261126175602.1882988-1-yonghong.song@linux.dev>
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

Test the previous patch with enum value relocations whose target value
is within the range of the type of the local enumerator, so they are
still relocated, even where the target enum differs from the local one
in size or value range.

test_core_reloc_enumval gets a local 1-byte enum with the packed
attribute. Its values are read only if the target has the enum, guarded
by bpf_core_enum_value_exists(), so targets without the enum are not
affected. The local values fit in int, so the enumerators are int, and
a target value out of a byte is relocated. The enumval target gets the
same enum, also packed.

New core_reloc cases, with the target enums in the shapes the kernel
has:
  - enumval___enum64: the target enums are 8 bytes, but the relocated
    values fit in int, so they work as before.
  - enumval___negative: a negative target value for an int enumerator
    is relocated.
  - enumval___byte_unpacked: 0x100 for an enumerator of the local 1-byte
    enum, from a 4-byte target enum, is relocated.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 40 +++++++++++++
 .../btf__core_reloc_enumval___byte_unpacked.c |  3 +
 .../progs/btf__core_reloc_enumval___enum64.c  |  3 +
 .../btf__core_reloc_enumval___negative.c      |  3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 56 ++++++++++++++++++-
 .../bpf/progs/test_core_reloc_enumval.c       | 14 +++++
 6 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___byte_unpacked.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___enum64.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___negative.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index 98b3c5fb1028..bb468f3764e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -904,6 +904,8 @@ static const struct core_reloc_test_case test_cases[]=
 =3D {
 		.named_val2 =3D 2,
 		.anon_val1 =3D 0x10,
 		.anon_val2 =3D 0x20,
+		.byte_val1 =3D 0x11,
+		.byte_val2 =3D 0xff,
 		.uint_val1 =3D 0x80000001,
 		.uint_val2 =3D 0xffffffff,
 	}),
@@ -932,6 +934,44 @@ static const struct core_reloc_test_case test_cases[=
] =3D {
 		.anon_val2 =3D 0x222,
 	}),
 	ENUMVAL_ERR_CASE(enumval___err_missing),
+	ENUMVAL_CASE(enumval___enum64, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D true,
+		.anon_val1_exists =3D true,
+		.anon_val2_exists =3D true,
+		.anon_val3_exists =3D true,
+		.named_val1 =3D 1001,
+		.named_val2 =3D 2002,
+		.anon_val1 =3D 0x11,
+		.anon_val2 =3D 0x22,
+	}),
+	ENUMVAL_CASE(enumval___negative, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D true,
+		.anon_val1_exists =3D true,
+		.anon_val2_exists =3D true,
+		.anon_val3_exists =3D true,
+		.named_val1 =3D 1,
+		.named_val2 =3D 2,
+		.anon_val1 =3D -0x10,
+		.anon_val2 =3D 0x20,
+	}),
+	ENUMVAL_CASE(enumval___byte_unpacked, {
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
+		.byte_val1 =3D 0x11,
+		.byte_val2 =3D 0x100,
+	}),
=20
 	/* 64bit enumerator value existence and value relocations */
 	ENUM64VAL_CASE(enum64val, {
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
byte_unpacked.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumv=
al___byte_unpacked.c
new file mode 100644
index 000000000000..4650a050bc5d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___byte_un=
packed.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___byte_unpacked x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
enum64.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___en=
um64.c
new file mode 100644
index 000000000000..6af92c96993e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___enum64.=
c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___enum64 x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
negative.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
negative.c
new file mode 100644
index 000000000000..3028b0b86ccf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___negativ=
e.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___negative x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
index 6d758e74bd58..116a67fdd1b2 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -1215,6 +1215,8 @@ struct core_reloc_enumval_output {
 	int named_val2;
 	int anon_val1;
 	int anon_val2;
+	int byte_val1;
+	int byte_val2;
 	long uint_val1;
 	long uint_val2;
 };
@@ -1245,6 +1247,11 @@ typedef enum {
 	ANON_ENUM_VAL3 =3D 0x30,
 } anon_enum;
=20
+enum named_byte_enum {
+	BYTE_ENUM_VAL1 =3D 0x11,
+	BYTE_ENUM_VAL2 =3D 0xff,
+} __attribute__((packed));
+
 enum named_uint_enum {
 	UINT_ENUM_VAL1 =3D 0x80000001,
 	UINT_ENUM_VAL2 =3D 0xffffffff,
@@ -1253,7 +1260,8 @@ enum named_uint_enum {
 struct core_reloc_enumval {
 	enum named_enum f1;
 	anon_enum f2;
-	enum named_uint_enum f3;
+	enum named_byte_enum f3;
+	enum named_uint_enum f4;
 };
=20
 enum named_unsigned_enum64 {
@@ -1355,6 +1363,52 @@ struct core_reloc_enumval___err_missing {
 	anon_enum___err_missing f2;
 };
=20
+/* 8-byte target enums, whose relocated values fit in the int enumerator=
s of
+ * the local enums
+ */
+enum named_enum___enum64 {
+	NAMED_ENUM_VAL1___enum64 =3D 1001,
+	NAMED_ENUM_VAL2___enum64 =3D 2002,
+	NAMED_ENUM_VAL3___enum64 =3D 0x300000000ULL,
+};
+
+typedef enum {
+	ANON_ENUM_VAL1___enum64 =3D 0x11,
+	ANON_ENUM_VAL2___enum64 =3D 0x22,
+	ANON_ENUM_VAL3___enum64 =3D 0x300000000ULL,
+} anon_enum___enum64;
+
+struct core_reloc_enumval___enum64 {
+	enum named_enum___enum64 f1;
+	anon_enum___enum64 f2;
+};
+
+/* negative value for an int enumerator */
+typedef enum {
+	ANON_ENUM_VAL1___negative =3D -0x10,
+	ANON_ENUM_VAL2___negative =3D 0x20,
+	ANON_ENUM_VAL3___negative =3D 0x30,
+} anon_enum___negative;
+
+struct core_reloc_enumval___negative {
+	enum named_enum f1;
+	anon_enum___negative f2;
+};
+
+/* 4-byte target enum with a value out of a byte, for the int enumerator=
s of
+ * the local 1-byte enum
+ */
+enum named_byte_enum___byte_unpacked {
+	BYTE_ENUM_VAL1___byte_unpacked =3D 0x11,
+	BYTE_ENUM_VAL2___byte_unpacked =3D 0x100,
+};
+
+struct core_reloc_enumval___byte_unpacked {
+	enum named_enum f1;
+	anon_enum f2;
+	enum named_byte_enum___byte_unpacked f3;
+};
+
 enum named_unsigned_enum64___err_missing {
 	UNSIGNED_ENUM64_VAL1___err_missing =3D 0x1ffffffffULL,
 	UNSIGNED_ENUM64_VAL3___err_missing =3D 0x3ffffffffULL,
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c =
b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
index 9933eadc2993..7ec4ff990cb3 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
@@ -27,6 +27,12 @@ typedef enum {
 	ANON_ENUM_VAL3 =3D 0x30,
 } anon_enum;
=20
+/* 1-byte enum, whose values fit in int, so its enumerators are int */
+enum named_byte_enum {
+	BYTE_ENUM_VAL1 =3D 1,
+	BYTE_ENUM_VAL2 =3D 2,
+} __attribute__((packed));
+
 /* 4-byte enum with values out of the range of int, so it is unsigned */
 enum named_uint_enum {
 	UINT_ENUM_VAL1 =3D 0x80000000,
@@ -45,6 +51,8 @@ struct core_reloc_enumval_output {
 	int named_val2;
 	int anon_val1;
 	int anon_val2;
+	int byte_val1;
+	int byte_val2;
 	long uint_val1;
 	long uint_val2;
 };
@@ -73,6 +81,12 @@ int test_core_enumval(void *ctx)
 	out->anon_val2 =3D bpf_core_enum_value(anon, ANON_ENUM_VAL2);
 	/* ANON_ENUM_VAL3 value is optional */
=20
+	/* enum named_byte_enum is optional */
+	if (bpf_core_enum_value_exists(enum named_byte_enum, BYTE_ENUM_VAL1))
+		out->byte_val1 =3D bpf_core_enum_value(enum named_byte_enum, BYTE_ENUM=
_VAL1);
+	if (bpf_core_enum_value_exists(enum named_byte_enum, BYTE_ENUM_VAL2))
+		out->byte_val2 =3D bpf_core_enum_value(enum named_byte_enum, BYTE_ENUM=
_VAL2);
+
 	/* enum named_uint_enum is optional */
 #ifdef __clang__
 	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL1))
--=20
2.53.1-Meta

