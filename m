Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7F3B42EB
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776392; cv=none; b=XO/vuuVINhpRzFZw75aMxiX8qH+rTrjuqv0dnxDLwp/4P2zq99+gPogOWy6ivJbZ9Bjx0F8CAcIY/WfRpBg7108aXYGmaoFLrZgEqWJg+Nb06BQDGQpxYkEESIs1qIp1zQx5DZ3lDOnhxxmlpQSH7S5zVV8UZ6tDnxEbS+5M194=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776392; c=relaxed/simple;
	bh=bhOFCoNt1FcyE8CRTp142uTy6DPXeAJz19LfMwhZokw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WCT95Z4R0vssSnjLlLEQiCtmywshsTcVzJcoacpyr3XIC2aoab5n1bbV9mE1D7sc52wcYjBXfWqrCDAVOG2LymN9qntNPDj7E1Co1XuOA6sjDycru+KuUvAGW7jczqvv44AcFtwNoBGEQuSZh78mbZafStb/JS+JeOmnHpboNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMxNVYX6; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMxNVYX6"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-498074920dcso6979255e9.1
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776375; x=1787381175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aebO+Nzzkyg+02vZWxzxhIVsYNPCh9QQ4stJxFqg4DU=;
        b=iMxNVYX64z295yXNazJDRoFYJ1kvUSlO0buuKRgkGC7zzQjJMq1JYRZ5yKV1CR4Luv
         1F6MGQOOnbosX07x41xnndDmm5cd4CKlCXXLrRP+yJ77m8XjuRhHponYZLJBbwS9xub9
         xrXT47/SRFxWdlBY83LdvKYUwbarqeUTMenbMxYrhdz1vdw3SXXFxrSngpgAGbaJqqs1
         lo+t5FlK0gTzOfY741I6cevhwRUDFDpNsHKfh3+QZWGQlqP+nFukDIqYEXEpWR5yHCM2
         0MIiaT9QQAVOu3n4fOtsYpZTTt0PlYnLuPWDsViOwgTTeaVifKWBHCMayQ1xxv6dBhys
         YWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776375; x=1787381175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aebO+Nzzkyg+02vZWxzxhIVsYNPCh9QQ4stJxFqg4DU=;
        b=R6o+CsaOJEBx6miqJ2KJr4UAsF+3DbTvc7mvPPO2bPIFfDXY+48Unv3kbsbKk9ylSi
         S0/MOStkFvvUuZh0HOYjRpjrmpNnk0XitH0rGvpJkIEaqRKWcgv2KnoLWAk73Nus9NFk
         MGvDqM+9g4TNjn091IgN4FPbTC8ygheRcEnDJREgQieX/eA97P/21Hc7eZVF/CnpWgEh
         UFXOlQJH66lI5LNeH9FMKb+BHRz7lJ8x3z0EX9qgIj3z1OecHCDODMPk78bZbi36dzYa
         Y8kz+wcnis4RJSt84la1irdhtOUkypBVTL+7vkh1MSJmSFf26ico9YlAhma8A5rhY8ou
         qu7Q==
X-Gm-Message-State: AOJu0Yw3SlPdII835g2DowwWD1z19stV+6VCBgW8TcFrINWAHwJL01Nk
	1AQwoGnr4vC3oytEq2EKVcCvk2J0fMf7JSsnaOYpJxR8Ay7HqaCIIEHWOWijVt3t
