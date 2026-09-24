Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601B346AC2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292695; cv=none; b=Np86GU8p4VBmXBehLlIn/WSj2M/LZjFsBdCaK3a34qIbzccpnpYDsFy0Ve/iC0cspuDkiXvvwRJ6RjQGwyI2LF8ep7bXAvZM0sfKv9v8sj4eWkgp+1lx2jSYO6j282aFmjnZl7DwKaYxp/4K51VmRwccaJNDegbk5lM5QxuXRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292695; c=relaxed/simple;
	bh=9U5d0DR93R+3c+sA35ipF7ce4bYky6vL8I5UqYNW1Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=evgQj2Qlr5MksoIoZVwTVX2nAqwPy2Uf0GrlYbWVheEboxa1GHZv97ie/xYKWycEdjpaR2w+PhlzRd4LyHKyO61przC9HfLDjXSZaz5IAn5l/m6Da5d5itFtvvEEhE+br/RfS3I0FWx0+I7lGYnXt8Zm+/BVKeu2eUmLb+IQStE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb+gdcxm; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb+gdcxm"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc750a1482fso149827a12.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292693; x=1790897493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PRkozvrQXS8xSqqde+wJ1uDxM9qr65gNpeV1Hy5LLfA=;
        b=Sb+gdcxmdC7tmdW35bVGaKyV9PhAsEVQW8SBgdWUdkofEA/iJ33Cxf58RHyoydqppf
         0YBa8SiJxVwE/S4epxLT7sWn2t6szYHCnarivKSYMBCV3aySbzKihQZYIWNdYtDuGgIL
         hg4crYWBLWpaOGfN9oz9BHX1oIIJ2yDmgoNZEkYvvSgvnlpqNxFBxWiN0qn72woUGaQ2
         rsYzSaOsG/fqQVCKWZ5XyvYalTJeAdbSLyVd7YyYJpI2Em0aHXv2F7+HbfBxvtM43lOx
         9yDqdCYsReUn2QP9e3nWlS+fgpCiasdQ7f89oWxMCW2erPfAmo/BRj7nGBxlmXOOQx10
         sbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292693; x=1790897493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRkozvrQXS8xSqqde+wJ1uDxM9qr65gNpeV1Hy5LLfA=;
        b=oyGlGOzVqYh7/8Ai7qAkE65bCj9laNaLSqnlHWWdQ1fk71KNCd7pZBSa0t4aFZeuNj
         gpTQAoXZqJBJK+cAvMFByy4boMtOyJZ4Ym10SVPCc7RVNL7Zdvr8YLIUi1WVhF6AuacS
         kTprWokVD7/56rVeMQaaCsV9uNgfiBi/p0BPJ8uwP9wh5fCe+wuJlEG0KRhnp0tc1ATz
         L0Fszrpcjxx2NoDACBF8UlBQyvs2wsOTZIBYMFfYNpQJnGbcDmxVooHDA/AI81BQSRwW
         B9+2yh8UcQuJUCc9IpPIXIe/8p7bEVPtbO2h+JDABLQYR6pj8/JeMZ546RzN4izZLXVo
         xpUw==
X-Gm-Message-State: AFuF++ntsIC7wEAD2J2vQZab1nWBKrrhlyFFH8r9kQ4GCeKssECc6/NN
	kaTsQ/ITaqHOUNqFf3O7zv3Hz65x1VCr+U6WbvdCihTDJBBViw3ZJn+8rIr9Hg==
X-Gm-Gg: AYBFou0iTks+DJ/l/LX0aqrWnKXo632AhW2IObg4TNr/mZcVct8J/dwkV419sWtYtkQ
	eC68N2iS39bprNQc1v44kOfxmt2XIBtxKIu2eM6sw1AvtOp08s4sYJO0o8l51Zsqvaei7yn/793
	l0F5KRMRUllFrF7u7gq4wE8UPKycjM3qEtSOi1xfeORlUQgWJLigVfxhi6bVZkwCb7blwg/A0Xf
	ShGQ/zF/E17hBtf+ptWqxz7A5iU8YxGnF/N7qoD8/DzCZanE3BUg+XeVfs0XW4jnYkqouFCPNnA
	qATlj2AFYdAteBDaCDpjQJViVt4mhleMgtc8J7PanEdKCW6AOZQgfB+oH2cERHvWEQJjWBsm88h
	WLMMo9rzq5r1FjAGgO5rJXv8qwYB8qoXaoWY7+JH4pMlFg8hiHqPJowp7VNLGUZJ2c0r4Tt8lm1
	rQBaa3wRkwyTOmFkkxxuMDN/42+7h51cTaz8t+Z/QmlhUzyXnAuN/+vQx3Q750Urylq21KmeL5c
	SBKxJrDK4jvXtpd4YORRRN1I/MWYSzYENKAC7m9nw656ZFKbZ/PKIpxdpWHH7q8QxqchvTOYYoE
	qMGl3jWAPM2aI5WQY0TOBmecZ5MgblQrj5/BOLQCfa8b8A==
