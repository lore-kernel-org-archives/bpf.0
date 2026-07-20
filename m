Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE738D407;
	Mon, 20 Jul 2026 06:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784527632; cv=none; b=CdwBcl90qel0n1uuMl4s8AviBhr8ofGBjOS1RiQN6zMIWgWpmL212dP+NcKmVQp+4mANEoOrBkBVDz1gS90/NOLG4J7KaMi+sLLX3CY9wSkFfKRhj981OEmLp+nq2c1nyKcFO5DGrOm7xTiq0WqsBHLdu2XUljZRNZ6UHWup10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784527632; c=relaxed/simple;
	bh=eOwmlZ1UyDz81nOWtr8J2+1ZOpVqGayHW56BZOT1OeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DQyQ1lLJQTjayMJB+LkHbujQh8kXyxYCzo043VmOJyie0HQTah1enZ1PyjWhbY7xr09dPzVInnBuvyI+CKDMahsjHA1dixJbl5z8V8gerHdiNNfZhRF1R/JXz727x6WkwhDyXCSuF84HZQtEsUNfhyIinj5R9qvQBLp82Ia1jNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 351a3dfa840111f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1983e0ea-c205-4455-881b-787d9203bef5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b417510f9b1d076d7875eb3920a67876,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 351a3dfa840111f1aa26b74ffac11d73-20260720
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 893897423; Mon, 20 Jul 2026 14:06:54 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Mon, 20 Jul 2026 06:06:49 +0000
Subject: [PATCH v3] bpf, riscv: fix extable handling for arena load_acquire
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-bpf-riscv-fix-extable-v3-1-e9a603882309@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAPm6XWoC/43NwQ6DIAyA4VcxnNfFgorutPdYdkCE2cygAUM0x
 ncfettpO/5t+nVjwXgygd2yjXkTKdDoUohLxnSv3MsAdakZz3mVS6ygnSx4CjqCpQXMMqt2MCC
 apimkVlLWHUu3kzdpfbqPZ+qewjz69XwT8Zj+EiMCgrI5F1qjVLa4v9eB3Biu2rGDjPwvhiem4
 GhlWSMvhfhi9n3/AKnhEwsCAQAA
X-Change-ID: 20260716-bpf-riscv-fix-extable-399947ca778d
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

emit_atomic_ld_st() returns 1 to have build_body() skip the zext after
a sub-word load_acquire. The caller does "ret = ret ?:
add_exception_handler(...)", which skips add_exception_handler() on any
non-zero ret, so the extable entry is missing and a faulting
PROBE_ATOMIC load_acquire oopses.

REG_DONT_CLEAR_MARKER leaves rd stale on fault, and the verifier still
thinks the load overwrote it, so a program can leak it through a map.

Check ret >= 0 before calling add_exception_handler(), and pass rd for
LOAD_ACQ so the fault zeroes rd like a PROBE_MEM load. Return ret
unchanged for the zext skip.

Fixes: fb7cefabae81 ("riscv, bpf: Add support arena atomics for RV64")
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
Changes in v3:
- Pass rd to add_exception_handler() for LOAD_ACQ so the destination is
  zeroed on fault instead of REG_DONT_CLEAR_MARKER (Björn Töpel).
- Link to v2: https://lore.kernel.org/r/20260716-bpf-riscv-fix-extable-v2-1-421f75812533@kylinos.cn

Changes in v2:
- Drop extra variable as suggested by Pu Lehui.
- Link to v1: https://lore.kernel.org/r/20260716-bpf-riscv-fix-extable-v1-1-af023cc17af4@kylinos.cn
---
 arch/riscv/net/bpf_jit_comp64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index f9d5347ba966..e1519ab4356c 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1986,7 +1986,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		else
 			ret = emit_atomic_rmw(rd, rs, insn, ctx);
 
-		ret = ret ?: add_exception_handler(insn, REG_DONT_CLEAR_MARKER, ctx);
+		/* ret can be 1 (skip-zext); extable entry still needs to be added */
+		if (ret >= 0)
+			ret = add_exception_handler(insn,
+				insn->imm == BPF_LOAD_ACQ ? rd : REG_DONT_CLEAR_MARKER,
+				ctx) ?: ret;
+
 		if (ret)
 			return ret;
 		break;

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260716-bpf-riscv-fix-extable-399947ca778d

Best regards,
-- 
Feng Jiang <jiangfeng@kylinos.cn>