X-Gm-Gg: AR+sD10MjPlidBs6s1WA0fQCDsR0uB0p6hQf+nqmN64sB8VaO8CYQs3kLI84lFnJFto
	ICFACo+JToI6v5W124S850YB8qwyZlNicrHy23LVOqBwb8w6K+x3JzPMTYTtKcAD+uJNvLGS/DN
	GPcY8YR1ch47RdrQRLRzA8pkOb1bvdeMz3ttHmkdCZ/qQahBcfQAXaXGvyeBmT9h9o8PkLKXWXY
	Gfi3Pzg9QEAFbGT97Zktls/vJ/zLm4Zotg7Gq9d0ogwlr1sNDZWkTvGblBZLzKb34MJArPabsB1
	xUcwGyM9cpoFMSBr249P3TAiKUcckqJVDmIlv6b6jE640VdIC+h052f5xQkA5NIc0sTYoy5nBJM
	4St+H+dW+hgAMuDQZYt2vhk1lIhhpJuSbaCcDr4LkdXjcp6Xsc5+mDWowumq+JCd+2XI4qPLcNV
	dx0e8KK7OQncD76X+D3q9BA7leBaza8WPjq4bAnJKu391Dl6ik4gAYQuNDdptjvvEywfH284WG1
	weHtEBWxayFPPoI4uEAvesS/+RsR7Y3Ovwhpouz5lb6EefVB/UEPhwjy/kjwg+RWrsaUIdJjyou
	6E6JtmlMjoVXZ8Y1pXXNxryRIB9v
X-Received: by 2002:a05:600c:500d:b0:499:86f5:9e33 with SMTP id 5b1f17b1804b1-499879bc10emr160715705e9.18.1786776374186;
        Fri, 14 Aug 2026 23:46:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988adfb67sm119646325e9.3.2026.08.14.23.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 00/14] Redesign Verification Errors
Date: Sat, 15 Aug 2026 08:45:55 +0200
Message-ID: <20260815064612.378577-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=35026; i=memxor@gmail.com; h=from:subject; bh=bhOFCoNt1FcyE8CRTp142uTy6DPXeAJz19LfMwhZokw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy23m8hbppSwrYlmOLL1ezyNQaLLmhZOyy2+/zrqH5 qfDu307SlkYxLgYZMUUWUr+72MyPlH5O9B2GTfMHFYmkCEMXJwCMJG7Fgz/NF5tfiJm82H+Qs6M /LebAs1rPYW1PWqcLn2a8UdIdl79CkaGR3uaelOE1r+sfMn5OeqQ3qvnqhm9/VYqVuWOQWt/7tj BCgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

TL;DR: This set reworks verifier error messages to include source and
instruction annotations, together with more causal context, making
failures easier to understand and more actionable when debugging and
repairing BPF programs.

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20260812233326.3575958-1-memxor@gmail.com

 * Defer Verifier Limit reports and the dependent call-chain allocation
   guards to follow-up work, reducing the series from 16 to 14 patches.
   (Eduard)
 * Make kfunc-name disassembly read-only before module-kfunc metadata is
   resolved, retain instruction context without usable source metadata,
   consolidate its fallback, and restrict source discovery to the containing
   subprogram. (Eduard, Sashiko)
 * Retain the newest diagnostic history in a bounded 64 MiB rotating buffer,
   use absolute logical positions across verifier path switches, report
   evicted shared history, and grow storage geometrically. (Eduard)
 * Complete active-path history for BPF_LD_IMM64 and atomic fetches, call
   clobbers and returns, outgoing stack arguments, legacy packet loads, and
   RCU pointer transitions. (Eduard, Sashiko)
 * Preserve causal lineage across equal snapshots, nullable pointer-cast
   branches, and repeated same-depth function invocations using unique
   diagnostic frame identities. Bound each rendered causal path to the oldest
   and newest 32 matching events with an omission summary. (Eduard)
 * Harden diagnostics for malformed release-kfunc signatures, fixed-size
   argument ranges, and dynptr, iterator, memory-size, and required-RCU
   failures by reporting the actual offending type or invariant. (Eduard,
   Sashiko)
 * Remove unrelated formatting and cross-patch churn, dead or single-use
   helpers and filter paths, and align helper placement, includes, and commit
   descriptions with the patches that first need them. (Eduard)

