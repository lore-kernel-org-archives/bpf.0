Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F813790B;
	Thu, 16 Jul 2026 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167318; cv=none; b=b+ouiMrILJnoMuO9vw1Fjg9kFefXUdir/3xaINLMMc4KClavYo2D2/Art+tm1Je8O2l3pt7YsuMLUY4p0tyXyVx2Qy5Co84cd70CZZ5WYSGpSbOyPBdyXUuAh5bWljUlGaM+5qdpCh/XLPAmV1h4TZmR84Bc7QS7H2b4bSnBh+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167318; c=relaxed/simple;
	bh=fQvG+29OPpS0hs1pFNibLWE3JNce3z+tLujnh8X9ROo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fChUFtWNfBkKFSDD+I8g/NuI70p6s+fOyk9tmbynZks9hinLEKU810SKm5Jg3zGrRsuplvFyXDnGiKnjmjE/z3lEFdGmn5d5RyZAW3m7/+nmHnApXHKtHtqur0dQPEwpqXEKG0o3bEpp/8Cw9LW3E8NaXtB9dDJlkODLwhy9UUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=ixFsLIuV; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="ixFsLIuV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7Fu5ur1jltM/99yFY7HLM908TyDhs8x760PAntSVxQk=; b=ixFsLIuVJXjGfoMFChvTr1vEW/
	EL8m47ACN3F4SKPjHFahbV9ZNvL9tpnV25c1TCG4HKFXHEwZXnzFULv4jfhP6Dt9bRCpzB1y1n9bD
	iC1YPXT6VWBjgN+EhZHccCFE0n7XDTpvzg4oGMpZXWUUPZa0HqHZY3AAP6GfGs5ldVL26V9O/j8+7
	wRsPTtIP9HPa9qPMST7s9JYFue3nfHjVkgUeRfg8GsWGW5qBL2x8cDJtA2wyTA4PNhufoQX/snQw3
	GKpEKktNzecP2RiRXN3FtWPMrP9PPPTfWJVjqf3k0bsjeO3KssLz5+O3YuimIxE4/beZXfI6183vw
	xxxOFupg==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wkBHm-000000008H8-25Y1;
	Wed, 15 Jul 2026 21:53:14 -0400
Date: Wed, 15 Jul 2026 21:53:13 -0400
From: Rik van Riel <riel@surriel.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kernel-team@meta.com, Andrii Nakryiko <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH + QUESTION] bpf: use cond_resched_tasks_rcu_qs in 
 bpf_fd_array_map_clear() loop
Message-ID: <20260715215314.44423f47@fangorn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

syzkaller creates a PROG_ARRAY with huge max_entries and triggers perf
tracepoint open close in parallel. The hung task detector reports
"INFO: task hung in perf_tp_event_init" with event_mutex held waiting
for synchronize_rcu_tasks().

bpf_fd_array_map_clear walks max_entries under RCU read lock on a
workqueue kworker. Commit 4406942e65ca added cond_resched for classic
RCU, but under PREEMPT it is a no-op and a preempted kworker never
reports RCU-tasks QS. The loop then blocks the grace period while
event_mutex is held in ftrace_shutdown, stalling perf_event_open().

Use cond_resched_tasks_rcu_qs to report RCU-tasks QS independent of
preemption model. The grace period completes and event_mutex is
released normally.

Fixes: da765a2f5993 ("bpf: Add poke dependency tracking for prog array maps")
Fixes: 4406942e65ca ("bpf: Fix RCU stall in bpf_fd_array_map_clear()")
Cc: stable@vger.kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Assisted-by: Claude:claude-opus-4-8
---
QUESTION: should we change cond_resched() instead, so it unblocks RCU
in any preempt configuration where cond_resched() is a noop?

That would take care of every bug of this shape with one change,
and rcu_tasks_qs() looks cheap enough?

 kernel/bpf/arraymap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..55fd97375130 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -1015,7 +1015,8 @@ static void bpf_fd_array_map_clear(struct bpf_map *map, bool need_defer)
 
 	for (i = 0; i < array->map.max_entries; i++) {
 		__fd_array_map_delete_elem(map, &i, need_defer);
-		cond_resched();
+		/* cond_resched() is a noop with preempt; unblock RCU */
+		cond_resched_tasks_rcu_qs();
 	}
 }
 
-- 
2.53.0-Meta


