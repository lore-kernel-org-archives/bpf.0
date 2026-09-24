Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CBE349CD6
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238372; cv=none; b=Lc4B66xTubtyt04wMa0cm168mXA7mxmLVyPK28x3mPwZKMKg/xahxjigRRbYlS9fIlGVnmHiBfr/bcRK59ZbqkooBtCD1Sak07f6bjwwUK9BATwCL0gOQfb7t4qEKzdk/xrVShGc9xGuSG199UKew6ayXPUOq12PQW3Rj4fLzp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238372; c=relaxed/simple;
	bh=gpGTDKU2BzQPjrFaTfkAFphYZ955QIdDlEHCx3IOl2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E0R9MqxT8Mtg3fT2p2zbM7GeixTqxnSQA7XNymA+Gc0UsQgin8BtmrjimPEFxuECUQHVNbsY522C5h2XSPYoszz6TCb0s6nmc29MzuG95W5SqN6rnLXiEaYUmrjpeOkEUwgt5oAbp4tUDliuy+zKtawVVfhkgXzVOdNFXg5q/q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJEj1CZz; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJEj1CZz"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so5005175e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238369; x=1790843169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YJpiY9+8VDFi7ZesG8yUOiwJ/Nv+16/b78//hJ/DP/Q=;
        b=FJEj1CZzu34FIUOc8X0LH1Z09a2FPeqy23zKWC0U6g0q34Qv/fgxFWBBqLixdmtpMs
         8QK1KFLU7lqu57FpBecFmD8AQJRpe7lX0OjTQtMk7I2SNIhUB5A6/Fstm9sbAjVXQ6zv
         dl8muFcj+pJSKLdcBkfBDSlyYslCTXvwsA9gXioIJGpyRNW1rJmGGHtUyjZTKur7tLMQ
         kZWUufpFBYDP0Yh2EEmN9/1bnJRoT0XVJyPdCuhcw0I6JW7/Q82kPliRVOi5LY7FkzG4
         qsg8t7X1G6ty5EIy2VK0Hw/CQn/LKkySnsecWE6cMP5cRHf7hg1mSGYSwV9Y0Xc8eIp0
         aEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238369; x=1790843169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YJpiY9+8VDFi7ZesG8yUOiwJ/Nv+16/b78//hJ/DP/Q=;
        b=zygmsjcGSxPnuUxK6IRyDHxm0WuIfWaeovjC7AcxOyGlG1cOOtg/R2/vVmqKyGYP/V
         ODh8KHwz8QgUO7b7b/v8E6XodndOptAYnXC2kPorSEiyw8qazV0ghR4NtabKuU9QmMGl
         2iDrPOFmPcr1UMlxLLtcYcOSCnpbQqwRst6bAU1U8EmqVXOBHgyyFKJTByr2SHpnkSVG
         8BDt4coNcG16hxSohpuHwsSzmbJaOOuVwaFuiHUvi55k4XEfV+gzyxySNn7K5YvOI9N1
         mzXzs3l8ZSY8BjDZCNsn356mKmG10sPIKS0GyOxv0l/ohWlrxRCIENI7rFwCG7D8m87L
         247w==
X-Gm-Message-State: AFuF++lbBjMepPFT0BlR0OzPctC4BIH57LyvTI8nWxZCwGPjpTi2Lu6v
	VDTRFBgcF2s3AcI9UJ7LcTj4m1G1ctqR9qm+JcLHD+dixXAzCngXgwqCUC75A3bR
