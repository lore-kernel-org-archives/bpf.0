Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2181A306B08
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790957; cv=none; b=sne/Le/SpeX5etnyrNNzI6dHqNNEeuglgNcGmhCj0+qb3W5VeeoNslcHeViLdLk/oXUdff7DLLfbXp9qOaFNiRn7ZqGvaPoe8NivlSlQha3wWDOVHcwPkDjTldYpmyA1v2cRi1Ab6tEEBFq4guACSIWcqdNrBILlPj5Z0EHHU3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790957; c=relaxed/simple;
	bh=HvtNCDj49dgFvhp3wom9wsy9zpflN1CxtCBa7W0JESo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkRxZ+VOzywfvR7hEDUgfRWCGiQWvYkkK09JbiW4jcXh6BcYyexcwYSVhyYoVv60sKbqYlMX9xc3PBA71pSSKnvuhop2IqfkzO8EqVNowww6gbf9COHNuSJIJ3NXFe8bCP8cLzvldc9Lgh5lIrtXrz3ZchgD1YyTvVdFJs/cMFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPSAAQrj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPSAAQrj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83F91F000E9;
	Mon,  3 Aug 2026 21:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785790955;
	bh=Lp9lWB4MpbVcAxvqIWu5ifkaYSpYAw1xzolskJ6j4Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPSAAQrjIwkPOp/N1hUzt0xJ9N4PpqszgQ1FMyybGafeBH28DwH2dwfJkyCX7yZpW
	 RsB3QpHveGE+vFdFjbYKafeT4QlvzKyhivGzvJELvaCwuvpuvKi39PUJf7lw1NMLp6
	 gnl0eTBBxcBHF1NAvVHhtPdW2UWoWBfxKOIDphtkYwISU35/V5OrY4J8v7ymhlqDCH
	 B9fSGtAIbyLQYvA+nEbwpNbkkVJm3G7jI+Jon2cPPIuWxbtHwNB5xlHOXXpj5Y5WF/
	 k9pAFj3ZnVzHxi4nbv+0koLuHNE5x5/LSWQy89SRfeTHyOsBC6zmnYDNRpTGFau2U+
	 Mcd5CAj2dtRvw==
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
Subject: [PATCHv3 bpf-next 04/12] bpf: Use stack id functions instead of __bpf_get_stackid
Date: Mon,  3 Aug 2026 23:01:41 +0200
Message-ID: <20260803210149.296496-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803210149.296496-1-jolsa@kernel.org>
References: <20260803210149.296496-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing __bpf_get_stackid calls with sequence of following functions:

  stackid_fastpath
  stackid_new_bucket
  stackid_install

This makes code more structured and allows us to easily disable
preemption only in bpf_get_stackid in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index d930d9754d7d..3ee0034daf52 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -584,22 +584,13 @@ stackid_new_bucket(struct stackid *stackid, struct bpf_map *map)
 	return bucket;
 }
 
-static long __bpf_get_stackid(struct stackid *stackid, struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+static long stackid_install(struct stackid *stackid, struct bpf_map *map,
+			    struct stack_map_bucket *new_bucket, u64 flags)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
-	struct stack_map_bucket *new_bucket, *old_bucket;
 	bool user = flags & BPF_F_USER_STACK;
+	struct stack_map_bucket *old_bucket;
 	u32 trace_len;
-	int err;
-
-	err = stackid_fastpath(stackid, map, trace, flags);
-	if (err != -ENOENT)
-		return err;
-
-	new_bucket = stackid_new_bucket(stackid, map);
-	if (!new_bucket)
-		return -ENOMEM;
 
 	if (stack_map_use_build_id(map)) {
 		struct bpf_stack_build_id *id_offs;
@@ -629,10 +620,12 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 {
 	u32 elem_size = stack_map_data_size(map);
 	bool user = flags & BPF_F_USER_STACK;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel = !user;
 	u32 max_depth;
+	int err;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -646,7 +639,15 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(&stackid, map, trace, flags);
+	err = stackid_fastpath(&stackid, map, trace, flags);
+	if (err != -ENOENT)
+		return err;
+
+	new_bucket = stackid_new_bucket(&stackid, map);
+	if (!new_bucket)
+		return -ENOMEM;
+
+	return stackid_install(&stackid, map, new_bucket, flags);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -674,6 +675,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	   struct bpf_map *, map, u64, flags)
 {
 	struct perf_event *event = ctx->event;
+	struct stack_map_bucket *new_bucket;
 	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel, user;
@@ -701,7 +703,6 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 
 	if (kernel) {
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -710,12 +711,22 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(&stackid, map, trace, flags);
 	}
 
+	ret = stackid_fastpath(&stackid, map, trace, flags);
+	if (ret != -ENOENT)
+		goto out;
+
+	new_bucket = stackid_new_bucket(&stackid, map);
+	if (new_bucket) {
+		trace->nr = nr;
+		return stackid_install(&stackid, map, new_bucket, flags);
+	}
+	ret = -ENOMEM;
+
+out:
 	/* restore nr */
 	trace->nr = nr;
-
 	return ret;
 }
 
-- 
2.54.0

