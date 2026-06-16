Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927E7466B4B;
	Tue, 16 Jun 2026 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629095; cv=none; b=hyayCGNl5JK2KVAVvzlLF2sTEhE8PHO2t9pwXxw3pYq9+4hgqL0K0uI6Dn9qfq5vKtpegKbzKdDV7vsyN3LBLpdeyfBEgs6OSHZTL8kFprR0lucGfDgxHjzDZ5zMhuSteOSAfc0N19QQ/w+gIxZH3iVMuJ2qrhUYiJlnUrvDftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629095; c=relaxed/simple;
	bh=dJ/hGazGTwv12VEPOnHnWO3uZ09QCV7h0s9LI3Ox/Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWOndd7sAnbLa6iMFLu9Uo2Gp34GSnMsBnJdALC/X/GizOlS8pyjiorVa63jjHm+ndI3hMeP6rcMhrb+aVmgXsO9FOt8Mx24erDverWRdsEL/Zqa/LuCIJgFeg6RbNBSRW+eyUZJI7dZtTEoHpgMuBuTorPk1ZKJH8G4iGB2pCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=V09X0x1G; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="V09X0x1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=ifT9P6/eUKBe78AheIbgUae/qU2YB3D
	aI9+vCqxPBn8=; b=V09X0x1GOPFwGQzIVkYcZrnQbfXOm4k/VsNhHQJznd14CJA
	7s4BkypMRD3RHqDSEogw0zj8mlvCs/qU5d1Ykaeo16ot1ylWHCmvpamo7RCHWIpt
	sYKqsQPo8TPWlUuR6zXE2uoHB7GoPF5SWCoXat1MQL9wxxJaayrGhPT01KWs=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQBneJ2VgDFqKUxPAg--.57407S3;
	Wed, 17 Jun 2026 00:57:57 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Wed, 17 Jun 2026 00:57:55 +0800
Subject: [PATCH bpf 1/2] bpf: Fix stack slot index in nospec checks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-f01-11-stack-nospec-slot-index-v1-1-e3a080b0cd7e@mails.tsinghua.edu.cn>
References: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
In-Reply-To: <20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781629079; l=1483;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=dJ/hGazGTwv12VEPOnHnWO3uZ09QCV7h0s9LI3Ox/Qk=;
 b=UGZCHtDTQLmRGX3R1maDgcNfjlB3Jr05NV3jpRSnJaJTtATRzEg8ZqAAyPYUPNYSRsSktv3y8
 MkzsI7eEZR8D0rdD1JRpHutIwGTiWGt0qa1DPylju4edgN27piAaCXi
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQBneJ2VgDFqKUxPAg--.57407S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AF45tF1xAFykCw4kAw4rGrg_yoW8Xr45pr
	ykWFy2ganrKasrWFnFvF4v9ryrGa1kW3y7GFWjv34FvF1rX348WasYgFy5XFyFyFyrXw4S
	qF1FyrZIyw1Uu3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxV
	AIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv
	8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II
	8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl
	c2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU8TqcUUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEAA2oxeAYIdwAAsZ

check_stack_write_fixed_off() computes the byte slot for a fixed-offset
stack write as -off - 1, and records each written byte in slot_type[] with
(slot - i) % BPF_REG_SIZE.

The Spectre v4 sanitization pre-check uses slot_type[i] instead. For a
4-byte write at fp-8 after the lower half of fp-8 has been zeroed, the
pre-check scans bytes 0..3 and sees STACK_ZERO while the actual write updates
bytes 7..4. That can leave the second half-slot write without nospec_result
even though the bytes being overwritten still require sanitization.

Use the same slot index in the sanitization pre-check that the write path uses
when updating slot_type[].

Fixes: e4f4db47794c ("bpf: Fix pointer-leak due to insufficient speculative store bypass mitigation")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281c..50e80dbbc1784 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3479,7 +3479,8 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		bool sanitize = reg && is_spillable_regtype(reg->type);
 
 		for (i = 0; i < size; i++) {
-			u8 type = state->stack[spi].slot_type[i];
+			u8 type = state->stack[spi].slot_type[(slot - i) %
+							      BPF_REG_SIZE];
 
 			if (type != STACK_MISC && type != STACK_ZERO) {
 				sanitize = true;

-- 
2.34.1

