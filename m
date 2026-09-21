Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67F53AC0C7
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985757; cv=none; b=j52ruku2miR56LMAWj+wSBvTDloeswXnWVWZXw00UVxmLWDAM54mIHbBhAeP63aXZNUZSaqOAlBlIO0FB+lCWYsXN3eU/HOfBlwWYqlhOaha7MwkUJUIEOgE6Z8Sdoxc94siAYnuCPDiMjCZlRyemgDKg9UHTnPmWvGy/WyzPkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985757; c=relaxed/simple;
	bh=vKUCQMgo90U+9RUXbvoDthqkzbx1ZnQRc+9oaj0MFdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=temaxHEAduFPPS7jvy9HkV+xmdka2TPihh0bC3ripOznWtxSNeigvZASt2vBwzulRqtMDl41MH16rWzx6/1rTDf6eaTN5u/ytKXygeAVwyXu0V5lJMM0+lp6xaeR3OYI9o24qZdqKOeFVun7YWPRpkzDE8A+w1l4QKlRuAv1nWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mvo7Gntc; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mvo7Gntc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Da
	C68x9H+vhpAzcHbhHzJQBQ4pfrJRZ9P/76ULJCCqQ=; b=mvo7GntceyTooy8/fO
	vmUbjijNfzzjsQHM6rjVGCHvl23asIJFGM2/6avg59hl09v4xPl2ETPneq1nYaVD
	9A2nVHftBDn2hV6ErSx7kru+pHVk0yAEFMKmI3wcO1ut3i412xNGrAQNKmhX3HNL
	kCiAdAdmc9E11yVeCTPTW5SJE=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHHsuiA7FqJ+caBw--.352S2;
	Mon, 21 Sep 2026 18:15:00 +0800 (CST)
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
Subject: [PATCH bpf-next v2 0/2] bpf: Fix task work scheduling race
Date: Mon, 21 Sep 2026 18:14:51 +0800
Message-ID: <20260921101453.69273-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHHsuiA7FqJ+caBw--.352S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1kur1fGFWxJFy7Zry5Jwb_yoW5XF4kpF
	ZYqw15trWkJF1Iqa12vw48XFySkFs3Ja13Cr1kJFyUAr98XFyIy347KFyUtF4UJrZYqF1F
	vw4qga93uF4jkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbzV8UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwwTwv2qxA6T+HQAA3X

From: Yun Lu <luyun@kylinos.cn>

This series fixes a race in the bpf_task_work scheduling kfuncs and
adds a regression test for it.

bpf_task_work_irq() publishes a task_work callback before it finishes
using the scheduling round.  A target task running on another CPU can
execute the callback, reset ctx->task and publish STANDBY before the
irq_work handler performs its final state transition.  Concurrent map
value deletion can then make the handler call task_work_cancel() with a
NULL task.  The early STANDBY transition can also let a new round reuse
the context and irq_work while the old irq_work handler is still
running.

Patch 1 makes the callback claim RUNNING before waiting for the
scheduling irq_work invocation to finish via irq_work_sync().  A single
temporary reference taken from the existing ctx refcount keeps ctx->task
alive when deletion wins before the callback claims the round.  A BUSY
check covers the add-failure path, where there is no callback to perform
the wait.  No fields or states are added to the context, and the
cancellation and destruction paths are unchanged.

Patch 2 adds a 1500-round cross-CPU regression test covering context
reuse, callback completion followed by deletion, and deletion racing
with scheduling.

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

- Built with KASAN, PROVE_LOCKING, PROVE_RCU and DEBUG_ATOMIC_SLEEP;
  ran test_progs -t task_work and 900 race-test rounds in QEMU, all
  clean.
- Replayed the deterministic reproducer (debug-delay only, not part of
  the series): without the fix it panics reliably in
  task_work_cancel(); with the fix the callback visibly waits for the
  handler and the guest stays healthy.

Yun Lu (2):
  bpf: Fix task work scheduling and callback race
  selftests/bpf: Add task work scheduling race test

 kernel/bpf/helpers.c                          |  46 ++-
 .../selftests/bpf/prog_tests/test_task_work.c | 283 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_race.c      | 126 ++++++++
 3 files changed, 449 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c


-- 
2.43.0

