Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901687;
	b=zxa11Vsb3ktcIimlrzYWYpPVx2DbrFIzSr7eEYBC4EsmFIpWVtHCc89mVHOyB1bKdT50
	 FRa598f4YalBEc3dLS2SSzuhW6TpEnYJF9CITNS9FlKoGfVK6lgeT2c7CR77enMuRSVHQ
	 qlVcIrp3FZSTDKqrAvh0w+0ciuYiibgs/PnvewJ5/RVkxEM1P/k8FQUAKPW6W8sZKVCvf
	 SV01K5TEfbvP8ad8LXYcQwyB+rclI1hXrd6XASOiFEjzq5JWOLwGHJEYPJHxn46QANU4/
	 lGvVHv3eYjZHPw8oEvZmhG5CtXu00TsxC2ylSJTthUD0cnPb26P40g9X5DWzuyYhWRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901687;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zs8v/oaTpbj5+iDyRfn8jTNZ+ce6pKl7TqE8jbTUjE0=;
	b=4S+zLOHRuosfLahb6IFV44JScl5U7zp0wOhu9pSyMNyVptC7RjjKaM0jl09fFEiOqKC+
	 L9d+Rvjx1rcsoV4l6cjOtGLcrhCpmVU5k3N4N4aE9xAVGEHIQGRcSjeOHaDcf8adh2TqI
	 4Crl5lTTSxZmUEseTRB4jH+BiDW56V6CCUD0rUeJSAGNszhP/7mB+c5AWw4Q4+4JF5V4V
	 4E91nCQCSiEram4KnNXvxbxtHT0feoYx2c7OzhQ9L+Ak0GGzaKMrx+DguERwkl36yJJjQ
	 D3nLEZJBOicQyKi8QBhRiJjv9oihw05gbWR18eOnRjIQ5HKp96dEuc/kOTB467RQMHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L6Ceks2f;
	arc=none smtp.remote-ip=91.218.175.44
Received: from mta0.migadu.com (out-44.mta0.migadu.com [91.218.175.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CD606A326
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB2CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=L6Ceks2f
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wrjEt8jRg4gwf4wijWzqa8MYgMszjs75z6HuWvFbvqo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901684; v=1; x=1794506484;
 b=L6Ceks2f3ZHueQIOwcXqCjPAmU+fipx3SX8YPoj1BBdVb8QSgNQquHKixrSR1/fgSGZvrCF9
 pV+wDDWf6HXwacnjlPiPLBMocb9RlR9xxnS4JnhY3wAQcH7WFK8UNdH0cnpnBGQN8wlS+Y10WAo
 xrQPhol/Ocvalg4HhGDon6TU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eee34d608ccc3c9a;
	Thu, 05 Nov 2026 18:01:24 +0000
X-Mizu-Trace-ID: eee34d608ccc3c9a
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
	David Faust <david.faust@oss.qualcomm.com>,
	Ian Rogers <irogers@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Vineet Gupta <vineet.gupta@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v4 14/17] selftests/bpf: Cover context and socket accesses through vmlinux.h
Date: Thu,  5 Nov 2026 10:58:42 -0700
Message-ID: <20261105175845.30357-15-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105175845.30357-1-ihor.solodrai@linux.dev>
References: <20261105175845.30357-1-ihor.solodrai@linux.dev>
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

Incorrect vmlinux.h annotations can make valid context and socket
accesses fail to load.

Add load tests through the generated header for these cases:

- fields in nested anonymous unions of context types, which vmlinux.h
  leaves unannotated, and a bpf_sock field.
- skb_narrow_field(): a narrow skb->mark load, which the verifier
  rejects if __sk_buff carries __bpf_relocatable.
- skb_merge_loads(): skb field loads merged across branches, which the
  verifier rejects without __bpf_static_offset. Built only if the
  compiler supports preserve_static_offset.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_ctx_rewritten.c        | 60 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index ae23304c1340..d41339ef00d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -45,6 +45,7 @@
 #include "verifier_const.skel.h"
 #include "verifier_const_or.skel.h"
 #include "verifier_ctx.skel.h"
+#include "verifier_ctx_rewritten.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_d_path.skel.h"
 #include "verifier_default_trusted_ptr.skel.h"
@@ -242,6 +243,7 @@ void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
 void test_verifier_const(void)                { RUN(verifier_const); }
 void test_verifier_const_or(void)             { RUN(verifier_const_or); }
 void test_verifier_ctx(void)                  { RUN_TESTS(verifier_ctx); }
+void test_verifier_ctx_rewritten(void)        { RUN_TESTS(verifier_ctx_rewritten); }
 void test_verifier_ctx_sk_msg(void)           { RUN(verifier_ctx_sk_msg); }
 void test_verifier_d_path(void)               { RUN(verifier_d_path); }
 void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trusted_ptr); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c b/tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c
new file mode 100644
index 000000000000..5feba7e1af73
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c
@@ -0,0 +1,60 @@
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
+	/* a nonzero byte offset becomes pointer arithmetic with preserve_access_index */
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

