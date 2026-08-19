Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD833D1712;
	Wed, 19 Aug 2026 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129617; cv=none; b=u3HAKtpWwxxHat9tuln7xDc6kh5uknliySjg82gAPvPhha18+MxXOaZKKst7j+t6Jlmvv9J+HHnOcAybmNRQS+6hVnBNfYWiRis99P5yej0kxvoJxcDWRNt0j/VF0UyOBRpHUdyDYTxiSx7PVFRCZr7PD0gT6LlMq2jEB45wDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129617; c=relaxed/simple;
	bh=S0g4WFSLQ2qZFvCIQUCzd4WPm3qYSawkMr6Z+YG1OaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqSPfwjbVI6yGlM1ndva+DIMWIyOtCM/EFZtuEum7t+SwFUZaYlujsf1F5GSPapKIhEBYRExvkE0PX7uNKA67XXU+MvH2gH4/nABn07h9xZboYNeOQgxxrXiAnJY0LRs2uU/l0d9SGHc8Kgp2gJsHLVMON4j88pIjIJY9m9vp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Fi8A6jH5; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Fi8A6jH5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787129605; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZCkwrG5UaWoJEzEsbaTN0x0VxiVzO2j77PibIF7G8XU=;
	b=Fi8A6jH5QBLvC4i/+9h0Jfsdv4z9b977qkZwY2KESQmsntWpXXTGhMWmOn6KroQNJeHu1YTo5Elr+UyGUJDoEa81yAmzcwV8j3cpXbgVZganqsTIJPG+07nxYwrrAKOganQPVPcOCVO/KyG6Tz+AgAwYJuBct4awsOaNQUV3K9g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X9G1g-1_1787129603;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9G1g-1_1787129603 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 16:53:24 +0800
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Enable arena LDSX tests for riscv64
Date: Wed, 19 Aug 2026 16:53:16 +0800
Message-ID: <b31c252625e16db62b87b8301b79bf6cc7d7ffac.1787128322.git.cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787128322.git.cp0613@linux.alibaba.com>
References: <cover.1787128322.git.cp0613@linux.alibaba.com>
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

