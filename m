Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130825;
	b=HoKRUUZ0N/WMADySEk50VcWvxQqImh0K4s3hgSNUp1imf9OAL3M4xbjDFnBPnrbmJNvT
	 bK7aWrzDpvG03h2WoD66Usie/PRCP/yD8urW916YfASKp1i6f6K9HnTzIpmEsbzrmFQjJ
	 gjo8xdn9LApeXVTNgKWaTqDiDyjfG46ZmMQs+l3xdpHchnonk8kr6rlCz//fOUSOSWY90
	 hqX5TlC+jKfAda0dy7zDJERgyqf7SdZHgAdJCEhe5nEyABttJ3OaR8NSdZA4QnWIZ5IZA
	 AjWk/nz6ARWXhN6IvISP1Wukk/qpxXxsbb/l8GCzaDZ83YsQzlQ/XAlgkSzdcaSdodw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130825;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ev6p8PzNMiYkppQcIjorTbI7P0WXufsPXyolmGeLwf4=;
	b=BN4g3iBdJCTY8Hd7VM7cq7Qag9c7ayyB2D/U+wL2/INlxvsfcqeaNbg8wMufXWTNFJhl
	 NU4Cg/uqBCriCnxUp3xbsB2MthTbrbX8RSck0d0SjdO1lufZF64Es3MvDWFIbVhfHH2zD
	 AwdR1P7eFguQGNfc2fgju5+PK2uVJGJFFvEsGl8CvaLn9iXCw3lwtgfJKwPhK5ppTLrCb
	 OuGErI2YsdG6Ve97H8IYf7zbXG//OsBkXY39LtA5E3UeVKMolTGO0n+8I9CS6uq5u9eaL
	 KluKPrClwo+t2E47JprYWAIua1AQR52gjaFXXSYqmMQV1mFmdOIbzY3UxzQSgmfoN3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.180
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCF606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2CCF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id A2E41591B5879; Thu, 19 Nov 2026 15:26:52 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 1/2] libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
Date: Thu, 19 Nov 2026 15:26:52 -0800
Message-ID: <20261119232652.3392590-1-yonghong.song@linux.dev>
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

For a BPF_CORE_ENUMVAL_VALUE relocation, bpf_core_calc_enumval_relo()
reads the value of a 32-bit enumerator from btf_enum->val, which is
__s32, so the value is sign-extended to 64 bits even if the enum is
unsigned. A value in [0x80000000, 0xffffffff] of an unsigned enum
becomes 0xffffffff80000000 or above.

Clang emits such a value zero-extended in the ld_imm64 of the
relocation, so the check of the original value fails, and the whole
object is refused even if the target value is the same:

  enum dentry_flags { DCACHE_PRIVATE =3D 0x80000000 };
  out =3D bpf_core_enum_value(enum dentry_flags, DCACHE_PRIVATE);

  libbpf: prog 'p': relo #0: unexpected insn #0 (LDIMM64) value: got
          2147483648, exp 18446744071562067968 -> 18446744071562067968
  libbpf: prog 'p': relo #0: failed to patch insn #0: -EINVAL

And a target value in that range is patched sign-extended, which is
wrong wherever the program uses it as a 64-bit value. The x86 vmlinux
has 29 enums with such values, e.g., dentry_flags, init_ns_ino and
e820_type.

