Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029886;
	b=BC+OLHsnpQpOw5XVlWrfgY6Qc0i3QXElnxiSmdccoTEdzed6Ma+IIzS10ghhSzMbaj9O
	 fIU2Ny2pxHZcoK4AzLNwPPg0kI602FX1juN3lOi3pANA6fqx04SyaveLCJIC/wlnq4e3Y
	 7xYX4+Mist4p2rwhcpj0HkPI6ofTplIlARYnaZVdOEh2RkkXwj4Ho5nzpXKP0e0fOMj1F
	 M6ujHn+HQy8MbXqkkXcRZUI5qcTfgI3UTQH0dxLiRps4ta0CYFIpDQ6YnrYJqJGedLDKN
	 /+vby6jfq6NTK3qAkdveuSuX5DNiA5UTRBdp6nqIeDbG2L1du6mJQV+HkT6j8wviSfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029886;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mGQUdaMvrAQl7LUJK52CVpNScjDWZf7NR9O1ie1VPgA=;
	b=1p8LWg4j6Sge9PfBDPmp5C3/uoHCLjx4nOLh7uiPdknorZCV6Ru9YbKFPpJUThFDd4uq
	 qm7X22EL7SCNJGViL5VIlkiRTGHG0Vy7T7i3P6FJCSvhhHTRKWUJL0aFo4d/WfLgpmON7
	 8XYnboCGYSB8TGRsB3NFaY0/K/5XaVcsTEhyL2ylDd9iyi6OTzfNAkp3OfJ+3ayvxQVii
	 NqJEBMNUTwSIfN8bOqtskPJ1oTZgy3BZlhuVjSg+5N9YRd4Lq2FjCjtGec5uwRK7TRa27
	 q6EyYh5BJh+W+50xlLF2QjJ1dtJGg63Ftma3NnArQd3dmc5i1t3+7GF4ZQuyxLRIY9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=io8n62I4;
	arc=none smtp.remote-ip=95.215.58.51
Received: from mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B40606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B40606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=io8n62I4
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dOQiRvzPvYkiRnvO/E3S8t3ISqp1ABryLlrOSe2Nass=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793029883; v=1; x=1793634683;
 b=io8n62I4qQM+w4eTOKlYt/E9yqBpGbpWlZH/p6HJhRlC0wwD4mtqUOL1S94yiIWv7Iq9jZ4H
 B+m8kyF7AwWerap1IGdYw/dcNbKsy8P5uLu4d0L2DP79HyWjEFgXF9GiW60Kz3oT620S5RENJO8
 vz4g2lJdtHCEm6pP/auYLVxg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 28b38ef0fefe3957;
	Mon, 26 Oct 2026 15:51:23 +0000
X-Mizu-Trace-ID: 28b38ef0fefe3957
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Masashi Honma <masashi.honma@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v5 5/6] libbpf: Add log_opts support for bpf_link_create
Date: Mon, 26 Oct 2026 23:49:46 +0800
Message-ID: <20261026154948.99408-6-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026154948.99408-1-leon.hwang@linux.dev>
References: <20261026154948.99408-1-leon.hwang@linux.dev>
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

Since the iter_info and iter_info_len in struct bpf_link_create_opts are
legacy, reuse the slot of iter_info to place log_opts.

When adding log_opts support for iter link_create in the future, we will
move the iter_info and iter_info_len to the last union, see below. And,
keep the backward compatibility meanwhile, that uses iter_info if
iter_info_len is set.

struct bpf_link_create_opts {
	/* ... */
	union {
		/* ... */
		strut {
			struct bpf_iter_link_info *info;
			__u32 len;
		} iter;
	};
};

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 20 +++++++++++++++++---
 tools/lib/bpf/bpf.h |  5 ++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index aea534764dfe..38dcb31e8c0e 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,6 +794,8 @@ int bpf_link_create(int prog_fd, int target_fd,
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, link_create);
 	__u32 target_btf_id, iter_info_len, relative_id;
+	union bpf_iter_link_info *iter_info = NULL;
+	struct bpf_log_opts *log_opts = NULL;
 	int fd, err, relative_fd;
 	union bpf_attr attr;
 
@@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
 	iter_info_len = OPTS_GET(opts, iter_info_len, 0);
 	target_btf_id = OPTS_GET(opts, target_btf_id, 0);
 
+	if (iter_info_len && attach_type != BPF_TRACE_ITER)
+		return libbpf_err(-EINVAL);
+
+	if (iter_info_len)
+		iter_info = OPTS_GET(opts, iter_info, (void *)0);
+	else
+		log_opts = OPTS_GET(opts, log_opts, (void *)0);
+
 	/* validate we don't have unexpected combinations of non-zero fields */
 	if (iter_info_len || target_btf_id) {
 		if (iter_info_len && target_btf_id)
@@ -824,7 +834,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 
 	switch (attach_type) {
 	case BPF_TRACE_ITER:
-		attr.link_create.iter_info = ptr_to_u64(OPTS_GET(opts, iter_info, (void *)0));
+		attr.link_create.iter_info = ptr_to_u64(iter_info);
 		attr.link_create.iter_info_len = iter_info_len;
 		break;
 	case BPF_PERF_EVENT:
@@ -960,12 +970,12 @@ int bpf_link_create(int prog_fd, int target_fd,
 			return libbpf_err(-EINVAL);
 		break;
 	default:
-		if (!OPTS_ZEROED(opts, flags))
+		if (!OPTS_ZEROED(opts, iter_info_len))
 			return libbpf_err(-EINVAL);
 		break;
 	}
 proceed:
-	fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
+	fd = __sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz, log_opts);
 	if (fd >= 0)
 		return fd;
 	/* we'll get EINVAL if LINK_CREATE doesn't support attaching fentry
@@ -975,6 +985,10 @@ int bpf_link_create(int prog_fd, int target_fd,
 	if (err != -EINVAL)
 		return libbpf_err(err);
 
+	/* bpf_raw_tracepoint_open() does not support log_opts */
+	if (log_opts)
+		return libbpf_err(err);
+
 	/* if user used features not supported by
 	 * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
 	 */
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 826d9cc9ab65..fe3b7fd8512b 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -422,7 +422,10 @@ union bpf_iter_link_info; /* defined in up-to-date linux/bpf.h */
 struct bpf_link_create_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 flags;
-	union bpf_iter_link_info *iter_info;
+	union {
+		union bpf_iter_link_info *iter_info;
+		struct bpf_log_opts *log_opts;
+	};
 	__u32 iter_info_len;
 	__u32 target_btf_id;
 	union {
-- 
2.55.0

