Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F973D6CB3
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342874; cv=none; b=alcku36U5ncoOXyIYzwE/ijhlT1NFph9KvdyKT/FGV5bdg55pZHHXq+Y8kKN4riPzAWZ/ydLDx1KLU0VuXHv5jESaMcqWKQ8Di4WUEFz3Fx6h4B9XKCyL4u9oDjw83HoZ//zjfbDcvqBw47cXuBmfeC3vacbD68eAoWu9Y1utH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342874; c=relaxed/simple;
	bh=MBZ5Pksx3ywHeI8WLR0p9zZBYpYkNr8ya9vKlQBoo90=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m7jncEfqKdaAJDSO+639KzjtU4Vv2pr44qA1srTi4oA6gMxQf9+7dn/YroORAw+yt+LwT48FOp24v4ym2w+erfAuDrY9LLexGiaFb1nhGjboTfmuzTLgeqKvFSFnyxGLdI2SnWqCARgE2GBC/MPTZMTRRoj8bYflzu6X4/sgiZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxL6rTUsJpjSAeAA--.27211S3;
	Tue, 24 Mar 2026 17:01:07 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxC8LTUsJpmxVcAA--.43301S2;
	Tue, 24 Mar 2026 17:01:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [RFC PATCH 0/7] LoongArch: BPF: Support more atomic instructions
Date: Tue, 24 Mar 2026 17:00:59 +0800
Message-ID: <20260324090106.13527-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxC8LTUsJpmxVcAA--.43301S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XFyfGF1rJw45Jr1DJw4xuFX_yoW3Jry8pr
	s29an8JF1DA3ZF9asFyFy8uFyv93Zaqr43Gr1Fkw1fAF1rGF1vyr47WFnIvFZ8Jw4kAw4F
	vw1j9w1UX3s8ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=

This series is based on 7.0-rc5, the aim is to support more atomic
instructions: (1) 8-bit and 16-bit read-modify-write instructions,
(2) 32-bit and 64-bit load-acquire and store-release instructions.

When compiling, please set CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
and unset CONFIG_BPF_UNPRIV_DEFAULT_OFF.

Most related testcases passed and no regressions for bpf selftests.
The testcase "verifier_store_release/store-release, 64-bit @unpriv"
failed for unprivileged BPF, but the other corresponding testcase
"verifier_store_release/store-release, 64-bit" passed for privileged
BPF, I do not know what is the root cause for now, so just RFC.

Any comments will be much appreciated, I will address the comments
and send a formal series once there are no problems.

