Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289F26ACC
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775181834; cv=none; b=dM0yR6XVScL9YyFQ1jnDTE+5gEWbn0eR2XBwqz+VPsKG9DD6CQDCeX8sh7Lf0NyzNlTBQ3VsKHed8OK1WdCahuzGQkHDzfZHAp4aeqxUOgQS3jDNsv914wIwNHAbf7GAQoXkkkzcSbORMUTsTMs2X8wZwLWBQNOpXvPqUZO+Ixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775181834; c=relaxed/simple;
	bh=/xVBBjjm1nvOTcV4gSUAIH4ZwISTpMRMs+vKgz9j60g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJA/2qe1mI4Mz0D8wk/6m8dleV+eKPMDkXyvQjJEbWoxAzt+wlHUQecs8wweFOzaEO0QfL0l96hcf3In7JrRt2b9Bl8mhSRLrGa8SCh0RGt8lxACldQU87adgJZm6MOoDt9qlulrgfEdyl+yyO//BWQlUrFbdgRFzotflIiaaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQxk8068; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQxk8068"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c74244dc0b3so837827a12.2
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775181833; x=1775786633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7z959bnmwD3IQ/yEM6tn9MbRLjLOnIOGmxRM2YA1Pk0=;
        b=OQxk8068+Ywtl4vkMT/NN50nmgccLbeMSTkuC8SUpzn4sdD6hGwTqnHUgj9og1LAzS
         tB5oJZLQ3Omy5vKF9EVG00oB5VLEvF4hOR43Wb27vTg//Ay/8foThwjRve/yCyEbtgSt
         i0uaVSuql2TKcdR3qfUFKsrzsCXXv/ogZpYdALcWXq4mfpvB54Cz73+sg8LdaMfaGXuB
         v8HzjKTtyAD1Zp8f1qdvY/MJpsx1DSYfiEG1T5MVN2lVlrZ9NJAqy62fzYHFVkn5YheC
         5EIH8r17XbEZ2iQa38zbtS7J5WtqdBaY3igBvLnWeH2SL9bBdhj0TqHOLRbA8lhGaQAR
         LZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775181833; x=1775786633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z959bnmwD3IQ/yEM6tn9MbRLjLOnIOGmxRM2YA1Pk0=;
        b=JT0avnfzA9tlrOrjrTZJkZswWEZqcMaoFwsuF5PbutJPWaoTKdYju8Hf+CAtOYyCZv
         a7aKbOjdMRqP368a00hcniRJ/4+yWCuJVJt2YILiLSBh+hr2gYiWga7XS0f5PLpr8R1e
         LAyrFSHIVgZpTXk+xRYNFdY31ifFUOmk7L4g2L4NgAE1Y+79HByD3Ph5N4oQ2qcZf8Mc
         DFcC0DAZ6Cjo4CsjtMMWNRMGXEbyx5pXYzdFXtatTZoa20c6UKUEm+4AoZKr/YvlWQe1
         tLv7tsstq6w/fFp4UeUPd16BR9UqHN/o1iEnWg6SwkdooCTmbEoVHZIZhuZtX1vXNh/g
         Xlow==
X-Gm-Message-State: AOJu0Ywpl+zyj0xftSHA2h63oSD3/nuIKx7hT8V599e7XjhuyzDZOxYv
	2dQaB9SlWDFfluDSpQm2AJ6eeyFJwjbrf3AZrsohDTExTfarm+78wivVBrwkDw==
X-Gm-Gg: ATEYQzzNECYx7N+L260mnnYUbEcFTipC2n75YHHwF3socp1QlGc3qPDPPgBXZxjI3R/
	BQj3R157C/ImmsC5bSOeqK1tIYAvUNZj+qpdPOuiITfvgclD8sWaAUvKLoRzzigi3NRsMI7Yl3k
	BLzf9CLrd2Kk8oL0cGIb4uKltHUJQWPsSE2BEmMT6Km+1II94MXU2JKFKvCWZhAgVhHVidJj45T
	hoNxurMvr3uxZDhfvM7tZb0XitsxdNVA840fSy4Wq7GlfgOSjWTmsk0WWiNI2mM9MgZg82lUGxT
	wRNPGfgGCFWw9VJVF8m8rmCAZTCvI5LyxoNIsIZquK1M6ofkAdG4VRnmH1wRzLuhjh8d/QvWl/v
	ZBjwaGIoAGT4kWL8r6KIrq9kqiDSDClk1Xiko7DTzJhshVzFS1yfuhMOastD+DgVMSYC45qnyb6
	jeq3ypSZHV9zezgumANBgnOQopFgoyupBFO7DU2EGgtZtSwew/D1SEnutN9IbNyuixmN/ovXbUH
	106cc+Cld/H/1roNJvxSsK1BbpMBSM6ti/ypaL+5O2LODiznALwxO2wEDFwXw==
X-Received: by 2002:a05:6a20:a115:b0:398:a5c7:3dce with SMTP id adf61e73a8af0-39f2ee8c3ebmr1054404637.23.1775181832553;
        Thu, 02 Apr 2026 19:03:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6561fe9sm3737492a12.15.2026.04.02.19.03.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:03:52 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v4 bpf-next 0/6] bpf: Prep patches for static stack liveness.
Date: Thu,  2 Apr 2026 19:03:44 -0700
Message-ID: <20260403020350.73823-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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
 .../selftests/bpf/verifier/junk_insn.c        |   4 +-
 10 files changed, 1054 insertions(+), 95 deletions(-)
 create mode 100644 kernel/bpf/const_fold.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_topo.c

-- 
2.52.0

