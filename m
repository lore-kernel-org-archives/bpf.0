Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569B3B3C1B
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314352; cv=none; b=eoysj4cIXxNhsgNvZoYvsoObCS5Q4YdK/Fm8EJe/hIoePf+CUatkyqWNFVQ1bPvXnrzfCcYaczi0FarB3ARYPIaRSUVbi+WA81elGyqOTLM+dQvMIaLiuWVLk2uGR5O0+IKNMtcbYMLwMb8hL2ANF3Jr7z1Dba5RwudWDoeD9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314352; c=relaxed/simple;
	bh=T205AUdPayribOZqBvYLnLv020WIXnd0JMgu02Y8k9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSrei9UgIfEI/XpP6JNvV8EOwyHK4F5h3/W2C2Tx5My1XgM3Am3KO/PQ4GLcFR3qts+anLd0uiJ0QhSwOo4rsS2z4yy7MlN7PpRyDrhr0amQ1dBhT6n0rv/cKs9LkGFnpEZsEpF1FWiXtFylnwpt01uNAY899E9GlUIhwQB/FPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ww/ofA2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww/ofA2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363A61F00A3A;
	Wed, 29 Jul 2026 08:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314351;
	bh=tvmt0+llmSdQHc8mLqoQ2jtu5h+fuX++KvXHTYDtMBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ww/ofA2IwSvCXohPhQXP9SEGjjPaqjA0pBD/W9x7gj87ufXwiP+Igj1Q6udzfPhhk
	 ZL0ag4cfKBwKqycw6u0foqVrKg6pt+HydBZsmPj2y0DVaG4uZpKe5OZXyulbKrbWM1
	 I3LsOd6azTq34NgCxsvueBUQ1hITt9MGY5b8D5u2rPTM4ee45WIQtwGvD1+boDwZIv
	 hAAlH7XVYQ1mfaFUjEtN7+5FDn0xE35PP8Sxpq8AgqmjpR9TNxGgmkBpOh7Iml6/Op
	 njS9M4cHrsM4tYW1+QdGWo/yI7fjusYkh9OCDS03D+JxrTBoSJ0eCQdo5+BXMtB9/C
	 /Kzd4kDDW7K6Q==
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
Subject: [PATCHv2 bpf-next 06/11] bpf: Factor callchain_store function from __bpf_get_stack
Date: Wed, 29 Jul 2026 10:38:02 +0200
Message-ID: <20260729083807.1588544-7-jolsa@kernel.org>
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

The new callchain_store function stores trace entries buffer into
user supplied buffer. It covers both just-ip and buildid data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index e48ddb4edd47..18b3db5c1fb9 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -746,6 +746,29 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
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
@@ -758,7 +781,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
 	int err = -EINVAL;
-	u64 *ips;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -803,21 +825,10 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
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

