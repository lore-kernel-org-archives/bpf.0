Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1035DA5B
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165340; cv=none; b=ixmesIZ6TNdZxJLmoSXjmTVQjGcTzow8C1iBJf6bapoRoOPWT12SNNQfjaPFoE8+urtwA3vfuRl7R8VJbU1mDFDKKkTUekh7IhdsOjuf5am8EcoT/EWUiqe4VUJkmrz9zdNzNyLjm+ZiC9IA8xkFQTV61floezr+ij2wCMJuhy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165340; c=relaxed/simple;
	bh=hB6vk7TOun8L3gF8GIIFvvpNX/x+SMOUgHXebLTfTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPVFkNWFChhQMYIilD19Bq76hknrJ6dWC5hHPGvAgUq1isvhQzqeIVzd60HU/d1e+499R3NtPOvF6UNSOLpOcl3cccG4QZKTQscT0olP1sAZs3BSq9DU8oRlUWg+tQPrfZSnzTdtHpDD6gJi+OL1AhPIhiwYGCQlweOmbbyL0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPYK2Wb3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPYK2Wb3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so1143433a91.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165338; x=1775770138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yqyWc5K9i9oCpGyKKrmxhsFyGFvbzy0nn/eV9JCzXU4=;
        b=lPYK2Wb3jvsW6R30MyCEqGqQFGs5zw+QzpmqcxvFYm3HBNMxF+t8xJvu7LXReJyIik
         HsRmBRY46boGtKwPJyCShX/ocQ27qDWrkaoLk7dYLR1v0Dzn9kM4nHq+3cfXC2vJ9jfY
         ggKBziY/gzjHjuQ0YrpLHTqiyL9ZVW6b4nOVAeqKA0kolaq7T8KxvM7fTGE7S1qTKC0d
         5IXOMSww4zyjD5dhJofmrGidIp6MQQuKdoot9MUS/AFOlKRwwLsFlFs2OhBkNukdHV3I
         Lxvds83MOdoALvEqLjWLP1Wed/n01GX73DwWCq7z6NI7/UnZAXQ0GTon49MTuXRezK6T
         bjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165338; x=1775770138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqyWc5K9i9oCpGyKKrmxhsFyGFvbzy0nn/eV9JCzXU4=;
        b=mS0bbWdcXR3R2CMYqefJ1W80BBpAFb7fkJcSW1NHVXlERyLvLjVr13sfFwiqV8rMdn
         n3ryJLCAgz+TxFqJTsjR6S50jTyTJSf8Z7UxYAa3Rhupf9HjZus8zUaqZsz1BtmU4Xr4
         9eCIS81kmCxchYFV+K6khFKQYQdILBrBd8B1w1RWND1NrEIHOLMv5WhiARJdovo0zh5r
         a+F+Q2vemHjZGakoiSov4g8Dyuc070E9CjseXp1a2oVnXbaaCxn1B3rcCoBR7Tm4HjLH
         eKtnZFrGu8PfID7mN5tHW4LEbcSRWPugZTkU7cX9X8hskjSibXb4g5ql+ydaDwvExFwn
         uf7w==
X-Gm-Message-State: AOJu0YxA2DD9RLGHqDqr33b9xPxMrz+koczEmUADimF+4BoACfIsuhUH
	tdZmdok72HvuAIM5kGPeOLMWZWKO46aMf2voRVAOXvchSuRDqiep7yFKD7J2PQ==
X-Gm-Gg: AeBDieuf3Q5cwsgvi6RrzBsYWwcJqq2T6uK726f+AaI6AAl8RJh8QiGvSGl1Dyv2xKx
	K2FYYWpkS+Nc+FDiAXlfJdtapFR36uV/O/PaO4bojzdVKi3wW10SkxiUPhU+WWSY4UuCvQy6YGX
	chI/GPLDQSqdaScwHTUsVDX0FMs2QrAML93lq/T+Xw9VUvMs9fAaRaCrd35Yai96lMVPZC8SbBq
	L7KfpfpwyX1cAUb9sr2eyX9cS9RUMkvxxNIGljVeMgNKKQ1b/P790mbU40KVnQPCObizc3UK0Qf
	iZklMNlVNMtK2D1/YgfAW/CJ28eZwlldvk71PiV2qUsvwQFOd9jtie/rvygpPTSTrrlcbotRwOS
	iNVmCw827GJyECYvxnFrUiE8c9lQN3MeZSwGvUNTf31ttxPGojAcW9/jUb+l//tM6UhA2liO0wv
	Rav6+385WWGIDmYymm2tfJ88ZBFN0EyR3+3Hp6rBqNgjZ4fg9zvyIo+LITK2oOZrGifyFT6zQBj
	xR0G0fq4+2uIsikgAR2V2VxzXHbxA3GfCRk8WYnzwTSGir9f1va30uxw/B3Yw==
X-Received: by 2002:a17:90b:3851:b0:35d:9d4f:f58a with SMTP id 98e67ed59e1d1-35de67df975mr440480a91.9.1775165338503;
        Thu, 02 Apr 2026 14:28:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd369064asm3756214a91.13.2026.04.02.14.28.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 14:28:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v3 bpf-next 0/6] bpf: Prep patches for static stack liveness.
Date: Thu,  2 Apr 2026 14:28:50 -0700
Message-ID: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v2->v3:
- added recursive call detection
- fixed ubsan warning
- removed double declaration in the header
- added Acks

v2: https://lore.kernel.org/bpf/20260402061744.10885-1-alexei.starovoitov@gmail.com/

v1->v2:
. fixed bugs spotted by Eduard, Mykyta, claude and gemini
. fixed selftests that were failing in unpriv
. gemini(sashiko) found several precision improvements in patch 6,
  but they made no difference in real programs.

v1: https://lore.kernel.org/bpf/20260401021635.34636-1-alexei.starovoitov@gmail.com/
First 6 prep patches for static stack liveness.

. do src/dst_reg validation early and remove defensive checks

. sort subprog in topo order. We wanted to do this long ago
  to process global subprogs this way and in other cases.

. Add constant folding pass that computes map_ptr, subprog_idx,
  loads from readonly maps, and other constants that fit into 32-bit

. Use these constants to eliminate dead code. Replace predicted
  conditional branches with "jmp always". That reduces JIT prog size.

. Add two helpers that return access size from their arguments.

Alexei Starovoitov (6):
  bpf: Do register range validation early
  bpf: Sort subprogs in topological order after check_cfg()
  selftests/bpf: Add tests for subprog topological ordering
  bpf: Add bpf_compute_const_regs() and bpf_prune_dead_branches() passes
  bpf: Move verifier helpers to header
  bpf: Add helper and kfunc stack access size resolution

 include/linux/bpf_verifier.h                  |  59 +++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/const_fold.c                       | 396 ++++++++++++++++
 kernel/bpf/verifier.c                         | 429 ++++++++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_loops1.c     |   3 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  20 +-
 .../bpf/progs/verifier_subprog_topo.c         | 226 +++++++++
 .../selftests/bpf/progs/verifier_unpriv.c     |   6 +-
 .../selftests/bpf/verifier/junk_insn.c        |   4 +-
 10 files changed, 1052 insertions(+), 95 deletions(-)
 create mode 100644 kernel/bpf/const_fold.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_topo.c

-- 
2.52.0

