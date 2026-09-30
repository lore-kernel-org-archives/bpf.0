Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A453468C17
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790758547; cv=none; b=AuTQOo6XX2KfSwG6nATrEP8myuoUdRpjEED4LswcNYVW2MGJjlpbGHNa96GFeeR1gTHZjN0JkMUDLQ3CBPMm6R3uHCI9Ok7d52TQHeUJL4HScUoim2KLwgYVE25S0CyROOKMySYkw0c26IpO8Z4xIv9DVdBqusMWXaExsVjeL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790758547; c=relaxed/simple;
	bh=LeUq7C/2+uchsxmxMJXqxlW2vnjp0lKa7aQHv0Nb/V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwvobhuZ4amT9VfKgmrHqenfknpP8RJqUN7kwOWyvpVniairXywyrJ05Jb8b6d02Oeh5m1nMKaMNGjb6Czikt3YS/482d49KHjNwCqfB6SzuOf+/XcsoH7zoc2zaJAWK9Z1VddbSnw5HIeVCXkb4Fe3CrB01d5ANPe1ySYVOGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KErVYuWG; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KErVYuWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Mn
	MjgMjlNH/4FcvidfK7r3FaSgRe+/Dcir+aV+EmyyI=; b=KErVYuWG7+tNxyaeNa
	6d8eED8bvdE4GJ1hqUvJgxyhf8/hRrTMSJHZafVj8vlYnodGX+vSWyDm+y7inkM1
	lb88Od65FNOFF4QA6sTW7KP5o/1vyEAcoWM3wo3frPfQgxw2nTMe1PDI7i2U9ZWH
	pxsJq49QpmrmFNqwQQ5D99wFo=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnDapYzrxqRk3PCA--.39078S2;
	Wed, 30 Sep 2026 16:54:50 +0800 (CST)
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
Subject: [PATCH bpf-next v5 0/3] bpf: Fix task work scheduling races
Date: Wed, 30 Sep 2026 16:54:14 +0800
Message-ID: <20260930085417.186729-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnDapYzrxqRk3PCA--.39078S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWfCr4xCFy8Aw4kuF15urg_yoWrtrWrpr
	ZYgw1ayr4kG3WxtanrZa18GrySgws3Ga15Grn5tryUArn8XF1xA34xKF4jgF4UAryvga4Y
	vrs0qa97uw1Yv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbxhLUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BuTYmq8zltpwQAA3t

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

Patch 3 adds a 1500-round cross-CPU stress test for context reuse and
map-value deletion racing with scheduling or callback completion. It
does not force the exact faulting interleavings.

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

- The unchanged kernel fixes were tested for v4 with KASAN, lockdep,
  PROVE_RCU, DEBUG_ATOMIC_SLEEP and KMEMLEAK.  The previous selftest and
  900-round stress runs were clean, with no leaks reported.
- The v4 directed delay tests covered both cancellation paths and both
  BUSY rejection paths.  The cross-round interleaving from patch 2's
  commit log crashed without patch 2 and survived with it.
- For v5, the updated selftest was rebuilt and rerun on the fixed
  kernel: test_progs -t task_work passed three times.

Yun Lu (3):
  bpf: Fix NULL task dereference in task work cancellation
  bpf: Prevent task work context reuse while irq_work is busy
  selftests/bpf: Add task work scheduling race test

 kernel/bpf/helpers.c                          |  54 +++-
 .../selftests/bpf/prog_tests/test_task_work.c | 281 ++++++++++++++++++
 .../selftests/bpf/progs/task_work_race.c      | 126 ++++++++
 3 files changed, 451 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_work_race.c


base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.43.0

