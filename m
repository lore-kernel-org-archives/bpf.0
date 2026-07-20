Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D933B7767
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537697; cv=none; b=CNHuYNDOO4pHh1tyzaRTYCNZHOu9VJgUNIS6/W0lL4ZsWl6N6RlR2sx5RP59Z39swPxwJVNLJ7jDOHX5sUCK6rTBCtjL2AzxLrOLo6Xku/OGNcB8uwOekisCUdWgd0LGoqsIedc5V356gfUJPyfqHNIcHnBLZX6eD0kbgCdKe2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537697; c=relaxed/simple;
	bh=MOCostllfOrX4flOPscTjG9QxQDcCZ6ecRTH94iy74U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9EQpO5fi1ypjXZzjMVuWJuT3yDxTEPCrt5/DZ/ztttR+eU18IaFgOl2P/8XGLSK8IHPBns5WEPw1v6Yxg2uW/EukOGFA+IEqlPSym4PwIvYgn3s7BJp/YBEH/+j82NjsBo3yhn9K7QebqmqqGra1yl7pZr0AQcC8IYLTLyv+Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD15vkqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD15vkqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AEF1F000E9;
	Mon, 20 Jul 2026 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537696;
	bh=eRtjnoY5Bw8TU8gO5Ljgy7YOniR4ptlceUO+xEykv2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CD15vkqiUxutTpOnZTrkR7WF+J8DlsAEkPpND3Uw/BVNGSkQzvAQKMlasAk1iQBCP
	 XYL4xLoe7s0x9eL5+/U/iQ/v/YOTUPmIeX0qQs1qqDRK4NjUASsMTPgeXw5uUz4ccs
	 YEhx/t4/D2+DqVomXRLkz5ztt/9+7AuWgWejHUlZJU2fpmYJJM1ypoHm8lxzR2tcf5
	 9pGmqOuKKRK4HIRCSgKe7fvjSc7uT3Z2i/ByuhQHqPsruTTVwuh+dGAKpF92VU4Ols
	 RDgh2xlbSqurqW0p6eblljeouNX71xE1/0hXTMPdvHFFy3Gvam9spSz1UTSq6VADRI
	 61HWw+mkCr18Q==
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
Subject: [PATCH bpf-next 6/9] bpf: Factor callchain_store function from __bpf_get_stack
Date: Mon, 20 Jul 2026 10:53:48 +0200
Message-ID: <20260720085351.655075-7-jolsa@kernel.org>
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

The new callchain_store function stores trace entries buffer into
user supplied buffer. It covers both just-ip and buildid data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index a64b14ffd1e8..b990643f25cd 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -747,6 +747,29 @@ const struct bpf_func_proto bpf_get_stackid_proto_pe = {
 	.arg3_type	= ARG_ANYTHING,
 };
 
+static u32 callchain_store(struct perf_callchain_entry *trace, void *buf, u32 size,
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
@@ -759,7 +782,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
 	int err = -EINVAL;
-	u64 *ips;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -804,21 +826,10 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto err_fault;
 	}
 
-	trace_nr = trace->nr - skip;
+	trace_nr = callchain_store(trace, buf, size, elem_size, flags);
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

