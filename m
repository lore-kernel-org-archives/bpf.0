Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBDC37D13E;
	Mon, 13 Apr 2026 04:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053125; cv=none; b=BotVHMlF7D+2vHdZBgPBBYXIDRFYoT2Zr+tnFT3Y9vI4Tdfs08o60C6do/W+4lGExYzINXdQS7I4jl1otCzEBqfJqXN9B/fQpt+p+KrG/WIU8uuopEFQV6GrX/f2f8NThMxJIwiPWApUJ3t61QKpRIMSKKGu0X2Fe72yfQlE0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053125; c=relaxed/simple;
	bh=mCp4it8EUfMTU9HORMd1P/tyjkUnKYdEXsV+q3LQIBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdRkIn3/iffGvZ8xLeo0HSJgIT12W83udWDhfOKFrOlHuMIvnaRzPLiWg/7tkygcmOrQsxWA69WrjKCwZRQWH3onnvRi47P06/Mf9xuP071QRkHvEv8osi6BIEzWmpTfe9TgZvnLRojSMGrx8cSpWuWWgR3Ig8jy/7XLS7MfqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxQ_B_a9xpuwIAAA--.88S3;
	Mon, 13 Apr 2026 12:05:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxaeBya9xpD91rAA--.9793S7;
	Mon, 13 Apr 2026 12:05:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] selftests/bpf: Make CAN_USE_LOAD_ACQ_STORE_REL usable for LoongArch
Date: Mon, 13 Apr 2026 12:05:06 +0800
Message-ID: <20260413040506.26640-6-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260413040506.26640-1-yangtiezhu@loongson.cn>
References: <20260413040506.26640-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxaeBya9xpD91rAA--.9793S7
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF17GrW8JF1DArWxKFWkXwc_yoW8tFWrp3
	WkuFyqyr18Kr4a9FnxAFWUuF4rGFykXrW8AFW0vr47G3WUJrWxJr1qkFZ0yFZ0ga9Yvrn5
	Zwn2qw13Zr48ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoxR6UUUUU

In order to do the following load-acquire and store-release tests
on LoongArch:

  sudo ./test_progs -t verifier_load_acquire
  sudo ./test_progs -t verifier_store_release
  sudo ./test_progs -t verifier_precision/bpf_load_acquire
  sudo ./test_progs -t verifier_precision/bpf_store_release
  sudo ./test_progs -t compute_live_registers/atomic_load_acq_store_rel

it needs to make CAN_USE_LOAD_ACQ_STORE_REL usable for LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h           | 4 ++--
 tools/testing/selftests/bpf/progs/verifier_precision.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index c9bfbe1bafc1..19f0bf44a9e1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -257,8 +257,8 @@
 
 #if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
 	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
-	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) || \
-	  (defined(__TARGET_ARCH_powerpc))
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
+	defined(__TARGET_ARCH_powerpc) || defined(__TARGET_ARCH_loongarch))
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 4794903aec8e..6f325876efdd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -75,8 +75,8 @@ __naked int bpf_end_to_be(void)
 
 #if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) || \
 	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) || \
-	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390)) && \
-	__clang_major__ >= 18
+	defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) || \
+	defined(__TARGET_ARCH_loongarch)) && __clang_major__ >= 18
 
 SEC("?raw_tp")
 __success __log_level(2)
-- 
2.42.0

