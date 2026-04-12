Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799434CFC7
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775963505; cv=none; b=aGgpNe34j4mwMo7O/yPxuhCCZwSNJHq6aIvhHKu+VZQwV6sxjMQGUtfUGknCgOpj02SPmjsTGZKF8wnuc3pxa3fzzasnjtgc4ghQoIyRdPCwt9fx4EbgEd+Hc6ydeVKgzWhz/c+3meiygSL2q8hFGDxIqGBVUyk2PGfF1J1t3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775963505; c=relaxed/simple;
	bh=eW22JNhxKeqFHRlgUglqnu1dF2bhDSrVaEnt0pVcDQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QbrGxHYnPzd7XJlixJwZdN7aQsG9HSFgthFviRNlG8vI0beUVgoaeMwZM6Mxhefu2EfHsdywrCf8AFsSwdmfle3T4LuNDMZMfbmo6PrjCgmwkkFdldxOXnJCYFIjz++ojQOdsY638aVxKISXWfc5MOWGVyUmzLyrEKeMKD1Dw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxqiqy8e; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxqiqy8e"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c76e702e01aso1104061a12.3
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775963502; x=1776568302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09MYCeHfL58jZVmSawMyzrmoQXnRCN4jiMGZx1VCy5w=;
        b=Cxqiqy8ez4ODZpAbmg+eb8XsnsZCaL/AXNFF9wIS2EdUeeUdRLYT1uiE861cjOCqKt
         ysKL21sWsyzKsFe7KTUbvx+DMzmFAdhqtJlcfwBP2I3i04w6+ZDLu0r0GSfFlgn3wlpy
         pyCTPHJRzwRmtYirHV2ExOvwteR+8sW5RPLhb6xKtVK9IBpVtTnqO+7zimEG1VqkijYD
         RvJsVaydE04yf6GYxfqSP5NBiP7CgrKeDzpcQ1LNX+W/uiPhGtTIMsUWlOjY68ajDvfN
         quYtrP+ruQkZzrtyI5j9t/KSLwqO4H8JFakYBRHh7WQQzX9Y3HqeUXqRuQ6R8WAfojIL
         ZxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775963502; x=1776568302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09MYCeHfL58jZVmSawMyzrmoQXnRCN4jiMGZx1VCy5w=;
        b=Wiunnoo7qDx3fPQ+WIDkgmwg94V1Hko9qd7lRJZbU3h8p06w1DlUS/M1SNUGMHseky
         r1e61hU2YSmHeA8EYXPUMJVLjy9xH2Be9Ra+Iz3mBW8mtvRVKDJ0cNchBBxIPl2B2tRl
         TSwTUQWoSI7Nqi1w+um596LgMCPXq28Dx/qGPAejRsq20vj60eDwSnpz08dZImFZAmeR
         h/F1FUD7vLf+mIoqDc5yx7ux6VXB+reiPzfIkn9TnHaGOV3GcNRog7uYkpokH3ITpJxn
         72vf5ZBTCa3v47ZeG0nj00ktA/QUXXqpOF85tgd9BWtsyRupQvm41OcLxyAc6ic6MWkC
         BWhQ==
X-Gm-Message-State: AOJu0YxpxmS6q7A/iJRYNJmGUoJl5XBX8XNYbAs2BKrISzo4H7O2mDpn
	JIEA161IiJqteo0s0BxtToIwrjvoYWgTQsA0R2ZKSldUOqMPkwALs2TilT68TA==
X-Gm-Gg: AeBDievZA5xS0P/aeJREOrSQASUkvlX5ynrKAQtogho/rNoXNPERrmRFTKQaZ9+JQqj
	uhWZAbEQAEawBEVog4N/hHWuO3SGEuQobdV1gzoTNOcqV+9bSBpxAcRTfjMmbuC5ou16gIyKXa2
	6j2WcEU2lPAiIG3iRushQOLqyyFXnScM3A0ZO8n7OSW/RCCZIHYrdEaFqXBe6II8azBy06xiM7D
	mQYPktEiABrBvdm9CerSImdGO5E6R5kkCvuhtMU25NRSRPeSP37FTpidYwCLRzao0ea7shJD5TC
	n0hcog1/te3WiwIn2Crd6fMxqadohb0dFSz/NItKTwLHnlxUA8f8sn6x5V+n+GA/XZ2goaj/TDC
	ZuULK3RZQuQbrsYkZTlOSXfZpoEzQLnUiFYfa9MCS1G19Fz+YAGAW9OQU2AzQHW6/O4SoCiX4ry
	uf8ysNFqLZtp2PC4hP0UrWg8GfhnoBLYyc+EHfk+RZdsDKmZS2qrna4xeZUEZU2lTGXRyXWvRYm
	s9icSKnZ5+BU75OG1sLAXw0O7RAiCEHhIPzqBfIRSc=
X-Received: by 2002:a17:90b:4d83:b0:359:8a78:569c with SMTP id 98e67ed59e1d1-35e42827fd2mr8995923a91.25.1775963501934;
        Sat, 11 Apr 2026 20:11:41 -0700 (PDT)
Received: from ast-mac ([2603:3023:126:8500:1c82:6ab4:808c:1834])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e3517f2a0sm14777766a91.17.2026.04.11.20.11.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 20:11:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 0/6] bpf: Split verifier.c
Date: Sat, 11 Apr 2026 20:11:31 -0700
Message-ID: <20260412031139.41248-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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

 include/linux/bpf_verifier.h |   284 +-
 kernel/bpf/Makefile          |     1 +
 kernel/bpf/backtrack.c       |   933 +++
 kernel/bpf/cfg.c             |   783 +++
 kernel/bpf/check_btf.c       |   463 ++
 kernel/bpf/fixups.c          |  2457 +++++++
 kernel/bpf/liveness.c        |   247 +
 kernel/bpf/states.c          |  1552 +++++
 kernel/bpf/verifier.c        | 12382 ++++++++-------------------------
 9 files changed, 9552 insertions(+), 9550 deletions(-)
 create mode 100644 kernel/bpf/backtrack.c
 create mode 100644 kernel/bpf/cfg.c
 create mode 100644 kernel/bpf/check_btf.c
 create mode 100644 kernel/bpf/fixups.c
 create mode 100644 kernel/bpf/states.c

-- 
2.52.0

