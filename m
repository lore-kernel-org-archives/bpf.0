Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDE1351C11
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376887; cv=none; b=fe4vjUlbJgTcP3LUgxdPJ2Nkb62WBMbEOiV1H3Kw1HDuzyRZKITrKJTqHeEYNTEEc5DjbdYDIaa23TZ+YfDvvx+JqiDudNZG5voFHLrD6r62n3A6/oGV4RZqwiyHjsCHS0CXx9cQa6PB41HazprIcaJZLPUSFek2fT8HUj+MCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376887; c=relaxed/simple;
	bh=T7/EjBlUDPgtH3+Kc1GIZBy1B9sDSEFQ7NV3Aql/rHI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h/YEEAI0D9guLUgJoQtDbzegJYn6nSjDDMXSwreq0qQNm5ZmmpqkEABhEwmkjEmX8VUezlaQy3+UmZGEopuuZWRGcMaH5ttnPlwVoTokFuGjdS/0FArGJRxZeIUgqMHNO87UFHChUPUyvM6yLVBfNs5RoFycdZoFSCnyhMGc+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWDNffo2; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWDNffo2"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35f1f76ea84so2935798eec.1
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 19:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792376884; x=1792981684; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Crvn0CPXnxp8m2IPqqP47ekZZe12p1wUtU3bcgmL9vw=;
        b=LWDNffo2/ow2v6FEzd7IzT7mnHRpIyunynVNTNlAKecjdon7mBIulAq4bhPkD5+8mB
         ejZ74W45z3hPJtf7iyvNHb3m1k61EA0pYlzeyY6KQZHpPqk7qU+Ng++GmTf+OHqq4isg
         6V2jstg59phhl2G4AQo0+xkNDR5f3Ow9Oh4vQrkj0LnRLIwnc5Xfq68dnQ1Rdp2ERxtt
         fQqxjmaWx13cU1pJ3IgJTqqWgZuv2P2R8Wdx41YNoZeTUSmFkK2d+Qvqbx23cVGNI/LZ
         g6EuJc+Lw3IRZZiS05tajJFd/6l4C1afjNZk/mBKn1SwrYAX8+qwddUCf47A8oNnE0KN
         JGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792376884; x=1792981684;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Crvn0CPXnxp8m2IPqqP47ekZZe12p1wUtU3bcgmL9vw=;
        b=N+CtuokwRPRvimaAIXvfxrOpOP3cN99vVb3/W7mOSCj0EWAScl02VIWysLkQc4d/Vl
         mw9ye0dUzqp5NRtHqQ3rVvGGyTCIrTgvw7qqRwHin8CCggDirVvyz9Y0HzNAkfMBkIV2
         xZX59zMrFspdbWCzbE7kK5XZTn1wmiZT6dOp9G9HCuopcwoqAydtEpEiORFm7t7IwTq6
         oJd8QSLkIIuOADxSrESeggAjoQqkBMAoWdUKquFkohN7UFe2Oz0gwoXE9tbVyqkw7TIe
         jVMRnAES1gEBiLrr6pwtmNa7z6mRXXIPej0YsdTGAph0mZ2D4aSiQtBd8sh7KmjiJo0p
         8w/Q==
X-Gm-Message-State: AFq9FYIVK7XwuAwpD46nePZHePHjXvQ6nqTC83JvKv1lc9OmcfS5E3od
	vkhg3SjpXUFLuQ9T1OkKvS2q/+TKKtGakLJYBFdkwTFvA9V5bzEtBcN7
X-Gm-Gg: AYBFou35aGg1Qxg+2ocuyQMdsjfXM9SC4yUNpTGTH5QX6hq75DIsT4TP9ZQw/0fEkoL
	Ksl6hT4CKscr2kHJ4ax4AXQ8naHgOmwQHBqxVc8nGPxN2NRYNRh8eWDuWNOpuEhsvvemMuGPfge
	/oHbfvlpA7l714N5pr7FzUu5jWW1mTV8a/sMYGch2xyn+stAzvsxggL9PMTF9RdTh838K8kkgTK
	47r8zKTvALXEtcnIanC8JnXtakHXche/lhcAGNYmNdg6y1PSb28qU3KMfQPDlMGYBwoaIYeouE2
	p+xus+M2IAZqReT2zS0rEjGoOQtVpbuY/xZzCj1i4F2874s2wsnHeMMizeO/F7+RwRabuZy426r
	Yviz4NqnY03UCZ83fYk+Kt1pEch651Is5938/CAXaxTxqS/SxZT0qLzL92cUOpCutBSYRbtG7Az
	34gFT5mL3igSqM8euxN43pSdOhczugAa4nl6FDFrmq071+2jdepUnTu3uUtUWyn99fMg==
