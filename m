Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB3409DF0
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641259; cv=none; b=IA2GLw2ioGp7DdYs4/wA4oJAXMeDxpuM4ofNTLFkMAPH+QIo339AxMIeY+u70A/yVWT0ceYJcMIgpwH82Zbye6yMojWbl9yKWBJIj56R1oKTd5nBRYRcxBCQ/7vs9XYEFWvYUN4OcyEhrWDLMz39WqOZ/X74uFBxuy2+JGUom/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641259; c=relaxed/simple;
	bh=makTFviQ+TzNumIOs0w4Qlq8kngZzj4v0YV7Uya8p+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5xpHoLu2qxsg1k3YsZ1Uk+YgwnPU/1//lUzlIl01FGX16lS7GijM7bGT/R6SK/nmzrbkha8lIgU7Zf8qpz3adjI84LMKE9l36bcm0hnA6D5rElG79+nBb7ojmfAqGx630wkWE1kC3Cl6LEmyQV77K65CTTD8aazd+S44I2CQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgk0dCWS; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgk0dCWS"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490b613a17bso14245615e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641254; x=1781246054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Szf2uGkR+E/OlqY7p4a65ifSUeW9Lex7pkn94I5rcmI=;
        b=mgk0dCWSoFzuFaHNA/FDkFyrvs9nP8kDDVkbDk2mvFcyRARUOt6bahr/HDLfKRxl2T
         RAhv7V4IpdN6foa2xkJqpcU0SX/3xFd76kfZcoqz3DOvS5MXjmlfhd08LFQjYv/d+hZi
         DfxWHruzdyYc8s7kPKRiuhbqZ29Wby4H7cJV2nf1QEDZVAnpCg/xtNMSZA8dbMeACvkt
         0isdFpHJUlGLsD8BnbTrCxJTNpCY+poi30/eTQC6waEiozVIGmyonPZAk5Bun2AXhSaP
         nSRDbIOZzDZ4Lzy/fu0sOED9tFVkv5nJ9t+Y1UvHp9OG3FXwJabrTTqjEX6h8HdmVZWp
         YwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641254; x=1781246054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Szf2uGkR+E/OlqY7p4a65ifSUeW9Lex7pkn94I5rcmI=;
        b=o6uJLZvT2/nOxj9pyBimUWGqBxRvGvKmHPl2vsajz9xUiwervMrxeYzFkEva3qNrst
         rnPagn33pnuDhVqZsiDnsdYMA4P2UhT+osSiSesFFTyuFHwG0gcolKElNWu86BH7yWBU
         15mdLN7K4BEOLn6NF47g4SuKgW6b2xpqY4PMPZM6pqg69fRoa3npYIgcYit0i/r5FakT
         JAaF2/qE65IgWKAQZeAdN/LVf5YvNSP6sIlVsZML9NJqsv9NVj71Z6rmiYvJf0qFt4aM
         glqChGgRqemKf+4WhrT3MSCVsBhfAD3fPpqKFfZ+OA6BwohaXCTDMVmsPlQpTJhPHIfD
         x8UQ==
X-Gm-Message-State: AOJu0Yyp33J3NixV9SO7/JPO8fLzC3KuK1qLVBMlCPvZqxeZ0p3bbBM1
	gBsAuH9XKR5Cgnpr3oD2y6Ybu47+VDSwmQciUnXSSKsVBmdgClwYbbsGyRAuyZzl
X-Gm-Gg: Acq92OF5SM0l2IOoEUiDFcq2L1+NIQszO6+MlgbutsJ9B8YTXJ+tmIpS7K9wUJ93jC9
	LfAPWE8YB3RGoR9OvDVOMPPhwUStoZLx9BlbFy657RQbmhxI0ikHNHXcGWGNhFd3kZiDEnxk2Q+
	gFlcnT4x016sGwhoeW1PgydOMctLA05SQA/SYVn9mKQG8UmoeQFUtPuDJJDTp9wHZcFrHwBwoWW
	kBRaMTm3kOB9sOxBeyNFvCAdD0JYcLJKYdDVyR9LQtb751V4V8RcVimUln7+dA+Tn9Nej5vO1XX
	IKuoAHiJWNBVZzLgcNKXHLTUyDsNUbZE5SETHenUU5MKs17yUgtcl+TG6lxf0sfXYI6bF21diBU
	PCxHF7jWX9D6hP6P/M1tzKoDfDbyizd+55PiFf8cozfL6AnaXSrRGwPPR1T5Kh51IwqBO7w4Dix
	hSxj08Kt2qctAVrx1/3U0lORl5JU/HslSDfy06FtMjmIv9PMOMQUI12Gh2gUqZ1rMKCgMES1aBI
	RKE1FV+lJIMJ8rgECTPwSgHKW+0mL+D6N6PiLcIa9aOlQ7CgtNTsTcdK19bbsf213SGyyk9XJxG
