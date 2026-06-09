Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C640D575
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048058; cv=none; b=cXvra4sooxmP+jgXUgqabKAVF0K6YPMETJO0VzIa3etYY1NqVfP1R9XFdmLap6PhhW1J/ijUy7aF9GVLLobCnG/bY7pzkbobJPwqor2q2fafctS3x1I+iFO1hKOiWE/QO/3yJLMzq7msZnvk9Wp5KQEGiz4AEzmYu+vV+hiJqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048058; c=relaxed/simple;
	bh=UkZa0/ORKID80KWsZgW5Y/vTIEa2SAPFlhsABfrZmmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q8zjY8+GD5UBpvzL2x/vozpgvbo4jDZ8R6c8FuV84/1iZ8yu73WkMwKu9GKLuKNZjtcnNeCxZ4eGSCvps33AsrTo5gF44JlfLl6r674wgmz8BWF4rYo9RIPIzViXbvw+bYWQokDwNOTkUiN3v1JPl+7y4J6Ql1MrbR6OGWBhmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0BAB514B04B8DC; Tue,  9 Jun 2026 16:34:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Fix tests for llvm23 true signature
Date: Tue,  9 Jun 2026 16:34:02 -0700
Message-ID: <20260609233402.2711071-1-yonghong.song@linux.dev>
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

Case 1: keep int return type for tailcall subprogs

The verifier requires any subprog that issues a bpf_tail_call to return
an 'int' (see check_btf_func() in kernel/bpf/check_btf.c, which rejects
it with "tail_call is only allowed in functions that return 'int'").

Several tailcall subprogs do 'return 0' (or another constant) whose
result no caller uses. With llvm23 the compiler folds the constant and,
since the return value is dead, optimizes the subprog to effectively
return 'void' and records 'void' in BTF, so the program fails to load.

Use barrier_var() and __sink() to prevent returned value from being
optimized.

Case 2: adjust tracing prog ctx layout for the true signature

test_pkt_access_subprog2() has an unused argument that llvm optimizes
away. Before llvm23 the BTF signature did not match the optimized
assembly, so the verifier fell back to MAX_BPF_FUNC_REG_ARGS (5) u64
arguments and the fexit return value sat after args[5]. With llvm23 the
true signature has a single argument, so the return value moves to the
slot after args[1]. Select the matching ctx struct based on __clang_major=
__
so the test works with both old and new llvm.

  [1] https://github.com/llvm/llvm-project/pull/198426

Changelogs:
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260609163947.1717694-1-yonghong.s=
ong@linux.dev/
    - Do not use bpf array map or bpf global var. Use __sink() instead.

Yonghong Song (2):
  selftests/bpf: Keep int return type for tailcall subprogs
  selftests/bpf: Adjust fexit_bpf2bpf ctx layout for llvm23 true
    signature

 .../selftests/bpf/progs/fexit_bpf2bpf.c       | 13 ++++++++--
 .../selftests/bpf/progs/tailcall_bpf2bpf2.c   |  5 +++-
 .../bpf/progs/tailcall_bpf2bpf_hierarchy1.c   | 13 ++++++----
 .../bpf/progs/tailcall_bpf2bpf_hierarchy2.c   | 24 +++++++++++++------
 .../bpf/progs/tailcall_bpf2bpf_hierarchy3.c   | 13 +++++++---
 .../progs/tailcall_bpf2bpf_hierarchy_fentry.c | 13 +++++++---
 .../selftests/bpf/progs/verifier_sock.c       |  9 +++++--
 7 files changed, 68 insertions(+), 22 deletions(-)

--=20
2.53.0-Meta

