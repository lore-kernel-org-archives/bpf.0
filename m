Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB838643B
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398824; cv=none; b=l+mhUp2S2/8GTZLrpMoqpo/rUIpVE7esdF+YoVdKTyuYtE59n9G4duHuki6mQoFN1sIKQUrHjzcFrBVXiqQh8WdaCGnGIl/oeSq+3j/FN/9zcIbwpwCFQ3F9GDZhbcG6FiIb7yuEKidsflMlkgk7hkinZ0Y4PRKFUw3pNLYZ750=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398824; c=relaxed/simple;
	bh=znnWdAvf0erpt0lKz/id2imGUbdSfqkkIWNZtL+zYkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IlcymipMMGGGk2RqUE0g25CIXUTNYDJqYLgAbKJm4zf/nD5tdtcMPv0Z1IVuKH/3ntzowjKVOszUwAvx3f9KyueP7tKSSSI9vZLSY3CxociYurPwlkd2jw1TxmVSH+GXwDEIzdthXiHj0QNj4jwulp25pGi4ouKjK6P2twT8Cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 556162D458C4CC; Fri, 25 Sep 2026 22:00:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 00/21] bpf: Run exception cleanup landing pads when bpf_unwind() unwinds
Date: Fri, 25 Sep 2026 22:00:06 -0700
Message-ID: <20260926050006.2213110-1-yonghong.song@linux.dev>
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
field a byte offset into the code section. The rule is "a frame suspended
at a call in [begin, end) resumes at landing_pad when an unwind passes
through". A pad ends with a call to _Unwind_Resume(), which the kernel
provides as the bpf_unwind_resume() kfunc.

Rather than overload bpf_throw(), which keeps its own meaning -- leave fo=
r
the exception boundary with the frames in between discarded -- a new
bpf_unwind() kfunc raises the unwind this series dispatches.

This series is the kernel half: take that table at BPF_PROG_LOAD, teach
the verifier that a covered call can also go to its landing pad, and have
bpf_unwind() run the pads as it walks.

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

Design
=3D=3D=3D=3D=3D=3D

A pad runs in the frame that owns it, entered by an ordinary return.
bpf_unwind() walks the frames with arch_bpf_stack_walk_ra(), which hands
out the slot each frame's return address came from, and rewrites that
slot: to the frame's landing pad where a record covers the call it is
suspended at, and to the frame's epilogue where nothing does. Then it
returns.

Each frame therefore runs its own pad, on its own stack, and leaves
through its own epilogue -- which is what puts its caller's r6-r9 back. T=
he
unwind needs no trampoline, no spill area and no per-frame metadata beyon=
d
the table itself. The fixups lower a pad's bpf_unwind_resume() to
"r0 =3D 0; exit", so the frame returns and the address rewritten below it
carries the unwind on to the next pad.

The verifier sees the same shape with no new machinery. A covered call
gets a second successor, its landing pad, in the same frame, and its entr=
y
state is the state at the call with the caller-saved registers gone, sinc=
e
the callee's epilogue puts them back on the way out. Nothing crosses a
frame boundary that the instruction stream does not already describe, so
precision, liveness and the resource checks work there as they do on any
other branch.

  1      pack bpf_insn_aux_data's flags into bit fields, so the flags thi=
s
         series adds cost bits rather than bytes
  2-3    uapi: cleanup_info in BPF_PROG_LOAD and struct bpf_cleanup_info;
         the bpf_unwind() and bpf_unwind_resume() kfuncs
  4-9    verifier: mark the covered call sites, give each an edge to its
         pad, and refuse the shapes that cannot be dispatched
  10     bpf_unwind(): rewrite the return addresses as it walks
  11-12  x86-64 and arm64 JITs
  13-17  libbpf: collect .bpf_cleanup, pass it to the kernel, resolve
         _Unwind_Resume, carry it through the light skeleton and the
         static linker
  18-21  selftests

Limitations
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  - Cleanup pads only. A catch pad -- one that ends in a plain exit rathe=
r
    than a resume, which is what Rust's catch_unwind would need -- is
    refused: bpf_unwind() rewrites every frame's return address in one
    pass, so a frame above a catch pad would resume at a pad for an unwin=
d
    that had already been caught. LLVM refuses type-specific catches and
    filters on its side as well.
  - A JIT that can dispatch pads is required: x86-64 (with
    CONFIG_UNWINDER_ORC, which bpf_throw() already needs there) and arm64=
.
    Anywhere else the load fails with -EOPNOTSUPP rather than silently
    doing nothing.
  - No offloaded programs, no private stack, and no combining a table wit=
h
    an exception callback.
  - In the pad's own frame: no tail call, no BPF_LD_[ABS|IND] and no
    indirect jump, none of which reaches the resume. And no second unwind
    anywhere above a pad, including a call to a global subprogram that ca=
