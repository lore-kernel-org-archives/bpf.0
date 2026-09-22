Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C523515CB
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039615; cv=none; b=YzB11NCrrJmYjfi5EookqRk7OzzQawgLGPFf3Xqx+J9P9AMiR1gqD6uaSMl2MV2JUZix1ccYmUbmIQuywjJvfOnmq1CbAcC6O8Mf4sXkW7pEgXtm1GoST1hO3+NZeV+CSeGc50oAD94bOfg5xZFAhlDLzsyTMElez7cZumCiiwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039615; c=relaxed/simple;
	bh=O46+j5T4a5rCMtZHkMhCOCD0PcP5NfrOXXPd/WJojts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bYvrITdKFqaaVDNF3DJpdzmYoRV45/jhGDInyT6mwT2L20oU2EozbpGGmeNLEC46AoLfpm39QiP7tOuxVvvCxFR1xZNhpaGNaDjnc0tjnwQZBmGBQiviYamOaVb74He5VKxT1wZC3cbp2nmZw3p51ECaF2pHiGk1nOeSkNHyM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdSzQAq7; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdSzQAq7"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so3214853a91.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039613; x=1790644413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZyHn+lO4yuzi5aIY5ENCmpTqWBwRhlx1HkHA2OZhERg=;
        b=GdSzQAq7MxcVk2KlYLvEHZ1Ves0xafguetaeiNoXBJbg7jpnfd44xfYu7MToPzUYO5
         kVTi92aoBMZpQh6hJNAfKrZq9GfbriF/E4lQXSHbYfIzkaXO8ledb1GJPd0NmR2qd1Sw
         MfJDW+WfZVE0cTOXq2b54NamNrnOqoYSzWaRB+XKw05y5KLPQ/Bi/XY9FdvT1v8f4Jwh
         GViUy5yw6S31AVve8kpDFJ672dsIi0hqM7gEhP59Eiw7hhtzg/Q/vDeWpJhc4wRK3aWt
         ATKcV1czOs/dh0H46HDxx3CoNDOU4VDeiTW3wWgOvS6ZGSCXzSa6vpWjymSYmNwkBi2N
         toAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039613; x=1790644413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZyHn+lO4yuzi5aIY5ENCmpTqWBwRhlx1HkHA2OZhERg=;
        b=BsHX3nK3vF9TnbjNqjyD4SYXMQT2Hhf7sfWdDwcfwvxOITdZp2oA947iD2zVECZKQn
         /n01xKNa5LkbXZW1H+Ud4PYArj2eWTSLzPnhIeAcFy7sHbOCloS9QhRTDl997AbFtcOr
         8y04IvVlV4eweIj7K6sDTONkHbjobvSU/GZv4k/d4JppPlu3SYmi2lWsNi7aK0krbkks
         Nnn2etCYtx3FWO7FCAkY59Fi6oeZ//NBAM9SflxS51XTqNwWrADq22j8kTULYOcgM7do
         WcFu2iALMo2xau/Nv5yd/VdoGFVXi+Zh8+BRMJ/XneV1NakChq+jTRGJfJtwSTnBVnTQ
         VFIg==
X-Gm-Message-State: AFuF++khHMwWNiOVt5CAZwwoN9hcI1cnyOYfJ6DF4Pdb99tNL3fGWWqh
	S9jT4F1pKiiwIfpvFh7OtgfXXDchvvATY8Qutg5cvF7iArDJSZNtBW6NfpFI2Q==
X-Gm-Gg: AYBFou3NpiQLCNn8CMxiCONDPeNAl/RsxOtespi03et+39tkKkF47PIMSlDelleJTQ7
	pFrmoYvY4uVfueXdu0gSEInFSpkiHQt71k9DBL4yYKjfKpVhXkZFGEcT1uW1LH6VLG/TWJvy4ie
	HVTqPXwbun8xC/YegIgj00dape6zLyRxPT2GvSocdC8M9nh+gFc+yDxQZK9TDd5tjVnsIeEZVmf
	+IkA/IRCMn4Q+PUSjtE3591xzWD9gL+cVegrV1IjEOYXiJad9zeLBJAoVm1U0yanlWrKSMenvnI
	ZG3bEsASrLZyLMteJUrWyjrMr41QSlc4mUTB0AKxwC74cfBJ1lv50Fn9rMrf+ucLcgcEB5x+5FC
	7lBPSEkqCZmwcFnm/LyU359Io2DV8knhaji6Qs0NP6v33j5zHazxXBgFsEFc7JQyV1DOvuorMiu
	cOXbt8sWKA5PIEfsbiUZqoWf5ibc4ffqhBpJmzWE99aCw1XZ/hg/xYkD1fKeUCQO8etEtHMT0X9
	U6a0MvrlqXZZ5LxLCfpc6jjS/ekY04H4Qe3sQGwt5nuCLqBTeaYYUNXCyNatVNmj/cHgNEqlhRj
	qBG5eHfeMh4FQJ5DO6Iw3JkuSUuhcPEsIuvdz5APPVlu+EHByCJLXw==
X-Received: by 2002:a17:90b:1c88:b0:39e:6c6a:209c with SMTP id 98e67ed59e1d1-39e6c6a2322mr12569689a91.61.1790039613055;
        Mon, 21 Sep 2026 18:13:33 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5751f2sm243540a91.9.2026.09.21.18.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:13:32 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	a.s.protopopov@gmail.com
