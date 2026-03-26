Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9B935F612
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515739; cv=none; b=C34XyvZQFQokMwypO/jas8reQQ+6txSttCqvcjcHDQlWSYwDGDefj8N55l43Pr+2vzwBG/DFbGo8w6d1hhg621FxApDl7RPqj3kLUxzwkbS1gwPS2dpjcPx9TLv8it2rVlcMntnquR4qlIa0oBZWevlBzE78Tk6eoqS1HhqHqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515739; c=relaxed/simple;
	bh=c0z83z4lww4X51DBxlKQRWbHCZpsnDdW1PFQyu5fW0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpA1sgVyVoAg08WvZ9603J2U0hzHAo7/LHJOSjNXrY+qNOaoBLjUHI9RP6VeOWpI0/idH7d6+1XqgjAtziDmShKfVDK5R/uYNJ5GtvUA2lt5IgH37Vain5e2qklQ0dTisjOfRMfmZI1Tb6MruOMVvFECLfHcsj+ywKAtC/G0yW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.190.130.12])
	by mtasvr (Coremail) with SMTP id _____wDXKND59cRpC_MFAA--.11941S3;
	Thu, 26 Mar 2026 17:01:45 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.190.130.12])
	by mail-app1 (Coremail) with SMTP id yy_KCgAnmKH59cRpN7keAA--.4386S2;
	Thu, 26 Mar 2026 17:01:45 +0800 (CST)
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
Subject: [PATCH bpf v5 3/3] bpf: Fix incorrect subprog ID in dumped bpf_pseudo_call instructions
Date: Thu, 26 Mar 2026 17:01:33 +0800
Message-ID: <20260326090133.221957-4-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
References: <20260326090133.221957-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAnmKH59cRpN7keAA--.4386S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAggCCmnEOosmYAAAsY
X-CM-DELIVERINFO: =?B?D882FQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9LOcIldiP1c5d5Kcb9i58uWrvjPWE3IcrXV0zj122IwaQmq/UM5RGsvHJv/1dBi/y8WX
	9xnMoDyM1+Pgk6rI88QnD4bUENBMeWZbMZW5HqgzHyZ585SPgt4kBsPJyVZBjg==
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyUurykKF4rZry3ArWxZrc_yoW5XFWxpF
	4kWFySgFykGF12kwsrAF4kuay5Ka97Z347WFyrZ34fGw4jgFyDCr4jgr4FqFZIkrn7Jr1S
	vFsFva9I9w4UGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07je-eOUUUUU=

From: Yazhou Tang <tangyazhou518@outlook.com>

In jit_subprogs(), restoring bpf_pseudo_call instructions truncates
the 32-bit call_imm into the 16-bit insn->off. For large BPF programs
(e.g., call_imm > 32767), this silent truncation causes find_subprog()
to return an incorrect subprog ID, which is then stored in insn->imm.

Consequently, "bpftool prog dump xlated" reads the corrupted insn->imm,
fails to resolve the subprogram name, and incorrectly displays a raw
kernel pointer.

For example, dumping the xlated bytecode of the JIT-loaded selftest
introduced in patch 2/3 (call_imm == 32768, i.e., 0x00008000) shows
that it is truncated to 0x8000 and reinterpreted as -32768 in s16:

Before this patch (with call_imm > 32767):
   4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
   5: (85) call pc-32768#0xffffffff814aed4e

After this patch:
   4: (85) call pc+2#bpf_prog_71cfe20590be813a_padding_subprog
   5: (85) call pc-32768#bpf_prog_5dccd3f669bbe4e4_target_subprog

This patch fixes the issue by passing the un-truncated 32-bit
env->insn_aux_data[i].call_imm directly to find_subprog().

Note that the assignment to insn->off is retained. Although it still
truncates for large jumps, it remains correct for the vast majority
of BPF programs where the offset fits within s16 bounds. Keeping it
ensures backward compatibility for existing user-space tools that rely
on insn->off to display the relative offset. A comment is added to
explicitly clarify this truncation behavior.

Suggested-by: Puranjay Mohan <puranjay@kernel.org>
Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in dump")
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

