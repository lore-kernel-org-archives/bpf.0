Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3FD371D04
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150923; cv=none; b=SVlZw0OdSzBUUrx60sqkCsl4eEcVD6Agw4pVHZvyfQkwWxT9i3AUPSIFfRykNHnp2q9rFn3yHo2lboOK0t7ewx+yhYG/roln50emDULSvBlflPyY2DZTxULT9VG3vIoA9FKoRlq3sL9JxRHCfSz0XMbJgskFBsG31ZUgNIEXtVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150923; c=relaxed/simple;
	bh=8b3d0mszzhUcsOgu0DYLC/CpLuQ3kE6tDyLVmUGLV8M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTh4n47D1q/1dki1KS19SUO6OzuQCvzByg5iEunfB+0uNGjizQpTtT9jmE9Rz5WwhhqMFD2uRy7T2dE3qPykkECx+oOrUqP5MQTX1KbRShUtuiVlncbH8TLShbzLS+9eFavKCnXpFfQ4YXqkoQa90HlT++jeSoqqKrzlYx5Eb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxI_CB6d1pfmkAAA--.1999S3;
	Tue, 14 Apr 2026 15:15:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxzsJ86d1pWLtsAA--.10358S3;
	Tue, 14 Apr 2026 15:15:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: bpf@vger.kernel.org
Subject: [PATCH RFC bpf-next 1/4] selftests/bpf: Only define ENABLE_ATOMICS_TESTS for cpuv4 runner
Date: Tue, 14 Apr 2026 15:15:04 +0800
Message-ID: <20260414071507.29804-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260414071507.29804-1-yangtiezhu@loongson.cn>
References: <20260414071507.29804-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsJ86d1pWLtsAA--.10358S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur18Wr45Jr17GF1fuF13WrX_yoW8Xw4xpa
	n7Ga10yFZ7WFy8K3Z7ArZrXr4fKws5X3yxAFW8tryFvr43Jr1kXF4Iga4Y9F12gr4rXws3
	Z34a9Fy3u3W8AwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=

Currently, ENABLE_ATOMICS_TESTS is added to the global TRUNNER_BPF_CFLAGS.
This causes build failures when the default test_progs runner (typically
uses -mcpu=v3) attempts to compile atomic operations on 8-bit and 16-bit
variables. The BPF backend for Clang only supports BPF_B and BPF_H atomic
instructions when -mcpu=v4 is explicitly specified.

Refactor the Makefile to only define ENABLE_ATOMICS_TESTS for the cpuv4
test runner. This ensures that:

1. The default build (make) passes by skipping 8/16-bit atomic code paths
   when using older instruction sets.
2. Comprehensive atomic testing is enabled for the cpuv4 runner where the
   proper compiler flags are guaranteed.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c028..c38a149932e3 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -775,7 +775,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
 		       $(wildcard progs/*.bpf.o)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
-TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
+TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS)
 $(eval $(call DEFINE_TEST_RUNNER,test_progs))
 
 # Define test_progs-no_alu32 test runner.
-- 
2.42.0

