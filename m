Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510138;
	b=lAgmSqILASMgaSfo3JLgBiLvKKTTgw2MqynLaTBpIpFBTs2IgHd3tMYla1t8vMsFk1KQ
	 4hp3hmGEaX6mx8b+1T27S0Op1bzbHZxNa53geAfacFRvaVh9wWtP7LTKPEM4krKzBtf+v
	 dqBkMqGtoo6yLMmMnZ9at5ZokO0Ll6SuDMojmyk6v9OQLJz7yfy2Qrjvx/dBdF3YtmzNP
	 4CfF95Aoye+GpMWihnocsgzCpxelo5Pbk2jkBiajgt9JX4MasTkb5X21Q+urG+MBEpOqx
	 T1Krs8xGmJn7/t0PNi9auGkOxlE4HCCIjqBAX+IvzeDQoZ+ycBWXQHucWghKlyMaE5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510138;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KVTYbR14YYgS4yah5hFkztdQ5rEEHZC+1mz3Q0u1oEs=;
	b=O9peeoWWKpyKxOS26oq1jx8StJikQw5kaw9H3p/iiy7fsmWAJZ6qcT0YzBGO3XLzqRPv
	 EdUEMfBnxQUksUjGSFfXaCVyESkMM24tjuNcsuy3IIqU3SeBHUZE+NUxVwXbksYPPTDox
	 KhXq7LfX1ci143zBn6FIJ1HaJDe3TD6dpLQefXeFHe/tB8IfBZLpW9LjLFuYbrZLBpmo1
	 6YCI/ZCi7gi2NvyN8Xc4OTbQdAz+amE54omU116znBdwf5lu16KXY0HbMddF6ugT5LmWc
	 ak234Q5Ga+hFXb/k4RptbIfN5ciPNSje5yfNsHjeM9uSWOe8rsPWyhyQmipyubOgguA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NF8knTR3;
	arc=none smtp.remote-ip=91.218.175.106
Received: from mta0.migadu.com (out-106.mta0.migadu.com [91.218.175.106])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8D606A31B
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 15:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F8D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NF8knTR3
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CfPc369hGVqKqwx/bCg1l8qsUmx6TMYTOAmZtXg4gRU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792510135; v=1; x=1793114935;
 b=NF8knTR3ea/iqWDsE0wv+BWCvAR+TcnxBFJNOUWfJCQKgdIWZDJKRs0q/nse4LhukqhBKtH9
 t32qjEBEuI20xUEMqr+hLZTFb5GMZwcsMOIJKBk59sHfjaeVZbrsqa0CjQOwfL2zn81u3Tsfr77
 /E0Ned+jY2vRAifaAu3kVfd4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 15d9d3cdf2241a0a;
	Tue, 20 Oct 2026 15:28:55 +0000
X-Mizu-Trace-ID: 15d9d3cdf2241a0a
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
Subject: [PATCH bpf-next v3 4/6] libbpf: Factor out __sys_bpf_fd helper
Date: Tue, 20 Oct 2026 23:28:02 +0800
Message-ID: <20261020152804.39863-5-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020152804.39863-1-leon.hwang@linux.dev>
References: <20261020152804.39863-1-leon.hwang@linux.dev>
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

In the next patch, it also needs to use the extended BPF syscall to
receive the reported log.

So, factor out __sys_bpf_fd helper.

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b49822d212ae..9a2107d4f6d8 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -203,6 +203,30 @@ int bump_rlimit_memlock(void)
 	return 0;
 }
 
+static int __sys_bpf_fd(union bpf_attr *attr, const size_t attr_sz, enum bpf_cmd cmd,
+			struct bpf_log_opts *log_opts)
+{
+	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
+	struct bpf_common_attr attr_common;
+	int fd;
+
+	if (!OPTS_VALID(log_opts, bpf_log_opts))
+		return libbpf_err(-EINVAL);
+
+	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
+		memset(&attr_common, 0, attr_common_sz);
+		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
+		attr_common.log_size = OPTS_GET(log_opts, size, 0);
+		attr_common.log_level = OPTS_GET(log_opts, level, 0);
+		fd = sys_bpf_ext_fd(cmd, attr, attr_sz, &attr_common, attr_common_sz);
+		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
+	} else {
+		fd = sys_bpf_fd(cmd, attr, attr_sz);
+		OPTS_SET(log_opts, true_size, 0);
+	}
+	return fd;
+}
+
 int bpf_map_create(enum bpf_map_type map_type,
 		   const char *map_name,
 		   __u32 key_size,
@@ -211,8 +235,6 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   const struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
-	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
-	struct bpf_common_attr attr_common;
 	struct bpf_log_opts *log_opts;
 	union bpf_attr attr;
 	int fd;
@@ -248,20 +270,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
 
 	log_opts = OPTS_GET(opts, log_opts, NULL);
-	if (!OPTS_VALID(log_opts, bpf_log_opts))
-		return libbpf_err(-EINVAL);
-
-	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
-		memset(&attr_common, 0, attr_common_sz);
-		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
-		attr_common.log_size = OPTS_GET(log_opts, size, 0);
-		attr_common.log_level = OPTS_GET(log_opts, level, 0);
-		fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &attr_common, attr_common_sz);
-		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
-	} else {
-		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
-		OPTS_SET(log_opts, true_size, 0);
-	}
+	fd = __sys_bpf_fd(&attr, attr_sz, BPF_MAP_CREATE, log_opts);
 	return libbpf_err_errno(fd);
 }
 
-- 
2.55.0