X-Received: by 2002:a05:600c:458a:b0:48a:525b:e148 with SMTP id 5b1f17b1804b1-490c25adb21mr29890585e9.4.1780641253482;
        Thu, 04 Jun 2026 23:34:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm38020434f8f.27.2026.06.04.23.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/17] Redesign Verification Errors
Date: Fri,  5 Jun 2026 08:33:50 +0200
Message-ID: <20260605063412.974640-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27804; i=memxor@gmail.com; h=from:subject; bh=makTFviQ+TzNumIOs0w4Qlq8kngZzj4v0YV7Uya8p+8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt0D5z7P7ddHHNCb/fPG2Ve7khfrd5uJvJUVXsUxZt K8wIXR9RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYyT47hr1ytXG1x5Vv2pH2L D524sO7l0fQ/s2y+nBdO5VJl3PvD5SYjw1Or6vIfP8xtmk7u/HHnpMJ51w1O1SZXzrybs4nH2fp NOysA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

TL;DR: This set reworks verifier error messages to include source and
instruction annotations, together with more causal context, making
failures easier to understand and more actionable when debugging and
repairing BPF programs.

Motivation
~~~~~~~~~~

The verifier log is the primary interface through which the verifier
communicates to the user its verdict on whether a program was accepted
or rejected.

To aid the debugging of rejection decisions, verifier also reports the
symbolic state of the program at each instruction, across every explored
path of the BPF program. Such detailed information is critical to
introspect the correctness of verification decisions, and provide
insight into why a given program may have failed to load in the kernel.

A constant pain point in BPF ecosystem throughout the years has been the
difficulty of debugging verification errors. The human-readable error
messages produced in response to a failure in satisfying safety-related
constraints are often terse, context-dependent, or insufficient for
understanding why a given error may have happened. Users must fall back
to the verbose instruction-by-instruction breakdown of how the symbolic
state evolved to surface the root cause. For programs with a huge log
volume due to high verification complexity, such logs quickly become
inscrutable.

All of this has made life difficult for users lacking an understanding
of how the verifier works, and the various heuristics and idiosyncracies
used by it. In some cases, even seasoned BPF experts spend significant
time reverse engineering why a program may have failed, and have to
reach into the verifier's source code to form a complete picture of the
verification process.

Such a steep learning curve and cognitive burden also hurts the speed of
BPF development, as the verifier sits right in the middle of the user's
iteration loop while they make use of BPF to solve any given problem.
Expertise in debugging verifier errors does not scale in terms of teams
deploying these programs in production across a diverse set of kernels.

Overall, this leads to a poorer developer experience, causes visible
user dissatisfaction, and remains a drag on wider BPF adoption. With
some of the more recent developments where users increasingly leverage
AI tooling [0] to author their code, this bottleneck becomes even more
critical to address, since it throttles the much faster iteration loop
of AI agents.

  [0]: https://lwn.net/Articles/1075067

Approach
~~~~~~~~

This series starts moving selected failures from terse terminal messages
toward diagnostics that carry the relevant context for a verification
failure. The existing verbose log remains the low-level trace. The new
report is emitted after this trace with selected failures and answers
the immediate debugging questions:

  - what verifier rule failed,
  - why the current state does not satisfy it,
  - where the failing instruction maps to source,
  - which earlier branch or state event made this path fail,
  - what kind of source change would satisfy the verifier.

The series adds a text-only diagnostics framework under kernel/bpf and
uses it to augment selected verifier errors. Existing verbose(env, ...)
messages are kept, so current selftest expectations and existing log
consumers continue to see the legacy text. The new report has a uniform
outer shape:

  Verification failed: <category>: <problem>

  Reason:
    exact reason for the verification failure, with details

  At:
    source and instruction annotation

  Causal path:
    compressed branch and verifier-state events relevant for debugging

  Suggestion:
    speculation on potential fixes to repair the program

