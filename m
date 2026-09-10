Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7739CD05
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 04:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789015234; cv=none; b=R6KV14H6aMRXJWjf63DTi1nRaGa1Jj6vNUuKmzpju17PFXaGlEPJqP9OJBegyw0tnBkgqdPzPOlQALhy30rq8ayeaXwEPGexPD2CL+T8HRBCWDM0ShaH9NUJf7d7eJD9uF+3PpnGmLycfTXLH72kGIxvalVjkQx6un1KwV6gL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789015234; c=relaxed/simple;
	bh=DZMF28s3wiYHzyBB+1LSM2+I6Q3v4WWh2pRbvTZdF0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R95+/zDGU4riHvVyMqM9bsAloWR+/wfRFsY+boGReZIFjA3WVUxX2W9Lmuldk2zlWvWHcgIKyzNtCrtg9si9aNklvWH/ZLetOjX0qC6M1506x4whguyg/Pd0oH28WR6F/ExGzqNdjoChYgaHuw4+bxTCQsmAh56o4P1BFR3Zd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=LzwwtsbD; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="LzwwtsbD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=OpmO3LO4GAwLy4Ev7KefHfeUy9zlhIfscX
	fZPSuoMmg=; b=LzwwtsbD03ctyW0RJSjxOKPmC5wi8/yW73s6w4PwY5Vbq6hRBP
	ygKKn7LiixaoBSKHR+RP7uPnoytH1SQ1KhOQn57WtD2Lt81xXHfo4fdX7aAgkkOm
	XKujnh77q8VZ62S311Xuz2Z82XVFl1wWV2XznfHJb+leLQPAnlO7hZB0o=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCnkhmyNKJqpDL_AA--.315S2;
	Thu, 10 Sep 2026 12:40:18 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test dynptr slices escaping a call frame
Date: Thu, 10 Sep 2026 12:40:06 +0800
Message-ID: <20260910044006.2279547-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn>
References: <20260910044006.2279547-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCnkhmyNKJqpDL_AA--.315S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy3Gr13Jw47CFy8CrWDCFg_yoW7trykpa
	y8u34YvFyxJF42gw17Xr4xZa1S9Fs5ur17GryfK345Ar1DJFWDXF4xK3yUWrn5Kr45u343
	uasFgay5ZF18GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU8CdgJUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add ring buffer tests where a subprogram derives a slice from a local
dynptr clone and passes the slice back through the caller's stack. Verify
that the slice remains usable while the shared reservation is live and is
invalidated after the reservation is submitted.

Also add a qdisc test where a subprogram creates an skb dynptr from the
referenced skb argument and returns a data slice. Releasing the skb in the
caller must invalidate the returned slice.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ...disc_fail__invalid_dynptr_returned_slice.c | 76 +++++++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 49 ++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 6dbd1487343c0..122ecb7e98e2a 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -11,6 +11,7 @@
 #include "bpf_qdisc_fail__invalid_dynptr.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_returned_slice.skel.h"
 #include "bpf_qdisc_fail__untrusted_write.skel.h"
 #include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"
 
@@ -230,6 +231,7 @@ void test_ns_bpf_qdisc(void)
 		test_incompl_ops();
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_returned_slice);
 	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
 	RUN_TESTS(bpf_qdisc_fail__untrusted_write);
 	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c
new file mode 100644
index 0000000000000..940aba7d8abfe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_returned_slice.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+static __noinline struct ethhdr *slice_in_subprog(struct sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+	return bpf_dynptr_slice(&ptr, 0, NULL, sizeof(struct ethhdr));
+}
+
+SEC("struct_ops")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(invalid_dynptr_returned_slice, struct sk_buff *skb,
+	     struct Qdisc *sch, struct bpf_sk_buff_ptr *to_free)
+{
+	struct ethhdr *hdr;
+
+	hdr = slice_in_subprog(skb);
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	/* this should fail */
+	proto = hdr->h_proto;
+
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
+	.enqueue   = (void *)invalid_dynptr_returned_slice,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 1cd61d72c166f..92f9f9ea05321 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1892,6 +1892,55 @@ int clone_invalidate4(void *ctx)
 	return 0;
 }
 
+static __noinline void clone_slice_in_subprog(struct bpf_dynptr *ptr, int **data)
+{
+	struct bpf_dynptr clone;
+
+	bpf_dynptr_clone(ptr, &clone);
+	*data = bpf_dynptr_data(&clone, 0, sizeof(val));
+}
+
+/*
+ * A slice that escapes the clone's call frame remains valid while the
+ * shared ringbuf reservation is live.
+ */
+SEC("?raw_tp")
+__success
+int clone_slice_returned_frame_valid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int *data = NULL;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	clone_slice_in_subprog(&ptr, &data);
+	if (data)
+		*data = 123;
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/*
+ * Releasing the shared reservation must invalidate a slice that escaped
+ * from a clone's call frame.
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int clone_slice_returned_frame_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int *data = NULL;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	clone_slice_in_subprog(&ptr, &data);
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+	if (data)
+		/* this should fail */
+		*data = 123;
+
+	return 0;
+}
+
 /* Invalidating a dynptr should invalidate any data slices
  * of its parent
  */
-- 
2.43.0

