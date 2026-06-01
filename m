Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148781A6839
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780352329; cv=none; b=Md+Xo9V0p9Pf7YbNiM7My7ufA85+O2wMPKLrwTsmer4orjTukk+krkiESt2HpS9h7xwvTSUkjPHYJd8d6WS0BWQkno/wGuRPVF2LEIdyC9o2MzW/bNvchON+D0k7u0k5qGMt0zoVYkd2/hSwq/XEpNNYCWEJLQUTABxUVbhXl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780352329; c=relaxed/simple;
	bh=yOXJfyH4uYGRZ8Xvfe3nWl/p184dQe3v9HotoP69xB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdKvIgnwqe+ON4ki8RlOHoOhlEz7FqKmLePvRWVLsfwxcdWst/Y4h1pvk6FSDluAyGxbeoA+QXp7AOPeEeg88p/OruytLqxqvvWMY3BtyiT1qGU1234G275aDERW21Omz48p312hTxizPKy2p8UZnk5E7vqYQdkqviUA8a+ShaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dxB7noKk; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dxB7noKk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780352325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mmfu6MW6lUQGaSyN52Gvbb4bBjHskV53Fvwbssv1x1g=;
	b=dxB7noKkZcYynoKJwQmo9MZgLZanZAs8PS7KjWZADxgHLl1KzJreKHzQNSbr6W/SS+R2VP
	tD31OaORrkMbHQOqxslv/AVJgFzBkbxGJsooAWQafPQDXmjKu5WCYl/J4ZDzVBmljHHHwi
	fvErNLHBAU7JmCnC6209LXnABLMEGWY=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH bpf-next v1 00/14] resolve_btfids: Implement BTF tags emission for kfuncs
Date: Mon,  1 Jun 2026 15:17:51 -0700
Message-ID: <20260601221805.821394-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BTF data for the kernel is generated through the following pipeline:
  * DWARF is emitted by the compiler
  * pahole reads in DWARF and produces BTF
  * resolve_btfids makes kernel-specific btf2btf transformation and
    patches .BTF_ids section

This is orchestrated by link-vmlinux.sh, gen-btf.sh and Makefile.btf
in ./scripts directory.

Historically kernel-specific BTF features were implemented in pahole,
and controlled by the feature flags. This requires kernel build
process to be aware of pahole version used for the build to set
correct runtime arguments for BTF encoding [1].

This is a burden which can be alleviated by splitting kernel/module
BTF generation in two stages:
  1. Generic BTF generation from the kernel source code.
  2. Kernel-specific BTF modifications to support various BPF features.

So far both stages were fused in pahole's BTF encoding. By moving
stage (2) in-tree, the dependency of kernel build on pahole can become
much more loose.

Recent work [2] made it possible to do btf2btf transformations in
resolve_btfids, and it is already responsible for a few important BTF
modifications for the kernel:
  * .BTF.base generation for modules [3]
  * BTF sorting [4]
  * KF_IMPLICIT_ARGS support [5]

This series continues the migration of kernel-specific BTF
transformations from pahole to resolve_btfids, implementing emission
of decl/type tags for the kfuncs and handling of the KF_ARENA_* flags.

The implementation is idempotent with respect to BTF modifications: if
input BTF already contains target tags, corresponding resolve_btfids
transformation is a noop. This allows for more flexibility in terms of
dependency on pahole. In particular, older pahole (without
decl_tag_kfuncs support, for example) can now be used in kbuild and
the resulting vmlinux BTF will contain properly tagged kfuncs
anyways. Conversely, if for whatever reason pahole emitted the same
tags, they will be properly skipped.

The series consists of the following patches:

  * patches #1-#4 refactor and fixup resolve_btfids selftest, adding
    kfunc checks
    * patch #3 is a fascinating rabbit hole with a two-line test fix
  * patch #5 refactors resolve_btfids introducing an address to
    elf-symbol index for efficient lookups
  * patch #6 changes how resolve_btfids discovers kfuncs: instead of
    relying on decl_tags emitted by pahole, identify kfuncs directly
    from BTF ID sets
  * patch #7 implements "bpf_kfunc" decl_tag emission, with the next
    patch testing it
  * patch #9 adds "bpf_fastcall" handling, with the next patch testing it
  * patch #11 implements KF_ARENA_* flags handling in resolve_btfids,
    with the next patch testing that
  * finally, patch #13 drops now unnecessary pahole runtime flags from
    the kbuild, and patch #14 adds a bit of documentation


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.btf?h=v7.1-rc5
[2] https://lore.kernel.org/bpf/20251219181321.1283664-1-ihor.solodrai@linux.dev/
[3] https://docs.kernel.org/bpf/btf.html#btf-base-section
[4] https://lore.kernel.org/bpf/20260109130003.3313716-4-dolinux.peng@gmail.com/
[5] https://lore.kernel.org/bpf/20260120222638.3976562-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (14):
  tools/bpf: Sync btf_ids.h to tools
  selftests/bpf: Modernize resolve_btfids test scaffolding
  selftests/bpf: Fix resolve_btfids test reads of BTF ID sets in PIE
    builds
  selftests/bpf: Add kfunc set test to resolve_btfids
  resolve_btfids: Index BTF ID symbols by address
  resolve_btfids: Discover kfuncs from BTF ID sets
  resolve_btfids: Emit bpf_kfunc BTF decl tag for discovered kfuncs
  selftests/bpf: Verify bpf_kfunc decl tag emission in resolve_btfids
  resolve_btfids: Emit a decl tag for kfuncs with KF_FASTCALL
  selftests/bpf: Verify bpf_fastcall decl tags in resolve_btfids test
  resolve_btfids: Process KF_ARENA_* flags in resolve_btfids
  selftests/bpf: Verify arena type tags in resolve_btfids test
  kbuild: Drop decl_tag_kfuncs and attributes from pahole flags
  docs, resolve_btfids: Document kfunc BTF annotation emission

 Documentation/bpf/kfuncs.rst                  |   8 +
 scripts/Makefile.btf                          |   7 +-
 tools/bpf/resolve_btfids/main.c               | 391 ++++++++++++++----
 tools/include/linux/btf_ids.h                 |  78 +++-
 .../selftests/bpf/prog_tests/resolve_btfids.c | 218 ++++++++--
 tools/testing/selftests/bpf/progs/btf_data.c  |  20 +
 6 files changed, 602 insertions(+), 120 deletions(-)

-- 
2.54.0

