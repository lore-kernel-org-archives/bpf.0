Received: from out-178.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3B12B94
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072854; cv=none; b=AN6rGTXUu9OpCx02tHFoS/cVOqD0YGzMabigCHs+1kft9WQXLC9vg6b7liW2HwqQ/QLuH4jMKFIQTaLwIW94XUZ2K+abH3wn8ZxvG0VYxq9+/IdrIwi/+/mji3R1QZwGqyncy2IyW+NDvYb4XAOsyLIUiUu+s9obmfGzkMlPyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072854; c=relaxed/simple;
	bh=/Oq6Y0nJeUif5VRk/anlAEimpz10FmZ1oyxfne8B6hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abwKoNflWyY/4u4jSKPyDePhQpOowbgWx66V71AdiOwSxIMwmNusn7UYbmq0XqvrD1sK/YsP/zNGDnucevL41+AQBJAbSKUNGEsiksvCPC0tIJ7BEsqXefXrBVICn/CMFAFbGJAfYIo1YFUhVWgrXlOuv2jJCpcU20u/tYSVfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eseKUiON; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eseKUiON"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786072849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bIov0VnMwQ6bCrK6wVEXnbnkQMsr3p/5fskMYM91Qf8=;
	b=eseKUiONyQHDZDxAJYGGKmx1hqoIKsNYhbbKpbxb0KyVAg0znApMVLIPPeiM1/tvh2/VIh
	/BfcvVUPO+A1m1UW6CiGt2tPJnl0eSlkiwFXR4AL94CgjwfUq4iIKhU5XYWN4n464NOcLC
	AJX7+A1p2jcLSvUnLe0Q6wYRWW9jwbQ=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/6] resolve_btfids: Implement BTF tags emission for kfuncs
Date: Thu,  6 Aug 2026 20:20:23 -0700
Message-ID: <20260807032029.78092-1-ihor.solodrai@linux.dev>
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

resolve_btfids is already responsible for a few kernel-specific BTF
modifications:
  * .BTF.base generation for modules [2]
  * BTF sorting [3]
  * KF_IMPLICIT_ARGS support [4]

This series completes the migration by emitting BTF kfunc annotations
in-tree: the "bpf_kfunc" and "bpf_fastcall" decl tags and the arena
"address_space(1)" type attribute, dropping the corresponding pahole
feature flags.

The three annotations depend on two pahole feature flags:
"decl_tag_kfuncs" and "attributes".  Since emission is unconditional,
each flag has to be dropped in the same commit as the emission that
replaces it.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.btf?h=v7.1-rc5
[2] https://docs.kernel.org/bpf/btf.html#btf-base-section
[3] https://lore.kernel.org/bpf/20260109130003.3313716-4-dolinux.peng@gmail.com/
[4] https://lore.kernel.org/bpf/20260120222638.3976562-1-ihor.solodrai@linux.dev/
[5] https://lore.kernel.org/bpf/20260722233518.778854-1-ihor.solodrai@linux.dev/
[6] https://lore.kernel.org/bpf/20260617210619.1562858-1-ihor.solodrai@linux.dev/

---

v2->v3:
  * Refactoring in patch #2 (Eduard)
    * restructure add_arena_tagged_proto() such that first we copy the
      func proto and then update param types in place
    * push error messages down to arena_tag_ptr()
    * introduce is_arena_arg() helper
  * Docs cleanup in patch #6 (Eduard)
  * Add stats in commit message for patch #1
v2: https://lore.kernel.org/bpf/20260805230648.2354989-1-ihor.solodrai@linux.dev/

v1->v2:
  * The bottom part of v1 has already been landed [5][6].
  * New patch #1: run btf__dedup() in finalize_btf().
  * Drop the "ensure" pattern. Emission is unconditional; kbuild owns
    the pahole flags, so assume input BTF is not already tagged.
  * Each pahole flag is now dropped in the same commit as the emission
    that replaces it.
  * Fail hard with an error on invalid kfunc declarations such as an
    arena flag naming a missing argument or a non-pointer type.
  * Various cleanups and nits (Andrii, Emil, Jiri, Sashiko).
v1: https://lore.kernel.org/bpf/20260601221805.821394-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (6):
  resolve_btfids: Deduplicate BTF after btf2btf transformations
  resolve_btfids: Process KF_ARENA_* flags in resolve_btfids
  selftests/bpf: Verify arena type tags in resolve_btfids test
  resolve_btfids: Emit bpf_kfunc and bpf_fastcall decl tags
  selftests/bpf: Verify decl tags emission in resolve_btfids test
  docs, resolve_btfids: Document kfunc BTF annotation emission

 Documentation/bpf/kfuncs.rst                  |   7 +
 Documentation/process/changes.rst             |   5 -
 scripts/Makefile.btf                          |   4 +-
 tools/bpf/resolve_btfids/main.c               | 185 +++++++++++++++++-
 .../selftests/bpf/prog_tests/resolve_btfids.c | 106 ++++++++++
 tools/testing/selftests/bpf/progs/btf_data.c  |  10 +
 6 files changed, 304 insertions(+), 13 deletions(-)

-- 
2.55.0

