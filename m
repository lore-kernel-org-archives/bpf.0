Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A319A3009F2
	for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439309; cv=none; b=m36PnuuOXfqEr48imiTwJ9MGLDtXMCEQmqrI2tLXz+W5MohstyVZY2IT5X5mWS+R9R7roC7H7ubTwV2Ri4N4iFqYi2to/4IM8wZVu5NUBcn+mJ0cgnW96Ge0Uy4BfZTZQ0H1zmzw4T8axiXmRAY2iJA+qQWILOO8/R6uFRbbN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439309; c=relaxed/simple;
	bh=hCG1aonoDqL3VPxWXb5AJsXu8sZsT0Fdbgr3773Yh84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g1ROdfNrtGBBW3DMqY+1xu4AkROvxg5t3//mgpEcmjwL12lCa8zWhoDkysNPZELpdoPQIxQbEvVom26ITL2Vc6QMQLtahGnhofs6EHw7DdKT/DZdeyuYtfDX8AmxEZCkB+BzNeRGYjgldtP/7Wse3paYQ2FUI4c/rP4v4sTrUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de; spf=pass smtp.mailfrom=swine.de; dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b=hVwR5JA/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=swine.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swine.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=swine.de header.i=@swine.de header.b="hVwR5JA/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so18745965e9.1
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2026 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swine.de; s=google; t=1787439306; x=1788044106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IhHei1VKoqJ0zzoYbfccvAVZfX3h3oItEz3B+qvlJrI=;
        b=hVwR5JA/oZclbfD7teot8/7cPg/dRcJf+2y4m7LRPnj3/C0xhDAb8St1TxrNOpu+uG
         zFB6A7O75RliKWXIHPURt1OdU5b4ksGaLllHomoZtL2vlvFJBK1uwpKooCaHyo20tMzm
         YVxN0nHBCUJdhAFuEQGKrUmLB0UMa82dfPV3fI94sHK0qt4D3qWR7g6KPQDo5EbfpKQP
         FSDxh/mlJ+T9Fv3Q/OFdz8Iog7/5criErgt8GDBChw6FVzRLYOlDmKIhrcIHvsOW8D/M
         sGueRKZwK55x19BEedDIY8bhr+ihON/rSvB4LupkUokbwr9ffrhG6fy18ZMP2LHZe95O
         kigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787439306; x=1788044106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IhHei1VKoqJ0zzoYbfccvAVZfX3h3oItEz3B+qvlJrI=;
        b=i4V6uTKNn37RAROjn45V2F4Y+rv7TvqbmEh4mo1/345DQhI63hlaGZkJRj4gf+w+Ed
         CdFSQLnd8N3Lx09Ee/7IcWA+MHHi4w4HFK7vbfuIKQIuIUMMulAln0JmMRPm9KbNdhy2
         5m/MuiPo80vSHBwE9LCn7DmEoZI8dT1Li5rt1qNFsOcFqeJ/QICQKd0ChPdaMvZeOZ9H
         MW0VTY2R285L3xZRLTxuegAZnaIwdFtiL769vZ/pLdt97IoZGR3c5LHTx81YC9DrJq8N
         kpC3NIzwGnpPO8i/N3Tnl+uvNc9sG+w9QVQcNqeEaSUvm+EcUVoTtBLQ+tn/OjPgbSm8
         iUSA==
X-Gm-Message-State: AFuF++lyNJHEbFbqM3T7rvQprlgV5nmnC7Zl+vl0DCvXDl1HKzgYHjBs
	OSzYp+CDdsQvLU4vvkJrk8SzCtkAhmMiwqO5HDFjwOJ7jLwOiCHDq+use/55hLfV1uS5I3D3+/l
	dalzeBVonGg==
X-Gm-Gg: AR+sD12QjbA3LSWB/4c0muFolnGvNCCIyAW8TtE0ua1K68v6CMM6MAvQ5mOl3Rd9Iyl
	PyL9u0VPumVUESAE9NBLGz7z8yp5fzPyBXEo9ISCgPKEalz8gAITOjFNr99MftKWxBH4EPnXwxG
	qm3okeg87gHX1tdRiQe4cfdp0bycAuZSRHmg1Y7b4xRyd1Qc0WjUhCUtKiYjQyOTIygMIaXEZ+f
	sgEOWhFdi9aADWQIqqEytw7mx5dkBi/3oO5cPjw00v0IDxllBEkbu/bC+MIYJJSEPw2RIN7DRqB
	AwNL9Kbd3WV1+NMUNYaJZ+P1kF/m8AM56eBWUZi9ss3NTbphdhPTqtGup97lmKhx9KHaEqGjXrZ
	qj4rqD+qRw4lFD50uzOpT231oO38w38i8Q1Ec2eKpwBoK8Wedh3lwgKNlH9a7A149HjHwMQqFAo
	zUhceuEdOiBfVyPEeGnVBrA5gn58aonpoQJ2khsaz9XlmZUwxaZ4b2HumVCV3jpfpIQvWoneCWl
	eYoAj1Qk3LMVyU=
X-Received: by 2002:a05:600c:4688:b0:499:5f80:83ac with SMTP id 5b1f17b1804b1-499b91ad940mr124259265e9.7.1787439305687;
        Sat, 22 Aug 2026 15:55:05 -0700 (PDT)
Received: from christian-gtr9.tailscale.swine.de ([2a02:6b67:d11b:4200:385d:79ca:2b97:1169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b9ba5139sm41376435e9.2.2026.08.22.15.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 15:55:04 -0700 (PDT)
From: Christian Simon <simon@swine.de>
To: bpf@vger.kernel.org
Cc: Christian Simon <simon@swine.de>,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	tj@kernel.org,
	yonghong.song@linux.dev,
	stable@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	olsajiri@gmail.com
Subject: [PATCH bpf v3 0/2] disable private stack for sleepable programs
Date: Sat, 22 Aug 2026 23:54:42 +0100
Message-ID: <20260822225444.2774461-1-simon@swine.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A JITed BPF program can use one private stack per program and CPU.
Sleepable programs can be preempted, allowing another task to run the
same program on the same CPU. The second invocation then reuses and can
overwrite the first invocation's private stack.

This patch series disables private stacks for sleepable programs and
adds a selftest covering that stack corruption.

---
Changes in v3:
- Target sleepable only.
- Add the powerpc Fixes tag.
- Split fix and selftests

v2: https://lore.kernel.org/bpf/20260818203234.1142913-1-simon@swine.de/

Christian Simon (2):
  bpf: disable private stack for sleepable programs
  selftests/bpf: verify preemptible uprobes avoid private stack

 kernel/bpf/verifier.c                         |   9 +
 .../bpf/prog_tests/uprobe_sleepable_stack.c   | 165 ++++++++++++++++++
 .../bpf/progs/uprobe_sleepable_stack.c        |  89 ++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/uprobe_sleepable_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/uprobe_sleepable_stack.c


base-commit: 75b0a6db4300e4c2c9e97a0848deaa7acfb42fb7
-- 
2.54.0

