Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C77332EBB
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774506893; cv=none; b=aTxsFGBCHAKOSszsp7GbnPYp8iDZcE8DtVW24fAYkINHEcdYADNbUNCHY3UP55/sRI6sVPsKQgpB67CgdtqHARjNmfL6zSKBhK11uk3zsLDbb03QBhgoWtEOrrr/W9+T+75K4RkeBwPfIxGYMGh928N3/1MlEO7GoZmoNNyQoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774506893; c=relaxed/simple;
	bh=fr5PgxFVWVZhPZVN1RqqugnQ8DTuk76t+9mXi5G4DFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qajzZwsO1SgxdbNkOqL6NSzOlgDcTML5isK5uFWpNJERp3vTOepd6l2Q7WsHaTy+V0uyhnTAdIwTYLFj3mynQ5cWraFkm0rTyDVZIX/YfWubUt9JAbJNkQAi+Wd91PJ+bcUGt/yliFpiXhGRkfRF9KcQoNAdfVVTi5ynvmihId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [115.236.2.94])
	by mtasvr (Coremail) with SMTP id _____wAXUghr08RpbOEEAA--.9534S3;
	Thu, 26 Mar 2026 14:34:19 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [115.236.2.94])
	by mail-app2 (Coremail) with SMTP id zC_KCgDnmtJd08RpuHkqAA--.62372S2;
	Thu, 26 Mar 2026 14:34:09 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn,
	Puranjay Mohan <puranjay@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v4 3/3] bpf: Fix incorrect subprog ID in dumped bpf_pseudo_call instructions
Date: Thu, 26 Mar 2026 14:33:29 +0800
Message-ID: <20260326063329.10031-4-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326063329.10031-1-tangyazhou@zju.edu.cn>
References: <20260326063329.10031-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgDnmtJd08RpuHkqAA--.62372S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAg0CCmnEOosdWgABsd
X-CM-DELIVERINFO: =?B?5uxT8gXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9B7VUHZ/jH0WVNiQoVfoxX6vkrcZ41kXy9STt9Z9DwDMRZzVb1/iZbex7cxsrlg4NhFM
	fhnQy2LORpqRyRjr0u8HHINKggpHC91MKYyLtHtAlapxxLhnoOmTWWzwFlMDFw==
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyUurykKF4rZry3AryxWFX_yoW5Gr4DpF
	4vgFyfGFyDJF1j9rsrAFWDZFW5Kan7Z347WrWru34fGw4jqFyDGr4jgF1FqFZIkrn7Ar1I
	vFsFva9I9w4UGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUKsbUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
(e.g., offsets > 32767), this silent truncation causes find_subprog()
to return an incorrect subprog ID, which is then stored in insn->imm.

Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
fails to resolve the subprogram name, and incorrectly displays a raw
kernel pointer.

For example, dumping the xlated bytecode of the JIT-loaded selftest
introduced in patch 2/3 shows:

Before this patch (with call_imm > 32767):
  4: (85) call pc+2#bpf_prog_115951674716e036_padding_subprog
  5: (85) call pc+3395#0xffffffff814aed4e

After this patch:
  4: (85) call pc+2#bpf_prog_115951674716e036_padding_subprog
  5: (85) call pc+3395#bpf_prog_5dccd3f669bbe4e4_target_subprog

This patch fixes the issue by passing the un-truncated 32-bit
env->insn_aux_data[i].call_imm directly to find_subprog().

Note that the assignment to insn->off is retained. Although it still
truncates for large jumps, it remains correct for the vast majority
of BPF programs where the offset fits within s16 bounds. Keeping it
ensures backward compatibility for existing user-space tools that rely
on insn->off to display the relative offset. A comment is added to
explicitly clarify this truncation behavior.

Suggested-by: Puranjay Mohan <puranjay@kernel.org>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 702579f56f7d..e87fedb09e1b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23017,8 +23017,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		}
 		if (!bpf_pseudo_call(insn))
 			continue;
+		/*
+		 * Note: If the original insn->imm is out of s16 bounds,
+		 * insn->off here will be a truncated value.
+		 */
 		insn->off = env->insn_aux_data[i].call_imm;
-		subprog = find_subprog(env, i + insn->off + 1);
+		subprog = find_subprog(env, i + env->insn_aux_data[i].call_imm + 1);
 		insn->imm = subprog;
 	}
 
-- 
2.53.0