X-Received: by 2002:a17:90b:264d:b0:3a0:3673:dbc0 with SMTP id 98e67ed59e1d1-3a0bb6325cemr307553a91.49.1790292693121;
        Thu, 24 Sep 2026 16:31:33 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efaeb3sm884068a91.2.2026.09.24.16.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/8] bpf: Fixes for may_goto, insn patching and iterator loops
Date: Thu, 24 Sep 2026 23:31:22 +0000
Message-ID: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Fixes for four bugs in may_goto, in patching of insns and in
convergence of iterator loops, each followed by its tests.

Patch 1: arch_bpf_timed_may_goto() on x86 computes the address of count
and timestamp as rbp + offset. The prog with private stack keeps its
stack in r9, so bpf_check_timed_may_goto() reads and writes the kernel
stack, where r0-r5 have just been saved.

Patch 3: [ST, ST, first insn] that inits may_goto count and
[nospec, insn] move the insn down inside its own patch.
bpf_adj_branches() doesn't look inside the patch, so a call, ld_imm64
of a func or a jump that points backward lands short of its target
by the number of insns in front of it.

Patch 5: may_goto is expanded into a conditional jump with off + 5,
off + 2 or off - 1 stored into 16 bits without a range check.
may_goto +32763 jumps backward when it expires.

Patch 7: states_equal() matches ids through idmap, so the loop is
assumed to converge at bpf_iter_*_next() when the iterator was
destroyed and created again since the old state. The prog that never
ends is accepted.

On x86-64 without the fixes may_goto_priv_stack, may_goto_far/32767,
may_goto_far/-32768, both new tests of verifier_may_goto_1, "nospec in
front of a call" (unpriv) and four "iter: remake ... jump to next"
tests fail. With the fixes they pass.

veristat on selftests, 5477 progs: no prog changes its verdict except
the new "iter: remake" ones. Patch 7 adds insns to 16 progs that
call bpf_iter_*_next() in a loop: 11010007 -> 11011495 insns in total,
test_copy_from_user_dynptr 342 -> 470 is the largest in percent.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Alexei Starovoitov (8):
  bpf, x86: Fix timed may_goto with private stack
  selftests/bpf: Add test for timed may_goto with private stack
  bpf: Adjust pc-relative insn copied into its own patch
  selftests/bpf: Add tests for pc-relative insn copied into its own
    patch
  bpf: Fix overflow of jump offset in may_goto expansion
  selftests/bpf: Add tests for may_goto with far target
  bpf: Don't converge a loop on an iterator that was created anew
  selftests/bpf: Add tests for iterator created anew in its loop

 arch/x86/net/bpf_jit_comp.c                   |  12 +
 arch/x86/net/bpf_timed_may_goto.S             |  10 +-
 kernel/bpf/fixups.c                           | 123 ++++--
 kernel/bpf/states.c                           |  14 +-
 .../selftests/bpf/prog_tests/may_goto_far.c   |  92 +++++
 .../bpf/prog_tests/may_goto_priv_stack.c      |  41 ++
 tools/testing/selftests/bpf/progs/iters.c     | 382 ++++++++++++++++++
 .../selftests/bpf/progs/may_goto_priv_stack.c |  52 +++
 .../selftests/bpf/progs/verifier_may_goto_1.c | 121 ++++++
 .../selftests/bpf/progs/verifier_unpriv.c     |  37 ++
 10 files changed, 848 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/may_goto_far.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/may_goto_priv_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/may_goto_priv_stack.c


base-commit: 93df8ae3267f19bf0c1135d26a0e21145dd0ea1c
-- 
2.55.0

