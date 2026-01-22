Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C448C412
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097719; cv=none; b=ArWWWukNfjw28+fNY+mnr2CduNd4JAXtVnKx1u1hSLZXthGr3yHxYIo7rE1UHFAa332m/cjYqoMl1Oo+OrJZ4j2EBXZXgd/AKWn9BVq3Qpkw8aTWB9VZjVC27Hm+5TOffj9OjEgQ9twiQsfieaCgp9LYYiYM1BsVBASVc2N0VMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097719; c=relaxed/simple;
	bh=KNCklaTtWp6MtXcbSHO5iNoMhwaJRFrkDro5LMMUwVw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C/CRAR78gYbAtfmd03mpIoL/+4oY+0p33TYFv/5tm5OmAZk7VuIrtJARrvueKNTE6Wq3CE3wy9vVqwr8DVtoXbZcpBWZEBpexYBEK9Za6vFjX9NifSEVu6wTitu8X/w2Aj3MohZy0PjkEREaS0luiU02R3bDguAdq9PnDjJhYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HgYbBWqn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HgYbBWqn"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MFC5lF2070343
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=msPLBceJlrta/eB1gS
	3AvzBZtaJuTqViqz6S39lXVKU=; b=HgYbBWqnqKfCII5URYdvxIBAVDs7SdxW23
	j6WBDnJvGmbXVKcyVZ//HWnpe//mYpa0aeRPXbfzdAlMQT9ePn7wSySreTHKSTdF
	IrNaVdJF78NQy5U1Blc3zBL61m72k/1G9YH42Y8eouwsGtFDMZIL9o3yjEW3xAH6
	HCH0IGHq65VWFA5qfZ1AsJvGlIoDo9ufYqIaeAmocn8MzxkBpi/OX6OdGy15+H/g
	kPghaqhDeGfjB/Vya4MdlQt2iObJF10cPkAfl+HgYtudo+TeCn3ZBG/A+MB9W5pC
	1z2EMMNujYK3ikVOYSvaTb6wrpIaGFu6FkJ42grDxAzYeJgkm3SQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bubagvbr5-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 08:01:52 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Thu, 22 Jan 2026 16:01:43 +0000
Received: by devbig002.atn3.facebook.com (Postfix, from userid 673679)
	id AE60510A69E7C; Thu, 22 Jan 2026 08:01:40 -0800 (PST)
From: Emil Tsalapatis <etsal@meta.com>
To: <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <daniel@iogearbox.net>, <memxor@gmail.com>, <puranjay@kernel.org>,
        <song@kernel.org>, Emil Tsalapatis <etsal@meta.com>,
        "Emil Tsalapatis (Meta)"
	<emil@etsalapatis.com>
Subject: [PATCH 00/13] bpf: Add arena ASAN runtime and BPF library
Date: Thu, 22 Jan 2026 08:01:18 -0800
Message-ID: <20260122160131.2238331-1-etsal@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qtGxcAMVOsL2Mt_REJQrIGwxaB5Fy0wp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDEyMiBTYWx0ZWRfX1NC8jhWXqa4z
 5yZRYzeo/fGwli8lxZIWg+RM9GaZ/9Bo5jihYc0zA+CPa0T+EEFkSbVoVg4AfnD2lj8atvazqjo
 iBn/A0BTC7D/FYVajfElZ8nrfENZlpxk6iJh+acxRO2nBOczGpr0hlSK9xCQZkfUi9xlCZjdgS6
 K0eodmX2OehLJfOVKu+6s28BVU+CLSi5y6vwdIA9OKuUR7dkT0zFq2KIxKOK3sq+ug6EvogwwNV
 rCg5TLwiywXSeHbS3xnPKM/5CWV3+IhvZ7WT9aUz8ys3IJsZ5VQEzDap7mJW/P+spITJ5RjHm5U
 JA+kVKqrbdsN2O8P0bU4ivrvvUpI4T7nZnxkz0cA6UXai2WaU5dJ4c5QqdNI75piwTA1qPSMvK5
 HJKmNnnUQWwezzat0spiVGsxJ3U3yUJgXiI4/iVnYNwgRPke8x607x+qm9NC1ESkZtFRnAHi7Kh
 rcj0G46jhp8LQwXOwrQ==
X-Authority-Analysis: v=2.4 cv=UJnQ3Sfy c=1 sm=1 tr=0 ts=697249f0 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=CWErhr8FAAAA:8
 a=YkWjfBbht6tmykpPiBoA:9 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-ORIG-GUID: qtGxcAMVOsL2Mt_REJQrIGwxaB5Fy0wp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01

Add a new subdirectory to tools/testing/selftests/bpf called libarena,
along with programs useful for writing arena-based BPF code. This
patchset adds the following:

1) libarena, a subdirectory where arena BPF code that is generally useful=
=20
to BPF arena programs can be easily added and tested.

