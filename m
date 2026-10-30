Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793403299;
	b=TqxWCq1WvjB0/Wtx2haX38YR6TAhAL6kDbMTE89wwirG0+/U1OCzU6xaaGgJ7Z2n0AUz
	 IYSPlYGq0/NjFHVz2/pTL0OTWNNa8jkZ0AihPQuHYNtuymFM0vUxSGqatk1J8d8GxofMH
	 bIHwqE8ZV+Tqb+J0aS8a9G9mRvRtnFKSGw55BTIb66w9kZ4AqYWOw4apOGHgyqAKNm/cz
	 Y2a4elBbwuahezM8fjaEQ6LAIir9bg1EtabqSbqFyQqKaVSFIJBwdL4Y1CpbetmeB56RS
	 smF29WHwGvXDzyKOcngzjCNrooNNYUMftSQWzfFnWcTpHeDJFt92rh/vtwbKUeR93JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793403299;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b82lP9jf4kTd/T+BI614MfKO1C8eM2+CQA2N2+Irlqo=;
	b=UNowzmRspsSMHVRQ3FJ51Ot+HuN0mY68JtVurwLrQyeEZdJNWaIks6awZwT/YSR3617W
	 TILosEdCKtQIFxG55/CtcTHTCeY9syWeNO3sgp6AxAKNG42hhiZjGwVnNBE+Vb9jcPBhq
	 TnWaImetdAYeOmqlJyjCUW9D6XY9EZStzQQijnaXu9aEMYd4pJe6LdtMUE6NnTJFsb+DN
	 wAof2bctkmtbqRe2e0vvmJIgJytVQrUntGIJYqCLI3AjjuS2L3FTcDzzk/pTba/NQZme7
	 E9+kKBwWXCRKBHFmB6qrzL3wvx8O07XOThMXjIhQ/KUbxHFi/Twbh+O4BAkZb2MhKGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B3g71HPp;
	arc=none smtp.remote-ip=95.215.58.53
Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E909606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 23:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E909606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=B3g71HPp
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hO+Nirg5V2OYF8+RxPmN6Vay8EeZOzKjHD0CF2zaoFc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793403296; v=1; x=1794008096;
 b=B3g71HPpae3BT04JVnsSf/nHNTA7fmGxB3K1c5MJsXy7F+ORFZQQ29VgJc42vnb/bsobXcP4
 2EdNFLySIXkYaQbBICo+eTg9CV849Rr+B4RNB7yip9bdXyhFuzRK7q0VH9hLKKO4i3V1MKG/VPs
 kddk8x43zIZPlYOPWf9AcAT8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id a6d34b50ce83fc1c;
	Fri, 30 Oct 2026 23:34:56 +0000
X-Mizu-Trace-ID: a6d34b50ce83fc1c
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
Subject: [PATCH bpf-next v3 12/13] selftests/bpf: Cover context and socket accesses through vmlinux.h
Date: Fri, 30 Oct 2026 16:33:54 -0700
Message-ID: <20261030233355.1836749-13-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
References: <20261030233355.1836749-1-ihor.solodrai@linux.dev>
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
index 386ad81051a9..40dea921f272 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -41,6 +41,7 @@
 #include "verifier_const.skel.h"
 #include "verifier_const_or.skel.h"
 #include "verifier_ctx.skel.h"
+#include "verifier_ctx_rewritten.skel.h"
 #include "verifier_ctx_sk_msg.skel.h"
 #include "verifier_d_path.skel.h"
 #include "verifier_default_trusted_ptr.skel.h"
@@ -233,6 +234,7 @@ void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
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

