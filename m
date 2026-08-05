Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA43F8EA7
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922189; cv=none; b=WZb5KXXvzwrUAxIdiddpY3xi1cLIdEVgFKPd/eUYcXpa3S7A6N985nGxubyioAjewBh++In1uy1oHpp1qWoKNK1+JDcuEyO94UfBMIns+dsuzDw2GKyJ5NroeqM9uG9yQwZ5+cPp8FIGsyxtPCHDFakJG36G5aHgQvfrJutdMvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922189; c=relaxed/simple;
	bh=5kqDttDE1vrryg5omJVBsxs39uEJNXVWgWzg7RkiXz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWyeuvfUhWlQFqUg/bqoILylqBNGhZP3xkZa4QEgL+6tFgFWKJ9eSjWKQRtFzNblOCSxduRrZO5z9ZsU/HxjVw3JmHXYlEuDSiAJkLH2LZEqpfj80ddHTbceH1c5w9tzN5MEtZbLB09DcKvkW6mcaFnIyXoOVEN5jW7gUchmDQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm0a0wnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm0a0wnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157D31F00A3A;
	Wed,  5 Aug 2026 09:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922187;
	bh=tlqHmSfFg0miJAgIQG7Pn3LMAaHpm7NuX0vbHIDBeIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lm0a0wnrsWbiUUaUcvjkrOx+YoacPTXbVUVHPJv/lPcnXeMNlmEH9XyPQbmv3shvM
	 j3kpH24C+p/59gZ6A2CgOd9LI/OCQR7h1wkfZ0ZyaGIWieJS6QrndLiopJTXMWjygW
	 EZRbT1mmHm4EN0wfdgKCp8Kx4tdgidunHoDQgUjJWWB0QqVxgesXupYzFnA2pk9TjX
	 M/Ja3+7rn0uRHMEteHGFaz3wMjncRHU6sNZiMnveQlEw1aFHpUDibvAfqL9SZst7Ts
	 ihsmdZS2guTdbq8E1HbmCQq459+wbqT+SdC9JLc+xBdWQaq6JXTfJx2kgMh1f0UibP
	 oqkW2zmlaMGEg==
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
Subject: [PATCHv4 bpf-next 06/12] bpf: Factor callchain_store function from __bpf_get_stack
Date: Wed,  5 Aug 2026 11:28:37 +0200
Message-ID: <20260805092843.516315-7-jolsa@kernel.org>
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

The new callchain_store function stores trace entries buffer into
user supplied buffer. It covers both just-ip and buildid data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 5b18d728f4b8..ee9905d67b8e 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -741,6 +741,29 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+static u32 callchain_store(struct perf_callchain_entry *trace, void *buf,
+			   u32 elem_size, u64 flags)
+{
+	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
+	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+	u32 trace_nr, copy_len;
+	u64 *ips;
+
+	trace_nr = trace->nr - skip;
+	copy_len = trace_nr * elem_size;
+
+	ips = trace->ip + skip;
+	if (user_build_id) {
+		struct bpf_stack_build_id *id_offs = buf;
+
+		for (u32 i = 0; i < trace_nr; i++)
+			id_offs[i].ip = ips[i];
+	} else {
+		memcpy(buf, ips, copy_len);
+	}
+	return trace_nr;
+}
+
 static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
@@ -753,7 +776,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
 	int err = -EINVAL;
-	u64 *ips;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -798,21 +820,10 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto err_fault;
 	}
 
-	trace_nr = trace->nr - skip;
+	trace_nr = callchain_store(trace, buf, elem_size, flags);
 	copy_len = trace_nr * elem_size;
 
-	ips = trace->ip + skip;
-	if (user_build_id) {
-		struct bpf_stack_build_id *id_offs = buf;
-		u32 i;
-
-		for (i = 0; i < trace_nr; i++)
-			id_offs[i].ip = ips[i];
-	} else {
-		memcpy(buf, ips, copy_len);
-	}
-
-	/* trace/ips should not be dereferenced after this point */
+	/* trace should not be dereferenced after this point */
 	if (may_fault)
 		rcu_read_unlock();
 
-- 
2.54.0

