Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FB2868B4
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892521; cv=none; b=UaaarnTl90zkNM29aOZNoSy2Y3ZLnqoFT3KXeGvB65Pa5JbfvS1iAf7WzKGnuSTJ1beMvTtYh8ynKrW1vwO9xuy5Bm4obn7WsKbUhjGzjJeubdVsJOUN+0TkFehR2uqjF8BdK6j2LlcduW8VX4k69n0TrRhHXATnbPjA8mVRW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892521; c=relaxed/simple;
	bh=+txmxU/ZMr2ONKfefIp9Kylp1isN4LsPu1VWuTDd/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fHnaz0yLMNCY/QWLOx6WJvKl1FALWCDFrzeIBz6t75lj+CZGlZyCs+OAss9HB/m7ILPWYzVpGSPm9iPgkvyot5FyaPO/G9IJPZD+Pn2yDRGfqxQqa3VYv9ZDb5YojRwroNUtJR1mrMWWjv1Y1nK5u7fzPa8G0NWIrNjl5VNOFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7jD3ZyH; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7jD3ZyH"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4955e5274cdso919865e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 18:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785892518; x=1786497318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSR9tKCjNVsosOh2/U7Hz2j6LcY1kEaWYnK4yq9QVcA=;
        b=Q7jD3ZyHUTTHNZNbXaKPz2zc2Ndddw5eFGYe5x/DDaRg3cDgeXV/KVEqbCDoUCjHh6
         rxbmAcbqwdLNM0W/nu2B3iVVwPjr8Vw/PBNr8i3SPbRwyvChXPaoNJMWUpe21QUqacrI
         lS1kBkfOJYYm+sB0XqQ35+Lzd1Zon4ZwiupfgIdbE5xW96oSXxSy6UE5YTfUAQuPt7MN
         ZKcBYIn6OqnPJD2Fg87pluwpVyIzKjAmJcuj066jrvWfIjAng2Ice/8rXE03zEdqkBip
         Jw0GKxELUrW/jWpdF6aAsXYOVyo5/c1qlCwvMexBZFXKrif8CbPPUdfGC3lBKPW0foJl
         2icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892518; x=1786497318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSR9tKCjNVsosOh2/U7Hz2j6LcY1kEaWYnK4yq9QVcA=;
        b=ZtUjVREc/etZOS8rKyUlBTSfM3f9d0viHGCp/mQL/2B/7wDvzuqAcbI6cCycutAVKG
         ditSXz1iaYCUJXv3K/LQk+73QylXakL39LM+Ruk5LouAeT8tCeI2kskmj2wCZZ0ltjhw
         +p6e3lxuPepf3RfgfoAt9rz9QFWKj0jPNaabzKXxLiqFBuIows9Kcz1/1NjkVUXbUcf+
         QzXHXyacaICfMH9TLicj9aQA1RigiZjei9livFkFK8hKH20Y6vEg9q+o/Gjk/s7qjtEx
         D/VXOUA9QfB2SNbgcxAp5d5HToFyXMhbFcPoGauk/kiix0hsBQHZ/5nPKGTu16b405kW
         ASsg==
X-Gm-Message-State: AOJu0YyuK4uluPJ5/OFb+0W2g8ViP6Eji+K0ko3jF53gQT0lJqR65kiV
	Vv0r/gjDnKZz7TdB1NG1Q44kXgYr1fvFA/X+tMWh92ekrH/+FJdTtujp1Oqz8SIN
X-Gm-Gg: AR+sD11q6KtGDCjRLxxcrxPQQaXs7vqfPHZ/3hPhXVg/8a6QQ2ln+C6EL7ZlCb6hQsQ
	A0R/aAPUl6UNG2XEv9McPbk2koi8xZU/cHP4fbM+WoI44MRwUUxOK7Cl/SokMu/3xznFp5ff1//
	rxDTIDV9LBnocRHU3ewhQfSgPANY+TJa7S7lt2TqegA47MdSY/559Sot6Y88qY1CoZScijUYxKd
	FGLDVUF6D9Uc84zA4vrIIG/J5v4xsoW/SKMOXk3rea45vs8Yx+9rmLmBgA0R224ZO6khZMQCfdJ
	PGqMQq26klwQBHXUlrMc1VHMg+CkxbF0YXQk9sNlVE85cXfhG5O9VEX6lmssvfYH0Txr4PaKhHY
	J7H6I9X7mVyUAohDwXmvuSGaIrpOFrp3hoFETiRgicEmHkQQ8PoKJdMblxzoqSToN6abe8jfRB+
	4H4hqUOA+8YKaTjnhMGgpiBPKanaVq6SL7D1xC7r5Br3M/DeWCLxeSMeQLvV/TVgDl3QkVlBQov
	kb0DID5NZwtYx1AoNdNrmE/r7eofvhP77GisQpTI+v5NMOUqZYOxWQQl6be2eWMoUuVZIBmQEym
	+wvgh8RdNCJaUjgKRN99YguPAj4=
X-Received: by 2002:a05:600c:231a:b0:497:ff28:6deb with SMTP id 5b1f17b1804b1-4994e7c71camr17495465e9.11.1785892517788;
        Tue, 04 Aug 2026 18:15:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994dfda556sm54915435e9.5.2026.08.04.18.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:15:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 0/6] Improve stack depth verification stats output
