Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.32.2.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571064;
	b=LzL6wPROp+Vy7vwnfA191BvkuLsIQDRcxLRy5PxbQre1db9AU+Q2IwKph0QwjsEX7DNj
	 TO3BK9h5CGighUVl1ydj2LUrklnemSUCLtYwKb9DHO0+6rZ7CmoaLY1FxRrIZgaw80vV6
	 1Uq56qarIHFkONCPAboC44/ulg0I/VD47hJa5kPVi2STB88NoYW5scWrg5Tj5sEZRXER4
	 THYHCclJ1cVfNfmd+sYiA59lQSwgtzgvoUtOlcrzB8AjV3Vp+6O8kgvbPzITgzlDVYyPA
	 8pkPZ5/SGmoq//dyLsCpiRqFrJzyH+AaFxrrC+9GUQV04ltR8pj8RRw132d50Dvowsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571064;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=NtSrsaakkEAIGEB2gQvOG9jbvdtBfnK9dR6g8YEjzZ0=;
	b=nOtaCUTwcVDy5oDFlRUgOrM8QcNRR79BLRRL3ryhRuQ2nzdkdJksl+2Z9XFa4C3dd2Vt
	 b90IFPfWAdnb4MLfhmaNsZri7F3dFBxM6FDPzeGBXqw7wtiRxXOa1wf5YePzh9rWMDqe5
	 ++Lt53Isu4MVrT5kaqoA5poIykpDnqPvXLHg2N2pZI4f8Dyq7rrg5gFCkt3ULN0pB9TbK
	 U2KA4l9bduGEfW13oHuyv95h6AnPJFdZBZf8C/YDLrIo7IU/p23a45jQe0igQ8AzMo8gy
	 OziPCs/1qUkmKopgbvdf5nw9kB/Y765sdM9ss2eTRjGI8ycUIicv5db98dAabYT70gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=210.32.2.4
Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D80606A321;
	Wed, 21 Oct 2026 08:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1D80606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wCnLzSkdthqR1CtAQ--.82S3;
	Wed, 21 Oct 2026 16:24:04 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgD3l6KjdthqFF21AA--.41144S2;
	Wed, 21 Oct 2026 16:24:03 +0800 (CST)
From: tangyazhou@zju.edu.cn
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	David Vernet <void@manifault.com>,
	bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	=?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Russell King <linux@armlinux.org.uk>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Wang YanQing <udknight@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Tianci Cao <ziye@zju.edu.cn>,
	Shenghao Yuan <shenghaoyuan0928@163.com>
Subject: [PATCH bpf-next v2 6/8] bpf: Refactor ALU instruction variant validation
Date: Wed, 21 Oct 2026 16:23:58 +0800
Message-ID: <20261021-bpf-hmul-v2-6-88e260099f7d@outlook.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
References: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgD3l6KjdthqFF21AA--.41144S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiAhILCmrXxB0pugAAsm
X-CM-DELIVERINFO: =?B?2V0buQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9Ks5WUqw3Z4rlIZd02nqEtft0MzfTq+s1QmQjSEdvTyQRalMSZtQuQPd1hkbAvlvYlWg
	6mzcp2KQy1GcuN/vxziY0QFgxtPKvJ2azCYMXYYrIqdIu0K+Kh20jDwP2BcX0g==
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3trWkWr4xtr13CF18tFc_yoW5GrW3pr
	1kKryrKF1kGr4Uur9rJrWxZFn8GF4xXa17Wr95Aay2qF47J3s8Gry5tFyIqrWak34Ikw1x
	tr4qva409w15CFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jeD73UUUUU=

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
index 5601d2056218..4f9d7b3de442 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21194,6 +21194,18 @@ static int fd_array_get_map_idx(struct bpf_verifier_env *env, u32 idx)
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
@@ -21249,15 +21261,9 @@ static int check_alu_fields(struct bpf_verifier_env *env, struct bpf_insn *insn)
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
2.56.0

