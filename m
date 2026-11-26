Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715781;
	b=UcJkRgRXjXyy59KIiW9FKyqSk/kEN6bOuWWExU7GeIJYWJHCTR1Pdd+PJZNr7ttfl1zg
	 G42UpzG19zE/Qrji2K6G/kNav67LFderbnygCsTL3xv0t1vfvOpHB+IhYRyswd6bV3HuQ
	 PozphOtWNyGU4cvS0qUGwBe4P37eQjClKeJgsf42OQsN36rs8710IuNc2FwdRwpU5XigY
	 qdJpI2S367f9jeWbGVOYoOI+lHiVdZLaH0/SMOKlBXMAC1m6ZB16pNUm49CVRg/CXIlny
	 71WpZkEAty3Vsbrk1idu9Nhji5bFuOk2jXIM8FtSra+d7/BlwRx4G0bzO+uW1q+nLLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715781;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M4dYjtalH6PJiqulJbAXhom7vEubb+GqH27K2yYRBhw=;
	b=FJ9xSIqTygk84/PsMKn9YT6DSSsOUx7hte+132+aKQjp1zvX5nKFzRUkQjjCe9ez2F6W
	 aYA6IoBbiLyxaqmK8Loc7iHxyJNnH8egkcIAD3Euj0QngTe13r4anGbdRiZoiaORTyj3a
	 RcOkSc35xqTUiSeLsbpNaEGR5deXtaBAhY7R0iQilajpwOM11vWw/OROTk+IIjsN+PpO9
	 +llvuWaqrLkVUThgfF6eFStGkswZLrMWtq/5DIVc1j0ZacorDUBwR0769E7OwYwSejB+U
	 89JOrO38sDkRzISKZfu027/4F1k9QpdccerKxU+Wg54lk1GpV55KGyRwsAfPfNecnRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.179
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15937606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 17:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15937606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id D9FC859E04765; Thu, 26 Nov 2026 09:56:07 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/3] libbpf: Poison an enum value relocation out of the local enumerator range
Date: Thu, 26 Nov 2026 09:56:07 -0800
Message-ID: <20261126175607.1883240-1-yonghong.song@linux.dev>
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

For a BPF_CORE_ENUMVAL_VALUE relocation, libbpf patches the 64-bit value
of the target enumerator into the ld_imm64 without checking whether it
fits in the type of the local enumerator.

This has been fine because such a relocation could only come from
__builtin_preserve_enum_value(), e.g., through bpf_core_enum_value().
The builtin returns a long, whatever the type of the local enumerator,
so the program uses all 64 bits of the patched value:

  enum E { N =3D 10 };
  long g(void) { return bpf_core_enum_value(enum E, N); }

is compiled to:

  g:
    r0 =3D 0xa ll          /* CO-RE <enumval_value> enum E::N */
    exit

