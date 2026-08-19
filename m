Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D832418A46;
	Wed, 19 Aug 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141377; cv=none; b=khs18Y7M5Zy4LjCHRUi0lqxdtcc2PpLWdGsiKUT1/y2hmpXU6PfSyO5+Et1c4E2anPTMjOZJ9Whnou71R3d965rBzh0w43il4OQPSbWn4D3NmcJ/9llF6aHZ6/fTjv7oezQc/5mSkacdWwzTlXUMgplClh75TI37SnvDY0I/GCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141377; c=relaxed/simple;
	bh=S0g4WFSLQ2qZFvCIQUCzd4WPm3qYSawkMr6Z+YG1OaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I56Lii2y02GjbjZn6wpY9Cf/Jvj2yHcGIeyKKmwPgIRUr5m7ogXqXyrdA/mg7ky7xzquDXwkAZgj0J3nlW/Xef+E0Rt1w4eZzdlT+ZBK6JSB8nGlBH2UDRAO/TAYuIPkMoN4IxESMjocdKFh+MP3s5BMWP+iTP2oMCJpT8Exr3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dWRdWFP3; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dWRdWFP3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787141371; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZCkwrG5UaWoJEzEsbaTN0x0VxiVzO2j77PibIF7G8XU=;
	b=dWRdWFP3RRdR7KSv09vM5kk+OinVmUZAk4OJJwkCQ8yxnJX7T4HeH+WhDzyXHShBkMvMTP2HuknuEugvl7gA1YRx/ZlwW7C2zvkLqsrpaYB/hk3G63EiYCNKM9eQYW+qzoapnZGD7j+YHJQ5wmqjkLHXy8dxiZZPenE3tUY/Ji8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X9GeFUz_1787141370;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9GeFUz_1787141370 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 20:09:31 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Enable arena LDSX tests for riscv64
Date: Wed, 19 Aug 2026 20:09:24 +0800
Message-ID: <1bab696ec36f196fa6ec74a0f056030b39730da7.1787140923.git.cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787140923.git.cp0613@linux.alibaba.com>
References: <cover.1787140923.git.cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the riscv64 JIT supports signed arena loads
(BPF_PROBE_MEM32SX), enable the arena LDSX tests on riscv64:
add JIT disassembly assertions for arena_ldsx_disasm (arena base in
s7, add into t2, sign-extending lw/lh/lb loads) and run
arena_ldsx_exception and arena_ldsx_s8/s16/s32 on riscv64.

Reviewed-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 .../testing/selftests/bpf/progs/verifier_ldsx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
index 41340877dc9d..ed0a0f159bc1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
@@ -286,6 +286,19 @@ __jited("add	x11, x0, x28")
 __jited("ldrsh	x22, [x11, #0x18]")
 __jited("add	x11, x0, x28")
 __jited("ldrsb	x22, [x11, #0x20]")
+__arch_riscv64
+__jited("add	t2, a5, s7")
+__jited("lw	s3, 0x10(t2)")
+__jited("add	t2, a5, s7")
+__jited("lh	s3, 0x18(t2)")
+__jited("add	t2, a5, s7")
+__jited("lb	s3, 0x20(t2)")
+__jited("add	t2, a0, s7")
+__jited("lw	s4, 0x10(t2)")
+__jited("add	t2, a0, s7")
+__jited("lh	s4, 0x18(t2)")
+__jited("add	t2, a0, s7")
+__jited("lb	s4, 0x20(t2)")
 __naked void arena_ldsx_disasm(void *ctx)
 {
 	asm volatile (
@@ -317,6 +330,7 @@ __description("Arena LDSX Exception")
 __success __retval(0)
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
 __naked void arena_ldsx_exception(void *ctx)
 {
 	asm volatile (
@@ -338,6 +352,7 @@ __description("Arena LDSX, S8")
 __success __retval(-1)
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
 __naked void arena_ldsx_s8(void *ctx)
 {
 	asm volatile (
@@ -369,6 +384,7 @@ __description("Arena LDSX, S16")
 __success __retval(-1)
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
 __naked void arena_ldsx_s16(void *ctx)
 {
 	asm volatile (
@@ -400,6 +416,7 @@ __description("Arena LDSX, S32")
 __success __retval(-1)
 __arch_x86_64
 __arch_arm64
+__arch_riscv64
 __naked void arena_ldsx_s32(void *ctx)
 {
 	asm volatile (
-- 
2.50.1

