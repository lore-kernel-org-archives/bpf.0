Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604674;
	b=CcYmgTVFQsJdFX+rvYxW3IdCOVf2tUDSXL5oU1R6LPh63mzlrDhEC9X/2P6IynDbyWk7
	 5sMXDuTRDuTipA9l4nhEVSDTMnv/FNu6NJjq4Dc1R8Vusj6cPExT0SUngO041awm5dAHu
	 +EoFE61fxT08rCx01kvdRtyYDCN76O90OSDW7zCPQ9ALdK4rHKJl8zoq6gASr0xSWSGiv
	 y02sRKgHy1rfIJyyBD4KyBx8OXYOFLYtRciEiBacd55Ydx2aJzDoy1FKhgQLhtCAfsxEv
	 tOh49Tep+MB4J6RPskjbVnhzFK2ojXp2Sbn8grsD1hz4/k0TzTZ0G6n91haY6BANgRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604674;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CrbQvaheVnGVHulUMcA8yjaKoTe8xjFM+3iVN2PxY5Q=;
	b=mauTsFuLI9qXRxUeZoV/GwzT+ONeXFqDwSF775XsbIMqwFyq6feiZ4RJakgyjDWP2GcS
	 W/QzAKcw70P1IUfD4U+UCzXIabWzmw+V+pjkv2Tj5/IZY/jD3NrUMsSdNVKBI21Hopjt9
	 HiRZf1gsCy4IkIHSfiyaZDuOXnCMNFcoBE/cU6zafo414+4TUI61Ud/ESwNxjLEE9ep9z
	 VqlQoiaHPzXgUQiyMuYlfSUKOpIxTeFY4qbAK03x7Sv/Zb9ZvRGf7U9wzJkLeNEPAIgtb
	 X6R7vnjlgQX2vaXbuCMpSqP0lVjD2YIGQIwXcSfCDe8zPy/RlIZnDWY/Mjm8ypJXNrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j9OO8fsD;
	arc=none smtp.remote-ip=91.218.175.7
Received: from mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25772606A31D
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 17:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25772606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=j9OO8fsD
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gzQQsJPuIUKqQmkp2GndF+kkdcenF51ADI84PnJQfJs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792604672; v=1; x=1793209472;
 b=j9OO8fsD3QvShz8b87kWWn3+D2jiLTV+y79AcTqWLj2XBuwCqd1esy9yr/XXaN9nL5PXddgv
 5uYBfFiWMG8WSqIzVmx1auiyiqWMvZQTnA2qQc42vOuROw9c6I2kS1Z+gW3V55ErLkAHjmPtyiz
 t1XNwTFgnWj1je1HdmJkVq5c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c25dbf7ea97f94ab;
	Wed, 21 Oct 2026 17:44:32 +0000
X-Mizu-Trace-ID: c25dbf7ea97f94ab
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
Subject: [PATCH v4 2/2] tracing: fgraph: use scoped_guard() for the task list walk
Date: Wed, 21 Oct 2026 10:44:06 -0700
Message-ID: <20261021174406.2891598-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021174406.2891598-1-vineet.gupta@linux.dev>
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_retstack_tasklist() open-codes rcu_read_lock() and unwinds it
through an unlock label. Use scoped_guard(rcu) instead and let the
compiler emit the unlock on every exit path.

The -EAGAIN case now jumps straight to the free label rather than to
unlock; leaving the guard's scope releases the RCU read lock on the
way, so the unlock label has no remaining users and is removed.

No functional change: objdump of fgraph.o shows identical call targets
and counts, including the three __rcu_read_unlock() sites the compiler
emits for the exits from the read-side section. A PROVE_RCU +
DEBUG_ATOMIC_SLEEP build with the -EAGAIN path forced several thousand
times is clean.

The preceding patch deliberately left this alone so that it stays
straightforward to backport. This is the follow-up.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Tested-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 kernel/trace/fgraph.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 4c74f1a15ad4..bbf6e4e2da2d 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1057,32 +1057,31 @@ static int alloc_retstack_tasklist(unsigned long **ret_stack_list)
 		}
 	}
 
-	rcu_read_lock();
-	for_each_process_thread(g, t) {
-		unsigned long *rs;
+	scoped_guard (rcu) {
+		for_each_process_thread(g, t) {
+			unsigned long *rs;
 
-		if (t->ret_stack)
-			continue;
+			if (t->ret_stack)
+				continue;
 
-		rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
-		if (!rs) {
-			if (start == end) {
-				ret = -EAGAIN;
-				goto unlock;
+			rs = kmem_cache_alloc(fgraph_stack_cachep, GFP_NOWAIT);
+			if (!rs) {
+				if (start == end) {
+					ret = -EAGAIN;
+					goto free;
+				}
+				rs = ret_stack_list[start++];
 			}
-			rs = ret_stack_list[start++];
-		}
 
-		atomic_set(&t->trace_overrun, 0);
-		ret_stack_init_task_vars(rs);
-		t->curr_ret_stack = 0;
-		t->curr_ret_depth = -1;
-		/* Make sure the tasks see the 0 first: */
-		smp_store_release(&t->ret_stack, rs);
+			atomic_set(&t->trace_overrun, 0);
+			ret_stack_init_task_vars(rs);
+			t->curr_ret_stack = 0;
+			t->curr_ret_depth = -1;
+			/* Make sure the tasks see the 0 first: */
+			smp_store_release(&t->ret_stack, rs);
+		}
 	}
 
-unlock:
-	rcu_read_unlock();
 free:
 	for (i = start; i < end; i++)
 		kmem_cache_free(fgraph_stack_cachep, ret_stack_list[i]);
-- 
2.53.0-Meta

