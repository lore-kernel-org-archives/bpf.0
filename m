Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2583CF663;
	Thu, 21 May 2026 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368204; cv=none; b=kINQqWs0BpgL2pMnonSS37uLN7U6AIDCF9okuDiczPF9Whh8/mTuj7sKgIPgPLJ6YcEkYQs+yzlHA5eR2Atbx/n9jbof8d8ASPpuQ4bLHcN3LBIjDRunpSa7ggOm/FWM7hREDI+JMAAxlnUHftRqBfj16zdSfhoBmC5DGS5DWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368204; c=relaxed/simple;
	bh=/6R93NxMEysDRMXCCzHKnzpYhn1kBnV3ZX9Yk1I1LGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LX0OkFtb1RsUBHTRDLac1tG7T5oMUZwynBN6pWygQGpntBPw4tyGtRd+vgGZO3RvuNA5/0GyxbnQAMJODiWgOAZGPBdvlD0/gZo4K1vhrYMSxSX3iWOZRvtjW6eODZVfySjTtIrVn/mCICYo2ZsGFsM2Rb6lUhLn7W8p7WC1Ue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxx3gHAQ9qq_4LAA--.10360S3;
	Thu, 21 May 2026 20:56:39 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx+8EFAQ9qPBuLAA--.2485S4;
	Thu, 21 May 2026 20:56:38 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add __arch_loongarch to limit test cases
Date: Thu, 21 May 2026 20:56:36 +0800
Message-ID: <20260521125636.26744-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260521125636.26744-1-yangtiezhu@loongson.cn>
References: <20260521125636.26744-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8EFAQ9qPBuLAA--.2485S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr4DGr13uFWrGw1xXFyDXFc_yoW8tr4fpa
	y8AasYkr1xt3W3XF17GrW5uFWxKrn7X3y5XFW8WrW8Zrs8X3s7Jr1xKFW3Gr98XrWrWw45
	AaykK3Zxu3W8ZFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcsjjDUUUU

Make it possible to limit certain tests to loongarch, just like it is
already done for x86_64, arm64, riscv64, and s390x.

This is a follow up patch of:

  commit ee7fe84468b1 ("selftests/bpf: __arch_* macro to limit test cases to specific archs")
  commit 1e4e6b9e260d ("selftests/bpf: Add __arch_s390x macro")

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 1 +
 tools/testing/selftests/bpf/test_loader.c    | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 9eeb5b0b63d6..b0c441384f20 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -158,6 +158,7 @@
 #define __arch_arm64		__arch("ARM64")
 #define __arch_riscv64		__arch("RISCV64")
 #define __arch_s390x		__arch("s390x")
+#define __arch_loongarch	__arch("LOONGARCH")
 #define __caps_unpriv(caps)	__test_tag("test_caps_unpriv=" EXPAND_QUOTE(caps))
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index abdb9e6e3713..3ce32d134e2c 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -377,6 +377,7 @@ enum arch {
 	ARCH_ARM64	= 0x4,
 	ARCH_RISCV64	= 0x8,
 	ARCH_S390X	= 0x10,
+	ARCH_LOONGARCH	= 0x20,
 };
 
 static int get_current_arch(void)
@@ -389,6 +390,8 @@ static int get_current_arch(void)
 	return ARCH_RISCV64;
 #elif defined(__s390x__)
 	return ARCH_S390X;
+#elif defined(__loongarch__)
+	return ARCH_LOONGARCH;
 #endif
 	return ARCH_UNKNOWN;
 }
@@ -580,6 +583,8 @@ static int parse_test_spec(struct test_loader *tester,
 				arch = ARCH_RISCV64;
 			} else if (strcmp(val, "s390x") == 0) {
 				arch = ARCH_S390X;
+			} else if (strcmp(val, "LOONGARCH") == 0) {
+				arch = ARCH_LOONGARCH;
 			} else {
 				PRINT_FAIL("bad arch spec: '%s'\n", val);
 				err = -EINVAL;
-- 
2.42.0