X-Gm-Gg: AYBFou3SacYaFWiKwdNrywDz7MY9u2AcWJjDtOFH4cWieOxlU6AiB81yLiOcSbAiL5k
	OYWSqfl6P4zJqVP79cF5pH05EX5mGwioCp38ERqpKSG2wx5s+ETN0POJDrMYpiBwSqHlP/Sd0CE
	XslHnWSyL8/XzyJLmQbERwP36aCw6512sHMS8Vl+UzaD5ubp6Pbpj1RhmbnNub5gmyrjOgnwCj2
	A1+jdpJZ6Jhu0Z4oi7B/hxpQrN/x0LDR0o7rbm5aqvgrYVaJAusGlA7coROok50x1yH2e+RySDD
	1Crbtn9zzJsPGBRCF2trtlKumlCMWVS0BqeKgTbdKJD90GUFY8bhMG/BY0/X1t4d+Mta+WhfFaz
	u749Osl0qSUDpk3IicCF7V/tn+xynn8g0J3N4xNamN1eTaVcmeIRvbQzR2ldS1Rv0OvPIwsRyIG
	JcGBZgRXFfCsyCU+AFKexcINn+xaS/pzF909B3KpvAAzUzzNQip2zhK9w3fAvCEtfVQIQXX63fA
	vBLlKiSjP9gISZNL9nCFmrjS56/doSZ2zPvHZphm1+u20p5pcpgS7aex43bPDRst/nua8oZ3C6I
	YA+iKwkoXURtyu7nPnbQW4iccXi2m0Xr1gnWYA==
X-Received: by 2002:a05:600c:1546:b0:49e:81a7:9fbc with SMTP id 5b1f17b1804b1-49fe66fa0ddmr30020645e9.24.1790238368786;
        Thu, 24 Sep 2026 01:26:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf3541aesm77160015e9.0.2026.09.24.01.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 00/18] Raise BPF program stack size to 2KiB
Date: Thu, 24 Sep 2026 10:25:36 +0200
Message-ID: <20260924082607.2695649-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10824; i=memxor@gmail.com; h=from:subject; bh=gpGTDKU2BzQPjrFaTfkAFphYZ955QIdDlEHCx3IOl2o=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvYT3jLc/7XfpPcJcbtqScFXqknfUM7HSZOsc1Xw1t g/f33l1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKNCxgZTrtt3ui+fsW1ox/X 7jbgrTpkP0Pyz4//WkcMhRa2PF0+3YOR4a7JOhutkEOPdOb0Buxv37Fw19f0ZRa5i/gSPD5vMfM N4wMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

BPF programs get 512 bytes of stack. This series raises that to 2 KiB
on x86-64 and arm64. The budget covers a whole call chain, or each frame
on a private stack, and a single function may use all of it. The
interpreter, offloaded programs and the other JITs keep 512 bytes.

The x86-64 and arm64 JITs do not depend on 512-byte frames: both encode
frame sizes in wide enough immediates, and on both a tail call pops the
caller's frame and lands in the target's prologue before the target sets
up its own.

The verifier needs several changes, however. Its bookkeeping assumes at
most 64 slots per frame: the jump history and linked register records
carry 6-bit slot indexes, backtracking and the scratched-slot log keep
one u64 per frame, the id map is sized for 64 slots per frame, and
liveness keeps three fixed 128-bit masks per instruction per frame.
Growing all of this fourfold would make every program pay for stack
limits that most program will not exercise. Therefore, some dynamicity
is needed without blowing verifier memory usage out of proportion.

The series first removes these assumptions without changing what
verifies (patches 1-8). The liveness masks become bitmaps as wide as the
stack a frame actually uses, and the id scratch grows on demand. It then
adds a per-program budget, bpf_prog_stack_limit(): 2 KiB when the
program is JITed, not offloaded, and the JIT reports
bpf_jit_supports_large_stack() along with tail calls from subprograms,
and 512 bytes otherwise. Finally, it turns the budget on for x86-64 and
arm64.

Tail calls need no separate limit. A tail call pops the frame that makes
it, and the frames its callers leave behind are still limited to 256
bytes by the existing rule for tail calls from subprograms. Only the
final program's frame in a tail call chain grows, from 512 bytes to 2
KiB, so the chain's worst-case kernel stack use grows from about 8.5 KiB
to about 10 KiB. The budget does not depend on privilege: an
unprivileged program cannot call other BPF functions, so its tail calls
leave no frame behind and its worst case is a single 2 KiB frame.