X-Received: by 2002:a05:701b:241b:b0:17f:7280:134e with SMTP id a92af1059eb24-18514b02cbfmr7856123c88.32.1792376883771;
        Sun, 18 Oct 2026 19:28:03 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm28341876c88.0.2026.10.18.19.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:28:03 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH bpf-next v5 0/4] bpf: Fix a struct_ops use-after-free
 behind a flaky assoc_in_timer test
Date: Mon, 19 Oct 2026 10:27:54 +0800
Message-Id: <20261019-selftests-bpf-struct-ops-assoc-timer-v5-0-77b2e181e5cc@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqA1WoC/5XNy27CMBCF4VdBXneQbwl1V30P1IUvY7BE4shjI
 iqUd6+bVcQqLEdH8/1PRlgSEvs6PFnBOVHKYzu6jwPzVzteEFJoN5Nc9oJzA4S3WJEqgZsiUC1
 3XyFPBJYoe6hpwAIdOi5Nh15xzho1FYzpsWbO7P9vxEdlP225Jqq5/K79Waz7e6lZgABjzckap
 4II7vsy2HQ7+jysgVluUMF3ohI4hJPV6tP0wUXxiqot2u1EVUMxYq9V0E5a9YrqLdrvRHVDjQ1
 KeCmk5H6LLsvyBwXd82/hAQAA
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

st_ops_assoc_in_timer_no_uref drops every reference to a struct_ops map
and expects a timer callback of its prog, 500ms later, to find no
struct_ops associated anymore. It fails now and then while test_progs
runs other tests in parallel.

Since commit 5db69b0fbdc8 ("bpf: Make struct_ops tasks_rcu grace period
optional"), a struct_ops map clears the association only after the RCU
grace period of bpf_map_put(), so nothing waits for a prog that reads
the association in between. A timer callback can then return into a
freed trampoline, and the kernel hits an int3 Oops.

Patch 1 lets the association be cleared in any context, and patch 2
clears it in map_free_pre_rcu(), so that the grace period bpf_map_put()
already waits for follows it. Patch 3 adds a test that catches a map
freed under a running .test_1. Patch 4 has the timer callback of
st_ops_assoc_in_timer_no_uref retry until the association is gone.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V4 -> V5:
- Drop the free_after_rcu_gp of struct_ops maps, which is dead now, and
  update the comment of free_after_mult_rcu_gp in struct bpf_struct_ops
  (Alexei)
- Also stop the tests when associating syscall_prog fails (Sashiko)

V3 -> V4:
- Clear the association in map_free_pre_rcu() instead of deferring the
  free of the map (Amery Hung)
- Add patch 1, replacing st_ops_assoc_mutex with a spinlock, since
  map_free_pre_rcu() may run in softirq
- Stop st_ops_assoc_in_timer_free and _no_uref when running syscall_prog
  fails, instead of waiting for the timer forever (Sashiko)
- Point Fixes of patch 4 at 0e841d19263ab, which added the test, as the
  delay left after patch 2 comes from freeing syscall_prog

V2 -> V3:
- Wait for an RCU tasks trace grace period in patch 1 for every map, so
  that progs reading the association under RCU tasks trace, e.g. from a
  bpf_wq callback, are waited for too (CI bot)

V1 -> V2:
- Add patch 1, fixing the use-after-free behind the flaky test (CI bot)
- Add patch 2, a test for the use-after-free
- Point Fixes of patch 3 at 5db69b0fbdc8 (CI bot)
- Move the restarting of the timer into patch 2, which needs it too,
  so patch 3 only turns it on for st_ops_assoc_in_timer_no_uref
- Rebase onto current bpf-next

v4: https://lore.kernel.org/r/20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com
v3: https://lore.kernel.org/r/20261015-selftests-bpf-struct-ops-assoc-timer-v3-0-efe643d4b2a3@gmail.com
v2: https://lore.kernel.org/r/20261010-selftests-bpf-struct-ops-assoc-timer-v2-0-d7a43896dbf1@gmail.com
v1: https://lore.kernel.org/r/20261009-selftests-bpf-struct-ops-assoc-timer-v1-1-9a97a9b3d1db@gmail.com

---
Qiliang Yuan (4):
      bpf: Protect the struct_ops association with a spinlock
      bpf: Dissociate struct_ops progs before the grace period of the map
      selftests/bpf: Test freeing a struct_ops map under a running prog
      selftests/bpf: Wait for the struct_ops map to be freed in assoc_in_timer

 include/linux/bpf.h                                | 10 +++---
 kernel/bpf/bpf_struct_ops.c                        | 29 +++++++++--------
 kernel/bpf/core.c                                  |  3 +-
 .../bpf/prog_tests/test_struct_ops_assoc.c         | 37 ++++++++++++++++++----
 .../bpf/progs/struct_ops_assoc_in_timer.c          | 16 ++++++++++
 5 files changed, 70 insertions(+), 25 deletions(-)
---
base-commit: 15b578b1715d9a318c804350d98af87c203672bc
change-id: 20261009-selftests-bpf-struct-ops-assoc-timer-5eb0295ec300

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

