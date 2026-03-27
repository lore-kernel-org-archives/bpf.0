Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8FC381B1F
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612082; cv=none; b=QTlH2drBd8rB9b66OwoXUXGTIBWlLXPDXxxqyHwqjsYXTJfRib2SO4vYJB0tBxGWEVSk+pegrS6P5WYegY9vlDhBoHLCfZY6kMeUqK2RiQyZyRof+jZObEUcK0mm+kaHVirsvTbsI0DnrLvotDEdWnMeWrpB0QN9juln6rrg+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612082; c=relaxed/simple;
	bh=6WqNWUbqfb7HlONn5CrSW8B/8IlYYtTlhCxhq+oa1jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nxyB1RlUlwC9VUOrfN8emnSSSz+aFep2cCjny20Dgflq4iWwRlhHIp1N20AYPKXn4jM/7C7ToD0GYQS81DrFAgvGT5sdqc/nD+4p1fLvP2VxOBoc/XnRUva2vUh7gOoOjMEjWm9+SdowIk9+YrZHIKEEwuDwpQUp+EVG89wPcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7xUpI35; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7xUpI35"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8298fad2063so1200990b3a.3
        for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 04:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774612079; x=1775216879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNMzj7FR5eiPcLDxvC3wno+fgNRRz7YkO5bQ1NKOas0=;
        b=s7xUpI35hFW1/JcJzVHe/JJ5Z3quTAzrKUzmUQP9Q6UBTzstOBlGOZgNnqQLLOrNrv
         eNOHVCxYEl7E+Si2lh83He/8VUDlAib16fD1K09Zx4zQci+qPkKv6j+Jv7aot9rWmCY3
         xOb86nBPP/R6z67halz9bF0u0wIvdQ+koSRITuukP5P+Kdoy1qw7CtkD89SB8tc6lleU
         eZUGk+IlX57qGz9DhWV3C07AAMpH9NlaDb/aj8rLDYHAWaO5JrDjEgGyHg0DuhhKBtop
         +I/QtdOr32bWQ+PLHBbvbwiagkfQeW2zcOFXfncLHtYInM4LqxxKJEQMjdRgr/FyV1q7
         UcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774612079; x=1775216879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNMzj7FR5eiPcLDxvC3wno+fgNRRz7YkO5bQ1NKOas0=;
        b=CAts0vzClPsOe190qRUAWdzpMz6aeh4CCtRKa+QhbTiyugPlj7WSeu6I7cREJXFkxj
         8bo+23am0xZ5ZliYtefr91cQ2aUuAeIG7S1Yldf8dd+UITpj79r3iAFcdRMqgQBVoNZj
         V30t9L54jy9ZXVOl1u/ionlDOg0vTaSbNw3MwHy896jVr8kDLwPe8vHuYdBh/NcopTk0
         OLixng9SA+/+ungDFyPVOoyEFsY/CHqKpjYI6fX5cr3o4EL5j+1q9aaOPVdL0FnzI8RE
         DZXfMkb5KllXhNC61b7h1MS8WTRAvaa6za576I3/qL588vxxcAtMwkctVcGGtmhqIZ1E
         3BFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJoAK7XKVRBu2ODW0owXb6csZel5ee8a0JF2aE4BOoTY/7M4iOl5EBXkW3aidwo7J0pSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygyEyLLrHymZuiGgyVx00YN1Io5Agwm3xcnGLxs2a/OBaoa9Uj
	cimuNDFL79861XLzFOTUFG0APS4HfAAR4yCg5YiOfHuuwLM0fgp/w2zNpYZmHg==
X-Gm-Gg: ATEYQzzak90/rc4/hxCzotUDDaiDp9/zWbLPrx3T+gJJ4iq94J0deu0uYnv34j0LGc8
	Afunc+CTH/pV0yHwXgnyWLutOaSR0aPvUoDdGkSGYlKKnk8FCfFdR2of4G+HWsp1uhGKc+rUFz2
	qLs2UI5j8qkvVib4X+AGrUqmUQdRmIB9AQbGEKQ2l2tNSDtw3BNsY+9aQoWH/7VMrN0djImlu6J
	DnHsD7k5m7Ly3VEVroPn5k/YCttVRC6ShihggfHP5HzuVOY9T1THU6PzSXmjt6X4/qDsIcaGRSX
	3bxSe85faevTkXdwh7mP9IoGk1Cp9F1oGcDKqpZUAuDVXWO4a9l/XAv2fkXQwBls3nteCIXCXwX
	u+uoAe6XuO2/u9upkX5T7/hqHpKgypfO3X85MIEOzPTI3GuVURvMSR7fP69gA4hk4XyM7/LsUmo
	4ih7ckXqP9B4bCZ2C1i82+E3cIRSOhBySCH580atChLvVhiJqXpohT2O+2JOcAXanI
