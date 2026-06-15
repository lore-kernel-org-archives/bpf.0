Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021C13AA500;
	Mon, 15 Jun 2026 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513858; cv=none; b=XmPrlZIhxLZnnE9uCFGFx7srXh7DBw22toTE2igjbSIjJq2Boy7zYKs4p23BclW3n71UOCgSz8oMFBqvGWzccyVYL1RSUeUKEy5hQplz/9QMprQoGPVS2Q+KsHq+PwDVc3m83bwlaj7+dPqYTP7xbmELKAEbzWfBOIM42xFA9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513858; c=relaxed/simple;
	bh=BSYCwVmowOEhqfvRRjMyFrss2fip1Fjn0Sx3jEck2Yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3LHxPhLW/gmQGQse5J8VAoaWs9rzVs+aDhOj4gveMPukHbcg/zo/86MpiWNwmEIWAWSn5WZ3+1RuKM2L3DURRptlIIkmHgG/ls4uBmq7l8aP7yKLmY4p7tEPd9OUyyqWWi6WdY1NIKqrYSsLWV974gcOSGaPpBN9QXtd5hSvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Lfa7qe3r; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Lfa7qe3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=sMUXae8eca4pa/PG9Al6274Qpf7ubHN
	6n5QSn/Z6Fyc=; b=Lfa7qe3rJid60cAy4SjfSAHoCfkhwu0jGcPwMOLPATpGQWe
	wF3Hc3H1zeADeqxY1xZCaSiHBr0yV+y2HbBEMaDXlkbh6cgArEl8UEKBRf1Mrbe1
	PGp+oykTPr7LaVu5jmQ7FFBXg3EvgsMWHrcIBrRxhISUkOwJFLYp83vzY0Uk=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQA37r1vvi9qPuFwAg--.22668S4;
	Mon, 15 Jun 2026 16:57:30 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 15 Jun 2026 16:57:18 +0800
Subject: [PATCH bpf 2/2] selftests/bpf: Cover rdonly_cast dynptr slice
 lifetime
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-2-2dd0a369e153@mails.tsinghua.edu.cn>
References: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781513842; l=5327;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=BSYCwVmowOEhqfvRRjMyFrss2fip1Fjn0Sx3jEck2Yk=;
 b=DJGV6ssjpzZs/8rm1oue+pD6UmRY4qNICL2QqFEq9b6IfRZCVIlkw7/qNlqdoXwgjQQXTg93E
 gS5wR5d1jSMABaLq9Yq0wBAr612Qlr/pQPsRya2g4iBotHiz5nXDlA9
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQA37r1vvi9qPuFwAg--.22668S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1UKF1rZFWxCw17JFWkWFg_yoW7AryUpa
	9YkrWUurZYq3W7Gry8Za1IqF4Y9r4kXF4fGrZFy34Ivw1UXr98ZF40k3Wjqrn5K3yUCr4U
	trZFgFW3uryUXrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUxv38DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgUTA2ovr8QffgAAsY

Add verifier tests that cast a ringbuf dynptr slice with
bpf_rdonly_cast(), release the dynptr, and read through the cast alias.
Also cover stack-overwrite invalidation when a clone still holds the
reference. Also cover clone-derived cast aliases that remain valid after
overwriting the original dynptr.

Cover both void and typed return paths. The alias should be invalidated by
release or overwrite of its originating dynptr, while aliases from the
still-live clone should remain usable.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c | 160 ++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b62773ce5219b..7ffe55ba28663 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -5,6 +5,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <linux/bpf.h>
+#include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <linux/if_ether.h>
@@ -13,6 +14,18 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct sock {
+	int __unused;
+};
+
+static __always_inline void overwrite_dynptr(struct bpf_dynptr *ptr)
+{
+	asm volatile("*(u8 *)(%[ptr] + 0) = 0"
+		     :
+		     : [ptr] "r"(ptr)
+		     : "memory");
+}
+
 struct test_info {
 	int x;
 	struct bpf_dynptr ptr;
@@ -2077,6 +2090,153 @@ int dynptr_overwrite_ref_invalidate_slice(void *ctx)
 	return 0;
 }
 
