Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAD30C62D;
	Mon, 13 Jul 2026 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910657; cv=none; b=b6r+FS4FZSguqHd4spylwz9EijGB6lsrAALqpR6e1+n4YNLRBQVwpJU/qo93rqDYjcOHTBbLDfb2kpeuK3pMFc/75RPq4HLLmVpb0uoo9gYU7TWQXcX6gVqFg5lHX+e5aWxJWxrsIJUZCNV9SmWShPDQ/eI6/amh+q6oxScmgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910657; c=relaxed/simple;
	bh=5T4Qxc3Id3c+RnN0wZyptLR86aTP2zq8JTx1X+sJwDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXNNPdvTmIbiAQMiZyThdr4YlCawzjB9iZhuy+VrYfz3nqR4+s4HHKTBaO/KhJG8aZElRTb6e+k+uSIJW3HNQwwG+v/qwefhkEfI1FazINf4f+ErwPeOu6YlXseTE0lumhZlQ1DlhrnLHsy4YlQxloz+HyHAYrBUbIUYt67n5cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6N6/mmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6N6/mmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91121F000E9;
	Mon, 13 Jul 2026 02:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910656;
	bh=Tt3VF+tkAjO1Pwgrqr+veSWn7C4x3qPNX7OHAFHz+/w=;
	h=From:To:Cc:Subject:Date;
	b=b6N6/mmD+scMeYPc0De9tzd6KqZPb/B9fwk2ure+r6a2iGJCBOf5XXY20dcw96v9U
	 MUaNqs3ADK/vdw/vvsPJnksBuanWvedEVQZyr/QlludSHBtFE0b5WyISKRvv5RjvD+
	 7P62JwHKZw0NwjdlTNn3kWZl/IxEYFk0xTiwtc5VFh829bPWXQ/OVIkPNcApN/aMD+
	 QF8Rgr74Qjz2ktc+5s+f+QtVQFS9xoHorVfDzdSrlPXNZPP7uPnxXbSd/L1A3ZmlGV
	 7eaQEA983HBlJaDHVWhnFfOgSv935q1/mg2LsxYL8/NBM3XsJikCaJYZoTd4hpKRhs
	 /Vv2YTQ2hI0Yw==
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET SLOP RFC 0/6] bpf: make arena pointers first-class kfunc and struct_ops arguments
Date: Sun, 12 Jul 2026 16:44:08 -1000
Message-ID: <20260713024414.3759854-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC. I am not familiar with the BPF verifier code base and this series is
heavily AI-assisted. I reviewed and iterated on all of it but leaned on the
AI outright in places.

BPF arena memory is shared between a BPF program and the kernel, but the two
sides address it through different bases, so an arena pointer cannot be
passed across the kfunc or struct_ops boundary as a pointer. It crosses as a
bare scalar, and the receiving side then offsets it to the other address
space and casts it by hand. Every kfunc and struct_ops caller that touches
arena memory open-codes the same translation.

This series adds an __arena argument suffix that makes the translation
automatic. The callee declares the parameter by its real pointer type and
dereferences it directly, and the verifier rebases it at the boundary
(arena to kernel address into a kfunc, kernel address to arena into a
struct_ops callback), with NULL preserved. The pointer arrives ready to use
on both sides, with no scalar laundering and no hand-written offset or cast.

The approach comes out of rough discussions with Alexei and Kumar.

Patches 1-4 are the BPF core support plus selftests, the kfunc direction
then the struct_ops direction. Patches 5-6 convert two sched_ext consumers
to show the result. They are marked NOT_SIGNED_OFF and are not meant to be
applied. sched_ext has moved on since, notably the pending cap work, so once
the core lands the plan is to pull bpf-next into sched_ext and redo the
consumer side there.

Tested: the BPF selftests pass at bpf_jit_harden 0/1/2, the arena,
struct_ops and kfunc regression suites are clean, and scx_qmap schedules
correctly through the converted paths.

Tejun Heo (6):
  bpf: Support __arena suffix for kfunc arguments
  selftests/bpf: Add kfunc __arena argument tests
  bpf: Support __arena suffix on struct_ops stub arguments
  selftests/bpf: Add struct_ops __arena argument tests
  sched_ext: Pass a kernel arena pointer to ops_cid.set_cmask()
  sched_ext: Convert scx_bpf_cid_override() to take an arena pointer

 Documentation/bpf/kfuncs.rst                  |  27 ++++
 include/linux/bpf_verifier.h                  |   2 +
 kernel/bpf/bpf_struct_ops.c                   |  17 ++-
 kernel/bpf/btf.c                              |  10 +-
 kernel/bpf/fixups.c                           |  70 +++++++++
 kernel/bpf/verifier.c                         | 103 +++++++++++--
 kernel/sched/ext/cid.c                        |  24 +++-
 kernel/sched/ext/ext.c                        |  11 +-
 kernel/sched/ext/internal.h                   |  16 +--
 tools/sched_ext/include/scx/compat.bpf.h      |   8 +-
 tools/sched_ext/scx_qmap.bpf.c                |  13 +-
 tools/sched_ext/scx_qmap.c                    |  41 ++++--
 tools/sched_ext/scx_qmap.h                    |   3 +
 .../selftests/bpf/prog_tests/arena_kfunc.c    |  14 ++
 .../bpf/prog_tests/test_struct_ops_arena.c    |  61 ++++++++
 .../testing/selftests/bpf/progs/arena_kfunc.c | 135 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_arena.c    |  67 +++++++++
 .../bpf/progs/struct_ops_arena_fail.c         |  20 +++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  45 ++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   2 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   5 +
 21 files changed, 622 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c

-- 
2.55.0

