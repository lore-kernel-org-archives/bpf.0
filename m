Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD033019C3;
	Thu,  4 Jun 2026 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585721; cv=none; b=S4frW5352KbuiMe8lYx2jNkMMagmth9wZCaJpbZrOTmi/bWhSe49S+vAvFVdbvseVeQJOvXRP+8fTWTVen7bgiyM2rRlZwfYbm9Y7M0/QgRMHzAVaC+WP9q6OwzS9OfEu3umq/D/kWFTDC0lOOpYEmaMF85Vdv6qYp/cn+HnlHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585721; c=relaxed/simple;
	bh=zjcAYw5xW78pIPIHsqvOpWgvlgFanQLgz4tl90E/4DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvsi2mh3rpw7QzPrgqmW220OEahcx4oHj9/IxPKHjU4bgSYdtutya0559h04OixjlUXDtTP0BymI7loPicjgIrJeSeZc9PJzAbawNltxtmDqmLuVvbE/HwmAydTMGiOn41FA951NUGa8pH4Sz5qAzmrmsaP6BDa4KYGrXeQb7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=h+eBwVXM; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="h+eBwVXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=hIv1X4xguXanfkVHUjSLm4k5svJg+xA565
	WhpN02GJk=; b=h+eBwVXMvfwMCV42r4hUhWXmiWiqJiNP11rlpAUCUFs1rnemEl
	rpSBWv6S84N346LTs/WWjCo9rB0ph9wtmQ9jAckD2bxzYIxG+vYuvFcizt/wk4fR
	K3jlJYBwHm4a+va0kC29fyGcF6Gbx7ZGHwTLRqk9+EmvT3G+hpVDGNB4U=
Received: from dumpling.. (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQDHE5HQlCFqqyQrAg--.52018S4;
	Thu, 04 Jun 2026 23:08:14 +0800 (CST)
From: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shenghao Yuan <shenghaoyuan0928@163.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: add tests for PTR_TO_FLOW_KEYS constant offset bounds
Date: Thu,  4 Jun 2026 23:07:55 +0800
Message-Id: <20260604150755.2487555-3-gnq25@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
References: <20260604150755.2487555-1-gnq25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQDHE5HQlCFqqyQrAg--.52018S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWDWryxXF48AryDGFWfKrg_yoWrtFW8pF
	n5u3ZIgFWkZr13Wa17AF4UZFyFqa1kX3W5AFyrA345ZF1DJwn7Wr4kKrW8Gr1fCrs8Z3yY
	vr4Fqr13AF4DAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQ0edUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgEIA2ohcoE8IwAAsv

Add verifier tests covering constant pointer arithmetic on a
PTR_TO_FLOW_KEYS register, which regressed with commit 022ac0750883
("bpf: use reg->var_off instead of reg->off for pointers"): an
out-of-bounds offset introduced as flow_keys += K and then dereferenced
at insn->off 0 was accepted, while the equivalent flow_keys + K direct
offset was rejected.

The tests check that:
 - in-bounds constant arithmetic on the keys pointer is still accepted,
 - an out-of-bounds offset introduced via constant arithmetic is rejected
   for both read and write, with the same diagnostic as the direct
   insn->off form.

Signed-off-by: Nuiqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_flow_keys.c  | 77 +++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_flow_keys.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 06cd24e37b3f..feaee223689b 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -38,6 +38,7 @@
 #include "verifier_div0.skel.h"
 #include "verifier_div_mod_bounds.skel.h"
 #include "verifier_div_overflow.skel.h"
+#include "verifier_flow_keys.skel.h"
 #include "verifier_global_subprogs.skel.h"
 #include "verifier_global_ptr_args.skel.h"
 #include "verifier_gotol.skel.h"
@@ -187,6 +188,7 @@ void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_st
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_mod_bounds(void)       { RUN(verifier_div_mod_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
+void test_verifier_flow_keys(void)            { RUN(verifier_flow_keys); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
 void test_verifier_gotol(void)                { RUN(verifier_gotol); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_flow_keys.c b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c
new file mode 100644
index 000000000000..512e5d1d2665
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Constant-offset bounds checks for PTR_TO_FLOW_KEYS pointer arithmetic. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* sizeof(struct bpf_flow_keys) is well under 4096, so +0x1000 is OOB. */
+
+SEC("flow_dissector")
+__description("flow_keys: in-bounds constant pointer arithmetic accepted")
+__success
+__naked void flow_keys_const_inbounds(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + %[flow_keys]);		\
+	r1 += 8;					\
+	r0 = *(u64 *)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+SEC("flow_dissector")
+__description("flow_keys: OOB via constant pointer arithmetic rejected")
+__failure __msg("invalid access to flow keys off=4096 size=8")
+__naked void flow_keys_const_oob_read(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + %[flow_keys]);		\
+	r1 += 4096;					\
+	r0 = *(u64 *)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+SEC("flow_dissector")
+__description("flow_keys: OOB write via constant pointer arithmetic rejected")
+__failure __msg("invalid access to flow keys off=4096 size=8")
+__naked void flow_keys_const_oob_write(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + %[flow_keys]);		\
+	r1 += 4096;					\
+	r2 = 0;						\
+	*(u64 *)(r1 + 0) = r2;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+/* Equivalent OOB expressed directly in insn->off; this form was always
+ * rejected and is kept to show both forms now share one diagnostic.
+ */
+SEC("flow_dissector")
+__description("flow_keys: OOB via insn->off rejected")
+__failure __msg("invalid access to flow keys off=4096 size=8")
+__naked void flow_keys_insn_off_oob(void)
+{
+	asm volatile ("					\
+	r1 = *(u64 *)(r1 + %[flow_keys]);		\
+	r0 = *(u64 *)(r1 + 4096);			\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1

