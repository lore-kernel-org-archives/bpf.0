Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41A32B102
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036918; cv=none; b=M/8vTly8E/ISVNWGxQUMPOkHdZhAJIVvNALdbt+PSg63F6ztVYoAcPd1lgc2kCrNbY8YURlzexPZiitFy041dcUk+UfQ2EloUSnotPBqQyEcJryeQLykjy3/BMagCkmf/ERkdf7Po4UZ+GKmqx+syp+LGXAV9K4y0HI876DgMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036918; c=relaxed/simple;
	bh=iYGScdFt0FI2T611MfM+d0y+pHzSDHUqjXoCxRTXd9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPkgQhhNumpnvCTksyFtE3uA/zKqjhyQ9HmKKSw8w0fBg9GZDmS0PG5HDCiqEVAOavFW2LZS3l5/z7wUvJSC8XA+dbomOANFpgw0sFjNemi81GCOFuftsk84/sDKRumCiISo3cEpaZfEP9Ar6EdJoJpqA3bp/WwN4lAvlme0cCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 91E9D314986E37; Wed, 14 Oct 2026 21:01:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 00/26] bpf: Run exception cleanup landing pads when bpf_unwind() unwinds
Date: Wed, 14 Oct 2026 21:01:43 -0700
Message-ID: <20261015040143.854070-1-yonghong.song@linux.dev>
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
the verifier to follow an unwind to the landing pad it reaches, and have
bpf_unwind() send each frame it leaves there.

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
slot for every frame above the one that called it: to the landing pad
where a record covers the call the address returns into, and to that
frame's epilogue where nothing does. It finds the frames in the calling
program itself, whose aux the verifier passes it as an implicit argument.
Then it returns. The frame that called it goes on after the call, where
the fixups put 'r0 =3D 0' and then a jump to its own pad, or an exit wher=
e
no record covers the call.

Each frame therefore runs its own pad, on its own stack, and leaves
through its own epilogue -- which is what puts its caller's r6-r9 back. T=
he
unwind needs no trampoline, no spill area and no per-frame metadata beyon=
d
the table itself. The fixups lower a pad's bpf_unwind_resume() to
'r0 =3D 0; exit', so the frame returns and the address rewritten below it
carries the unwind on to the next pad. For main -> A -> B -> C with only
A's call to B covered, an unwind raised in C runs:

  frame   runs
  -----   ----------------------------------------------------------
  C       'r0 =3D 0; exit', patched in after its bpf_unwind()
  B       its epilogue, putting back A's r6-r9
  A       its pad, which drops A's resources; the resume is an exit
  main    its epilogue, returning 0 to the kernel

The verifier follows the same path. A bpf_unwind() goes on at its own
frame's pad, or pops frames to the first pad that covers a call, or to th=
e
main program's exit, where nothing may still be held and the zero returne=
d
has to suit the program type. Only there are an unwind's resources
checked, since a pad may drop what another frame acquired, as when Rust
moves a value into a callee. A resume goes on below its frame the same
way. The pad is entered from the state the unwind leaves, not from a
snapshot at the call: before unwinding, a callee may have written its
caller's stack through a pointer, overwritten a spilled pointer, or
changed packet data, and the callee's epilogue puts back none of that. A
global subprog is verified on its own, so a call to one that can unwind
gets a second successor, the unwind, taken from the state the call
returns in. Precision backtracking follows the same edges back, into the
frame the unwind left.

  1      pack bpf_insn_aux_data's flags into bit fields, so the flags thi=
s
         series adds cost bits rather than bytes
  2-3    uapi: cleanup_info in BPF_PROG_LOAD and struct bpf_cleanup_info;
         the bpf_unwind() and bpf_unwind_resume() kfuncs
  4-6    keep a call site's pad in insn_aux_data, mark the covered call
         sites, refuse what cannot carry a table, and make the landing pa=