X-Received: by 2002:a05:6a00:600a:b0:824:a706:bd75 with SMTP id d2e1a72fcca58-82c956c2ef1mr2401030b3a.0.1774612078684;
        Fri, 27 Mar 2026 04:47:58 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d3c289dsm5235572b3a.47.2026.03.27.04.47.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Mar 2026 04:47:57 -0700 (PDT)
From: Chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rust-for-linux@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [RFC 0/2] block: Introduce a BPF-based I/O scheduler
Date: Fri, 27 Mar 2026 19:47:39 +0800
Message-ID: <20260327114741.91500-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

I have been working on adding a new BPF-based I/O scheduler. It has both
kernel and user-space parts. In kernel space, using per-ctx, I implemented
a simple elevator that exposes a set of BPF hooks. The goal is to move the
policy side of I/O scheduling out of the kernel and into user space, which
should greatly increase flexibility and applicability. To verify that the
whole stack works end to end, I wrote a simple BPF example program. I am
calling this feature the UFQ (User-programmable Flexible Queueing) I/O
scheduler.

This patch depends on new BPF functionality that I have already posted to
the BPF community but that is not yet in mainline. Details are in these
two threads:

https://lore.kernel.org/all/20260214124042.62229-1-pilgrimtao@gmail.com/
https://lore.kernel.org/all/20260316112843.78657-1-pilgrimtao@gmail.com/

To try it, you need to apply the patches from those series first.

Note: This is still somewhat experimental. I have only done basic testing,
there may be bugs or security issues, which I plan to address in follow-up
work. I am also looking for community feedback on whether this direction
and the implementation approach make sense, and what else we should
consider.

Kaitao Cheng (2):
  block: Introduce the UFQ I/O scheduler
  tools/ufq_iosched: add BPF example scheduler and build scaffolding

 block/Kconfig.iosched                         |   8 +
 block/Makefile                                |   1 +
 block/blk-merge.c                             |  49 +-
 block/blk-mq-sched.h                          |   4 +
 block/blk-mq.c                                |   8 +-
 block/blk-mq.h                                |   2 +-
 block/blk.h                                   |   2 +
 block/ufq-bpfops.c                            | 213 +++++++
 block/ufq-iosched.c                           | 526 ++++++++++++++++++
 block/ufq-iosched.h                           |  38 ++
 block/ufq-kfunc.c                             |  91 +++
 tools/ufq_iosched/.gitignore                  |   2 +
 tools/ufq_iosched/Makefile                    | 262 +++++++++
 tools/ufq_iosched/README.md                   | 136 +++++
 .../include/bpf-compat/gnu/stubs.h            |  12 +
 tools/ufq_iosched/include/ufq/common.bpf.h    |  73 +++
 tools/ufq_iosched/include/ufq/common.h        |  91 +++
 tools/ufq_iosched/include/ufq/simple_stat.h   |  21 +
 tools/ufq_iosched/ufq_simple.bpf.c            | 445 +++++++++++++++
 tools/ufq_iosched/ufq_simple.c                | 118 ++++
 20 files changed, 2094 insertions(+), 8 deletions(-)
 create mode 100644 block/ufq-bpfops.c
 create mode 100644 block/ufq-iosched.c
 create mode 100644 block/ufq-iosched.h
 create mode 100644 block/ufq-kfunc.c
 create mode 100644 tools/ufq_iosched/.gitignore
 create mode 100644 tools/ufq_iosched/Makefile
 create mode 100644 tools/ufq_iosched/README.md
 create mode 100644 tools/ufq_iosched/include/bpf-compat/gnu/stubs.h
 create mode 100644 tools/ufq_iosched/include/ufq/common.bpf.h
 create mode 100644 tools/ufq_iosched/include/ufq/common.h
 create mode 100644 tools/ufq_iosched/include/ufq/simple_stat.h
 create mode 100644 tools/ufq_iosched/ufq_simple.bpf.c
 create mode 100644 tools/ufq_iosched/ufq_simple.c

-- 
2.43.0

