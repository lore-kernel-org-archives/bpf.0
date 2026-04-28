Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3F2C027F;
	Tue, 28 Apr 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363262; cv=none; b=U0px5UosiBAAL8xLCegcelu+/1jdFho+Ndc/YDoWGgin1iRumoK+v2HsbULw7bGt28s9F+q682dp4MIIRDqgy18FkJ4MA/0raTjueolV9qNDzSCPS7AknoIkiAFXtRo/UokQlLBh4JfrOJzUkrV1fUbyGx5p/qG7A3xF+1S9cZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363262; c=relaxed/simple;
	bh=KXf7wyigCxWQyjk93Ql6iedexnVqP3jzQ9HGdHTmS7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRQkMnaTFzDzUjAuuCaWvwyvjqVotC4jf0yG6YG+HsTrHpzp1q7RRTvxOwdFlyAP5qxUpJ6QujjFwDqgCsm5IhUcw/DV4DZlE7xCEfeDtcEVdvs7ueJixzR6KTPSvILiMfLo/f2IJB03UYvu3ka/uoiq1JG+RHDicYD0i7bSaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx3ek7afBpEq0EAA--.15440S3;
	Tue, 28 Apr 2026 16:00:59 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx38I1afBpmWt2AA--.27930S4;
	Tue, 28 Apr 2026 16:00:58 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 2/3] selftests/bpf: Test inline_bpf_get_current_task() for LoongArch
Date: Tue, 28 Apr 2026 16:00:50 +0800
Message-ID: <20260428080051.20938-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260428080051.20938-1-yangtiezhu@loongson.cn>
References: <20260428080051.20938-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx38I1afBpmWt2AA--.27930S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw47GF47tFW3Jr1fuw13Jrc_yoW8XFyDp3
	ykW3srt3s8Ga42gay7AF4DZFW5XF95Z3y5Ar1Fg3yUCF4DJr1kXr93Gr13Cry5WFZY939a
	vw129a1vga4UJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcDDGUUUUU

Add the JITed inline instruction of bpf_get_current_task() for LoongArch
to pass the test case.

Before:

  $ sudo ./test_progs -t verifier_jit_inline
  #570/1   verifier_jit_inline/inline_bpf_get_current_task:SKIP
  #570     verifier_jit_inline:SKIP
  Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED

After:

  $ sudo ./test_progs -t verifier_jit_inline
  #570/1   verifier_jit_inline/inline_bpf_get_current_task:OK
  #570     verifier_jit_inline:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Note that this test will pass only after the JIT inline support for
bpf_get_current_task is merged. While the JIT inlining is still in
the pipeline, adding the changes now will not introduce any build
regressions. It serves to define the expected JIT output for future
validation.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/verifier_jit_inline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
index 4ea254063646..913a1699e42b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -10,6 +10,8 @@ __arch_x86_64
 __jited("	addq	%gs:{{.*}}, %rax")
 __arch_arm64
 __jited("	mrs	x7, SP_EL0")
+__arch_loongarch
+__jited("	move	$a5, $tp")
 int inline_bpf_get_current_task(void)
 {
 	bpf_get_current_task();
-- 
2.42.0

