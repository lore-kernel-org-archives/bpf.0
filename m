Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD223370D63
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150926; cv=none; b=UE0L3PT9Pho9tb/wwNtXWeNF2iEO2lk25lrqiIxAKoi9pNwg6nQdQLuF21LxsekpHyaPM/JY8Ch4EwwkoxjZBNmchlLU4dSyBPtygIIE+93+jZEifaucRlL6zGE2E4PGJgzKKvvq+lNahwFFlB2mFAzvPLKHwC1eJD5C16ffqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150926; c=relaxed/simple;
	bh=LTUAUXFZoxEc+JMQ8f8EztP6j9JsYJsstYJNo3VE65s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F09qLV5+Gb0k85dKJobBkAHe+j0t8bRoFh6UGv7p8J4sCzpQETEufWaa1wax1n2MrT36AgauDTztcw5zhJcQaSEQtkNaXm76uwUvmAupkISdVTXyWC16MuiB6Q/Wp7JAdBaKsfa8SKu9+3ACIxk72FmmzAsgw17H7Diy65e1coU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx8ep_6d1pfWkAAA--.2090S3;
	Tue, 14 Apr 2026 15:15:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxzsJ86d1pWLtsAA--.10358S2;
	Tue, 14 Apr 2026 15:15:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: bpf@vger.kernel.org
Subject: [PATCH RFC bpf-next 0/4] selftests/bpf: Update atomics test
Date: Tue, 14 Apr 2026 15:15:03 +0800
Message-ID: <20260414071507.29804-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsJ86d1pWLtsAA--.10358S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4DKw48JF17tw43Cr15trc_yoW5Xryfpa
	ykWrZrKFy7ZFyft3s8ArWDGa1rAFs5A3yjgF4kW3srCF4akFy0yFyxtF90ga98Xr1ftr45
	u340g39xGa18urXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=

Extend the BPF atomics selftests to provide full coverage for the 8-bit
(BPF_B) and 16-bit (BPF_H) atomic instructions introduced in recent BPF
ISA updates.

While the BPF verifier and JIT backends now support these narrower widths,
the existing selftests primarily focused on 32-bit and 64-bit operations.
The aim of this series is to ensure that the all of the instructions are
correctly handled across various memory regions and instruction variants.

The tests are intended to be run with the test_progs-cpuv4 runner.

This is just RFC, because there are building failures when executing
"make test_progs-cpuv4" under tools/testing/selftests/bpf, maybe it
needs support by LLVM.

  CLNG-BPF [test_progs-cpuv4] atomics.bpf.o
progs/atomics.c:61:17: error: unsupported atomic operation, please use 32/64 bit version
   61 |         add16_result = __sync_fetch_and_add(&add16_value, 2);
      |                        ^
progs/atomics.c:62:2: error: unsupported atomic operation, please use 32/64 bit version
   62 |         __sync_fetch_and_add(&add16_noreturn_value, 2);
      |         ^
progs/atomics.c:63:23: error: unsupported atomic operation, please use 32/64 bit version
   63 |         add16_stack_result = __sync_fetch_and_add(&add16_stack_value, 2);
      |                              ^
progs/atomics.c:66:17: error: unsupported atomic operation, please use 32/64 bit version
   66 |         add8_result  = __sync_fetch_and_add(&add8_value, 2);
      |                        ^
progs/atomics.c:67:2: error: unsupported atomic operation, please use 32/64 bit version
   67 |         __sync_fetch_and_add(&add8_noreturn_value, 2);
      |         ^
progs/atomics.c:68:22: error: unsupported atomic operation, please use 32/64 bit version
   68 |         add8_stack_result = __sync_fetch_and_add(&add8_stack_value, 2);
      |                             ^
fatal error: error in backend: Cannot select: 0x15543e4f0: i32,ch = AtomicLoadAdd<(load store seq_cst (s8) on %ir.5)> 0x15543e480:1, FrameIndex:i64<3>, Constant:i32<2>,
      progs/atomics.c:68:22
In function: add
PLEASE submit a bug report to https://github.com/llvm/llvm-project/issues/ and include the crash backtrace, preprocessed source, and associated run script.

Tiezhu Yang (4):
  selftests/bpf: Only define ENABLE_ATOMICS_TESTS for cpuv4 runner
  selftests/bpf: Add 8-bit and 16-bit fetch-based testcases for atomics
  selftests/bpf: Introduce all of non-fetch-based testcases for atomics
  selftests/bpf: Implement exhaustive stack-based testcases for atomics

 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/atomics.c        |  90 ++++++--
 tools/testing/selftests/bpf/progs/atomics.c   | 194 ++++++++++++++++--
 3 files changed, 251 insertions(+), 35 deletions(-)

-- 
2.42.0