Here are the test results on LoongArch:

  $ sudo ./test_progs -t verifier_load_acquire
  #577/1   verifier_load_acquire/load-acquire, 8-bit:OK
  #577/2   verifier_load_acquire/load-acquire, 8-bit @unpriv:OK
  #577/3   verifier_load_acquire/load-acquire, 16-bit:OK
  #577/4   verifier_load_acquire/load-acquire, 16-bit @unpriv:OK
  #577/5   verifier_load_acquire/load-acquire, 32-bit:OK
  #577/6   verifier_load_acquire/load-acquire, 32-bit @unpriv:OK
  #577/7   verifier_load_acquire/load-acquire, 64-bit:OK
  #577/8   verifier_load_acquire/load-acquire, 64-bit @unpriv:OK
  #577/9   verifier_load_acquire/load-acquire with uninitialized src_reg:OK
  #577/10  verifier_load_acquire/load-acquire with uninitialized src_reg @unpriv:OK
  #577/11  verifier_load_acquire/load-acquire with non-pointer src_reg:OK
  #577/12  verifier_load_acquire/load-acquire with non-pointer src_reg @unpriv:OK
  #577/13  verifier_load_acquire/misaligned load-acquire:OK
  #577/14  verifier_load_acquire/misaligned load-acquire @unpriv:OK
  #577/15  verifier_load_acquire/load-acquire from ctx pointer:OK
  #577/16  verifier_load_acquire/load-acquire from ctx pointer @unpriv:OK
  #577/17  verifier_load_acquire/load-acquire with invalid register R15:OK
  #577/18  verifier_load_acquire/load-acquire with invalid register R15 @unpriv:OK
  #577/19  verifier_load_acquire/load-acquire from pkt pointer:OK
  #577/20  verifier_load_acquire/load-acquire from flow_keys pointer:OK
  #577/21  verifier_load_acquire/load-acquire from sock pointer:OK
  #577     verifier_load_acquire:OK
  Summary: 1/21 PASSED, 0 SKIPPED, 0 FAILED

  $ sudo ./test_progs -t verifier_store_release
  tester_init:PASS:tester_log_buf 0 nsec
  process_subtest:PASS:obj_open_mem 0 nsec
  process_subtest:PASS:specs_alloc 0 nsec
  #615/1   verifier_store_release/store-release, 8-bit:OK
  #615/2   verifier_store_release/store-release, 8-bit @unpriv:OK
  #615/3   verifier_store_release/store-release, 16-bit:OK
  #615/4   verifier_store_release/store-release, 16-bit @unpriv:OK
  #615/5   verifier_store_release/store-release, 32-bit:OK
  #615/6   verifier_store_release/store-release, 32-bit @unpriv:OK
  #615/7   verifier_store_release/store-release, 64-bit:OK
  run_subtest:PASS:obj_open_mem 0 nsec
  libbpf: BTF loading error: -EPERM
  libbpf: Error loading .BTF into kernel: -EPERM. BTF is optional, ignoring.
  run_subtest:PASS:unexpected_load_failure 0 nsec
  do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
  run_subtest:FAIL:1299 Unexpected retval: 1 != 0
  #615/8   verifier_store_release/store-release, 64-bit @unpriv:FAIL
  #615/9   verifier_store_release/store-release with uninitialized src_reg:OK
  #615/10  verifier_store_release/store-release with uninitialized src_reg @unpriv:OK
  #615/11  verifier_store_release/store-release with uninitialized dst_reg:OK
  #615/12  verifier_store_release/store-release with uninitialized dst_reg @unpriv:OK
  #615/13  verifier_store_release/store-release with non-pointer dst_reg:OK
  #615/14  verifier_store_release/store-release with non-pointer dst_reg @unpriv:OK
  #615/15  verifier_store_release/misaligned store-release:OK
  #615/16  verifier_store_release/misaligned store-release @unpriv:OK
  #615/17  verifier_store_release/store-release to ctx pointer:OK
  #615/18  verifier_store_release/store-release to ctx pointer @unpriv:OK
  #615/19  verifier_store_release/store-release, leak pointer to stack:OK
  #615/20  verifier_store_release/store-release, leak pointer to stack @unpriv:OK
  #615/21  verifier_store_release/store-release, leak pointer to map:OK
  #615/22  verifier_store_release/store-release, leak pointer to map @unpriv:OK
  #615/23  verifier_store_release/store-release with invalid register R15:OK
  #615/24  verifier_store_release/store-release with invalid register R15 @unpriv:OK
  #615/25  verifier_store_release/store-release to pkt pointer:OK
  #615/26  verifier_store_release/store-release to flow_keys pointer:OK
  #615/27  verifier_store_release/store-release to sock pointer:OK
  #615     verifier_store_release:FAIL

  All error logs:
  tester_init:PASS:tester_log_buf 0 nsec
  process_subtest:PASS:obj_open_mem 0 nsec
  process_subtest:PASS:specs_alloc 0 nsec
  run_subtest:PASS:obj_open_mem 0 nsec
  libbpf: BTF loading error: -EPERM
  libbpf: Error loading .BTF into kernel: -EPERM. BTF is optional, ignoring.
  run_subtest:PASS:unexpected_load_failure 0 nsec
  do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
  run_subtest:FAIL:1299 Unexpected retval: 1 != 0
  #615/8   verifier_store_release/store-release, 64-bit @unpriv:FAIL
  #615     verifier_store_release:FAIL
  Summary: 0/26 PASSED, 0 SKIPPED, 1 FAILED

  $ sudo ./test_progs -t verifier_precision/bpf_load_acquire
  #596/5   verifier_precision/bpf_load_acquire:OK
  #596     verifier_precision:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

  $ sudo ./test_progs -t verifier_precision/bpf_store_release
  #596/6   verifier_precision/bpf_store_release:OK
  #596     verifier_precision:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

  $ sudo ./test_progs -t compute_live_registers/atomic_load_acq_store_rel
  #80/7    compute_live_registers/atomic_load_acq_store_rel:OK
  #80      compute_live_registers:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Tiezhu Yang (7):
  LoongArch: Add some code related with AM{SWAP/ADD}.{B/H}
  LoongArch: Add some code related with {LLACQ/SCREL}.{W/D}
  LoongArch: BPF: Rename emit_atomic() to emit_atomic_rmw()
  LoongArch: BPF: Add the default case in emit_atomic_rmw()
  LoongArch: BPF: Add {8,16}-bit read-modify-write instructions
  LoongArch: BPF: Add load-acquire and store-release instructions
  selftests/bpf: Enable CAN_USE_LOAD_ACQ_STORE_REL for LoongArch

 arch/loongarch/include/asm/cpu-features.h     |   2 +
 arch/loongarch/include/asm/cpu.h              |   4 +
 arch/loongarch/include/asm/inst.h             |  12 ++
 arch/loongarch/include/uapi/asm/hwcap.h       |   2 +
 arch/loongarch/kernel/cpu-probe.c             |   8 +
 arch/loongarch/net/bpf_jit.c                  | 178 ++++++++++++++++--
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   4 +-
 .../selftests/bpf/progs/verifier_precision.c  |   4 +-
 8 files changed, 199 insertions(+), 15 deletions(-)

-- 
2.42.0

