Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35C29CE9
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343210; cv=none; b=rj8ZYs946j+Td8eClyyn5HU8Yy5h+RFGEIQeJIH+MLm7h9lxhg+vG0KEX5WO5Zp3Y9Hr9KZSp7OaG62rPARBzOXhQuqFMQDUFQh2Csr0tn13JMce22ELIW3+FfhgKYaqs4JdndNpyZkBAi4d3bDshIRRtZkHTmyRlmPQk/lOUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343210; c=relaxed/simple;
	bh=l1uekfxNYkRpOTR2YrHa1y+lUXb+GnUT7Jl6n9qXqM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhbYQOaG/mL0Z0tMogfDrhFrGZklK2GVTY968VP4KjfDB8tKFlRas1qkuXpO4u8DD441fi6jReRDqtLZt0YNN3DWHHaaEiVmkdF9yGp3je3ImTh/Lw1i4l9WZwGuozi3VdAfu/PT9Db3yLO06VftzYP2kreI+5CRIJh+d0/LXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UbB4rAOz; arc=none smtp.client-ip=91.218.175.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UbB4rAOz"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=l1uekfxNYkRpOTR2YrHa1y+lUXb+GnUT7Jl6n9qXqM4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787343204; v=1; x=1787948004;
 b=UbB4rAOz8cDqJYqMJqvCqMGRcVd5f21r+YTs2iFhTcX72cUHHgBYXSwl0+sv5J9Ozyxsc8HN
 A/qfsyVW0FzL+ThqFmgW48Cq9BTYNDHKWyjFSLcPp5ih1EO8O0bqz9KidMGXFeD7aq0G7A2pmGs
 YLeeTTSGDIJ+I6skd/32ZHEA=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY (67.169.75.212)
	by smtp.migadu.com with ESMTPS id 3f1655d114df58c5;
	Fri, 21 Aug 2026 20:13:24 +0000
X-Mizu-Trace-ID: 3f1655d114df58c5
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next 0/3] selftests/bpf: unblock bpf-gcc test coverage
Date: Fri, 21 Aug 2026 13:13:13 -0700
Message-ID: <20260821201316.1059129-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing some unrelated testing, stumbled upon this. A lot of tests
are skipped run under BPF_GCC due to clang only gate. On top, the test
harness declares them passing/OK.

Patch 1 renames a few placeholders a consistent dummy_test name [NFC].

A sample test with BPF_GCC used to say:

| #587/1 verifier_bswap/cpuv4 is not supported by compiler or jit, use a dummy test:OK
| #587	 verifier_bswap:OK

Patch 2 adds a __skip("reason") annotation so a compile-time gated file
reports SKIP rather than OK, making these gaps visible in test_progs
output.

Now the output changes to

| #587/1 verifier_bswap/cpuv4 is not supported by compiler or jit, use a dummy test:SKIP
| #587	 verifier_bswap:SKIP

Patch 3 augments the clang only gate with a per-feature gate supported
by both the compilers. FWIW the clang half has to stay: clang only
defines __BPF_FEATURE_MOVSX and friends at -mcpu=v4 but assembles the
inline asm at -mcpu=v3 too, so dropping it would remove these tests from
the default test_progs flavour where they run today.

And finally the output now is

| 587/1	 verifier_bswap/BSWAP, 16:OK
| #587/2 verifier_bswap/BSWAP, 16 @unpriv:SKIP
| #587/3 verifier_bswap/BSWAP, 32:OK
| #587/4 verifier_bswap/BSWAP, 32 @unpriv:SKIP
| #587/5 verifier_bswap/BSWAP, 64:OK
| #587/6 verifier_bswap/BSWAP, 64 @unpriv:SKIP
| #587/7 verifier_bswap/bswap16_range:OK
| #587/8 verifier_bswap/bswap32_range:OK
| #587/9 verifier_bswap/bswap64_range:OK
| #587/10 verifier_bswap/be16_range:OK
| #587/11 verifier_bswap/be32_range:OK
| #587/12 verifier_bswap/be64_range:OK
| #587/13 verifier_bswap/le16_range:OK
| #587/14 verifier_bswap/le32_range:OK
| #587/15 verifier_bswap/le64_range:OK
| #587/16 verifier_bswap/BSWAP, reset reg id:OK
| #587	 verifier_bswap:OK (SKIP: 3/16)

Programs per object recovered under BPF_GCC, 124 in total:

  verifier_sdiv                  1 -> 80
  verifier_movsx                 1 -> 17
  verifier_ldsx                  1 -> 14
  verifier_bswap                 1 -> 13
  compute_live_registers        17 -> 19
  verifier_gotol                 1 -> 2
  verifier_iterating_callbacks  34 -> 35

Two things stay clang-only on purpose: the arena tests using
addr_space_cast, and verifier_load_acquire/verifier_store_release. gas
implements neither.

The increased coverage bore fruits right away as I stumbled into a gas
bug: PR gas/3455. Fix is posted however workaround is needed for the
time being.

Built for x86_64 with both clang and bpf-gcc; the per-object counts above
were read back from the generated objects.

Vineet Gupta (3):
  selftests/bpf: name the remaining placeholder programs dummy_test
    [NFC]
  selftests/bpf: report placeholder tests as SKIP, not OK
  selftests/bpf: Enable some of the blocked cpuv4 instruction tests for
    bpf-gcc

 .../testing/selftests/bpf/progs/arena_kfunc.c |  3 ++-
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 10 ++++++++--
 .../bpf/progs/compute_live_registers.c        |  7 +++++++
 .../selftests/bpf/progs/stack_arg_fail.c      |  3 ++-
 .../selftests/bpf/progs/stack_arg_precision.c |  1 +
 .../selftests/bpf/progs/verifier_bswap.c      |  3 ++-
 .../selftests/bpf/progs/verifier_gotol.c      |  1 +
 .../selftests/bpf/progs/verifier_ldsx.c       | 19 ++++++++++++-------
 .../bpf/progs/verifier_load_acquire.c         |  1 +
 .../selftests/bpf/progs/verifier_movsx.c      |  3 ++-
 .../bpf/progs/verifier_private_stack.c        |  1 +
 .../selftests/bpf/progs/verifier_sdiv.c       |  3 ++-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  1 +
 .../bpf/progs/verifier_stack_arg_order.c      |  1 +
 .../bpf/progs/verifier_store_release.c        |  1 +
 tools/testing/selftests/bpf/test_loader.c     |  9 +++++++++
 16 files changed, 53 insertions(+), 14 deletions(-)

-- 
2.53.0-Meta

