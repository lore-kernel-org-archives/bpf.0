Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541354CF69
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182391; cv=none; b=UG9Mg4eF5QWAW58aAj8rQceA108Jq2V3PxMORVbjgHNh78XCdIRnOyO+yOCOvtYtssNLt+gUvje60POPXQHsREnR1YeITD99DnCg5SMZJDic9OKNcBWQtkNi3nIOfi7s+2mvGUhHYwJxcGjYoOxcwgnlNJRPhadi7U/7JwS2gvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182391; c=relaxed/simple;
	bh=PD3nlC5eY8SaTnCr1Vmc5nDyvaL6fN4wbimoAhFvlNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLdkRL5U/OqKFVb7EfoDHt4fYDcwEDoR6m14s8nTBdh3GCK3sfztCCLa8nJ/6g8FyK799r98bgqpj0LUR6sgrtS+9U6F2oZ2EjbeghN8CxNab4u7nw3PYznja621XxPc3F6x7PuTehokY4Q7aVsaQvUc+Ak4yINdgtjh6LirX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdjKoMHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdjKoMHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99751F000FF;
	Wed, 23 Sep 2026 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182390;
	bh=p/+EcWB/fzsPpxw7Gkqd/N0Wn3uHZqy15xSoGrVSz38=;
	h=From:To:Cc:Subject:Date;
	b=WdjKoMHNKegiKFFV1VRnUivavl1xlcjCa068jCQlhq7Rmediv/zJY9a206iyZi9+L
	 jxx7z8Go7miVuN8YM4TM0/7N7PluBkMqc4BbY5uPYYt9QPOILonObIM/7ULG8vVz7c
	 nMu8w7C4gRV5psK4F2/C1trKlKS3/UDw7gOT6RoBCDnRH33jSo1oPsERrG5QuwJa/4
	 ze/TSFPHzQPZh3yuZ6ATl1cZGzG1YNTKWzhguSAew41sbb+h8sEDg/UHUNKElYYkrd
	 HjOpYvESiYtB2H454IC4YjX4Pjz01nog/aavYPO6KqiVRpYkGbo61VIZjaqRljIPxW
	 hV83XfP6gZmcQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 0/2] bpf, x86: Support fetching AND/OR/XOR atomics in arena
Date: Wed, 23 Sep 2026 09:52:58 -0700
Message-ID: <20260923165301.3463007-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A fetching AND/OR/XOR against arena memory is rejected on x86-64:

  BPF_ATOMIC stores into R1 arena is not allowed

x86-64 has no single instruction for these, so the JIT lowers them to a
CMPXCHG loop. The loop performs two memory accesses, the load of the old
value and the CMPXCHG itself, and either can fault when the arena page
goes away. The verifier reserves one exception table entry per
instruction, so there was nowhere to record the second one and
bpf_jit_supports_insn() refused the three opcodes instead.

x86-64 is the only architecture that needs this. riscv64 has native
AMOAND/AMOOR/AMOXOR with fetch, s390 has LAN/LAO/LAX, and arm64 with LSE
has LDCLRAL/LDSETAL/LDEORAL, so all three already accept these in an
arena. arm64 without LSE rejects every arena RMW atomic and is unaffected
either way, since the CMPXCHG that such a lowering would need is not
available there in an arena either.

Patch 1 emits the loop with R12-indexed addressing and gives each of the
two accesses its own exception table entry. Both entries resume past the
whole loop rather than past the faulting instruction, with the fetch
destination cleared, so a fault cannot re-enter the loop. The JIT accounts
for the extra entry itself by rescanning the instruction stream in
bpf_int_jit_compile() before the extable is sized; s390 does the same in
bpf_jit_alloc() for its BPF_XCHG lowering.

Patch 2 makes the selftests actually cover this. The existing arena
and/or/xor tests discarded the returned value, so clang emitted the
non-fetching instruction and the fetching one was never exercised. That
was deliberate: commit 2897b1e2a2f4 ("selftests/bpf: Fix arena_atomics
failure due to llvm change") switched them to __c11_atomic_fetch_*() with
memory_order_relaxed specifically to obtain a non-fetching instruction,
because of the limitation patch 1 removes. They go back to plain
__sync_fetch_and_*() and check the old value, x86 is dropped from the
exclusion list of the uaf test that covers the fault path, and a new
fetch_r0 test pins the two register assignments the JIT special-cases.

Puranjay Mohan (2):
  bpf, x86: Support fetching AND/OR/XOR atomics in arena
  selftests/bpf: Test fetching AND/OR/XOR atomics in arena

 arch/x86/net/bpf_jit_comp.c                   | 255 ++++++++++++------
 .../selftests/bpf/prog_tests/arena_atomics.c  |  32 +++
 .../selftests/bpf/progs/arena_atomics.c       | 114 +++++---
 3 files changed, 286 insertions(+), 115 deletions(-)


base-commit: 91f8613d95ad8cd99d8baf094806d1ef98bc6380
-- 
2.53.0-Meta

