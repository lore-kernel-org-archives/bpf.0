Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.32.2.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792686554;
	b=U9m1+xDwugMc4qqgqXLKHJ6mo2tIyIxG9w+xQEZ6V0BuQEH12enOSdop9mHmtKf7vHt4
	 a1cRMq2c19uxjrdxPNUM+b7Q7u6jejXku8GZpNlkb5KBERUVM+TadyslY8DvGyanc3F8L
	 WvuhK6EyeNLsy53L5VGk4YuplZouW/ajfzV5dXqV/iiFs5UeDAM9dL7hF8gNCW+0qKyMQ
	 rv35fmYfAhgx4CB8xDxxuzgDEQUK4VSu3GUvYJy/qQMvQt3Ap0VDyoFu9H1Rw3Hpi6eEr
	 Fs0QhmdLg/R+yg4tJNMEQq1UPHygB8S0lA6h84WFfqtQL4m9FSbxlG1VIA2n1cpw7ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792686554;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-CM-DELIVERINFO:X-Coremail-Antispam;
	bh=NtSrsaakkEAIGEB2gQvOG9jbvdtBfnK9dR6g8YEjzZ0=;
	b=CTU8qGjTzX2SB1q/830oi9EGE0DxGDWsSGbTk2EX0oazGJjw0wYylus/Kd7XCcxYMTI8
	 z4hx3Z4H6VIoYQIV0XRgFdAOYSvSscAYfBhyMTWy9gq0a15MY8gJg8C04j96NFj14jLQR
	 ua9zggc2xpLy6+3FhWi8yB0pB/i1KAy7Vs16lMYvRgQYNKz8q08ZiIz/R3WiP8oDPYSO7
	 bCq6JlG87NDfyi5EIVz+/KJOquyZB6630//Q91aN7nBtZXu/Bj2nvF6zeS29LwdsXcFGp
	 DPrGU5T9mxN5KNH2Os0FjOKB2cqVxdruX68bLzr8LxLuwajVdgVD7/BtUBNXt6IDbpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=zju.edu.cn;
	spf=pass smtp.mailfrom=zju.edu.cn;
	arc=none smtp.remote-ip=210.32.2.4
Received: from zju.edu.cn (gw.zju.edu.cn [210.32.2.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CBC606A31A;
	Thu, 22 Oct 2026 16:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44CBC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.192.73.73])
	by mtasvr (Coremail) with SMTP id _____wCHIzzQOdpqWlK0AQ--.3597S3;
	Fri, 23 Oct 2026 00:29:04 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [10.192.73.73])
	by mail-app1 (Coremail) with UTF8SMTPA id yy_KCgAnOIXPOdpqKKOJAA--.46245S2;
	Fri, 23 Oct 2026 00:29:03 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
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
	Luke Nelson <luke.r.nels@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Yazhou Tang <tangyazhou518@outlook.com>,
	Tianci Cao <ziye@zju.edu.cn>,
	Shenghao Yuan <shenghaoyuan0928@163.com>
Subject: [PATCH bpf-next v3 5/7] bpf: Refactor ALU instruction variant validation
Date: Fri, 23 Oct 2026 00:28:45 +0800
Message-ID: <20261023-bpf-hmul-v3-5-b99e808cb28b@outlook.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
References: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
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
X-CM-TRANSID:yy_KCgAnOIXPOdpqKKOJAA--.46245S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgQMCmrZFZ1POgAAsK
X-CM-DELIVERINFO: =?B?HKTo7wXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9JatvK8BSGkLsRrdyfcL+iMVmyRBbrrmpgCsj79+fO3C1cG3+bOFAsJgQLz4MC2XN1Ge
	lw9XxDD7uwItX54c+IULcodS3tl8R0Tf7cgD8mPfUoGDd+5pL2wUSDNI1vp7eg==
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW3trWkWr4xtr13CF18tFc_yoW5GrW3pr
	1kKryrKF1kGr4Uur9rJrWxZFn8GF4xXa17Wr95Aay2qF47J3s8Gry5tFyIqrWak34Ikw1x
	tr4qva409w15CFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG0xvY0x
	0EwIxGrVCF72vEw4AK0wACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1vPfPUUUUU==

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