ds
         reachable in the CFG and in liveness
  7      verifier: follow an unwind through landing pads and epilogues
  8-10   refuse a callback that can unwind and a pad that does not
         resume; no private stack for a program that can unwind
  11     lower the unwind and resume calls, and build the native cleanup
         tables
  12     keep an exit in every function the walk can pass, putting one in
         a function that has none
  13     let a subprog end with a call that does not return, as a compile=
r
         emits one
  14     bpf_unwind(): rewrite the return addresses as it walks
  15     refuse a trampoline that calls a subprog that can unwind
  16-17  x86-64 and arm64 JITs
  18-22  libbpf: resolve _Unwind_Resume, collect .bpf_cleanup and pass it
         to the kernel, carry it through the light skeleton and the stati=
c
         linker
  23-26  selftests

Limitations
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  - Cleanup pads only. A catch pad, which Rust's catch_unwind would need,
    is refused: bpf_unwind() rewrites every frame in one pass.
  - Needs a JIT that dispatches pads: x86-64 with CONFIG_UNWINDER_ORC, an=
d
    arm64. Elsewhere the load fails with -EOPNOTSUPP.
  - Not with offload, a private stack, a verifier_ops epilogue, bpf_throw=
()
    or an exception callback.
  - In a pad's frame: no tail call, BPF_LD_[ABS|IND] or indirect jump, an=
d
    no second unwind in the pad or anything it calls.
  - A subprog that can unwind cannot be a callback, nor be attached by
    fexit, fmod_ret or fsession. One with a callx counts as able to unwin=
d
    when any subprog whose address is taken can.
  - Until the Rust toolchain supports BPF exception handling, the selftes=
