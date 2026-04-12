Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF499299A82
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775966390; cv=none; b=lhVAEEk45tqXTqVyuJowbE2I0w98mHIinfWmDOmdnrqRfh1D6uwhvh8gC6tScNXvjGOSwWJQCULaEntE6l6wKD0te3lO20Kl4RptlkPlt/tMeM+qtpJvcwy3A+askUs8P/rVs9UVLBV50bkaJkg1k1XqGKhdbcxu3aGR7NUI4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775966390; c=relaxed/simple;
	bh=B++w+s1H28Wgavll3+Zb8PITrs55QwuPPHeRjrBqS1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ai6KSR5mGnn/YkQvSX/gSmiU2msccy81kqfUgp+qgny4BZ/F2FPD1mVR/zmu+gUlhp0sXPUwPcr9auzi5D0mVnxgfsbymm8CWFXKXrpEv4mYwWDkVZ+ovrfEsJAa0SbQPld+whqECcf2HrbIdoGZElb+bRBYPDZj6XQq01qcJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgOAVOMc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgOAVOMc"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82d0b68837aso1833671b3a.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 20:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775966388; x=1776571188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dVACO35wLDF+QszVEzok6Azy+lVqx/Q+37daFkjjXM4=;
        b=cgOAVOMcpxrkF2aiDxcUJ17q7gknHV6JmB+eYO/WD1xmfms9uzSegTOqk0poDZqxO9
         iqwu/k9g8PZ8EBBWscNy8ltIgQM4TjEiaLNgGVAcjy2mTAGoC2liJ/dPlO3y9yg0kPJu
         KsBxrbB4zAtLsbaYOoJr0WmaexMVi20L+D+D+Al9Cl3f+RH3dJliwoZDotm0vJAQLkor
         xfrvZ3J8WecKlRe8Xnvnh/E+LcOYlsP9CTNL0e67B75fdc7ra3PppxM5lGt8Onk85HZG
         9Gd4bmfDCZdghAYeHOfNaRx6n9+aDnGtUpneHOhRSyN4c20S6VOuo7bKsIAbu1pFg7aq
         hkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775966388; x=1776571188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVACO35wLDF+QszVEzok6Azy+lVqx/Q+37daFkjjXM4=;
        b=mMmJHl+lARz8uOnvR+95odxDpPNHarqy/0r9ItaaoRzGOSKNEJSx2sROsV6JdLIxGC
         S957YHHUcURxnqGiDvmZLU9iwy3WlAb47aGNb5fHK4+b19dEEDWb5SYNmxITTb5z1sRo
         2/jerST4H3Iefx24UZeT98fiypNTilbFhNwTBEGVL18h5vH0bAPCsHh1Q7HQ87g8ne6A
         QREOq09+47eSIzPzWa26R6Eaj5g7YaXdr3jo9ipOCZ/YiFxHdokYPsEYmYoW6ARD38yf
         R5b72AHsf9nywLo9tYzMIM0A4LEdVIoRHU6wImjrIF1OvpSCeE8Va/uSnEQmKOnFw3Ew
         hvhg==
X-Gm-Message-State: AOJu0YydOvoozyPQwsrezePrF8WCr7NjBYEZs9AvJVUAWVM+jzm0yYp8
	bTIZkw66lwWeKW/wNw9eW56BBdPOzXBq1qqV0r5U7qI4Y/jdBUVFSIZwheY0aw==
X-Gm-Gg: AeBDieu6opkzdV5IB/qAofoWUOaQmX4WfzxPP6SYLweuU/mn5/aCO0HRUedtdHSSYHP
	seFHVI/lYdxFbqLdGNJDSj7wUmuRbE5K7+CznCeEZogcLmw9EYnFVnWJLRlrNmsz6vfr4IL0/yw
	txEVWEP7UwphVq2xF9XUu4Ezh/X8qMWDKRBCBqeuSdLlaJxKSldekBgzlas8vDGRNgQ+u8tQyWq
	QFAJHIolwxryxtbn9LLUQi4rIiBwMjL0fXmS4ze9w/2EpbbRmbYreuhpH8NX6pgTcErzkOzGfZo
	N5+Q+d79v5M+qN7r6R9t3vVIN8czvcHg86hpIy50ZPdL3fquodnROmvUem0C7xmbdXW9Ui2n/L2
	F70Nlaez3U/ktcFzc4Qo+f0jgj7tHNbrZAhe/ZyEBSdL/m7hM5no8fwMpFxOFiBPpEUaUIj6V+R
	mXUUDW9PieN6EBRWa+w7HO57FX83RfgjCM7Lwm5MW4sdb6baJWzj50Mw9JTJqjjXI0WwxJTyJ3d
	VrEiVTsARhyRQ2qstznruV0dfd69IqdNDnpDSBRNTY=
X-Received: by 2002:a05:6a20:6a27:b0:398:b95c:51ed with SMTP id adf61e73a8af0-39fe3f55568mr9937723637.35.1775966387777;
        Sat, 11 Apr 2026 20:59:47 -0700 (PDT)
Received: from ast-mac ([2603:3023:126:8500:1c82:6ab4:808c:1834])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216fedfdsm6837928a12.4.2026.04.11.20.59.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Apr 2026 20:59:47 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf-next 0/6] bpf: Split verifier.c
Date: Sat, 11 Apr 2026 20:59:38 -0700
Message-ID: <20260412035945.46916-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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

 include/linux/bpf_verifier.h |   284 +-
 kernel/bpf/Makefile          |     1 +
 kernel/bpf/backtrack.c       |   933 +++
 kernel/bpf/cfg.c             |   872 +++
 kernel/bpf/check_btf.c       |   463 ++
 kernel/bpf/fixups.c          |  2457 +++++++
 kernel/bpf/liveness.c        |   247 +
 kernel/bpf/states.c          |  1552 +++++
 kernel/bpf/verifier.c        | 12382 ++++++++-------------------------
 9 files changed, 9641 insertions(+), 9550 deletions(-)
 create mode 100644 kernel/bpf/backtrack.c
 create mode 100644 kernel/bpf/cfg.c
 create mode 100644 kernel/bpf/check_btf.c
 create mode 100644 kernel/bpf/fixups.c
 create mode 100644 kernel/bpf/states.c

-- 
2.52.0