Memory was measured as the peak kernel memory allocated during each
BPF_PROG_LOAD, for all 5162 loadable selftest programs, against bpf-next
at 24629aac43d2. "Total" is the sum of the per-program peaks. Two runs of
one kernel agree to 0.01% in total; a handful of small programs differ by
one 64 KiB allocation between runs, and those one-off jumps are left out
of the per-program rows.

                                      patches 1-8   whole series
  total                                  -0.72%        -0.50%
    5027 programs under 1 MiB            -0.32%        -0.13%
     116 programs of 1-16 MiB            -0.58%        +0.26%
      19 programs of 16 MiB or more      -1.09%        -1.05%
  median program                          0.0%          0.0%
  programs growing by more than 5%          11            59
  largest increase                        +16%          +19%
  largest decrease                       -5.0%         -5.0%

The savings come from liveness: a frame within 256 bytes needs 24 bytes
of masks per instruction instead of 48. The largest are pyperf600
(-5.2 MiB, -2.0%), pyperf180 (-3.2 MiB, -2.8%), pyperf100 (-2.8 MiB,
-3.1%) and test_verif_scale2 (-1.0 MiB, -5.0%).

The increases have two causes:

 * history: the jump history entry grows from 16 to 20 bytes, which
   penalizes loop-heavy programs. This is already present in patches 1-8.
 * masks: a frame read as a whole through a pointer of unknown offset
   keeps liveness masks as wide as the 2 KiB budget. This appears only
   once the budget is raised.

The largest absolute increases for the whole series (peak in MiB):

  program                                   before  after   MiB      %  cause
  loop1/nested_loops                          17.6   19.2  +1.5    +9%  history
  strobemeta_bpf_loop/on_event                10.5   11.8  +1.3   +12%  masks
  verifier_loops1/jumps_out_rather_than_in     4.4    5.1  +0.7   +16%  history
  pyperf600_bpf_loop/on_event                  5.6    6.3  +0.7   +12%  masks
  pyperf600_nounroll/on_event                 80.3   80.9  +0.6    +1%  history
  strobemeta_nounroll2/on_event               44.5   45.1  +0.6    +1%  both
  strobemeta/on_event                        201.8  202.4  +0.5  +0.3%  history
  bpf_iter_tasks/dump_task_sleepable           8.2    8.6  +0.4    +5%  both
  test_tcp_custom_syncookie                   10.8   11.2  +0.4    +4%  masks
  strobemeta_nounroll1/on_event               20.9   21.3  +0.4    +2%  both

The largest relative increases are small programs whose frame is read as
a whole, each growing by 50 to 110 KiB: verifier_bitfield_write +15 to
19%, test_tc_tunnel +13 to 15% and dynptr_success +12%.

No selftest program uses more than 512 bytes, so a few were rebuilt with
a 1 KiB local array handed only to an empty asm statement and
-mllvm -bpf-stack-size=2048, which puts every spill below fp-1024 while
the verifier never touches the array. They verify with the states and
instructions of their unpadded twins; what grows is the verifier state,
which carries 88 bytes per stack slot up to the deepest one touched:

  program             slots    insns          states       peak MiB
  pyperf600           37/165   258028/258030  16635/16635  208/905
  strobemeta          61/189   164241/164243  4719/4719    202/870
  test_cls_redirect   22/150   59764/59766    3893/3893    7/186
  test_verif_scale2   3/131    779692/779694  3048/3048    12/169

(unpadded/padded; the two extra instructions are the asm barrier).

In terms of verification time, the changes are within margin of error.

For more details, please see the individual commits.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260923191139.2816206-1-memxor@gmail.com

 * Rebase on bpf-next. Rewrite the new callx stack depth tests, which
   expect 608 bytes of stack to be rejected, to use call chains deeper
   than 2 KiB, so that they are rejected under both budgets.
 * Size the liveness spill tracker by the deepest 8-byte access a
   subprog makes directly through R10 when that reaches past the 64
   slots of a 512-byte frame, so that a pointer spilled below fp-512
   keeps its identity when filled; add a test, and report programs that
   spill that deep in the cover letter. (Alexei)
 * Return -ENOMEM from the iterator destroy path when the id stack
   cannot grow, and keep warning about any other release_reference()
   failure. (Sashiko)
 * Read 248 instead of 264 bytes into the frame in the liveness merge
   test, so the precise pass is narrower than a 512-byte whole-frame
   read on 64-bit and the widening is exercised everywhere. (Sashiko)
 * Convert the nfp offload driver's stack slot indexing to
   bpf_stack_slot(), note the address-based lookup in reg_to_target(),
   fetch each slot once in the functions the message names, and narrow
   the accessor patch's message accordingly. (BPF CI)
 * Raise the verifier log's line buffer to 2 KiB so that a full 256-slot
   stack mask fits in one line. (BPF CI)
 * Say in the stack size Q&A that the interpreter's 512 bytes apply per
   frame and to programs verified for it. (BPF CI)

