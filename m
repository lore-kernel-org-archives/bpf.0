Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F654DEC1A
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070593; cv=none; b=HdMRyw4vT/s37bJJ4/E285c6FKdQ/mQQ1BjPuEk0yeq+9IJSyLe4b2wPxLMeniegAUHL2WXdwNoG05IoiFn2AIMKg2pqo/2MRDu/h1l2X6eD9pfOC0PdNpli9SfXABkTk7CPfXThaX3vOocwcZ3V1/a8Wqxw+vTMuOnge8xyRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070593; c=relaxed/simple;
	bh=VR1I70M9bQNSvWIJGh+K0LSZoEApq1y6B7+ZdbsCYo8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U0lByHbe/VoDmWpE1emlmuwkaORNs0rOp69Gqtvs8lTMrRCnPVfm1g57RNY1BFbvbKPgFENEDmbBaNn6QizMiQNzIPoMpQvGbLSQEkNrojJxPBGpC6bq23YCFr6+fN2VxD/feK9kkAYZOeqkfygQRUwGO9kpGn4xLmMsMX5lBPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W363IDUe; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W363IDUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+/
	+bX+JQKb2RyxPr0ReKgZcP27kFy+gPAF/4i/g6jLA=; b=W363IDUeTY6j5csGzD
	xCe64hSjdCI/qIwrKdYIneF/DuFMe8Dh0bGJ632y9Uqh4Fl9xxrLYZW7W2k/w3Nn
	pNdhRM7sA0kTQcsvNiNPCjci8jhw8wg6LqMrct2ZkknoC2mVnlCzN8fE43b778eU
	Khwvy5TrSAizpZb4T9anp9Wrk=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHr_I0T7Jq5bZYAA--.9083S2;
	Tue, 22 Sep 2026 17:49:41 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: luyun_611@163.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/2] bpf: Fix task work scheduling race
Date: Tue, 22 Sep 2026 17:49:36 +0800
Message-ID: <20260922094938.135826-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr_I0T7Jq5bZYAA--.9083S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1kur1fGFWxJFy7Zry5Jwb_yoWrJF1Upr
	ZYgw1ayr4kGa1Iya17Zw4xXryfKan3ta15Grs2qryUAry5WFn2ya47KF1UtFWUGryvvF1F
	vr4qqa97ur4Y9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRRc_3UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xUo9mqyTzWWUwAA3H

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
- Deterministic A/B replay (debug delay in the scheduling irq_work,
  validation only): unpatched panics 3/3 in task_work_cancel(),
  patched survives 3/3 with the callback staying non-blocking.

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

