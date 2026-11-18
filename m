Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794989528;
	b=swUP14K2e01ea0u+QK0lj4B0XErxBEk9IbcI8Ny69Lj7Apyx3DA1AZwuxvRET1vpiEwv
	 JkWQzGX+hxFJWvzWrZkM1axbSi/YR3Re3fh9XwYgBuLP4m5WywwSPfcNmCsOGW9IBURET
	 NMHGXKFwhFwWQegN0hBvFl1T3MNRtOE0AgGWf6TQQUFG9zsJ1gtaTC9ei+SGIcBm7HQI7
	 z/JOMikyxi7YCkALxlx6r62waQp/wtL5XV6rpoNM/pXFZIzx35BoT7RYQxncazoINiwNF
	 mE1ZCS6yBd/OdlvCa9ZNCfGWIJ14RZ9isx4STI8scFxAgzFZkIkKZBA0KL0unzOX7AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794989528;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=vTPzdvuJQqBp5xH9v4iHahHPRW4Vz6i/Z2rINVyIBeg=;
	b=EGnQ2/p5qBK79fvV9sySpoobglDHkkbud+5xXTAxKKe8jZTtl0MfPKDjmTZhzvwVCwM/
	 ggZBisfg/YNIPpUBrKDiugLtjQ26smSgc+Oxn9Om2Dl3Fzec2WGj0tqXYyE+XEb1iIKrC
	 8wGvEo/Iz8V14uVOi5TGsdzF/EeGJtyuOsQlv1xwpohuMHz4fzkkEGQaASIknIIOEWhY8
	 xZEfsapyNfxMS907UYJbcyYgpAkzJslXV76c0PjVNmOkFEr93fZk5PVx9qUH3G6x5qeYT
	 LQWArSXDhBma4DTRwzh9vR1qU4CbX40/C1mqClQzFbQfCpujJ3MTxovehyjnOuV3xsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B51606A325;
	Wed, 18 Nov 2026 08:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B51606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxjdLTXf1qV8AgAA--.28504S3;
	Wed, 18 Nov 2026 16:12:03 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxX8_RXf1qZI41AA--.41807S2;
	Wed, 18 Nov 2026 16:12:02 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: BPF: Optimize doubleword loads with ld.d and ldptr.d
Date: Wed, 18 Nov 2026 16:12:01 +0800
Message-ID: <20261118081201.10498-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxX8_RXf1qZI41AA--.41807S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4kJr1xur1rKF4fKF4xZrc_yoW8WrW3pr
	n7Cr4Skr4rXr95XF1xJa97Wr1xKFsa9r13WF43KayrAwnxXFW3WF1fKanI9F15J39YgF1k
	XFySyFn0vFWDXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU24SoDUUUU

Currently, 64-bit doubleword loads (BPF_DW) unconditionally load the
offset into a temporary register with move_imm() and emit ldx.d.

Optimize these loads by emitting ld.d for signed 12-bit offsets and
ldptr.d for 4-byte aligned signed 16-bit offsets, or falling back to
move_imm() + ldx.d when necessary.

With this patch, only a single load instruction is emitted in most
cases.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
This is based on the patch:
LoongArch: BPF: Fix the offset of stptr.w and stptr.d stores
https://lore.kernel.org/loongarch/20261118071444.10258-1-dongtai.guo@linux.dev/T/#u

Note that BPF_W is left unchanged because LoongArch provides ldptr.w
(which sign-extends to 64 bits) but lacks an unsigned zero-extending
ldptr.wu instruction required by standard 32-bit BPF loads.

 arch/loongarch/net/bpf_jit.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 906f34f420f1..d36891db1179 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1352,8 +1352,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
 			}
 			break;
 		case BPF_DW:
-			move_imm(ctx, t1, off);
-			emit_insn(ctx, ldxd, dst, src, t1);
+			if (is_signed_imm12(off)) {
+				emit_insn(ctx, ldd, dst, src, off);
+			} else if (is_aligned_signed_imm16(off)) {
+				emit_insn(ctx, ldptrd, dst, src, off >> 2);
+			} else {
+				move_imm(ctx, t1, off);
+				emit_insn(ctx, ldxd, dst, src, t1);
+			}
 			break;
 		}
 
-- 
2.42.0

