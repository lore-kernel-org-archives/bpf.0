Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7263B6BFA
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537707; cv=none; b=RyX8Af1lYKT22ejkYQHF6SHd8NVv/JGaqaqkh7SiiyVArGuXeGd/fZJomodYFSh1k+PeK4Ehd0abVcg3Bx3+1VSVa8XK8svwUXTdjtxZSlk+FSZT85mh4Xxfm0sgy8e2YbKu20hBuBz7QTSzl42TCU0JcqoNvuU3mxVG0YxH9zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537707; c=relaxed/simple;
	bh=BIfjCWMStcPBouEgBE1sbsNlNp0zzMeE8/XYDxr4tdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOdK1MZgu8rcJzUCARvXbT0v9qVCKv8TEAJ6ZDflRl/D8R+FCjIh3tn96Lgu4TpyC0D42meOULmT+uEsOYLtsfxf3YGt/vznRogIFGu3csWXK4xw9rtv0ZxLEWtz6UPAF+qncc4y6jcA9+V5hM61T234L/vw9LHMDgCUt6yRjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqJ33m1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqJ33m1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B004F1F000E9;
	Mon, 20 Jul 2026 08:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537706;
	bh=swSrEkSbY8KimggYoTVtul+Mo5FXEDsx470MSFv0gBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jqJ33m1R27rk11zNpfCTz3RSkRRXe8WUq0PQ90BG6S68lhUBt6V8+w3pBpSDnoCvc
	 09M4gAEFrC1rccsr5dhFSdNSzWTWFkoXYnyQk1TdSg0bQnuNcPRJy3DAfroeyA7y0u
	 q3z+1N09nSC6QaoGtRoqviAbYj3R4Dx71eNTGBascNbBA5sGJ+bd6zwXk1TMCgsIRK
	 9xsv2nV+n1/1f1a8WYl1c6FiN3KVwTGrclbOZuTo+nUOZQYcdiE9/ZCp1oHRIJ+WJP
	 NsNH9ItOzHVAXfffkHx2af3dI2aolfOqVSGFVegSMyHZUd12TMr1l4ssBmA6Ejwmbo
	 Gvz7F1gPyM1Gg==
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
	STAR Labs SG <info@starlabs.sg>
Subject: [PATCH bpf-next 7/9] bpf: Factor callchain_finalize function from __bpf_get_stack
Date: Mon, 20 Jul 2026 10:53:49 +0200
Message-ID: <20260720085351.655075-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720085351.655075-1-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
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
index b990643f25cd..eea7b781300c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -770,16 +770,29 @@ static u32 callchain_store(struct perf_callchain_entry *trace, void *buf, u32 si
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
 
@@ -827,18 +840,12 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = callchain_store(trace, buf, size, elem_size, flags);
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

