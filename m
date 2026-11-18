Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018269;
	b=xskEb/BIaPo9LGHD0SLpQsaiNjZYEF+B/rMCo6tprR3A5fDyBfaBf9ajqHkkKIPla4nj
	 kG6jIKPSoPOhfPjQSnQOsbaba0nL9269rqy2MiRjNRklfSG6IAwoEE8yPp7RLb+Kw6aqh
	 VZ8kUZR/lIAI91/GXWn/mo6kAFQ5720Jius6YAGzM16ndrPsfW++oFHy45trbFc2Iwgk4
	 rlYD+4y0V2SK/NganVkT7LyBrKroil1pK9fhRo/14bTfP+31KrUHqu1zBX55Gevsk3MSK
	 QlBZFAd7fcZbC4IiRQqjoFE299rs/xeEx92tFeAkjBFz4lSw8JR4zc4gj7U717Les/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018269;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qEQX/xuxEsyc85D/lXfAfsoyshfmWrWvCcFKiiA3y3o=;
	b=Oa4tHAVMlMFB55qnfE4lcJbt+LF0WBn00xcBXLKYIqc7UXo9sZFDCDsPToydNZT3fKkd
	 UM2/pnVjwj/ZGfD7JjuJKfMuvKrCHQAzujeC9Dhyz6lwYAzxA2VUBAJuBUGZm8j6e4lHT
	 bgegspHvBWBZqomBUbxDCz2DjG/Zoh+/vA1xy8oCT4/hmNjPjJvZ6VR730t9bCalRLYlJ
	 2Zp+ZDxvmr5/bALErfx0M0GpAt/y98hj8FvYukoOSUDrhEN71wsXoxBtfA5ghdl8+KYTz
	 g+1VNGy/CZbUUvGTXV0KgyQ/UZ5zV1vIKIBptplkSp5SBhh/JsMX4DFX6tznsid2mXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.178
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F8606A31C
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 16:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D4F8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id D323258F5F2F8; Wed, 18 Nov 2026 08:10:53 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations
Date: Wed, 18 Nov 2026 08:10:53 -0800
Message-ID: <20261118161053.1768878-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
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

Fixes: 23b2a3a8f63a ("libbpf: Add enum64 relocation support")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/btf.h       |  5 +++++
 tools/lib/bpf/relo_core.c | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

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
index 2672623a4198..7aa7eb4e4021 100644
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
--=20
2.53.1-Meta

