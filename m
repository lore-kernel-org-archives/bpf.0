Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E672BE7BE;
	Mon, 20 Jul 2026 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784529804; cv=none; b=RCTtb6JHnI3Eudxtx27C7rVD19XcbYsluTAIuSG+richgjpn3JrQJbQkQFXlmrYYLfsctv1AIHbLv70GyCvKZQsrRqWSjMDClmmRqzndxiMewbq1Jp5zJP7Gj+pjce5GLktASgzBy8abDl+W7+ifNTBRUHduShjzFU4v29QfmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784529804; c=relaxed/simple;
	bh=niYlHRbNlv8yRWd3CzjQG9dh3E/BV+4DgB/4+Crceiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W8K7ZyVhKHWWT0kAEG47BLDukiwAYIpg3tkV6GqMGraKsKW63/KWvlGbgWjtdx9qqt3eFc66LoVTiugwEHZrLxY4kAMcg9JHE/PaN2CapVr9uQX8w/Z5/lBQXpYIACrzHu27kLpEnV6Ui5Pa7CyyhBFI+BTb6NKpWAlV7VPUTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 48264f24840611f1aa26b74ffac11d73-20260720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6ca9ffa6-c7ae-4817-81ff-9bf191c7c61c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:9fe386d20ed2bd4355799ee68e0faaa8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 48264f24840611f1aa26b74ffac11d73-20260720
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 384922734; Mon, 20 Jul 2026 14:43:14 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Mon, 20 Jul 2026 06:42:57 +0000
Subject: [PATCH v4] bpf, riscv: fix extable handling for arena load_acquire
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-bpf-riscv-fix-extable-v4-1-165c0b3b07d5@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAHDDXWoC/43N0Q6CIBSA4VdpXEeDAwp01Xu0LhAhWU4dOKZzv
 nvoVa21uvzP2fnOgqIN3kZ0Piwo2OSj77sc/HhAptHd3WJf50ZAoCSClrgaHA4+moSdn7CdRl2
 1FjOlFBdGCyFrlG+HYPN6d6+33I2PYx/m/U2i2/SXmCimWDsCzBgqtOOXx9z6ro8n06GNTPAXA
 5nhQJ0oJIWCsQ+GvTBAvjEsM1bpkjApgRH1xqzr+gSA4M6qSQEAAA==
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
Suggested-by: Pu Lehui <pulehui@huawei.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
Changes in v4:
- No code changes (pure v3 re-send).
- Restore Suggested-by for Pu Lehui (from v2, missed in v3).
- Restore Reviewed-by from Pu Lehui (v2)
- Link to v3: https://lore.kernel.org/r/20260720-bpf-riscv-fix-extable-v3-1-e9a603882309@kylinos.cn

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

