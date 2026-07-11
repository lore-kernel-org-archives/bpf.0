Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4EC36F8EF;
	Sat, 11 Jul 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783764610; cv=none; b=sgmdMVJqbV8DoFSFd2O2Qyna77K+Q6jLWMUKBXA9mhMrkvhDRVo8koYIe44KGs7/MTyM23bMsz3osXLHI1e9kUEa2Ocmxk/LohyCgBOwqUGfK8tpvyQcJ8eQycfnJVvcxfRcf1zwRSBRP5ze8hp0MVhMHprBvAXEh766+xqurls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783764610; c=relaxed/simple;
	bh=MyhEhYBX009NdzGxQS0HNuJYbW1EujhK0vFA1zjV7ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNKbpF5Sow3jcWwVmn1XwYk0LVrrG0Py1b549VoWPBWEpPcgwugfNSjRF5ocrK6HHQLoHmid1RXWy3o7GQnjeY4kEOy9GDBwqk91apG7CTcWigAIdsb26lh7/4mZcg1K7NtHjY5fZ9YEWULl7OZy8ndcbsvxMy8A0eRNBPEUy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxRep3FlJqzpgCAA--.9386S3;
	Sat, 11 Jul 2026 18:09:59 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxTOV1FlJqVnAJAA--.36096S4;
	Sat, 11 Jul 2026 18:09:59 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] LoongArch: BPF: Remove dead move_imm() call in BPF_NEG path
Date: Sat, 11 Jul 2026 18:09:55 +0800
Message-ID: <20260711100956.4351-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260711100956.4351-1-yangtiezhu@loongson.cn>
References: <20260711100956.4351-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOV1FlJqVnAJAA--.36096S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GF47WFW5XryDAF1fGw17Arc_yoWDZFX_Gr
	yxK3y8Ww4Fqry3A3Wjg3Z5CF12ka4xGF1FvF909F4xKas0qF43ZrWvyFyav342grWUJw45
	Z397J3s3Ar1avosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

The BPF_NEG operation is a unary operator that performs `dst = -dst`.
The current code unconditionally executes a move_imm() call before the
subtraction, generating useless JITted instructions to load data into
the temporary register `t1`. This `t1` register is never used anywhere
else in the entire BPF_NEG path.

Remove this dead `move_imm()` call to avoid useless instructions.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 2738b4db1165..5f32b205a6ac 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -894,7 +894,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 	/* dst = -dst */
 	case BPF_ALU | BPF_NEG:
 	case BPF_ALU64 | BPF_NEG:
-		move_imm(ctx, t1, imm, is32);
 		emit_insn(ctx, subd, dst, LOONGARCH_GPR_ZERO, dst);
 		emit_zext_32(ctx, dst, is32);
 		break;
-- 
2.42.0

