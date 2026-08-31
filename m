Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A21334104E
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176781; cv=none; b=bqlD3IyAl0/pyfrMxfvXW2DvqEKpc8It5ojdDlPA4r4l3cjkpI1rVCfBvVqCpKF86MWfN6U3IDaZhv0zyUy+V/9sBFkGyk0XhibR1lC771sJQ5SrlC7Ts99gG7/nmLMSR3EvCfNA6bo8frK9L1tmENKVWwFLWLv1M95chc3HW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176781; c=relaxed/simple;
	bh=Wantihy7kBtRItPmWja+nw9sRtnBLqYqIP+NryRzGt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IH3+DkG7HzbUzmlhrjq/01yPbK80s+C/sbacZ6FNZ1pe2u9QPa1+O3krnoMXdBJpuDQiARxnDGdnubDePsODF4pRH8OPDOICCeY5UG2tUabrrdJUBPHxuLUjHF+tvPsi7DyL+jZ5teF8sb1Bx73nyJEhUWXVaANWqwUGDVDEo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idk3B8sf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idk3B8sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640DD1F000E9;
	Mon, 31 Aug 2026 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788176779;
	bh=+Up/p4BkQ5QfGVGLrLdElq6kBl1CACZkQT06Hh1qqy0=;
	h=From:To:Cc:Subject:Date;
	b=Idk3B8sfFbCa7WJwjqt3KqFooxdUQIMocbPuSkqX82n6UDZJu6tpnJuyHXNbtc5SY
	 b0QNAxVtwMZb+IMymCkGGTC3kNAF4tvKiFKzARCYpUTCM7U+MVcWY80d0Z3Xwn6Z3v
	 sNQX+6Bds7lmb5839y3o6is/K+cK5d+UPrHS3nqUlrgGv49bpkj/FcLSfTxi7iKvhi
	 LuOZHjHyejmmlBjk12Um6+SA9s4x0+bSMIxBfJ82G1LoocTaWJHNK8yEV/DXYEfE1s
	 gn/zKnGFyayTumMWZPbQ3LJKKIXHzE/a/thWRVUXY7FYCkwSSNW3Cn+/7xxOU0VKXY
	 r/gTDGTTQyotA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH bpf-next 0/3] bpf, x86: Add jit dry run mode
Date: Mon, 31 Aug 2026 13:46:11 +0200
Message-ID: <20260831114614.157277-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we recently hit performance issue in arch_bpf_trampoline_size,
that Mike fixed in [1].

I wondered we could go completely without emitting jit code for
getting just the trampoline size as we do on arm and it turned
out it actually makes the tracing_multi attachment benchmark
much faster.

With current code:

  # ./test_progs -t tracing_multi_bench_attach -v
  ...
  serial_test_tracing_multi_bench_attach: found 55227 functions
  serial_test_tracing_multi_bench_attach: attached in   1.563s
  serial_test_tracing_multi_bench_attach: detached in   0.256s

With the fix:

  # ./test_progs -t tracing_multi_bench_attach -v
  ...
  serial_test_tracing_multi_bench_attach: found 55235 functions
  serial_test_tracing_multi_bench_attach: attached in   0.798s
  serial_test_tracing_multi_bench_attach: detached in   0.258s

thanks,
jirka


[1] https://lore.kernel.org/bpf/20260818130510.3110054-1-rppt@kernel.org/
---
Jiri Olsa (3):
      bpf, x86: Split x86_call_depth_emit_accounting in two functions
      bpf, x86: Introduce JIT emission context
      bpf, x86: Add support for jit dry run

 arch/x86/include/asm/alternative.h   |   4 +-
 arch/x86/include/asm/text-patching.h |   2 +
 arch/x86/kernel/alternative.c        |   2 -
 arch/x86/kernel/callthunks.c         |   7 +-
 arch/x86/net/bpf_jit_comp.c          | 864 ++++++++++++++++++++++++++++++++++++++++---------------------------------------------------
 5 files changed, 381 insertions(+), 498 deletions(-)