Kumar Kartikeya Dwivedi (18):
  bpf: Add accessors for verifier stack slots
  bpf: Widen the stack slot index in the jump history
  bpf: Store linked registers in the jump history as an array
  bpf: Track backtracking stack slots with bitmaps
  bpf: Track scratched stack slots with a bitmap
  bpf: Treat unknown-size stack reads as reaching the frame top
  bpf: Size liveness stack masks by the stack each frame uses
  bpf: Grow the verifier id scratch on demand
  selftests/bpf: Cover the tail call caller stack depth limit
  selftests/bpf: Check that narrow stack stores define no slot
  selftests/bpf: Check liveness merge of masks with different widths
  bpf: Size the per-frame verifier structures for a 2 KiB stack
  bpf: Bound program stack use by a per-program limit
  selftests/bpf: Add load conditions on the program stack limit
  selftests/bpf: Give the 512-byte stack boundary tests a 2 KiB twin
  bpf, x86: Allow programs 2 KiB of stack
  bpf, arm64: Allow programs 2 KiB of stack
  selftests/bpf: Test the 2 KiB stack budget

 Documentation/bpf/bpf_design_QA.rst           |  11 +-
 arch/arm64/net/bpf_jit_comp.c                 |   5 +
 arch/x86/net/bpf_jit_comp.c                   |  12 +
 .../net/ethernet/netronome/nfp/bpf/verifier.c |   2 +-
 include/linux/bpf_verifier.h                  | 205 +++----
 include/linux/filter.h                        |   6 +
 kernel/bpf/backtrack.c                        | 101 ++--
 kernel/bpf/core.c                             |  13 +
 kernel/bpf/diagnostics.c                      |  11 +-
 kernel/bpf/liveness.c                         | 516 ++++++++++++------
 kernel/bpf/log.c                              |  13 +-
 kernel/bpf/states.c                           | 136 +++--
 kernel/bpf/verifier.c                         | 334 ++++++------
 .../bpf/prog_tests/struct_ops_private_stack.c |  31 ++
 .../selftests/bpf/prog_tests/tailcalls.c      |  42 ++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/async_stack_depth.c   |  75 +++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   3 +
 .../bpf/progs/struct_ops_private_stack_fail.c |  47 +-
 .../progs/struct_ops_private_stack_large.c    |  51 ++
 .../bpf/progs/tailcall_large_stack.c          |  62 +++
 .../selftests/bpf/progs/test_global_func1.c   |  65 +++
 .../bpf/progs/test_global_func_deep_stack.c   |  33 +-
 .../selftests/bpf/progs/verifier_callx.c      |  61 ++-
 .../bpf/progs/verifier_callx_rodata.c         |  53 +-
 .../bpf/progs/verifier_large_stack.c          | 377 +++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c | 104 +++-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  21 +
 .../selftests/bpf/progs/verifier_stack_ptr.c  |  53 ++
 .../selftests/bpf/progs/verifier_tailcall.c   |  57 ++
 .../selftests/bpf/progs/verifier_var_off.c    |  32 ++
 tools/testing/selftests/bpf/test_loader.c     |  24 +
 tools/testing/selftests/bpf/testing_helpers.c |  41 ++
 tools/testing/selftests/bpf/testing_helpers.h |   1 +
 tools/testing/selftests/bpf/verifier/calls.c  | 122 ++++-
 35 files changed, 2152 insertions(+), 570 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_stack_large.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_large_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_large_stack.c


base-commit: 24629aac43d2884109ae47a993fd51b504e2b09b
-- 
2.53.0

