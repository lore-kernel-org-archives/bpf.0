Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1283F6C48;
	Wed, 22 Jul 2026 04:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784694155; cv=none; b=eooVCIpEPuddi4Cby9QuHVO5e678Rnk+zSihqi1FJOoNqSO8WeVHIZv1UDQEgm4AZs7nBoPgRSDJsbQgOvE5UsjyZknU0lICh3g1WI2pyJhvNbckI7tCEyaWFGT3+NSm6Tc+pNOhUcJJpeYvQ672X1CV5y3tIXfCxMJ/C4oDVek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784694155; c=relaxed/simple;
	bh=9pZM91wH5qS3tTHuOBDW+FBaHdsgk4KRQRL6kw+qOeQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lzF7o1bN6bEx6BK+YFj6Mk4PZCdcGhviO2iFqCjUut7HtBPdgV8nbaYEZqWlzzRpzl8fSCVT7/B4/8/dqRAHedbctrLAE4rkXxQw9+QneZf+GFfY7VAJuDoA3if/FC53fFN8nZINB4Qs7iONFStj7obYKgAPxnPqroA3q44BLZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ed0af8d0858411f1aa26b74ffac11d73-20260722
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5d92c429-5465-4ab4-8a8b-8fa8adf55d60,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:38b6ac61c8f95797365616dffae84f27,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ed0af8d0858411f1aa26b74ffac11d73-20260722
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 222012023; Wed, 22 Jul 2026 12:22:18 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Subject: [PATCH bpf-next v4 0/3] bpf, riscv: add timed may_goto support
Date: Wed, 22 Jul 2026 04:21:24 +0000
Message-Id: <20260722-riscv-bpf-timed-may-goto-v4-0-e117e6337bc7@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAERFYGoC/3WNyw6CMBREf4XctddUCgiu/A/DovYBN0pL2qaBE
 P7dSty6nJyZMxsE7UkHuBUbeJ0okLM5VKcC5CjsoJFUzlCysmHXC0NPQSZ8zgYjTVrhJFYcXHT
 IlNR1U3VtLQzk+ey1oeVQP+Dbt3qJ0GcyUojOr8dn4gf/6ev/+sSRoTSl6CRXbcXN/bW+ybpwl
 hb6fd8/BKUuDMsAAAA=
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
 arch/riscv/net/bpf_timed_may_goto.S                | 47 +++++++++++++++++
 tools/testing/selftests/bpf/progs/stream.c         |  1 +
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    |  3 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c      | 61 ++++++++++++++++++++++
 6 files changed, 123 insertions(+), 3 deletions(-)
---
base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b
change-id: 20260710-riscv-bpf-timed-may-goto-0dce564985af

Best regards,
-- 
Feng Jiang <jiangfeng@kylinos.cn>

