Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C90253340
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791786025; cv=none; b=L/xQ3AnhqmOOq6Z3yjosocZZxsqCt149OZIFUo/9P3EQmN/UdOPVovhWzW54jdw745Q/kRE6fR6TpyHfB40jwhhFfMQfdPCpfZpKOADy/lmw11601hIcNjMpXQDpBC58a+BDgW1JvqN+FiURyk9UkMUuEdch1u7KcyXZ5hevcMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791786025; c=relaxed/simple;
	bh=J2fhmiV4Z8XtC+0cjxNBcPJKWKPnmV+CWcVaFNigrbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JD2LzatbptEZIe+YNDfDxJLcgE9ZdEvUDQc4HRJjB0ar3yjAmLTalKN3m5HtUPDjU+UuLk7Plfoq1pGi4xbSf2qBid++q4CyF0kKZgPrrtAP2d/xmhyELv4ujGaV0oKuGp4itBXO01VWTyljEkmiSfiFTr+h8GvsOOIkJJY/d4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eoHzQDUg; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eoHzQDUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bj
	u1V3h/li+ZbGTwHkKy4jOVxQytVuWaQ3Y2se2mJH4=; b=eoHzQDUgqyI9efjuVN
	WUa+PvJjdRBSI1noafiP1XRMw1uzjGJTx6POqlXAGqtaVtMV1RWCSEjKwf7KsF3D
	3rM9JR/h8Z/NJvikGH5IP7cD2omw1psyMvNumCPgP8XNrlIDaCs7v5cW7KVC7Zdo
	wXt6ebZBZfW/LL19ke8NVGpK8=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_8bte8xqryiFEA--.37995S2;
	Mon, 12 Oct 2026 14:19:28 +0800 (CST)
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
Subject: [PATCH bpf-next v7 0/4] bpf: Fix task work scheduling races
Date: Mon, 12 Oct 2026 14:19:11 +0800
Message-ID: <20261012061915.231254-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_8bte8xqryiFEA--.37995S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF47Gw1UCr13uw1xtFWrKrg_yoWxCFyxpF
	ZYg3sxCr4kK3WxtanrAw48WryF9ws5Gay5Gr1ktry0yws8XF1IyryxKF1UtF4DCryvga4Y
	vr4qgFZ3uw4qvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbKsbUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BHot2rMe-HRkgAA3N

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

Changes since v6 (patch 4 only):

- Skip on PREEMPT_RT through the CONFIG_PREEMPT_RT kconfig extern
  read from the skeleton before attaching, instead of the
  /sys/kernel/realtime probe and the irq_work thread-name detection.
- Share the status accessors, sequence polling, polling bounds and
  the userspace value layout with the cancellation race test.
- Drop the auxiliary stats map, the loop-count diagnostic and the
  wall-clock assertion; the elapsed time is read once after the
  worker cleanup, purely as a diagnostic.  Publish every first-round
  scheduling result, including -EBUSY, and drop the redundant
  userspace CB1 wait and the pacing-only inter-attempt sleep.

The core window protocol and its assertions are unchanged.

v6: https://lore.kernel.org/all/20261010042132.137430-1-luyun_611@163.com/

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

- QEMU/KVM on x86-64 with KASAN, lockdep, PROVE_RCU and
  DEBUG_ATOMIC_SLEEP: task_work_busy passed three ordinary runs and
  three under target-CPU contention, with missed windows retried
  within the attempt budget; the cancellation race test passed as
  well.
- Without the BUSY fix the same binary fails the in-window rejection
  assertion as expected.  A PREEMPT_RT kernel skips before attaching,
  and a tracefs instance without the global function listing still
  attaches and passes.

Yun Lu (4):
  bpf: Fix NULL task dereference in task work cancellation
  selftests/bpf: Add task work cancellation race test
  bpf: Prevent task work context reuse while irq_work is busy
  selftests/bpf: Add task work BUSY window test

 kernel/bpf/helpers.c                          |  54 +-
 .../selftests/bpf/prog_tests/test_task_work.c | 694 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_busy.c      | 325 ++++++++
 .../selftests/bpf/progs/task_work_race.c      | 126 ++++
 4 files changed, 1189 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_busy.c
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c


base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.43.0

