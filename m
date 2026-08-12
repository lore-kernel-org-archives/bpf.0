Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECB218592
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573170; cv=none; b=IfHA+3jzO6BiuMURCSDD/yQPchh32TrcoWqcpRvp++PPFktt6dDXRaWRH0tzcjHpnuCfn+a0NqBL6G94tOFFRHF4t3cUKNP0llYRRW7SuNLzsp4dMD3GIWB2aEL0vZqhFAr9fjm5qzqFTRqnenbAOIjPoWKcJpuF2CU29kBYNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573170; c=relaxed/simple;
	bh=3A+UKkYWs8Ce10MvKM+UKVIWHcvmRGFfQ6u/gtma3eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCufQ88G/W567+sPEQApBCW/HdX66UsMzez/yfnX/9Zj0ftSbN6GlQOFAltNMNd0+0/D0SZwTHBpNd9kS/NvKBRCOAT88LW5I8m2xwxwiVJ9dKQEG3fEtRPLFcknmIojEPJ9WxBuqJFPHQ3EkdyTAlTy5/ewrJmu8Kmkv9QHNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s35YmEQz; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s35YmEQz"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495482c36b8so4997655e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573166; x=1787177966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aOCw8GUl6IhpMCGBKyhDSVTexkFQ7QqY1fU043hgv74=;
        b=s35YmEQzv1MCfnyVaLdzYBHnlmTBGlXqIjnBV7sjWLbtZQZ9AUv3Ko44gj4Klc6GqB
         JewI01v5/OhA0WqEOxdp/MDVoTBupwTEe99/rgD/QTWyqBrjlNRYTc/m1AuVJrvnKU/P
         7gFWXNMdzcVVYhrLtTauC+1w1SUxjQvU3TsozQ1NyTzMzl8f7oSr1l+6zJA8IDJ1w+sZ
         qHR8WG9ioonsyu9/iPLuUIWMWcDes/Nfm76lUHjwr2pHiRTMiwvpgE/BkZE/ZtinDLh+
         zvRJMDDxikdmyxpdtrn5DlxqUw7avzRDTCB5ShgwuIx8TfPkYxqeTdDKYzHCkFiKgblp
         dx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573166; x=1787177966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aOCw8GUl6IhpMCGBKyhDSVTexkFQ7QqY1fU043hgv74=;
        b=GylNqYHieDRKrlBcawbivG/VU+z+Bugi1l06oI7bDjqDVpWbOP8N3ufbto/J0aKwUU
         GK3zGEaPbqN/QbxGTvf8Lam/VZiiirtl2SWqspXYI3wDzTJBIZ87PccNgrbXg8c0m4q2
         QigW9jF/BOIDrZbilERZK0mL4E1PjAPnAcBDIrycEOgTIYcVJP7W4ryJKzApEaR5qcsi
         JwT2SWYXAli56dua3KocbdMPRAHWv61LqTPOaaGbONSl/NyJspuMT+HLrQuqy78SuTaf
         XJ3zGulqxy7rlWs8QQCv/bWKNvCgbnycuhFIYQNe2Vvq3ASSeO/BNdKYDz4UEmgBbJ+H
         Fb7A==
X-Gm-Message-State: AOJu0YyYrvdL+r1Be2qJWoy9vFVCZs5vxj1vKsshp1jXEMPzQW7v2n4p
	cUtZvCME9BiSyfyIPK/Trci6MpxW0wXQxd8bcW8Ej5QB7+TQtgW6l8E5TRdxucTz