The outer shape is shared, but report construction is category-specific.

The categories are intentionally broad and reviewable. This revision
covers representative cases in Register Type Safety, Memory Safety,
Resource Lifetime Safety, Call Type Safety, Execution Context Safety,
Program Structure, Policy, Verifier Limit, and Verifier Internal errors.
It does not attempt to convert every verbose(env, ...) site for now.
Additional verbose-only errors can be moved into the same framework
incrementally.

The following excerpts are copied from this current run on this branch:

  ./test_progs -j1 \
    -a cpumask/test_populate_invalid_destination,\
    cpumask/test_alloc_no_release,\
    verifier_helper_value_access/via_variable_no_max_check_1,\
    verifier_sock/invalidate_pkt_pointers_from_global_func \
    -vv

They show the old terminal error and the exact new diagnostic report,
including the source/instruction annotation.

Call Type Safety, cpumask/test_populate_invalid_destination:

  Legacy:
    R1 type=scalar expected=fp

  Diagnostic:
    Verification failed: Call Type Safety: Invalid call argument

    Reason:
      The first argument (R1) to bpf_cpumask_populate does not satisfy the verifier contract: the kfunc expects 16 bytes of
      memory for 'struct cpumask', but it is an integer scalar and not verifier-known memory.

    At:
      test_populate_invalid_destination @ cpumask_failure.c:234:8
          232 | ...                                                                                   2 | (b7) r1 = 1193046
          233 | ...                                                                                   3 | (b7) r3 = 8
      >>> 234 |         ret = bpf_cpumask_populate((struct cpumask *)invalid, &bits, sizeof...   >>>  4 | (85) call bpf_cpumask_populate#61800
              |         ^-- error: invalid first argument (R1) for bpf_cpumask_populate
          235 |         if (!ret)                                                                     5 | (56) if w0 != 0x0 goto pc+4
          236 |                 err = 2;                                                              6 | (18) r1 = 0xffffc9000028e000

    Causal path:
      test_populate_invalid_destination @ cpumask_failure.c:234:8
          232 | ...                                                                                   0 | (bf) r2 = r10
          233 | ...                                                                                   1 | (07) r2 += -8
      >>> 234 |         ret = bpf_cpumask_populate((struct cpumask *)invalid, &bits, sizeof...   >>>  2 | (b7) r1 = 1193046
              |         ^-- update: R1 changed from context pointer at offset 0 to integer scalar value 1193046
          235 |         if (!ret)                                                                     3 | (b7) r3 = 8
          236 |                 err = 2;                                                              4 | (85) call bpf_cpumask_populate#61800

    Suggestion:
      Pass stack, map, context, or other verifier-known memory of the expected type and size, not an integer cast to a
      pointer.

Register Type Safety, verifier_sock/invalidate_pkt_pointers_from_global_func:

  Legacy:
    R7 invalid mem access 'scalar'

  Diagnostic:
    Verification failed: Register Type Safety: Invalid dereference

    Reason:
      R7 is an integer scalar here, not a pointer to memory.

    At:
      invalidate_pkt_pointers_from_global_func @ verifier_sock.c:1067:5
          1065 | ...                                                                                  8 | (85) call pc+4
          1066 |         skb_pull_data1(sk, 0);                                                       9 | (b4) w1 = 42
      >>> 1067 |         *p = 42; /* this is unsafe */                                           >>> 10 | (63) *(u32 *)(r7 +0) = r1
               |         ^-- error: invalid dereference of R7 (scalar)
          1068 | ...                                                                                 11 | (bc) w0 = w6
          1069 | }                                                                                   12 | (95) exit

    Causal path:
      invalidate_pkt_pointers_from_global_func @ verifier_sock.c:1066:2
          1064 |         if ((void *)(p + 1) > (void *)(long)sk->data_end)                            6 | (b4) w6 = 0
          1065 | ...                                                                                  7 | (b4) w2 = 0
      >>> 1066 |         skb_pull_data1(sk, 0);                                                  >>>  8 | (85) call pc+4
               |         ^-- invalidated: R7: packet data may have moved; previous value was pkt at offset 0
          1067 |         *p = 42; /* this is unsafe */                                                9 | (b4) w1 = 42
          1068 | ...                                                                                 10 | (63) *(u32 *)(r7 +0) = r1

    Suggestion:
      Preserve a pointer-valued register where needed, or reload and revalidate the pointer after scalar arithmetic, helper
      calls, or other operations that can invalidate it.

Memory Safety, verifier_helper_value_access/via_variable_no_max_check_1:

  Legacy:
    R1 unbounded memory access, make sure to bounds check any such access

  Diagnostic:
    Verification failed: Memory Safety: Access outside bounds

    Reason:
      The verifier cannot prove that this access stays within the object: The access needs offset + size <= 48, but R1 has
      no safe upper bound. R1 is map_value; offset is variable: known bits 0x0, unknown mask 0xffffffff, signed range [0,
      4294967295], unsigned range [0, 4294967295]; access size 1; object size 48.

    At:
      via_variable_no_max_check_1 @ verifier_helper_value_access.c:627:2
          625 | ...                                                                                  11 | (b7) r2 = 1
          626 | ...                                                                                  12 | (b7) r3 = 0
      >>> 627 |         asm volatile ("                                 \                        >>> 13 | (85) call bpf_probe_read_kernel#113
              |         ^-- error: access may be outside object bounds
          628 | ...                                                                                  14 | (95) exit
          629 | ...

    Causal path:
      via_variable_no_max_check_1 @ verifier_helper_value_access.c:627:2
          625 | ...                                                                                   8 | (bf) r1 = r0
          626 | ...                                                                                   9 | (61) r3 = *(u32 *)(r0 +0)
      >>> 627 |         asm volatile ("                                 \                        >>> 10 | (0f) r1 += r3
              |         ^-- update: R1 changed from map value from map_hash_48b at offset 0 to map value from map_hash_48b
              |             with variable offset: known bits 0x0, unknown mask 0xffffffff, signed range [0, 4294967295],
              |             unsigned range [0, 4294967295]
          628 | ...                                                                                  11 | (b7) r2 = 1
          629 | ...                                                                                  12 | (b7) r3 = 0

    Suggestion:
      Add or adjust a bounds check that proves offset + access size stays within the object.

Resource Lifetime Safety, cpumask/test_alloc_no_release:

  Legacy:
    Unreleased reference id=2 alloc_insn=0
    BPF_EXIT instruction in main prog would lead to reference leak

  Diagnostic:
    Verification failed: Resource Lifetime Safety: Unreleased resource

    Reason:
      Owned resource (id=2) was acquired at instruction 0 and still needs to be released before this exit path.

    At:
      test_alloc_no_release @ cpumask_failure.c:36:5
          34 | ...                                                                                   19 | (7b) *(u64 *)(r10 -8) = r6
          35 | ...                                                                                   20 | (b4) w0 = 0
      >>> 36 | int BPF_PROG(test_alloc_no_release, struct task_struct *task, u64 clone_flags)    >>> 21 | (95) exit
             | ^-- error: owned resource (id=2) still needs release
          37 | ...
          38 | ...

    Causal path:
      test_alloc_no_release @ cpumask_common.h:78:12
          76 | ...
          77 | ...
      >>> 78 |         cpumask = bpf_cpumask_create();                                           >>>  0 | (85) call bpf_cpumask_create#61791
             |         ^-- acquired: owned resource (id=2)
          79 |         if (!cpumask) {                                                                1 | (bf) r6 = r0
          80 |                 err = 1;                                                               2 | (55) if r6 != 0x0 goto pc+5
      test_alloc_no_release @ cpumask_common.h:79:6
          77 | ...                                                                                    0 | (85) call bpf_cpumask_create#61791
          78 |         cpumask = bpf_cpumask_create();                                                1 | (bf) r6 = r0
      >>> 79 |         if (!cpumask) {                                                           >>>  2 | (55) if r6 != 0x0 goto pc+5
             |         ^-- branch: explored as true, goto followed
          80 |                 err = 1;                                                               3 | (18) r1 = 0xffffc90000252000
          81 | ...
      test_alloc_no_release @ cpumask_common.h:84:6
          82 | ...                                                                                    9 | (85) call bpf_cpumask_empty#61792
          83 | ...                                                                                   10 | (54) w0 &= 1
      >>> 84 |         if (!bpf_cpumask_empty(cast(cpumask))) {                                  >>> 11 | (56) if w0 != 0x0 goto pc+7
             |         ^-- branch: explored as true, goto followed
          85 |                 err = 2;                                                              12 | (18) r1 = 0xffffc90000252000
          86 |                 bpf_cpumask_release(cpumask);

    Suggestion:
      Release or transfer ownership of the acquired resource on every path before the program exits.

Patch layout:

  - Patches 1-3 add the common infrastructure: report sections, diagnostic
    categories, source-line lookup, and side-by-side source/instruction
    annotations.
  - Patches 4-7 add bounded diagnostic history to verifier state. The
    history records branch outcomes, material register changes, reference
    lifetime events, and execution-context events so reports can explain
    the path and causal state transitions that led to the failure.
  - Patches 8-16 add the first category-specific reports. These patches
    hook selected verifier failure sites and choose the evidence that is
    useful for that error class.
  - Patch 17 gates diagnostic collection and rendering on verifier log
    level, so stats-only loads do not collect the extra path history.
    The overhead is limited to verbose log mode through this change.

Evaluation
~~~~~~~~~~

To quantitatively measure and goal on metrics that help assess the
quality of diagnostics (apart from subjective human feedback), we use AI
models (called over APIs) and veristat metrics to compare results.

Models are used as a way to measure repair utility of the extra
diagnostics over a fixed test set. Each prompt contains only a sanitized
source snippet and either the legacy verifier log or the new diagnostic
log. To avoid leaking the answer through the test itself, comments,
annotations, and other source hints that describe the intended failure
were removed. The model is not given internet access, repository access,
test execution, verifier access, or the expected fix. The expected
causes and intended repairs are kept outside the prompt. Under those
constraints, correctness, exact repair rate, output size, reasoning
tokens, cost, and wall time provide a proxy for whether the additional
verifier context makes the failure easier to understand and turn into a
source-level fix.

Verifier cost is assessed by forcing the collection of diagnostics
information during normal verification. This information by default is
supposed to only be collected and processed when logs are enabled, but
forcing it even without a verbose log levels helps us understand the
cost in CPU time and memory that is incurred due to this extra data.

Both evaluations are covered in the sections below.

Repair Quality
--------------

Repair quality is measured by asking API-only models to propose source
fixes from a sanitized source snippet and verifier log. The criterion is
score >= 3 on a 0-4 local grading scale, where 3 means a likely fix with
incomplete detail and 4 means an actionable source-level fix. Score 4 is
reported separately as the exact repair rate. The reported model set
contains 596 successful API responses: 298 diagnostic and 298 legacy.

Main results (details available in Appendix):

  Metric                              Diagnostic   Legacy       Delta
  ----------------------------------  -----------  -----------  --------
  Answers                             298          298
  Success rate                        97.0%        97.3%        -0.3 pp
  Exact repair rate                   82.2%        72.1%        +10.1 pp
  Mean score                          3.79         3.69         +0.10
  Solver cost                         $8.93        $10.37       -13.8%
  Mean output tokens per answer       1662         1975         -15.8%
  Mean reasoning tokens per answer    951          1080         -11.9%
  Mean wall time per answer           37.3s        44.1s        -15.4%

Diagnostic prompts carry more input context. The resulting answers are
still shorter and cheaper. In this run, diagnostics do not materially
change the coarse success rate, but they increase exact repairs by 10.1
percentage points while reducing cost, output tokens, reasoning tokens,
and wall time.

Verifier cost
-------------

Verifier cost is measured with veristat over the BPF selftest programs
selected by tools/testing/selftests/bpf/veristat.cfg, with five
repetitions per configuration. With diagnostics gated by log level, wall
time is within run noise of baseline. Forcing diagnostics on for every
verifier run is much more expensive in terms of CPU time, more than
doubling it.

  Configuration                 Wall time mean   Verifier duration    Max RSS mean
  ----------------------------  --------------   -----------------    ------------
  bpf-next baseline                 25.76s            9.41s              22135 KiB
  diagnostics, gated                25.78s           10.29s              21860 KiB
  diagnostics, forced on            58.54s           41.72s              21697 KiB

TODO
~~~~

Known follow-up work:

  - Use memory.peak in cgroup v2 for veristat memory cost.
  - Convert more verbose-only verifier errors into category-specific
    reports.
  - Integrate loop-convergence failure summarization from Eduard.
  - Report candidate kfuncs/helpers for releasing owned resources.
  - Explore association of source variables with verifier registers
    where debug info permits it.
  - Refine suggestions per category and, where useful, link diagnostics
    to maintained documentation.
  - Bring verifier warnings into the same reporting framework.

Appendix: AI repair details
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The 20 verifier-failing selftest cases are:

  Case     Diff    Category                    Selftest selector
  -------  ------  --------------------------  ---------------------------------------------
  case-001 easy    Call Type Safety            cpumask/test_populate_invalid_destination
  case-002 easy    Resource Lifetime Safety    cpumask/test_alloc_no_release
  case-003 easy    Register Type Safety        verifier_spill_fill/check_corrupted_spill_fill
  case-004 easy    Register Type Safety        test_global_funcs/global_func12
  case-005 easy    Execution Context Safety    preempt_lock/preempt_sleepable_helper
  case-006 easy    Policy                      verifier_helper_restricted/in_bpf_prog_type_kprobe_1
  case-007 medium  Memory Safety               dynptr/dynptr_slice_var_len1
  case-008 medium  Call Type Safety            dynptr/test_dynptr_skb_small_buff
  case-009 medium  Call Type Safety            task_kfunc/task_kfunc_acquire_untrusted
  case-010 medium  Register Type Safety        test_global_funcs/global_func6
  case-011 medium  Resource Lifetime Safety    dynptr/ringbuf_missing_release2
  case-012 medium  Execution Context Safety    irq/irq_sleepable_helper_global_subprog
  case-013 medium  Verifier Limit              test_global_funcs/global_func1
  case-014 hard    Memory Safety               verifier_helper_value_access/via_variable_no_max_check_1
  case-015 hard    Register Type Safety        verifier_sock/invalidate_pkt_pointers_from_global_func
  case-016 hard    Resource Lifetime Safety    verifier_ref_tracking/check_free_in_one_subbranch
  case-017 hard    Resource Lifetime Safety    irq/irq_restore_ooo
  case-018 hard    Resource Lifetime Safety    res_spin_lock_failure/res_spin_lock_ooo_unlock
  case-019 hard    Program Structure           verifier_loops1/bounded_recursion
  case-020 hard    Verifier Limit              verifier_liveness_exp/liveness_exponential_complexity

The grading scale is:

  - 4: identifies the verifier cause and gives an actionable source-level fix.
  - 3: gives a likely fix, but with incomplete explanation or detail.
  - 2: identifies part of the issue, but not enough to fix confidently.
  - 1: gives only a broad verifier-area answer, or a wrong/insufficient fix.
  - 0: does not identify the intended verifier failure.

Detailed effort metrics for the model set:

  Metric                   Variant      Mean      Median       P99
  -----------------------  ----------  --------  --------  --------
  Cost per answer          diagnostic   $0.030    $0.019    $0.203
  Cost per answer          legacy       $0.035    $0.018    $0.223
  Input tokens             diagnostic     1391      1220      4048
  Input tokens             legacy         1052       805      3655
  Output tokens            diagnostic     1662       954      8680
  Output tokens            legacy         1975      1034      9912
  Reasoning tokens         diagnostic      951       208      8108
  Reasoning tokens         legacy         1080       228      6322
  Wall time                diagnostic    37.3s     18.3s    222.7s
  Wall time                legacy        44.1s     19.8s    255.5s

Per-model results for diagnostic prompts:

  Model profile                              Ans  Succ   Exact  Mean  Cost     OutK  ReasK  Wall
  -----------------------------------------  ---  -----  -----  ----  -------  ----  -----  -----
  anthropic-haiku-4.5-default                 20   90.0   80.0  3.70  $0.087   11.4    0.0   5.0s
  anthropic-opus-4.8-high                     20  100.0   90.0  3.90  $0.819   25.5    0.0  15.5s
  anthropic-opus-4.8-medium                   20   95.0   90.0  3.85  $0.870   27.5    0.0  12.7s
  anthropic-sonnet-4.6-high                   20   95.0   80.0  3.75  $0.824   48.9    0.0  21.6s
  anthropic-sonnet-4.6-medium                 20  100.0   65.0  3.65  $0.278   12.4    0.0   6.6s
  openai-gpt-5.3-codex-high                   20  100.0   80.0  3.80  $0.601   39.8   33.9  25.0s
  openai-gpt-5.3-codex-medium                 20   95.0   85.0  3.80  $0.287   17.5   11.4  13.5s
  openai-gpt-5.5-high                         20  100.0   90.0  3.90  $2.356   74.4   65.2  56.8s
  openai-gpt-5.5-low                          20  100.0   90.0  3.90  $0.686   18.7    8.5  21.3s
  openai-gpt-5.5-medium                       19  100.0   84.2  3.84  $1.353   41.1   31.8  37.4s
  openai-gpt-5.5-none                         20   95.0   90.0  3.85  $0.457   11.1    0.0  10.4s
  openrouter-deepseek-r1-0528                 20  100.0   75.0  3.75  $0.145   61.5   53.8  98.3s
  openrouter-deepseek-v3.2                    19  100.0   78.9  3.79  $0.028   64.2   58.1  87.3s
  openrouter-glm-5.1-high                     20   95.0   80.0  3.75  $0.113   28.8   20.7  19.3s
  openrouter-qwen3-coder                      20   90.0   75.0  3.65  $0.028   12.4    0.0   7.1s

Per-model results for legacy prompts:

  Model profile                              Ans  Succ   Exact  Mean  Cost     OutK  ReasK  Wall
  -----------------------------------------  ---  -----  -----  ----  -------  ----  -----  -----
  anthropic-haiku-4.5-default                 20   90.0   45.0  3.35  $0.081   11.6    0.0   5.0s
  anthropic-opus-4.8-high                     20   90.0   70.0  3.60  $1.192   42.2    0.0  17.5s
  anthropic-opus-4.8-medium                   20   95.0   85.0  3.80  $1.001   34.5    0.0  13.4s
  anthropic-sonnet-4.6-high                   20  100.0   75.0  3.75  $1.181   74.1    0.0  24.4s
  anthropic-sonnet-4.6-medium                 20   95.0   65.0  3.60  $0.420   23.4    0.0  12.3s
  openai-gpt-5.3-codex-high                   20  100.0   85.0  3.85  $0.562   37.8   31.6  27.1s
  openai-gpt-5.3-codex-medium                 20  100.0   75.0  3.75  $0.318   20.3   13.7  13.6s
  openai-gpt-5.5-high                         19  100.0   78.9  3.79  $2.613   84.0   75.4  98.1s
  openai-gpt-5.5-low                          20  100.0   75.0  3.75  $0.664   19.0    9.7  21.7s
  openai-gpt-5.5-medium                       20  100.0   75.0  3.75  $1.602   50.2   41.0  56.1s
  openai-gpt-5.5-none                         20   95.0   85.0  3.80  $0.416   10.7    0.0  10.9s
  openrouter-deepseek-r1-0528                 20   95.0   70.0  3.65  $0.149   64.6   57.5  92.5s
  openrouter-deepseek-v3.2                    20  100.0   60.0  3.60  $0.030   74.3   67.8  98.3s
  openrouter-glm-5.1-high                     19  100.0   63.2  3.63  $0.115   32.1   24.9  30.4s
  openrouter-qwen3-coder                      20  100.0   75.0  3.75  $0.022    9.5    0.0   5.4s

Kumar Kartikeya Dwivedi (17):
  bpf: Add verifier diagnostics report helpers
  bpf: Define verifier diagnostic categories
  bpf: Add source and instruction diagnostic context
  bpf: Track verifier branch diagnostic history
  bpf: Track verifier register diagnostic history
  bpf: Track verifier reference diagnostic history
  bpf: Track verifier context diagnostic history
  bpf: Report Register Type Safety errors
  bpf: Report Memory Safety bounds errors
  bpf: Report Resource Lifetime reference leaks
  bpf: Report Call Type Safety argument errors
  bpf: Report Execution Context Safety errors
  bpf: Report Program Structure CFG errors
  bpf: Report Policy helper and kfunc errors
  bpf: Report Verifier Limit errors
  bpf: Report Verifier Internal errors
  bpf: Gate verifier diagnostics on log level

 include/linux/bpf_verifier.h |    6 +
 kernel/bpf/Makefile          |    2 +-
 kernel/bpf/diagnostics.c     | 1936 ++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.h     |  245 +++++
 kernel/bpf/liveness.c        |    6 +
 kernel/bpf/verifier.c        | 1053 +++++++++++++++++-
 6 files changed, 3217 insertions(+), 31 deletions(-)
 create mode 100644 kernel/bpf/diagnostics.c
 create mode 100644 kernel/bpf/diagnostics.h


base-commit: bf29346fc39355cc57118e4e825109f66ac3542d
-- 
2.53.0

