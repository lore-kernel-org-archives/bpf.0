Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8AE3DDAF5
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510730; cv=none; b=bASa3NMQc61XPhR2wuw3atMT8UtXohq/LB3ZLxKoNaXRm9aF33sP1I6MhkvCiRrMSg+xSvunrRfTHNoCNf+PyfEK9bCRVD97AYLFznhEc7q23afqI5FftUC7cj/55RiAnv3EXjzH9beEDj0D8hRudyP+67ssQyRH5YhcSAnTMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510730; c=relaxed/simple;
	bh=Ox4flAcGhKoAkD0SWyYSm3XCQhx7AtWm8NhUzAA8Z7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nliq7q9WmJpdC7BcN1GcHZBKB6ccnb+gz+RwAI9mmEeSbnNwzLWlLz280eCEZNdN+hErVsbA6tuTXHfsUb3/titGBO5Nzbk4glw5+z9UA+y9LtPvqKposonbI4krL0gdy0Ox/FXIz1XQOOsE8HwzV5mKQYgesxPufEk7MCVTgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=wsFAgoyk; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="wsFAgoyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=S1AJlZrTHso3X28IEjYhiq8jsAy738JoM4
	XgwN0reYQ=; b=wsFAgoykp7mRomBSTqaINubbodIXvEB6qJM5mdeGpBTOINn+gb
	yDfyUFYSEW/4lhyooHdCpBZW8Vxts2BevN8PQao1vWE8rAMA4I43yYbhMFeXn6kw
	Ag6Dovl6K5pPh8In5dQbpGmW+9a1pDt4+zV/EOxguFx6U21InlHcFpRmc=
Received: from localhost (unknown [222.195.81.76])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgA3LCNLBrlqNYlqAQ--.1490S2;
	Sun, 27 Sep 2026 20:04:27 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	sashiko-bot@kernel.org
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Test dynptr teardown on subprog return
Date: Sun, 27 Sep 2026 20:04:22 +0800
Message-ID: <20260927120422.1042107-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
References: <20260927120422.1042107-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgA3LCNLBrlqNYlqAQ--.1490S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry5XrW3JF4kZF18Cr4DJwb_yoWxKFy7pa
	y8CryYvFyxJF42gry7Xr4xZa1F9Fsxur13Gry3K345Aw1DJr98ZF1xKayUXr98Kr45u3y5
	Z39Fgay5uF18GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW5JwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUxG-eUUUUU
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add failure tests for slices that escape a subprogram from a dynptr in the
callee stack. Cover immediate use of a ring buffer clone slice,
release-time invalidation of a caller dynptr slice after it crosses a
subprogram return, and immediate use of an skb dynptr slice in a qdisc
program.

Cover the error path where a subprogram would otherwise lose the last
dynptr capable of releasing a referenced resource.

Also add a success control which derives a slice from a caller-owned dynptr
and creates a separate clone in the callee. Destroying that callee-local
clone on return must not invalidate the caller dynptr's slice.

Assisted-by: LLM
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  2 +
 ...disc_fail__invalid_dynptr_returned_slice.c | 76 +++++++++++++++
 .../testing/selftests/bpf/progs/dynptr_fail.c | 95 +++++++++++++++++++
 3 files changed, 173 insertions(+)
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
index 0d13f828710e7..8c5387388d45f 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1895,6 +1895,101 @@ int clone_invalidate4(void *ctx)
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
+ * Destroying a callee-local clone on return must not invalidate a slice whose
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
+ * A slice derived from a callee-local clone is invalid after the subprogram
+ * returns.
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int callee_dynptr_slice_invalid_after_return(void *ctx)
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
+ * A slice from a caller-owned dynptr survives the subprogram return, but
+ * releasing the shared reservation must invalidate it.
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int caller_dynptr_slice_release_after_subprog_invalid(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	int *data = NULL;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, val, 0, &ptr);
+	caller_slice_in_subprog(&ptr, &data);
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

