Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795221258;
	b=dTX4QOKqqZ3qVla0388gaFF6V9q1jr1Tmb7L9DcA3GPsCHIeR1sKJx4YAGwHYXOaUGN+
	 IZR7zNWJw59yX1KuRVcG9RfrXPaVZfNjSaYdZd7kTqmscUmmOqOJ1vAradL+qKRlLEltY
	 AMJujp0qXqzkL+1rhknieqOFq9IazCYOOzuaEQo8Io749v175wLHr07WSnFyepNFUcsCo
	 BZFuFm1NlBUlmyeui1oP1H1WXqibiYzJxYydiC1RHDRG5mgMqvYlbL7QIqOu0sNwyq55I
	 St+txwXG2850FVgC4hnBdcKQ2FKgV+sWYNfsuZu2xOV+daw6wHWpc0AadNc09Liwu7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795221258;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LVqfb6I1hyZommDgKkjQ68K5FsUedpZwA/p7WOx4ogk=;
	b=bioakL2kXIe8uXK/DAiygAa65nt/7amdhnW0vc5XXpMX2xIjJ8d5pmNGga08lZPFIgBM
	 aMwLhfM4dkZGEg63SOR6QdNiys1W3DaDgCXTF6HsAU6pgjcG3FLLhQNLi8mVgJkSpuKZg
	 8NiN0ItGqKF8S+WDSLHynVpJA+NlR4lzKh716gOliX2desFLdbpJpDDv6VrXqKuM5Ercb
	 4HercSw011pBtCkDPKoMhv9lFGBcP2aFjN4b8rZ/2CP16stuGL+rlB681eE9eQvQHbSGM
	 JTTGimUJyBaiEQ4QvfZCZCs9cLa8mGez982KaaaSH5oUJarzLI8TzodzeGugPf9w1yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AsY5sR9u;
	arc=none smtp.remote-ip=95.215.58.138
Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE1606A681
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 00:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CFE1606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AsY5sR9u
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/a8TPGHtim4W1Kp+5mddRIO0C+8W9McFTbcSGRi3Jys=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795221254; v=1; x=1795826054;
 b=AsY5sR9u6zCUde8BmP5ld3dYcq7yXYHf6NRW5s32oJlwqZ93HCXZIOW+Gctql5dUmTQ0GsV+
 /18oHrvcGtzkwwnH/t2dpHkUB7CoIQ5hNTGQ664fS1GGthvMlA3T6EF2nj6Vlm5vVOJZvYlFdOm
 fbOe8mV743O6JM93NlQsqBx0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id dc407b2e55f5ce0c;
	Sat, 21 Nov 2026 00:34:14 +0000
