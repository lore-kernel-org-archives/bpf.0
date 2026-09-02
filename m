Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D65387361
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332784; cv=none; b=UmjQxEZgd7MUct8bb6k5EFg3ZGOFDsSYGEkuthEwmDOMUdNAEWauZqU0I8X7Y70y98Fy/OnwCPauyU8ypiRIsKn9yYP29AOsvpE4flGrGuQnzmVa3vRWS1tF3cOrslgsEVOo4xfhUS/ViT9428EjTdGyaCW+oqBdKxouHvocOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332784; c=relaxed/simple;
	bh=ZKvxQv8Dy4MXSstdioj2Pb4LY9XQIOeKpfuCkX5XOBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Byjel9QQYOwEqeGO32SEHtw4PmH+cXAxzs0XkABK9/GhLv7LP505fZvvupF79i7M5+VRLY7kRZ+Jg14do42IdhvglHZ/wLHlZ9Kp0d9gCFdkv9tFyyiFU+n6dTRXsg12Gk+0yG4uZpyBe/xfUca7N6OUEFA6Bi6SkOanzS6sVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.14.28.207])
	by mtasvr (Coremail) with SMTP id _____wAXATfgypdqIRXjAA--.34615S3;
	Wed, 02 Sep 2026 15:06:08 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.14.28.207])
	by mail-app2 (Coremail) with SMTP id zC_KCgBXxsvfypdqDB5IBA--.34975S2;
	Wed, 02 Sep 2026 15:06:08 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [RFC PATCH bpf-next 4/6] bpf: Refactor ALU instruction variant validation
Date: Wed,  2 Sep 2026 15:05:32 +0800
Message-ID: <20260902070534.2141812-5-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBXxsvfypdqDB5IBA--.34975S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhECCmqXKpkZ+wABs2
X-CM-DELIVERINFO: =?B?6iViJAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Kedt9TgU4vPvYZ+hKALaYei6kjAxywKXy2mgRVyZ/6VKo5q79r6PwJvrvlqUK+dnG1x
	GAsLMJ3aKeRqCSrE6kVhGtrtHt3WMOCN6IxxOX/enx1sasIU6ekvGgQcjfLYNg==
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3trWkWr4xtr13CF18tFc_yoW5GrW3pr
	1kKryrKF1kGr4Uury7JF4xZFy5GF4xWa17Wr95AayaqF47J3s8GryUtFyIqrWak34Ikw18
	tr4qva409w15CFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8aYLPUUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

check_alu_fields() currently validates insn->off together with the
source-specific reserved fields. This duplicates the DIV and MOD
variant rules between register and immediate forms and makes the valid
instruction variants difficult to identify.

Move the opcode-specific insn->off validation into is_valid_alu_variant().
The helper permits off == 1 for DIV and MOD and requires off == 0 for all
other ALU operations. Validate the variant once, then separately check the
reserved immediate field for register sources and src_reg for immediate sources.

This is a pure refactoring and does not change which instruction encodings
the verifier accepts.

Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
---
 kernel/bpf/verifier.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8f585ceb2cd5..92ab55ba349d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19108,6 +19108,18 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
 	return -EPROTO;
 }
 
+static bool is_valid_alu_variant(const struct bpf_insn *insn)
+{
+	switch (BPF_OP(insn->code)) {
+	case BPF_DIV:
+	case BPF_MOD:
+		/* off == 1 selects SDIV/SMOD. */
+		return insn->off == 0 || insn->off == 1;
+	default:
+		return insn->off == 0;
+	}
+}
+
 static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
 	u8 class = BPF_CLASS(insn->code);
@@ -19163,15 +19175,9 @@ static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	case BPF_MUL:
 	case BPF_DIV:
 	case BPF_MOD:
-		if (BPF_SRC(insn->code) == BPF_X) {
-			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
-			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
-				verbose(env, "BPF_ALU uses reserved fields\n");
-				return -EINVAL;
-			}
-		} else if (insn->src_reg != BPF_REG_0 ||
-			   (insn->off != 0 && insn->off != 1) ||
-			   (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
+		if (!is_valid_alu_variant(insn) ||
+		    (BPF_SRC(insn->code) == BPF_X && insn->imm != 0) ||
+		    (BPF_SRC(insn->code) == BPF_K && insn->src_reg != BPF_REG_0)) {
 			verbose(env, "BPF_ALU uses reserved fields\n");
 			return -EINVAL;
 		}
-- 
2.43.0

