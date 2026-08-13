Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C42C0296;
	Thu, 13 Aug 2026 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605552; cv=none; b=NaG9dkxMf8lxv6Xds9we0Xno6Ba2ER7sku9j/80s99AnSn0I+a9NATVuWxCBXsjTGL5zOnxwOqNNIQWUf9TH7ZhFl6JSlykiS2PatpD1HmVB3F8va/B7i+CU7RUkUojDu/x2S650XEfwB1xq5jy7Dk1bn0IcuErXQYBMRmbHCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605552; c=relaxed/simple;
	bh=EC2zwG7oxy7+WlUSa2EaNA8dq4681GIh0Wx7RdB1omo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jhJCdvTwIsn4MfP6Bmc7P0y4WzBBtMkerWVdKc1iSdAko4AliLtLdf4QXI/0P4+sp+K3UH4pFfkLhDf/LrnG5A4lTzdsfgRXDJIBROeAZmYc6ra3rwUuyacUiCl/Hh3GByPH9p6IkWtX/zMktEQV3QcFNRB4nMxfmCvp8ifA7lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 42fea39a96e711f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dd3d0fa6-05d4-4335-91f5-8acd60f9a65b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:7e3bd00aa8c0169534ba9e0b3707b2b6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 42fea39a96e711f1aa26b74ffac11d73-20260813
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1969336531; Thu, 13 Aug 2026 15:19:03 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH bpf-next v2 0/2] bpf, riscv: Add BPF stack arguments
 support for RV64 JIT
Date: Thu, 13 Aug 2026 07:18:41 +0000
Message-Id: <20260813-bpf-riscv-stack-args-v2-0-efea8f9b3fe1@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFvfWoC/22NQQ6CMBBFr0Jm7Zi2SgFX3sOwKHWABlNIhzQQw
 t2tXbt8+XnvH8AUHDE8igMCRcdu9gnUpQA7Gj8QundiUEJpUakau6XH4NhG5NXYCU0YGPWtFG+
 htZHUQFKXQL3bcvYFP8PTtkKbltHxOoc9/0WZ95yupfqfjhIF6qpTd10LTWXznPaP8zNfrYf2P
 M8vaECiVsMAAAA=
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
 tools/testing/selftests/bpf/progs/exceptions.c     |  5 +-
 tools/testing/selftests/bpf/progs/stack_arg.c      |  3 +-
 .../testing/selftests/bpf/progs/stack_arg_kfunc.c  |  3 +-
 .../selftests/bpf/progs/stack_arg_precision.c      |  3 +-
 .../selftests/bpf/progs/verifier_stack_arg.c       |  3 +-
 .../selftests/bpf/progs/verifier_stack_arg_order.c |  3 +-
 11 files changed, 98 insertions(+), 12 deletions(-)
---
base-commit: d114bb98936770c501c958bf2bc5fb6b7c0bad7b
change-id: 20260728-bpf-riscv-stack-args-6350d066a1e9

Best regards,
-- 
Feng Jiang <jiangfeng@kylinos.cn>

