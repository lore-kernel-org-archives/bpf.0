Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769F3AFCEE
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314361; cv=none; b=n7ZBTVK+NeiuF5c7sBtqCgd6xNaIJR5UtTe7VAqV6G3Chq+zrAPhzTr4WLkkB42K6nBS/s3WN1GhVS9qT2t21sQI2LZE8uGBpz9NbPCpR/L3Yk7vYXxGwu1eqAZWKXqKVSs/8LOLgAQljpZQIYFhXS8kwdB8aAGUb4GzxdZtvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314361; c=relaxed/simple;
	bh=7gPggpOEzIIOWetD28ict+mXupJuQ8GNpxjfXqhYe0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZrtdmEJqif6/Bn65rudOfpbAdzhTSzj11wXhX0otKIyldCJ0vjAUlHUDoNhJSZY6IyZ/V/4CsTPPXfmw/hx5OvWmm/VYRxGjkUv29d3tDPvWtFhChW3QuJk5jUvXA7z/VfSIfc7fw/U7LWRqYbdnGKn8UOyRMHwGwc3fvBg/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr0dTr0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr0dTr0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E421F000E9;
	Wed, 29 Jul 2026 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314360;
	bh=nFKnQSyfbszVGlApGE1MbY6DC03BTB8G3TcwLdX+rbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hr0dTr0UkszXzqHj2kLCTR6rguDdtxc+X/qxw4cLMfINf5YcFTfC5+gpFqWgbDAJ9
	 VbrShP0CqA10OB6eqI/8iucohKOoPoFbTdifd5K4MGAwHeS78XLAoXTnqkl/JOGlUC
	 0K2YvJ3Q8AS2bFLNjd8fFtRqDR83lmpZyX/ejz5bKTGsEWgom2Y1cumn7gNsWul5vs
	 pfmaQdWw3lJ4Y1R32mZIeK7NRs1G+m6UQiKTxFvjMtPAXsi6fw6orU6mKb7oO0F8nE
	 dyH10S+car2v+tyFgdyNLaGxyZcOoP6PEfX/IO1pVAfitdodGojZhiYnDoMg6m70T+
	 iRIm0AqjW3LXQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv2 bpf-next 07/11] bpf: Factor callchain_finalize function from __bpf_get_stack
Date: Wed, 29 Jul 2026 10:38:03 +0200
Message-ID: <20260729083807.1588544-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729083807.1588544-1-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new callchain_finalize function calls the build-id retrieval
(if needed) and zeroes the buffer.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 18b3db5c1fb9..05269f2a9e08 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -769,16 +769,29 @@ static u32 callchain_store(struct perf_callchain_entry *trace, void *buf,
 	return trace_nr;
 }
 
+static long callchain_finalize(void *buf, u32 size, u32 trace_nr, u32 elem_size,
+			       bool user_build_id, bool user, bool may_fault)
+{
+	u32 copy_len = trace_nr * elem_size;
+
+	if (user_build_id)
+		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
+
+	if (size > copy_len)
+		memset(buf + copy_len, 0, size - copy_len);
+	return copy_len;
+}
+
 static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
-	u32 trace_nr, copy_len, elem_size, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
+	u32 trace_nr, elem_size, max_depth;
 	bool kernel = !user;
 	int err = -EINVAL;
 
@@ -826,18 +839,12 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = callchain_store(trace, buf, elem_size, flags);
-	copy_len = trace_nr * elem_size;
 
 	/* trace should not be dereferenced after this point */
 	if (may_fault)
 		rcu_read_unlock();
 
-	if (user_build_id)
-		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
-
-	if (size > copy_len)
-		memset(buf + copy_len, 0, size - copy_len);
-	return copy_len;
+	return callchain_finalize(buf, size, trace_nr, elem_size, user_build_id, user, may_fault);
 
 err_fault:
 	err = -EFAULT;
-- 
2.54.0

