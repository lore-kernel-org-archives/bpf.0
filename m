Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CDA2E7165;
	Fri, 14 Aug 2026 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670973; cv=none; b=GEQFLOVFWnuuB+t6qUCxB95SFZ7+BnBiHWhfBP7xQtqYYnSC/cUnzOoBcmEouF3ksh/GkEc1hS3G6e7TXwscxeB7/y/dHp5posO+nv1GNIu+0h4sy1e6qR7LEUrgLPy7oioqUOQuS4YJw+JgrX5tB2hxEfsiqHdOJa1yoOmI1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670973; c=relaxed/simple;
	bh=5lG2fKvLH9z+sik8yf3Ct2EKdBEopun9RtSDbGD7Jpg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KF6AeqQL4RNG0DQW70BfSkhghdwdKLh6wMeWEPkmubmMobwHVj+nGjqDa2pecFB/fB/xPKaYMJc55XSiQqGlhoFysOyzQ7m0jHX+1cGcJmRYnbtRwXOA28xSevipG7cIWfhKGgYII5iDCeorLQFBk4U5wq12RYmbFaliHOZqA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9586912a977f11f1aa26b74ffac11d73-20260814
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3ebe20aa-3b6e-4e24-9a03-eb0659e72c16,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:7cd0f55f152b39015d90a1aa5b7ec287,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9586912a977f11f1aa26b74ffac11d73-20260814
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1959050617; Fri, 14 Aug 2026 09:29:25 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH bpf-next v3 0/2] bpf, riscv: Add BPF stack arguments
 support for RV64 JIT
Date: Fri, 14 Aug 2026 01:29:02 +0000
Message-Id: <20260814-bpf-riscv-stack-args-v3-0-2160de56fea3@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF5vfmoC/3XNTQ6CMBQE4KuQrq3pjxRw5T2Mi1Je4QVTSEsaC
 OHu1q400eVkMt/sJIBHCORa7MRDxICTS0GeCmIG7Xqg2KVMBBOKVaKm7Wypx2AiDYs2I9W+D1T
 JknVMKc2hIWk6e7C4ZvZO3gsH60IeqRkwLJPf8l/kuc90zcVvOnLKqKpacVE1U1A2t3F7opvC2
 bgsRvGpyD+KSApY0LVtWmmBfynHcbwAhyLSegkBAAA=
X-Change-ID: 20260728-bpf-riscv-stack-args-6350d066a1e9
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

Port the BPF stack argument feature (BPF_REG_PARAMS / r11) to the
RV64 JIT, matching what x86 and arm64 already do.

BPF-to-BPF calls keep all extra arguments on the stack.  For kfunc
calls, the JIT loads arguments 6-8 into A5-A7 at the call site to
satisfy the RISC-V C calling convention.

Tested on riscv64 QEMU with LLVM main [1]; BPF-to-BPF and kfunc
selftests pass.

[1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
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

---
Feng Jiang (2):
      bpf, riscv: Add BPF stack arguments support for RV64 JIT
      selftests/bpf: Enable stack argument tests for RV64

 arch/riscv/net/bpf_jit.h                           |  1 +
 arch/riscv/net/bpf_jit_comp64.c                    | 79 +++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c                      |  4 ++
 .../selftests/bpf/progs/btf__stack_arg_precision.c |  3 +-
 .../bpf/progs/btf__verifier_stack_arg_order.c      |  3 +-
 tools/testing/selftests/bpf/progs/stack_arg.c      |  3 +-
 .../testing/selftests/bpf/progs/stack_arg_kfunc.c  |  3 +-
 .../selftests/bpf/progs/stack_arg_precision.c      |  3 +-
 .../selftests/bpf/progs/verifier_stack_arg.c       |  3 +-
 .../selftests/bpf/progs/verifier_stack_arg_order.c |  3 +-
 10 files changed, 95 insertions(+), 10 deletions(-)
---
base-commit: d114bb98936770c501c958bf2bc5fb6b7c0bad7b
change-id: 20260728-bpf-riscv-stack-args-6350d066a1e9

Best regards,
-- 
Feng Jiang <jiangfeng@kylinos.cn>

