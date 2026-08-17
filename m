Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709E3B71A3;
	Mon, 17 Aug 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786951493; cv=none; b=PnXCRvu+aLs+yr+5CRWL+MmThUdtxPNJNjpmdPphDvICAWaJ+TeIzXVgFgfaJHgkJdjAyzAVrxokNr+0AL0dkYjr3Ed9jqTiEAloZuj7/eh4Mh6y67tw3joE7c1/MIs6430ZID1ZqP24J/XZWTB77ZaC6OwC5SkCRtE0Od7pXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786951493; c=relaxed/simple;
	bh=f06tOPZ1julrNQSafVLBYB6Jc5E2gj7xvDNDijzZpaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVJoy71BYy0/EkyIlLS2M5XA+Oi0O2uBAOGM2dYFt2e20DMiX1ojLG1mn448gqE8Tu3XFZri9SqjY8/43pMZPjbLoQruyjY96auIcfTGcTDo16cN6Gip3xIkjGSiwnwt25gmfucg12SA7lCaMGbrCSB5cSalMijr8R2MXCYLMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SuOgOgfF; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SuOgOgfF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786951487; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QiDMtzylae+qC9+4Ug6NQ9raR1nP9TUQubbhKCJf3IM=;
	b=SuOgOgfFtwDdNqjhm/vtYi+VOXVhM3euQsgUS8KeuolB1X4HIARWHyQKXERSGe5gVt+QjaX1B2+r7gqJuJ+cDtS34PP3ny6U9hqnFlX0Yx1WdDXjbr01lAU4exPHbTOw8iOzHBJuA5iIEeqV6pYViwm1AHjWImCg9t194FPHNpM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X946s4R_1786951486;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X946s4R_1786951486 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 15:24:46 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: eddyz87@gmail.com,
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Enable arena LDSX tests for riscv64
Date: Mon, 17 Aug 2026 15:24:33 +0800
Message-ID: <913f4fd8b3d0b7470428d9e6f0ed64f3a89e8a98.1786708960.git.cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786708960.git.cp0613@linux.alibaba.com>
References: <cover.1786708960.git.cp0613@linux.alibaba.com>
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

