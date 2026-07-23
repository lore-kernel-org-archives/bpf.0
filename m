Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63303AA9F4;
	Thu, 23 Jul 2026 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785310; cv=none; b=WDz4vMgrDRVKZuMIJhv84NSOPgwf4w88dCVWxta/GD61fBLQVB0OACwkdNmTOm6BS4PXqOecY0HySVq2u7XPNmje+okv6uQwnBKFObhmhQRBUWp+omAifDK+3rbOBCz/H05ISlRZX7Mb10oAsn6BmG+d0i7Yj1gqe9zUUHIepgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785310; c=relaxed/simple;
	bh=JDFRUOpgCgrr75HFKaJ0dlLre8qe9ANEfqNnZ9PYI/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=u694myCqVxvbfW3O957QyKfn8Fc4i4H8/fAqtiPLmYkTB/0kBdAXotpQjxaqJzSgB3dTkSOtC8pWYMlbMETXGKGnSvDxlQi7kB7CgJALWvXOBQ9stzixoFdGU7tdZGb5Hq/MNL7p1pLOQ5hLs6vbKKeMZKzVR2EY+nd24Pc9QMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2d649d58865911f1aa26b74ffac11d73-20260723
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:35998454-3bec-478b-b67b-efd9f61364b0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:98b40a018686caac7d3782104e19b5b8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d649d58865911f1aa26b74ffac11d73-20260723
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1242378994; Thu, 23 Jul 2026 13:41:39 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH bpf-next v5 0/3] bpf, riscv: add timed may_goto support
Date: Thu, 23 Jul 2026 05:41:31 +0000
Message-Id: <20260723-riscv-bpf-timed-may-goto-v5-0-86acb54e5642@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIupYWoC/33NTQ6CMBAF4KuQrh1TWn5deQ/jAsoUJmpLWtJAC
 He3Ehe60OXLm/fNyjw6Qs9OycocBvJkTQz5IWFqaEyPQF3MTHBR8DLl4MirAO2oYaIHdvBoFuj
 tZIF3CvMiq6u80SzOR4ea5p2+sNe9wXli19gM5Cfrlv1nkHv/5vPffJDAQWnR1Ep2VSb1+bbcy
 Vh/VGZXQ/YhCfFHyqKEaVpiIWXZqvJL2rbtCWK5ym4VAQAA
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
 Shuah Khan <shuah@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

This series adds RISC-V JIT support for the timed may_goto loop bound.

Patch 1 implements arch_bpf_timed_may_goto() and enables
bpf_jit_supports_timed_may_goto() so the verifier uses the timed
expansion path.

Patch 2 adds a test that checks R0-R5 are preserved across
arch_bpf_timed_may_goto() calls.

Patch 3 enables the verifier_may_goto_1, stream_cond_break, and
may_goto_interaction fastcall tests on riscv64.

Tested on riscv64 QEMU (rva23s64): may_goto programs load and JIT
correctly, and the 250ms timeout path works as expected.

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
Changes in v5:
- Use REG_S/REG_L/SZREG in arch_bpf_timed_may_goto assembly. (Pu Lehui)
- Add __arch_s390x to the timed_may_goto_preserves_regs test. (Pu Lehui)
- Switch the preserves-regs test to SEC("syscall") to fix
  bpf_prog_test_run() EINVAL.
- Link to v4: https://lore.kernel.org/r/20260722-riscv-bpf-timed-may-goto-v4-0-e117e6337bc7@kylinos.cn

Changes in v4:
- Add 'bpf-next' prefix to match the BPF kernel tree workflow.
- Add a test checking that R0-R5 are preserved across
  arch_bpf_timed_may_goto() calls. Use bpf_get_prandom_u32() to
  prevent the verifier from removing the checks via DCE.
- Rename may_goto_interaction_arm64() to may_goto_interaction().
- Wrap the arch_bpf_timed_may_goto address check to a single line.
- Link to v3: https://lore.kernel.org/r/20260715-riscv-bpf-timed-may-goto-v3-0-cf2a9c3d843f@kylinos.cn

Changes in v3:
- Set up the frame pointer in arch_bpf_timed_may_goto() so the function
  does not break stack unwinding under CONFIG_FRAME_POINTER.

Changes in v2:
- Fix BPF_REG_0 being clobbered after arch_bpf_timed_may_goto() calls.
- Enable the may_goto_interaction fastcall test on riscv64.

---
Feng Jiang (3):
      bpf, riscv: add support for timed may_goto
      selftests/bpf: test timed may_goto preserves R0-R5
      selftests/bpf: enable timed may_goto tests for riscv64

 arch/riscv/net/Makefile                            |  2 +-
 arch/riscv/net/bpf_jit_comp64.c                    | 12 ++++-
 arch/riscv/net/bpf_timed_may_goto.S                | 47 ++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c         |  1 +
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |  3 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c      | 62 ++++++++++++++++++++++
 6 files changed, 124 insertions(+), 3 deletions(-)
---
base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b
change-id: 20260710-riscv-bpf-timed-may-goto-0dce564985af

Best regards,
-- 
Feng Jiang <jiangfeng@kylinos.cn>

