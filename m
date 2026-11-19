Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795130821;
	b=QJSeoOSwbnjQgpNnMt6MPlVIlNn/zTumOZmD3yD+pdM31Zw/KdEnemq9/OseJA9sWJxQ
	 tm2/Q+PqqO7NY+hmu+NjJ/IgqbmHVjNp9EYkqVE2+fZU2g5V3P4lWN57345/kHbOgEUIm
	 /0cDT9HE/3x56IivTdT9FOq1qYLynnH3ESJCfojp2HuoMUHtkzuWWTvR7RYpK08KDTMmW
	 7qYt6/AA1jmBvPDe9fFiQ0DaRodKCjWXuGueS+XB35KZFgoIS6UJBIPInKyvPbe0NQgXk
	 ODOy2TAzXC9fQQ6cJB+aUQmjNWGLS+9KWgTdoMYYP4BOm53/EU0AFTqHcSxtb1UeAbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130821;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s/9H3IL1rfVGlbVyW/4at+ELioBltWZZTWJ4iiO5OfU=;
	b=NK5QMgFCHlIHaryrcNB7bP1eI4Q/wa0Mtb3YYJjiNKw8uKYVRE/1ndqJbECaC1Sf4Jnp
	 7g8+CFooJbJfa/1GC6/byXvIMfMbIseW2e7XWe9kWoD9sTr/ygRZf52gGJ0PaCh8BYrLB
	 5qGroYAsaMJrjyK6HKx0EEOdUFsxX0YFejR8bR/U0tnOJPJEvBqdohs1eQ6MwDi8Yc/Fi
	 Py+TGaeSpy0NGfGfL8uCJff3qxPHqGZuUC/3w+JkV1fMiqdblwEg6uHJ0VpprkDwLzEfp
	 3K87z0mmTJy2OycKnONweRmh/02pwzlnC7UCjvYtVJpiTBecT5lkaioM+Ot5Q9BDm6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.181
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9A3606A32C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A9A3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 8C3BA591B585C; Thu, 19 Nov 2026 15:26:47 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 0/2] libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
Date: Thu, 19 Nov 2026 15:26:47 -0800
Message-ID: <20261119232647.3392045-1-yonghong.song@linux.dev>
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

For a BPF_CORE_ENUMVAL_VALUE relocation, libbpf sign-extends the value
of a 32-bit enumerator even if the enum is unsigned. A value in
[0x80000000, 0xffffffff], e.g., DCACHE_PRIVATE of enum dentry_flags,
then doesn't match the zero-extended value clang emits, and the whole
object is refused.

Patch 1 extends the value as given by the kflag of the enum, which is
the form clang emits. The kernel builds the same relo_core.c, so it gets
the fix too.

GCC emits every 32-bit enum value sign-extended, since its
__builtin_preserve_enum_value() returns int. So with the change above
alone, GCC objects that load today would be refused. Patch 1 therefore
also accepts the sign-extended form of an unsigned value, and patches
the target value in the same form.

Patch 2 tests it, with clang and GCC.

Changelog:
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20261119051443.1902163-1-yonghong.s=
ong@linux.dev/
    - Fold patch 3 into patch 1 and patch 4 into patch 2 to avoid test
      failures when bisecting.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20261118161053.1768878-1-yonghong.s=
ong@linux.dev/
    - Accept the sign-extended enum values emitted by GCC (patch 3), and
      make the new test work with GCC (patch 4).

Yonghong Song (2):
  libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
  selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values

 include/linux/btf.h                           |  5 +++
 tools/lib/bpf/relo_core.c                     | 31 ++++++++++++++++---
 .../selftests/bpf/prog_tests/core_reloc.c     |  2 ++
 .../selftests/bpf/progs/core_reloc_types.h    |  8 +++++
 .../bpf/progs/test_core_reloc_enumval.c       | 21 +++++++++++++
 5 files changed, 63 insertions(+), 4 deletions(-)

--=20
2.53.1-Meta

