Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0CC3EA96A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139554; cv=none; b=d36tJnOgDrKfboxoeRRkUpfjVgOybSoMTqUb5wYO+Xf8BnJ4818uHMLcIHg+q0SBgLvDTz7znoqPMAbCKrH3g5KX5fvd2dCrMzKo3J+hvQZ7Q9/rvyMUP1ULr9uqT7veaDeaePBmbvv1VuXrDhZwq9YFs6r/RMTnLJwxBmKJSd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139554; c=relaxed/simple;
	bh=6DIUnis1YIcqSEOO8k1NgTzuNUp3nXUhaAIk4eT7Bb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5P1jCTwaRTOWq4/XRQ3TRqGV8aC5Sx50NMo5dqJQsVHe9n4NojrYXka52mAX9hTnNj4995rSliQs0XGPWDfpeivfGh46StmcYjZGYJyEyubI+Q5kruoZvZAnNEhseglefNas1b+ef59h8AHOvPxW02Y+dpyoxfcMMuzKotBxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 82A052C8DA161B; Tue, 22 Sep 2026 21:58:46 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 00/21] bpf: Run exception cleanup landing pads when bpf_throw() unwinds
Date: Tue, 22 Sep 2026 21:58:46 -0700
Message-ID: <20260923045846.2414643-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bpf_throw() walks the BPF call stack to the exception boundary and
discards every frame in between. A frame that owns something -- an RCU
read lock, a preemption-disabled section, a referenced kptr -- never gets
to give it back, so the verifier refuses to let such a frame throw at
all. That is the whole reason a Rust program cannot use bpf_throw() as
its panic path right now: Rust's Drop glue *is* that give-back, and there
is nowhere to run it.

LLVM 23 added the compiler half ([1]). A Rust function that owns a value
across a call that can unwind

    fn foo() {
        let _guard =3D RcuReadGuard::new();  /* bpf_rcu_read_lock()   */
        may_throw();                       /* extern "C-unwind"     */
    }                                      /* Drop: rcu_read_unlock */

lowers to an invoke with a cleanup landing pad holding the Drop call, and
the BPF backend writes one record per invoke region into a .bpf_cleanup
section: a flat table of 12-byte (begin, end, landing_pad) triples, each
field a byte offset into the code section. The rule is "if a frame unwind=
s
with its return address in [begin, end), run landing_pad before discardin=
g
it". A pad ends with a call to _Unwind_Resume(), which the kernel provide=
s
as the bpf_unwind_resume() kfunc.

This series is the kernel half: take that table at BPF_PROG_LOAD, teach
the verifier that a covered call can also go to its landing pad, and have
bpf_throw() run the pads as it walks.

C has no unwinding, so the selftests spell out by hand what a frontend
emits -- a call site bracketed by two labels, a landing pad, and a record
tying them together. The frame above, written that way:

        "call bpf_rcu_read_lock;"
    "1:"    "call foo3;"                /* cleanup region */
    "2:"
        ... normal path, ends in bpf_rcu_read_unlock ...
    "6:"                                /* landing pad */
        "call bpf_rcu_read_unlock;"
        "call bpf_unwind_resume;"
        CLEANUP_REC("1b", "2b", "6b")

Right now that program does not load: the throw inside foo3 is reported a=
s
"bpf_throw cannot be used inside bpf_rcu_read_lock-ed region", because as
far as the verifier is concerned nothing will ever unlock. With the serie=
s
the verifier walks the unwind the same way the run time will -- into the
pad, which unlocks, then on to the next frame -- and the program both
loads and releases the lock when it throws.

Design
=3D=3D=3D=3D=3D=3D

A pad is run, not lowered. bpf_throw() already walks the frames with
arch_bpf_stack_walk(); it now looks each frame's return address up in
that (sub)program's table and calls the pad as a subroutine of the walker=
,
with the unwinding frame's frame pointer and its callee-saved registers
restored from the spill its callee's prologue left. The pad therefore see=
s
its own frame but runs on the walker's stack, far below it, so nothing it
calls can disturb the frame it is cleaning up after. The JIT turns its
bpf_unwind_resume() into the way back to the walker.

The verifier walks the same thing, step for step, so the resource rules
are unchanged: whatever a pad releases is released in the verifier state
too, and check_resource_leak() simply moves from "a throw was seen" to th=
e
end of the walk.

  1      change some fields from bool type to bitfield to save space for
         struct bpf_insn_aux_data
  2-3    uapi: cleanup_info in BPF_PROG_LOAD, struct bpf_cleanup_info,
         and the bpf_unwind_resume() kfunc
  4-10   verifier: mark the covered call sites, give them an edge to the
         pad, walk the unwind, and refuse the shapes that cannot be
         dispatched
  11     bpf_throw(): dispatch pads while walking
  12-13  x86-64 and arm64 JITs
  14-18  libbpf: collect .bpf_cleanup, pass it to the kernel, resolve
         _Unwind_Resume, carry it through the light skeleton and the
         static linker
  19-21  selftests

