Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424229;
	b=IEKxs3rJywi6p039bjPFKt/KEpFNfZKztshYG/+M1yUJcwdv7pQGsq79I7l92h+lKwca
	 qbfInt47CDbsKqJWNw/5YnoOEdcvP2M8PpU0r6TqWFG2kp/4wE0SighxO0d+p52ahEzgm
	 K7WXmejZZqidmH5hLwU3cWXSAOFGpjj3N9OsKqfXN6szBx4++x7QJVq7gv3THmn6Yy9oU
	 vTKVuvSAq9oZQIzClpJwBinqr4PIWh3AW7oprIp7M83GIaEKGlnNPFCFIB+iSz7taq6RG
	 1eA0NhlBwrJpbBhmjdN94mRNHd4ssfErwOPrna92V6T4Lqvslzm5Qo1tL0Ac7F83hTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424229;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TNedbBYOy/266NwdenfQLWbJ1e1qFOtNO3TwhovjQfA=;
	b=xrIGwd2D91yKbem0dgoXmvHoSi1eo+FdPytNl9TIV3Pj+uVBcfbX8Df8NGSzetP3ZbxD
	 YkFnEv0wYg5hYVYszxOjWKRnwK1ELIbQlM0xwNY0VjJvUiMHaxysjAjSQpb/nlTwNPZy6
	 b8t/8dR/kykR9SE7gSOb/59dK6eaOIVDXXySqxrwNUocvNzaj66FMdOYeQWtw5eNmxP3v
	 ZtJYCA9yvDjmAm34xgnwt0aOA8cbD/ztDX37fsnBPBUN4miSCBNgQ10y2dq/PIYOAz5cF
	 MpjcelZXzJ1MaJpY3D0MtctVbaDnkVH5p76AEHxD6yigve+y0+jy4M2LgtDPL/atTnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DfymdGzR;
	arc=none smtp.remote-ip=95.215.58.72
Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF98607F4AE
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF98607F4AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DfymdGzR
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=orhaXplratJcNb2My1mCuYwPc/ihniONCQm4s/dSjPA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792424226; v=1; x=1793029026;
 b=DfymdGzR1n6o40qpMP5e0lo0tUgOwzMSDUSKq4Wqc6NXbTCwHqpsP/wGTTpPziNPPbfH0QDh
 pDK3s/XFz8Ja4eIoFyi5FAQ6qrErPyC4R8wFX7VtlP4Oh9cghdSN48pyZFHziSO3iSOu3uXL/IG
 R/rqYuisZdL4YYB798s6ZMcI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9046bafc7c8451ba;
	Mon, 19 Oct 2026 15:37:06 +0000
X-Mizu-Trace-ID: 9046bafc7c8451ba
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
Subject: [PATCH bpf-next v2 3/6] bpf: Retire tracepoint bpf_xdp_link_attach_failed
Date: Mon, 19 Oct 2026 23:36:25 +0800
Message-ID: <20261019153628.15912-4-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019153628.15912-1-leon.hwang@linux.dev>
References: <20261019153628.15912-1-leon.hwang@linux.dev>
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

In the previous patch, it has a proper way to back-propagate the
underlying driver error message to user space via the BPF syscall common
attributes.

The tracepoint bpf_xdp_link_attach_failed seems redundant to report the
error message. And, the tracepoint doesn't report the ifindex alongside
the error message [1].

So, retire the tracepoint bpf_xdp_link_attach_failed and its selftest.

According to the tracepoint change discussion [2], please revert this
patch if users complain about the disappeared tracepoint
bpf_xdp_link_attach_failed in the future.

Links:
[1] https://lore.kernel.org/bpf/CAFk-A4mE9Jweo2hfX7y_85xbPyt0FqpMT1EvqX1OcYZ=LTLgRA@mail.gmail.com/
[2] https://lore.kernel.org/linux-mm/CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com/

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/trace/events/xdp.h                    | 17 -----
 net/core/dev.c                                |  1 -
 .../selftests/bpf/prog_tests/xdp_attach.c     | 65 -------------------
 .../bpf/progs/test_xdp_attach_fail.c          | 54 ---------------
 4 files changed, 137 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index 18c0ac514fcb..f1d4d0702884 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -362,23 +362,6 @@ TRACE_EVENT(mem_connect,
 	)
 );
 
-TRACE_EVENT(bpf_xdp_link_attach_failed,
-
-	TP_PROTO(const char *msg),
-
-	TP_ARGS(msg),
-
-	TP_STRUCT__entry(
-		__string(msg, msg)
-	),
-
-	TP_fast_assign(
-		__assign_str(msg);
-	),
-
-	TP_printk("errmsg=%s", __get_str(msg))
-);
-
 #endif /* _TRACE_XDP_H */
 
 #include <trace/define_trace.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index 96be63b9331e..a142613536b0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10817,7 +10817,6 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog,
 		bpf_link_cleanup(&link_primer);
 		if (extack._msg)
 			bpf_log(log, "%s\n", extack._msg);
