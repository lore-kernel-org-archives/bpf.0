Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BCC3803C3;
	Wed, 15 Jul 2026 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099579; cv=none; b=sehtomwq49oldSmmB33Do6NG7FnCu/MI/oZd6EWPrnNP7iXRq90stMxYe0f2itlpgl3ANvhjCvjfIODxG+FEMkX11a0/XPYXSYVjM002T3+fg5Z1L+UvCSmYDM/h7vu6K1U2PwKJoirZKS6uzsZG2r6o/+03jqwSPPG6ZRMPGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099579; c=relaxed/simple;
	bh=AILBo0AnB3n3rJenZM9fS56wG1PtkMV6MGymqNrBWik=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R6dE8Vm+DGYVeIeF/ZTfOiE3SON0X4FoG2r4K0UoDdw5XNFWkPWB7m35wJOTC1ODFrtA/y1XJpIp31lXgAS6puznQJEQ10lK4Qk83Ridt7fQeMCyhBJwep/pbsFhH4F+hOoqGs4Hjy/QC5o4yvU3KKpw6rFbR7GZft9+FZlwUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 90e8b9f6801c11f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7dee691f-853c-4c14-a751-72a2246c7f10,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e350770af9135fe67bfba6aa55e33a5c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 90e8b9f6801c11f1aa26b74ffac11d73-20260715
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1477231556; Wed, 15 Jul 2026 15:12:40 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH v3 0/2] bpf, riscv: add timed may_goto support
Date: Wed, 15 Jul 2026 07:12:24 +0000
Message-Id: <20260715-riscv-bpf-timed-may-goto-v3-0-cf2a9c3d843f@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANgyV2oC/x3MOQ6AIBBA0auYqZ0EF3C5irFAGHQKxYAxGuPdJ
 Zav+P+BSIEpQp89EOjkyH5LqPIMzKK3mZBtMpSiVKIpBAaO5sRpd3jwShZXfePsD4/CGpKq7lq
 pHaR8D+T4+tfD+L4fRffmMmoAAAA=
X-Change-ID: 20260710-riscv-bpf-timed-may-goto-0dce564985af
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Luke Nelson <luke.r.nels@gmail.com>, 
 Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

This series adds RISC-V JIT support for the timed may_goto loop bound.

Patch 1 implements arch_bpf_timed_may_goto() and enables
bpf_jit_supports_timed_may_goto() so the verifier uses the timed
expansion path.

Patch 2 enables the verifier_may_goto_1, stream_cond_break, and
may_goto_interaction fastcall tests on riscv64.

Tested on riscv64 QEMU (rva23s64): may_goto programs load and JIT
correctly, and the 250ms timeout path works as expected.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
Changes in v3:
- Set up the frame pointer in arch_bpf_timed_may_goto() so the function
  does not break stack unwinding under CONFIG_FRAME_POINTER.

Changes in v2:
- Fix BPF_REG_0 being clobbered after arch_bpf_timed_may_goto() calls.
- Enable the may_goto_interaction fastcall test on riscv64.

---
Feng Jiang (2):
      bpf, riscv: add support for timed may_goto
      selftests/bpf: enable timed may_goto tests for riscv64

 arch/riscv/net/Makefile                            |  2 +-
 arch/riscv/net/bpf_jit_comp64.c                    | 13 +++++-
 arch/riscv/net/bpf_timed_may_goto.S                | 47 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c         |  1 +
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |  1 +
 .../selftests/bpf/progs/verifier_may_goto_1.c      |  4 ++
 6 files changed, 66 insertions(+), 2 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260710-riscv-bpf-timed-may-goto-0dce564985af

Best regards,
-- 
Feng Jiang <jiangfeng@kylinos.cn>