X-Gm-Gg: AR+sD13Wfb/0vTC5Mi8LjXsryvrjtziEUyNBmiCgrfHWlQ53/9u+Dd8XwyfJX7Myrk5
	SywcdjYrq3S5+8c5KGW5vt/aJJPV1rpE7/PV82ozuJHIja+kVWHDN6fY2PjWWfSXgybIWgKqoVC
	jq3Qw82UdN6Ilt3Po48J6cYoYLbl+1VJntOpAjsDwZvtXtcKaz6o53cd0U8vNnUmKhOwHKi5W6S
	RQqH7Wm17AgFDZxYPV1epdVcAy5O7vBdwyzAyQ5XkEeEiqWI+Q9zTIFjR05CE2LsYMN7TxWc6MN
	LGQlJGlyrgQQh6ACLEskAzXuL566nWcz9MPwyqGgxvYfZzlVPd9UKf+o8PG88nFevp5pkxxhfMP
	MZdleCWZwceGxq1pmLf9pBiT9kBhR/8tcKZHES6qAAJR2YjPeIxIcBvyEYhxio5jH/6durZgjCk
	XgEy9UWdw7KiyZOhyihRfn0HLLn/8FcuWii5jj0zhm5Tmzi799cAjm4buhXi4Lyg4dtu7ZOKB9G
	OGyVrqcCnOmpa7tNSWjTyaYLhGkZh9lfsPVk/2drCD0dMGX3BG0TkSkWyFAi4IspleHZnU+EQbg
	AP2Wfukb2K4DS9wcswU+UjR8y30=
X-Received: by 2002:a05:600c:45d4:b0:499:4dca:aa4 with SMTP id 5b1f17b1804b1-4998219b782mr8850475e9.4.1786573166204;
        Wed, 12 Aug 2026 15:19:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b58700sm14653465e9.9.2026.08.12.15.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 15:19:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v8 0/6] Improve stack depth verification stats output
Date: Thu, 13 Aug 2026 00:19:17 +0200
Message-ID: <20260812221925.3358041-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6260; i=memxor@gmail.com; h=from:subject; bh=3A+UKkYWs8Ce10MvKM+UKVIWHcvmRGFfQ6u/gtma3eQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavmww9WFU+FH7vmB02b6TEzcd0EbdM82exTudOUT7edn Rhz58b9jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzEtIzhf9Xtwkn+vnKH2M7E Ppa+2nLxSsLtorhODyGHmTtsLQxK3jD8L1LTzFwqcmuX3+fMENFDG3tNZ7yclj7Tdvd77uVOnG8 eswEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some improvements for more clarity in the stack depth verification
statistics output. See commit logs for details.

For example, ./test_progs -t subprogs/subprogs_alone loads prog4,
which has a main program, two static subprograms, and two independently
verified global subprograms. A sample run produces:

  verification time 1765 usec
  stack depth max 48
  subprog 0 (prog4) main insns_self 29 insns_total 51 stack 8
  subprog 1 (get_task_tgid) global insns_self 9 insns_total 9 stack 8
  subprog 2 (sub4) static insns_self 15 insns_total 22 stack 8
  subprog 3 (sub3) static insns_self 7 insns_total 7 stack 0
  subprog 4 (sub1) global insns_self 10 insns_total 10 stack 8
  processed 70 insns (limit 1000000) max_states_per_insn 0 total_states 7 peak_states 7 mark_read 0

The insns_self counts account for every processed instruction exactly once:

  29 + 9 + 15 + 7 + 10 = 70

The main program and global subprograms are independent exploration roots,
so their insns_total counts also account for the full processed budget:

  51 + 9 + 10 = 70

Static subprogram totals provide a nested, top-down breakdown inside their
root. In this example:

  sub4: 22 = 15 self + 7 in sub3
  prog4: 51 = 29 self + 22 in sub4

The global subprogram bodies are accounted in their own root totals rather
than being included in prog4 or the static callees which call them.

Asynchronous callbacks start from fresh frame-zero verifier states, but the
work remains part of the do_check_common() invocation for the main or global
verification root under which it was scheduled. Running:

  ./test_progs -t verifier_subprog_insn_stats/stats_async_nested -v

produces the following stats:

  stack depth max 0
  subprog 0 (stats_async_nested) main insns_self 9 insns_total 25 stack 0
  subprog 1 (stats_async_nested_schedule) static insns_self 7 insns_total 7 stack 0
  subprog 2 (stats_async_outer) static insns_self 7 insns_total 7 stack 0
  subprog 3 (stats_async_nested_leaf) static insns_self 2 insns_total 2 stack 0
  processed 25 insns