2) An ASAN runtime for BPF arena programs. BPF arenas allow for accessing=
=20
memory after it has been freed or if it out of bounds, making it more=20
difficult to triage bugs combined to regular BPF. Use LLVM's recently add=
ed=20
support for address-space based sanitization to selectively sanitize just=
=20
the arena accesses.

3) A set of memory allocators that can be reused by BPF programs to handl=
e=20
memory allocation/deletion. The allocators use the ASAN runtime to add=20
address sanitization if requested.

The patch includes testing for the new allocators and ASAN features that
can be built from the top directory using "make libarena_test" and
"make libarena_test_asan". The generated binaries reside in libarena/.

The structure of this patch is:

1-2: Add BPF Streams kfunc for dumping the current program stack, and
allow BPF Streams kfuncs to be callable while holding a lock.

3-4: Minor changes to the /testing/selftests/bpf directory headers to
prepare for the introduction of libarena.

5-7: Add the base libarena directory and testing scaffolding, and
introduce the ASAN runtime.

8-9: Add a arena memory bump allocator along with testing. This
allocator is used for permanent allocations during program init.

10-11: Add a stack page-oriented allocator along with testing. This=20
allocator is used for repeated large allocations to avoid constant
bpf_arena_{alloc,free}_pages calls.

12-13: Add a buddy allocator along with testing. The allocator acts as a
general allocator for arena-based BPF programs.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (13):
  bpf: Add bpf_stream_print_stack stack dumping kfunc
  bpf: Allow BPF stream kfuncs while holding a lock
  selftests: bpf: Move bpf_arena_spin_lock.h to the top level
  selftests: bpf: Make WRITE_ONCE macro in bpf_atomic.h conditional
  selftests: bpf: Add basic libarena scaffolding
  selftests: bpf: Add arena ASAN runtime to libarena
  selftests: bpf: Add ASAN support for libarena selftests
  selftest: bpf: Add bump allocator for libarena
  selftests: bpf: Add libarena selftests for the bump allocator
  selftest: bpf: Add libarena stack allocator
  selftests: bpf: Add selftests for the libarena stack allocator
  selftests: bpf: Add buddy allocator for libarena
  selftests: bpf: Add selftests for the libarena buddy allocator

 kernel/bpf/helpers.c                          |   1 +
 kernel/bpf/stream.c                           |  13 +
 kernel/bpf/verifier.c                         |  13 +-
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 tools/testing/selftests/bpf/.gitignore        |   2 +
 tools/testing/selftests/bpf/Makefile          |  24 +
 .../bpf/{progs =3D> }/bpf_arena_spin_lock.h     |   4 +-
 tools/testing/selftests/bpf/bpf_atomic.h      |   2 +
 tools/testing/selftests/bpf/libarena/Makefile |  69 ++
 .../selftests/bpf/libarena/include/asan.h     | 133 +++
 .../selftests/bpf/libarena/include/buddy.h    |  62 ++
 .../selftests/bpf/libarena/include/bump.h     |  20 +
 .../selftests/bpf/libarena/include/common.h   | 118 +++
 .../selftests/bpf/libarena/include/stack.h    |  44 +
 .../selftests/bpf/libarena/include/userapi.h  |  23 +
 .../bpf/libarena/selftests/selftest.c         | 328 ++++++++
 .../bpf/libarena/selftests/selftest.h         |  17 +
 .../libarena/selftests/st_asan_buddy.bpf.c    | 238 ++++++
 .../bpf/libarena/selftests/st_asan_bump.bpf.c | 193 +++++
 .../bpf/libarena/selftests/st_asan_common.h   |  49 ++
 .../libarena/selftests/st_asan_stack.bpf.c    | 253 ++++++
 .../bpf/libarena/selftests/st_buddy.bpf.c     | 231 ++++++
 .../bpf/libarena/selftests/st_bump.bpf.c      | 275 ++++++
 .../selftests/bpf/libarena/src/asan.bpf.c     | 463 +++++++++++
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 784 ++++++++++++++++++
 .../selftests/bpf/libarena/src/bump.bpf.c     | 212 +++++
 .../selftests/bpf/libarena/src/stack.bpf.c    | 338 ++++++++
 .../selftests/bpf/progs/arena_spin_lock.c     |   2 +-
 28 files changed, 3909 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/bpf/{progs =3D> }/bpf_arena_spin_lock.h (=
99%)
 create mode 100644 tools/testing/selftests/bpf/libarena/Makefile
 create mode 100644 tools/testing/selftests/bpf/libarena/include/asan.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/buddy.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/bump.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/stack.h
 create mode 100644 tools/testing/selftests/bpf/libarena/include/userapi.=
h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selfte=
st.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/selfte=
st.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_bump.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_common.h
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_asa=
n_stack.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_bud=
dy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/selftests/st_bum=
p.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/asan.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/bump.bpf.c
 create mode 100644 tools/testing/selftests/bpf/libarena/src/stack.bpf.c

--=20
2.47.3

