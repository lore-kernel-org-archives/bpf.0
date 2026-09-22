Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0C47DF9C
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071327; cv=none; b=Gjh4hGuaMHSSFi2uAF4JtJliANl1vek3BUXgzy7hc52iWsuAVoGdamCaVjjSswWpgbTDg6kU41yAYU5FmKSf5bKTMCeCFw6VsB9dqHwQNv0SgH9ixu+NCA47AhgjIpYr6RC1tdJwHvXkNv9GVXTrd8xe0XSgr/lQ/3AZ8GpqrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071327; c=relaxed/simple;
	bh=W5DbtMnk1ZYUbX/qgS2uBENdrRE/spZ9tidycG6IeUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bv7CHXyk5cYiS6vxt7g2rSNxE4dtQEV2ivLus4yNdVZtpvxov6QAAzoYExXBD3eZb17OakZLB4cLTzIx3Iot0t8ZOJhzu3Yngc6p7IRjJDmO4XMeuXvrKdfmTPnb0MIeGHd81k/MMKkZ4LbdwGRsEGSFX0AOMOL9N7lYKHb5GK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dQqY9eRp; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dQqY9eRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n6
	lzrqs31LJW3vRAQmziRVkGw9PgnRxT0QFhHoLo2Dg=; b=dQqY9eRpyfJCPI7KVT
	7dat7djKPK50SFJvY2NzszbmVs66B8OmHJmtRg10XNh9rhdR1+N7deFAdli5w/o1
	uvPs1YQMU1p0AmOpOJRcJd7/lDUFmXKfd2M3Ccjfdf6HiwnrkxV5BHzqJ88uB/df
	FquG1YoO5mf/pAylbHfYDpX1k=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3HzLjUbJqDJOzAg--.12558S2;
	Tue, 22 Sep 2026 18:01:08 +0800 (CST)
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
Subject: [PATCH bpf-next v3 0/2] bpf: Fix task work scheduling race
Date: Tue, 22 Sep 2026 18:00:40 +0800
Message-ID: <20260922100042.136818-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3HzLjUbJqDJOzAg--.12558S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1kur1fGFWxJFy7Zry5Jwb_yoWrJFyUpr
	ZYgw1ayrWkGa1Iya17Zw4xWrySkan3Ka15Gr4vqryUAry5WF12ya4UKF1UtFWUJryvvFyF
	vr4qq397uF4j9FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbxhLUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCwwTUo2qyUeRgOgAA3H

From: Yun Lu <luyun@kylinos.cn>

This series fixes a race in the bpf_task_work scheduling kfuncs and
adds a regression test for it.

bpf_task_work_irq() publishes a task_work callback before it finishes
using the scheduling round.  A target task running on another CPU can
execute the callback, reset ctx->task and publish STANDBY before the
irq_work handler performs its final state transition.  Concurrent map
value deletion can then make the handler call task_work_cancel() with a
NULL task.  The early STANDBY transition can also let a new round reuse
the context while the old irq_work handler is still running.

Patch 1 captures an independent task reference in the scheduling
handler before task_work_add() and uses it for the post-add
cancellation, so the handler never reads ctx->task after the callback
may have reset it.  A BUSY check in acquire keeps a new round from
starting while a previous handler is still running, which prevents a
delayed handler from consuming the new round's SCHEDULING state.  The
scheduling irq_work is initialized once at context creation.  No
fields or states are added to the context, the callback stays
non-blocking, and the cancellation and destruction paths are unchanged.

Patch 2 adds a 1500-round cross-CPU regression test covering context
reuse, callback completion followed by deletion, and deletion racing
with scheduling.

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

Changes since v1 :

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
  clean, zero leaks reported.
- Replayed the deterministic reproducer (debug-delay only, not part of
  the series): without the fix it panics reliably in
  task_work_cancel(); with the fix the callback staying non-blocking
  and the guest stays healthy.

Yun Lu (2):
  bpf: Fix task work scheduling and callback race
  selftests/bpf: Add task work scheduling race test

 kernel/bpf/helpers.c                          |  39 ++-
 .../selftests/bpf/prog_tests/test_task_work.c | 283 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_race.c      | 126 ++++++++
 3 files changed, 437 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c


base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.43.0