v3 -> v4
v3: https://lore.kernel.org/bpf/20260713153910.2556007-1-memxor@gmail.com

 * Introduce helpers with their first callers and add printf annotations.
   (Eduard, Sashiko)
 * Remove "report" from diagnostic function names. (Sashiko)
 * Reuse bpf_linfo_source and seq_buf, simplify internal names, and use shared
   formatting storage. (Eduard)
 * Use compact common event fields and record branches at successor entry.
   (Eduard)
 * Bound event storage at 1 MiB, use kvrealloc(), and drop events non-fatally.
   (Eduard, Sashiko)
 * Restore diagnostic history only for activated queued states, preserving the
   active failure trace during cleanup. (Eduard, Sashiko)
 * Record register changes through begin/end and scrub helpers, deriving targets
   and origins without caller-saved snapshots. (Eduard)
 * Store lineage marks on events and rewind shared formatting storage after
   rendering each event. (Eduard)
 * Record iterator return values before snapshotting alternate paths. (Sashiko)
 * Use the current verifier instruction for global-subprogram dynptr errors.
   (Sashiko)
 * Use the supplied call name for nullable global-subprogram arguments.
   (Sashiko)
 * Describe global calls under locks as a verifier restriction rather than a
   sleepability failure. (Sashiko)
 * Keep diagnostic strings unsplit and put long call openings on their own
   line. (Eduard)
 * Keep kfunc metadata zeroed before early fetch and allowability failures.
   (Sashiko)
 * Drop the Verifier Internal Error report patch. (Eduard)
 * Distinguish never-initialized registers from invalidated registers.
   (local review)
 * Preserve the legacy different-lock verifier message. (local review)
 * Preserve nullable type qualifiers and stable mismatch formatting.
   (local review)
 * Mark truncated call chains with an ellipsis. (local review)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260619205934.1312876-1-memxor@gmail.com

 * Address various comments from Eduard and Sashiko.
 * Move instruction context from a separate gutter into a new section
   following source context, since surrounding source lines and BPF
   instructions do not map one-to-one.
 * Fix active-path branch reconstruction when switching to queued states,
   and expand register histories to follow value lineage across spills,
   fills, stack reads, helper/kfunc clobbers, and dynptr invalidation.
 * Misc improvements and refinements.

v1 -> v2
v1: https://lore.kernel.org/bpf/20260605063412.974640-1-memxor@gmail.com

 * Reworked diagnostic history from per-verifier-state log to active
   path log with positions saved and reset when verifier search
   backtracks. (Eduard)
 * Moved reusable diagnostic formatting storage into struct bpf_diag
   under struct bpf_verifier_env, and removed large per-report scratch
   buffers from verifier stack frames. (Eduard)
 * Added stack-slot events so diagnostics follow ordinary stack
   spill/fill value flow and invalidations in register-scoped
   histories. (Eduard)
 * Reused existing source and BTF formatting helpers for diagnostics,
   including bpf_get_linfo_file_line() and
   btf_type_snprintf_show_name(). (Eduard)
 * Fixed diagnostic edge cases around signed offset text,
   BPF_MAX_VAR_OFF reporting, negative-offset clamping, poisoned
   stack reads, and borrowed-reference invalidations. (Eduard)
 * Fixed various miscellaneous diagnostic bugs. (Sashiko)
 * Misc improvements and refinements.

--

Motivation
~~~~~~~~~~

The verifier log is the primary interface through which the verifier
communicates to the user its verdict on whether a program was accepted
or rejected.

To aid the debugging of rejection decisions, the verifier also reports
the symbolic state of the program at each instruction, across every explored
path of the BPF program. Such detailed information is critical to
introspect the correctness of verification decisions, and provide
insight into why a given program may have failed to load in the kernel.

A constant pain point in the BPF ecosystem throughout the years has
been the difficulty of debugging verification errors. The human-readable error
messages produced in response to a failure in satisfying safety-related
constraints are often terse, context-dependent, or insufficient for
understanding why a given error may have happened. Users must fall back
to the verbose instruction-by-instruction breakdown of how the symbolic
state evolved to surface the root cause. For programs with a huge log
volume due to high verification complexity, such logs quickly become
inscrutable.

