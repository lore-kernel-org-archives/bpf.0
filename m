Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=69.171.232.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478728;
	b=NR6kcn3q8E1rp9aC+csuf5ajz6JoXTNx35eMElmmVpfoXl7gS9fFYLw4l43BP3N07SPY
	 Kvxtb9b/ZIUn0sGuqoRwqopBNqNVcvXhBJWSw97yydCZ2TPYjPFfDaA9fHHUrXjrqHkbK
	 nE9O1gqQkOjSnTglq9pJCgpa4KSIPTihfxZ3jT+UZwtB/d8lx5FDNJxgq5qjuepd7JwMf
	 Y90yMPYBgF9rgZ7QByjC7TQTeM7PnKOoPuEWbq6xu1Lqtwl5gRowuW+rjGKlMlYR+FJdr
	 Y6TtCogw3+ysii1lsrME2nOZTpCOLB5CYT0wKMUvxaimQSdXhuFy99X4fX//GyRCyYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478728;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+jrMj9cTwBpFasM+MTAFt7wSrL6hMS2Qjw7+3nEY9Pw=;
	b=jEztZBSohGOn4grD9VrEjaGUE+gGLEZiEJBDNOrkTOQUVSnlfXASFzxPs+mrrrBr5oky
	 oaML0/nAW8/B9gmCyOUsudjampqW/UvBV9/yw9/0SaupuqTqbs/HFE92pMoobStkFghAz
	 w/PC/EYxhWRbz3Enh1OvRgaEH/uWhKqhR6WqDdvs1kG+YWjND1GoNgFazJkoS/bCnhtA2
	 p4jUp5qW5Cmgq+Bdi7gfcBumeBpDZgP7p3T0iXFLp5BXlSr7cpT1GlXGmTnRQ5Zp2mRc/
	 tuW6zBnPDw9KgnY3hllwpYI/EVuSMbIvZyzRHgdD+FyEBZNO+xnV4YhXsuvUn13BkwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=69.171.232.181
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B054606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 00:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B054606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id 84A6C5989F91B; Mon, 23 Nov 2026 16:05:14 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 0/2] libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
Date: Mon, 23 Nov 2026 16:05:14 -0800
Message-ID: <20261124000514.2955878-1-yonghong.song@linux.dev>
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
object is refused. And a target value in that range is patched
sign-extended.

Patch 1 extends a 32-bit enum value according to the kflag of its enum,
i.e., sign-extends it if the enum is signed (kflag 1), and zero-extends
it otherwise (kflag 0), for both the local and the target value. The
kernel builds the same relo_core.c, so it gets the fix too.

GCC emits every 32-bit enum value sign-extended, since its
__builtin_preserve_enum_value() returns int, so a GCC object with an
unsigned enum value in [0x80000000, 0xffffffff] is now refused. That
needs to be fixed in GCC.

Patch 2 tests the unsigned enum values. With GCC, the test is skipped
if the target BTF has the unsigned enum.

Changelog:
  v5 -> v6:
    - v5: https://lore.kernel.org/bpf/20261120214957.868409-1-yonghong.so=
ng@linux.dev/
    - Extend a 32-bit enum value according to the kflag of its own enum
      in bpf_core_calc_enumval_relo(), instead of zero-extending the
      values in bpf_core_calc_relo() (patch 1).
    - Don't take a target value with the kflag 0 as signed if the local
      enum is signed, and drop its test (patch 3).
    - Don't accept the sign-extended form of an unsigned enum value
      emitted by GCC (patch 1), and skip the test with GCC instead
      (patch 2).
  v4 -> v5:
    - v4: https://lore.kernel.org/bpf/20261120165540.2074139-1-yonghong.s=
ong@linux.dev/
    - Keep the sign extension in bpf_core_calc_enumval_relo(), and
      zero-extend the 32-bit values of unsigned enums once in
      bpf_core_calc_relo(). This drops btf_enum_value() from
      include/linux/btf.h and the three helpers in relo_core.c. No
      change in behavior (patch 1).
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20261119232647.3392045-1-yonghong.s=
ong@linux.dev/
    - Take a 32-bit target enum value as signed if the target enum has
      the kflag 0 but the local enum is signed, for the BTF of kernels
      without enum signedness (patch 1).
    - Test it with a target BTF whose enums have the kflag cleared
      (patch 3).
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

 tools/lib/bpf/relo_core.c                     |  9 +++++---
 .../selftests/bpf/prog_tests/core_reloc.c     |  2 ++
 .../selftests/bpf/progs/core_reloc_types.h    |  8 +++++++
 .../bpf/progs/test_core_reloc_enumval.c       | 23 +++++++++++++++++++
 4 files changed, 39 insertions(+), 3 deletions(-)

--=20
2.53.1-Meta

