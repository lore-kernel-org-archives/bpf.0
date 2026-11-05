Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901558;
	b=hN/fEkppIJMjLvP33Qs29VCcTiymjf9zqQlezbqmosc0ijX0PVlEb7OuRNEIpTIBmInw
	 DRDbWobHR7ZkpyU+b8540OVvgCAbTVO1oxIrFSr24/62PhCaO/CBdiwxXsDXBFDw+7V1C
	 qRrDwUOKfHjLM58cWL8lytPfrHarQeU1GPZoOmSiN2/i/wAzLlnf+sMxosupgAr+izFw1
	 3NyKtqjU27ubnjBuf1RDzNxjXQZMRs/8NxQxJpSqLp7/nkhNhC2SR4dFh21jCb9aBeCUY
	 sE/6hnjZ6dv3t3hsdBjNdiINBXHVA8WQpTxCMKtjVIkeMtCXHIWe0CGniGjdU6gz/vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901558;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Nz+bYXT7mfgDDgT7fmp6KxU7uUrsZB0wjHq/XToG8oY=;
	b=ucL/dahjbknGQDFh1vhygHC6vIXyACEAwf/1eQzhskPud4qHxABvhxzFQ+kNFNqOztf0
	 D3e0f3PPk4tMl2BYaYISdmnOt+ZwW+M8eWtKgEh2gn21zgdr8R1Op35L5Ze3zFzoMT08g
	 vl0pfI2zOIpGtg7MPcobq69KE4pZWscO832gs6FZTEmjIeFNN/1oC/hdOV6u1yfZYIbpe
	 8Q80k6qf6SU3N4hV/9Vtxl1GFQ3xmY6I4fv69ovxF6POMqgKXR2mEFr835YSNKKL7iZzo
	 0dpEdkolCU9x4LUgXLuDlR1aaf/UZJ2apdPPbLDsxEHGEcZqcKyAiOKGpkNnCoweWpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f6Vq5eeB;
	arc=none smtp.remote-ip=95.215.58.226
Received: from mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADAB606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 17:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ADAB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=f6Vq5eeB
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cZPBa8NyhwpCB1/OwAl5sb5q+NNTavNKdHxFJaE20oE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901556; v=1; x=1794506356;
 b=f6Vq5eeBoxomctAab9GiSUUkzANNd+alpXd4tDW5ySmUm8DVNfiwKOhYX6/WcP2CHsB2o/rc
 URqdiO61YLEjsV9xjxgq39tJAlZ/fyMH/XL3uPL2+cdSH+md4DwyxA8U694WHLJt5Ncx2tMZ+D8
 SFFZv/ydi+5Lyl2hNinSRwzg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 145ec0129afbf48c;
	Thu, 05 Nov 2026 17:59:16 +0000
X-Mizu-Trace-ID: 145ec0129afbf48c
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 00/17] bpftool: Per-record CO-RE attributes in the C dump
Date: Thu,  5 Nov 2026 10:58:28 -0700
Message-ID: <20261105175845.30357-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
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

bpftool's C dump wraps its output in a clang attribute pragma:

  #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)