All of this has made life difficult for users lacking an understanding
of how the verifier works, and the various heuristics and idiosyncrasies
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
failure. The existing verbose log remains the low-level trace. For selected
failures, the new report is emitted after this trace and answers the
immediate debugging questions:

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
Program Structure and Policy.
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
including the source and instruction annotations.

Call Type Safety, cpumask/test_populate_invalid_destination:

  Legacy:
    R1 type=scalar expected=fp

  Diagnostic:
    Verification failed: Call Type Safety: Invalid call argument

    Reason:
      The first argument (R1) to bpf_cpumask_populate does not satisfy the verifier contract: the kfunc
      expects 24 bytes of memory for (struct bpf_cpumask), but it is an integer scalar and not
      verifier-known memory.

    At:
      test_populate_invalid_destination @ cpumask_failure.c:234:8
      Source context:
          232 | ...
          233 | ...
      >>> 234 |         ret = bpf_cpumask_populate(invalid, &bits, sizeof(bits));
              |         ^-- error: invalid first argument (R1) for bpf_cpumask_populate
          235 |         if (!ret)
          236 |                 err = 2;
      Instruction context:
           2 | (b7) r1 = 1193046
           3 | (b7) r3 = 8
      >>>  4 | (85) call bpf_cpumask_populate#62860
           5 | (56) if w0 != 0x0 goto pc+4
           6 | (18) r1 = 0xffffc9000028e000

    Causal path:
      test_populate_invalid_destination @ cpumask_failure.c:234:8
      Source context:
          232 | ...
          233 | ...
      >>> 234 |         ret = bpf_cpumask_populate(invalid, &bits, sizeof(bits));
              |         ^-- update: R1 changed from context pointer at offset 0 to integer scalar value
              |             1193046
          235 |         if (!ret)
          236 |                 err = 2;
      Instruction context:
           0 | (bf) r2 = r10
           1 | (07) r2 += -8
      >>>  2 | (b7) r1 = 1193046
           3 | (b7) r3 = 8
           4 | (85) call bpf_cpumask_populate#62860

    Suggestion:
      Pass stack, map, context, or other verifier-known memory of the expected type and size, not an
      integer cast to a pointer.

Register Type Safety, verifier_sock/invalidate_pkt_pointers_from_global_func:

  Legacy:
    R7 invalid mem access 'scalar'

  Diagnostic:
    Verification failed: Register Type Safety: Invalid dereference

    Reason:
      R7 is an integer scalar here, not a pointer to memory.

    At:
      invalidate_pkt_pointers_from_global_func @ verifier_sock.c:1067:5
      Source context:
          1065 | ...
          1066 |         skb_pull_data1(sk, 0);
      >>> 1067 |         *p = 42; /* this is unsafe */
               |         ^-- error: invalid dereference of R7 (an integer scalar)
          1068 | ...
          1069 | }
      Instruction context:
           8 | (85) call pc+4
           9 | (b4) w1 = 42
      >>> 10 | (63) *(u32 *)(r7 +0) = r1
          11 | (bc) w0 = w6
          12 | (95) exit

    Causal path:
      invalidate_pkt_pointers_from_global_func @ verifier_sock.c:1062:29
      Source context:
          1060 | int invalidate_pkt_pointers_from_global_func(struct __sk_buff *sk)
          1061 | ...
      >>> 1062 |         int *p = (void *)(long)sk->data;
               |         ^-- update: R7 changed from uninitialized value to pkt at offset 0
          1063 | ...
          1064 |         if ((void *)(p + 1) > (void *)(long)sk->data_end)
      Instruction context:
           0 | (b4) w6 = 2
           1 | (61) r2 = *(u32 *)(r1 +80)
      >>>  2 | (61) r7 = *(u32 *)(r1 +76)
           3 | (bf) r3 = r7
           4 | (07) r3 += 4

      invalidate_pkt_pointers_from_global_func @ verifier_sock.c:1064:22
      Source context:
          1062 |         int *p = (void *)(long)sk->data;
          1063 | ...
      >>> 1064 |         if ((void *)(p + 1) > (void *)(long)sk->data_end)
               |         ^-- branch: took the false branch of this conditional, goto not followed
          1065 | ...
          1066 |         skb_pull_data1(sk, 0);
      Instruction context:
           3 | (bf) r3 = r7
           4 | (07) r3 += 4
      >>>  5 | (2d) if r3 > r2 goto pc+5
           6 | (b4) w6 = 0
           7 | (b4) w2 = 0

      invalidate_pkt_pointers_from_global_func @ verifier_sock.c:1066:2
      Source context:
          1064 |         if ((void *)(p + 1) > (void *)(long)sk->data_end)
          1065 | ...
      >>> 1066 |         skb_pull_data1(sk, 0);
               |         ^-- invalidated: R7: packet data may have moved; previous value was pkt at
               |             offset 0
          1067 |         *p = 42; /* this is unsafe */
          1068 | ...
      Instruction context:
           6 | (b4) w6 = 0
           7 | (b4) w2 = 0
      >>>  8 | (85) call pc+4
           9 | (b4) w1 = 42
          10 | (63) *(u32 *)(r7 +0) = r1

    Suggestion:
      Preserve a pointer-valued register where needed, or reload and revalidate the pointer after scalar
      arithmetic, helper calls, or other operations that can invalidate it.

