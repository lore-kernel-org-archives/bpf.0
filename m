Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1C3BBFBD
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618671; cv=none; b=LHotHa/Yw1IZ5sKxnGdBabFPv4e4NFUoqt31h3pQXB9FoifUmdML8n3pQ+4zjMioxVQasoIA16YyqWzmwevz/+z7j14iMBjsJRbRPtEYf9wK5+VJdNwBx/1UDtf5n5VAtFfwLYrHz1CuZvqL2anGrMCOJYh3sYrVC2qvB0j6qQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618671; c=relaxed/simple;
	bh=Mlo5NZ6M7ByF5HV9LxEVRl9594YxWkh5e04NQEpZbK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSPWK71k8/zVKGEx3/V7t5CgStXRstkdPurZKE225HE5RodJEhkfBDfTZ4Skw+ZwXLXwjupJA9ATuaiXaOEzO3ORNwV2jZKWbh6n1jMOUalOLL0I64oxZIJsKpedMDgTYXAo0i3IbIwn9Kzx60f7gPVsR9nuZ0LqDxugIF9iHmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wBHQD_ZaatqohMdAQ--.3748S3;
	Thu, 17 Sep 2026 12:17:29 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgA3OqTYaatqKeuJBA--.2236S2;
	Thu, 17 Sep 2026 12:17:29 +0800 (CST)
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
Subject: [PATCH bpf-next 6/8] bpf: Refactor ALU instruction variant validation
Date: Thu, 17 Sep 2026 12:17:10 +0800
Message-ID: <20260917041712.1860722-7-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
References: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgA3OqTYaatqKeuJBA--.2236S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgMRCmqq8RoVWgABs7
X-CM-DELIVERINFO: =?B?lK+XawXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9NuO7bmcOm6inyHA68dGwwRXVxgiCM9y2q6IR63W+T4mYgoSm13z4HuduOe47IDOlyAC
	gnVyKwjqgyo6YpBUhAkOmkr4cW4sY3CWHImpu/LjbmovbLxerHxy/QcLyXUXZg==
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3trWkWr4xtr13CF18tFc_yoW5GrW3pr
	1kKryrKF1kGr4Uur9rJF4xZF15GF4xXa17Wr95AayaqFsrt3s8Gry5tFyIqrWakryIkw1x
	tr4qva409w15CFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUTmhUUUUU=

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
index 6c6b8d8520cd..ed8742bf504f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19338,6 +19338,18 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
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
@@ -19393,15 +19405,9 @@ static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
2.55.0

