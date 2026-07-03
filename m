Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D6242D97;
	Fri,  3 Jul 2026 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093985; cv=none; b=NcV8abh3w8zRuKkMZlGK7FKCAcGiFtNUDte0nx1f+WyfU7Yn1Ekj5EG8PzAF1x69UOIBn/AXXCSl1JBMa54uM1wK5e08K36D8UhCPoAYHtHQSNQemRrRVTlvtpxymkbGz6cscMFuO1gT8g91MhicKK5Dp/6Zvw7BzD/23+NrTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093985; c=relaxed/simple;
	bh=o8mTIMRJH34m5FZmVqFv7hKqLsaCcbxqNUxsi944LOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=awS9hjDvjBT6gMQ0WjDRhGfTnsV7lK99XTGfMtc2Ru7aDHr8vMVuZeZY0aAsOY7NdRxQ3DwLCyw/NkcQak5gJGvKrdFImp0RgsYDDtZm8tlZ1rAvssV6VgEwrNO+BUZ8RzY8L6Qoq1L5VpSRe4wZRglUdrDD0k0yDmwYN5jzQy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=OJNQTmrs; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="OJNQTmrs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=Wp0hwcEgrbPLsHM90zar8FLEnNY0sGqCErXsxAvYDnM=; b=OJNQTmrsfqINsLldlxP2E8vaAd
	W2UiCx+e6yMZqA3YQDHFpRhe+S+trc26MN0ywxgva+png/vE4RmUl5V1jKaisBHoYRhjsy5Q0ybh8
	qAi2Djowrh7Oq1Bc9tkbcDqn+aqp9+g1G5zMULaTcmgJg4kUm+chkyHm8Fi8AGdo9IzzwwG3zWLD+
	xdHJqPmYKDpzHyuMLStZWZDsa83mBej5wEurrRzd3rlJOLFGojS7TA2Wec0dfJMNLF81ifeDv625B
	w5E7lXpn7rRUneaRxLFArHDdqJXfyJYNOpyKMB86VnnbkN23n69nnZgLvMeyKaIv1OfrVaKuT7Ito
	VZwkhokA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wfgCJ-009VUy-1E;
	Fri, 03 Jul 2026 15:52:59 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 03 Jul 2026 08:52:50 -0700
Subject: [PATCH] workqueue: annotate racy sum_exec_runtime reads for
 CPU-intensive detection
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-wq-sum-exec-runtime-v1-1-a26062e6de8b@debian.org>
X-B4-Tracking: v=1; b=H4sIANLaR2oC/x3MQQ6CMBAF0KtM/ppJKg0YexXjgoxfnQVVW0ESw
 t1JeAd4KyqLsyLJisLZq78zkpwagb2G/KT6HUnQhrYP5xD1/9U6jcqFpmXKPx+pg7GzvovxQkM
 j+BQ+fDnW623bdlqZ1ztlAAAA