Commit 89e7a42e3030 ("libbpf: Normalize enum values according to
signedness") added btf_enum_value(), which extends the value as given by
the kflag of the enum, for btf_dump and map fields, but not for CO-RE
relocations, whose relo_core.c is also built into the kernel. Use it in
bpf_core_calc_enumval_relo() as well, and add it to the kernel's
include/linux/btf.h, so that the kernel gets the same fix.

GCC, however, sign-extends every 32-bit enum value, since its
__builtin_preserve_enum_value() returns int. For the example above:

  clang: r1 =3D 0x80000000 ll
  gcc:   lddw %r1,-2147483648

An object built by GCC is accepted today, because the original value is
sign-extended too, and the change above alone would refuse it:

  libbpf: prog 'p': relo #0: unexpected insn #0 (LDIMM64) value: got
          18446744071562067968, exp 2147483648 -> 2147483648

The two forms differ only for an unsigned value in [0x80000000,
0xffffffff]. For such a value, accept the sign-extended form as well.
In that case, also sign-extend the target value, since GCC code uses
the ld_imm64 as the int value widened to 64 bits.

An original value below 0x80000000 is the same in both forms, so the
instruction doesn't show which compiler emitted it. The target value
then gets the extension given by the kflag of the target enum, which is
the form clang emits, as its builtin returns long. A target value that
doesn't fit in 32 bits, e.g., from an enum64 in the target kernel, is
patched unchanged.

Fixes: 776281652ddc ("libbpf: Permit 64bit relocation value")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/btf.h       |  5 +++++
 tools/lib/bpf/relo_core.c | 31 +++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 87fad4076f0e..ceb27984df14 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -525,6 +525,11 @@ static inline struct btf_enum *btf_enum(const struct=
 btf_type *t)
 	return (struct btf_enum *)(t + 1);
 }
=20
+static inline u64 btf_enum_value(const struct btf_type *t, const struct =
btf_enum *e)
+{
+	return btf_type_kflag(t) ? (s64)e->val : (u32)e->val;
+}
+
 static inline struct btf_enum64 *btf_enum64(const struct btf_type *t)
 {
 	return (struct btf_enum64 *)(t + 1);
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2672623a4198..4891c8efa916 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -861,6 +861,13 @@ static int bpf_core_calc_type_relo(const struct bpf_=
core_relo *relo,
 	return 0;
 }
=20
+static __u64 bpf_core_enumval(const struct btf_type *t, int idx)
+{
+	if (btf_is_enum(t))
+		return btf_enum_value(t, btf_enum(t) + idx);
+	return btf_enum64_value(btf_enum64(t) + idx);
+}
+
 static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
 				      const struct bpf_core_spec *spec,
 				      __u64 *val)
@@ -875,10 +882,7 @@ static int bpf_core_calc_enumval_relo(const struct b=
pf_core_relo *relo,
 		if (!spec)
 			return -EUCLEAN; /* request instruction poisoning */
 		t =3D btf_type_by_id(spec->btf, spec->spec[0].type_id);
-		if (btf_is_enum(t))
-			*val =3D btf_enum(t)[spec->spec[0].idx].val;
-		else
-			*val =3D btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
+		*val =3D bpf_core_enumval(t, spec->spec[0].idx);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -1028,6 +1032,20 @@ static int insn_bytes_to_bpf_size(__u32 sz)
 	}
 }
=20
+/*
+ * A 32-bit enum value is in the low 32 bits of the ld_imm64, extended a=
s
+ * the compiler chooses: clang zero-extends an unsigned value, GCC
+ * sign-extends every value, as its __builtin_preserve_enum_value() retu=
rns
+ * int. Check whether the instruction has the sign-extended form of an
+ * unsigned value, so that the target value gets that form too.
+ */
+static bool bpf_core_enumval_is_sext(const struct bpf_core_relo *relo,
+				     __u64 imm, __u64 orig_val)
+{
+	return relo->kind =3D=3D BPF_CORE_ENUMVAL_VALUE && orig_val <=3D UINT_M=
AX &&
+	       imm !=3D orig_val && imm =3D=3D (__u64)(__s32)orig_val;
+}
+
 /*
  * Patch relocatable BPF instruction.
  *
@@ -1144,6 +1162,11 @@ int bpf_core_patch_insn(const char *prog_name, str=
uct bpf_insn *insn,
 			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
=20
 		imm =3D (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
+		if (res->validate && bpf_core_enumval_is_sext(relo, imm, orig_val)) {
+			orig_val =3D imm;
+			if (new_val <=3D UINT_MAX)
+				new_val =3D (__s32)new_val;
+		}
 		if (res->validate && imm !=3D orig_val) {
 			pr_warn("prog '%s': relo #%d: unexpected insn #%d (LDIMM64) value: go=
t %llu, exp %llu -> %llu\n",
 				prog_name, relo_idx,
--=20
2.53.1-Meta

