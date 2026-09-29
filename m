Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71B384250
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643272; cv=none; b=uz8Vc2Efq6ro/22p7ON9h/Vt+QoCzjr0MQVRzmrHY2IzNyLKVu8SlHIkGyJ8T5vCnuf3uEVzBMiXIodbm65MrCgMTFs5cFtiRHjrW4Ua6JCX4WoiVDBWHXKhWXvlMz7BMTAiCBywcdzMFPTR+RNh1als4bepwR5YhrsZoQACkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643272; c=relaxed/simple;
	bh=/ZN+t8Y7O1ERXt/PK2W2EQrnipLYq8zXZKVAc4oVFWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPvfdEEPtfN1DWCEqIkbz7IQJyTEvlC8qQwxSTvlb8cWiA7P4g4vaEmBPlx2i/rebvaJ/nko86NI467+S7OyShPtKRJsZWQoGY+9n/go387rXxrfiff93MFsJcUdRZYhzS4eUSEyVCgzGA0THs+IwFZBBhGAlabRKFi6Va+kZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BY+SdWJ8; arc=none smtp.client-ip=95.215.58.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BY+SdWJ8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/ZN+t8Y7O1ERXt/PK2W2EQrnipLYq8zXZKVAc4oVFWI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790643266; v=1; x=1791248066;
 b=BY+SdWJ8s5UX8jw6r4m5PAMJFoZ0J2uffIv2g8PoskMyphOuZLMS0EmC75mIFtA6rPWUe1co
 kWRWP/MVvwIhxqPFpzXqzrddW6p34kySRLj3lZViq/7aPKBpcSkfWT670BmzLI02Lep++4+dB/4
 qmkISC2An/lay98nvrxP6YM4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36436f1125b35320;
	Tue, 29 Sep 2026 00:54:25 +0000
X-Mizu-Trace-ID: 36436f1125b35320
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
Subject: [PATCH v2] tracing: fgraph: fix the quadratic shadow stack walk
Date: Mon, 28 Sep 2026 17:54:10 -0700
Message-ID: <20260929005411.4105448-1-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 tried to make the sweep loop cheaper: raise the batch from 32 to
1024, and add a cond_resched() so the walk could not hold a CPU. Peter
pointed out that the loop does not need to be batched at all. Allocating
inline with GFP_NOWAIT is legal under rcu_read_lock() because it cannot
sleep, so a single sweep can serve every task and the pre-allocated
array becomes an out-of-memory fallback.

That removes the quadratic behaviour rather than dividing it by a
constant, so both v1 patches are dropped in favour of this one.

Measured at 400000 threads on a 60-core Sapphire Rapids machine,
PREEMPT_LAZY:

	v1 base (batch 32)      227.8 s     12503 sweeps
	v1 patch (batch 1024)     7.2 s       391 sweeps
	v2 (this patch)           0.092 s       1 sweep

With one sweep there is no retry loop left, so the v1 cond_resched()
patch has nothing to attach to and is dropped too.

v1: https://lore.kernel.org/all/20260922225526.1554758-1-vineet.gupta@linux.dev/

Changes since v1:
 - replace both patches with Peter's inline GFP_NOWAIT approach
 - comment why returning from inside scoped_guard() skips the free
   loop safely

Vineet Gupta (1):
  tracing: fgraph: allocate shadow stacks inline with GFP_NOWAIT

 kernel/trace/fgraph.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

-- 
2.53.0-Meta

