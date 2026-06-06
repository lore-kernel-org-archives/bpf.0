Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78040191;
	Sat,  6 Jun 2026 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780743066; cv=none; b=Cy7TQXnd5QKRO2esmTjyrb7HEm6iGpCRA9UFuvzMhc7LTxSYQy9dqjow0ZuXP+ZmLedoFIAf+awnmcjpAjBge6lwdXLEBWT3gEO4jO9PQnS00yxzsj9+6Bv3PJIazsUUGcwz6Vka7xk11aCvHghmBP9vs60TQnRtOyKjDzUkpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780743066; c=relaxed/simple;
	bh=F9wWB3gzwS6cYyDm9Khbjz4fhBE8uBZvhmH1osFybs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHcA1DxCZcz2kCAMdQsLh9F/O9ztBLoS4cWCLg9HGaNBwPn+D19Tx/bsiupUaaDWt7BoU2afxkclQRMaDTof/1h3kcsAjkQH6YqvhCD7opR1jcXfj1O2coAvKbSLODTQIgots+6eM3OkwByiDg8yGyVOwz8fv9Xy2gNlnPwEVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=n3yA+mGD; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="n3yA+mGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=2+TIAZz3nyi70H/5JZBVf7VLbBwETYe
	cx5/LUN4eZII=; b=n3yA+mGDSofs1CvySiykfa+MYe7Gh78LVzNWBypIiokF3h5
	wghQZUMRgdq4Mf/oDPQORgshYc/WBJciyJrWmwBmVgaZ+Nl0uaSZ+swAy2jom2Qv
	faTp1KpVnXXewAcPG6usItOLTPvE5mpWDzkAa0NG/tzdeCpw5TZOFAukuw8s=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQC3cMB++yNqENcwAg--.58351S4;
	Sat, 06 Jun 2026 18:50:39 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 06 Jun 2026 18:50:38 +0800
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 PTR_TO_FLOW_KEYS offset bounds
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-c3-01-v3-v3-2-97c51f592f15@mails.tsinghua.edu.cn>
References: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
In-Reply-To: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780743040; l=5174;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=F9wWB3gzwS6cYyDm9Khbjz4fhBE8uBZvhmH1osFybs4=;
 b=FdigwVgUm7/DHhNTEfvIq3uo5SrEStZcNpwGQc0Jm6OuIBkEbk2tqi2RGcecrAOESFYUZIbHC
 QNepKl6xO0IAqwRCdSB14lLUstNl1G/PlrEFu4vlSbwHG3fzrQdjxL2
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQC3cMB++yNqENcwAg--.58351S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW5JFyDXF4rKryfJFyrJFb_yoW7Xr4kpr
	n5u3ZIgay8Zr13Wa17AF48ZFyFqa1kXw45AFy8Aw15AF1DJwn7Wr4kGrWUGr1fArn8W3yY
	yr4Fqr13AF4DAFJanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r1Y6r17M2vYz4IE04k24VAvwV
	AKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6x8ErcxFaVAv8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wrylc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUFT5lUUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgAKA2ojTRugSwAFs6

Add verifier tests covering pointer arithmetic on a PTR_TO_FLOW_KEYS
register. This covers the bpf-next regression where an out-of-bounds
constant offset introduced as flow_keys += K and then dereferenced at
insn->off 0 was accepted, while the equivalent flow_keys + K direct offset
was rejected.

The tests check that in-bounds constant arithmetic on the keys pointer is
still accepted, out-of-bounds constant arithmetic is rejected for both read
and write, and a truly varying offset from bpf_get_prandom_u32() remains
rejected by the existing PTR_TO_FLOW_KEYS pointer arithmetic rules.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 +
 .../selftests/bpf/progs/verifier_flow_keys.c       | 97 ++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 89779d897aba..8a3d69e2453c 100644
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
@@ -190,6 +191,7 @@ void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_st
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
 void test_verifier_div_mod_bounds(void)       { RUN(verifier_div_mod_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
+void test_verifier_flow_keys(void)            { RUN(verifier_flow_keys); }
 void test_verifier_global_subprogs(void)      { RUN(verifier_global_subprogs); }
 void test_verifier_global_ptr_args(void)      { RUN(verifier_global_ptr_args); }
 void test_verifier_gotol(void)                { RUN(verifier_gotol); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_flow_keys.c b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c
new file mode 100644
index 000000000000..d780a36a6e9a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_flow_keys.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Bounds checks for PTR_TO_FLOW_KEYS pointer arithmetic. */
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
+SEC("flow_dissector")
+__description("flow_keys: variable pointer arithmetic rejected")
+__failure __msg("R1 pointer arithmetic on flow_keys prohibited")
+__naked void flow_keys_var_read(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xFFFF;					\
+	r1 = *(u64 *)(r6 + %[flow_keys]);		\
+	r1 += r0;					\
+	r0 = *(u64 *)(r1 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(flow_keys, offsetof(struct __sk_buff, flow_keys)),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";

-- 
2.34.1

