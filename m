Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988976;
	b=tTghwcF6hdRFd2bINg0gfNaCYqkAGXe6xy8MZfgU/sz8QGvNRO2bcmsczdm61XVHR8Ip
	 FcGa6hx/1ZLyxDWrRyH07484yLfyM3lveM2JIesuQE6FrCOUE69Yt5JcRZs4+P8yeG5uz
	 k4NDhGaBCFs1EZJr60VKHQSWZRXzWTiMSFE0t1v8hvxva2OiXGoy2cSGKrNeyKQuDufVf
	 /jGJ6NK1oqicXaScXlDoSkP+b/tjKhWAHXgj902wzC9rthPnFNTyvs0gKl3kklJeZM9B9
	 iklgn+tjkQrPpxSkmW7UCKJCA8kt+CnLOZnJJAFZEz6lGPqmYUBZgFHridRLJwHnFGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988976;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oj7yyLGXka6snyLwwPDV89YPr2tF7hbTbrbYfPXXDNc=;
	b=FdhHlAtPsCnPeUoWhRQ4XaOLNY2YLqyGIk38OmJn3ZYbhcv1ke1XPmDPMlAmzyfGqNZG
	 ZgXtlWGM9dNRg7+GFYKDv8Tusu/EsHdJ14+fWa4/1CFLyU/gdZE2qB+EJ5xZKEb7XYHOK
	 +VAon2DnvHb952ws6JxpEE5hfch4rnBjpCruLid5jdXi2q4cRttIAgnaDTvXplmvoNdvl
	 jG/fw5z8HtV21sDdOnBIGd3soMLw/wOUAw/Xv5Eeh7YlH15JnVyjdEbmlvHP871WhmwDE
	 jK8fA9OYwXVu1TL2X4kXaCMgU+Qb1xtHaTWfcQdFs/hj0uO1Amqtc7S6Kfequ1mhh1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T8bVa0HA;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F498606A329;
	Fri,  6 Nov 2026 18:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F498606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=T8bVa0HA
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793988972; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oj7yyLGXka6snyLwwPDV89YPr2tF7hbTbrbYfPXXDNc=;
	b=T8bVa0HANS3Twz08sAhyHtzokmQQYzTA/JpbpY/Sn0yZ6Se9G7MIIuQS1JUsaT7A9RYMLoq8RZjUxMjKL2Lb2rVhQE9aPy3n2DMfmetNZpiypB5a+pfuqNMxrUgof2z7hr9Qbv3H6ldhL8aH7aWOue7Sq9iWOBRa/g0MsLBXoHY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XECMC2V_1793988969;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XECMC2V_1793988969 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Nov 2026 02:16:10 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org,
	alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	shuah@kernel.org,
	rgbi3307@gmail.com,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 2/3] selftests/bpf: Enable private stack tests for riscv64
Date: Sat,  7 Nov 2026 02:15:57 +0800
Message-ID: <20261106181558.1564-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106181558.1564-1-cp0613@linux.alibaba.com>
References: <20261106181558.1564-1-cp0613@linux.alibaba.com>
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

The RV64 JIT now supports the private stack. Allow the existing
verifier and struct_ops private-stack tests to run on riscv64 and add
the expected RV64 JITed instruction patterns.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
---
 .../bpf/prog_tests/struct_ops_private_stack.c |  3 +-
 .../bpf/progs/verifier_private_stack.c        | 41 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
index 2b3ec2b79091..103179ff8733 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
@@ -6,7 +6,8 @@
 #include "struct_ops_private_stack_recur.skel.h"
 #include "struct_ops_private_stack_large.skel.h"
 
-#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__) || \
+	(defined(__riscv) && __riscv_xlen == 64)
 static void test_private_stack(void)
 {
 	struct struct_ops_private_stack *skel;
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index aa15361bcca5..3cde7b1af126 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -8,7 +8,8 @@
 /* From include/linux/filter.h */
 #define MAX_BPF_STACK    512
 
-#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
 
 struct elem {
 	struct bpf_timer t;
@@ -42,6 +43,14 @@ __jited("	mov	x0, #0x2a")
 __jited("	str	x0, [x27]")
 __jited("...")
 __jited("	ldp	x25, x27, [sp], {{.*}}")
+__arch_riscv64
+__jited("	addi	sp, sp, -0x20")
+__jited("...")
+__jited("	sd	s5, 0x10(sp)")
+__jited("...")
+__jited("	sd	a0, -0x100(s5)")
+__jited("...")
+__jited("	ld	s5, 0x10(sp)")
 __naked void private_stack_single_prog(void)
 {
 	asm volatile ("			\
@@ -60,6 +69,10 @@ __jited("	subq	$0x8, %rsp")
 __arch_arm64
 __jited("	mov	x25, sp")
 __jited("	sub	sp, sp, #0x10")
+__arch_riscv64
+__jited("	addi	sp, sp, -0x30")
+__jited("...")
+__jited("	addi	s5, sp, 0x10")
 __naked void no_private_stack_nested(void)
 {
 	asm volatile ("			\
@@ -153,6 +166,14 @@ __jited("	str	x0, [x27]")
 __jited("	bl	{{.*}}")
 __jited("...")
 __jited("	ldp	x25, x27, [sp], {{.*}}")
+__arch_riscv64
+__jited("	addi	sp, sp, -0x20")
+__jited("...")
+__jited("	sd	s5, 0x8(sp)")
+__jited("...")
+__jited("	sd	a0, -0x200(s5)")
+__jited("...")
+__jited("	ld	s5, 0x8(sp)")
 __naked void private_stack_nested_1(void)
 {
 	asm volatile ("				\
@@ -223,6 +244,16 @@ __jited("	bl	0x{{.*}}")
 __jited("	mov	x8, x0")
 __jited("	mov	x8, #0x0")
 __jited("	ldp	x25, x27, [sp], {{.*}}")
+__arch_riscv64
+__jited("func #1")
+__jited("...")
+__jited("	addi	sp, sp, -0x20")
+__jited("...")
+__jited("	sd	s5, 0x8(sp)")
+__jited("...")
+__jited("	sd	a0, -0x200(s5)")
+__jited("...")
+__jited("	ld	s5, 0x8(sp)")
 __naked void private_stack_callback(void)
 {
 	asm volatile ("			\
@@ -452,6 +483,10 @@ __arch_arm64
 __jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
 __jited("	add	x27, x27, x10")
 __jited("	add	x25, x27, {{.*}}")
+__arch_riscv64
+__jited("	addi	sp, sp, -0x20")
+__jited("...")
+__jited("	sd	s5, 0x8(sp)")
 int private_stack_async_callback_1(void)
 {
 	struct bpf_timer *arr_timer;
@@ -481,6 +516,10 @@ __arch_x86_64
 __jited("	subq	$0x100, %rsp")
 __arch_arm64
 __jited("	sub	sp, sp, #0x100")
+__arch_riscv64
+__jited("	addi	sp, sp, -0x120")
+__jited("...")
+__jited("	addi	s5, sp, 0x100")
 int private_stack_async_callback_2(void)
 {
 	struct bpf_timer *arr_timer;
-- 
2.50.1

