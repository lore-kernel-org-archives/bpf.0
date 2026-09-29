Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EE39E17C
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 07:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666944; cv=none; b=cr/77PiMa30PG3Hnrw5SRtAUFILb9DUQKmF1BuWM0N8DwuBhZO04mR0HWlSnTVImFdwyj8hjqql4qtsEvxL8yMxbbfVjbDuuDtajP2DmN7+RApWB/7n4d52g5LrOGFcVvX+692sDUobSuNgn9MPnsz0/jUpOzlwGcoyx/1JrJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666944; c=relaxed/simple;
	bh=saYx4lTtS38enk5zRg/v4HVjgH+ZTq6h5f6cW8sR7zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZhuaUeGpL5/z4VKnY/LDNaqmr+Cue9nlVlrXSEgVXN8f/ARqGNP9lx0rQ+PA5oKm1h5EeT+x8mOmuRDq5s+gCLhjS6n3w/6kkyMi/gTinYoMtNvWncm+/fbrkrd7n+bG8aSpyTOQAGb0RznVYK2YSIFuIHXzfjUgnZXj9K4blk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g08zG0ja; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="g08zG0ja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=r+
	3p7t2CKPGdjQ9JIBSBVDe72Rm1nYsTu8JQ+KAXwAk=; b=g08zG0jalI4Rl5Lyac
	8Q+90xd6ed6DMtEzek+Laul6IbJqbKHhhSeeXdFqDJsE932Al8bqsqObWLg7/Yr3
	XIWmDW2NCnBTxxFFTB4P57VbJSecgeZscIyJPgxtBWBZUDz28bMV7sYxy54ITab/
	Jt7O8kROA3k1YpdpDFL5JJ2Js=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgD3H4iLaLtqtLTxBw--.62773S2;
	Tue, 29 Sep 2026 15:28:14 +0800 (CST)
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
Subject: [PATCH bpf-next v4 0/3] bpf: Fix task work scheduling races
Date: Tue, 29 Sep 2026 15:27:57 +0800
Message-ID: <20260929072800.113129-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgD3H4iLaLtqtLTxBw--.62773S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWfCr4xCF4rAr1rKFyUWrg_yoWrWFW5pr
	ZYgw1Yyrs5G3WxtF47Za18GryS9ws3Ca15Grn5try0yrn8XF1xAa4xKF1jqF4UCryvyFyY
	vr4qqa97ur4jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jj_M-UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCxA7GlWq7aI4HuAAA3R

From: Yun Lu <luyun@kylinos.cn>

This series fixes two races in the bpf_task_work scheduling kfuncs and
adds a regression test for them.

Patch 1 fixes a NULL task dereference: the callback can clear ctx->task
before the scheduling irq_work handler attempts cancellation, so the
handler now captures the task pointer before publishing the callback and
relies on its existing RCU read-side section, which covers the captured
task because bpf_task_release() is put_task_struct_rcu_user().

Patch 2 stops a new round from reusing the context while the previous
scheduling irq_work is still BUSY.  Without it, a delayed handler can
consume the new round's SCHEDULING state, leaving the context stuck in a
false SCHEDULED that later routes deletion into task_work_cancel() with
a NULL task.

Patch 3 adds a 1500-round cross-CPU test racing scheduling, callback
completion and map-value deletion.

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

- Built with KASAN, lockdep, PROVE_RCU, DEBUG_ATOMIC_SLEEP and
  KMEMLEAK; test_progs -t task_work and 900 stress rounds in QEMU are
  clean, no leaks reported.
- Replayed the deterministic reproducer (debug-delay only, not part of
  the series): without the fixes it panics reliably in
  task_work_cancel(); with them the callback stays non-blocking and
  the guest stays healthy.
- Directed delay tests cover both cancellation paths and both BUSY
  rejection paths.  The cross-round interleaving from patch 2's commit
  log crashes the kernel without patch 2 and survives with it.

Yun Lu (3):
  bpf: Fix NULL task dereference in task work cancellation
  bpf: Prevent task work context reuse while irq_work is busy
  selftests/bpf: Add task work scheduling race test

 kernel/bpf/helpers.c                          |  54 +++-
 .../selftests/bpf/prog_tests/test_task_work.c | 283 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_race.c      | 126 ++++++++
 3 files changed, 453 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c


base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.43.0

