Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CDF4071C8
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780864271; cv=none; b=awRb6NfA2A35yh7j0hLvUCrgJ84VXNrknYnM8XVO7mLsc/wUwGdfhRhs1wJ92DMdXSGiQMdM6Xc8wg2raJCdWhduZvGFXpjjF7TkJOWdR85zXuXtbfUhFPPa1BQs3UvCfGf2WZS9YAKTsUuNL61cb9nXGqV7Cr2+TwXlbLIXb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780864271; c=relaxed/simple;
	bh=IO3EKsw65alZtEKRz42IqnJDtfbXg1ILDUkSFeJBwKk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oIz8lEImJubp0OjjxRSd72V2/Do4bFKE2uzbi2P1tqEj8omO8XeboX5QVb/I2SMBySmLiqvtMHtjHeBi4s1MdwITvgbbkt6tZ35F40q0SeTRVF5X22N1b0H6uZ5t7fsToEXzpa48gwqLif5gNqiCqP0dIe2eytOpYtzwlEye+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecuKNRGN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecuKNRGN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so39905535e9.0
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780864269; x=1781469069; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ivGp36rvD+/M1uBaLXebR9k8s/1gz5Gdnx8CU9MZPIk=;
        b=ecuKNRGNKldSc029BSX4W6YVgZB1XQBOW7FrNOLqAZMcG3iEnBg0FD58NTysvgo5s+
         ZPfaAUiXjUE67Kcg4tzP9V/bHXI3cneTY4zhR6EgpWB9hDxlO+RMWf+jFOjwZe8M/4pB
         +qtFZ/PPoxp3Osj71E8Z2OjhBxDTsKgr7JiCFuxfBDKOqPvJW8dQDql46Zi+Xb13+wyi
         oJ0m+Ecdp6Ue4FP23f5Y5F4trP0sbqEHRa9GAWVo5FJNbFn2V1WmnzfXZhfkRKcpnFQB
         SHs95nU7GbG08+9eqsHKPTeyGoiBC/UkLeZxPST1ttc9NEQqZHFa0CuPNG17gO0vedEM
         Vzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780864269; x=1781469069;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivGp36rvD+/M1uBaLXebR9k8s/1gz5Gdnx8CU9MZPIk=;
        b=aliWQFSkYdPjnu0T4YEjJzWNnoozarSm8npBE62E3/V6jGHJYM2ivAPAdDfsgJFAvO
         8DgNE3kUhKBV5SkymNE+aFzlDBFa+5Nz3+PmP2kbzZakhD5/DNC7rbZHXT3BgrVNNadR
         HznjWR3GAuKzvRFgk1m0XzMzabd3wd1RGZBnzCh6X61ri99EgT3uM91jmfcjCDQjIPgN
         FCESG30UQtHWXAu173cdp0cY5YVWXdlRZ+cm2BoT5WzErzxh2bCsbaqzfJmpXeMfwXdh
         mblKwlLAMhk9zGHuA/9ecJltIYszmIaKwSkLVojvM+rOa06Nk1gJyXXEyZNOkC3ropSU
         QR4A==
X-Gm-Message-State: AOJu0YwlAtK0zYfmVTp6Dv0kSuQh+cJ3vVgQvHfpzNxi8eKBEYucilKA
	xcheQvMjKKy1n98tcP6NVMiPwfnOKsaJoRJGf0Vge1pfhCxbPaRJCgm9
X-Gm-Gg: Acq92OFv8E23zd4WkLtUYLQNO4NjQkic/4zHEHd9pECxqiWWuf1aRYrs3QawToRfeMm
	zkU770Bj+tYX+U75ijMaSEGIveL1qbZ3Hl+/zJp1ON9ZR0DQvcvYN2r/zGBXZmzWL97PtCR+KE6
	NeCmwGT8COuxDk69U8d1Zl5ZGrRT9zv/9k3pLHyVJUrU0SX4E+0J3BRdUR3DehaFEMkblvcCYCw
	0iFM+c1xLPAsUxtcb6hVTRNdfNdiTXKvmucZRPxJMP+BMD3RJBrtbpydv1iyY2byptx91SPeQFT
	Fi3RiRhLRIC3K2SknNlCejnuFBoqpOOgp3GOaQkJk+2eY8AVQtHWM0zvBDfM0XA/8X41TrX5DkD
	5NqPdfQYbq4xNxwhB3z3ghi27BJaczmdPE5Qzud0bCdZWayRelIvS4l5cNqm28VNwSVgCUlbt9W
	WlerSiL6NRxdBk90AMOuW6i/W+DRAjydJIrA==
