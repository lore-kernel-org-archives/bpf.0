Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FEA317148
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268617; cv=none; b=mqv/FfGL/Re5pu8UJSXCSRITTRjwikdlRykV2WlBQS2HC/2Fuxsw2Ezw0WkqHiJ5kM0UBNY1ky+wZUfkRTAbj9e/EsV4zV2hJrpufuSn+wtXJoRshsiFabcK3h8iDQ/EhCizjq7pLOABxZZlCR2r4qZzKOtUglvH3enO+TAmpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268617; c=relaxed/simple;
	bh=G+Edb+etHA6vMteKZHvf0hPBb/GjZQYa+pFwusga7g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giL8Sstr9kj+DHH0YhhSW6EG0oexzktrP2lZTZEgFNZVSuy8kMH62ddDcxxk2QmhjGUV5rXseNwlV6FTfze9lBxbna0iuoHa3ptpZjOGqCLoHHeQFUzcNYmL1q1db/qw+GfoZp32CnoxtN21fRaH40IYc6bzWbJpqJvESPxq3/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.82.142])
	by mtasvr (Coremail) with SMTP id _____wBHxu6rMMFpyiFIAA--.3947S3;
	Mon, 23 Mar 2026 20:23:07 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.162.82.142])
	by mail-app3 (Coremail) with SMTP id zS_KCgC3YHOrMMFpzSYOAA--.6829S2;
	Mon, 23 Mar 2026 20:23:07 +0800 (CST)
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
Subject: [PATCH bpf v3 3/3] bpf: Fix incorrect subprog ID in dumped bpf_pseudo_call instructions
Date: Mon, 23 Mar 2026 20:22:54 +0800
Message-ID: <20260323122254.98540-4-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
References: <20260323122254.98540-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgC3YHOrMMFpzSYOAA--.6829S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBg0TCmnARgsoSQAAsX
X-CM-DELIVERINFO: =?B?m8MsuQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9J7NtY8waPB0m8dxxxIcg0cp+zIIvmD0EMXTHDImflvEpDhGmp46ENGM8SPuc3wP8cAV
	bq8BGy5xoI+fDA2oVgO7yws3rHZMY/CJy8cTdK8kKUUqQoHgMFpf+GLSFynN3Q==
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyUurykKF4rZry3AryxWFX_yoW5CF4UpF
	4kWFyfGF1DJF42krnrAFWkuFW5Ka97Z3y7Wryru34fCw1jgFyDCr4jgF4rXFZ0kr1kAr1I
	vF4qva9I9w1DCFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jnJ5rUUUUU=

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
Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in dump")
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
index 809ac2325dcb..a45a393365b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23027,8 +23027,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
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

