Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584771;
	b=l58KGwNWdFFdU3LrLdHIa7zG9qG0h0sJkjAn9CFPEF3KUv/Yz02dbUDtkcG9QAfuAcr7
	 cHwsNDh2Rw82g+vaujb3mrjSiWv8pJXWK7zHsm4aL2mHqOj1jvb+jEZDUeJrdxdc2PPSr
	 BWuoMEk8bHTqAi8usSDJVta4+WodO21fzpt4KHhhGVDsTOJBXYjq5Y3uudJMM8k3jAWfA
	 TGONK3dt1m8qkUP4k7IPSnUt777Bp+0DWgrBLHkBQX5Tb0Zu9pL/B6jwmTIT93b+l9gPC
	 WwL2ZwW8PTvQZOmIPybVqWkgT7fpwqnTzcqDGw6lSuDRRvdbRYlCbH+kVQw6actloLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584771;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=8TDkzHIQTb0cmXMx7xs5icndgOXcEeTLbwyeJ7c7VFM=;
	b=Tbput1JbMrXuoU/gUA/a6UYb3c8ycAM5X3Uum/5Q8LizNMuQdB9SVW9Ys1e5oASG/RX1
	 43YzkYIYyfO3SPd7sPDCxhNVIt19glrmmmuK+nANClmEC3E6bBj2v0CzbqdtiT1GxPH+e
	 1VsG8tSgNGse8xL21VOzxHWDdPGUNGwOcYpADDzT+uoxiFbFxsYvBgakh9cKGwMy2/naI
	 pZB1836YPBUXsfQCHwvGeESifaMP36cE3Emj8UcNVkB0xWv5ta9V2vyy9emgWXTw81twL
	 yEqJfye7KwS5bNA7QnXijvSzUVg/Q94w4kjK+dkJHRym/aeELhiHhlH0H9GKiF4F94g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=h+E4YswI;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E3D606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E3D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=h+E4YswI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8T
	DkzHIQTb0cmXMx7xs5icndgOXcEeTLbwyeJ7c7VFM=; b=h+E4YswI9uA7ADhvZq
	E3Y/6YBxPslBIABqID0H4D25URGPYG8qV+hEe4VHF5CR2zkUa1hGD0El+ElZBnpN
	xCMvfIePaJQVHyqtGMBdSVmUI6PXKfUNyv5n8A3U4O5RFv/llVT4e0L0YvQhuQLp
	lnKWk9aoA/3NrqcCLA59tBlR0=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL6jCcgZrriN8JQ--.11907S2;
	Wed, 25 Nov 2026 13:31:49 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v5 0/6] bpf: Fix async callback use-after-free on map deletion
Date: Wed, 25 Nov 2026 13:31:26 +0800
Message-ID: <20261125053132.444234-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL6jCcgZrriN8JQ--.11907S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF18CFykCF13uF43Xw4UCFg_yoWrZrWfpa
	yFqwnxtr4DGas7t393Cw48ZFyFgwn5Ja1akasaqryYvrn8Xr18AryI9r1jgF9xCrZYgw1a
	vrn2qana9a4jva7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URSoAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wUq+GsGcsWTlwAA3i

From: Yun Lu <luyun@kylinos.cn>

This series fixes a use-after-free when a BPF program schedules task
work, workqueue work or a timer through a value pointer retained across
map deletion. Review of the earlier task-work series [1] pointed out
that cancellation can leave the deleted value open to reinitialization.

The original reader keeps the element alive while it queues new work,
but the new callback can start outside the grace period that protects
the element and access the freed key or value. Patch 2 describes the
race and includes a KASAN report from an unmodified kernel.

Mark task work FREED or clear cb->map before detaching the context.
Following Alexei's suggestions [2, 3], check task-work membership after
claiming PENDING and check wq/timer membership in the shared setter.
The setter also rejects zero usercnt. An idle callback can survive in
an unlinked cached element past the last user reference and be reused
when the element is inserted again.

Patches 1-3 fix task work and add its regression test. Patches 4-6 fix
the shared wq/timer paths and cover both in the wq and rhash_timer
selftests.

Testing on x86-64 QEMU/KVM with KASAN, PROVE_LOCKING, PROVE_RCU and
DEBUG_ATOMIC_SLEEP enabled.

- task_work, task_work_stress, wq, rhash_timer, timer and timer_mim pass.
  The deleted-value tests and wq/usercnt_reuse pass.
- With the same test binary on v3, wq/usercnt_reuse fails as expected
  when the setter returns 0 instead of -EPERM.

Changes since v4:
- Patch 1: every canceller compare-exchanges the task-work slot; the
  first FREED transition owns the map reference (Alexei).
- Patch 2: non-marking LRU hash lookup (bpf-ci) and a full barrier
  ordering the membership lookup before the usercnt read (Alexei).
- Patch 3: move the deleted-value task-work test to RUN_TESTS (Mykyta).
- Patch 4: every canceller clears cb->map and compare-exchanges the
  async slot with a READ_ONCE slot load (Alexei).
- Patch 5: carries forward the shared wq/timer setter checks and the
  rhash_timer regression.
- Patch 6: single skeleton load with map-in-map for the reuse test
  (Mykyta); setup/cleanup errors and retry exhaustion fail the test
  (bpf-ci).

v4: https://lore.kernel.org/all/20261119033051.196177-1-luyun_611@163.com/

Changes since v3:
- Reject zero usercnt in the shared setter (Sashiko), order the check
  after lookup with a full barrier, and add a wq regression for reuse.
- Consolidate the task-work return value documentation (bpf-ci).

v3: https://lore.kernel.org/all/20261111024333.228633-1-luyun_611@163.com/

Changes since v2:
- Use the existing map lookup and move the wq/timer check to the shared
  setter (Alexei).
- Give slot detachment to the first invalidator and reuse the existing
  task-work, wq and timer selftests.

v2: https://lore.kernel.org/all/20261106095747.471718-1-luyun_611@163.com/

Changes since v1:
- Replace slot poisoning and allocator hooks with lookup checks
  and split out cancellation ordering (Alexei).
- Extend the fix and regression coverage to wq and timers (Alexei,
  Mykyta).

v1: https://lore.kernel.org/all/20261028073525.1035605-1-luyun_611@163.com/

[1] https://lore.kernel.org/all/20261012061915.231254-1-luyun_611@163.com/
[2] https://lore.kernel.org/all/DMGN8VM2BAOR.28NRNN51MCI8I@gmail.com/
[3] https://lore.kernel.org/all/DMOAQI1S0JBS.3N3WETHD2L6KQ@gmail.com/

Yun Lu (6):
  bpf: Mark task work FREED before detaching it
  bpf: Check task work value membership before scheduling
  selftests/bpf: Test task work scheduling on a deleted value
  bpf: Invalidate async callbacks before detaching them
  bpf: Check async callback membership and user references
  selftests/bpf: Test wq callback setup after deletion and user release

 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/helpers.c                          | 100 ++++++++++++++++--
 tools/include/uapi/linux/bpf.h                |   2 +
 .../selftests/bpf/prog_tests/rhash_timer.c    |  24 ++--
 tools/testing/selftests/bpf/prog_tests/wq.c   | 115 +++++++++++++++++-
 .../testing/selftests/bpf/progs/rhash_timer.c |  26 ++--
 .../selftests/bpf/progs/task_work_fail.c      |  26 +++++
 tools/testing/selftests/bpf/progs/wq.c        | 109 ++++++++++++++++-
 8 files changed, 358 insertions(+), 46 deletions(-)


base-commit: bd75869299f1d4ff6e9f45117cce28f8badee1cd
-- 
2.43.0