+/* A read-only cast of a dynptr slice should be invalidated on release */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int dynptr_rdonly_cast_slice_after_release(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(__u64), 0, &ptr);
+
+	data = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*data));
+	if (!data) {
+		bpf_ringbuf_discard_dynptr(&ptr, 0);
+		return 0;
+	}
+
+	data = bpf_rdonly_cast(data, 0);
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+
+	return *data;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int dynptr_rdonly_cast_typed_slice_after_release(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u64 *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(__u64), 0, &ptr);
+
+	data = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*data));
+	if (!data) {
+		bpf_ringbuf_discard_dynptr(&ptr, 0);
+		return 0;
+	}
+
+	data = bpf_rdonly_cast(data, bpf_core_type_id_kernel(struct sock));
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+
+	return *data;
+}
+
+/* A read-only cast alias from an overwritten dynptr should be invalidated
+ * even when a clone still holds the underlying reference.
+ */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int dynptr_rdonly_cast_slice_after_overwrite(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+	__u64 *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(__u64), 0, &ptr);
+
+	data = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*data));
+	if (!data) {
+		bpf_ringbuf_discard_dynptr(&ptr, 0);
+		return 0;
+	}
+
+	bpf_dynptr_clone(&ptr, &clone);
+	data = bpf_rdonly_cast(data, 0);
+
+	overwrite_dynptr(&ptr);
+
+	return *data;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int dynptr_rdonly_cast_typed_slice_after_overwrite(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+	__u64 *data;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(__u64), 0, &ptr);
+
+	data = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*data));
+	if (!data) {
+		bpf_ringbuf_discard_dynptr(&ptr, 0);
+		return 0;
+	}
+
+	bpf_dynptr_clone(&ptr, &clone);
+	data = bpf_rdonly_cast(data, bpf_core_type_id_kernel(struct sock));
+
+	overwrite_dynptr(&ptr);
+
+	return *data;
+}
+
+/* A read-only cast alias from a clone should remain valid after overwriting
+ * the original dynptr while the clone still holds the reference.
+ */
+SEC("?raw_tp")
+__success
+int dynptr_rdonly_cast_clone_slice_after_parent_overwrite(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+	__u64 *data;
+	int ret;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(__u64), 0, &ptr);
+	bpf_dynptr_clone(&ptr, &clone);
+
+	data = bpf_dynptr_slice(&clone, 0, NULL, sizeof(*data));
+	if (!data) {
+		bpf_ringbuf_discard_dynptr(&clone, 0);
+		return 0;
+	}
+
+	data = bpf_rdonly_cast(data, 0);
+	overwrite_dynptr(&ptr);
+
+	ret = *data;
+	bpf_ringbuf_discard_dynptr(&clone, 0);
+
+	return ret;
+}
+
+SEC("?raw_tp")
+__success
+int dynptr_rdonly_cast_typed_clone_slice_after_parent_overwrite(void *ctx)
+{
+	struct bpf_dynptr ptr, clone;
+	__u64 *data;
+	int ret;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(__u64), 0, &ptr);
+	bpf_dynptr_clone(&ptr, &clone);
+
+	data = bpf_dynptr_slice(&clone, 0, NULL, sizeof(*data));
+	if (!data) {
+		bpf_ringbuf_discard_dynptr(&clone, 0);
+		return 0;
+	}
+
+	data = bpf_rdonly_cast(data, bpf_core_type_id_kernel(struct sock));
+	overwrite_dynptr(&ptr);
+
+	ret = *data;
+	bpf_ringbuf_discard_dynptr(&clone, 0);
+
+	return ret;
+}
+
 /*
  * Data slices from a dynptr clone should remain valid after
  * overwriting the original dynptr

-- 
2.34.1

