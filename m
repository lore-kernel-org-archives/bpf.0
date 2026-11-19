Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065306;
	b=XsWvVubCeyLmsecH2WFD3juJIo7F+3EzQr2w9lMGGN91KQSZuwfkMCOg4juJVwwDlV8W
	 aywmoKIpRRuU0qLIeDPr4VqR0VurqlRbqeHIojGPhhQ+J1z/8O9SbMMHiJeefChki/FL9
	 rfWNKsrlGqiuVsPZGwvEEmidYuuPzNMIvDWE3IJMoQC/nJU9u/607WTHLeK6NCCKyhma+
	 ssxbZQkFxq7wGtaxpWcj8tbv8j5VxcBiBiCyFXBUSArY3zk+yB/M8euqAP2KskCa3PfLZ
	 L1gOLD6jy1eqorl0AUt0Lm/ZpWIMPvs4UOBhFcNLpSF+MoDQk9x/+rraAqeksE7Ozeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065306;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BXyCFWJtloBcTguoW5E30b0fgDc78HY9DeHDHalUs84=;
	b=MzYy3xhJNCbu7G7gR35kozAXx4RMd/ykw3DNxznhcYxbc2fPl8IxixbPG7SWv/PTFpEX
	 CAMj0mQNQqcp/8+1ZgurLJ8ueWM0hZNjPltOkZfM4aN9bnaRkKlEdha7B2Q5fDyG5NZxh
	 08vmQp1JuP0IH0HrShkSXhLOuhDdpyG1o5m31J/5F//Bd4/daqGYnyW4Z1/dJghFEpCfH
	 MBGO6vcSehzDiLQ2koCoVbyV7aMHT+Ezl4S/fQcTe04hE/iQ8eQAtVaK//eobgq5s3ig+
	 T2ewCLwnXfA23FikLIBvmJbIhynM/pZlCtlvKg11FQbBcWMG0EaN3KKJtKvDnqPyaBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.180
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDE606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3EDE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id E0F6F59083BBF; Wed, 18 Nov 2026 21:14:53 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 2/4] selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values
Date: Wed, 18 Nov 2026 21:14:53 -0800
Message-ID: <20261119051453.1902726-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261119051443.1902163-1-yonghong.song@linux.dev>
References: <20261119051443.1902163-1-yonghong.song@linux.dev>
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

Test the zero extension of unsigned 32-bit enum values in CO-RE
relocations from the previous patch.

test_core_reloc_enumval gets an optional local enum with values out of
the range of int, i.e., an unsigned 4-byte enum, whose values clang
emits zero-extended in the ld_imm64 of the relocations. The enumval
target has the same enum with different values, 0x80000001 and
0xffffffff, which are expected zero-extended in the 64-bit outputs.

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
 .../testing/selftests/bpf/prog_tests/core_reloc.c  |  2 ++
 .../testing/selftests/bpf/progs/core_reloc_types.h |  8 ++++++++
 .../selftests/bpf/progs/test_core_reloc_enumval.c  | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

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
index e7ef3dada2bf..964297b9bab5 100644
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
@@ -39,6 +45,8 @@ struct core_reloc_enumval_output {
 	int named_val2;
 	int anon_val1;
 	int anon_val2;
+	long uint_val1;
+	long uint_val2;
 };
=20
 SEC("raw_tracepoint/sys_enter")
@@ -64,6 +72,12 @@ int test_core_enumval(void *ctx)
 	out->anon_val1 =3D bpf_core_enum_value(anon, ANON_ENUM_VAL1);
 	out->anon_val2 =3D bpf_core_enum_value(anon, ANON_ENUM_VAL2);
 	/* ANON_ENUM_VAL3 value is optional */
+
+	/* enum named_uint_enum is optional */
+	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL1))
+		out->uint_val1 =3D bpf_core_enum_value(enum named_uint_enum, UINT_ENUM=
_VAL1);
+	if (bpf_core_enum_value_exists(enum named_uint_enum, UINT_ENUM_VAL2))
+		out->uint_val2 =3D bpf_core_enum_value(enum named_uint_enum, UINT_ENUM=
_VAL2);
 #else
 	data.skip =3D true;
 #endif
--=20
2.53.1-Meta

