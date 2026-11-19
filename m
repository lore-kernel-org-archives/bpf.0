Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059110;
	b=AfTlYx7bStATR+wKHu1fI0//Hd5ZzHCjbpR72XmTCpHurPhl2v8UCWIiAkxoRojLbVU9
	 8jrRwXs6YE4t7dpsjq0uvYwMNCVwm1FjdSFLzNoBYX2PpxQBzBmx0AvEpd5DRGoEtvWoB
	 D5oWjY7iG/ltinYuNX1w2zMCghEN8hcS9Z+TCic8m12wBwlIu5t+NcJn4hVSFz3uWBRxQ
	 FXQ8RmnJ6gr3CsX+eOz5SqKG7wjQwwEoVqQKQtKLbSJYxVNDqt4efOqOZ+sCz2yFTYOe0
	 j67KouMln4cre2JYIflV+MOwznwbUr6+O53SV9Is/WhljETu+Utz1kgVCqTeAkTux7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059110;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=yHDnaNhr910/gUuGeXasS7El/214pG/VLEb6ikiaCGU=;
	b=OmF7fMxpkydOkXu2twOKsnr2ydmTcUnITtJGdwDC9qbPc9EFllrGex+YwldNTy5+KSwR
	 tB14K95VaUV/7Kuz8he6x+jnG13P2vBHCOJ+GR2TWIjNcmld14EF2zvLmVka4CzqinTAA
	 Es0cWVkpvXOS9Hhc3S+z9+gqfs7hY7BZGSoaNRbdvA1PHl80xMsPdMxW1UtdP/h2nL2wO
	 8yxWnoPrCjEmCtohGpyL/8P+vn+2iwfJ3jXAhCcr8rOmPB8Jf7QKQu9LUPLxx8Jds2R5E
	 qWJO446GbLnmYpDvDz2yCrBVpWhKpqqxOBe61cdXNSRZtxjCNBMkcdrwyLaX4Zo7ZcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KoOcIc60;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326CD606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 326CD606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KoOcIc60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yH
	DnaNhr910/gUuGeXasS7El/214pG/VLEb6ikiaCGU=; b=KoOcIc60rPUGBhF5xc
	WsVzbJMCk7GCK6gjrDKmQQKO4PKQuDajqahtScW+K5kvXKtmHj5GejZ9DpCVhvuq
	HBt6WaPPrXXwOvFi9TLGX6B7yjpyafx+3cAaydIljBLmAvI6if6ESVSwBSudqSkn
	p7S0XD8dqy1NGeRY/aEH8Tvno=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3Xzx1bf5qM8OwJA--.54798S2;
	Thu, 19 Nov 2026 11:31:03 +0800 (CST)
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
Subject: [PATCH bpf-next v4 0/6] bpf: Fix async callback use-after-free on map deletion
Date: Thu, 19 Nov 2026 11:30:45 +0800
Message-ID: <20261119033051.196177-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wD3Xzx1bf5qM8OwJA--.54798S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF18CFykCFy3KFWruFWfKrg_yoWrJryxpa
	yFq3sxKr48Ga4xtws7Gw48ZFyrWwn5X3WYk3saqryYyrn8Xr18AryI9r1jgFZxCrZYgw4a
	vr1Iqana93Wjv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbiSLUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xfSoWr+bXcYJgAA3-

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
DEBUG_ATOMIC_SLEEP:

- task_work_stress, wq, rhash_timer, timer and timer_mim pass.
- With the same test binary on v3, the new wq test fails as expected:
  the setter returns 0 instead of -EPERM.
- A reduced LKMM model rules out the stale usercnt result with the full
  barrier after the membership check.

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
 kernel/bpf/helpers.c                          |  89 +++++++++++++--
 tools/include/uapi/linux/bpf.h                |   2 +
 .../selftests/bpf/prog_tests/rhash_timer.c    |  24 ++--
 .../bpf/prog_tests/task_work_stress.c         |  18 +++
 tools/testing/selftests/bpf/prog_tests/wq.c   | 103 +++++++++++++++++-
 .../testing/selftests/bpf/progs/rhash_timer.c |  26 ++---
 .../selftests/bpf/progs/task_work_stress.c    |  17 +++
 tools/testing/selftests/bpf/progs/wq.c        |  62 +++++++++++
 9 files changed, 299 insertions(+), 44 deletions(-)


base-commit: bd75869299f1d4ff6e9f45117cce28f8badee1cd
-- 
2.43.0