GCC-BPF implements preserve_access_index, but not the pragma. Since
the commit 675b4e24bc50 ("bpf: Temporarily define
BPF_NO_PRESEVE_ACCESS_INDEX for GCC") the BPF selftests build GCC
objects with -DBPF_NO_PRESERVE_ACCESS_INDEX, which disables automatic
CO-RE for vmlinux.h field accesses.

This series replaces the pragma with an explicit attribute on each
record definition, and uses the same mechanism to annotate the context
types that the verifier rewrites with preserve_static_offset.

Jose proposed per-record attributes in May 2024 [1]. It stalled on a
requirement from preserve_static_offset (PSO) work [2] to add
attributes on selected types only, which a fixed string cannot
express.

BTF decl tags can carry an arbitrary attribute list since commit
51d1b1d42841 ("libbpf: Introduce kflag for type_tags and decl_tags in
BTF"), and btf_dump renders them on record definitions, since
76ea31239021 ("libbpf: Render decl_tags in btf_dump"). This allows
bpftool to put any attribute on any subset of records, with no new
libbpf API.

btf_dump now prints the strings of kflagged decl and type tags as is,
allowing macros defined by the generated header. bpftool attaches decl
tags from its dump split to input type tags; btf_dump prints the decl
tag instead. The input, including module base BTF, stays unchanged.

Overrides render legacy "address_space(1)" as
__attribute__((address_space(1))) and plain "arena" as __bpf_arena,
which adds address_space(1) while preserving the BTF tag.
resolve_btfids emits the complete specifier in new kernel BTF; legacy
handling remains in bpftool.

Old bpftool built with libbpf 1.6 or later emits invalid arena kfunc
prototypes from new kernel BTF, breaking programs that include them.
Users will be advised to update their bpftool when generating
vmlinux.h for new kernels.

[1] https://lore.kernel.org/bpf/20240503111836.25275-1-jose.marchesi@oracle.com/
[2] https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/
[3] https://github.com/llvm/llvm-project/pull/234280

---

Series structure:
  * 1-5: Preparation: revert the libbpf arena special case, fix string
    lookup, and prepare split dumping and test fixtures.
  * 6-9: Decl-tag overrides, verbatim kflagged tags, legacy arena
    compatibility and tests.
  * 10-15: Per-record CO-RE and static-offset annotations, tests and docs.
  * 16-17: __bpf_arena rendering and tests.

v3->v4:
  * Let decl tags override type tag rendering in btf_dump.  
  * Replace the in-place legacy arena fixup with such overrides. This
    also handles module and merged BTF without changing the input.
    (Alexei, Andrii)
  * Add a GENERATED HEADERS section and an example showing both macro
    definitions and their annotations (Quentin)
  * Revert libbpf's special case for the plain "arena" type
    tag. Render it as __bpf_arena in bpftool instead.
  * Reorder some patches vs v3: prep first, and keep the renderer,
    resolve_btfids producer and legacy compatibility changes together
    in one commit ("Dump kflagged BTF tags as is" patch)
  * Add type-tag override tests, legacy module BTF coverage, and the
    __bpf_arena case
  * Remove unused array/modifier unwrapping from the anonymous record walk
  * Reword commit messages, documentation and comments

v3: https://lore.kernel.org/bpf/20261030233355.1836749-1-ihor.solodrai@linux.dev/

v2->v3:
  * Print kflagged decl and type tags as is in btf_dump, and encode
    the complete arena specifier in resolve_btfids (Andrii)
  * Define __bpf_relocatable and __bpf_static_offset as complete
    attribute specifiers, so record definitions carry only the macro
    names (Andrii)
  * New patch "bpftool: Normalize legacy arena type tags before C dumps"
    keeps C dumps of older kernel BTF valid
  * Rename the no_pai map and helper to non_relocatable, and use a bool
    array instead of linux/bitmap.h (Andrii)
  * selftest refactoring: build bpftool_btf_dump fixtures in
    btf_to_tmpfile()
  * Commit message and documentation rewording, other nits

v2: https://lore.kernel.org/bpf/20261023222652.3927736-1-ihor.solodrai@linux.dev/

v1->v2:
  * Rename __bpf_core_pai to __bpf_relocatable
  * Rename __bpf_core_pso to __bpf_static_offset
  * Use a split BTF to add decl_tags in bpftool instead of a detached
    copy (Alexei, Alan)
    * New patch "libbpf: Look up BTF strings without making BTF
      modifiable" lets btf__find_str() build its string index without
      making BTF modifiable
    * Dropped patch "bpftool: Dump C from a detached BTF copy"
  * The Clang crash on __builtin_preserve_field_info over PSO types is
    fixed in LLVM [3]. PSO stays on by default; -D__bpf_static_offset=
    remains the documented workaround for Clang 18 through 23
  * GCC-BPF gets __bpf_relocatable from patch #3, so its narrow loads
    from context types fail verification until patch #4 (bpf-ci bot),
    left as is
  * Commit message and documentation rewording

v1: https://lore.kernel.org/bpf/20261016000012.2232059-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (17):
  Revert "libbpf: Render the arena type tag with its address space"
  libbpf: Look up BTF strings without making BTF modifiable
  bpftool: Dump C through a split BTF
  selftests/bpf: Build BTF fixtures in btf_to_tmpfile()
  selftests/bpf: Cover unknown BTF header-extension bytes in bpftool C
    dumps
  libbpf: Let decl tags override how btf_dump renders type tags
  libbpf, bpftool, resolve_btfids: Dump kflagged BTF tags as is
  selftests/bpf: Cover type tag rendering overrides in btf_dump
  selftests/bpf: Cover legacy arena type tags in bpftool C dumps
  bpftool: Apply __bpf_relocatable per record on BTF dump
  bpftool: Skip __bpf_relocatable on verifier-rewritten context types
  bpftool: Emit __bpf_static_offset on verifier-rewritten context types
  selftests/bpf: Cover record attributes in bpftool BTF dumps
  selftests/bpf: Cover context and socket accesses through vmlinux.h
  bpftool: Document __bpf_relocatable and __bpf_static_offset
  bpftool: Render the arena type tag as __bpf_arena
  selftests/bpf: Cover the arena type tag in bpftool C dumps

 Documentation/bpf/btf.rst                     |  24 +-
 Documentation/bpf/kfuncs.rst                  |   3 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  73 ++++-
 tools/bpf/bpftool/btf.c                       | 195 ++++++++++++-
 tools/bpf/resolve_btfids/main.c               |   2 +-
 tools/lib/bpf/btf.c                           |  51 ++--
 tools/lib/bpf/btf_dump.c                      |  19 +-
 .../bpf/bpftool_btf_dump_sorted.expected      |  54 +++-
 .../bpf/bpftool_btf_dump_unsorted.expected    |  54 +++-
 .../bpf/prog_tests/bpftool_btf_dump.c         | 259 +++++++++++++++---
 .../selftests/bpf/prog_tests/btf_dump.c       | 119 ++++----
 .../selftests/bpf/prog_tests/resolve_btfids.c |   4 +-
 .../bpf/prog_tests/test_struct_ops_arena.c    |   2 +-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../progs/struct_ops_arena_member_render.c    |   7 +-
 .../bpf/progs/verifier_ctx_rewritten.c        |  60 ++++
 16 files changed, 774 insertions(+), 154 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c


base-commit: a3c8813409f13779fec225468aba7d4067a66468
-- 
2.56.0

