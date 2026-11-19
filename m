Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130829;
	b=MvTV+A3k12b5Wano+3tL1Dc0GluTByFiemIjf4+vi3wlo0FzmqIaOOAvHPjcBsMfy3A4
	 51yGwxEh/8Y6WeICWgYfT3UUslD996gtUD8I+e0FDTL9QZzgygeVv3ChIddxJfNwtos6f
	 6txwAscDNJ1yF/Bh8CPlBQKEGh8MXRDH3mvIXForE0tlQkb1BS2gKXU0mDt0vHLubRl7r
	 mqtu/P+q4AWbGGJp/U7VcJfQLbmcPeYzzpMjN6P2KhMuTza7nGM6C7wGT1mLbT6tGOoGc
	 M61zCDvqsfK11130eAs4A1Rov/a2sszeOV2sjdFy/1eApkMiheNTW+wTt22DtZnIHkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130829;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e+Et1QkyQpw8ACVi1b3VK5MQFSTIOgA8OXmYXl4I2mQ=;
	b=thCUpwKS+BSohlCwA3YdwFRegJj1Dttu1w0QsJ9Hm3m7cqMuubB6d8eHrxwHoc/7HxJi
	 RjaLqoDsCWDeUZ7hFdb7dHi0RgmiNww8lWkFcnnYJwqcS8NNfksKgrR3Qf/Wzvtk0fzQx
	 KsIvgVx9w+IeUJlUJZUk764oMixwh4rvO0Igajji+V2A8v38WevuDVLmiLlFDZDfbC7O1
	 +ImsqO1fZhGCbBOe5/5U4yOp9RKE7meJh3XYsvMgq1MzHo12587/9llXoL86Vq1+8A4nK
	 2bSSwyKSfjZWrDigrWvvV8BRX3MKawgE21lDBlXHYR1PEsda+Fymjj66IEM/exwvKig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.179
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1AD606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F1AD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id C5389591B589B; Thu, 19 Nov 2026 15:26:57 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values
Date: Thu, 19 Nov 2026 15:26:57 -0800
Message-ID: <20261119232657.3392789-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119232647.3392045-1-yonghong.song@linux.dev>
References: <20261119232647.3392045-1-yonghong.song@linux.dev>
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

