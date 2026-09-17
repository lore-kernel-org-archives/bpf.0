Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF64F96B0
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663262; cv=none; b=mS5SWV3l3YhHPqUJQDMv5e/kAA/2Oq8oRLkDxZywIQJHfprk46aK/+zaMj09yPABGZiRl1LeWA/l+fKAL+sPdmQcew02r7A5cVEfPKUXtZOdPKhDFCq686IxjXf4O6t/XR2k6RXEl0t6NYL9eU+KTP18kM9GvZqnxIbMhfiuyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663262; c=relaxed/simple;
	bh=B3GlDaLYhBtmP8Qf7VY/XL7ci1wka/lHMW8XX4EiBqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgSP7/Lyzr/cgRuLhrXLEHRVPURVJZ4OJUzczwxWKuYbZyuYqo0piAz7/Yts8K5+eA1WcYw2ooqTiPTZuQ3zwTRgQGSB9U+djJrxkA7TpwN0XjZUtALvDnjlfr6EkxZ3yVxYdPYOShPe6P0CVj/ZOHQTweHgmIRGGV8Mq/lHU/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B99C32B60AB836; Thu, 17 Sep 2026 09:40:48 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/3] dwarf_loader: Do not align the argument register index for FP arguments
Date: Thu, 17 Sep 2026 09:40:48 -0700
Message-ID: <20260917164048.1578102-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917164038.1576763-1-yonghong.song@linux.dev>
References: <20260917164038.1576763-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The arm64 ABI aligns a general purpose argument that occupies two registe=
rs
to an even register number, leaving a hole when the next free register is=
 an
odd one.  parameter__abi_reg_align() applies that rule to every argument
wider than a pointer, but floating point and vector arguments are allocat=
ed
from a register bank of their own -- v0-v7 on arm64, xmm0-xmm7 on x86-64 =
--
so a wide one never takes a general purpose register pair and must not
trigger the rule:

  u64 f_fp(u64 a, long double v, u64 b);

Recognize floating point and vector arguments and leave the general purpo=
se
register index alone for them.

This does not change the BTF that is emitted today: such an argument stil=
l
advances the general purpose register index by its own size, so the
alignment is not the only thing standing between the model and the ABI.  =
It
does keep parameter__abi_reg_align() honest about which bank the rule
applies to.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 dwarf_loader.c | 21 ++++++++++++++++++++-
 dwarves.h      | 10 ++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 81c2076..1e5363a 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3651,6 +3651,25 @@ static int parameter__abi_slots(const struct param=
eter *parm, const struct cu *c
 	return slots > 0 ? slots : 1;
 }
=20
+/*
+ * Floating point and vector arguments are allocated from a register ban=
k of
+ * their own -- v0-v7 on arm64, xmm0-xmm7 on x86-64 -- so a wide one doe=
s not
+ * take a general purpose register pair and must not trigger the even-re=
gister
+ * alignment rule, which applies to the general purpose bank only.
+ */
+static bool tag__uses_gpr_bank(const struct tag *type, const struct cu *=
cu)
+{
+	/* Scalars represented by FP/SIMD registers have their own allocation b=
ank. */
+	if (tag__is_base_type(type, cu) && base_type__is_float(tag__base_type(t=
ype)))
+		return false;
+
+	/* Also exclude vector/SIMD types if dwarves represents them distinctly=
. */
+	if (tag__is_vector(type))
+		return false;
+
+	return true;
+}
+
 static int parameter__abi_reg_align(const struct parameter *parm, const =
struct cu *cu)
 {
 	struct tag *type;
@@ -3659,7 +3678,7 @@ static int parameter__abi_reg_align(const struct pa=
rameter *parm, const struct c
 		return 1;
=20
 	type =3D tag__strip_typedefs_and_modifiers(&parm->tag, cu);
-	if (type =3D=3D NULL)
+	if (type =3D=3D NULL || !tag__uses_gpr_bank(type, cu))
 		return 1;
=20
 	return tag__natural_alignment(type, cu) > cu->addr_size ? 2 : 1;
diff --git a/dwarves.h b/dwarves.h
index 70adbbf..f3453ed 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1607,6 +1607,11 @@ static inline uint16_t base_type__size(const struc=
t tag *tag)
 	return tag__base_type(tag)->bit_size / 8;
 }
=20
+static inline bool base_type__is_float(const struct base_type *bt)
+{
+	return bt->float_type !=3D 0;
+}
+
 const char *__base_type__name(const struct base_type *bt);
=20
 const char *base_type__name(const struct base_type *btype, char *bf, siz=
e_t len);
@@ -1625,6 +1630,11 @@ static inline struct array_type *tag__array_type(c=
onst struct tag *tag)
 	return (struct array_type *)tag;
 }
=20
+static inline bool tag__is_vector(const struct tag *tag)
+{
+	return tag->tag =3D=3D DW_TAG_array_type && tag__array_type(tag)->is_ve=
ctor;
+}
+
 struct string_type {
 	struct tag      tag;
 	uint32_t        nr_entries;
--=20
2.53.0-Meta

