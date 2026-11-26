Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715779;
	b=iuj7+Q6M4ZRBFiv77IBq4Yflhuq/H22tU4NBshrVZxnhVuKNTh2KxvZRuoPGk4p8l9VJ
	 zV26dNuStajsFmmPtwOBHudt2D6YMySoDcsSvtb9b14lr50GXDQ/4RZnlBDMZ9Y9cRJem
	 IMDXvOGGCS1sqU1wPLA/1wP4+tB1GlqSXqjYg95z0TXC9PKMzcyKEyXQgM27XpyUXXVa3
	 Gw243emme6i8HI+Ehzj3K/rEtIk+VgBM9njDfvCSa9ltL9p22YvP57dt1x5X2qh+hM/YY
	 Nkq6KqJMyLnYPsdyEAg3dFkqzhuy83XFG8X8JBvSEl/4pzteIqv9Na7FFPXdWe5V+Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715779;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xvkr2w9ZrHSQq/srAMCVEIrZiy/cjINMUtLFY8GXTaM=;
	b=afWA+uBf70AgQhYvhDs7J+sBsxW2v6cM0o07aaTDpKx1sf5b5PIa5U2DWoFymjdN5jyk
	 33Jb9kqKoVG8dcXAAnLekmjUCJ+bfgF424RdGhLSP1mkKuglz5dfftKQY2pne8Rr2ImLx
	 lOZmznv0DFrgmMgJn3ieDTnOrzezE1nxHnjDxYHUG++4jfMIUAWGLYBUk+eLq5fsRwiFp
	 eqzwQkclzb6DSJ9zbwcJD1L/T1aSvkA/O6Orz9h62HiCHEmZHyVExUnzulUa8yKt+qDo5
	 iCYnh2DPf6Or4rWTLnisn+EbcrOyG3mYL/HVkyILSXx0licpd1OvdRtopcPDQioYMMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.178
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F351606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 17:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F351606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id C24E259E0473D; Thu, 26 Nov 2026 09:56:02 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 0/3] libbpf: Check enum value relocations against the local enumerator type
Date: Thu, 26 Nov 2026 09:56:02 -0800
Message-ID: <20261126175602.1882988-1-yonghong.song@linux.dev>
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

Clang now accepts the preserve_access_index attribute on an enum, see
llvm commit c080a0b9b673. Each reference to an enumerator of such an
enum gets a BPF_CORE_ENUMVAL_VALUE relocation, and the compiler converts
the relocated value to the type of the enumerator, e.g., uses only its
low 32 bits for an int. libbpf patches the 64-bit target value without
checking that it fits in that type, so a target value out of its range
becomes a different value: 0x100000000 becomes 0 for an int enumerator,
and 0x80000000 becomes negative. The program loads and uses it without
any error.

Patch 1 poisons such a relocation, as is done for a missing enumerator,
so the program is rejected only if the instruction is reachable. The
type of the local enumerator follows from the local enum, as in C: int
if all values of the enum fit in int, which includes the 1-byte packed
and mode(byte) enums in the kernel, and otherwise the type of the enum.
The check also applies to bpf_core_enum_value(), since libbpf cannot
tell the two forms apart.

Patch 2 tests relocations that still work, where the target enum differs
from the local one in size or value range. Patch 3 tests target values
out of the range of int, unsigned int and long enumerators, which make
the load fail.

Yonghong Song (3):
  libbpf: Poison an enum value relocation out of the local enumerator
    range
  selftests/bpf: Test enum value relocations within the local enumerator
    range
  selftests/bpf: Test enum value relocations out of the local enumerator
    range

 tools/lib/bpf/bpf_core_read.h                 |   5 +
 tools/lib/bpf/relo_core.c                     |  88 +++++++++++-
 .../selftests/bpf/prog_tests/core_reloc.c     |  45 +++++++
 .../btf__core_reloc_enum64val___err_sign.c    |   3 +
 .../btf__core_reloc_enumval___byte_unpacked.c |   3 +
 .../progs/btf__core_reloc_enumval___enum64.c  |   3 +
 .../progs/btf__core_reloc_enumval___err_int.c |   3 +
 .../btf__core_reloc_enumval___err_too_big.c   |   3 +
 .../btf__core_reloc_enumval___err_too_small.c |   3 +
 .../btf__core_reloc_enumval___err_uint.c      |   3 +
 .../btf__core_reloc_enumval___negative.c      |   3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 126 +++++++++++++++++-
 .../bpf/progs/test_core_reloc_enumval.c       |  14 ++
 13 files changed, 294 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val___err_sign.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___byte_unpacked.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___enum64.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_int.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_too_big.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_too_small.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_uint.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___negative.c

--=20
2.53.1-Meta

