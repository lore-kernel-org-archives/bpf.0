Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1523624CB
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220271; cv=none; b=TNBkABhZ9kxjPWP+1N+s4xnA/dy8R/hQjneZo22YWTjT9effa0WeIdQCs0hnq3/oPMcglQa8SkFGwBIY8BBImM4lmdXXHpfWUnwJwSo9I1RiYsgpnhPMMANSUuK1DmViqFo7or3aQPRiqhmaEHt6v8RysGzTCDmpncoXltjGtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220271; c=relaxed/simple;
	bh=rFy6nblFEXDXrQjYzDH8JUZIB9dmrqpOpTVpE56a+9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lcq+wODuoDj0qf2VI99LW2R20WChWBtAsMl0PNFNtjRE2XrxaLQ6G29tFxIfXuaqRXdyehRsm9NsKJYc5lSdtdWB98vcidhH4lc3QvpEdnn2yo8dwMI4nT6xshj194kvE7SHFNqsn6W0+Gi59KV75wXeFJ+JOiBeJPIMxN0pJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbQq5Y+5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbQq5Y+5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35c238f1063so1136471a91.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775220268; x=1775825068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJEQdMR4fTWKEEHbAU4/IQMqpC2w6AVUg71G3gp1ZrM=;
        b=sbQq5Y+5CRUQTSC2WZV7h10SDqM2v6YoZto7xFuKjwxyxM1qk4rtfbctfDae5kZG1w
         aiKZxFBnb7jb/zoX5uTxTnitmC6p6ibqj4PDSEaFOnydW6ajEl7mBnY4Rvq9t12KTx2d
         qqjvh5i+52wN3MbXcm2+27DqZUUSDkGTiwv08F67XxcZdydyHEOZHKVPhE6W27XFcg6A
         c0nrIYbB5Jg9+Nw0Y05/r13hmLdXfFqNyGr0RBEeY+BrDmsD/nEr/6s6KZsE3g8znl54
         5J/jGSwVuj37L19DiGrh1F6307qMbnwRXNpXBYu/kOabJeBEh9jMlOj8uBZXq16KWG1n
         2s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775220268; x=1775825068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJEQdMR4fTWKEEHbAU4/IQMqpC2w6AVUg71G3gp1ZrM=;
        b=SACgiuy7/UvdZCavW2pqKseA5iSmy/8Q8Zrw/xCDS8LXRiaM2kdcTEflhdut3CSAov
         OsKNrDuWDYZNX4sbwkUWpJHlDRBYsZuSCr3VAWp16ntgjUMmJwDmJKOFdPhiaFGXjBoW
         sjH4Ze/PBjct4AO0D/x+0n8gqndNIo5SlzRxplAOhORQqynThKoKcA5z/rZQtjakgMu1
         IQtDAzf/xxSEEsN6dGHC2X/Z7N6D7NUh7veotFjypvN0ru1X3lWpcMDK3iB0Ubpaq6kj
         yjIeyldBFPj2X0WAjl7hsK5/zvriXpVZThjjvowK+9RdLiLG2umYg9I3hjcMbkqrklbV
         MmVQ==
X-Gm-Message-State: AOJu0YxsG6xHNOV562VvkCOaky+Vu/4QaFLwbVAjN+4TqVbW0EOokj4M
	1sebeAF4tIKpZWbNFdhNdFjVBDeEJFdFEw2WcXEP84fhHXJ9unKPuacqdjWP1sRYZpM=
X-Gm-Gg: AeBDieso0Y+d9cTXx3xkPRCwtEall4FptR3VeBmAHfjFQcTDu/BTeTsDwTOfga3LYkM
	aBoaDqlVwI369EvmXGpd1h7dJldMsnYHkXK7z4pjKq6nAZYTCu24A5nanwgdLHBaiLxcbx71Co+
	cKzpOXXeLngaGKt/Jp/o+A+cceIxx3vu8U98SCDuygQt7leV9Emyda0/huCCBMUgS2iGr9P4ALn
	ps6YGTj/JIbb0QDfFU9Qb3FL7IThgxacB2NXJ4aieCy8jiw/W5fFI08NXSKbWRvEfDwYlyfixHB
	lqdTwHFpzCXjyEce/dWMaswTEv6QGxeVxkjl+mOZ7dOhXM6uiIv9/2ETz7lOnlBS5W9xgmNXrtL
	8qpkTijrDv6ODx46W4dNcKHQ7IUivtY15SaM6HXBrwPg3UFBXBX3rw7X5xPUmCD1DOWJkbOJyQZ
	4a+cdXwzTF9xkSrASlWrNqlh2xKP0OgHl5MTt+dmQQyK3CWl9Fpz9yUGepFbeOybzGTAGE
