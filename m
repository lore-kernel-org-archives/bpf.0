Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF893F8251
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116172; cv=none; b=tglMmPLMzOICKGArLU0tD5W1u84fnHGlwR/Ue2jvpkhP8CIPMCnWOmHEUwEdxBOIoXzzjs5hR5NUwrdJq2TKoYbJacgRY/V8WdjQCl/oL0gDva+ry1Uv2bN2VSV5jg4jt6BQXug1MdwPH2oMe54thvD25hW8E20m68I+FWdb5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116172; c=relaxed/simple;
	bh=/2U9/KamnahY5ShAuAZlF7f9V0nZs8RaasoWfCZttgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fl3KcvDLTVPiXiuHPIeXQVKQKiu+s47GrXBWXFaaNowGtvENfBW9G8R8RIruEj9FyrcfyO1oCVdRLs8x8z8UKxM+WvD1kkNBc7pkQqR9SxyeB8hOPaHLigzMskvVvcIpEQk/FXbr8vDSlDhTZ4lpTgX8jRX2lccLJ7uaGQuH5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=t6YcMNte; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="t6YcMNte"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=1N2zqIvZCdLwtrChz0qeYTs9Zc9DpB/P/y
	gluz9PV84=; b=t6YcMNte27siYzW+McH3d73a4ND8Q8qEzgDEY7K5L7+ZzefBBb
	uCEkQjRosbTiZ3MnD/gQ3sPutxC6lyFSDySwhnC0v6mviGr/B5zkdUu81wlunsBb
	JEnI2umyCFHv9ccul+1V/c0b/LzxGH2Ucd6XFT0CDp72mfBxsAg5N5Hxk=
Received: from localhost (unknown [222.195.81.105])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBXSyIBv6Nqae8GAQ--.483S2;
	Fri, 11 Sep 2026 16:42:41 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test dynptr teardown on subprog return
Date: Fri, 11 Sep 2026 16:42:09 +0800
Message-ID: <20260911084209.3481285-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911084209.3481285-1-xyx2021@mail.ustc.edu.cn>
References: <20260911084209.3481285-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBXSyIBv6Nqae8GAQ--.483S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry5XrW3JF4kZF18Cr4DJwb_yoW3Wr1kpF
	W8uryYvry8JF47KryxXr4xZa1F9Fs3ur13Gry3K345Aw1UJr98ZF4xKa4UXrn8Kr45u3y5
	Zay7KFW3uF18GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07j4ksDUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add failure tests for slices that escape a subprogram from a dynptr in the
callee stack. Cover immediate use of a ring buffer clone slice, use after
the shared reservation is released, and immediate use of an skb dynptr
slice in a qdisc program.

Cover the error path where a subprogram would otherwise lose the last
dynptr capable of releasing a referenced resource. Update the existing
callback leak test for the same earlier return-time diagnostic.

Also add a success control which derives a slice from a caller-owned dynptr
and creates a separate clone in the callee. Destroying that local clone on
return must not invalidate the caller dynptr's slice.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ...disc_fail__invalid_dynptr_returned_slice.c | 76 +++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 97 ++++++++++++++++++-
 3 files changed, 174 insertions(+), 1 deletion(-)
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
index 0000000000000..8217f4c4c00c4
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
+	/* this should fail */
+	proto = hdr->h_proto;
+
+	bpf_qdisc_skb_drop(skb, to_free);
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
index 1cd61d72c166f..f57e6162dbf5b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -127,7 +127,7 @@ static int missing_release_callback_fn(__u32 index, void *data)
 
 /* Any dynptr initialized within a callback must have bpf_dynptr_put called */
 SEC("?raw_tp")
-__failure __msg("Unreleased reference id")
+__failure __msg("cannot overwrite referenced dynptr")
 int ringbuf_missing_release_callback(void *ctx)
 {
 	bpf_loop(10, missing_release_callback_fn, NULL, 0);
@@ -1892,6 +1892,101 @@ int clone_invalidate4(void *ctx)
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
+static __noinline void caller_slice_in_subprog(struct bpf_dynptr *ptr, int **data)
+{
+	struct bpf_dynptr clone;
+
+	*data = bpf_dynptr_data(ptr, 0, sizeof(val));
+	bpf_dynptr_clone(ptr, &clone);
+}
+
+static __noinline void reserve_dynptr_in_subprog(void)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+}
+
+/* A subprogram cannot lose the last dynptr that can release a resource. */
+SEC("?raw_tp")
+__failure __msg("cannot overwrite referenced dynptr")
+int referenced_dynptr_lost_on_subprog_return(void *ctx)
+{
+	reserve_dynptr_in_subprog();
+
+	return 0;
+}
+
+/*
+ * Destroying a local clone on return must not invalidate a slice whose
+ * source dynptr belongs to the caller.
+ */
+SEC("?raw_tp")
+__success
+int caller_dynptr_slice_across_subprog_valid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int *data = NULL;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	caller_slice_in_subprog(&ptr, &data);
+	if (data)
+		*data = 123;
+	bpf_ringbuf_submit_dynptr(&ptr, 0);
+
+	return 0;
+}
+
+/*
+ * A slice that escapes a clone's call frame is invalid once the local
+ * clone is destroyed on return.
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
+	if (data)
+		/* this should fail */
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
+int clone_slice_returned_frame_release_invalid(void *ctx)
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

