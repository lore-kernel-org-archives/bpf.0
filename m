Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBB30E0FB
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481906; cv=none; b=qrnblNeUxnl3ZL/RQ27plOFlUBJlgO7woD1X6HM0oyqXh4cM13a7MQiXqh1zca30TeDTOytCWhIu2he0YgaqY8ya6eVG1QeUjWQvuh3NRt0M3e1SAlQ9QX8IuCHJlnPxfTSjm0z0C9A2QP8kYsnO9sTblw6ZWQmf2WHkncZWht4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481906; c=relaxed/simple;
	bh=X3zboxeJAOms020zMMLXsjZSmbwOolqLIY8+jYjPq3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDr2sWxzD1XYf+eQZCrkEbVOJ67pmzSWkfwVPv2dNNxj2Tz3gMzrVWNIl6P+N9gUFD7FNc4f5QuF3FmTN9VuIkX3HJimLys7auC1O8OdxZapokU8EMgCBZT+S8hXPJ4kcND/P8VlkWhRySUAkeOOBjoMfAPmn1n1N+Ck8haZI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QbI4wHPQ; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QbI4wHPQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1BqMEOY9X0l6L8QNWTbBYeaa++beJxlVBc9vvQg0ZY=;
	b=QbI4wHPQfRxt8LfCF+viV3xkrlBU6NP5bBWY35N/NkqWng0zJlvecrQMEa1z3u7pww2PWr
	Tv5enAhdzVLQfRrxGb4aYKamVhrbRnhLb2bC3PaWMu7jqL3WSp44XVhQf5aLobBHS07fRT
	yO6H6ZRa3Mi6o/210cWpFLKHLzbagDY=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 10/17] mm: introduce bpf_task_is_oom_victim() kfunc
Date: Mon, 26 Jan 2026 18:44:13 -0800
Message-ID: <20260127024421.494929-11-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-1-roman.gushchin@linux.dev>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Export tsk_is_oom_victim() helper as a BPF kfunc.
It's very useful to avoid redundant oom kills.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Suggested-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8f63a370b8f5..53f9f9674658 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1381,10 +1381,24 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
 	return ret;
 }
 
+/**
+ * bpf_task_is_oom_victim - Check if the task has been marked as an OOM victim
+ * @task: task to check
+ *
+ * Returns true if the task has been previously selected by the OOM killer
+ * to be killed. It's expected that the task will be destroyed soon and some
+ * memory will be freed, so maybe no additional actions required.
+ */
+__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
+{
+	return tsk_is_oom_victim(task);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_oom_kfuncs)
 BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_task_is_oom_victim)
 BTF_KFUNCS_END(bpf_oom_kfuncs)
 
 BTF_ID_LIST_SINGLE(bpf_oom_ops_ids, struct, bpf_oom_ops)
-- 
2.52.0