Date: Wed,  5 Aug 2026 03:15:08 +0200
Message-ID: <20260805011517.1717238-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5093; i=memxor@gmail.com; h=from:subject; bh=+txmxU/ZMr2ONKfefIp9Kylp1isN4LsPu1VWuTDd/cA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauoz+UzR8Ca5Vu8cz7tOinxM2iCnOb1h90ZG2/oauv9T P8W/t2uo5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABORKGT4Z/nG9kLZroha1kCz jNk71T97xup+8sz4Jhn35PLm3dPkXzIyPNy2Z1/XLKOza9TuOBRM9xLy2pHe/SKc5cLZ1gUHxfe ncAEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Some improvements for more clarity in the stack depth verification
statistics output. See commit logs for details.

For example, ./test_progs -t subprogs/subprogs_alone loads prog4,
which has a main program, two static subprograms, and two independently
verified global subprograms. A sample run produces:

  verification time 1765 usec
  stack depth max 48
  subprog 0 (prog4) main insns_own 29 insns_total 51 stack 8
  subprog 1 (get_task_tgid) global insns_own 9 insns_total 9 stack 8
  subprog 2 (sub4) static insns_own 15 insns_total 22 stack 8
  subprog 3 (sub3) static insns_own 7 insns_total 7 stack 0
  subprog 4 (sub1) global insns_own 10 insns_total 10 stack 8
  processed 70 insns (limit 1000000) max_states_per_insn 0 total_states 7 peak_states 7 mark_read 0

The insns_own counts account for every processed instruction exactly once:

  29 + 9 + 15 + 7 + 10 = 70

The main program and global subprograms are independent exploration roots,
so their insns_total counts also account for the full processed budget:

  51 + 9 + 10 = 70

Static subprogram totals provide a nested, top-down breakdown inside their
root. In this example:

  sub4: 22 = 15 own + 7 in sub3
  prog4: 51 = 29 own + 22 in sub4

The global subprogram bodies are accounted in their own root totals rather
than being included in prog4 or the static callees which call them.

Asynchronous callback work is propagated through every scheduling subprogram
in a nested callback chain. Running:

  ./test_progs -t verifier_subprog_insn_stats/stats_async_nested -v

produces the following stats:

  stack depth max 0
  subprog 0 (stats_async_nested) main insns_own 9 insns_total 23 stack 0
  subprog 1 (stats_async_nested_leaf) static insns_own 2 insns_total 2 stack 0
  subprog 2 (stats_async_outer) static insns_own 6 insns_total 8 stack 0
  subprog 3 (stats_async_nested_schedule) static insns_own 6 insns_total 14 stack 0
  processed 23 insns

Here, 9 + 2 + 6 + 6 = 23. The nested callback work is propagated
bottom-up through both scheduling subprograms:

  stats_async_outer: 8 = 6 own + 2 in stats_async_nested_leaf
  stats_async_nested_schedule: 14 = 6 own + 8 in stats_async_outer
  stats_async_nested: 23 = 9 own + 14 in stats_async_nested_schedule

Changelog:
----------
v5 -> v6
v5: https://lore.kernel.org/bpf/20260804081114.3871564-1-memxor@gmail.com

 * Track own and inclusive instruction counts for main, global, and static
   subprograms. (Andrii, Eduard)
 * Keep instruction subtotals path-local across verifier state copies.
 * Propagate async callback budget through nested scheduling chains. (Andrii)
 * Split per-subprogram instruction accounting into a preparatory patch.
 * Add deterministic selftests with exact own, total, and processed counts.

v4 -> v5
v4: https://lore.kernel.org/bpf/20260803072733.191502-1-memxor@gmail.com

 * Change the format to combine instruction counts and stack depths into
   per-program records. (Andrii)
 * Adjust veristat for the new format while retaining support for the legacy format.
 * Explain why the legacy stack parsing buffer is zero-initialized. (BPF CI Bot)

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
  bpf: Propagate async callback instructions to scheduling subprograms
  bpf: Show more useful info in stack depth stats
  selftests/bpf: Adjust veristat stack depth parsing
  selftests/bpf: Test stack depth stats without BTF subprog names
  selftests/bpf: Test subprogram instruction statistics

 include/linux/bpf_verifier.h                  |   7 +-
 kernel/bpf/verifier.c                         |  88 +++++--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_basic_stack.c          |   8 +-
 .../bpf/progs/verifier_bpf_fastcall.c         |  38 ++-
 .../bpf/progs/verifier_global_subprogs.c      |   6 +-
 .../bpf/progs/verifier_private_stack.c        |  22 +-
 .../bpf/progs/verifier_subprog_insn_stats.c   | 225 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_var_off.c    |   8 +-
 tools/testing/selftests/bpf/test_verifier.c   |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  12 +-
 tools/testing/selftests/bpf/veristat.c        |  16 +-
 12 files changed, 395 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_insn_stats.c


base-commit: 6655c409707ec8ce9ce0850ffe4fe02331fd4d9c
-- 
2.53.0

