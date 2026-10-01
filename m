Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA24C33DE
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850575; cv=none; b=gAAocglUoeV264qHsSrbSthd8tzRHn8sbn+lBTFvSE5/hANzXBghYs6mjVdGgkLUZPzhs5lTBbAJLbjcO/YTTdzEBJ0mbd7nrr0mJeM/MM1VjAn4b7arJWjLFy249sUK8vbC2FelpGNuCHqASd54NtnXuOC8sflvU6QnBzKOpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850575; c=relaxed/simple;
	bh=j0DTB35JN7w3qoE4dsr+0qEQkdEFJWnqgYt85R35l2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re4htDEitJJkSS/NxG3FRTZp8Jz+AJG6+QHr/rz4gDHD6xJ84mhjJgEWTDEMH9pBP+s1Yl3CIPWlsiHxSGgNL09K2a33XSSFzaUEcgd421F+yFgGYh3G5/0RbBASR0mohlUAzYOQKuFzEKLVkoCicgk2hAgUe6O9iUQ7zklL5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ghkUP+Kk; arc=none smtp.client-ip=95.215.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ghkUP+Kk"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j0DTB35JN7w3qoE4dsr+0qEQkdEFJWnqgYt85R35l2k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790850570; v=1; x=1791455370;
 b=ghkUP+KkcZtesnf+8otH9691zX7aZk2GJagEeuvcoXlbC0dLyKP8QDUdrJL6ADlbmtlv5ps5
 7z3ToPgXoY/pFdy+xs3dR64TL/LEcKFaTuTYSQtbFWdP+dZhJ5rFdVS1CcmCxUeFNxUDzeBQP2i
 C0l58il6vnNJMVYpL/jXojsY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9a1e96d489a4a683;
	Thu, 01 Oct 2026 10:29:30 +0000
X-Mizu-Trace-ID: 9a1e96d489a4a683
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	andrii@kernel.org,
	peterz@infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH v3] tracing: fgraph: fix the quadratic shadow stack walk
Date: Thu,  1 Oct 2026 03:29:08 -0700
Message-ID: <20261001102909.1152572-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_retstack_tasklist() assigns a shadow stack to every thread when
fgraph is enabled. It did so FTRACE_RETSTACK_ALLOC_SIZE (32) tasks at a
time, and since for_each_process_thread() has no cursor, every sweep
restarted from init_task and re-walked the tasks already served, making
the ftrace_graph_active 0 -> 1 transition quadratic in the thread count.
On a 60-core Sapphire Rapids machine with 400000 idle threads it took
227 s, inside a single bpf() syscall for the kprobe_multi case.

Allocating inline with GFP_NOWAIT removes the batching: a single sweep
serves every task, 227 s -> 0.092 s.

v1: https://lore.kernel.org/all/20260922225526.1554758-1-vineet.gupta@linux.dev/
v2: https://lore.kernel.org/all/20260929005411.4105448-1-vineet.gupta@linux.dev/

Changes since v2:
 - update the stale alloc_retstack_tasklist() comment, which still
   described the old batch-of-32 behaviour (bot+bpf-ci)

Sashiko flagged the mix of goto-based cleanup and scoped_guard() in
this function. Peter and Andrii both considered it fine as is, so it
is unchanged:
https://lore.kernel.org/all/20260929080346.GR4120091@noisy.programming.kicks-ass.net/

Changes since v1:
 - replace both v1 patches with Peter's inline GFP_NOWAIT approach,
   which removes the quadratic behaviour rather than dividing it by a
   constant. With a single sweep there is no retry loop left, so the
   v1 cond_resched() patch has nothing to attach to and is dropped.
 - comment why returning from inside scoped_guard() skips the free
   loop safely

Vineet Gupta (1):
  tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT

 kernel/trace/fgraph.c | 44 ++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.53.0-Meta