Memory Safety, verifier_helper_value_access/via_variable_no_max_check_1:

  Legacy:
    R1 unbounded memory access, make sure to bounds check any such access

  Diagnostic:
    Verification failed: Memory Safety: Access outside bounds

    Reason:
      The verifier cannot prove offset + access_size <= object_size. Here, the maximal bound for a
      memory access is 4294967295 and exceeds maximum allowed offset of 536870912. R1 is map_value;
      offset is variable: known bits 0x0, unknown mask 0xffffffff; signed range [0, 4294967295],
      unsigned range [0, 4294967295]; access_size is 1; object_size is 48.

    At:
      via_variable_no_max_check_1 @ verifier_helper_value_access.c:627:2
      Source context:
          625 | ...
          626 | ...
      >>> 627 |         asm volatile ("                                 \
              |         ^-- error: access may be outside object bounds
          628 | ...
          629 | ...
      Instruction context:
          11 | (b7) r2 = 1
          12 | (b7) r3 = 0
      >>> 13 | (85) call bpf_probe_read_kernel#113
          14 | (95) exit

    Causal path:
      via_variable_no_max_check_1 @ verifier_helper_value_access.c:627:2
      Source context:
          625 | ...
          626 | ...
      >>> 627 |         asm volatile ("                                 \
              |         ^-- update: R0 changed from uninitialized value to nullable map value from
              |             map_hash_48b at offset 0
          628 | ...
          629 | ...
      Instruction context:
           4 | (18) r1 = 0xffff88810a3ea000
      >>>  6 | (85) call bpf_map_lookup_elem#1
           7 | (15) if r0 == 0x0 goto pc+6
           8 | (bf) r1 = r0

      via_variable_no_max_check_1 @ verifier_helper_value_access.c:627:2
      Source context:
          625 | ...
          626 | ...
      >>> 627 |         asm volatile ("                                 \
              |         ^-- branch: took the false branch of this conditional, goto not followed
          628 | ...
          629 | ...
      Instruction context:
           6 | (85) call bpf_map_lookup_elem#1
      >>>  7 | (15) if r0 == 0x0 goto pc+6
           8 | (bf) r1 = r0
           9 | (61) r3 = *(u32 *)(r0 +0)

      via_variable_no_max_check_1 @ verifier_helper_value_access.c:627:2
      Source context:
          625 | ...
          626 | ...
      >>> 627 |         asm volatile ("                                 \
              |         ^-- update: R1 changed from uninitialized value to map value from map_hash_48b
              |             at offset 0
          628 | ...
          629 | ...
      Instruction context:
           6 | (85) call bpf_map_lookup_elem#1
           7 | (15) if r0 == 0x0 goto pc+6
      >>>  8 | (bf) r1 = r0
           9 | (61) r3 = *(u32 *)(r0 +0)
          10 | (0f) r1 += r3

      via_variable_no_max_check_1 @ verifier_helper_value_access.c:627:2
      Source context:
          625 | ...
          626 | ...
      >>> 627 |         asm volatile ("                                 \
              |         ^-- update: R1 changed from map value from map_hash_48b at offset 0 to map value
              |             from map_hash_48b with variable offset: known bits 0x0, unknown mask
              |             0xffffffff, signed range [0, 4294967295], unsigned range [0, 4294967295]
          628 | ...
          629 | ...
      Instruction context:
           8 | (bf) r1 = r0
           9 | (61) r3 = *(u32 *)(r0 +0)
      >>> 10 | (0f) r1 += r3
          11 | (b7) r2 = 1
          12 | (b7) r3 = 0

    Suggestion:
      Add or adjust a bounds check that proves offset + access_size stays within the object.

Resource Lifetime Safety, cpumask/test_alloc_no_release:

  Legacy:
    Unreleased reference id=2 alloc_insn=0
    BPF_EXIT instruction in main prog would lead to reference leak

  Diagnostic:
    Verification failed: Resource Lifetime Safety: Unreleased resource

    Reason:
      Owned resource (id=2) was acquired at instruction 0 and still needs to be released before this
      exit path.

    At:
      test_alloc_no_release @ cpumask_failure.c:36:5
      Source context:
          34 | ...
          35 | ...
      >>> 36 | int BPF_PROG(test_alloc_no_release, struct task_struct *task, u64 clone_flags)
             | ^-- error: owned resource (id=2) still needs release
          37 | ...
          38 | ...
      Instruction context:
          19 | (7b) *(u64 *)(r10 -8) = r6
          20 | (b4) w0 = 0
      >>> 21 | (95) exit

    Causal path:
      test_alloc_no_release @ cpumask_common.h:78:12
      Source context:
          76 | ...
          77 | ...
      >>> 78 |         cpumask = bpf_cpumask_create();
             |         ^-- acquired: owned resource (id=2)
          79 |         if (!cpumask) {
          80 |                 err = 1;
      Instruction context:
      >>>  0 | (85) call bpf_cpumask_create#62851
           1 | (bf) r6 = r0
           2 | (55) if r6 != 0x0 goto pc+5

      test_alloc_no_release @ cpumask_common.h:79:6
      Source context:
          77 | ...
          78 |         cpumask = bpf_cpumask_create();
      >>> 79 |         if (!cpumask) {
             |         ^-- branch: took the true branch of this conditional, goto followed
          80 |                 err = 1;
          81 | ...
      Instruction context:
           0 | (85) call bpf_cpumask_create#62851
           1 | (bf) r6 = r0
      >>>  2 | (55) if r6 != 0x0 goto pc+5
           3 | (18) r1 = 0xffffc90000252000

      test_alloc_no_release @ cpumask_common.h:84:6
      Source context:
          82 | ...
          83 | ...
      >>> 84 |         if (!bpf_cpumask_empty(cast(cpumask))) {
             |         ^-- branch: took the true branch of this conditional, goto followed
          85 |                 err = 2;
          86 |                 bpf_cpumask_release(cpumask);
      Instruction context:
           9 | (85) call bpf_cpumask_empty#62852
          10 | (54) w0 &= 1
      >>> 11 | (56) if w0 != 0x0 goto pc+7
          12 | (18) r1 = 0xffffc90000252000

    Suggestion:
      Release or transfer ownership of the acquired resource on every path before the program exits.

Patch layout:

  - Patches 1-2 add the initial renderer, source-line lookup, and separate
    source and instruction context blocks. Reusable report sections arrive with their first
    category-specific consumers.
  - Patches 3-7 add bounded, growable environment-owned diagnostic
    history. It grows to 64 MiB and then retains the newest events in a
    rotating buffer. The history follows the active verifier path and is
    pruned when backtracking; it records branch outcomes, material register
    changes, reference lifetime events, and execution-context events so
    reports can explain the path and causal state transitions that led to
    the failure.
  - Patches 8-14 add the first category-specific reports. These patches
    hook selected verifier failure sites and choose the evidence that is
    useful for that error class.

Evaluation
~~~~~~~~~~

The evaluation below is retained from v4 while v5 changes are in progress.
It includes two Verifier Limit cases removed from v5 and must be refreshed
before posting.

To quantitatively assess diagnostic quality beyond subjective human
feedback, we use AI models (called over APIs) and veristat metrics to
compare results.

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
information during normal verification. By default, this information is
collected and processed only when verbose logs are enabled, but forcing
it even without a verbose log helps us measure the CPU time and memory
cost of the extra data.

Both evaluations are covered in the sections below.

Repair Quality
--------------

Repair quality is measured by asking API-only models to propose source
fixes from a sanitized source snippet and verifier log. The criterion is
score >= 3 on a 0-4 local grading scale, where 3 means a likely fix with
incomplete detail and 4 means an actionable source-level fix. Score 4 is
reported separately as the exact repair rate. The reported model set
contains 596 completed API responses: 298 diagnostic and 298 legacy.

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
time and verifier duration stay close to baseline. Forcing diagnostics
on for every verifier run adds modest overhead on this workload.

memory.peak is measured with cgroup v2 memory accounting for each
program load. The table reports the mean wall time, the mean summed
verifier duration, and the mean of the per-repetition maximum
memory.peak values.

  Configuration                 Wall time mean   Verifier duration    memory.peak
  ----------------------------  --------------   -----------------    -----------
  bpf-next baseline                 25.78s            9.86s              142 MiB
  diagnostics, gated                26.64s           10.16s              144 MiB
  diagnostics, forced on            28.01s           11.00s              148 MiB

TODO
~~~~

Known follow-up work:

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

Kumar Kartikeya Dwivedi (14):
  bpf: Add verifier diagnostics report helpers
  bpf: Add source and instruction diagnostic context
  bpf: Add verifier diagnostic event log
  bpf: Prune verifier diagnostics when switching paths
  bpf: Track verifier register diagnostic events
  bpf: Track verifier reference diagnostic events
  bpf: Track verifier context diagnostic events
  bpf: Report Register Type Safety errors
  bpf: Report Memory Safety bounds errors
  bpf: Report Resource Lifetime reference leaks
  bpf: Report Call Type Safety argument errors
  bpf: Report Execution Context Safety errors
  bpf: Report Program Structure CFG errors
  bpf: Report Policy helper and kfunc errors

 include/linux/bpf.h                           |   12 +-
 include/linux/bpf_verifier.h                  |   21 +
 include/linux/btf.h                           |    1 +
 kernel/bpf/Makefile                           |    2 +-
 kernel/bpf/btf.c                              |   10 +
 kernel/bpf/cfg.c                              |   35 +
 kernel/bpf/core.c                             |   35 +-
 kernel/bpf/diagnostics.c                      | 2355 +++++++++++++++++
 kernel/bpf/diagnostics.h                      |  111 +
 kernel/bpf/log.c                              |   11 -
 kernel/bpf/verifier.c                         | 1065 +++++++-
 .../selftests/bpf/progs/verifier_map_in_map.c |    1 +
 .../selftests/bpf/progs/verifier_uninit.c     |    1 +
 13 files changed, 3509 insertions(+), 151 deletions(-)
 create mode 100644 kernel/bpf/diagnostics.c
 create mode 100644 kernel/bpf/diagnostics.h


base-commit: f5b57e9e9cfd9736246eb9a5f385da451d199039
-- 
2.53.0

