Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9F136EAA8
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253917; cv=none; b=mh1Fn4UZDluHpnZ0K/nvI51lvl57tUsl3AtJukE7X7ngDa82nSVfPQyD4yS+BJu4a8rEPJgpOlXkIyRXT7YizwJ3ny5TcBlRFKddGeJXsOM14LTcFdY9V2iYT74/EnlFoeOk1HMOL9KLcb0CJ1Um9IRLSU9KFW2WjWimidT6ONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253917; c=relaxed/simple;
	bh=HJmrEWvNBHs1vRgrk75ECdQkBwPvLawfTOuFSZph/FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Be9epl7d7YN0N0JU1MWgIaXrkZrY5mitjZKGy0kkrHxyXbq9/u7RtPGtRAzgcLEK4NGiKZoJkL7iLGXBLpkJ5WtYZZBQ0yo5F8d8GNuoeOrrsm8xyP0FlwBZVeO70egBiWPWKWs9WoI818zu8mwqhYPrsB7pHxUftxwV//gZQt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.82.142])
	by mtasvr (Coremail) with SMTP id _____wC3NfY598BpqM1GAA--.3664S3;
	Mon, 23 Mar 2026 16:18:01 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.82.142])
	by mail-app4 (Coremail) with SMTP id zi_KCgBXXDY598BpOUUMAA--.2271S2;
	Mon, 23 Mar 2026 16:18:01 +0800 (CST)
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
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH bpf v2 3/3] bpf: Fix incorrect subprog ID in dumped bpf_pseudo_call instructions
Date: Mon, 23 Mar 2026 16:17:48 +0800
Message-ID: <20260323081748.106603-4-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323081748.106603-1-tangyazhou@zju.edu.cn>
References: <20260323081748.106603-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgBXXDY598BpOUUMAA--.2271S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgMQCmm8UYsYPgAEsy
X-CM-DELIVERINFO: =?B?pYNJ0wXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9BZfZ83D7fDWWCSgyGjOU49iz6klcAEnLdmZXy/Q7uzV8cH9BSonCf1mMOTtWHf7MSc0
	7Ghr1hz97mqAEqFeNGDpri4ZuJL2KRVogm8wlDuyAO6lUN9aBZvkyMYJzmebtA==
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyUurykKF4rZry3AryxWFX_yoW5Aw1rpF
	4kWFyfGF1DJF42krnrAaykuFW5Ka97Z3y7Wryru34fCw4jgFyDGr4jgF1rZFZ0kr1kAr1I
	vF4qva9I9w1DCFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2db1UUUUU

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
---
Hi Puranjay,

As you mentioned in the last iteration, this still leaves insn->off wrong
but is generally fine. To clarify this for future readers, I have added
an inline comment explaining the truncation.

I also debated whether to add a warning log when the truncation actually occurs.
However, since the program will load and run perfectly fine after this fix,
I held off on adding it to avoid unnecessary log spam.

Do you think a warning log is worth adding here, or is the code comment sufficient?

 kernel/bpf/verifier.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 702579f56f7d..2178c3b2ef97 100644
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

