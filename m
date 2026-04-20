Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD392264A9
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699398; cv=none; b=WAf0aaj0RrWIwPEZjMxDqzOCO2hAkuQASeZlr9bkAkrkzeMfdyC8+zRUE40/2nP0mbRKbxhme5PWySWk+1tAM96LbhupwSnc60F6l1TkO4zpMbqVaoLGD6qhsJLFFNTRnSW/2bZb++WkrvHef543hZbXwSz0fXnZlgg4j9onYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699398; c=relaxed/simple;
	bh=k+ottxoZps94DSX9qItnTOLdpr5XktfGOzXXvV/mjOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhKyJXL1hCOum9/z2TsXFzxX3wQeH5z119LApJHx0SFLG9KcV0XuJsBTdIzggLBX8j+pBPsOR6rzFfjbamRCvhDuPGcyX5ZrD433BkXr1WH0M36KHh2gSZ6NXqPKiRJ3zAL8mSh+JSbUMcpg9HF3kiZfm7H1pDIWqU65YYGIAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7SNE8+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7SNE8+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DB6C2BCB4;
	Mon, 20 Apr 2026 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699398;
	bh=k+ottxoZps94DSX9qItnTOLdpr5XktfGOzXXvV/mjOY=;
	h=From:To:Cc:Subject:Date:From;
	b=j7SNE8+QSgK/a4zudVM+Xfjt5IVtA6SaeW8V9ddpG7eIctsSeUBzbE2YJFCsLTu06
	 0IXloOlDunFeC6xfrctAEEJiCUfRbzOk47zV9QmOC4vScJ26Qx9qc0pInd3xQRRwbZ
	 An90uPd73GBTqgITp3Fun1qnh22JZRF2wugaJ1C6D1ZNZimEzc9yKun9QgZS4ivolO
	 zEM48mad8amqFj+tCa3Div2IzXIH3VszyPW0SXKeuRJkhiUxQOrH0q2fdLbPopxrIp
	 nxl3bI7eSsWzvqSvriMkh3r4ROKD97lC6RYxrlQ017gS+DizWYpEsTOjVtAckYRI5B
	 ps2VPznM1089g==
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
	"Yonghong Song" <yonghong.song@linux.dev>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 0/3] bpf, arm64: Support stack arguments
Date: Mon, 20 Apr 2026 08:35:58 -0700
Message-ID: <20260420153603.4097618-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set add support of stack arguments to the arm64 JIT based on the
preparatory work and x86 support in [1]. Arm64 allows passing 8
arguments in registers x0-x7 and remaining ones on stack. Currently, BPF
supports passing 5 arguments all of which map to x0-x4.

BPF passes arguments in R1-R5 which map to x0-x4 on arm64, BPF reg R0 is
mapped to arm64 reg x7, but as arm64 needs this register to pass
arguments now, the first patch changes the mapping of BPF reg R0 to x8
which allows passing arguments in x0-x7 (8 arguments). 9+ arguments are
passed on the stack.

Note: This set needs to be applied on top of [1]

All selftest pass:

  ./test_progs -t stack_arg,stack_arg_fail,stack_arg_kfunc,verifier_stack_arg
  #431/1   stack_arg/global_many_args:OK
  #431/2   stack_arg/async_cb_many_args:OK
  #431/3   stack_arg/bpf2bpf:OK
  #431/4   stack_arg/kfunc:OK
  #431     stack_arg:OK
  #432/1   stack_arg_fail/test_stack_arg_big:OK
  #432/2   stack_arg_fail/r11 in ALU instruction:OK
  #432/3   stack_arg_fail/r11 store with non-DW size:OK
  #432/4   stack_arg_fail/r11 store with unaligned offset:OK
  #432/5   stack_arg_fail/r11 store with positive offset:OK
  #432/6   stack_arg_fail/r11 load with negative offset:OK
  #432/7   stack_arg_fail/r11 load with non-DW size:OK
  #432/8   stack_arg_fail/r11 store with zero offset:OK
  #432     stack_arg_fail:OK
  #631/1   verifier_stack_arg/stack_arg: subprog with 6 args:OK
  #631/2   verifier_stack_arg/stack_arg: two subprogs with >5 args:OK
  #631/3   verifier_stack_arg/stack_arg: read from uninitialized stack arg slot:OK
  #631/4   verifier_stack_arg/stack_arg: gap at offset -8, only wrote -16:OK
  #631/5   verifier_stack_arg/stack_arg: pruning with different stack arg types:OK
  #631/6   verifier_stack_arg/stack_arg: release_reference invalidates stack arg slot:OK
  #631/7   verifier_stack_arg/stack_arg: pkt pointer in stack arg slot invalidated after pull_data:OK
  #631/8   verifier_stack_arg/stack_arg: null propagation rejects deref on null branch:OK
  #631/9   verifier_stack_arg/stack_arg: missing store on one branch:OK
  #631/10  verifier_stack_arg/stack_arg: share a store for both branches:OK
  #631/11  verifier_stack_arg/stack_arg: write beyond max outgoing depth:OK
  #631/12  verifier_stack_arg/stack_arg: sequential calls reuse slots:OK
  #631     verifier_stack_arg:OK
  Summary: 3/24 PASSED, 0 SKIPPED, 0 FAILED

[1] https://lore.kernel.org/all/20260419163316.731019-1-yonghong.song@linux.dev/

Puranjay Mohan (3):
  bpf, arm64: Map BPF_REG_0 to x8 instead of x7
  bpf, arm64: Add JIT support for stack arguments
  selftests/bpf: Enable stack argument tests for arm64

 arch/arm64/net/bpf_jit_comp.c                 | 91 +++++++++++++++++--
 arch/arm64/net/bpf_timed_may_goto.S           |  8 +-
 tools/testing/selftests/bpf/progs/stack_arg.c |  3 +-
 .../selftests/bpf/progs/stack_arg_kfunc.c     |  3 +-
 .../selftests/bpf/progs/verifier_jit_inline.c |  2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |  6 +-
 .../bpf/progs/verifier_private_stack.c        | 10 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  | 15 ++-
 8 files changed, 116 insertions(+), 22 deletions(-)

-- 
2.52.0

