Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F223EA83
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247265; cv=none; b=qp+dVpYQVh0t1n5onLPPo/BRx9py+r1btHoNt87DszL+EFD/8o5bO/rMbDDcL2mwplsM1XKEoNxowrbfVIEM8I6xoshdypXY+j+dDpv563oX2lDxJqbpjTrswVtHkgINIDH9rhbCk2dA6HfWPhtHIzXRvsNQTY3nnwCbgiN/ZS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247265; c=relaxed/simple;
	bh=hSujJ52xS1JOB8Ox6F1d3dWK4L7mKvijJ1KMhCmuqe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsYEppMpCOYRjh8IkIeY4TsOMJNhAWrVDf2nt1zdIv38SHJ0HZF2TYJhml0BX3iNm8MNM4UZ5Oyayfqxr4DpTk04SCye3rAt7A6s2Sjyn3zMreOMNGzklG5DmNBqXfESisTx5JXRTcTWKfCmkmlL0NLGQxmNC+cxNTm0xpfjTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cqQYumwD; arc=none smtp.client-ip=95.215.58.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cqQYumwD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hSujJ52xS1JOB8Ox6F1d3dWK4L7mKvijJ1KMhCmuqe4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792247261; v=1; x=1792852061;
 b=cqQYumwDz1NhjP9TsQ2/Oj8HK8tZIzmp0U4rMBfl2WLwTf1fptH+YqwI35XZvLldhJ/f4+S5
 m1bPtchM8rC1bEy6fA+mxqD5/Pv869wR7IzHGaW2GCr7ymM4oNwU08ox25YpUd2EsqKZ2q79rnU
 6RGsqNYr+vPLS9A8PAw9DOjs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1de47e8b36eb255a;
	Sat, 17 Oct 2026 14:27:41 +0000
X-Mizu-Trace-ID: 1de47e8b36eb255a
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
Subject: [PATCH bpf-next 4/6] libbpf: Factor out __bpf_sys_fd helper
Date: Sat, 17 Oct 2026 22:26:47 +0800
Message-ID: <20261017142649.51047-5-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017142649.51047-1-leon.hwang@linux.dev>
References: <20261017142649.51047-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the next patch, it also needs to use the extended BPF syscall to
receive the reported log.

So, factor out __bpf_sys_fd helper.

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b49822d212ae..17e73e443bc7 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -203,6 +203,27 @@ int bump_rlimit_memlock(void)
 	return 0;
 }
 
+static int __sys_bpf_fd(union bpf_attr *attr, const size_t attr_sz, enum bpf_cmd cmd,
+			struct bpf_log_opts *log_opts)
+{
+	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
+	struct bpf_common_attr attr_common;
+	int fd;
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
@@ -211,8 +232,6 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   const struct bpf_map_create_opts *opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
-	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
-	struct bpf_common_attr attr_common;
 	struct bpf_log_opts *log_opts;
 	union bpf_attr attr;
 	int fd;
@@ -251,17 +270,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 	if (!OPTS_VALID(log_opts, bpf_log_opts))
 		return libbpf_err(-EINVAL);
 
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

