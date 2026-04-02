Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801072FE582
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110668; cv=none; b=pULJr698DkNkIN5YILQffXtMfdz5DY0IflhTsrRybuGhfYBloCe1Hsj1H6P5vYcn0oaQL9KOERbG4EloZSvU5BR1YAtI80Ukp6Mw+cIFOb/fIYiJBwq3BpvBOJTQjLjlVfq9Zu7OV9RdtCf8UrVBW6ZelS7tn5PWf4Tdsxs5y1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110668; c=relaxed/simple;
	bh=yWkcGi4UUALVzgfpUgHUSLrs1F8YJMFuW8/rau4pF6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYdxkFDQtzVxZl67W58EP7xeQ3dGiP5N1X/wMLwA2vaXFKJE5VDISf3h6hjJXNbr+uXngOjlkQX7M5x+sF95vpQQWcuYfmZ4KpKMGHBPwVuRU7AiMlOTPawkITouVdrT5vdbWzOzbkB5Zo+Ua8It1EmdbPtD3g7pdVpkS02uQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKNr/f9I; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKNr/f9I"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76b87931b8so310982a12.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775110666; x=1775715466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmBUNXUuOTvapYQgn6kyZhVOe4AU+s3WJ4pJlYoq2vw=;
        b=HKNr/f9IbOW8ftbsKK8JBQDVMyj7YtXwB9UqCcUyadGZ/DRNAlrCy6VHllmOO5MrHW
         JA7dE9cPcqqPcvOLhDbv/5xRfqXnzuuiQSSLdAoxvhmTPqBL6qH+tICSmS6mlqajZl3N
         MAshjzcXPo8f6rjgGIqsWZgD60wFQTtBGHq+PnrILwbI2UYcZNXCxF+iI1nHWoiwWxBY
         EHydtUMRTzD2Fs3cldjPauHALMvKWqjcFoiPoyijJ9zyxmn88rZQeH72UiJbNOks62P/
         CuX1Fs1rDu58H6JRJPjOf275BSMsE+ut0KrUfYOv30ThD5zMYMkMYnP1Zq4zThXMQ3YK
         X48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110666; x=1775715466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmBUNXUuOTvapYQgn6kyZhVOe4AU+s3WJ4pJlYoq2vw=;
        b=o0t2KuU99vEwjqKhkp+UBH2juU9evYoiahVhncp/JnPawXF7N31ekS038W0nFnuuRA
         EnvV5QypdfjlGpBIf+4/izwNpkPpuOVyKP5YdgZWcilfMCgJ5pOqFCBidCjY5vjKg7sa
         AqnmnK4GvME2zF0RsrygXwKegOxGV1MNYB2WT3KE/xFNjy5duSZJV50M+VZ7r4JDllEk
         eA5vj2V9ecLzKORuEpRVvmwzOLdJv4kX1sgLB7YTvNdaRdinDbAGETukyCM6cTuJa08E
         LAx6KNr7iKXCbpc1HMpvNpHcvJrcZdXb7KwQm9xL6EmqBt55D9jj91zkZXhsSYD0hctl
         MnKA==
X-Gm-Message-State: AOJu0Yw/Vr5GZ7mekubblFrh/UaYZB4ijAvTcjOrSEKAtpGBw9LnCmTF
	gAtIDlGkugWtd/MZn/qMHXZ8q/P7OoPFlZfD/L1tlfeZD4zxdT0x6+OZ3yhMSQ==
X-Gm-Gg: ATEYQzwpKDsPqG+DNroMIcpo6PFSmFQUMRMff80/coFwlu9/GQ1xwdxmH2Tt0Bc2wA7
	XGU+zVq+4q9dTMZvetgrpx8vYnQgewzAopRRfTi1a6apeo7H33lhKMn4/zG0BeUqp0az/wW7z4E
	miOsjn1lGJpYYnNvN04/JQ6gJXR2cXqUTgDRjvqKclt1o2vLefkGnxx3mYTC9vw/ODIiiiuI7sJ
	N0gbv1UGlXNOLkyp5k5Lmb7Yt2U78DBouKQYh9FoxQlUk1q9asa/TYIc4VBKJA197005g8LQ4lG
	fukjFUu8Mo49eaoEAKx0+Ior2uyRqbnP8iUnk/ZWXfDwgkaR8lFf4UujQ9UaF4EbvA/98cs5+1m
	Fvon9qBzyZLr0ehNdo6o2bVOPj2qB+YasiE1SwbVoCjH6WfAK7hije+y6PY/ohcPS+lnisbkHGh
	pCNjPwARfudKRftwlqJusIBt90BO/9FNFyHyIa3637n2tix24GhQrCP15/K+tL80yY8Xim6MqOO
	LCo0g6i/zt6ra5t/kEYXmMQTcgwrEdA/5gGlJlS4Zx38q882p/kiiG8H1O80Q==
X-Received: by 2002:a05:6a20:9190:b0:398:9662:110e with SMTP id adf61e73a8af0-39f108fc58amr2326487637.8.1775110666200;
        Wed, 01 Apr 2026 23:17:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b60199sm1678503b3a.25.2026.04.01.23.17.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 23:17:45 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 0/6] bpf: Prep patches for static stack liveness.
Date: Wed,  1 Apr 2026 23:17:38 -0700
Message-ID: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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

 include/linux/bpf_verifier.h                  |  60 +++
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/const_fold.c                       | 396 ++++++++++++++++
 kernel/bpf/verifier.c                         | 422 ++++++++++++++----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_scalar_ids.c |  20 +-
 .../bpf/progs/verifier_subprog_topo.c         | 226 ++++++++++
 .../selftests/bpf/progs/verifier_unpriv.c     |   6 +-
 .../selftests/bpf/verifier/junk_insn.c        |   4 +-
 9 files changed, 1045 insertions(+), 93 deletions(-)
 create mode 100644 kernel/bpf/const_fold.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_subprog_topo.c

-- 
2.52.0

