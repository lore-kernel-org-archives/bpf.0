Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914632D0D8
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778369700; cv=none; b=K/c/HW8vCYPtJ9di02W4Kqj9bwY9TA9oMxEDSB/O5OoO+05h+K5bnyOP588SYduxdj87Qk7ahLeCo1o5hGo7UV5pU1XuuXrKl1gzNtqmUV+L0efBfpq9uq1Eqtz8cEtkgE1JqNqz4au30d/7c4v8K8GztYGjvGFP0wtWv1kOtUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778369700; c=relaxed/simple;
	bh=JAYJ5MK6iRducm9mWgZFRrVhxXE//jwxDFTteuMVW98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvlnRz0qE3j+pO/kgA7oGGhFKk1N8iQLC+vo0BHpfsY+lAZQSQBGNqpeiyiJJSLqMU/DCmhDK463EgsCq5QNB0sxWZ2PQLp+okajwzQPtzgR5GvxqfCFKmrBUtow44WbaPQo9M7AURD3n541CpTwqWw7EHERr9guOrVr3Yo0jVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkE7xPXV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkE7xPXV"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8353dfdad62so2344291b3a.1
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 16:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778369699; x=1778974499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQI247T5wbObzCF3WwIl+l5yBfadYry9qpXCePD3xRk=;
        b=WkE7xPXVuCI2hUPEsJjbq4mBbmFJdHaA0lY5jGCDT+hfMu2wEdH46b9M+F6Z+TVfHU
         VERzdh+XG3sM1ahMaTSDlVlBENhNDyecrwFV1jKn5k22zupfQhIHOWNSeGIGpU2R02vh
         zPCW2WAqaVKXAI7WqSBRrQAF1oIu9Mh/mK5DTeBxyTTKMNGD0zM6Na+ytXTgiOhzbHrw
         /szm8sXF/YvbHhGi5aNdADIDzsiZOUkvFI/OOzI7fHmk4qIepvjcPnaJJ0xTC8pO1L2z
         unap5bRseQgb9PuVcICljgMUoKRlHNLYwnhu9UEwRzo0tJgBhDofcWYSHRNBE4GnB09R
         Iyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778369699; x=1778974499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQI247T5wbObzCF3WwIl+l5yBfadYry9qpXCePD3xRk=;
        b=jc63V1S97/DyP3bNaYP2CJJ6273U1OKFLMyBPAAnC7IzgoOHj+ZpfG15A3c43lPU/0
         0np4BBhiyHfhYdrLAccK3OH4HFfd/KBLTJm7QSbdvGTcqDy7b0foBEdHbL8u7ACbFtoV
         wLj+o7SfrdwfdXT1AmY/GTbDsU8VaPEsr1aa1KKWSBrF57N7TYYwl7tWsKuMjgwLREJI
         6e6rE8vOVQ6pnIpsMhUvGhxqUM0UGLwO8HOCKodIrDLYEXCftkCUD4DFOtCsKyGmMrru
         0Nt+xVITv6UolB+qZRezg+2CqI+bxqrLA11360O7H6JWZIljRx4o+GpmzCMtVFtqZBJU
         pYcQ==
X-Gm-Message-State: AOJu0YyuApRR4T8WWX65hH1h2qxOK7TE+ie6Z+fSM/9Fe+l8SoN1A3ux
	RddQT3lCHoG9YV8v0VSNq7wWtPtHnxnQ/biSBBQhZmhcy11YlK/mU1rL
X-Gm-Gg: Acq92OFtyJoEUJ+c40jFh/o0YFcpMsbOufxmJqG3a+4uNF+K4g0/zKJDS6NweeGabp0
	e1aMqbDKQ9/weGq2vFknIKq4FgH2G4qUFgXRIL/EQnClwVoY3HJzGASklgUoLDsJjziKeV1pU/5
	B5zUN9mragoNd9MZYZ3gADnS4ql2QcHY8jGw9dmMQ+MLp1T7X6sdQ0kNPKiFNRDTQxTS9itOnAU
	MYxyELKWlyuPCY/0GL+f3KYGajoCSjUl0KfypqBTYDkHZTqtgTAHg5H5khWtA2VSSb2RX1r/zru
	R1pTD9TPOyUVzlyiJWc2gY0LMhSr6RUevyyEdUZRYcS0WjhXlRi/glQ7yb7nTSwWDERB1zUdruV
	nGkhvIrMhpyIhfRAggWNwUf/QqRw4ZK6V/e3xdjo/6XFNvLNEERH26G5J+RQfi+dsq948IKvjFW
	y/KbZGzTObdA2tp13KSfc4FBBIGpqoy8UYvjO9us/zeVe8r8lzxkp6g1H+t55pbc91rqLcqepij
	1VBIMwaI/C7WSzJ4VuqbB9GAV3Ek22BZoIt9YGiIhMmZhjzNpe3iIPsU3jlpQ==
