Received: from mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC42D73A6
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247286; cv=none; b=bpGUCdb7FUKtCK625PGjbHI7lRXT8HfpKW7Y2LKd6QpT+m1+2+LLUoBkVO3cGuhqzqVSoVay1JvA3uOa4+H9Ojjx9um3jThRQYg38WBA29Gc17oPf+qlVG6jivvgJzmoryTIdCBnmo/rXDcUyHq6QdTrR0d5dO1qjb7vB8pDQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247286; c=relaxed/simple;
	bh=zlRml5dbBrFYpndsKRAi6GKAzb3il6oIIuaUt6OBrmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVqFIUK/hzcYBjbZapxUgfpqU/6nnkPWZepmdNljjLDJ+LSRyy7zc4yICW9wkhf2Xg4Y5rGjqNKtlblG2z5vWp5hI0ApeD1jmMudQ+uYAYV1BT0i0hFIaTyErSq6plq6yzCV+90otRvMV4vxvur0l8WbaLTJgdrdXh/M+sxZiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EwaUkp4y; arc=none smtp.client-ip=91.218.175.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EwaUkp4y"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zlRml5dbBrFYpndsKRAi6GKAzb3il6oIIuaUt6OBrmo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792247282; v=1; x=1792852082;
 b=EwaUkp4yIDxtqqYQMSyq8+JMv6sGQTT0tZpAme7O5tEdYH8KeA/RwCTmUkWfL2UQvNz6jv4W
 luqsIIOOy2sURv2ngcz6RtX/3SnTKaVWc8ZveI3uEu52FnfQGXo3SxYYW2f27kOeWOVpZ7yK3wZ
 UGL7qRkWTA5qHvFtic6bA1DA=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5e1f2d513015c2b1;
	Sat, 17 Oct 2026 14:28:02 +0000
X-Mizu-Trace-ID: 5e1f2d513015c2b1
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
Subject: [PATCH bpf-next 5/6] libbpf: Add bpf_link_create_log API
Date: Sat, 17 Oct 2026 22:26:48 +0800
Message-ID: <20261017142649.51047-6-leon.hwang@linux.dev>
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

Add a new API to accept the log opts, instead of extending the existing
struct bpf_link_create_opts.

In the struct bpf_link_create_opts, it seems not proper to append a
tailing common log field prior to those variant length fields.

Add a new API to avoid breaking the struct bpf_link_create_opts.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/lib/bpf/bpf.c      | 24 ++++++++++++++++++++----
 tools/lib/bpf/bpf.h      |  5 +++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 17e73e443bc7..eb127d71f3c8 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -788,9 +788,10 @@ int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
 	return bpf_prog_detach_opts(prog_fd, target_fd, type, NULL);
 }
 
-int bpf_link_create(int prog_fd, int target_fd,
-		    enum bpf_attach_type attach_type,
-		    const struct bpf_link_create_opts *opts)
+static int __bpf_link_create(int prog_fd, int target_fd,
+			     enum bpf_attach_type attach_type,
+			     const struct bpf_link_create_opts *opts,
+			     struct bpf_log_opts *log_opts)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, link_create);
 	__u32 target_btf_id, iter_info_len, relative_id;
@@ -965,7 +966,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 		break;
 	}
 proceed:
-	fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
+	fd = __sys_bpf_fd(&attr, attr_sz, BPF_LINK_CREATE, log_opts);
 	if (fd >= 0)
 		return fd;
 	/* we'll get EINVAL if LINK_CREATE doesn't support attaching fentry
@@ -999,6 +1000,21 @@ int bpf_link_create(int prog_fd, int target_fd,
 	}
 }
 
+int bpf_link_create(int prog_fd, int target_fd,
+		    enum bpf_attach_type attach_type,
+		    const struct bpf_link_create_opts *opts)
+{
+	return __bpf_link_create(prog_fd, target_fd, attach_type, opts, NULL);
+}
+
+int bpf_link_create_log(int prog_fd, int target_fd,
+			enum bpf_attach_type attach_type,
+			const struct bpf_link_create_opts *opts,
+			struct bpf_log_opts *log_opts)
+{
+	return __bpf_link_create(prog_fd, target_fd, attach_type, opts, log_opts);
+}
+
 int bpf_link_detach(int link_fd)
 {
 	const size_t attr_sz = offsetofend(union bpf_attr, link_detach);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 826d9cc9ab65..dedaf8086902 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -484,6 +484,11 @@ LIBBPF_API int bpf_link_create(int prog_fd, int target_fd,
 			       enum bpf_attach_type attach_type,
 			       const struct bpf_link_create_opts *opts);
 
+LIBBPF_API int bpf_link_create_log(int prog_fd, int target_fd,
+				   enum bpf_attach_type attach_type,
+				   const struct bpf_link_create_opts *opts,
+				   struct bpf_log_opts *log_opts);
+
 LIBBPF_API int bpf_link_detach(int link_fd);
 
 struct bpf_link_update_opts {
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index eeba4072a5da..990e2f926ecc 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_link_create_log;
 		bpf_map__attach_cgroup_opts;
 		bpf_prog_stream_open;
 		bpf_program__add_flags;
-- 
2.55.0