Subject: [PATCH bpf-next 00/17] bpf: Indirect calls of bpf subprogs (callx)
Date: Tue, 22 Sep 2026 01:13:06 +0000
Message-ID: <20260922011323.1298619-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce BPF_JMP | BPF_CALL | BPF_X 'callx dst_reg' instruction: indirect
call of bpf subprog with address in a register. LLVM emits it for calls
via function pointer. The verifier rejected it as unknown opcode.

Only static subprogs can be called. The callee is verified in the context
of the caller like a direct call of static subprog. No callx into global
subprogs, helpers or kfuncs.

All callees are known before the main verifier pass. The address of
the callee comes from:

- ld_imm64 BPF_PSEUDO_FUNC, which is allowed for static subprogs only.
  add_subprogs() and check_cfg() see them already.

- 64-bit load from read-only data: tables of functions, struct ops,
  vtables, where pointers are mixed with other data. Rust needs that:

    r6 = vtable ll
    r1 = *(u64 *)(r6 + 0)      // data
    r2 = *(u64 *)(r6 + 8)      // pointer to a function
    callx r2

  libbpf keeps the data in a frozen read-only array map, one per prog,
  and stores byte offset of static function in the prog into the pointer.
  The kernel guesses pointers by that value before check_cfg() (patch 10).
  Wrong guess is safe. Functions referenced by data only are found via
  func_info (patch 9). After JIT the kernel replaces the offsets in
  the map with addresses. The prog must be the only user of the map,
  since other progs would have been verified with its old content. The
  prog reads addresses as data, so CAP_PERFMON is required.

Both produce PTR_TO_FUNC.

The passes before the main one don't know the callee and treat callx
conservatively (patch 4). The main pass records caller -> callee edges.
Recursion and stack depth checks use them afterwards (patch 6).

In C:

  static const struct shape_ops square_ops = { 1, area, 10, perimeter };
  ...
  return ops->area(x) * ops->scale + ops->perimeter(ops->id);

and

  static int (* const handlers[])(struct xdp_md *) = { foo, bar, baz };
  ...
  if (i < ARRAY_SIZE(handlers))
          return handlers[i](ctx);

plus what clang compiles without data: picking one of several functions,
passing a function pointer into another function.

Patches 1-3 are fixes I hit along the way and are independent: a prog
without callx that hangs bpf_prog_load() in check_max_stack_depth(),
its test, and const folding of loads from insn_array.

Not supported:
- JITs other than x86-64 and arm64. No interpreter support.
- x86-64 with FineIBT: bpf_jit_supports_callx() returns false.
- tail calls in callees of callx.
- pointers to functions in writable data, misaligned pointers.

Alexei Starovoitov (17):
  bpf: Fix infinite loop in check_max_stack_depth()
  selftests/bpf: Test recursion through a global function and a callback
  bpf: Don't fold loads from insn_array maps into constants
  bpf: Prepare static analysis passes for callx instruction
  bpf: Add callx instruction to call bpf subprogs indirectly
  bpf: Add callx calls to the call graph
  bpf, x86: Add JIT support for callx
  bpf, arm64: Add JIT support for callx
  bpf: Discover subprogs described by func_info
  bpf: Recognize pointers to functions in read-only maps
  libbpf: Support pointers to static functions in data when linking
  libbpf: Resolve pointers to functions in read-only data
  libbpf: Treat .data.rel.ro as read-only data
  libbpf: Support pointers to functions in read-only data in light
    skeleton
  selftests/bpf: Add tests for callx
  selftests/bpf: Add tests for callx through pointers in read-only data
  bpf, docs: Document callx instruction

 Documentation/bpf/clang-notes.rst             |   7 +-
 Documentation/bpf/linux-notes.rst             |  31 +-
 arch/arm64/net/bpf_jit_comp.c                 |  16 +
 arch/x86/net/bpf_jit_comp.c                   |  68 ++
 include/linux/bpf.h                           |  10 +
 include/linux/bpf_verifier.h                  |  43 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/backtrack.c                        |  20 +-
 kernel/bpf/cfg.c                              |  75 ++
 kernel/bpf/const_fold.c                       |  11 +-
 kernel/bpf/core.c                             |  12 +
 kernel/bpf/disasm.c                           |   5 +-
 kernel/bpf/fixups.c                           |  55 +
 kernel/bpf/liveness.c                         |  35 +-
 kernel/bpf/verifier.c                         | 632 ++++++++++-
 tools/lib/bpf/bpf_gen_internal.h              |  13 +-
 tools/lib/bpf/gen_loader.c                    | 172 ++-
 tools/lib/bpf/libbpf.c                        | 430 +++++++-
 tools/lib/bpf/linker.c                        |  18 +
 tools/testing/selftests/bpf/Makefile.skel     |   2 +-
 .../bpf/prog_tests/callx_func_ptr_map.c       | 192 ++++
 .../bpf/prog_tests/callx_rodata_lskel.c       |  55 +
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/callx_rodata.c        |  43 +
 .../selftests/bpf/progs/verifier_callx.c      | 984 ++++++++++++++++++
 .../bpf/progs/verifier_callx_rodata.c         | 651 ++++++++++++
 .../bpf/progs/verifier_global_subprogs.c      |  31 +
 .../selftests/bpf/verifier/basic_call.c       |   2 +-
 28 files changed, 3507 insertions(+), 111 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callx_func_ptr_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/callx_rodata_lskel.c
 create mode 100644 tools/testing/selftests/bpf/progs/callx_rodata.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx_rodata.c


base-commit: 79dc258c9392051420a26f1504c647bd3d27c66a
-- 
2.55.0

