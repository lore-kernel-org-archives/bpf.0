Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FB317B50A
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007781; cv=none; b=Ci0n2JnZdqIMUeWLfjSqWCwg/Gm6wHaqBFVhWO2lXBts/GzEMpMAXcFUdV6NMJG/McsoWSlkUDNqK/wOSutJwOb9Mx6AtK5SKVhYrSDmWLw1vW37/iD8GkpSdLwuwbCBdGNv9Q8kdFiK2LjCIdM9MGAcoLg8H26zCHOpeCSCKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007781; c=relaxed/simple;
	bh=pJ303NBSrrHCN+LAMFFITLfG12y1b/QRvsIGPW8oCkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBLsVTZpQEoj7C5ET9dEhXm02d+wwLIu5PHLEJxdXsCcnanfAHXlMF2YYAkUy4E/HKtFqOMIPn3zza10+xJBzG4gfXrguBQMt1mrYg6htixFVX9FM6oUUrw7UvoIWSePm1461EpU6LGRz2Yab/n5t1OzQ4V3CISBGuLm9VLc/P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNTI+hZc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNTI+hZc"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b4583f0a1aso2514865ad.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776007779; x=1776612579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KxE9+zU0EGgz80OWfaKj+O0EMhcdHq2CWskM2oUY5CQ=;
        b=eNTI+hZc5O3WCSa+eKbjLUuLnH5Emb/jdrzyAqCGcMQmc1WWlJPnAxMXkgJDfhB33T
         0DcsThwH041Z80zxVgz6FKLSjmPcVuyZoEMxWv+mzy42a+zgFWX/o2LON477eN+NZFgj
         CcabgQKnC1XcBYFC1wHs0ART4rPsSBoOFBgm8lMC2ZQC6/pjNS0XiNSwc9H+e2Gi+AZd
         WlbE9cPrZyQzh6BndxlebNI3xtBTpHqUqHtKJOd3+3BZ/cOioQmrvU2eXbkcFc408Ev6
         upDZqPEUM12Aqgr3nXgEql5R17bOHtTgFGyT+FVNyO/We+2y4DKLm7vT65Tvk7pEmVZz
         RsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007779; x=1776612579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxE9+zU0EGgz80OWfaKj+O0EMhcdHq2CWskM2oUY5CQ=;
        b=Y4zzmsHK72/ftMP22BeRm42pZF7p11hZtGo6ZpYtcqzTjFzHPgczAfLsUG7uTBkCkn
         oZm2Fm8MVSZjHgVSlbcaovHYNDB/nUc7V//7dDc4nrvQgMmEuQBB32L05oprvEZ3kHtW
         /NHiYNiaRoHJH7r+BhnK/tfJIv/YbGPUHJiv2VljGBzQi15NpQDvr0D+JwISnPPe2SSF
         CRZ/ZQMnry9bNm8rmOurptthW1J5HQse7u2/jwGJoAFcxsxZlSlsaPV2BdUnTP9BsOBa
         2S97myDXcMRejKiYDmPV2ROOAvNfgj7aaQhEQV6g1XAwc1fspRyrb1BAr2b18R2eKnLy
         jMPQ==
X-Gm-Message-State: AOJu0YwrzHwZF0kd7EbYtkXNRUOvbdU4rbhFBjcDX3SapBPZ323xeKHL
	VmSPpDKiyuRLJW9pSgc8o6QvzdAQrCzaQu+9XKp3GVyWIyOhnRa0qWzYr+hltA==
X-Gm-Gg: AeBDievX5exC85MCTCTWIfeWGdZyRngWIH4yImARsmhR+OAiwjVTjrdYJu8BXQ1e4t/
	IbePmcxiQ2QwNicW5y4B1GUx721izeW3gVUx3Rr8Zlz6wDX4SYb2qApDOEtz8jDjMsIOjhLtPLj
	KUXH6IfglLZj7KcNb/GL4X/EmyFVWWu1mAwWz+vb3WPa6IUiSltSQIccWlakHqDHpPk91R4j0/J
	Qu3QKEYqH1LVkZtM5b79caoVVsNavMW0FVi8t+v1xCtxUV9dLrqhUbFQ/CwEEWZRWAsEl2cPvTc
	06XUViqRRj5f/qhsHxcqS0HNIYLSJmOKbkC9v8RLQNNDmkfjI8MoAfc55sWNjq23gMYjJCyiuTj
	siLjlqcEUInisgEFKHwqXbnsLg8P/pTNcGqvnseMzaI+1QQ8GCFcaifoE0DPF3ZHCPkBb0wrg/h
	BRViFnLosMDI8LSFae9+xlFWz34W0DD3Us/OzDjKPpyKM62YveTqbRlq8gs75tULKRSrnf2EvtG
	mO5oioGMBb0yC97egAA0O2iGpU5KMhA3EuE40FK/mKenBH2x/+izUrqd5tGyg==
X-Received: by 2002:a17:903:c11:b0:2b2:5099:2f3e with SMTP id d9443c01a7336-2b2d59416b7mr65207535ad.4.1776007779295;
        Sun, 12 Apr 2026 08:29:39 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4daede9sm116660095ad.14.2026.04.12.08.29.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Apr 2026 08:29:38 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v4 bpf-next 0/6] bpf: Split verifier.c
Date: Sun, 12 Apr 2026 08:29:29 -0700
Message-ID: <20260412152936.54262-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

v3->v4: Restore few minor comments and undo few function moves
v2->v3: Actually restore comments lost in patch 3
(instead of adding them to patch 4)
v1->v2: Restore comments lost in patch 3

verifier.c is huge. Split it into logically independent pieces.
No functional changes.
The diff is impossible to review over email.
'git show' shows minimal actual changes. Only plenty of moved lines.
Such split may cause backport headaches.
We should have split it long ago.
Even after split verifier.c is still 20k lines,
but further split is harder.

Alexei Starovoitov (6):
  bpf: Split fixup/post-processing logic from verifier.c into fixups.c
  bpf: Move compute_insn_live_regs() into liveness.c
  bpf: Move check_cfg() into cfg.c
  bpf: Move state equivalence logic to states.c
  bpf: Move backtracking logic to backtrack.c
  bpf: Move BTF checking logic into check_btf.c

 include/linux/bpf_verifier.h |   285 +-
 kernel/bpf/Makefile          |     1 +
 kernel/bpf/backtrack.c       |   934 +++
 kernel/bpf/cfg.c             |   872 +++
 kernel/bpf/check_btf.c       |   463 ++
 kernel/bpf/fixups.c          |  2457 +++++++
 kernel/bpf/liveness.c        |   247 +
 kernel/bpf/states.c          |  1563 +++++
 kernel/bpf/verifier.c        | 12195 ++++++++-------------------------
 9 files changed, 9562 insertions(+), 9455 deletions(-)
 create mode 100644 kernel/bpf/backtrack.c
 create mode 100644 kernel/bpf/cfg.c
 create mode 100644 kernel/bpf/check_btf.c
 create mode 100644 kernel/bpf/fixups.c
 create mode 100644 kernel/bpf/states.c

-- 
2.52.0