X-Change-ID: 20260703-wq-sum-exec-runtime-ace5c65339ec
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739; i=leitao@debian.org;
 h=from:subject:message-id; bh=o8mTIMRJH34m5FZmVqFv7hKqLsaCcbxqNUxsi944LOg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqR9rY8LLOvq8ms9b6zS9r3a5t4j9U6RnpqU1RE
 jeeQOYo8DmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakfa2AAKCRA1o5Of/Hh3
 ba/PEAClj/9XwQh0/Q70QRADXRQJrVh96QkRcNk1kgFWGNESIsgcby/KCzbbIDM+3bLDLSx0+pJ
 jf/qANO9h/5ppkD7tZBxmPv3syDMH/4yC5zl/+BtQGUpu4yRgb6dJwfdt5E3WkT155tOFa3O+4x
 oEddqnr1Q9uuencpeC07VWEGbUZvquyWig6QY4NFHBjXRyuRdawgq7jyVJcbDxW3gjHtrchUoWF
 1TQGyMEHC9yH3vkgVF8GTGl53GgzPub9pNSfCtOth7sjiP/E8Oaw+oG8F7tkX3jJ24tiBSYCHXj
 I+Dv6rvOaWsF60t5/fJB2TABGIjabynrsjyOjMiNLeua4xjFWyu6wms+CvtffzkYl3WJBpJRizt
 KLd/aw2rxUx53iPDzU1dB3HIkV4E1cdRrqguyjgRnEZTC8v5W9fa4InktJT/dKgLKLgva/c/OJ0
 5v2pMtcSajqWn3LXkpAw7/qe0/gNrJLnI9g/0A5/TIKnEGIrYpWDGDx2CBpG3SAwdl2vfpgeEIf
 tKfzoRsBOB6wIZYLcfZZKrGD7Bmcp2KEGhzcCkWUBdujzrFxGKFmNJZb6IrrTQoDfP7IB4mXmEb
 wlNmKqGaZsKQEuFzGdelUU4PxeDy+gaJD4x57FKC7i0YUR9IZIYkMtf8hYfWd99E77BPuKuLjkw
 pRe0S9ToGb245hA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

The automatic CPU-intensive work item detection reads the worker task's
se.sum_exec_runtime without a lock in wq_worker_running(),
wq_worker_tick() and process_one_work(). The scheduler updates that
field under the rq lock (from the tick via update_curr(), or cross-CPU
via task_sched_runtime()), raising:

  BUG: KCSAN: data-race in wq_worker_running+0xa8/0xe8

  race at unknown origin, with read to 0xffff0009a11d1df8 of 8 bytes by task 238535 on cpu 68:
   wq_worker_running
   schedule
   schedule_preempt_disabled
   __mutex_lock
   mutex_lock_nested
   cgroup_bpf_release
   process_one_work
   worker_thread
   kthread
   ret_from_fork

  value changed: 0x0000000088482ba0 -> 0x00000000884893c0

The value only feeds a heuristic, so the race is benign-ish. Unlike
commit ecf5aad9a441 ("workqueue: annotate racy PWQ_STAT_CPU_TIME update
in wq_worker_tick()") that only needs data_race(), these are plain reads
whose result drives a subtraction and comparison, so use READ_ONCE() for
a single, non-torn load, which also silences KCSAN.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/workqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0ffe104fe213d..c85a158696acf 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1468,7 +1468,7 @@ void wq_worker_running(struct task_struct *task)
 	 * CPU intensive auto-detection cares about how long a work item hogged
 	 * CPU without sleeping. Reset the starting timestamp on wakeup.
 	 */
-	worker->current_at = worker->task->se.sum_exec_runtime;
+	worker->current_at = READ_ONCE(worker->task->se.sum_exec_runtime);
 
 	WRITE_ONCE(worker->sleeping, 0);
 }
@@ -1553,7 +1553,7 @@ void wq_worker_tick(struct task_struct *task)
 	 * We probably want to make this prettier in the future.
 	 */
 	if ((worker->flags & WORKER_NOT_RUNNING) || READ_ONCE(worker->sleeping) ||
-	    worker->task->se.sum_exec_runtime - worker->current_at <
+	    READ_ONCE(worker->task->se.sum_exec_runtime) - worker->current_at <
 	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
 		return;
 
@@ -3294,7 +3294,7 @@ __acquires(&pool->lock)
 	worker->current_func = work->func;
 	worker->current_pwq = pwq;
 	if (worker->task)
-		worker->current_at = worker->task->se.sum_exec_runtime;
+		worker->current_at = READ_ONCE(worker->task->se.sum_exec_runtime);
 	worker->current_start = jiffies;
 	work_data = *work_data_bits(work);
 	worker->current_color = get_work_color(work_data);

---
base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
change-id: 20260703-wq-sum-exec-runtime-ace5c65339ec

Best regards,
--  
Breno Leitao <leitao@debian.org>

