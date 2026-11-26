Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715786;
	b=coFcbIq4HzNu2YnPEgn1QI/wqtvBvtJrHtS06i18GetQ4/CEp8CalPSippt8HLL2hQn9
	 LBVHBZhSVQoCeN1K2lx4OxlcbnHCkyleLMNQ5Q6+9W9ERH8N70ZnMN5WTG7bMOKof9F2m
	 KgkvjeQk931UHMAMm8LfCsD1/nGDyAjOfJECkCRXNBthsNTxBb9n8ogckFtGKJ58qYWw4
	 FGBYa445g21Ed27/j99G6D0LfZqrY0bXJQLDOColXJzN27sXn4Y3d2dVIKkY3JC3XiSJS
	 msjcmk/2GAaULR/imVcXEWtbg0opAViLA3M9poWi2icNrKBFA0RZylEHToeuV7E154w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715786;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4wlmfNJVHGdZjzrbHvvbDxWdfrlIpoBVdmNKlmVs67g=;
	b=gX3qN6do3PNM6oRmFIEVTmJQBHjK7RRO04OpBxb9vmdnSTuciEC/JOhVWJwZVi/cp7qJ
	 dfGXbzzLHygmylIeyYfITWa3/e20/FhEd8IEriEYo0e+Dj9v9FQzx8ap3mMIzHP0jlnRe
	 8RTjEUTmQv8slebc/8nPRSKtsxa6PutEj70xqceaoJ4Xd4d+oT/LkenBavuyn0DSIJI3V
	 tDoqKLg5GaUPO4HRbcqJmwsi85RAMb66TFZRVYL/L766jJff0QXwXoffRSkXonrX3JYFU
	 gRYyWVZliHU1FNdVgzhEyh5rhgI7DZX86o2Tlceo1/wsjt2TgXXExizihRkk+Q54Fow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.179
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8A2606A327
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 17:56:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8A2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 2BAB659E047C3; Thu, 26 Nov 2026 09:56:18 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test enum value relocations out of the local enumerator range
Date: Thu, 26 Nov 2026 09:56:18 -0800
Message-ID: <20261126175618.1884490-1-yonghong.song@linux.dev>
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

Test the libbpf patch, which poisons an enum value relocation whose
target value is out of the range of the type of the local enumerator.
In each new core_reloc case, the poisoned instruction is reachable, so
the load fails:
  - enumval___err_too_big: 0x200000000 for an int enumerator, from an
    8-byte target enum.
  - enumval___err_too_small: -0x100000000 for an int enumerator, from a
    signed 8-byte target enum.
  - enumval___err_int: 0x80000000 for an int enumerator, from an
    unsigned 4-byte target enum.
  - enumval___err_uint: 0x100000000 for an unsigned int enumerator, from
    an 8-byte target enum.
  - enum64val___err_sign: 0x8000000000000000 for a long enumerator, from
    an unsigned 8-byte target enum.

With GCC, the values of enum named_uint_enum are not read, and the
enumval___err_uint case is skipped, as for the enumval case, and so is
enum64val___err_sign, as for all enum64val cases.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/core_reloc.c     |  5 ++
 .../btf__core_reloc_enum64val___err_sign.c    |  3 +
 .../progs/btf__core_reloc_enumval___err_int.c |  3 +
 .../btf__core_reloc_enumval___err_too_big.c   |  3 +
 .../btf__core_reloc_enumval___err_too_small.c |  3 +
 .../btf__core_reloc_enumval___err_uint.c      |  3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 70 +++++++++++++++++++
 7 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val___err_sign.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_int.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_too_big.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_too_small.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_uint.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index bb468f3764e6..580db3266401 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -972,6 +972,10 @@ static const struct core_reloc_test_case test_cases[=
] =3D {
 		.byte_val1 =3D 0x11,
 		.byte_val2 =3D 0x100,
 	}),
+	ENUMVAL_ERR_CASE(enumval___err_too_big),
+	ENUMVAL_ERR_CASE(enumval___err_too_small),
+	ENUMVAL_ERR_CASE(enumval___err_int),
+	ENUMVAL_ERR_CASE(enumval___err_uint),
=20
 	/* 64bit enumerator value existence and value relocations */
 	ENUM64VAL_CASE(enum64val, {
@@ -1011,6 +1015,7 @@ static const struct core_reloc_test_case test_cases=
[] =3D {
 		.signed_val2 =3D -222,
 	}),
 	ENUM64VAL_ERR_CASE(enum64val___err_missing),
+	ENUM64VAL_ERR_CASE(enum64val___err_sign),
 };
