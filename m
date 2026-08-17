Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FF1418A39
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975821; cv=none; b=FsTmpenoXuosKjZU2YO60IHVfZY5Vl/46i0VYouyAMhhHG7O734lMYG+DrqkTphL5F+FgnZAGoHVd5kigZm8pmbUiobbfAxHlyEQ/P5uWbst28Xr/mS6MW91mGXYxYjJp1sucL18oWNkdHd0TamASQvsp4VXN2ySTA2UGPBjsg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975821; c=relaxed/simple;
	bh=3dSXIOk6uIKu9ZAyeC4o0SC+xkN8X4IZ801BUnOO914=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9h6QVAAXoa4PaFEsRk959lzSpE4uVoF8edOc9gWh7W40KpeuJNsYGeA+dhMZnXJe0EzvyTBAtnlIUKLdKnHlQAixVNO82hRYzuqr1N9s9l3TjcknOAxj5JnD4eGEDpDwAJGTMJACI4Fp+wqQyUsXhGbnbFPkYbKKCQg8WMOnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QT1FgcOS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QT1FgcOS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=EakLggF10eTw8zn+qxxABs/Xl9jQ3q8SHP2uVcWTG7Y=; b=QT1FgcOSI8WoSw+FInRs+XjxNh
	NCIa6ARScyjtcDeZDnTKdXhunKRZi1e69vgVztGlJ+9Ql9madF7Epbh2V7PST5UsWKKn0clJXQrv3
	lyp8mhWszRdSCGQc+sU0uLeAqN19Klig4c5m/NkgSg/CMzn0Y5R8VPzzG+BBT/Tqg9w3ngHbcnSE4
	EpA9PFbebTtoSLmqJAF+tO1PQ9pbXoDPaee9yKN5f/btXFr5BkVu6E4kJLs9jkoJFb9ffXe+ls0WL
	zixkXZ8Xb52I/hUuW/6qG+nzyhzryK7s+yzjCE+TyXGE96dlfxd4j0qp8q9ex5nisZP2eg+h1NF6s
	hZ4E4xbQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvy2b-000MLJ-1a;
	Mon, 17 Aug 2026 16:10:17 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: eddyz87@gmail.com
Cc: memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: Add tests for a store on a fault prone qdisc pointer
Date: Mon, 17 Aug 2026 16:10:15 +0200
Message-ID: <20260817141015.878071-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817141015.878071-1-daniel@iogearbox.net>
References: <20260817141015.878071-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28095/Mon Aug 17 08:23:59 2026)

Cover the store which used to be left as a plain BPF_STX without an
exception table entry:

  1: R1=trusted_ptr_Qdisc()
  ; struct Qdisc *next = sch->next_sched;
  1: (79) r1 = *(u64 *)(r1 +216)        ; R1=ptr_Qdisc()
  ; next->limit = 1000;
  3: (63) *(u32 *)(r1 +20) = r2         ; R1=ptr_Qdisc() R2=1000

Assert that it is rejected now.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t ns_bpf_qdisc
  [...]
  #257/1   ns_bpf_qdisc/fifo:OK
  #257/2   ns_bpf_qdisc/fq:OK
  #257/3   ns_bpf_qdisc/attach to mq:OK
  #257/4   ns_bpf_qdisc/attach to non root:OK
  #257/5   ns_bpf_qdisc/incompl_ops:OK
  #257/6   ns_bpf_qdisc/invalid_dynptr:OK
  #257/7   ns_bpf_qdisc/invalid_dynptr_cross_frame:OK
  #257/8   ns_bpf_qdisc/invalid_dynptr_slice:OK
  #257/9   ns_bpf_qdisc/untrusted_write:OK
  #257/10  ns_bpf_qdisc/dynptr_use_after_invalidate_clone:OK
  #257     ns_bpf_qdisc:OK
  Summary: 1/10 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v2->v3:
  - new patch

 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 .../progs/bpf_qdisc_fail__untrusted_write.c   | 65 +++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__untrusted_write.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 77f1c0550c9b..6dbd1487343c 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -11,6 +11,7 @@
 #include "bpf_qdisc_fail__invalid_dynptr.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_fail__untrusted_write.skel.h"
 #include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"
 
 #define LO_IFINDEX 1
@@ -230,6 +231,7 @@ void test_ns_bpf_qdisc(void)
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
+	RUN_TESTS(bpf_qdisc_fail__untrusted_write);
 	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__untrusted_write.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__untrusted_write.c
new file mode 100644
index 000000000000..688c2a049ae3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__untrusted_write.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops")
+__failure __msg("only read is supported")
+int BPF_PROG(untrusted_write, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct Qdisc *next = sch->next_sched;
+
+	/*
+	 * sch is trusted, but the walk of next_sched yields a plain
+	 * PTR_TO_BTF_ID which may fault on a dereference. A store through
+	 * it does not get an exception table entry, there is no probed
+	 * store to rewrite it into, hence it has to be rejected before
+	 * bpf_qdisc_btf_struct_access() gets to allow the write to limit.
+	 */
+	next->limit = 1000;
+
+	bpf_qdisc_skb_drop(skb, to_free);
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)untrusted_write,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
-- 
2.43.0

