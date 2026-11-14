Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794668803;
	b=x+mOn9H3lmz14E3TokssNocoblPtRID6ctCebYHpY7nX8Ex9za2dqfcKYDsEr1s1GQ12
	 xZwhuGwkb2nMwi4JAiT34UhpWSm2IeQEDCE3yiYYe0OmcbHBBq3Szf9qRphA3YwL7dmHA
	 2lPFxssk+7M0Yl6BET2GnippEUJawkItTWV00bK3r8slpuGDDYtWymbPiMlQ9DfSULJK6
	 acmtNPRN7HdBEHAe2o5qJAmnaQS64jd1n5v8wHfujxw7emti78lwpfOdfdBv9xAIgjnN6
	 f+D4DOLinTGBfZX9YRM9Afal4/Qa5tLjYfwbazXe0Ad3wQuwM9hGGWo2Inw/vERRp9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794668803;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EebCx3KLdBVrhi6ZniiPVGIFYXZ1ZuZMHtX/uCQHf4w=;
	b=FBjEkLmWpS2k28+KuFPqW9Zy5jrZHJP9L8Nr2p4Lc+odSVGaNOFYTTMZFYaxyTYlQuNO
	 IW9r6g0iPXMk9Kq8+awKngMFDMfonRWFoV9tA+kG9jjMl3g6NRd2yGbYcp7akXW2sz7Ul
	 C3Zm+9iDoMIwI6Jc45uAi+UFjd9WfSOb3bBXYf5M5wRjC/dLZgVlJRNGSOIgCxRNM2XZv
	 NQp6zl7Z7jEiT982Lpc1U5wupQeQas4UeBQYERwLgVNjnrWiguRbeNeZPOZ56otKrH7XR
	 B3fty8F9YIp9Y7rpy33Lmp61m02szHVex/cn7ATcahcooM3gJ8Ffuj6fGM8GT6ZM78Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xes1Lx4T;
	arc=none smtp.remote-ip=91.218.175.2
Received: from mta0.migadu.com (out-2.mta0.migadu.com [91.218.175.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49109606A329
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 15:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49109606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xes1Lx4T
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PO6QFDVMBoljIYWyqUFVKzEvVAiwpcUFVHXoA8wm8S8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794668801; v=1; x=1795273601;
 b=xes1Lx4T04YaQ1E7a14uxPPiBajRXZIM2/6GkXPqEkd8gfWlHqgol345rXhfe/vnoixwHicS
 aRh0eU4lKshUXUSSLgLb4MP3Csr8T6cMY+EGRfQ3CSDNjpB/tAWhVOADQJAxKiMif4jPS7tzvsV
 c7dbVtd5XxDP/dhkPwQGhy/A=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id de7231f92c90d303;
	Sat, 14 Nov 2026 15:06:40 +0000
X-Mizu-Trace-ID: de7231f92c90d303
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
Subject: [PATCH bpf-next v2 2/9] bpf: Add log support for tracing_multi link_create
Date: Sat, 14 Nov 2026 23:06:03 +0800
Message-ID: <20261114150610.84507-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261114150610.84507-1-leon.hwang@linux.dev>
References: <20261114150610.84507-1-leon.hwang@linux.dev>
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
index cf6bf3765b3d..3c7bedced354 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5933,7 +5933,7 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr, struct bpf_common_a
 		else if (prog->expected_attach_type == BPF_LSM_CGROUP)
 			ret = cgroup_bpf_link_attach(attr, prog);
 		else if (is_tracing_multi(prog->expected_attach_type))
-			ret = bpf_tracing_multi_attach(prog, attr);
+			ret = bpf_tracing_multi_attach(prog, attr, log);
 		else
 			ret = bpf_tracing_prog_attach(prog,
 						      attr->link_create.target_fd,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index b4ff9d4e86b3..a3964d7c9497 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3911,7 +3911,8 @@ static int check_dup_ids(u32 *ids, u64 *cookies, u32 cnt)
 	return err;
 }
 
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			     struct bpf_verifier_log *log)
 {
 	struct bpf_tracing_multi_link *link = NULL;
 	struct bpf_tramp_node *fexits = NULL;
@@ -3925,12 +3926,26 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
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
@@ -4001,7 +4016,8 @@ int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
 
 #else
 
-int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
+int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr,
+			     struct bpf_verifier_log *log)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.55.0