=20
 struct data {
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val_=
__err_sign.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64va=
l___err_sign.c
new file mode 100644
index 000000000000..81cfed621a94
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___err_s=
ign.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enum64val___err_sign x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
err_int.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___e=
rr_int.c
new file mode 100644
index 000000000000..8235eb7f303d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___err_int=
.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___err_int x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
err_too_big.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval=
___err_too_big.c
new file mode 100644
index 000000000000..6d329e2a4d4e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___err_too=
_big.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___err_too_big x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
err_too_small.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumv=
al___err_too_small.c
new file mode 100644
index 000000000000..bb4b19c71e1d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___err_too=
_small.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___err_too_small x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
err_uint.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
err_uint.c
new file mode 100644
index 000000000000..33ad12fd61bd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___err_uin=
t.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___err_uint x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
index 116a67fdd1b2..01d67521efd1 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -1409,6 +1409,62 @@ struct core_reloc_enumval___byte_unpacked {
 	enum named_byte_enum___byte_unpacked f3;
 };
=20
+/* second enum value out of the range of the local int enumerator, as th=
e
+ * target enum is 8 bytes, should fail
+ */
+enum named_enum___err_too_big {
+	NAMED_ENUM_VAL1___err_too_big =3D 1,
+	NAMED_ENUM_VAL2___err_too_big =3D 0x200000000ULL,
+	NAMED_ENUM_VAL3___err_too_big =3D 3,
+};
+
+struct core_reloc_enumval___err_too_big {
+	enum named_enum___err_too_big f1;
+	anon_enum f2;
+};
+
+/* second enum value out of the range of the local int enumerator, as th=
e
+ * target enum is signed and 8 bytes, should fail
+ */
+enum named_enum___err_too_small {
+	NAMED_ENUM_VAL1___err_too_small =3D 1,
+	NAMED_ENUM_VAL2___err_too_small =3D -0x100000000LL,
+	NAMED_ENUM_VAL3___err_too_small =3D 3,
+};
+
+struct core_reloc_enumval___err_too_small {
+	enum named_enum___err_too_small f1;
+	anon_enum f2;
+};
+
+/* second enum value out of the range of the local int enumerator, as th=
e
+ * target enum is unsigned, should fail
+ */
+enum named_enum___err_int {
+	NAMED_ENUM_VAL1___err_int =3D 1,
+	NAMED_ENUM_VAL2___err_int =3D 0x80000000,
+	NAMED_ENUM_VAL3___err_int =3D 3,
+};
+
+struct core_reloc_enumval___err_int {
+	enum named_enum___err_int f1;
+	anon_enum f2;
+};
+
+/* first unsigned enum value out of the range of the local unsigned int
+ * enumerator, as the target enum is 8 bytes, should fail
+ */
+enum named_uint_enum___err_uint {
+	UINT_ENUM_VAL1___err_uint =3D 0x100000000ULL,
+	UINT_ENUM_VAL2___err_uint =3D 0xffffffff,
+};
+
+struct core_reloc_enumval___err_uint {
+	enum named_enum f1;
+	anon_enum f2;
+	enum named_uint_enum___err_uint f3;
+};
+
 enum named_unsigned_enum64___err_missing {
 	UNSIGNED_ENUM64_VAL1___err_missing =3D 0x1ffffffffULL,
 	UNSIGNED_ENUM64_VAL3___err_missing =3D 0x3ffffffffULL,
@@ -1423,3 +1479,17 @@ struct core_reloc_enum64val___err_missing {
 	enum named_unsigned_enum64___err_missing f1;
 	enum named_signed_enum64___err_missing f2;
 };
+
+/* first signed enum value out of the range of the local long enumerator=
, as
+ * the target enum is unsigned, should fail
+ */
+enum named_signed_enum64___err_sign {
+	SIGNED_ENUM64_VAL1___err_sign =3D 0x8000000000000000ULL,
+	SIGNED_ENUM64_VAL2___err_sign =3D 2,
+	SIGNED_ENUM64_VAL3___err_sign =3D 3,
+};
+
+struct core_reloc_enum64val___err_sign {
+	enum named_unsigned_enum64 f1;
+	enum named_signed_enum64___err_sign f2;
+};
--=20
2.53.1-Meta

