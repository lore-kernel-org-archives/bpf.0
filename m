Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794480;
	b=kffmGQSY3zf24MA1CtuDHS7NUBSvBw3eDBBptrrnM1gWFz8YDMtADMSeswk4vkiyuWE/
	 XrMMDTJzfYtsK6KwOCxE50owxMIPxGLNqvs5faDpH4DZ+QNkZcflpJh703d1LoepSH8WU
	 iss9cqnoRKgJ39nCjv8oNvQa+pyOFv0sDmzaaUjH92+WcQhaKd8jsbk1vb4A8tdvRsA2z
	 lm6ZK81cPDdZQmiACXJ+KaJI+8TfE/6rmZlTK8doXQMfb+wh+LoxJ+ca44IAL2Mzc3BLj
	 5WURoTbBSzLCLwQAXR8QkilI1BVJZozyNZLh5Yvd2zrLW4O5X225P7rIc1hFCW+Pb3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794480;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FfPoGioRhMmCpWX17g9TscwePSa7sArx1akOhExP20A=;
	b=iK5Y8vtLQ7Q5TqvEjJRcY90xLuXIRNc2ErRcrm2c6UR8RN8kifCi7pTOLZ1FrESHBGRE
	 CJtVc/kzF9WoX2ZpXlr5NuDE98PcqhAySOCKNbOazUuMQMyjr4WPF0R77ovkYOCUn0//s
	 2zo+y604uirTzzWE6QYOtHyFXbWgfkzeDqyMhHtw2vKJUlRxGV9sciJJP4PxGa7pYdwec
	 Qy8YRFePeoM6nhu9j74TROCFwiSvyBiLtLzIOMKN5v4WMGNwz2AP0/p1qjzbk8OtE+zga
	 PsTXs34AXhQ05bDjK8U2T+e2K2qVZ36DuvCw1kb1rdiktDuaEGZy/TkwUov2Gr4GuZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LvNHSWsH;
	arc=none smtp.remote-ip=91.218.175.192
Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660D606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B660D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LvNHSWsH
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hG2Gn7Rrf5bg2Jmeysy/2VcqsmqE+NMJ9Q3Sa6BhteU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794478; v=1; x=1793399278;
 b=LvNHSWsHk6m7nM1k/zciVPtdHbUm4wGiXEXna5DH3NwGx4YFZaQBQCls526YDMMu/vNAF43L
 NHZ/iw9I0t9Tvi//Ad7QrR2DSkavVNpUziuzPKHtHvmiStsEsochJjLMw8lwZIrrToThBjPe36m
 ZMj38kxnLJN4fPhqpFLKR5jI=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id fec4b04389c32958;
	Fri, 23 Oct 2026 22:27:58 +0000
X-Mizu-Trace-ID: fec4b04389c32958
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Cupertino Miranda <cupertino.miranda@oracle.com>,
	David Faust <david.faust@oracle.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2 7/8] selftests/bpf: Cover context and socket accesses through vmlinux.h
Date: Fri, 23 Oct 2026 15:26:51 -0700
Message-ID: <20261023222652.3927736-8-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
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

Add load tests for context and socket accesses through the generated
vmlinux.h:

- fields in nested anonymous unions of context types, which vmlinux.h
  leaves unannotated, and a bpf_sock field.
- skb_narrow_field: a narrow skb->mark load, which the verifier
  rejects if __sk_buff carries __bpf_relocatable.
- skb_merge_loads: skb field loads merged across branches, which the
  verifier rejects without __bpf_static_offset. Built only if the
  compiler supports preserve_static_offset.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_ctx_rewritten.c        | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 04740ba37e91..57a8a1abedd8 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -42,6 +42,7 @@
 #include "verifier_const.skel.h"
 #include "verifier_const_or.skel.h"
 #include "verifier_ctx.skel.h"
+#include "verifier_ctx_rewritten.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_d_path.skel.h"
 #include "verifier_default_trusted_ptr.skel.h"
@@ -234,6 +235,7 @@ void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const(void)                { RUN(verifier_const); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx(void)                  { RUN_TESTS(verifier_ctx); }
+void test_verifier_ctx_rewritten(void)        { RUN_TESTS(verifier_ctx_rewritten); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
 void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c b/tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c
new file mode 100644
index 000000000000..33eb975a170a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+SEC("tc")
+__success
+int skb_socket(struct __sk_buff *skb)
+{
+	struct bpf_sock *sk = skb->sk;
+
+	return sk ? sk->family : 0;
+}
+
+SEC("sockops")
+__success
+int sockops_args_reply(struct bpf_sock_ops *skops)
+{
+	skops->reply = skops->args[1];
+	return 0;
+}
+
+SEC("sk_msg")
+__success
+int sk_msg_data(struct sk_msg_md *msg)
+{
+	return msg->data < msg->data_end;
+}
+
+SEC("cgroup/getsockopt")
+__success
+int sockopt_optval(struct bpf_sockopt *ctx)
+{
+	return ctx->optval < ctx->optval_end;
+}
+
+SEC("tc")
+__success
+int skb_narrow_field(struct __sk_buff *skb)
+{
+	return ((__u8 *)&skb->mark)[1];
+}
+
+#if __has_attribute(preserve_static_offset)
+SEC("tc")
+__success
+int skb_merge_loads(struct __sk_buff *skb)
+{
+	__u32 value;
+
+	if (skb->len)
+		value = skb->pkt_type;
+	else
+		value = skb->mark;
+	return value;
+}
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.56.0

