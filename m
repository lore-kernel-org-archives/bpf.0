Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4493750BE
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613198; cv=none; b=eAWGH10zncfNcvvb/K6EFVECy7a23KiHBXyYR6v7MtJg2J9Dt2q1zwSXnSxxFEpM6cP9uOXSAQTpLTfzRz2Ll+uum8qVQLk1TLvv6xtx1lL1LTeNtoP2B0p3ggmB5/w1kd97NYnS0C9iawOV1e8jIsFqalfe/vI/6HYTyRUgUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613198; c=relaxed/simple;
	bh=Tm7u+dOJNHVRkVJHahU3gR3l5xiY3Uzv4auF+AryfjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0Mb0UR8kTHDd7QizMl2P62VHCBrTmmM785WMcrDu8o5t78w1j0To7JkNrr/cTG/lif5tY98PpAUafOGoOWJzyBfztfQdisfC8d6D9QBO9nUXpl/AQhitFJXDhuIdBmq6731rcEBoojKQxYwcC67aGvmonlJfZSTs9J7Qm2K7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [122.224.66.117])
	by mtasvr (Coremail) with SMTP id _____wDHJ4Q17qdpKMwEAQ--.15965S3;
	Wed, 04 Mar 2026 16:32:53 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [122.224.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgAHWtUr7qdpF812Bg--.53379S2;
	Wed, 04 Mar 2026 16:32:43 +0800 (CST)
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
	glapt.pro@outlook.com
Subject: [PATCH bpf v2 1/2] bpf: Reset register ID for BPF_END value tracking
Date: Wed,  4 Mar 2026 16:32:27 +0800
Message-ID: <20260304083228.142016-2-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
References: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAHWtUr7qdpF812Bg--.53379S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgQACmmnOYkbZwACsI
X-CM-DELIVERINFO: =?B?JhBn2QXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9H+6e/0XdEnku/cOG5HghNjEnkgMZ/NA/a7Hl3tXmFz4dbXFwkI+uMy15W7Lfgn+u/iC
	jI8KIo1DIes26SNVfuz4X5cPk0UOWSpko9777E2eNHAw31CwlzJ9tjetZc8lZw==
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr4rCF4kAry5Kr13WrWDWrX_yoW8Krykpw
	4DGFy5tFWvgry2ka1xuF1xu34Yg3Z5X3yxWr4DA34SyF1UJF1Fkw1YgF1YqrWakrsag3yY
	vrnIvrZIva1UAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Hq2tUUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

When a register undergoes a BPF_END (byte swap) operation, its scalar
value is mutated in-place. If this register previously shared a scalar ID
with another register (e.g., after an `r1 = r0` assignment), this tie must
be broken.

Currently, the verifier misses resetting `dst_reg->id` to 0 for BPF_END.
Consequently, if a conditional jump checks the swapped register, the
verifier incorrectly propagates the learned bounds to the linked register,
leading to false confidence in the linked register's value and potentially
allowing out-of-bounds memory accesses.

Fix this by explicitly resetting `dst_reg->id` to 0 in the BPF_END case
to break the scalar tie, similar to how BPF_NEG handles it via
`__mark_reg_known`.

Fixes: 9d2119984224 ("bpf: Add bitwise tracking for BPF_END")
Closes: https://lore.kernel.org/bpf/AMBPR06MB108683CFEB1CB8D9E02FC95ECF17EA@AMBPR06MB10868.eurprd06.prod.outlook.com/
Link: https://lore.kernel.org/bpf/4be25f7442a52244d0dd1abb47bc6750e57984c9.camel@gmail.com/
Reported-by: Guillaume Laporte <glapt.pro@outlook.com>
Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 401d6c4960ec..dd6e51ad8201 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15886,6 +15886,13 @@ static void scalar_byte_swap(struct bpf_reg_state *dst_reg, struct bpf_insn *ins
 	/* Apply bswap if alu64 or switch between big-endian and little-endian machines */
 	bool need_bswap = alu64 || (to_le == is_big_endian);
 
+	/*
+	 * If the register is mutated, manually reset its scalar ID to break
+	 * any existing ties and avoid incorrect bounds propagation.
+	 */
+	if (need_bswap || insn->imm == 16 || insn->imm == 32)
+		dst_reg->id = 0;
+
 	if (need_bswap) {
 		if (insn->imm == 16)
 			dst_reg->var_off = tnum_bswap16(dst_reg->var_off);
-- 
2.53.0