ts
    write their tables by hand in inline asm.

  [1] https://github.com/llvm/llvm-project/pull/192164
      llvm commit 9d51c891b719 ("[BPF] Add exception handling support
      with .bpf_cleanup section")

Changelog
=3D=3D=3D=3D=3D=3D=3D=3D=3D
  v10 -> v11:
    - v10: https://lore.kernel.org/bpf/20261009041447.17092-1-yonghong.so=
ng@linux.dev/
    - New patch 12, split out of patch 11: a subprog an unwind passes
      through without an exit, such as one ending in the loop rustc puts
      after a call that does not return, gets one after its last insn
      instead of being refused. The last insn keeps its aux data.
    - New patch 13: let a subprog end with a call that does not return,
      the way rustc ends one with a call to a '-> !' function and LLVM a
      pad with its _Unwind_Resume call. check_subprogs() accepts a final
      call to a subprog with no exit, or to bpf_unwind(),
      bpf_unwind_resume() or bpf_throw(); do_check() refuses a path on
      which the call returns. The CFG walk, stack liveness and precision
      backtracking handle a call with no fall-through.
    - When an unwind with no pad leaves a resource held, report it as
      "bpf_unwind cannot be used inside ..." at the unwinding insn,
      instead of as a BPF_EXIT in main.
    - Run the in-pad checks from do_check_insn().
    - arm64: sign the new return address with PACIA1716, so no assembler
      support for pointer authentication is needed.
    - libbpf: read the .bpf_cleanup fields with memcpy(), as the section
      may be unaligned in a linked object; when _Unwind_Resume's prototyp=
e
      does not match, name bpf_unwind_resume in the warning.
  v9 -> v10:
    - v9: https://lore.kernel.org/bpf/20261008074959.2993751-1-yonghong.s=
ong@linux.dev/
    - Split the callback refusal into its own patch 8.
    - Fix a verifier_bug() when a global call's pad is the next insn.
    - On a cleanup_info record with a nonzero tail, fail with -E2BIG
      without writing a record size back into the attr.
  v8 -> v9:
    - v8: https://lore.kernel.org/bpf/20261001133006.1335369-1-yonghong.s=
ong@linux.dev/
    - unwind_frames() destroys popped frames' dynptrs.
    - Drop patch 8: it refused a callee's pad dropping a reference its
      caller acquired, which is how Rust compiles moving a value into a
      callee. Held resources are checked only where main or a global
      subprog returns.
    - Drop the per-insn in/outside-pad marks; compare in_pad when pruning=
.
    - Split patch 11 into 10 (prepare the JITed program) and 11 (the walk=
).
    - bpf_unwind() finds frames in its program's aux (KF_IMPLICIT_ARGS),
      not in kallsyms, which can go while an instance still runs.
    - New patch 12: refuse fexit/fmod_ret/fsession on an unwinding subpro=
g.
    - x86, arm64: make bpf_unwind() notrace and NOKPROBE, drop the
      hooked-return warning; arm64: drop the PAC modifier check.
    - Fix an unwind out of main inside a loop, and a global subprog
      returning in R0:R2; narrow the callx might_unwind marking.
    - libbpf: skip records of an overridden weak function; leave table
      checks to the kernel.
  v7 -> v8:
    - v7: https://lore.kernel.org/bpf/20260929001601.3242665-1-yonghong.s=
ong@linux.dev/
    - Follow an unwind to its pad from the state it leaves, not from a
      snapshot at the call; patch 7 is renamed to match.
    - Follow the unwind out of a call to a global subprogram as well: the
      call continues at the next insn and, from the state it returns in,
      at its pad or further out.
    - Backtrack precision across an unwind; clear r1-r5 at a main-frame
      unwind exit.
    - bpf_unwind() leaves its own caller alone; the fixups put 'r0 =3D 0'=
 and
      a jump to its pad after the call.
    - Refuse bpf_throw() and an exception callback with any unwind, not
      only with a table.
    - Refuse a subprogram an unwind passes through that has no exit.
    - Patch 8's rule that a frame an unwind leaves holds what it entered
      with no longer keeps the pads safe; it stays to refuse a program at
      the frame at fault.
    - A speculative walk leaves no in-pad or outside-pad mark.
    - x86, arm64: warn on a hooked return. arm64: take the PAC modifier a=
s
      record + 16, and allow a shadow call stack.
    - libbpf: narrow the _Unwind_Resume translation, close the opts hole,
      size the light skeleton's attr by need, and tighten the linker chec=
k.
  v6 -> v7:
    - v6: https://lore.kernel.org/bpf/20260926050006.2213110-1-yonghong.s=
ong@linux.dev/
    - New patch: require an unwind to leave a frame holding what it enter=
ed
      with, including at a call it passes through with no record over it.
    - A resume ends the verifier's path instead of walking back to the
      instruction after the call, where an unwind never returns.
    - Refuse a private stack for any program that can unwind, not only on=
e
      carrying a table.
    - Refuse a table for a program whose verifier_ops plants an epilogue,
      and scan the whole instruction stream for bpf_throw().
    - Keep the last exit of every subprogram an unwind can pass through,
      not only the one after a bpf_unwind() call, and search for it.
    - Fix precision backtracking across a resume, push a landing pad by
      itself so the CFG walk's DFS invariant holds, and mark callx sites.
    - x86: leave a frame whose return a tracer has hooked alone; no ENDBR
      at a pad head, which is only ever reached by a return.
    - arm64: no BTI at a pad head; ask the build whether a return address
      is signed; refuse cleanup pads where a shadow call stack is in use.
    - Answer a speculative walk reaching a pad with a barrier, not a refu=
sal.
    - selftests: add the negative shapes for the above, allow repeated
      __set_global()/__ret_global(), and drop duplicate accepted shapes.
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

Yonghong Song (26):
  bpf: Pack bpf_insn_aux_data flags into bit fields
  bpf: Accept the compiler's exception cleanup table at program load
  bpf: Add the bpf_unwind() and bpf_unwind_resume() kfuncs
  bpf: Keep a call site's landing pad in insn_aux_data, add lookups
  bpf: Mark covered call sites and check a program can take a table
  bpf: Make exception landing pads reachable in the CFG
  bpf: Verify an unwind through landing pads and epilogues
  bpf: Refuse a callback that can unwind
  bpf: Refuse a landing pad that does not resume
  bpf: Do not use a private stack for a program that can unwind
  bpf: Prepare JITed programs for dispatching cleanup pads
  bpf: Keep an epilogue for each subprog an unwind can pass through
  bpf: Allow a subprog to end with a call that does not return
  bpf: Dispatch cleanup pads by rewriting return addresses
  bpf: Refuse a trampoline that calls a subprog that can unwind
  bpf, x86: Dispatch exception cleanup pads at run time
  bpf, arm64: Dispatch exception cleanup pads at run time
  libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
  libbpf: Add cleanup_info to bpf_prog_load_opts
  libbpf: Collect .bpf_cleanup records and pass them to the kernel
  libbpf: Carry the exception cleanup table through the light skeleton
  libbpf: Let the static linker carry .bpf_cleanup relocations
  selftests/bpf: Add end-to-end and negative .bpf_cleanup exception
    tests
  selftests/bpf: Add __set_global() and __ret_global() test tags
  selftests/bpf: Cover more accepted .bpf_cleanup exception shapes
  selftests/bpf: Load an exception cleanup program from a light skeleton

 arch/arm64/kernel/stacktrace.c                |   77 +
 arch/arm64/net/bpf_jit_comp.c                 |   16 +
 arch/x86/net/bpf_jit_comp.c                   |   36 +
 include/linux/bpf.h                           |   31 +
 include/linux/bpf_verifier.h                  |   79 +-
 include/linux/filter.h                        |    3 +
 include/uapi/linux/bpf.h                      |   14 +
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/backtrack.c                        |   46 +-
 kernel/bpf/cfg.c                              |  131 ++
 kernel/bpf/core.c                             |   12 +
 kernel/bpf/exception.c                        |  379 +++++
 kernel/bpf/exception.h                        |   30 +
 kernel/bpf/fixups.c                           |  195 ++-
 kernel/bpf/helpers.c                          |   78 +
 kernel/bpf/liveness.c                         |   31 +-
 kernel/bpf/states.c                           |   11 +-
 kernel/bpf/syscall.c                          |    2 +-
 kernel/bpf/verifier.c                         |  283 +++-
 tools/include/uapi/linux/bpf.h                |   14 +
 tools/lib/bpf/bpf.c                           |    6 +-
 tools/lib/bpf/bpf.h                           |   10 +-
 tools/lib/bpf/gen_loader.c                    |   29 +-
 tools/lib/bpf/libbpf.c                        |  343 ++++-
 tools/lib/bpf/libbpf_internal.h               |   10 +
 tools/lib/bpf/linker.c                        |   39 +-
 tools/testing/selftests/bpf/Makefile.skel     |    2 +-
 .../selftests/bpf/exceptions_cleanup.h        |   54 +
 .../bpf/prog_tests/exceptions_cleanup.c       |  173 +++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   12 +
 .../selftests/bpf/progs/exceptions_cleanup.c  |  157 ++
 .../bpf/progs/exceptions_cleanup_fail.c       |  904 ++++++++++++
 .../bpf/progs/exceptions_cleanup_shapes.c     | 1304 +++++++++++++++++
 .../bpf/progs/exceptions_cleanup_tracing.c    |   26 +
 .../selftests/bpf/progs/verifier_cfg.c        |   76 +
 tools/testing/selftests/bpf/test_loader.c     |  319 +++-
 36 files changed, 4850 insertions(+), 84 deletions(-)
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
shapes.c
 create mode 100644 tools/testing/selftests/bpf/progs/exceptions_cleanup_=
tracing.c

--=20
2.53.0-Meta

