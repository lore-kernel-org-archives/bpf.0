Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4B8331A48
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718472; cv=none; b=sZ9T8GYbj83rXPh49K82FxyrhdicikKrWF/DWAvaj4dGt6wyFOzM63KBho1s+PsGJBePBMFDM3bJDajeheV57ngyWMp1UP5SW5YpQBELZK8nglvMq186WXJwnpAQSdJWuJ9KdReirYnxIANekAKKznDlYA4P1XAYuZWtF5tKb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718472; c=relaxed/simple;
	bh=rZio4/+JlvYuoF2Eq+kNM9hzLgmHxIS79E4/y56eqkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owqod8UT+tg5rBP0pJoPbdV/Z/FmNwSvO+4VnKZcjkQLkOibwxOMSPpIHUXasU5JtBWqthrhFGbIGWLFE5IR50VWslKtfCqYSjI1M1BwAoE2ldig0KlzEeQWkKmUt1sr6Ytp/+3WKQ9T6CFnW2Afy/SxcCIm8XPKv7lmudmHAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W2OBS1Bq; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W2OBS1Bq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Pj
	bcav3Li4rcolvj0bTF5ARiJUQx3H3ZzNCLsIgJQKA=; b=W2OBS1BqHyJg97U+RQ
	ns+qi45McSyVIn7/d6oN7fGJZjZVwVT8Tt5w0A3bEj9Mh3NbVbTk7FGOO/cMwTAC
	Y6ZYC1EgdHLY+mAfX59e4UFp6xBDEbJz2ryal1lRT2FOD7gVAaiUktrit4YzI2Y2
	VjF0FD83Xyq/KmKySH/eSXOsA=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHCk2O76xqG1U9AA--.7036S2;
	Fri, 18 Sep 2026 16:00:16 +0800 (CST)
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
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/2] bpf: Fix task work round ownership race
Date: Fri, 18 Sep 2026 16:00:12 +0800
Message-ID: <20260918080014.54012-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHCk2O76xqG1U9AA--.7036S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4UJr4xKF1ktFy5Gw45ZFb_yoW5Wr4DpF
	ZIgwsxtrs8JF1xtw4avw4UX34FgFs3Ja15Gr1xKr9rAwn5JFn2v3W2qF1jqF4UArWkZF1j
	vr4jqw4xuF1j9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbzV8UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xDltGqs75DkUgAA3l

From: Yun Lu <luyun@kylinos.cn>

This series fixes a race in the bpf_task_work scheduling kfuncs and
adds a regression test for it.

A task_work callback scheduled for a task running on another CPU can
complete before bpf_task_work_irq() regains control after
task_work_add().  The callback's cleanup releases ctx->task, so a
concurrent map value deletion that publishes the FREED state makes the
resumed irq_work handler call task_work_cancel(NULL, &ctx->work),
dereferencing task_struct::task_works through a NULL task (RIP at
task_work_cancel+0xd, RDI == 0, CR2 at the task_works offset).  The
same cancellation is reached when the deletion wins before the
callback runs and the callback's bailout path drops the last ctx
refcount, clearing ctx->task.

Patch 1 gives each scheduling round an ownership count: the irq_work
scheduler, the published callback and an asynchronous canceller hold a
reference while using this round's task/prog/work, and only the last
user releases them, before the ctx can be reused from STANDBY.  The
count is zero based with the STANDBY -> PENDING transition acting as
the zero-to-one gate, so a finished round cannot be revived: a
canceller either pins a still-active round (ctx->task guaranteed
valid) or declines to cancel.  Separate irq_work objects for
scheduling, cancellation and deferred destruction avoid reinitializing
an irq_work that may still be queued or running.  FREED remains
terminal and the scheduling path stays atomic-only, preserving NMI
safety.

The race window between task_work_add() and the SCHEDULING ->
SCHEDULED cmpxchg is only a few instructions wide, so the fix was
verified with a deterministic reproduction that widens exactly this
window with a debug delay, while scheduling cross-CPU and deleting the
map value concurrently: without the fix the kernel panics reliably;
with it, all interleavings complete.  A 900-round stress test rotating
through ctx reuse, deletion after the callback and deletion right
after scheduling also runs clean, with no leaks reported by kmemleak.

Patch 2 adds a selftest that keeps steady pressure on the
interleaving: it schedules cross-CPU, deletes the map value at
different points of a round, uses READY/DONE handshakes so scheduling
errors cannot be missed, and tags every callback with a generation so
a late callback cannot satisfy a later round's assertions.

Yun Lu (2):
  bpf: Fix task work round ownership during cancellation
  selftests/bpf: Add task work round ownership race test

 kernel/bpf/helpers.c                                  | 123 ++++++++++--
 .../selftests/bpf/prog_tests/test_task_work.c         | 283 +++++++++++++++++++++
 .../selftests/bpf/progs/task_work_race.c              | 125 ++++++++
 3 files changed, 503 insertions(+), 28 deletions(-)

-- 
2.43.0