X-Received: by 2002:a05:6a20:9392:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-3aa5ac27026mr19067689637.50.1778369698743;
        Sat, 09 May 2026 16:34:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267710262sm5326504a12.18.2026.05.09.16.34.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 09 May 2026 16:34:58 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [GIT PULL] BPF fixes for 7.1-rc3
Date: Sat,  9 May 2026 16:34:56 -0700
Message-ID: <20260509233456.39703-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit eb5249b12507246dc959945454cd1be8d7dc3795:

  Merge tag 'parisc-for-7.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2026-04-18 11:37:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 3ac1a467e37683f602221e243fa3c59b0de81165:

  bpf: Fix off-by-one boundary validation in arena direct-value access (2026-05-09 16:18:39 -0700)

----------------------------------------------------------------
- Fix sk_local_storage diag dump via netlink (Amery Hung)

- Fix off-by-one in arena direct-value access (Junyoung Jang)

- Reject TCP_NODELAY in bpf-tcp congestion control (KaFai Wan)

- Fix type confusion in bpf_*_sock() (Kuniyuki Iwashima)

- Reject TX-only AF_XDP sockets (Linpu Yu)

- Don't run arg-tracking analysis twice on main subprog (Paul Chaignon)

- Fix NULL pointer dereference in bpf_sk_storage_clone and fib lookup
  (Weiming Shi)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Amery Hung (1):
      bpf: Fix sk_local_storage diag dumping uninitialized special fields

Junyoung Jang (1):
      bpf: Fix off-by-one boundary validation in arena direct-value access

KaFai Wan (4):
      bpf: Reject TCP_NODELAY in TCP header option callbacks
      bpf: Reject TCP_NODELAY in bpf-tcp-cc
      selftests/bpf: Test TCP_NODELAY in TCP hdr opt callbacks
      selftests/bpf: Verify bpf-tcp-cc rejects TCP_NODELAY

Kuniyuki Iwashima (7):
      sockmap: Fix sk_psock_drop() race vs sock_map_{unhash,close,destroy}().
      bpf: tcp: Fix type confusion in bpf_tcp_sock().
      selftest: bpf: Add test for bpf_tcp_sock() and RAW socket.
      bpf: tcp: Fix type confusion in bpf_skc_to_tcp_sock().
      bpf: tcp: Fix type confusion in bpf_skc_to_tcp6_sock().
      bpf: tcp: Fix type confusion in sol_tcp_sockopt().
      bpf: Free reuseport cBPF prog after RCU grace period.

Linpu Yu (1):
      xskmap: reject TX-only AF_XDP sockets

Martin KaFai Lau (2):
      Merge branch 'bpf-reject-tcp_nodelay-in-tcp-header-option'
      Merge branch 'bpf-tcp-fix-type-confusion-in-bpf-helper-functions'

Matthieu Baerts (NGI0) (1):
      mptcp: bpf: Fix type confusion in bpf_mptcp_sock_from_subflow()

Paul Chaignon (2):
      tools/headers: Regenerate stddef.h to fix BPF selftests
      bpf: Don't run arg-tracking analysis twice on main subprog

Weiming Shi (2):
      bpf: Fix NULL pointer dereference in bpf_sk_storage_clone and diag paths
      bpf: Fix NULL pointer dereference in bpf_skb_fib_lookup()

 include/linux/bpf.h                                |  1 +
 kernel/bpf/arena.c                                 |  2 +-
 kernel/bpf/liveness.c                              | 25 +++-------
 net/core/bpf_sk_storage.c                          | 14 +++---
 net/core/filter.c                                  | 55 +++++++++++++++++++---
 net/core/sock_map.c                                | 39 +++++++++------
 net/ipv4/bpf_tcp_ca.c                              |  2 +-
 net/mptcp/bpf.c                                    |  2 +-
 net/xdp/xskmap.c                                   |  4 ++
 tools/include/uapi/linux/stddef.h                  | 26 +++++++++-
 .../testing/selftests/bpf/prog_tests/bpf_tcp_ca.c  |  4 ++
 .../testing/selftests/bpf/prog_tests/sockopt_sk.c  | 17 ++++++-
 .../selftests/bpf/prog_tests/tcp_hdr_options.c     |  4 ++
 tools/testing/selftests/bpf/progs/bpf_cubic.c      | 14 ++++++
 tools/testing/selftests/bpf/progs/sockopt_sk.c     | 16 +++++++
 .../bpf/progs/test_misc_tcp_hdr_options.c          | 15 +++++-
 16 files changed, 189 insertions(+), 51 deletions(-)
