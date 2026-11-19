Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=66.220.155.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065297;
	b=SYj7GFIWFdym1dpmiP1GpIU2E6YLysMLqscbQPdgG1FNQicE/6sdmxb1MZua+V3pA/67
	 0AH1RURqrh5VN3mzjajNzjDFJMgaK34HCZCV27UcJ38sPOuiCVPcYuM8gx0QEHuzWByN0
	 Up7JH09B3PHtRyNFIQiusWwoiwnHNv8HAwcwvC60UF843Jg4ThtyEPfv7tdAEL/dEwAuH
	 qNrUheC6Huz5fUO7eAVhZkA0hZ+jshUEhrI8GdFKjjJs0HV6+jaOn6kOLBbABbAVB2biM
	 KsACuxWMe+4RZxulCeNMdeDNwMJW/Wet0PD/AHXgNTjYgftRGEhojEQdN1bNnec+cog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065297;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zvgFRL0R8qNfTIrjmR9pZa9cP8z0qbZZGF0IqcsHhr8=;
	b=PS3ObeOhJDBUNtKWXW7N0ZGU6oo/rEap5t2vhUe2ISR/JRs6ENkLW8EU6z1sUgoyzEse
	 Z4bhwk6gU1HqDVflVJNhmifUO0hj5ky0IEjzWJ7vUdbNXQGMkbi7ajBqpXQlKOYo/rSGa
	 QFjNiW0WNAWaXcyGd9nPCbm407QJtohoGrHkf7HlaebqHhyUrJxOEYp4nhH7HYBMXdTdH
	 M4D70N7w84DMK8ugI6TbO9bgaQoo9xaDuiDNrCs33EW46F0tIRRuAs/7UjXjeqJl1qvea
	 LGk278p8VqDEb3CWwuUEuQcc2Z0TKfGNHPdMUWHiWRzbpZaV9+yNisabNhqWKwpQh7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.dev;
	spf=fail smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=66.220.155.178
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10672606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10672606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm50310.atn0.facebook.com (Postfix, from userid 128203)
	id A846559083B83; Wed, 18 Nov 2026 21:14:43 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 0/4] libbpf: Fix CO-RE relocations of unsigned 32-bit enum values
Date: Wed, 18 Nov 2026 21:14:43 -0800
Message-ID: <20261119051443.1902163-1-yonghong.song@linux.dev>
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
the fix too. Patch 2 tests it.

GCC emits every 32-bit enum value sign-extended, since its
__builtin_preserve_enum_value() returns int. So with patch 1 alone, GCC
objects that loaded before would be refused. Patch 3 accepts the
sign-extended form of an unsigned value and patches the target value in
the same form. Patch 4 makes the test of patch 2 work with GCC.


Changelog:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20261118161053.1768878-1-yonghong.s=
ong@linux.dev/
    - Accept the sign-extended enum values emitted by GCC (patch 3), and
      make the new test work with GCC (patch 4).

Yonghong Song (4):
  libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations
  selftests/bpf: Test CO-RE relocations of unsigned 32-bit enum values
  libbpf: Accept sign-extended 32-bit enum values in CO-RE relocations
  selftests/bpf: Take unsigned enum values as unsigned int for GCC

 include/linux/btf.h                           |  5 ++++
 tools/lib/bpf/relo_core.c                     | 30 ++++++++++++++++---
 .../selftests/bpf/prog_tests/core_reloc.c     |  2 ++
 .../selftests/bpf/progs/core_reloc_types.h    |  8 +++++
 .../bpf/progs/test_core_reloc_enumval.c       | 21 +++++++++++++
 5 files changed, 62 insertions(+), 4 deletions(-)

--=20
2.53.1-Meta

