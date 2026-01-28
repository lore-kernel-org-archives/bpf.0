Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F17318EEA
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619467; cv=none; b=svhLFhI0I0asd1ywJX40ztU/rmGVUKP81AtTTl6lpx6xgfDz1DhYnAOPVD77jF/WUNk2m88EqIOzRPxNTvE47wHMAQxEKfFXjOC8G5OnXn5pA2r2WfTAr/JmyLQWGf7Miiets68s9QMkeBbnQ+QarVBBsOYhfq4GFB/1N9zQlgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619467; c=relaxed/simple;
	bh=Xy7l4IlBMtdLVWEB1jQFsT2TwL189a03RVDzG0zKLaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7fq+Bi2ZGo0GnwGPXgDohRNI2UDuDlepsIKePxbckubqFv58brea0vHbyBJLUzMx/TmkAvPw1UTRtQH6mQ+TgA/jhYALfLpXJQ9Zy3dRaWaewmf/dyO6HJnD8SEKZ7tFVJuwM6ck28SU1bE3wuS53+LB7Or03U8kSjbtuuq54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aIsWDTqp; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aIsWDTqp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769619463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CNtNv8rSuyb0z68K1rJhYYJu0H3XVoM8UAx9pK28RfA=;
	b=aIsWDTqpJkGeg95V8d4OQJADHv7uXvd085isyj0LXZbKxMfK3e1p7amWNvSylY7L5Vp5PN
	X9EnfN8+nq6MGjl+8eOFDe+1i586IeXjgBYmUBRXkIISXTI6QatdlZywKBfCSRH2Jpl1Nm
	jXbSH0+sXAIVdjZMqftDHWbdC0RzcFY=
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
Subject: [PATCH bpf-next] bpf: Remove RCU lock for perf callchain buffer
Date: Thu, 29 Jan 2026 00:57:10 +0800
Message-ID: <20260128165710.928294-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As Andrii suggested, BPF can guarantee perf callchain buffer won't
be released during use, for bpf_get_stack_id, BPF stack map will
keep them alive by delaying put_callchain_buffer() until freeing time
or for bpf_get_stack/bpf_get_task_stack, BPF program itself will hold
these buffers alive again, until freeing time which is delayed until
after RCU Tasks Trace + RCU grace period.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c1..2e682d8697b 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -460,9 +460,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
-	if (may_fault)
-		rcu_read_lock(); /* need RCU for perf's callchain below */
-
 	if (trace_in) {
 		trace = trace_in;
 		trace->nr = min_t(u32, trace->nr, max_depth);
@@ -473,11 +470,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 					   crosstask, false, 0);
 	}
 
-	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
-			rcu_read_unlock();
+	if (unlikely(!trace) || trace->nr < skip)
 		goto err_fault;
-	}
 
 	trace_nr = trace->nr - skip;
 	copy_len = trace_nr * elem_size;
@@ -493,10 +487,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		memcpy(buf, ips, copy_len);
 	}
 
-	/* trace/ips should not be dereferenced after this point */
-	if (may_fault)
-		rcu_read_unlock();
-
 	if (user_build_id)
 		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
 
-- 
2.48.1

