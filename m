Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE2414A619;
	Sat,  5 Sep 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591547; cv=none; b=E/fYYCpb+bJVftv/FgMgBc7A+T3jEoasOuM0acyWPdkPAuqkJo+FFZ6vtAmoWmuveZQLnjEMfBlIMyXZaEuHkUJFTsVE1Om3XMK7VwnPNSPAaD0KIqZ5rK0OnXRpUbWnjq7x0LNLTavAPco4mOuTN3jBl4RV90VJZRSWKGQQVcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591547; c=relaxed/simple;
	bh=Sl9FcmjzYX+gdN0zbJG9gCD5j/qX6Ln34MKkeEdIvZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O2RLVrLSdDna7684jlAUamoDJfC3hiN+s339xu/1+HjyryAsKc5N//oLwb8Yxnm2fgZKR0g0VdEOJ23tJCCg4Q5txCwGvwGnr1/gbFvc0WSauwbUjA9eG7TgGffp+uMLqH+La85MJ7DcuGhsFz9mqoHyK8XYpJAWksUrtcKqRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hcPL54BhyzKHMV3;
	Sat,  5 Sep 2026 14:58:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 243684056B;
	Sat,  5 Sep 2026 14:59:02 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDXvQi0vZtqheFEAw--.38251S2;
	Sat, 05 Sep 2026 14:59:01 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Feng Jiang <jiangfeng@kylinos.cn>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v4 0/3] Add bpf stack arguments support for RV64
Date: Sat,  5 Sep 2026 07:04:06 +0000
Message-Id: <20260905070409.4141522-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXvQi0vZtqheFEAw--.38251S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF18Jw48CrWxGr4xWw17Wrg_yoW8ury7pa
	4v9Fy3Kryvva12ga1xCFWUWryrJF4ku3y3WF4xZ3y5J3W8tryUXrn3Ka1rJwn8JF97X3Wr
	ZwnagF9xGa1kZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

Implement bpf_jit_supports_stack_args() on RV64 JIT to allow bpf
subprogs and kfuncs to pass and receive more than 5 arguments.

Tested on riscv64 QEMU with LLVM main [1]; BPF-to-BPF and kfunc
selftests pass.

[1] https://github.com/llvm/llvm-project/pull/189060

---
Changes in v4:
- Remap BPF_REG_0 and RV_REG_TCC to align the calling convention of
  bpf2bpf and kfunc calls with the riscv abi.
- Adapt the bpf stack arguments implementation based on change 1.

Changes in v3:
- Drop the exceptions.c guard change: the guarded programs use
  bpf_throw(), unsupported by the RV64 JIT, so the test is denylisted
  on riscv64 and the guard has no effect. (BPF CI)
- Link to v2: https://lore.kernel.org/r/20260813-bpf-riscv-stack-args-v2-0-efea8f9b3fe1@kylinos.cn

Changes in v2:
- Sign-extend 32-bit kfunc arguments passed on the stack (args 9+),
  matching the register path and the RISC-V psABI. (Sashiko)
- Restrict the riscv selftest guard to __riscv_xlen == 64 so the
  tests are not enabled on RV32. (Sashiko)
- Link to v1: https://lore.kernel.org/r/20260812-bpf-riscv-stack-args-v1-0-67b246806e59@kylinos.cn


Feng Jiang (2):
  riscv, bpf: Add BPF stack arguments support for RV64 JIT
  selftests/bpf: Enable stack argument tests for RV64

Pu Lehui (1):
  riscv, bpf: Remap BPF_REG_0 and RV_REG_TCC

 arch/riscv/net/bpf_jit.h                      |  1 +
 arch/riscv/net/bpf_jit_comp64.c               | 87 ++++++++++++++++---
 arch/riscv/net/bpf_jit_core.c                 |  6 ++
 arch/riscv/net/bpf_timed_may_goto.S           |  4 +-
 .../bpf/progs/btf__stack_arg_precision.c      |  3 +-
 .../bpf/progs/btf__verifier_stack_arg_order.c |  3 +-
 tools/testing/selftests/bpf/progs/stack_arg.c |  3 +-
 .../selftests/bpf/progs/stack_arg_kfunc.c     |  3 +-
 .../selftests/bpf/progs/stack_arg_precision.c |  3 +-
 .../selftests/bpf/progs/verifier_jit_inline.c |  2 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |  6 +-
 .../selftests/bpf/progs/verifier_stack_arg.c  |  3 +-
 .../bpf/progs/verifier_stack_arg_order.c      |  3 +-
 13 files changed, 101 insertions(+), 26 deletions(-)

-- 
2.34.1