X-Mizu-Trace-ID: dc407b2e55f5ce0c
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Song Liu <song@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v2 0/6] libbpf: Support kernel-side kfunc variants
Date: Fri, 20 Nov 2026 17:33:57 -0700
Message-ID: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A kfunc prototype change breaks BPF programs built against the old
prototype. For example, 8fe4dc4f6456 ("bpf: change prototype of
bpf_session_{cookie,is_return}") made this change in v7.0:

  before:  bool bpf_session_is_return(void);
  v7.0:    bool bpf_session_is_return(void *ctx);

A program built before v7.0 declares bpf_session_is_return(void), and
libbpf can't resolve it on v7.0. The kernel has no way to keep the old
prototype available to such programs. sched_ext works around the same
problem with ___v2___compat names in compat.bpf.h.

With this series, the kernel can keep the old prototype as a variant:

  bool bpf_session_is_return(void *ctx);
  bool bpf_session_is_return___v1(void);

and libbpf binds each declaration to the function with a matching BTF
prototype.

The new lookup changes what some existing declarations resolve to.

A replay of kfunc resolution against v6.18, v7.2 and bpf-next BTF
covered 1302 BPF objects: 1174 sched_ext schedulers from Meta's
internal builds, and 128 public objects from the scx repo,
tools/sched_ext, the selftests and bpftrace. It also covered 16
objects declaring every kfunc from each x86 vmlinux.h in the scx
repo's history, counted here as public. No strong declaration
changes. These __weak declarations change, counted in objects per
kernel:
                                                    public   Meta
  lost on v7.2 and bpf-next, no candidate:
    scx_bpf_dsq_insert___v2___compat                    36    136
    scx_bpf_dsq_move_to_local___v2___compat             33     27
    scx_bpf_reenqueue_local___v2___compat                9     44

  lost on v7.2 and bpf-next, struct names differ:
    bpf_io_uring_get_region(struct io_ring_ctx *)        1      0
    bpf_io_uring_submit_sqes(struct io_ring_ctx *)       1      0

  lost on bpf-next, struct names differ:
    bpf_cpumask_populate(struct cpumask *)               8     88

  lost on v6.18 and v7.2, struct names differ:
    bpf_cpumask_populate(struct bpf_cpumask *)           4      0

  gained on v7.2 and bpf-next:
    scx_bpf_dsq_move_to_local___v2(u64, u64)             7    120
    scx_bpf_dsq_insert___v2(...)                         8      0
    scx_bpf_reenqueue_local___v2(void)                   8      0

In-tree compat.bpf.h now tries the plain ___v2 names first. Objects
that gain a ___v2 kfunc now call it instead of their fallback path.

---

v1->v2:
  * Pick a kfunc by prototype among all funcs with the same essential
    name, without preferring the exact name (Andrii, Eduard).
  * Compare struct and union names, ignoring ___ suffixes, instead of
    using bpf_core_types_are_compat(), so that variants can differ
    only in a pointee type (Eduard, Andrii).
  * Drop the alias exception that kept ___v2___compat names working
    (Eduard). New patch 2 updates compat.bpf.h instead.
  * resolve_btfids: check registered kfuncs within vmlinux or a module
    with libbpf's new matcher and report every matching pair. New
    patch #1 shares libbpf internals with it instead of wrapping them
    (Eduard).
  * Call kernel-side ___ functions "variants". "Flavor" stays CO-RE's
    term for local suffixes.
  * Rewrite the docs for the new rules.

v1: https://lore.kernel.org/bpf/20261117192153.3384031-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (6):
  libbpf: Separate interfaces shared with in-tree tools
  sched_ext: Prefer ___v2 kfunc names in compat.bpf.h
  libbpf: Resolve kfunc variants by prototype
  selftests/bpf: Test kfunc variant selection by prototype
  resolve_btfids: Reject ambiguous kfunc variants
  docs/bpf: Describe how to change a kfunc's prototype

 Documentation/bpf/kfuncs.rst                  |  96 ++++++++++++++
 tools/bpf/bpftool/Makefile                    |   9 +-
 tools/bpf/resolve_btfids/btf_colors.c         |  15 +--
 tools/bpf/resolve_btfids/btf_colors.h         |   4 -
 tools/bpf/resolve_btfids/main.c               |  74 ++++++++++-
 tools/lib/bpf/btf.c                           |  99 ++++++++++++++-
 tools/lib/bpf/libbpf.c                        | 117 ++++++++++++------
 tools/lib/bpf/libbpf_internal.h               |  32 +----
 tools/lib/bpf/libbpf_tools.h                  |  48 +++++++
 tools/sched_ext/include/scx/compat.bpf.h      |  39 ++++--
 .../selftests/bpf/prog_tests/verifier.c       |   3 +
 .../selftests/bpf/progs/kfunc_variants.c      |  32 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  12 ++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   3 +
 14 files changed, 481 insertions(+), 102 deletions(-)
 create mode 100644 tools/lib/bpf/libbpf_tools.h
 create mode 100644 tools/testing/selftests/bpf/progs/kfunc_variants.c


base-commit: 82cc2b4383e3edfa1026c8612fb4e90a9329ba11
-- 
2.56.1