n
    raise one.
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
  v5 -> v6:
    - v5: https://lore.kernel.org/bpf/20260923045846.2414643-1-yonghong.s=
ong@linux.dev/
    - Run a pad in the frame that owns it: bpf_unwind() rewrites each
      frame's saved return address rather than calling the pad as a
      subroutine of the walker. The bpf_cleanup_pad.S trampolines, the
      per-frame spill area and the pad-entry register header all go away.
    - Raise the unwind with a new bpf_unwind() kfunc, so that bpf_throw()
      keeps its meaning.
    - Add arch_bpf_stack_walk_ra(), which also hands out the slot a retur=
n
      address came from. arm64 re-signs the address it writes there.
    - A pad is an ordinary second successor of a covered call, so the
      verifier needs no unwind edge of its own: the cross-frame precision
      and liveness work is gone, with the v5 fixes it needed, and two
      patches become one.
    - Refuse the undispatchable shapes per instruction in do_check(), key=
ed
      on a per-frame mark, rather than by walking each pad.
    - Allow on-stack call arguments in a pad, which now has its own frame=
.
    - Add __set_global() and __ret_global() test tags, so RUN_TESTS() dri=
ves
      the shapes and test_shapes() goes away (suggested by Eduard).
    - Drop the shapes that needed a driver of their own, and the three
      extension objects with them.
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
  bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
  bpf: Add lookups for exception cleanup resumes and landing pads
  bpf: Prepare for an exception cleanup table before the CFG walk
  bpf: Make exception landing pads reachable in the CFG
  bpf: Resume a covered call at its landing pad
  bpf: Refuse a landing pad that does not resume
  bpf: Refuse a private stack for a program with an exception cleanup
    table
  bpf: Dispatch cleanup pads by rewriting return addresses
  bpf, x86: Dispatch exception cleanup pads at run time
  bpf, arm64: Dispatch exception cleanup pads at run time
  libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
  libbpf: Add cleanup_info to bpf_prog_load_opts
  libbpf: Collect .bpf_cleanup records and pass them to the kernel
  libbpf: Carry the exception cleanup table through the light skeleton
  libbpf: Let the static linker carry .bpf_cleanup relocations
  selftests/bpf: Add an end-to-end .bpf_cleanup exception test
  selftests/bpf: Add __set_global() and __ret_global() test tags
  selftests/bpf: Cover the exception cleanup shapes the chain does not
    reach
  selftests/bpf: Load an exception cleanup program from a light skeleton

 arch/arm64/kernel/stacktrace.c                |  94 +++
 arch/arm64/net/bpf_jit_comp.c                 |  20 +-
 arch/x86/net/bpf_jit_comp.c                   |  35 +-
 include/linux/bpf.h                           |  45 ++
 include/linux/bpf_verifier.h                  |  59 +-
 include/linux/filter.h                        |   3 +
 include/uapi/linux/bpf.h                      |   9 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/backtrack.c                        |  24 +-
 kernel/bpf/cfg.c                              |  65 +-
 kernel/bpf/check_btf.c                        | 134 ++++
 kernel/bpf/core.c                             |  25 +-
 kernel/bpf/exception.c                        | 260 +++++++
 kernel/bpf/exception.h                        |  23 +
 kernel/bpf/fixups.c                           | 141 +++-
 kernel/bpf/helpers.c                          |  61 ++
 kernel/bpf/liveness.c                         |  24 +
 kernel/bpf/syscall.c                          |   2 +-
 kernel/bpf/verifier.c                         |  93 +++
 tools/include/uapi/linux/bpf.h                |   9 +
 tools/lib/bpf/bpf.c                           |   6 +-
 tools/lib/bpf/bpf.h                           |   7 +-
 tools/lib/bpf/gen_loader.c                    |  29 +-
 tools/lib/bpf/libbpf.c                        | 342 ++++++++-
 tools/lib/bpf/libbpf_internal.h               |  10 +
 tools/lib/bpf/linker.c                        |  36 +-
 tools/testing/selftests/bpf/Makefile.skel     |   2 +-
 .../selftests/bpf/exceptions_cleanup.h        |  47 ++
 .../bpf/prog_tests/exceptions_cleanup.c       | 115 +++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   7 +
 .../selftests/bpf/progs/exceptions_cleanup.c  | 162 +++++
 .../bpf/progs/exceptions_cleanup_fail.c       | 593 ++++++++++++++++
 .../bpf/progs/exceptions_cleanup_light.c      |  39 +
 .../bpf/progs/exceptions_cleanup_shapes.c     | 665 ++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 207 ++++++
 35 files changed, 3351 insertions(+), 44 deletions(-)
 create mode 100644 kernel/bpf/exception.c
 create mode 100644 kernel/bpf/exception.h
 create mode 100644 tools/testing/selftests/bpf/exceptions_cleanup.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/exceptions_cle=
anup.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
light.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
shapes.c

--=20
2.53.0-Meta

