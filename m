Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2826296BCF
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 04:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791606170; cv=none; b=HWEtjpreSOEEqBsR1AaYLXedoe9kz4V/vpdk5cekOPA1sXLOz0CAt2P0R/9WVa3NrY445whmyASpqMc6QfXgwr2Y6J63Jc+trhC/RfzMC0ktLf5SHlWxI5E3wj/JV6qmL4D+4rPqJmWMhHViUt3/GmlgosdwhE5jyrxBh0U+JiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791606170; c=relaxed/simple;
	bh=Q5tEB80klFJu4/VfoRy+KJfmDagzQR/z9IwlNFHFI+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROymo9sUiALx3AV/lgIF2LNWMQPA82al+a79prW4+/+4viQiCyb4Me84o+dCkriglhRE4U30zOwrtrzpASIDXpG1kzqDRF50ttuSFinM/RL8etivJxTaAaiDrGXiR8d3LeT7JDmYfhiZbhPS+p5eNPCDA6xSFjaBhNbkUSRG684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kImmljoU; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kImmljoU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FL
	zH7TXrO1Yz6S67oPI4mNgGdkpl7T+59plFF7f2/+o=; b=kImmljoUOZ1BjSW6ON
	YT+gMF0GX6RSUCRamduOnr4iB1MwDOOOKugreIzWDLQK1zDEpvsMSvgCQdMovqLG
	VjjgyvNWTfKihJ1r5LNA4+0q/axqtJ9OC7LXFzN0oZwlClgGgHgxl6+WIdfCCkZC
	Ml4Vit1AAB53I3eihOmCNRQnI=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v+Bhvclqy5XMDg--.2624S2;
	Sat, 10 Oct 2026 12:21:55 +0800 (CST)
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
Subject: [PATCH bpf-next v6 0/4] bpf: Fix task work scheduling races
Date: Sat, 10 Oct 2026 12:21:28 +0800
Message-ID: <20261010042132.137430-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v+Bhvclqy5XMDg--.2624S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF47Gw1UAw4UWr4rZF4ruFg_yoW7Kry3pF
	ZYg34Yyr4kK3WIyanrAw48WryF9ws5Ga15Grn5tryxAws8XF1xAryfKF1UKFWUCr9Yga4a
	vr4qqa93uws0vrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jj_M-UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wWVZGrJvWUXwQAA3y

From: Yun Lu <luyun@kylinos.cn>

This series fixes two races in the bpf_task_work scheduling kfuncs and
adds a regression test for each.  Each fix is followed by its test.

Patch 1 captures the task pointer before publishing the callback, which
can clear ctx->task before the scheduling handler attempts cancellation.
The existing RCU read-side section keeps the captured task alive because
bpf_task_release() is put_task_struct_rcu_user().

Patch 2 adds a 1500-round cross-CPU stress test for the cancellation
races: context reuse and map-value deletion racing with scheduling or
callback completion.  It does not force the exact faulting interleavings.

Patch 3 rejects context reuse while the previous scheduling irq_work is
still BUSY.  Otherwise a delayed handler can consume the next round's
SCHEDULING state and leave a false SCHEDULED state with a NULL task.

Patch 4 adds a separate test for that BUSY gate.  A bounded fexit wait on
task_work_add() holds the real scheduling handler after publication.
The target's next syscall attempts context reuse after its callback
wrapper has returned.  Observing its acknowledgment inside the fexit
wait proves the attempt occurred while the old irq_work was still BUSY.
Check rejection with -EBUSY, bounded recovery and exactly-once delivery.
Missed windows are retried within a bounded attempt budget.

Changes since v5:

- Narrow the race test to the cancellation races it covers and add the
  task_work_busy test: a bounded fexit wait on task_work_add() holds
  the real window while the target thread attempts reuse after its
  callback wrapper returned, asserting -EBUSY, bounded recovery and
  exactly-once delivery.
