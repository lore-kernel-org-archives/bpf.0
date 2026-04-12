Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB482F5468
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002839; cv=none; b=reP6tXTOzZumd1K0YGeRZw1L8mYWzGmm1+qKCb+3T29Fb6+2p9RnlbnMyJhwyuBoTWh1WwgdiWOisgDEF0MWxsOV6LL2MpZ/YJiOAOzezL0mZmrcViA4trRB3DcgXj/6zVXH8lZKMtJw9zI+f9NUK1kd2vH6DkAmY0xWqAFIJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002839; c=relaxed/simple;
	bh=biK4/46PkQ5RvKLhaFzZ3Xo5Fug/l/bBy44rAxgQDeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vj2/WTpX1oLx2h2Gu/DZgLKCgOnQxHEdvF0RXDGyl6rvEL3hgk/hqnziI6Y5JxP6mg7BvgrU3fmVqUZAhlucSW5JsJEgQc27o8zgwxIpWBWX12nLhVel0YgN6qgfVDRWqMdb/DHeUOgoXz+7Qa+q/kfOmmBW3h8UmXnUJfPD80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+xr+4x+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+xr+4x+"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f0fc82c76so779126b3a.0
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 07:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776002837; x=1776607637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXrXNC1aozfRtChEJXwvaRmaFJMgiOHIq/Eg3RJfA8E=;
        b=o+xr+4x+Z7KWeZQNJoX0WUneFVVFnf9pAsXCR7DKPA5fOEIui5u30SlDSg/JtwpgE1
         Wp7F98Th3X5X8P222PAFOz1tlttVLQt1wg99I7MN/kup8+rypOJxgFojyj30xRJs0jOE
         Nd59T6yFjRrHFAx4P0OnaOjqEx/14sxZWmHupzrn8S1DpyZXwO2Hpfaw1trOgNIGU2CB
         xNOC+Eprn+TJuw11RYSsiPqvJeu/TkcVzy70JQxSVlwmpU7bZo/wit7ZmhbkVaV6Fm8r
         NlhcmW+yuMjkoOv710Hq+va7bTFAPH1gNMH38ZOyGDJP2S1IWjqpWVn04Q+iRwZpC0Dm
         kIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776002837; x=1776607637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXrXNC1aozfRtChEJXwvaRmaFJMgiOHIq/Eg3RJfA8E=;
        b=qLYhdImv7J/dpVzbCzWRFC27d/mcvAke/0rqB7YC0vxeodI3BtPdyu2JUwD5MxJFyQ
         bq+STuPV14cKgqEZTklaO70zSSn6EMN9EM+kkfpKmJjpghHgYeHPfdmqowa6kMiCWJeL
         4jVMgfORmGcVkU8K0gcfoIkMNg6caMUQ+BTfLNqz13qoYpy/HZ8c5OVRNNfzdeDtg3XM
         l5aQsucAFLsWxPlmDowgE/WjG99coR7r3Gsm9qyZUeL7TTkAmgF+gyZAQamCkyQD/Lds
         96bQzBmfq54ye7wiGVMmS/jY0elckf9QTmV/muchPvRzon5kqWJ9aYSJAwoq2i93+/25
         zR6g==
X-Gm-Message-State: AOJu0YwjYHtTaSSnlG3dquKzTTavHRgnBMsT/OAlf4mi3K3JhXkblIRT
	a0nSTbrUsorbGUOFzG3miK7xoJozMTS2q8nz0tASoMpSlI5PIt0WFiy/3SvJ+w==
X-Gm-Gg: AeBDietG9hvMyxG/Uy6n6/RlXltms2sL2sgszIYvz0zppML5T0Tt5CpxMZVUmUZYM67
	GS4f/8Y6j1Vg+Xut8xWmn/hhf5vdF8PxRHb34x9jOSDuxNACJFErIVoz7NELNymNLfvV7HnLTyP
	TrflNYfZIU9XOj7GC0jD5lO26PTcMlLPFyBueFhyXGZSTTXmucK6/7/WCNpQHrY2CU68obu0Q6B
	pKV3ZbeWlNNCjRxJ5bBJU65vIcfZTXkpLMlP37kw7Naup1BqAHT8alJCqch+d+UWOxv20w2udAi
	x6jCJF845/oI96mUT3XQEUUoPe7WcbX3dqV3mw4qYdDuE92nT1cgiRlXMldqKupBbb2h0Z+pzdK
	S9A7Af0g2BqqNuvVC3TN3AbFOeKi9qK/Zorc5IUt6H+6HiQymbKvF8mVve2fSD+fjcGJSWI7N67
	QU3rMNHD+hZJSSGjAEY9mn8K5RBdORrWmGX8/xGWx4vXeStzA6zZdbnJ4qBoXMzIbTAQzpiHzMK
	8H0N47QfcI0LJuVFDSNzNxgdNVEpKoHBtTGDhMNTU1n0PgLBeOBYM2WBkd6sw==
X-Received: by 2002:a05:6a00:2183:b0:82c:7f08:8826 with SMTP id d2e1a72fcca58-82f0c1600dbmr10770634b3a.17.1776002837147;
        Sun, 12 Apr 2026 07:07:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c50a8f7sm7946812b3a.56.2026.04.12.07.07.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 12 Apr 2026 07:07:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v3 bpf-next 0/6] bpf: Split verifier.c
Date: Sun, 12 Apr 2026 07:07:08 -0700
Message-ID: <20260412140715.30423-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

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