X-Received: by 2002:a05:600c:19ce:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-490c25dd679mr213789925e9.20.1780864268610;
        Sun, 07 Jun 2026 13:31:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc40716bsm352024025e9.12.2026.06.07.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:31:08 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v3 0/3] bpf: Fix LRU NMI/tracepoint re-entry
 deadlock
Date: Sun, 07 Jun 2026 13:30:40 -0700
Message-Id: <20260607-lru_map_spin-v3-0-bcd9332e911b@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPDUJWoC/13NSwqDMBSF4a2EOzbletXYOuo+SpEYkxqoURIbL
 OLeC+mgj/Hh/84GQXurAzRsA6+jDXZy0LAiY6AG6W6a2x4aBoQksMpP/O4f7SjnNszW8aMm7GX
 XmVIgZAxmr41dE3eBbjbc6XWBa8ZgsGGZ/DP9xDztb5KOv2TMOfLSVERU5DUqcx71Ig9qGpMT6
 dMKLP5a4shrFKhMJ1Qv1Ve77/sL10nQuO0AAAA=
X-Change-ID: 20260519-lru_map_spin-8e20dabbf460
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>, 
 syzbot+c69a0a2c816716f1e0d5@syzkaller.appspotmail.com, 
 syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780864266; l=1697;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=IO3EKsw65alZtEKRz42IqnJDtfbXg1ILDUkSFeJBwKk=;
 b=oYvbZpfOPcvERKRpKEMHRrjXbbKhkOgDrhI52VZqSCLmezbe7aNDTFuY4FbGMB9buUMbTRUox
 9hh2GtW6MWSDvysyRACuaQrFPYZF3hMLcI2bmo2+qRwDOl/N3s+9c7v
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

This series fixes AA-deadlocks where NMI and tracepoint BPF programs
re-enter the per-CPU or global LRU lock already held on the same CPU
(syzbot c69a0a2c816716f1e0d5, 18b26edb69b2e19f3b33).

Patch 1 converts every LRU lock site to rqspinlock_t
and adds explicit recovery for some failures so no node leaks.

Patch 2 refreshes Documentation/bpf/map_lru_hash_update.dot to show
the new rqspinlock failure exits and recovery routes.

Patch 3 introduces a stress test.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v3:
- Removed RFC tag
- Link to v2: https://patch.msgid.link/20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com

Changes in v2:
- Patch 1: __bpf_lru_node_move_in() now clears pending_free only when
  moving to the FREE list.
- Patch 3: address sashiko's feedback.
- Link to v1: https://patch.msgid.link/20260528-lru_map_spin-v1-0-4f52223170cf@meta.com

---
Mykyta Yatsenko (3):
      bpf: Fix NMI/tracepoint re-entry deadlock on lru locks
      Documentation/bpf: Refresh map_lru_hash_update.dot for rqspinlock
      selftests/bpf: Stress LRU rqspinlock recovery paths

 Documentation/bpf/map_lru_hash_update.dot          |  44 +++-
 kernel/bpf/bpf_lru_list.c                          | 165 ++++++++------
 kernel/bpf/bpf_lru_list.h                          |  25 ++-
 .../selftests/bpf/prog_tests/lru_lock_nmi.c        | 243 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/lru_lock_nmi.c   |  33 +++
 5 files changed, 437 insertions(+), 73 deletions(-)
---
base-commit: 245da8192c073820390f7fa1cc1e834b32119bce
change-id: 20260519-lru_map_spin-8e20dabbf460

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