- Give each attempt dedicated workers and a fresh map value; reset the
  shared state before the workers are enabled and reuse it only after
  their TIDs have left PID lookup.
- Skip on fewer than two CPUs or confirmed PREEMPT_RT.  Reorder the
  series so each fix is followed by its test.  Kernel patches
  unchanged.

v5: https://lore.kernel.org/all/20260930085417.186729-1-luyun_611@163.com/

Changes since v4 (selftest only; patches 1 and 2 are unchanged):

- Rework the commit message to map each variant to the races fixed by
  this series, and note that the stress test does not force the exact
  faulting interleavings.
- Merge the trigger and target threads into one worker function, name
  the polling bounds, and accept only -ENOENT in the deletion-race
  variant (-EBUSY is retried inside the BPF program and never
  published to userspace).

v4: https://lore.kernel.org/all/20260929072800.113129-1-luyun_611@163.com/

Changes since v3:

- Drop the get_task_struct()/put_task_struct() pair: capturing the
  pointer before task_work_add() is sufficient, since
  bpf_task_release() is put_task_struct_rcu_user() and the handler's
  RCU read-side section keeps the captured task alive.  Reword the
  RCU explanation.
- Split the BUSY check and the one-time irq_work initialization into
  a separate patch 2, with the full interleaving and the failure it
  prevents.
- Selftest code unchanged; commit message wording only.

v3: https://lore.kernel.org/all/20260922100042.136818-1-luyun_611@163.com/

Changes since v2:

- Kernel: drop irq_work_sync() from the callback and both
  WARN_ON_ONCE() checks, as requested in review.  Following the
  suggested direction, the scheduling handler now takes its own task
  reference around task_work_add() and the post-add cancellation; the
  temporary ctx refcount from v2 is gone as well.  The callback ends
  up unchanged from upstream.
- The BUSY check in acquire is kept: without it a handler delayed
  between task_work_add() and its state cmpxchg can flip the next
  round into a bogus SCHEDULED, which later routes map-value deletion
  into task_work_cancel() with an already-reset ctx->task.
- Selftest is unchanged apart from the rebase.

v2: https://lore.kernel.org/all/20260921101453.69273-1-luyun_611@163.com/

Changes since v1:

- Kernel: rework the fix per review feedback.  Replace the round_refs
  ownership counter and the extra irq_work objects with a completion
  edge: the callback claims RUNNING and waits for the scheduling
  irq_work via irq_work_sync(), plus one temporary reference from the
  existing ctx refcount and a BUSY check covering the add-failure
  path.  No context fields or states are added.
- Selftest: address review feedback (single packed result store,
  bounded thread-start wait, tolerate the expected deletion-race
  outcomes).

v1: https://lore.kernel.org/bpf/20260918080014.54012-1-luyun_611@163.com/

Testing:

- Built with KASAN, lockdep, PROVE_RCU and DEBUG_ATOMIC_SLEEP in
  QEMU/KVM.  task_work_busy, the cancellation race test and the
  task_work family passed; under target-CPU contention the BUSY test
  retried missed windows and still completed its coverage.
- Without patch 3, task_work_busy failed the in-window -EBUSY
  assertion as expected.  On PREEMPT_RT it skipped after observing
  the irq_work handler thread.  Worker-creation and exit-probe
  failures produced the intended errors without secondary failures.

Yun Lu (4):
  bpf: Fix NULL task dereference in task work cancellation
  selftests/bpf: Add task work cancellation race test
  bpf: Prevent task work context reuse while irq_work is busy
  selftests/bpf: Add task work BUSY window test

 kernel/bpf/helpers.c                               |  54 +-
 .../selftests/bpf/prog_tests/test_task_work.c      | 843 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/task_work_busy.c | 380 ++++++++++
 tools/testing/selftests/bpf/progs/task_work_race.c | 126 +++
 4 files changed, 1393 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_busy.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c

base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.43.0

