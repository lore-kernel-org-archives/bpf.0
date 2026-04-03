Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B552258CD0
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184266; cv=none; b=ZyEM0AaS+pct3iibak9Dqa2MkzM587JLF5fgNdbkrTVWI7X1GSvkU5PnWrvT8+/a3WvZ7dPaH7y4mBl4020vArMgjXvK6uHxgcqQ2/jQxagjukdayt4hz3eqTeqZZCfhXIgnVM6TkNHtPb+7fi/ztCZtkUBqFlGEDI4k83QElJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184266; c=relaxed/simple;
	bh=V0cnXVn7gX42hp565RwSdm5JnbdjhZnf3y8WDsuGEWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qooGOmg/AqaTGRadjlcIgeasC+2yNXaCOuY+gFYk+thG2/Wg0qARHQGJFn4JHJVCzuOO1tpMlSjya+zeuzdS02tq/Z4KgjSPi11DWP/6H1B/UECdmoUTz1PiNTWaytjyXjb+tm1fGKtKh8LiQz5hP3s4ZyKmRX52mbyY1wPzl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baStb0zD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baStb0zD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so694592b3a.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775184264; x=1775789064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gw43aNg1SdGrV+FTlx3PI7ppvhHAdG6WzOYXcpXBcXE=;
        b=baStb0zDfseckIu19tP9s57n22eCNoFahmNJyrEBbDtKC+tulWoAlXAXVj1kyETZhd
         2Hsmjary2fXa2rWZKPqUUnpHxRTLDCDiyW9TqKnsv8wR34O8h1N1/cbz0CvaMOCgdAQR
         efQNOipzD6zF56zHyVrWGHcBY93J/fl9Um02xR/eLTBHZmVK3Typj63VwhrpH4+f/Oi1
         K79Rp+bOPsOn1Ogi9ifXYB/XnhXuVI0UUB7OnvmlK+Du5q+j817My09iI2V+fNGkBxcn
         GZjOzJ5h9CdMlIdFnLJXiSuiBr+gtdpVk+yzf+mhSri9/Dv2UUJ4yPR3Jh4/BR6beeCt
         0zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184264; x=1775789064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw43aNg1SdGrV+FTlx3PI7ppvhHAdG6WzOYXcpXBcXE=;
        b=aHVy+BLiJeg64cf9uW8F6S+xkOh4OY7REZUyMwOm8jwPPvwywcg7jeqrtBa07daZFU
         jHKjhQhl3i0pnQcdLaeacmW4U8Quxi1e7/wXjG7vWd4VhEvnnoS2JmaG7wTibWbCZ08R
         eZ+AbzX+kCZaSDdcLUYSDy0Sn0pphfMwlfjINp/OcfnX2tUoTFvfd2vgaBvd+K+qZa+o
         GV0gwxVSMwA1z8EmzV7MNQQhZnZcIE6NwGZDwjRYgwRzlup2Z3SZKiQgIpufwepej/Un
         3FvUkkPQg9/Z0pOQlIR9ixawbhf7xfAUo8dEs1ytGXmCM1sP6ijuk2P7i32px+1yWGmL
         /XjQ==
X-Gm-Message-State: AOJu0YzVXZqJtK0m/haksxvZw0VZyEdEO+KMxmK7X8RvkEZJvLGG+h5I
	rnPxQibc7aeo/VKdcUZ1nWvwfjq4j/j7LGBfExyr0IGw3fGuCBCiquUQTQrCOw==
X-Gm-Gg: ATEYQzwS/SZU6rE84bCA3e1xVzHKoH0JnFiqGEnla3Xpj4WgLc1Hvop11G4WkKBDY2g
	hfxiTA/Ka1uCuqi1Yr2mUPCqo1QbP/CwJ3qcHhKfZALgbs41QaMHOZ8QPcmpxAiT01+ynA/d7ru
	pnUoKEUmI35XgNj3qtmoaEkJKCyuJO5yjzPntLFksO9Z3uED+M2yqpRZtxRDek/m/PWVPZFZSAV
	6bfkwU63NeRjCpA42FaGePj1RD9zPoJa35EJljbmQlF/lcy2Xweg2VPkzcCqkryR41Sdr2bhfTC
	LkbNE9IwPWwufIJs9fo3tdxHAga//9rtJRyfLAIxw2lHDYzSIGV31fyEaWrdWodJk+frwA1sjVj
	YodwEDL9IGNFJfShJ+7VM5TtsG/IFLV4/1aXZPYCMXmJoo0L5Z8nAm5GesXcGgycosXdM/My7Xp
	CSr0vozVz8DOg1cS2qLbCHuR8LQOY1OtwnozPmLknE4T3CoFNbj0aeovtNYFcfTWI1br9sd2+11
	ujwr569joBM4njC486oqxFpsC91W1tPvIxzQS0Xrr4+4Q88UyDL6xsqJjvEnE3yXPqkq4kO
X-Received: by 2002:a05:6a00:3318:b0:829:9fa3:5c8b with SMTP id d2e1a72fcca58-82d0dbd53f8mr1320080b3a.55.1775184264158;
        Thu, 02 Apr 2026 19:44:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9cf065asm4145944b3a.8.2026.04.02.19.44.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:44:23 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v5 bpf-next 0/6] bpf: Prep patches for static stack liveness.
Date: Thu,  2 Apr 2026 19:44:15 -0700
Message-ID: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v4->v5:
- minor test fixup

v3->v4:
- fixed invalid recursion detection when calback is called multiple times

v3: https://lore.kernel.org/bpf/20260402212856.86606-1-alexei.starovoitov@gmail.com/

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
 kernel/bpf/verifier.c                         | 431 ++++++++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_loops1.c     |   3 +-
 .../selftests/bpf/progs/verifier_scalar_ids.c |  20 +-
 .../bpf/progs/verifier_subprog_topo.c         | 226 +++++++++
 .../selftests/bpf/progs/verifier_unpriv.c     |   6 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
 .../selftests/bpf/verifier/junk_insn.c        |   4 +-
 11 files changed, 1057 insertions(+), 98 deletions(-)
 create mode 100644 kernel/bpf/const_fold.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_topo.c

-- 
2.52.0

