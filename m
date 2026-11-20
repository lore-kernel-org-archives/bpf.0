Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211416;
	b=IU/BwV9kiyaiA+WB3qSFKNE4DQeaARZRYNJwjRqF1PD8WqkIATOeMVRbfMVNnlS4XpaO
	 aNHs6aPjLHW6dZ+rJfyv73WpnBx/L9Dw8h9nTc10KihcIsEs3OdnNlfIYspkyOH1iDFQ4
	 k6KMgUvgSrq/OOSod3auuZcMEPuCW8j1oynftwwMjZD5ycvNIj0lgGMcErYpFHX5x7ied
	 5+LnWhaBMeGEP8tvyWGDszglRpvEATBRnlbM6avfBBmj4u6HTIWVHb7AAuy0pNrZjPrqm
	 iw1Pdh2+pjnRVeuzuRo+bmH3xTPhDAN5otVey2Y6QgH3QRihaPvMmoYdaIC0ZQzinAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211416;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FIgDbQ/9CZvHQLaVkowiWsqsBz0oIXDWdGzA7SGRZ3Q=;
	b=wNbQ94XOy8O4yrHx2q79i1Wbyd2nh5S7nYARsLho3r8nZB/FY8V/+8q4cX9V//bx6rfm
	 Tku7Ipkld6di9bd5cLji1L4y3D5IFDaznF8LxAav0/rb+y3ZmlYYK5iNVvqb520JqUsjs
	 ngDjbW7MlOJCaz9DTNOCuGmhwFDczl5zmjzYzAllTu0B+WZc+7K+rg0jsgP4jhgusMm/U
	 oIMXhxdA2q5SEUuY/bX6LBE6Slrhmv/ZHL8lAZCiAdxS/DZy2l8Nm1hCEd+RBMZGXjkRJ
	 x0+lJrKOFmHCVPQ/SmYUUOhA1kjP7cdpER7og3tVPPsPj/51Nr7cd832zV+fl7Rf6QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.179
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2C606A6BD
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38D2C606A6BD
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 98CCC59405502; Fri, 20 Nov 2026 13:50:02 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 1/3] libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
Date: Fri, 20 Nov 2026 13:50:02 -0800
Message-ID: <20261120215002.868773-1-yonghong.song@linux.dev>
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
signedness") fixed this for btf_dump and map fields, but not for CO-RE
relocations, whose relo_core.c is also built into the kernel. Keep the
sign extension in bpf_core_calc_enumval_relo(), and zero-extend the
32-bit values of unsigned enums, i.e., with the kflag 0, once in
bpf_core_calc_relo().

The kflag 0 of the target enum doesn't always mean unsigned, though.
Before commit 6089fb325cf7 ("bpf: Add btf enum64 support") in v6.0, the
kernel refused an enum with the kflag set, so the BTF of an older kernel
has the kflag 0 on every enum, signed or not. pahole doesn't record the
signedness before v1.24 either, and the kernel still accepts pahole
v1.22. On such a kernel, zero-extending a negative target value would
make, e.g., 0xffffffff instead of -1:

  long v =3D bpf_core_enum_value(enum perf_event_state,
                               PERF_EVENT_STATE_OFF);

The local enum has the kflag 1, so the original value matches the
ld_imm64, and nothing would warn. So zero-extend the target value only
if the local enum has the kflag 0 too. A target value is then
zero-extended only if neither enum is signed.

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
then gets the extension above, which is the form clang emits, as its
builtin returns long. A target value that doesn't fit in 32 bits, e.g.,
from an enum64 in the target kernel, is patched unchanged.

In summary, a 32-bit target value is extended as follows, where kflag 1
is signed:

  local enum   target enum   clang   GCC
  ----------   -----------   -----   ----------
  kflag 1      kflag 1       sign    sign
  kflag 1      kflag 0       sign    sign
  kflag 0      kflag 1       sign    sign
  kflag 0      kflag 0       zero    zero, or sign (*)

  (*) sign if the local value is in [0x80000000, 0xffffffff], since
      GCC emits it sign-extended in the ld_imm64

Fixes: 776281652ddc ("libbpf: Permit 64bit relocation value")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/relo_core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2672623a4198..3f37a0879c40 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -887,6 +887,28 @@ static int bpf_core_calc_enumval_relo(const struct b=
pf_core_relo *relo,
 	return 0;
 }
=20
+/*
+ * btf_enum->val is __s32, so both values are sign-extended at this poin=
t.
+ * clang zero-extends the value of an unsigned enum.
+ * kflag =3D=3D 0 is an unsigned enum or BTF without signedness (kernel =
before
+ * v6.0, pahole before v1.24), so new_val needs kflag =3D=3D 0 on both s=
ides.
+ */
+static void bpf_core_zext_enumval(const struct bpf_core_spec *local_spec=
,
+				  const struct bpf_core_spec *targ_spec,
+				  struct bpf_core_relo_res *res)
+{
+	const struct btf_type *local_t, *targ_t;
+
+	local_t =3D btf_type_by_id(local_spec->btf, local_spec->spec[0].type_id=
);
+	targ_t =3D btf_type_by_id(targ_spec->btf, targ_spec->spec[0].type_id);
+	if (BTF_INFO_KFLAG(local_t->info))
+		return;
+	if (btf_is_enum(local_t))
+		res->orig_val =3D (__u32)res->orig_val;
+	if (btf_is_enum(targ_t) && !BTF_INFO_KFLAG(targ_t->info))
+		res->new_val =3D (__u32)res->new_val;
+}
+
 /* Calculate original and target relocation values, given local and targ=
et
  * specs and relocation kind. These values are calculated for each candi=
date.
  * If there are multiple candidates, resulting values should all be cons=
istent
@@ -962,6 +984,8 @@ static int bpf_core_calc_relo(const char *prog_name,
 	} else if (core_relo_is_enumval_based(relo->kind)) {
 		err =3D bpf_core_calc_enumval_relo(relo, local_spec, &res->orig_val);
 		err =3D err ?: bpf_core_calc_enumval_relo(relo, targ_spec, &res->new_v=
al);
+		if (!err && relo->kind =3D=3D BPF_CORE_ENUMVAL_VALUE)
+			bpf_core_zext_enumval(local_spec, targ_spec, res);
 	}
=20
 done:
@@ -1144,6 +1168,13 @@ int bpf_core_patch_insn(const char *prog_name, str=
uct bpf_insn *insn,
 			return bpf_core_poison_insn(prog_name, relo_idx, insn, insn_idx);
=20
 		imm =3D (__u32)insn[0].imm | ((__u64)insn[1].imm << 32);
+		/* GCC sign-extends the value of an unsigned enum. Keep its form. */
+		if (relo->kind =3D=3D BPF_CORE_ENUMVAL_VALUE && orig_val <=3D UINT_MAX=
 &&
+		    imm !=3D orig_val && imm =3D=3D (__u64)(__s32)orig_val) {
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