Here, 9 + 2 + 7 + 7 = 25. The main root total is the complete verifier
budget for its do_check_common() invocation, including both directly and
transitively scheduled asynchronous callbacks. Static subprogram and
callback totals remain local to their synchronous paths.

Changelog:
----------
v7 -> v8
v7: https://lore.kernel.org/bpf/20260808062601.1070988-1-memxor@gmail.com

 * Move the insns_total snapshot and delta for main and global roots into
   do_check_common() and explain why the override is needed for async
   subprograms. (Eduard)
 * Avoid splitting __msg string literals in the stack-depth stats tests.
   (Eduard)
 * Add a comment explaining why both the new per-subprogram records and the
   legacy one-line format are matched in veristat's parse_verif_log().
   (Eduard)

v6 -> v7
v6: https://lore.kernel.org/bpf/20260805011517.1717238-1-memxor@gmail.com

 * Rename insns_own to insns_self throughout. (Andrii)
 * Drop the async accounting call stack and attribute callback work to the
   scheduling main or global verification root using its processed-insn
   delta. (Eduard, Andrii)
 * Skip missing frames when folding instruction totals after a partial
   verifier state copy. (BPF CI Bot)
 * Use explicit callback argument operands in deterministic instruction-count
   tests and update tests and examples for root attribution. (BPF CI Bot)

v5 -> v6
v5: https://lore.kernel.org/bpf/20260804081114.3871564-1-memxor@gmail.com

 * Track self and inclusive instruction counts for main, global, and static
   subprograms. (Andrii, Eduard)
 * Keep instruction subtotals path-local across verifier state copies.
 * Propagate async callback budget through nested scheduling chains. (Andrii)
 * Split per-subprogram instruction accounting into a preparatory patch.
 * Add deterministic selftests with exact self, total, and processed counts.

v4 -> v5
v4: https://lore.kernel.org/bpf/20260803072733.191502-1-memxor@gmail.com

 * Change the format to combine instruction counts and stack depths into
   per-program records. (Andrii)
 * Adjust veristat for the new format while retaining support for the legacy
   format.
 * Explain why the legacy stack parsing buffer is zero-initialized. (BPF CI
   Bot)

v3 -> v4
v3: https://lore.kernel.org/bpf/20260803031457.3115812-1-memxor@gmail.com

 * Read names from subprog_info directly to avoid an out-of-bounds access
   when func_info validation fails. (BPF CI Bot)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260802225209.2511758-1-memxor@gmail.com

 * Reuse subprog_name() to fetch subprogram names. (BPF CI Bot)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260801230400.850271-1-memxor@gmail.com

 * Use multi-line format. (Eduard)
 * Adjust veristat to work with old and new format.
 * Adjust selftest log_level without new option. (Eduard)

Kumar Kartikeya Dwivedi (6):
  bpf: Track verifier instruction stats for each subprogram
  bpf: Attribute async callback instructions to verification roots
  bpf: Show more useful info in stack depth stats
  selftests/bpf: Adjust veristat stack depth parsing
  selftests/bpf: Test stack depth stats without BTF subprog names
  selftests/bpf: Test subprogram instruction statistics

 include/linux/bpf_verifier.h                  |   5 +-
 kernel/bpf/verifier.c                         |  84 +++++--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_basic_stack.c          |   6 +-
 .../bpf/progs/verifier_bpf_fastcall.c         |  28 ++-
 .../bpf/progs/verifier_global_subprogs.c      |   5 +-
 .../bpf/progs/verifier_private_stack.c        |  15 +-
 .../bpf/progs/verifier_subprog_insn_stats.c   | 223 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_var_off.c    |   6 +-
 tools/testing/selftests/bpf/test_verifier.c   |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  12 +-
 tools/testing/selftests/bpf/veristat.c        |  23 +-
 12 files changed, 372 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c


base-commit: 3a59f11e0f989bdd637c87151992605a6559a7cb
-- 
2.53.0