X-Received: by 2002:a17:90b:1e04:b0:35d:a2d3:5c31 with SMTP id 98e67ed59e1d1-35de6a01c54mr2439273a91.29.1775220267800;
        Fri, 03 Apr 2026 05:44:27 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f52c8sm5463525a91.5.2026.04.03.05.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:44:27 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	menglong8.dong@gmail.com,
	varunrmallya@gmail.com
Subject: [RFC PATCH bpf-next v3 0/3] Upgrading uprobe and kprobe to their `multi` counterparts.
Date: Fri,  3 Apr 2026 18:14:09 +0530
Message-ID: <20260403124412.37449-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC patch explores auto-upgrading standard uprobes/kprobes to use the
multi-uprobe/multi-kprobe infrastructure when applicable.

Background:
The BPF token concept allows privileged operations inside non-privileged 
user namespaces. However, attaching standard uprobes and kprobes
currently relies on the perf_event_open() syscall, which is not BPF
token-aware. Multi-uprobes and multi-kprobes bypass 
perf_event_open() entirely, attaching via the bpf() syscall instead, 
making them compatible with BPF tokens. 

To bridge this gap, the goal is to switch SEC("uprobe") and 
SEC("kprobe") to use multi-uprobe/kprobe under the hood. To maintain 
backward compatibility for cases where singular uprobes are explicitly 
desired, this patch also introduces SEC("uprobe.single") and 
SEC("kprobe.single").

Current Implementation:
The decision to upgrade is made in `bpf_object_prepare_progs()`
(According to the feedback received in [1].)
If the kernel supports FEAT_UPROBE_MULTI_LINK,
we intercept programs with section names matching "u[ret]probe" and change 
their `expected_attach_type` to BPF_TRACE_UPROBE_MULTI.

A similar thing is done with kprobes, but I had to add a new
FEAT_KPROBE_MULTI_LINK to the kern_feature_id struct along with it's
implementation similar to it's uprobe counterpart.
This has been tested to work with an older kernel version (5.0).

Just one selftest had to be changed for uprobe but quite a few had to be
changed for kprobe. The decision to change them have been explained in
the commit descriptions.

Some Observations:
- Earlier, I noted that uprobe and uprobe_multi are equivalent. I have
  found out that uprobe_multi does not support versioned symbols such as
  those in `tools/testing/selftests/bpf/progs/test_uprobe.c` like
  `SEC("uprobe/./liburandom_read.so:  \
   urandlib_api_sameoffset@LIBURANDOM_READ_1.0.0")`.
  It has been noted in [2] that this needs to be addressed. Until then,
  I hope we can keep the exclusion of versioned symbols.

A question:
- I had to change the `get_func_ip_test` selftest to `?kprobe.single` from
  `?kprobe` due to offsets that were added later (after prepare_progs
  ran). This means that anyone using `?kprobe` along with offsets will
  have to change things, which is not ideal. Is it alright if I exclude
  this class of SEC_DEFs from getting upgraded ?

Changes:

v1->v2 changes: All suggestions from Andrii's review on v1 were made as
well as support for kprobe upgrade was added.

v2->v3 changes (v2 at [4]):
Patch 1 (uprobe auto-upgrade):
- Use str_has_pfx; fix uretprobe.single handling; simplify cnt; 
  drop temp arrays

Patch 2 (FEAT_KPROBE_MULTI_LINK):
- Use E2BIG error to detect if KPROBE_MULTI is available or not.

Patch 3 (kprobe auto-upgrade):
- Create upgrade_program function; use str_has_pfx;
  add warning instead of silent fail on
  bpf_program__attach_kprobe_opts(); drop BPF_F_SLEEPABLE check in
  favour of [3].

[1] https://lore.kernel.org/bpf/20260212152013.17351-1-varunrmallya@gmail.com/
[2] https://lore.kernel.org/bpf/20260330110019.549079-1-varunrmallya@gmail.com/T/#m349cbbcf700d1edf0419997d14bc76dd30eec50e
[3] https://lore.kernel.org/bpf/ac0hLyMuPHiZfnVc@computer/
[4] https://lore.kernel.org/bpf/20260330110019.549079-1-varunrmallya@gmail.com

Varun R Mallya (3):
  libbpf: Auto-upgrade uprobes to multi-uprobes when supported
  libbpf: Add FEAT_KPROBE_MULTI_LINK feature probe.
  libbpf: Auto-upgrade kprobes to multi-kprobes when supported

 tools/lib/bpf/features.c                      |  38 ++++++
 tools/lib/bpf/libbpf.c                        | 114 ++++++++++++++++--
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/progs/get_func_ip_test.c    |   2 +-
 .../selftests/bpf/progs/missed_kprobe.c       |   4 +-
 .../bpf/progs/test_attach_probe_manual.c      |   4 +-
 .../selftests/bpf/progs/test_fill_link_info.c |   4 +-
 7 files changed, 154 insertions(+), 14 deletions(-)

-- 
2.53.0

