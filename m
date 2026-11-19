Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065312;
	b=G3ykzUdHzNxjSMD2aM0DmlW5xTd14svRDfDisFcgJIB5tRU3lIfYS1lPtVjBm7Mxhjqi
	 FWU2J2oHCepqAHDQdbEuuXnXZ/wf7b03Z23v+Pwr+8hv73x6a0IyAMTqXxEs73m/CEmM0
	 w5yJYl8dLVkxWKFwM/9DDyMNNJuVVOVuOu9hq+OwnqDJneoeevluEXnZIg5C9pTqPWJP4
	 muXoWgFTvNUlv3WotA1ErZ76MrYKab2ByvXkde5TWsDAeQZ/A6NtDQJ47mEh83cvXmhgK
	 DG+q4oxA88VXKJqeu/5Y3YBsJ1S4tRCmVS0H3xNIQUDfQ9JSLFQlXsmRKBSswG1ZJUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065312;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IGoIGTmtXsZ0cxgR9T70gY3yv7uDH6jyEcCQ9n9SWyY=;
	b=Kb0+l2EVDukGoX1PPAlbKShZwDhmylVGBgr8ewQ2vM2QmMbGPs8HOOpbvGzHF84e9nZU
	 90UAMrn9+6dhWLtZBF5MoEHZlPDyGkoVdZ6oVl4Vwyl7QgIGKbcbyDryWpFIGyC4s7+mC
	 vFEcpmP1Pgzf3j2AQmAzKAztgcSkZsiuWSawS17RO3tmNbm6/bD5o+NXRkCMplW9cTpPG
	 pMN0uH7RvAzBZxDwqLvX4pG1hS3Xg5k56Bwati2WlixaHAGZG2QOx9pcTCq66DdYfcSRx
	 IeihppuK/4T75Ik6l2aD9YDpmi6Et4UfVE8O7TbzRfm9gN8nSFZY50+TwQdezPGyepQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.180
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CA1606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CA1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 0E97259083BDC; Wed, 18 Nov 2026 21:14:59 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 3/4] libbpf: Accept sign-extended 32-bit enum values in CO-RE relocations
Date: Wed, 18 Nov 2026 21:14:59 -0800
Message-ID: <20261119051459.1902876-1-yonghong.song@linux.dev>
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

The value of a 32-bit enum in a BPF_CORE_ENUMVAL_VALUE relocation is in
the low 32 bits of the ld_imm64, and the compiler chooses how it is
extended to 64 bits. Clang zero-extends the value of an unsigned enum
and sign-extends that of a signed one. GCC sign-extends every value,
since its __builtin_preserve_enum_value() returns int:

  enum E { V =3D 0x80000000 };
  out =3D bpf_core_enum_value(enum E, V);

  clang: r1 =3D 0x80000000 ll
  gcc:   lddw %r1,-2147483648

The previous patch extends the original value as given by the kflag of
the enum, which is the form clang emits. So an object built by GCC,
which was accepted when the value was sign-extended for all 32-bit
enums, is now refused:

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

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/relo_core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 7aa7eb4e4021..76efee8e876f 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1032,6 +1032,19 @@ static int insn_bytes_to_bpf_size(__u32 sz)
 	}
 }
=20
+/* A 32-bit enum value is in the low 32 bits of the ld_imm64, extended a=
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
@@ -1148,6 +1161,11 @@ int bpf_core_patch_insn(const char *prog_name, str=
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

