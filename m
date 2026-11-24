Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478733;
	b=jkxttCbuKHBYLqEvlXmL+30yBzzfFN22Tq8ufYmfvTmgo0mh16lZC/aIjaHtjgDueAZP
	 7n2fUG8gguYN0MS47V5lT8Vlp3jS7BsXbm4Gfj2Eu5uLwZltKfkuWwwgI1XxCJQY34eHA
	 8Nf4Y54+naPuOP/DEiXFV5oxe2rG/VbkrycxzSWxaxC2FNgZU86JJ9AX9xMhx89neA0cy
	 7Hmi1JVrSV3wg4e5eDB8DwErD4GemWusyex6Gjr56xyDvDAZU+kY0oTonvplFA0HYu0wf
	 POMwXeEZWvV/WZanBOFnHx96Ga968uHI5NQ3R4JBTyrx+3ayL+pVQttJ+yQoutduMyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478733;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F7TnRd6SDv8dAvQCFzn9Lst63D2VW8zXf69gbVCc800=;
	b=lCoTE/M3khqXGf/liwgwGMhKmzSYbGD+XXVkqHiZKKusJ5oi5heEd0LJ+uwOmlhmStuM
	 Roc6xXdRdZcX4bukA+h22Y+CRxxfD5Iw0aIR/x/svcGTfXjU8RWnk9gpTKmEuK++ciHWA
	 IZfN7tYAFLZ4Ia/G14OBF/bcyE1526lwaBgwX4eF4A4sRxQ9p9B733NElbYaYJM+C0lMh
	 6VMWQJJFxXuhY5sDX4LdbYgDwYyZA37wgW9yQGS3xn0X5DFG+KijJ15mFUaJGzvkY7MPK
	 0R5I/X5xk/u4vMhwVTrv1vf//GN2qwAiwAgrwhDwjhILh7e1v5iBVqd/tcEgQ/ROAfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.178
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD85606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD85606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 9BB1F5989F935; Mon, 23 Nov 2026 16:05:19 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 1/2] libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
Date: Mon, 23 Nov 2026 16:05:19 -0800
Message-ID: <20261124000519.2956216-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261124000514.2955878-1-yonghong.song@linux.dev>
References: <20261124000514.2955878-1-yonghong.song@linux.dev>
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
relocations, whose relo_core.c is also built into the kernel. Extend a
32-bit enum value according to the kflag of its enum in
bpf_core_calc_enumval_relo(), i.e., sign-extend it if the kflag is 1,
and zero-extend it otherwise, for both the local and the target value.

The kflag 0 is taken as unsigned. pahole records the signedness since
v1.24. The BTF of a kernel before v6.0 has the kflag 0 on every enum,
though, so a negative target value there is now patched zero-extended.

GCC sign-extends every 32-bit enum value in the ld_imm64, since its
__builtin_preserve_enum_value() returns int, so a GCC object with an
unsigned enum value in [0x80000000, 0xffffffff] is now refused. That
needs to be fixed in GCC, whose builtin should return long, as clang's
does.

Fixes: 776281652ddc ("libbpf: Permit 64bit relocation value")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/lib/bpf/relo_core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 2672623a4198..58c782cc60e8 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -866,6 +866,7 @@ static int bpf_core_calc_enumval_relo(const struct bp=
f_core_relo *relo,
 				      __u64 *val)
 {
 	const struct btf_type *t;
+	const struct btf_enum *e;
=20
 	switch (relo->kind) {
 	case BPF_CORE_ENUMVAL_EXISTS:
@@ -875,10 +876,12 @@ static int bpf_core_calc_enumval_relo(const struct =
bpf_core_relo *relo,
 		if (!spec)
 			return -EUCLEAN; /* request instruction poisoning */
 		t =3D btf_type_by_id(spec->btf, spec->spec[0].type_id);
-		if (btf_is_enum(t))
-			*val =3D btf_enum(t)[spec->spec[0].idx].val;
-		else
+		if (btf_is_enum(t)) {
+			e =3D btf_enum(t) + spec->spec[0].idx;
+			*val =3D BTF_INFO_KFLAG(t->info) ? (__s64)e->val : (__u32)e->val;
+		} else {
 			*val =3D btf_enum64_value(btf_enum64(t) + spec->spec[0].idx);
+		}
 		break;
 	default:
 		return -EOPNOTSUPP;
--=20
2.53.1-Meta

