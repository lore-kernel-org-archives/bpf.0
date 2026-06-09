Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF03350A18
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023202; cv=none; b=WNSik5x9S6Ejx2EUsOwZWEgwiz9T/IwfVruWXFOn3pMQRQdrFB8iyaRNWJizvpG75gUr1JZuNX30SdzFh8zv7G2zZLJAusI2mp2cMnyLFX6xh5fb+1DZ0Ke/bQxd6YkEWJhCvtLpm5M7Jfvc/Off8otF7ZxKXZh4fS3qShHKDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023202; c=relaxed/simple;
	bh=C3YVjTse3I/HE/4emDS7+775DuoxWp+m+8J3ueRtkGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wo1A1rdlHSTGC/S+aG23zqluEroXo2J3z45xd3/yV3hkvlBXwKRKIbvlRdVJ5YeNen9xg2Lm2iO47rnzjy9McVguYg1/Krb6QPwglZs7cEB3v4pngIVtG9TlUtTOCq8LvM7YAwNC0HZQD3RP1eYPjW7eZ/7x2vSXAzRBfvQPOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 4B98814982C44F; Tue,  9 Jun 2026 09:39:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 0/3] selftests/bpf: Fix tests for llvm23 true signature
Date: Tue,  9 Jun 2026 09:39:47 -0700
Message-ID: <20260609163947.1717694-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM23 ([1]) records the 'true' function signature in BTF, i.e. the
signature inferred after optimization rather than the one written in C.
This caused two kinds of selftest failures (see below).

Case 1: keep int return type for tailcall subprogs (patches 1 and 2)

The verifier requires any subprog that issues a bpf_tail_call to return
an 'int' (see check_btf_func() in kernel/bpf/check_btf.c, which rejects
it with "tail_call is only allowed in functions that return 'int'").

Several tailcall subprogs do 'return 0' (or another constant) whose
result no caller uses. With llvm23 the compiler folds the constant and,
since the return value is dead, optimizes the subprog to effectively
return 'void' and records 'void' in BTF, so the program fails to load.

Modifying bpf_tail_call_static() (in bpf_helpers.h) to return 'int' and
adding a trailing 'return 0' does not help: the compiler still sees a
constant result and can change the caller's return type to 'void'.

Instead, use barrier_var() so the returned value cannot be folded into a
constant, and make the value live by storing it into an array map or a
global variable (where the caller does not already consume it).

Case 2: adjust tracing prog ctx layout for the true signature (patch 3)

test_pkt_access_subprog2() has an unused argument that llvm optimizes
away. Before llvm23 the BTF signature did not match the optimized
assembly, so the verifier fell back to MAX_BPF_FUNC_REG_ARGS (5) u64
arguments and the fexit return value sat after args[5]. With llvm23 the
true signature has a single argument, so the return value moves to the
slot after args[1]. Select the matching ctx struct based on
__clang_major__ so the test works with both old and new llvm.

  [1] https://github.com/llvm/llvm-project/pull/198426

Yonghong Song (3):
  selftests/bpf: Keep int return type for tailcall subprogs with maps
  selftests/bpf: Keep int return type for tailcall subprogs
  selftests/bpf: Adjust fexit_bpf2bpf ctx layout for llvm23 true
    signature

 .../selftests/bpf/progs/fexit_bpf2bpf.c       | 13 ++++++++++--
 .../selftests/bpf/progs/tailcall_bpf2bpf2.c   |  5 ++++-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   | 21 +++++++++++++++----
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   | 18 +++++++++++-----
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   | 11 +++++++---
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c | 20 +++++++++++++++---
 .../selftests/bpf/progs/verifier_sock.c       |  9 ++++++--
 7 files changed, 77 insertions(+), 20 deletions(-)

--=20
2.53.0-Meta

