Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617181;
	b=OHIE6R9e0IsJsxPe7TFk9UJL2EriWEOx/RIbEX6mGbVcfvJCmv5Ix+aa8UJ0qaQVcxnV
	 atURueMnybg01Tpg5k0hySIdnMlG0YlQNEg+ix2TJLX9XcFab/zAhQTZu8CUGe4jYBs1S
	 wObY2FZ9ihsXlT6rbEVHVraYdxWQIXgp0RlA9LSPYQxb8bj48VtZ+Ukx6+tkLICmJQuyW
	 2D/VO4ogrAy3Qr9YkQHhdT4J98AsLsexnJJdwWWshexVAM3dyC6z21mPGjI2zgn68Mw4d
	 UHhHzXwlcH5R/GTPuYvyv+s4HpB6iqV8k7cjAJNfpsGPFSbn2dlug5iL3eSsn4QXTng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617181;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=512KT+dszHg+efwS3BYuJV7mtcBzhHtr0Z9hlCoHSL0=;
	b=MvTQHsnKKT6/KNwClbLp3EjL0bap4XeuxD32tbIu7FoJHfuBq2ZmOjDEnEfBsErcmeKJ
	 5bGyUN2526hHYrhoSz0mM8QHuhso3nl642lll1qtLoUv8ABnDArdwjtaqngERJr2oOMcD
	 mj2CWIQZwy84UaCixPvqCTJDriJqj6rYRYDIqz5H2TkwsaK8RPUtSVemPGvIKxXDFPIcu
	 ah4OX8fl9Y6KotJZnMPo9tDH24qfiHRr9LkEjBdSvjYtF1BxQ9LZ5A6/iRkJE9FK8iiHf
	 0Q6K1rI16Zp4utYsVjWdUs1LsG8Pvvnte+BJkVGLHR2ywvhRV4f5w8N2Lk9EnjmHBDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FW5+uWxd;
	arc=none smtp.remote-ip=95.215.58.15
Received: from mta1.migadu.com (out-15.mta1.migadu.com [95.215.58.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82A5606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C82A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FW5+uWxd
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z4IB+Ki3a8PjnrMq6MarlatYObpvI30K+1qs+OUo6t0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795617179; v=1; x=1796221979;
 b=FW5+uWxdIs+vo91DNV8wRdMW1ndH78gwe5LDKAgBEzL61M4+TLLjYsV2RZgdWAHROFHcvZWP
 YkTnbHYbtMGxiVxPI+7d1DbI6tIBQ1fTg82nJ28Ab8gPh4sfPVp0ApWwLPy+2/SfhmTZpWgdVjI
 SeWBPX8/ia9XFi7GK1wLJ/Vw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aba4313b7db095e1;
	Wed, 25 Nov 2026 14:32:59 +0000
X-Mizu-Trace-ID: aba4313b7db095e1
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
Subject: [PATCH bpf-next v4 5/6] libbpf: Add log_opts support for BPF_TRACE_ITER
Date: Wed, 25 Nov 2026 22:31:37 +0800
Message-ID: <20261125143138.47174-6-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125143138.47174-1-leon.hwang@linux.dev>
References: <20261125143138.47174-1-leon.hwang@linux.dev>
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

Add iter.info and iter.len to pass iterator information separately from
log_opts. Keep the existing iter_info and iter_info_len fields working
for callers that do not request logs.

Thereafter, log_opts can work for iter link_create.

Meanwhile, add log_opts support for bpf_program__attach_iter() API.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c    | 23 +++++++++++++++++------
 tools/lib/bpf/bpf.h    |  8 ++++++++
 tools/lib/bpf/libbpf.c |  5 +++--
 tools/lib/bpf/libbpf.h |  3 ++-
 4 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 38dcb31e8c0e..ad6b356cc48c 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -808,11 +808,6 @@ int bpf_link_create(int prog_fd, int target_fd,
 	if (iter_info_len && attach_type != BPF_TRACE_ITER)
 		return libbpf_err(-EINVAL);
 
-	if (iter_info_len)
-		iter_info = OPTS_GET(opts, iter_info, (void *)0);
-	else
-		log_opts = OPTS_GET(opts, log_opts, (void *)0);
-
 	/* validate we don't have unexpected combinations of non-zero fields */
 	if (iter_info_len || target_btf_id) {
 		if (iter_info_len && target_btf_id)
@@ -821,6 +816,22 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 	}
 
+	if (attach_type == BPF_TRACE_ITER) {
+		if (iter_info_len) {
+			iter_info = OPTS_GET(opts, iter_info, (void *)0);
+		} else {
+			log_opts = OPTS_GET(opts, log_opts, (void *)0);
+			iter_info = OPTS_GET(opts, iter.info, (void *)0);
+			iter_info_len = OPTS_GET(opts, iter.len, 0);
+			if (iter_info_len && target_btf_id)
+				return libbpf_err(-EINVAL);
+			if (!OPTS_ZEROED(opts, iter))
+				return libbpf_err(-EINVAL);
+		}
+	} else {
+		log_opts = OPTS_GET(opts, log_opts, (void *)0);
+	}
+
 	memset(&attr, 0, attr_sz);
 	attr.link_create.prog_fd = prog_fd;
 	attr.link_create.target_fd = target_fd;
@@ -970,7 +981,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 		break;
 	default:
-		if (!OPTS_ZEROED(opts, iter_info_len))
+		if (!OPTS_ZEROED(opts, log_opts))
 			return libbpf_err(-EINVAL);
 		break;
 	}
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index fe3b7fd8512b..2ac143fd1102 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -422,6 +422,10 @@ union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
 struct bpf_link_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 flags;
+	/*
+	 * iter_info and iter_info_len are deprecated, use iter.info and
+	 * iter.len instead.
+	 */
 	union {
 		union bpf_iter_link_info *iter_info;
 		struct bpf_log_opts *log_opts;
@@ -478,6 +482,10 @@ struct bpf_link_create_opts {
 			const __u64 *cookies;
 			__u32 cnt;
 		} tracing_multi;
+		struct {
+			union bpf_iter_link_info *info;
+			__u32 len;
+		} iter;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd37b2e..612eba0ff4f0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -14813,8 +14813,9 @@ bpf_program__attach_iter(const struct bpf_program *prog,
 	if (!OPTS_VALID(opts, bpf_iter_attach_opts))
 		return libbpf_err_ptr(-EINVAL);
 
-	link_create_opts.iter_info = OPTS_GET(opts, link_info, (void *)0);
-	link_create_opts.iter_info_len = OPTS_GET(opts, link_info_len, 0);
+	link_create_opts.log_opts = OPTS_GET(opts, log_opts, (void *)0);
+	link_create_opts.iter.info = OPTS_GET(opts, link_info, (void *)0);
+	link_create_opts.iter.len = OPTS_GET(opts, link_info_len, 0);
 
 	prog_fd = bpf_program__fd(prog);
 	if (prog_fd < 0) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 49f1120f4021..56300be81016 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1000,8 +1000,9 @@ struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	union bpf_iter_link_info *link_info;
 	__u32 link_info_len;
+	struct bpf_log_opts *log_opts;
 };
-#define bpf_iter_attach_opts__last_field link_info_len
+#define bpf_iter_attach_opts__last_field log_opts
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_iter(const struct bpf_program *prog,
-- 
2.55.0

