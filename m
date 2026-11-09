Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233355;
	b=V34xBk3HWx9uQ8lZyB9eKDdkM0d11ZrwzIPSaLdbRFzm7hM+OddE9VgIJOZAXE+kvuvQ
	 wGXV9sb8uesqhmdckxd7BU/xOPUd9BgOC+xnfr1/6fxjbf1gSofUhSgsneR9hBQ1r7zDW
	 /r6X07gCNDPahKTL45n/2e/pCGOWLeG6EhVfLPgkbQXZlnXvnSNPUpBNNTkX9mBfCxUBU
	 RqcFDEYY+naWz7k8K04eylCjQr2Zr+mvwmKCo8iPY+aROsWjRYIjoCKaXGjWEp/PcO0mf
	 yENLJ7PN+czAa5svv5Kv66sNdCy4bBc2WVWI5/taBnlcohMoOuUCS2JLM8/LQflGqRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233355;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iQ50Z8GrZdVWvlWB3gtz0AyrON7bR4KOzGZo59Q0ECI=;
	b=RYy+kf8aAU8YFy6A9zTKuMkncel5ydmV2EfIDZMpT5tqiZTY5qqAz56n4wnNj9qIenHC
	 FXXhE7t3gHfH4+BqdURrkgqT6wAnXv5ij8GmTbd4SYTFoWUZQZqdVa2wCLwJ4bgT9XS63
	 6qFwGREDpXNkyw7iUy2DZQfop4ALhwPpvZ2cS/b3Ez7/yp1E3b+BlzTmDJhQyQTlnIy7K
	 pBt4FAR2uPeoaAAfIbUHcWEePVnRc0frcjqLTWJ7pwcHQmjLLt8qoUv5MQXlAM4Ir4FeI
	 Ai13Z1kd+oVjrZEwFE9PEraqwTigrFndAMYeepXXxF7H9YkukjPKeoDz7cKoUB+vXmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U7FEH9b3;
	arc=none smtp.remote-ip=95.215.58.111
Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7A606A323
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 14:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB7A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U7FEH9b3
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eInuAVUPIVJ9rBRgFXv1dy5BH1QgCtuQ2/F9w6eAqww=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794233353; v=1; x=1794838153;
 b=U7FEH9b3omA+VvEanH6hiqgA/eWVuZVRl3XkFcaEhHle9eK0HYCaoSs/98ZjFShLw+5kX5/u
 bDxKBHbJzayUfBzGxCun3Fa8bPqnHN3rNfh1JgTBNhk5BFwQz9kmJ0AWa4BYCy0qXS/Jz+KNW5g
 SxtazHX3mzWy9GSb08uzNnbA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7db8cf0a1ec2ca8c;
	Mon, 09 Nov 2026 14:09:13 +0000
X-Mizu-Trace-ID: 7db8cf0a1ec2ca8c
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
Subject: [PATCH bpf-next 5/9] libbpf: Add log_opts support for BPF_TRACE_ITER
Date: Mon,  9 Nov 2026 22:08:12 +0800
Message-ID: <20261109140816.5196-6-leon.hwang@linux.dev>
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

Add iter.info and iter.len to pass iterator information separately from
log_opts. Keep the existing iter_info and iter_info_len fields working
for callers that do not request logs.

Thereafter, log_opts can work for iter link_create.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 17 +++++++++++------
 tools/lib/bpf/bpf.h |  8 ++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 38dcb31e8c0e..174a8bfaf663 100644
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
@@ -821,6 +816,16 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 	}
 
+	if (iter_info_len) {
+		if (OPTS_GET(opts, iter.len, 0))
+			return libbpf_err(-EINVAL);
+		iter_info = OPTS_GET(opts, iter_info, (void *)0);
+	} else {
+		log_opts = OPTS_GET(opts, log_opts, (void *)0);
+		iter_info = OPTS_GET(opts, iter.info, (void *)0);
+		iter_info_len = OPTS_GET(opts, iter.len, 0);
+	}
+
 	memset(&attr, 0, attr_sz);
 	attr.link_create.prog_fd = prog_fd;
 	attr.link_create.target_fd = target_fd;
@@ -970,7 +975,7 @@ int bpf_link_create(int prog_fd, int target_fd,
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
-- 
2.55.0

