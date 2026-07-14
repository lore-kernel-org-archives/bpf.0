Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B94305662;
	Tue, 14 Jul 2026 02:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997942; cv=none; b=TLJI+S/TppCjHwEeNn3neru0DJuODpZJWCqIV3ardBKL7c0glO2JbfT+5nn58YtPRxULRFIs7/6wyr+SoHsPB2DlKDvGRsE+HyN/Js4GK9BYEd+YwYyF9cIWTPEjX63nKP6g8xB0KjT7b3cfHiqdzAD0FKpMZmjy144MbeS/LOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997942; c=relaxed/simple;
	bh=jib98B6Ovi85ynmf+T7fW79heLbdMYuH+Zw/xAvoANo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FJWn0EOGkNV+CPyRQwW5XzO/Wgr76Ap5toEif7NqvonclTvZcbOd3xxV9284UW7sG0cNxLBfsVWCJOS9LhKiqHtV8990ei6vql81VuR2YNMzxOsl0BKdhCIpI4ZLsVEpWM2aTK1F5ld1TnEInVfe+yg91UAnv3d14rNGL72WKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f2ddeec67f2f11f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:41d149a2-d77a-4b3d-b9be-6477aacff83a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:ceb06cec8d0d9343f9cfd983ff5c6e12,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f2ddeec67f2f11f1aa26b74ffac11d73-20260714
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1156635766; Tue, 14 Jul 2026 10:58:54 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH 0/2] bpf, riscv: add timed may_goto support
Date: Tue, 14 Jul 2026 10:58:47 +0800
Message-Id: <20260714-riscv-bpf-timed-may-goto-v1-0-3988601fe6ac@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOelVWoC/x3MTQqAIBBA4avErBvQ6P8q0cJ0rFmkoSFFdPek5
 bd474FIgSnCWDwQKHFk7zJkWYDelFsJ2WRDJapWdFJg4KgTLofFk3cyuKsbV396FEZT09ZD3yg
 LOT8CWb7+9TS/7weOM1R7agAAAA==
X-Change-ID: 20260710-riscv-bpf-timed-may-goto-0dce564985af
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
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

Patch 2 enables verifier_may_goto_1 and stream_cond_break on riscv64.

Tested on riscv64 QEMU (rva23s64): may_goto programs load and JIT
correctly, and the 250ms timeout path works as expected.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
Feng Jiang (2):
      bpf, riscv: add support for timed may_goto
      selftests/bpf: enable timed may_goto tests for riscv64

 arch/riscv/net/Makefile                            |  2 +-
 arch/riscv/net/bpf_jit_comp64.c                    |  5 +++
 arch/riscv/net/bpf_timed_may_goto.S                | 44 ++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c         |  1 +
 .../selftests/bpf/progs/verifier_may_goto_1.c      |  4 ++
 5 files changed, 55 insertions(+), 1 deletion(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260710-riscv-bpf-timed-may-goto-0dce564985af

Best regards,
-- 
Feng Jiang <jiangfeng@kylinos.cn>

