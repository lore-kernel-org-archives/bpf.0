Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C983CB2FC
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858174; cv=none; b=Pd2/ZCd4FFrLcYXJfHK+82RkpvCd+ox+eBBl6ZbtmExYt2YW72urDTW2QqhInYWnj+c6OdU3gBVAFm/taR49Qrlq2V+Nm9yqxclWBIbHgu20fe+KAZKEYD7G+5OOYxlSRNmYlu1K+7fIwNUKp7/dI9A8sM8WJBz/sO9udTIU1OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858174; c=relaxed/simple;
	bh=8PmVyxQmnnEiS1KxO/fEeLK8LEKexDtIgCORnjyk6tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYN5Ay1Ra0zSCFqk4uwXiEJzQcTgvIJIXBtJl3pntU6xRoWD6cXsYUzHBDr5O+pHUoJSLykQvD+2Nvg1j4X5ztXkYS0PwqCFVN9AfMDQVZfEtd+dlUXm2IQMkxDqIEFSGzUgGyE33+B5FQxwA5f/zy5Ah3m08DlDmjH9BnBQsSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=eEILS7a0; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="eEILS7a0"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651c36a7ee9so1588406d50.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1778858172; x=1779462972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKFizhLjRF18dIH2oJNICiOfhq8yOlJciPdatJOILtg=;
        b=eEILS7a0PD8Q9XvNQDnKKw1N97OdbdtPQ3RzGLXwj1ldbP3C/CVYZrCOp6i86i8ENu
         xRm7kWa0LHvblNAsASl32Tbmr5aAg8zxUdeMjfI0kPx+BmXHfwXu+sbprW3/xm1VfpNJ
         6hFuMMnHEyDuAAI9tz6B0bHaUIc25Iimk3jF4eyZZNUp5PfbEq+nhVjooz2lZ9/cuUYI
         rW/UkYHQJWFAuwNjrOueHdrXJUSD+AbJ1emiIJXOc4mSCWvton1YpTK+S+xDtpdFURox
         Zjw6EZuT40oE5ZZ6YRpOf8qEwuoZS8iVdRV1kHIZyiHQregM/pIEpFAXEf5scXbRrSys
         27uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778858172; x=1779462972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKFizhLjRF18dIH2oJNICiOfhq8yOlJciPdatJOILtg=;
        b=lbvkTHSulw/U7+DEjK51Pdg9OSiAD46hbMnsjvLlcbXBiKg9bcESFgqXxwAVl0aYIm
         bkITqk/Pjg+OTvV/sGZq7fIQ163TEUjTiYAOl1cg505KJcjfswxmLcWV2WV+XtPm0O8Q
         3XwZ/LYQrAteVUzuhn/+XlZDcJtAj1REGJdtgsN307y31Z0tkDIB90l5Ko0Czx+3N8Aw
         89O/W/xTecVZiUx0KlD3Se021B47ewvFIKxEkoe8ItTNpo4qLgAJ3Ii9wq2b/sKRqRBG
         2sWldAogLA7jB3abWYVIsuavgK/ANs3QO/sqCTo2+Q8VdwWZ6qFDoHi1+sT3Gc1MtyWm
         qZWg==
X-Forwarded-Encrypted: i=1; AFNElJ98EJxCIXK0QpHKGrapywFHEJ+nddKpr3vZL8n/28mi2oUSDWTpIij/oirMv7F0vRcZl3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZrPeCmwokIi6F5LsEUTNeZsw4GGx+7xQJKvvNuaovfBTJMOh8
	CXHEYBN8/DqBRUjC4p8pF9bk0Q6pgebCFFe3pW21AuGZ79x4huRAFJfX5KNmtaHFnv9h
X-Gm-Gg: Acq92OGKMehyQqC83AVYAyxJnivOf8bkyiBQpE/B9hrtCvhX6wAz1A4qrJvYCpVPf+F
	oZfn8FAxjJH+HoL8ED5tPC9650vjvQyAUMW/rT1uKnDanKQ7T18AcNUauExrv4fe1k3ndMpCCpz
	NXIrIdCDJ+5vqFP3XOh+Rg257qshvB4I1glDzS8kq6GFkOVavmv+Pcop2p4mZx3HRWmG0vWGjW4
	4Aof84VMP8VfwL0YwgwO+UphBa8NTvU+CLz2v6AAEKq5ikwAYcJpHrJ8VwkD7LT7HVkj0mJMQj/
	31hjJSlPGpJjghkJDAozYSfQpEclXjZTxwBvF6lVOJdvuXwn/sQ2kA+dqKYeUulHtTSvBWXZfyq
	GR10lfKHBDi/Q3s5eJtvWHz/vrdvevL4zvDtQWbtpsIRx6MMREu66pbLBqo9/f/JdPfOZ8xoPSw
	nU3BWJWgDFEG0n4yO03D2+NOunqUsz5bU3ZTn9SoMdcLvfjjTYUVHW3kC8tY51AVqNhz6j1jw9Z
	khS4ydTDVv8xic=
X-Received: by 2002:a05:690e:134c:b0:65c:27b5:414c with SMTP id 956f58d0204a3-65e2281c6c2mr2570464d50.5.1778858171353;
        Fri, 15 May 2026 08:16:11 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d878cf2sm2724116d50.2.2026.05.15.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:16:10 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: tls: fix async BPF split record loss
Date: Fri, 15 May 2026 11:15:54 -0400
Message-ID: <20260515151556.189841-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes a kTLS TX bug in the BPF sk_msg apply_bytes path when the
selected AEAD provider completes asynchronously.

tls_push_record() can split ctx->open_rec into the record being encrypted
and a remainder record. If tls_do_encryption() returns -EINPROGRESS, the
current code returns before reattaching the remainder. The peer observes a
truncated stream, and the orphaned tls_rec is leaked.

Patch 1 keeps the split remainder rooted on the async path and lets the BPF
verdict loop continue draining queued records while preserving the async
return signal. Patch 2 adds a regression selftest which compares the sync
and async providers for the same BPF apply_bytes split-record stream.

The selftest fails on the vulnerable tree with the async provider receiving
12916 bytes instead of 17312. It passes with this series:

  TAP version 13
  1..2
  ok 1 sync provider transmits split record
  ok 2 async provider transmits split record

This work is LLM-assisted. The static-analysis variant hunt and
async-boundary state-retention class sweep that surfaced this
candidate site at net/tls/tls_sw.c were performed using Codex
(gpt-5.5); the writeup, patch refinement, and this cover letter
were performed using Claude (claude-opus-4-7). Hardware validation
(QEMU/KVM kernel run, deterministic 17312 vs 12916 sync/async
byte-count delta, lifetime-probe linear-leak scaling) and operator
review at every external gate were human-driven. Methodology
context at https://northecho.dev/posts/codex-vs-claude-code-vuln-research/.

Sent to the public list per the security-bugs.rst exception for
findings trivial to discover via automated tooling, as interpreted
by the kernel security team for LLM-assisted reports (Willy Tarreau,
2026-05-14, IVPU thread).

Christopher Lusk (2):
  net: tls: preserve split open record on async encrypt
  selftests: net: add kTLS async split record regression

 net/tls/tls_sw.c                              |  29 +-
 tools/testing/selftests/net/Makefile          |   5 +
 .../selftests/net/ktls_async_split.bpf.c      |  24 ++
 .../testing/selftests/net/ktls_async_split.c  | 391 ++++++++++++++++++
 4 files changed, 441 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/ktls_async_split.bpf.c
 create mode 100644 tools/testing/selftests/net/ktls_async_split.c

-- 
2.54.0
