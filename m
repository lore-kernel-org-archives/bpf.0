Received: from mta1.migadu.com (out-228.mta1.migadu.com [95.215.58.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7B1F192E
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108866; cv=none; b=adMlgguqJsuQcJtTswzCu5+TAl+oMxhGU1/gcFF5z0WSSvL7Rsu9eH+KLHDEP6WIhmBRfPElNteFv9sgMnhoLtBxtP006jxD3GA0sKlwsVcC0hzd3s5EAoz+oMrC5KtMEtV9lQor1rtJlP63Xf7awGWbNMf18p/yHIBbxcBVbxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108866; c=relaxed/simple;
	bh=yxwsJEqi8nYCo0cg779ZelmFtbMjAfxwy1kFREOOtBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khLKrgEfcgRZgPd0WmkbHAw2sSaMC/YO/xTGGe6/f3TmLpShKB6PU6R2H8vCf/ciKlC2uOHu407pAKFNrz/WMJrSXmGzVi7qJQ5O5RfFRFcqMS6t0PyOLBd1vKqkDjUryGgBUk3f5luGwGdd4aGHWXxHLtV0xzdt/UcFiLEqnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CSnGnf8/; arc=none smtp.client-ip=95.215.58.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CSnGnf8/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yxwsJEqi8nYCo0cg779ZelmFtbMjAfxwy1kFREOOtBg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108863; v=1; x=1792713663;
 b=CSnGnf8/RVgsSQmRxap8gFGcWQprehGMNOIGMw4S+Bxq/aAZyhf/GrlQOr/d9vV4WVQGByFb
 xZWc+VUymArt7jZ2EfmHDOrCYuqH0LZHPLWJCSx92cyTTiBHFYgBEHktNgwP+f45h/823JNxnjR
 XVqU0NjltJhmN1IKapHZZdQs=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 036ccca360243c76;
	Fri, 16 Oct 2026 00:01:02 +0000
X-Mizu-Trace-ID: 036ccca360243c76
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
Subject: [PATCH bpf-next v1 7/8] selftests/bpf: Cover context and socket accesses through vmlinux.h
Date: Thu, 15 Oct 2026 17:00:11 -0700
Message-ID: <20261016000012.2232059-8-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
References: <20261016000012.2232059-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generated vmlinux.h leaves __bpf_core_pai off the types whose field
accesses need static offsets and off their nested anonymous records,
and marks these types with __bpf_core_pso.

Some accesses fail to load if any part is missing. With __bpf_core_pai
on an anonymous member but not on its enclosing type, Clang roots the
CO-RE relocation at an unnamed type that libbpf cannot resolve. With
__bpf_core_pai on the type, a narrow field load can become pointer
arithmetic on the context pointer, which the verifier rejects. Without
__bpf_core_pso, merging field loads from two branches into one does the
same.

Cover each case with programs loaded through the generated header:
accesses through the anonymous unions of four context types, a narrow
skb->mark load, and a merged load where the compiler supports
preserve_static_offset.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_ctx_rewritten.c        | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_ctx_rewritten.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c69c0f7e9cc8..56b626419ab6 100644
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
@@ -231,6 +232,7 @@ void test_verifier_cgroup_storage(void)       { RUN(verifier_cgroup_storage); }
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