Limitations
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  - Cleanup pads only. A catch pad -- one that ends in a plain exit rathe=
r
    than a resume, which is what Rust's catch_unwind would need -- is
    refused: the walker calls a pad as a subroutine and cannot hand a fra=
me
    back its own execution. LLVM refuses type-specific catches and filter=
s
    on its side as well.
  - A JIT that can dispatch pads is required: x86-64 (with
    CONFIG_UNWINDER_ORC, which bpf_throw() already needs there) and arm64=
.
    Anywhere else the load fails with -EOPNOTSUPP rather than silently
    doing nothing.
  - No offloaded programs, no private stack, and no combining a table wit=
h
    an exception callback.
  - In a pad body: no tail call, no BPF_LD_[ABS|IND], no indirect jump, a=
nd
    no on-stack call arguments -- each of them reads or writes a stack th=
e
    pad does not own.
  - The Rust toolchain does not properly support BPF exception handling
    yet. The tables the selftests use are hand-written inline asm, which
    the assembler turns into the same relocations the BPF AsmPrinter emit=
s,
    so libbpf and the kernel see an object indistinguishable from a
    compiler-generated one.

  [1] https://github.com/llvm/llvm-project/pull/192164
      llvm commit 9d51c891b719 ("[BPF] Add exception handling support
      with .bpf_cleanup section")

Changelog
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  v4 -> v5:
    - v4: https://lore.kernel.org/bpf/20260921210033.1715000-1-yonghong.s=
ong@linux.dev/
    - Rebase on bpf-next.
    - Clear r0 where a throw enters a landing pad: no instruction defines
      it, so a precision request for it outlived the state and oopsed the
      verifier.
    - Defer entering the frames an unwind edge crossed until the backtrac=
k
      reads an instruction from them; entering at the landing pad could
      leave bt->frame past the parent state's frames and oops the verifie=
r.
    - Stamp the popped frame count inside bpf_push_jmp_history(), so a pa=
d's
      entry carries it even when the prune path is what creates the entry=
.
    - Replace the hand-rolled CFG traversal and its separate pass with
      per-instruction checks in do_check(), keyed on the verifier's
      unwinding state; kernel/bpf/exception.c halves.
    - Add a first patch packing bpf_insn_aux_data's flags into one bit fi=
eld
      word, 144 bytes to 128, so the flags this series adds cost bits.
    - Drop the per-subprogram arrays the JITs consulted for throw sites,
      resume sites and pad bodies, and read insn_aux_data, which a JIT
      already has.
    - Drop the pad-entry r0 header: r0 at a pad is an unknown scalar, and=
 a
      dispatcher writes a defined value there only to keep a kernel one o=
ut
      of BPF.
    - Take the bool arguments back out of verifier_remove_insns() and the
      site collector, and share pop_frame() with prepare_func_exit().
    - Rename the recorded call sites to throw_call and resume_call, give =
the
      exported functions a bpf_exc_ prefix, and drop cleanup_ from the
      statics.
  v3 -> v4:
    - v3: https://lore.kernel.org/bpf/20260920054225.864535-1-yonghong.so=
ng@linux.dev/
    - Rebase on bpf-next due to conflict.
    - Reserve the throw-site spill area only in a (sub)program that calls
      bpf_throw(): 40 bytes of stack per frame on x86-64, 80 on arm64.
    - Bound the record count by the number of instructions in the program=
,
      and name both in the message.
    - Refuse a .bpf_cleanup section in libbpf whose record count cannot b=
e
      handed to the kernel as a count times a record size in an int.
    - Fix the static linker's new bounds check, which could itself wrap, =
and
      refuse a section too small to hold one field.
    - WARN once if the body of bpf_unwind_resume() is ever reached, the w=
ay
      bpf_throw() does where its exception callback should never return.
    - Rename nr_pad_body to pad_body_bits, use BTF_ID_LIST_SINGLE, move
      cleanup_pad out of insn_aux_data's bools, drop an arm64 include.
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260918044156.3283973-1-yonghong.s=
ong@linux.dev/
    - Keep a landing pad's record when opt_remove_nops() deletes a pad th=
at is
      a nop, instead of dropping it after the verifier has already checke=
d the
      call site against it.
    - Refuse a BPF_LD_[ABS|IND] in a pad body.
    - Teach mark_chain_precision() about the throw-to-pad edge, which cro=
sses
      frames with no instruction to account for them.
    - Refuse a bpf_unwind_resume() in any frame but the one whose landing=
 pad
      the walker entered.
    - Check raw_data, alignment and bounds before the static linker write=
s
      through a relocation in a non-executable section, which may be SHT_=
NOBITS.
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260917055645.3926444-1-yonghong.s=
ong@linux.dev/
    - Consolidate all usages of kern_extern_name() in a single patch in l=
ibbpf.
    - Avoid compiler warning and add proper cleanup_info_cnt guard in lib=
bpf when
      collecting .bpf_cleanup records.
    - Add cleanup_info_cnt condition for emit_rel_store() with cleanup_in=
fo.

Yonghong Song (21):
  bpf: Pack bpf_insn_aux_data flags into bit fields
  bpf: Accept the compiler's exception cleanup table at program load
  bpf: Add the bpf_unwind_resume() kfunc
  bpf: Add lookups for exception cleanup resumes and landing pads
  bpf: Prepare for an exception cleanup table before the CFG walk
  bpf: Make exception landing pads reachable in the CFG
  bpf: Explore the landing pads no call site reaches
  bpf: Walk the exception unwind in the verifier
  bpf: Refuse exception cleanup shapes bpf_throw() cannot dispatch
  bpf: Refuse a private stack for a program with an exception cleanup
    table
  bpf: Dispatch exception cleanup pads from bpf_throw()
  bpf, x86: Dispatch exception cleanup pads at run time
  bpf, arm64: Dispatch exception cleanup pads at run time
  libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
  libbpf: Add cleanup_info to bpf_prog_load_opts
  libbpf: Collect .bpf_cleanup records and pass them to the kernel
  libbpf: Carry the exception cleanup table through the light skeleton
  libbpf: Let the static linker carry .bpf_cleanup relocations
  selftests/bpf: Add an end-to-end .bpf_cleanup exception test
  selftests/bpf: Cover the exception cleanup shapes the chain does not
    reach
  selftests/bpf: Load an exception cleanup program from a light skeleton

 arch/arm64/net/Makefile                       |    2 +-
 arch/arm64/net/bpf_cleanup_pad.S              |   94 ++
 arch/arm64/net/bpf_jit_comp.c                 |   92 +-
 arch/x86/net/Makefile                         |    3 +
 arch/x86/net/bpf_cleanup_pad.S                |   79 ++
 arch/x86/net/bpf_jit_comp.c                   |   81 +-
 include/linux/bpf.h                           |   88 ++
 include/linux/bpf_verifier.h                  |   64 +-
 include/linux/filter.h                        |    2 +
 include/uapi/linux/bpf.h                      |    9 +
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/backtrack.c                        |   41 +-
 kernel/bpf/cfg.c                              |   71 +-
 kernel/bpf/check_btf.c                        |  134 +++
 kernel/bpf/core.c                             |   35 +-
 kernel/bpf/exception.c                        |  328 ++++++
 kernel/bpf/exception.h                        |   23 +
 kernel/bpf/fixups.c                           |   98 +-
 kernel/bpf/helpers.c                          |   48 +
 kernel/bpf/liveness.c                         |   19 +
 kernel/bpf/states.c                           |    6 +
 kernel/bpf/syscall.c                          |    2 +-
 kernel/bpf/verifier.c                         |  161 ++-
 tools/include/uapi/linux/bpf.h                |    9 +
 tools/lib/bpf/bpf.c                           |    6 +-
 tools/lib/bpf/bpf.h                           |    7 +-
 tools/lib/bpf/gen_loader.c                    |   29 +-
 tools/lib/bpf/libbpf.c                        |  332 +++++-
 tools/lib/bpf/libbpf_internal.h               |   10 +
 tools/lib/bpf/linker.c                        |   38 +-
 tools/testing/selftests/bpf/Makefile.skel     |    2 +-
 .../selftests/bpf/exceptions_cleanup.h        |   56 +
 .../bpf/prog_tests/exceptions_cleanup.c       |  524 ++++++++
 .../selftests/bpf/progs/exceptions_cleanup.c  |  164 +++
 .../bpf/progs/exceptions_cleanup_ext_table.c  |   48 +
 .../bpf/progs/exceptions_cleanup_fail.c       |  678 +++++++++++
 .../bpf/progs/exceptions_cleanup_freplace.c   |   17 +
 .../bpf/progs/exceptions_cleanup_light.c      |   39 +
 .../progs/exceptions_cleanup_pad_freplace.c   |   17 +
 .../bpf/progs/exceptions_cleanup_shapes.c     | 1049 +++++++++++++++++
 40 files changed, 4410 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm64/net/bpf_cleanup_pad.S
 create mode 100644 arch/x86/net/bpf_cleanup_pad.S
 create mode 100644 kernel/bpf/exception.c
 create mode 100644 kernel/bpf/exception.h
 create mode 100644 tools/testing/selftests/bpf/exceptions_cleanup.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cle=
anup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
ext_table.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
light.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
pad_freplace.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
shapes.c

--=20
2.53.0-Meta

