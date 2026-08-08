Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32383B1B3
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170366; cv=none; b=L0sQO+nNYSVVv56/7GziUg3PNgphjukqF7Cij66r4s6SjOz3gVfY8beEwhTjMJv4IMM4wmVQS6Z18PlGftv1lS4H76jyzYOnkYhO7Gpmb/QjetV/jHXujQOp8bxQbSOgAZ47TIJZlhLX6lQGPVO3ycy1W5ZOJ7zEHKGSI34Tuf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170366; c=relaxed/simple;
	bh=LGfWfwHd6DIb2nFEmjy52HAAUDE5x9CErbM+WXyZgaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYrS4q/VHV4LYiwcKBXUZRiNV6dN1HWNBVIngyCQv+N01MoUZcAEqRFtJqIufmW39vm+gAqwYirOXB+h9xiNtuIzcoEvidwh1k4Mu+4GfHpCertYRTCQuY3nk56htMaEbzHH9BgxDvtOaOmA2tFcx+S3HPWiLoIPSZTFye1+0zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdi0tDW5; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdi0tDW5"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495473da596so118225e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 23:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170363; x=1786775163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uZo2kZ+F4kIY9yrQOFHR7B+4bTQU1swkv9i1Cpph8MI=;
        b=Wdi0tDW5ZukOkV7Jb4qk/6VBGrXlheK5DhBIyvbKG+mWWL3HWTRkLecDXSjTyghuog
         D4Le0w7bQ40yFbGMaYKf16YPM2en9JKJ8kT2almqy7w0noj92Rl297N0bF7BgUCpU9n/
         ib9FEzknFyDPTJbRRyz7Yx54b1TGSADw8w8apGglpb/OyJ3yzwMmgRpTZjxNqACNOUoJ
         oWgII7tb14oTwz2xv2yeVXVOaEax+rVi1lyaC1cvLOw1bCeSxWaGK/RWqKgeGNYRQbrD
         j4VoHm0mrTJ9rnVhgBvtx3Bz8mGsa8FlHqW8e8kQDiuY+oz6gp1y5xKVw5KtFsHmj8Zb
         rdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170363; x=1786775163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uZo2kZ+F4kIY9yrQOFHR7B+4bTQU1swkv9i1Cpph8MI=;
        b=MoEiQtLQMqh0UHP7R9Gtol5wh9MXswnNh6vuWIA1Aty12YeieJcn50CnBB5zW60qzU
         EZwDxs1cAn8Ryo9W3l3Hwax0k031JgmaBFnLywg9hE5bfL+qGQ9UvysKtQuEXw+hXKiz
         b++ldG029lACV+jtBuDYp2CP8djKSU60gkYGvLTgyGHGjX7+kez5VmFwvw1IeMyh9W+c
         h7ZbHf2w36QdJHc3bMc/T3daYybvNuVk2SIxn2KmIkzwMLQL2l2bRObuHJxVU+3yn7sW
         Z3E5E8tyZy3+RbYKjXkq8mJSsfYiguUwKYmuEMpNmAjZtwxa0CEOBfmHO7up2FZ3Sc39
         M6ew==
X-Gm-Message-State: AOJu0Yy4hQiKZfwS8it20RWq00MNHyli49HqXZv4Ntx4byiirnRgk8Xk
	XlSg/NKvWN/THGlifBjzA/ztE/Miq+dCUR1cQoU0ierFED2+tMScmDWZynrvYmRMCgw=
X-Gm-Gg: AR+sD13IY1KBjjbbtTPmU+GxBK6lGyhsJZVaNNHe0mwOvpYGmja5mDK6WHeZ6YGOJ9B
	FBRczVnP119x0JqVTs72XI3YIjBUhlBBFxn6Dn8Y8jDLl6a/HAixwKqEjKUo6emHhYHpw8hQXs4
	S1uMLWB2JkOvh3ULEWWS2m2xHLRXRn/leaLxDkEfV26Yr+dNbtmM1XZmg3UO4SnMtsoDqs6trCe
	nmHQYn1Y/H0YuGJtq7KlpwgfGvsLmr0iR+0y2QkNXaeUOuXktpvEzqHBuqtqWB/4K21Zeo+y5qi
	joKnUMfa6CKWjeyf5Ulgxb/v12HHIyn5vY2UgbnoqpYx2zAJgVbSNkaPTwLc9qrzo3MQHi5x4x9
	v0QiT3rOgkaHqJGcVxW04ZWt+WECXjy99krX3qgIb42QJdFBQdMwFK8j7EmqRK1iWylbxrbFRIm
	K8gf6fSqalCE7YdJmE4hJMcC12Ny7qls+8FAjHed4rc/Dqw9ExY+240cqSRUoD+UiIoq9G9xMQA
	/ntX3Sgs2/dReAxlIa3tjoZ4ez9vzQLjabDsomo2NGX8cwZpTTWcL3D7DZtEqCoMW6xTI4xtGuw
	w17zl6LGSxROThKE5kEL73J2S+g=
X-Received: by 2002:a05:600c:4e8e:b0:497:ff5a:38b9 with SMTP id 5b1f17b1804b1-4996247e640mr37605635e9.9.1786170362700;
        Fri, 07 Aug 2026 23:26:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7a3d1dsm84819815e9.3.2026.08.07.23.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:26:02 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 0/6] Improve stack depth verification stats output
Date: Sat,  8 Aug 2026 08:25:52 +0200
Message-ID: <20260808062601.1070988-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5749; i=memxor@gmail.com; h=from:subject; bh=LGfWfwHd6DIb2nFEmjy52HAAUDE5x9CErbM+WXyZgaA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavs9M23CxVNzP5wzI8rOKGRpbMjdqVE3RT5pwu3/rH7H qnse25jRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbydy3DX2mbq3McuIUW7dn7 UViT9xXDtourv70//awiurfPUZ9733OG//55fz4tz9IoPn9JPfJU1zZuz1irua7vPQ3W9y+YsMl 9MiMA
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
 kernel/bpf/verifier.c                         |  75 ++++--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_basic_stack.c          |   8 +-
 .../bpf/progs/verifier_bpf_fastcall.c         |  38 ++-
 .../bpf/progs/verifier_global_subprogs.c      |   6 +-
 .../bpf/progs/verifier_private_stack.c        |  22 +-
 .../bpf/progs/verifier_subprog_insn_stats.c   | 228 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_var_off.c    |   8 +-
 tools/testing/selftests/bpf/test_verifier.c   |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  12 +-
 tools/testing/selftests/bpf/veristat.c        |  16 +-
 12 files changed, 385 insertions(+), 37 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c


base-commit: 51476f6a06ef55cecf785ae1622c638fa8cfb846
-- 
2.53.0

