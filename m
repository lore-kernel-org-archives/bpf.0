Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4A346AC0
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922199; cv=none; b=uvV7CI7d9rBTRhrtRfGtcwtZWR/ZVUap8mkSXemeRULwREY8zUHLXQA2Q+UXkcRyiNOgfgDHahplSAlEQhVQfPg1wZoEUTXF5ZkguQuL8W4Ti/pE/DXodXKKttz53pJSPQ/Eto2lBrR5fborMnx3LjzI6+G6kuPXqbvz8PJ//o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922199; c=relaxed/simple;
	bh=NM0CCFQUCiHhsVQH9bBGQVL885iap3Mwz1SYGNNGjY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR+UEf6hWFop+q86FaqeIyEOb+GDK1qHq9/fyoYwo8zK8Cw7f/ol/4Qg6lmY5Fmx15WEEcAFdf5DMksOSVhsMAn1PLWbGdR0n0huAC/a8oPuYRBeMFyqBCXiB/9Ppy9uoIo7Fy9+XmMO91d5iIdzC4dfON418rIySLC+8P81uG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYZ8LKiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYZ8LKiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0621F00A3A;
	Wed,  5 Aug 2026 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922197;
	bh=XHj5Ye397xeC2DSzEpy1uMTkvozUF1c20AbZUwhOk78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bYZ8LKiIc4AchVxul9EKe9YRDGc9KIW+I0904D8/2tRA9iIC+zQaKMpNKe3NelDHH
	 zZZAUZ41ttQ2Pj2rRAG31dFvrjDjhLCkRIntkpKXEsWTD3kJWc0z6zW1QvtkNg4+2U
	 7YAXu0yuKRl2KKApDkXOEbtyKo0I+lpoaMAcJDegbX6BquN5ymzoDBrjwh+W8uYhoq
	 rkh5wKVjIJZkQPmVnfIPvms0fAULcZL9rRI/QscZLxe26hH1Y+7UkvzduxVkfTgPkA
	 XyC2pQGXrAdNMvTUPS1Gc7UOc8INnomQQu/jRoPJeK+D18Jz9tlQ2jPM/uUqS/kyQM
	 BOXUH61GsjXPg==
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
Subject: [PATCHv4 bpf-next 07/12] bpf: Factor callchain_finalize function from __bpf_get_stack
Date: Wed,  5 Aug 2026 11:28:38 +0200
Message-ID: <20260805092843.516315-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805092843.516315-1-jolsa@kernel.org>
References: <20260805092843.516315-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new callchain_finalize function calls the build-id retrieval
(if needed) and zeroes the buffer. This makes things easier for
preemption fix in following change.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index ee9905d67b8e..cdeb6c2e50da 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -764,16 +764,31 @@ static u32 callchain_store(struct perf_callchain_entry *trace, void *buf,
 	return trace_nr;
 }
 
+static long callchain_finalize(void *buf, u32 size, u32 trace_nr, u32 elem_size,
+			       u64 flags, bool may_fault)
+{
+	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
+	bool user = flags & BPF_F_USER_STACK;
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
 
@@ -821,18 +836,12 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
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
+	return callchain_finalize(buf, size, trace_nr, elem_size, flags, may_fault);
 
 err_fault:
 	err = -EFAULT;
-- 
2.54.0

