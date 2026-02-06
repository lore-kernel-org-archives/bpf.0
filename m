Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7430ACE3
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368838; cv=none; b=fSboyDHJDKvb/jeF63QsWb86CrFTKA1bt/4K7nm26UhJnDfQ8gEatmcaHkq5lXWTez8ompnAQoIe2DnjUDaCn0s9gdAB6IjP6qRKMfCcVsu96Hw11xD59CD7RhnpicJEC7k4Ox7sWM12nBrzYeloE6NQvMA4s0ys6KqNCUnofX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368838; c=relaxed/simple;
	bh=8dO1I0IejNJ/z1KjLqgLI11hdMJ6mVZaLmUATdh+5wA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbx9MYYD6lvvaW2poBHyv1Z3fdZsK8+IXgAw3luTvLF8yK9kauddprba9JDegZXHkh4K6MaoqbHVWcpaSmr+SDTlPMYz42P3NhEywX9y/wB5tvI6JDJoZ50qNRwa8QPaoeWQcUgc67IIg4BKnoyjCK48zu7SNYP75LT7uELCm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EVYyNxpn; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EVYyNxpn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770368835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0AsZWhb2+t9HhuxuP/nEZ+TtHKWOUbVVnldjxyY0rks=;
	b=EVYyNxpn/Yca9ZlhEVYkaOPX9W4+Pc1dhepSFrOMqJrgEAx7E6r39oH3N+BD+eaZE2xxLk
	kg1dhDwWxpp7wU5rLW2zuTvCP8hJKLfOTxMcv9yHxvaqzh9Cs7VqCLhPGVxNg0f55/IQCx
	u8Cu8buNu0rDSQofNnge+UR37/NZHOY=
From: Tao Chen <chen.dylane@linux.dev>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 1/2] bpf: Add preempt disable for bpf_get_stack
Date: Fri,  6 Feb 2026 17:06:52 +0800
Message-ID: <20260206090653.1336687-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The get_perf_callchain() return values may be reused if a task is preempted
after the BPF program enters migrate disable mode, so we should add
preempt_disable. And as Andrii suggested, BPF can guarantee perf callchain
buffer won't be released during use, for bpf_get_stack_id, BPF stack map
will keep them alive by delaying put_callchain_buffer() until freeing time
or for bpf_get_stack/bpf_get_task_stack, BPF program itself will hold these
buffers alive again, until freeing time which is delayed until after
RCU Tasks Trace + RCU grace period.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---

Change list:
 - v1 -> v2
   - add preempt_disable for bpf_get_stack in patch1
   - add patch2
 - v1: https://lore.kernel.org/bpf/20260128165710.928294-1-chen.dylane@linux.dev

 kernel/bpf/stackmap.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c1..1b100a03ef2 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
-	if (may_fault)
-		rcu_read_lock(); /* need RCU for perf's callchain below */
+	if (!trace_in)
+		preempt_disable();
 
 	if (trace_in) {
 		trace = trace_in;
@@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
-			rcu_read_unlock();
+		if (!trace_in)
+			preempt_enable();
 		goto err_fault;
 	}
 
@@ -493,9 +493,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		memcpy(buf, ips, copy_len);
 	}
 
-	/* trace/ips should not be dereferenced after this point */
-	if (may_fault)
-		rcu_read_unlock();
+	if (!trace_in)
+		preempt_enable();
 
 	if (user_build_id)
 		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
-- 
2.48.1