If N is 0x100000000 in the kernel, g() returns 0x100000000, although
the local N has type int. This is why commit 776281652ddc ("libbpf:
Permit 64bit relocation value") allowed any 64-bit value, so that a
local enum can match a kernel enum64.

Clang now accepts the preserve_access_index attribute on an enum, see
llvm commit c080a0b9b673 ("[BPF] Support preserve_access_index attribute
for enum"). Each reference to an enumerator of such an enum is
relocated, and the relocated value is converted to the type of the
enumerator. For example:

  enum E { N =3D 10 } __attribute__((preserve_access_index));
  enum U { M =3D 0x80000000 } __attribute__((preserve_access_index));

  unsigned f1(unsigned hash) { return hash % N; }
  long f2(void) { return N; }
  unsigned long f3(void) { return M; }

is compiled to:

  f1:
    w0 =3D w1
    r1 =3D 0xa ll          /* CO-RE <enumval_value> enum E::N */
    w0 %=3D w1
    exit
  f2:
    r0 =3D 0xa ll          /* CO-RE <enumval_value> enum E::N */
    r0 <<=3D 0x20
    r0 s>>=3D 0x20
    exit
  f3:
    r0 =3D 0x80000000 ll   /* CO-RE <enumval_value> enum U::M */
    r0 <<=3D 0x20
    r0 >>=3D 0x20
    exit

N has type int and M has type unsigned int, so only the low 32 bits of
the patched value are used, even where the result is 64-bit:

  - If N is 0x100000000 in the kernel, f1() computes hash % 0 and f2()
    returns 0.
  - If N is 0x80000000 in the kernel, f2() returns 0xffffffff80000000,
    a negative value.
  - If M is 0x100000000 in the kernel, f3() returns 0.

In each case the program loads and silently uses a wrong value.

The type of the local enumerator follows from the local enum, as in C:
int if all values of the enum fit in int, and otherwise the type of the
enum, i.e., unsigned int for a 4-byte enum, and long or unsigned long
for an 8-byte one. A 1-byte enum made with the packed or mode(byte)
attribute, as in the kernel, still has int enumerators.

If the target value is out of the range of that type, poison the
instruction, as is done when the enumerator does not exist in the
target, and warn:

  libbpf: prog 'test_core_enumval': relo #7: enumerator
          'NAMED_ENUM_VAL2___err_int' value 0x80000000 does not fit in
          int type of local enumerator

So a program is only rejected if the poisoned instruction is reachable.

This also applies to bpf_core_enum_value(), since libbpf cannot tell the
two forms apart. A program like g() above, which could use a target
value out of the range of the local enumerator type before, is now
rejected if the instruction is reachable. Document this in
bpf_core_read.h.

The target value is taken as signed or unsigned according to the kflag
of the target enum, which pahole sets for a signed enum since v1.24, the
minimum version now required for kernel BTF.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/bpf_core_read.h |  5 ++
 tools/lib/bpf/relo_core.c     | 88 ++++++++++++++++++++++++++++++++---
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.=
h
index b997c68bd945..00e8567e0a98 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -283,6 +283,11 @@ enum bpf_enum_value_kind {
  *    64-bit value, if specified enum type and its enumerator value are
  *    present in target kernel's BTF;
  *    0, if no matching enum and/or enum value within that enum is found=
.
+ * If the target value does not fit in the type of the local enumerator,=
 the
+ * instruction is poisoned, so the program is rejected if it is reachabl=
e.
+ * The local enumerator has type int if all values of the local enum fit=
 in
+ * int. Otherwise, it has type unsigned int for a 4-byte enum, and long =
or
+ * unsigned long for an 8-byte enum, depending on whether the enum is si=
gned.
  */
 #ifdef __clang__
 #define bpf_core_enum_value(enum_type, enum_value)			    \
diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 58c782cc60e8..b78f8ae15294 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -861,12 +861,22 @@ static int bpf_core_calc_type_relo(const struct bpf=
_core_relo *relo,
 	return 0;
 }
=20
+static __u64 bpf_core_enum_val(const struct btf_type *t, int idx)
+{
+	const struct btf_enum *e;
+
+	if (btf_is_enum(t)) {
+		e =3D btf_enum(t) + idx;
+		return BTF_INFO_KFLAG(t->info) ? (__s64)e->val : (__u32)e->val;
+	}
+	return btf_enum64_value(btf_enum64(t) + idx);
+}
+
 static int bpf_core_calc_enumval_relo(const struct bpf_core_relo *relo,
 				      const struct bpf_core_spec *spec,
 				      __u64 *val)
 {
 	const struct btf_type *t;
-	const struct btf_enum *e;
=20
 	switch (relo->kind) {
 	case BPF_CORE_ENUMVAL_EXISTS:
@@ -876,12 +886,7 @@ static int bpf_core_calc_enumval_relo(const struct b=
pf_core_relo *relo,
 		if (!spec)
 			return -EUCLEAN; /* request instruction poisoning */
 		t =3D btf_type_by_id(spec->btf, spec->spec[0].type_id);
-		if (btf_is_enum(t)) {
-			e =3D btf_enum(t) + spec->spec[0].idx;
-			*val =3D BTF_INFO_KFLAG(t->info) ? (__s64)e->val : (__u32)e->val;
-		} else {
-			*val =3D btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
-		}
+		*val =3D bpf_core_enum_val(t, spec->spec[0].idx);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -890,6 +895,71 @@ static int bpf_core_calc_enumval_relo(const struct b=
pf_core_relo *relo,
 	return 0;
 }
=20
+static bool bpf_core_enum_val_fits_int(__u64 val, bool val_signed)
+{
+	return val_signed ? (__s64)val =3D=3D (__s32)val : val <=3D INT_MAX;
+}
+
+/*
+ * As in C, the enumerators of an enum have type int if all values of th=
e enum
+ * fit in int, even for a 1-byte enum made with the packed or mode(byte)
+ * attribute, and otherwise the type of the enum, which is then 4 or 8 b=
ytes.
+ */
+static bool bpf_core_enum_fits_int(const struct btf_type *t)
+{
+	bool is_signed =3D BTF_INFO_KFLAG(t->info);
+	int i, n =3D btf_vlen(t);
+
+	for (i =3D 0; i < n; i++) {
+		if (!bpf_core_enum_val_fits_int(bpf_core_enum_val(t, i), is_signed))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * Check whether the target value of an ENUMVAL_VALUE relocation fits in=
 the
+ * type of the local enumerator. The compiler may convert the relocated =
64-bit
+ * value to that type, e.g., for an enumerator of an enum with the
+ * preserve_access_index attribute. A target value out of the range of t=
hat
+ * type then becomes a different value, e.g., 0x100000000 becomes 0 for =
an int
+ * enumerator, and the program uses it without any error.
+ */
+static int bpf_core_check_enumval_range(const char *prog_name, int relo_=
idx,
+					const struct bpf_core_spec *local_spec,
+					const struct bpf_core_spec *targ_spec,
+					__u64 targ_val)
+{
+	const struct btf_type *local_t, *targ_t;
+	bool local_signed, targ_signed, fits;
+	const char *type;
+
+	local_t =3D btf_type_by_id(local_spec->btf, local_spec->spec[0].type_id=
);
+	targ_t =3D btf_type_by_id(targ_spec->btf, targ_spec->spec[0].type_id);
+	local_signed =3D BTF_INFO_KFLAG(local_t->info);
+	targ_signed =3D BTF_INFO_KFLAG(targ_t->info);
+
+	if (bpf_core_enum_fits_int(local_t)) {
+		type =3D "int";
+		fits =3D bpf_core_enum_val_fits_int(targ_val, targ_signed);
+	} else if (local_t->size =3D=3D 4) {
+		type =3D "unsigned int";
+		/* a negative value is sign-extended, so it is also too big */
+		fits =3D targ_val <=3D UINT_MAX;
+	} else {
+		/* the 64-bit value is used as is, only its sign may change */
+		type =3D local_signed ? "long" : "unsigned long";
+		fits =3D local_signed =3D=3D targ_signed || (__s64)targ_val >=3D 0;
+	}
+	if (fits)
+		return 0;
+
+	pr_warn("prog '%s': relo #%d: enumerator '%s' value 0x%llx does not fit=
 in %s type of local enumerator\n",
+		prog_name, relo_idx, targ_spec->spec[0].name,
+		(unsigned long long)targ_val, type);
+	return -EUCLEAN; /* request instruction poisoning */
+}
+
 /* Calculate original and target relocation values, given local and targ=
et
  * specs and relocation kind. These values are calculated for each candi=
date.
  * If there are multiple candidates, resulting values should all be cons=
istent
@@ -965,6 +1035,10 @@ static int bpf_core_calc_relo(const char *prog_name=
,
 	} else if (core_relo_is_enumval_based(relo->kind)) {
 		err =3D bpf_core_calc_enumval_relo(relo, local_spec, &res->orig_val);
 		err =3D err ?: bpf_core_calc_enumval_relo(relo, targ_spec, &res->new_v=
al);
+		if (!err && relo->kind =3D=3D BPF_CORE_ENUMVAL_VALUE)
+			err =3D bpf_core_check_enumval_range(prog_name, relo_idx,
+							   local_spec, targ_spec,
+							   res->new_val);
 	}
=20
 done:
--=20
2.53.1-Meta

