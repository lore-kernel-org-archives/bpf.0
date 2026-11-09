Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233321;
	b=OMUiAJ/Qh76juhxaMetIEPolxXr1cv1zoVjI6g77KL2X0O3RAv/fwyOzkFqrDztcvnRu
	 DE4uqLai6nJAaQnRr7KvFH4XnYpMk6EwcsChOauxQe9Za20BFTL3fhdj6edwFxAll5lOu
	 DqkjxDzGdaekFqufeBohHJ8p3RUYl60WgFMjJN/9abBurjp4J+EKaIJn+i44CBLS3cMxj
	 S3WrNi8leDENjAVXsDSWpzXQtVxHrtVsCSoY3SnyE6I2Bw7PGNzNEvLKYvmovY0lJfYjx
	 V1PFnDx/yLBgcFxG1RR+xR6GhGmjobrW6QdGBNqqpuV5v/rEfgk+z8Hh0dTbAQgOfOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233321;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dSTYqBIt3VTPCqTFm0u5zdAmxK7quSdoKDbpFn3GOGw=;
	b=c7LsTtXDv413+M0hScjiMuKJo9/6XbBW4YJCda6yaYlz1l+kj6puAbb83HYgRLHeOY69
	 QDxbRNtyngoU+/3DXqdt7EmCRoQwriTxbKsMBeN1xHOVbJ5b/82Vn2QtVExsTF083hNTu
	 Ufasqf8qy7w/ZKMHXmqheQ6rrVrKDQvKwNm/eJP2hDZoRdM+Toim83UhMklvMJiIr9U43
	 GoLuqo9elb2DOaqz5aeMa217YAKnlbI5b4Ai4TLTdHAOirqxH0CDUILPOmaDnUB4byylJ
	 EMtg+nTDSkHRIrG0wnjl0dNs6Sqze8cRUaSJwc2LQDxBm2JANuy8EK8bZ17YXFRocuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gHTG7gRw;
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81102606A33B
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81102606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gHTG7gRw
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7U2/OuuDKaOLck2npQORVFN+xs78A0M0+SmzLQqXEqI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233318; v=1; x=1794838118;
 b=gHTG7gRwrrPAeBO0NZko3xTKpMCjVHOJE1mu9njQ72aEDYZSB0WziDwz5CFSFu0MGvwgLMca
 2cfu84SOFKpdFANr/qhArJongoWg//eAWXrTrjWgKr7FfBGuqqE0xnJfNF4K46DjQXR9F7HA7O2
 CKZH3H1qofDHcie3IPnQGoFk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ab71e52b82ac4bb8;
	Mon, 09 Nov 2026 14:08:38 +0000
X-Mizu-Trace-ID: ab71e52b82ac4bb8
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 2/9] bpf: Add log support for tracing_multi link_create
Date: Mon,  9 Nov 2026 22:08:09 +0800
Message-ID: <20261109140816.5196-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261109140816.5196-1-leon.hwang@linux.dev>
References: <20261109140816.5196-1-leon.hwang@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tracing_multi BPF_LINK_CREATE returns an error for invalid counts, missing
IDs, unsupported flags, or a nonzero target FD without explaining which
check failed.

Report these failures through the BPF_LINK_CREATE log.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/trace_events.h |  7 +++++--
 kernel/bpf/syscall.c         |  2 +-
 kernel/trace/bpf_trace.c     | 26 +++++++++++++++++++++-----
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 321f2f3a6c8e..bb825ea5d09c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -16,6 +16,7 @@ struct tracer;
 struct dentry;
 struct bpf_prog;
 union bpf_attr;
+struct bpf_verifier_log;
 
 /* Used for event string fields when they are NULL */
 #define EVENT_NULL_STR		"(null)"
@@ -796,7 +797,8 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    unsigned long *missed);
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr);
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			     struct bpf_verifier_log *log);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
@@ -855,7 +857,8 @@ bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	return -EOPNOTSUPP;
 }
 static inline int
-bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			 struct bpf_verifier_log *log)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6147d386b777..aed1c6a2f203 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5932,7 +5932,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
 		else if (is_tracing_multi(prog->expected_attach_type))
-			ret = bpf_tracing_multi_attach(prog, attr);
+			ret = bpf_tracing_multi_attach(prog, attr, log);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2aec56d7f3d3..352a1cd0c863 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3861,7 +3861,8 @@ static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
 	return err;
 }
 
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			     struct bpf_verifier_log *log)
 {
 	struct bpf_tracing_multi_link *link = NULL;
 	struct bpf_tramp_node *fexits = NULL;
@@ -3875,12 +3876,26 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 	uids = u64_to_user_ptr(attr->link_create.tracing_multi.ids);
 	cnt = attr->link_create.tracing_multi.cnt;
 
-	if (!cnt || !uids)
+	if (!cnt) {
+		bpf_log(log, "tracing_multi.cnt cannot be zero.\n");
 		return -EINVAL;
-	if (cnt > MAX_TRACING_MULTI_CNT)
+	}
+	if (!uids) {
+		bpf_log(log, "tracing_multi.ids must be set.\n");
+		return -EINVAL;
+	}
+	if (cnt > MAX_TRACING_MULTI_CNT) {
+		bpf_log(log, "tracing_multi.cnt is too large.\n");
 		return -E2BIG;
-	if (attr->link_create.flags || attr->link_create.target_fd)
+	}
+	if (attr->link_create.flags) {
+		bpf_log(log, "Invalid flags.\n");
 		return -EINVAL;
+	}
+	if (attr->link_create.target_fd) {
+		bpf_log(log, "Invalid target_fd.\n");
+		return -EINVAL;
+	}
 
 	ids = kvmalloc_objs(*ids, cnt);
 	if (!ids)
@@ -3951,7 +3966,8 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 
 #else
 
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			     struct bpf_verifier_log *log)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.55.0