-		trace_bpf_xdp_link_attach_failed(extack._msg);
 		goto out_put_dev;
 	}
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
index e6bcb6051402..fa3cac5488f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
-#include "test_xdp_attach_fail.skel.h"
 
 #define IFINDEX_LO 1
 #define XDP_FLAGS_REPLACE		(1U << 4)
@@ -86,74 +85,10 @@ static void test_xdp_attach(const char *file)
 	bpf_object__close(obj1);
 }
 
-#define ERRMSG_LEN 64
-
-struct xdp_errmsg {
-	char msg[ERRMSG_LEN];
-};
-
-static void on_xdp_errmsg(void *ctx, int cpu, void *data, __u32 size)
-{
-	struct xdp_errmsg *ctx_errmg = ctx, *tp_errmsg = data;
-
-	memcpy(&ctx_errmg->msg, &tp_errmsg->msg, ERRMSG_LEN);
-}
-
-static const char tgt_errmsg[] = "Invalid XDP flags for BPF link attachment";
-
-static void test_xdp_attach_fail(const char *file)
-{
-	struct test_xdp_attach_fail *skel = NULL;
-	struct xdp_errmsg errmsg = {};
-	struct perf_buffer *pb = NULL;
-	struct bpf_object *obj = NULL;
-	int err, fd_xdp;
-
-	LIBBPF_OPTS(bpf_link_create_opts, opts);
-
-	skel = test_xdp_attach_fail__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "test_xdp_attach_fail__open_and_load"))
-		goto out_close;
-
-	err = test_xdp_attach_fail__attach(skel);
-	if (!ASSERT_EQ(err, 0, "test_xdp_attach_fail__attach"))
-		goto out_close;
-
-	/* set up perf buffer */
-	pb = perf_buffer__new(bpf_map__fd(skel->maps.xdp_errmsg_pb), 1,
-			      on_xdp_errmsg, NULL, &errmsg, NULL);
-	if (!ASSERT_OK_PTR(pb, "perf_buffer__new"))
-		goto out_close;
-
-	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &fd_xdp);
-	if (!ASSERT_EQ(err, 0, "bpf_prog_test_load"))
-		goto out_close;
-
-	opts.flags = 0xFF; // invalid flags to fail to attach XDP prog
-	err = bpf_link_create(fd_xdp, IFINDEX_LO, BPF_XDP, &opts);
-	if (!ASSERT_EQ(err, -EINVAL, "bpf_link_create"))
-		goto out_close;
-
-	/* read perf buffer */
-	err = perf_buffer__poll(pb, 100);
-	if (!ASSERT_GT(err, -1, "perf_buffer__poll"))
-		goto out_close;
-
-	ASSERT_STRNEQ((const char *) errmsg.msg, tgt_errmsg,
-		      42 /* strlen(tgt_errmsg) */, "check error message");
-
-out_close:
-	perf_buffer__free(pb);
-	bpf_object__close(obj);
-	test_xdp_attach_fail__destroy(skel);
-}
-
 void serial_test_xdp_attach(void)
 {
 	if (test__start_subtest("xdp_attach"))
 		test_xdp_attach("./test_xdp.bpf.o");
 	if (test__start_subtest("xdp_attach_dynptr"))
 		test_xdp_attach("./test_xdp_dynptr.bpf.o");
-	if (test__start_subtest("xdp_attach_failed"))
-		test_xdp_attach_fail("./xdp_dummy.bpf.o");
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c b/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
deleted file mode 100644
index 2ff1b596e87e..000000000000
--- a/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
+++ /dev/null
@@ -1,54 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright Leon Hwang */
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-
-#define ERRMSG_LEN 64
-
-struct xdp_errmsg {
-	char msg[ERRMSG_LEN];
-};
-
-struct {
-	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__type(key, int);
-	__type(value, int);
-} xdp_errmsg_pb SEC(".maps");
-
-struct xdp_attach_error_ctx {
-	unsigned long unused;
-
-	/*
-	 * bpf does not support tracepoint __data_loc directly.
-	 *
-	 * Actually, this field is a 32 bit integer whose value encodes
-	 * information on where to find the actual data. The first 2 bytes is
-	 * the size of the data. The last 2 bytes is the offset from the start
-	 * of the tracepoint struct where the data begins.
-	 * -- https://github.com/iovisor/bpftrace/pull/1542
-	 */
-	__u32 msg; // __data_loc char[] msg;
-};
-
-/*
- * Catch the error message at the tracepoint.
- */
-
-SEC("tp/xdp/bpf_xdp_link_attach_failed")
-int tp__xdp__bpf_xdp_link_attach_failed(struct xdp_attach_error_ctx *ctx)
-{
-	char *msg = (void *)(__u64) ((void *) ctx + (__u16) ctx->msg);
-	struct xdp_errmsg errmsg = {};
-
-	bpf_probe_read_kernel_str(&errmsg.msg, ERRMSG_LEN, msg);
-	bpf_perf_event_output(ctx, &xdp_errmsg_pb, BPF_F_CURRENT_CPU, &errmsg,
-			      ERRMSG_LEN);
-	return 0;
-}
-
-/*
- * Reuse the XDP program in xdp_dummy.c.
- */
-
-char LICENSE[] SEC("license") = "GPL";
-- 
2.55.0

