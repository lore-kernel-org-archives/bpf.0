Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9D818
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 00:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065666; cv=none; b=PAwhFOo/zAefKEE3DnqFO1INgdRfLNu2YuvM9GvTSXtMtSz/TQdeU+2OLObUQ//HA+w9zo510kvME5JIDrd0JeERm73SfuOxFSEEKbMgIu392BNq97ndGgDCj1733S4Gw6Ub0K42pBGfdo3CqrwTipQFvMwtrS+HjNoIvtj6zhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065666; c=relaxed/simple;
	bh=I0Fr6K0RHrxGOfhvSpmKiz3mE+CFTNXIv68ut2OVi3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ki+H9ykXBVndWJxk4IIWoX5ZOfsyfoa8rPE8tqwYfNtWnIXavD5OcRdGzydKbfMXhC18SsUUCmEvKQQhMIKKNnhfKMJAkE4d7W2+LXIRopnRwJ8vlQgrySFdcypeEg/YqJxv9m1UBDV/u1ZG23lvczNqBq3q3JTkQPQIM1PctoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXw66Xku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXw66Xku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAD3C433F1;
	Fri, 22 Mar 2024 00:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065666;
	bh=I0Fr6K0RHrxGOfhvSpmKiz3mE+CFTNXIv68ut2OVi3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXw66Xku8ZzH/ZS9AELei+n2PUSSp62LIs8gCxdHRfkm0TumqreCtRVnwFgavKCh1
	 MhBbOnDCatNyoJCuKUoKkrBtjhKoMehSC50h9LH6HMGNP4lgEf4n4kcUa5yBS2mgiI
	 8oex1W7R/jIp+FvNR+8obAMlIXI/29kCK1hMB016H/5/6mQDJyLbUPw+ihQRdlCP7o
	 t1+E8o7dDUQTjOtDyS890jSIdjHqA3+0E8fI32HBamfWX2j1xMyvf/r4fIw+u1Lmo7
	 ywN3g0TmmKPPmYWfbH2928IjBdjUYQ2i9Q67daX+MXneihpcIdOpyDv+K0Hg7TupE2
	 5v/A8121hNibw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 5/6] bpf: add bpf_test_tp() kfunc triggering tp and allowing error injection
Date: Thu, 21 Mar 2024 17:00:40 -0700
Message-ID: <20240322000041.2919948-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240322000041.2919948-1-andrii@kernel.org>
References: <20240322000041.2919948-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple bpf_test_tp() kfunc, available to all program types, that
is useful for various testing and benchmarking scenarios, as it allows
to trigger most tracing BPF program types from BPF side, allowing to do
complex testing and benchmarking scenarios.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/bpf_test.h | 34 ++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c  | 13 +++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100644 kernel/bpf/bpf_test.h

diff --git a/kernel/bpf/bpf_test.h b/kernel/bpf/bpf_test.h
new file mode 100644
index 000000000000..c779927d3574
--- /dev/null
+++ b/kernel/bpf/bpf_test.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM bpf_test
+
+#if !defined(_TRACE_BPF_TEST_H) || defined(TRACE_HEADER_MULTI_READ)
+
+#define _TRACE_BPF_TEST_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(bpf_test,
+
+	TP_PROTO(int nonce),
+
+	TP_ARGS(nonce),
+
+	TP_STRUCT__entry(
+		__field(int, nonce)
+	),
+
+	TP_fast_assign(
+		__entry->nonce = nonce;
+	),
+
+	TP_printk("nonce %d", __entry->nonce)
+);
+
+#endif /* _TRACE_BPF_TEST_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE bpf_test
+
+#include <trace/define_trace.h>
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9234174ccb21..67bf9659c447 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -26,6 +26,10 @@
 
 #include "../../lib/kstrtox.h"
 
+#define CREATE_TRACE_POINTS
+#include "bpf_test.h"
+
+
 /* If kernel subsystem is allowing eBPF programs to call this function,
  * inside its own verifier_ops->get_func_proto() callback it should return
  * bpf_map_lookup_elem_proto, so that verifier can properly check the arguments
@@ -2549,6 +2553,14 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
 
+__bpf_kfunc int bpf_test_tp(int nonce)
+{
+	trace_bpf_test(nonce);
+
+	return nonce;
+}
+ALLOW_ERROR_INJECTION(bpf_test_tp, ERRNO);
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -2625,6 +2637,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+BTF_ID_FLAGS(func, bpf_test_tp)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.0

