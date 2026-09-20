Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202728C2BF
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.38.64.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938280; cv=none; b=nT7zLGO0KdjfbHK3oz+sV/8GcrAoF7Ai0rtwRzLQ4wl2RVdWhFjq6qQHlkK1xyrNN0hk1DbHAtJ2QxuyWLMcBrP2ezf3cqrbGxPwL/843Koz6xKdltcaRb8m92icR3EpW3tvR1e5KeMOvwX9PZCfXj+cVg6WsWpT1AagbDLIjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938280; c=relaxed/simple;
	bh=MnbZilKnyopiDbolSFZk0/qywszkNsVB0/7QwLp+XPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMOaCyrgsrOzMJTrprBeB426RDgvfedDYID0hYvElU1Pinz97FQOFShfE+63WaUlixL0sVw6l1VAc2UPTjW/9aOzA4zc/txKKS2KW7P2PLErcMKIf8gFDgG8wFyuJBmU00Urn/pBkIkHzzOi4Zb1Xj1Ig9o0T+/zdMFv4sbWQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn; spf=pass smtp.mailfrom=mail.ustc.edu.cn; dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b=DRv4QP63; arc=none smtp.client-ip=202.38.64.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="DRv4QP63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=BH2Dt0fHDHrsJeahc40zO/GDCpD81PuLMq
	GcBG1T3TI=; b=DRv4QP633t3XV+D3IUueFRah0xpk9h18KLSNMXWqg/mskiTK6Y
	UnXojaWQxts5gw8pQjLdsEcauwYmvSYRmuaJsX7wp+w0BOYcaPuJ3vsSnxLX9i7V
	KqWdJtgghbvscCQfykYujTQwu0dgg5O/xIXJzZ8Hor18KvJ+2WVhh/fLo=
Received: from localhost (unknown [222.195.81.68])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgCXly5cSrBq3TBAAQ--.2595S2;
	Mon, 21 Sep 2026 05:04:28 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	sun.jian.kdev@gmail.com
Subject: [PATCH bpf v2 1/2] bpf: Reject non-negative offsets in stack_slot_obj_get_spi()
Date: Mon, 21 Sep 2026 05:04:21 +0800
Message-ID: <20260920210423.345636-2-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920210423.345636-1-xyx2021@mail.ustc.edu.cn>
References: <20260920210423.345636-1-xyx2021@mail.ustc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgCXly5cSrBq3TBAAQ--.2595S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr48XrWrZw45JF1UWw47XFb_yoW8XrW8pF
	sagFy7tFyvvF1j9FnFvanruFyUC3WDGw47CFZ0y3yfAr1xtF1DXa4UKFWYqa4ayFW8Zw1F
	vF109wsFqayUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_Jr
	ylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_CwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07j7J5rUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

bpf_get_spi() computes (-off - 1) / BPF_REG_SIZE using C division,
which truncates toward zero. For off == 0, this produces spi 0, the
same index used by the valid stack slot at fp-8.

stack_slot_obj_get_spi() currently checks alignment and the resulting
spi bounds, but does not reject the non-negative offset itself. It can
therefore validate a PTR_TO_STACK register holding fp+0 against an
iterator stored at fp-8 even though the runtime receives the actual fp+0
pointer. An effectful iterator kfunc can then interpret memory outside
the BPF stack as iterator state.

Reject non-negative offsets before converting the offset to an spi. All
valid stack objects begin at a negative offset from the frame pointer.

Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Assisted-by: LLM
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 02be326f235c1..dd8bb179d39eb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -567,7 +567,7 @@ static int stack_slot_obj_get_spi(struct bpf_verifier_env *env, struct bpf_reg_s
 	}
 
 	off = reg->var_off.value;
-	if (off % BPF_REG_SIZE) {
+	if (off >= 0 || off % BPF_REG_SIZE) {
 		verbose(env, "cannot pass in %s at an offset=%d\n", obj_kind, off);
 		return -EINVAL;
 	}
-- 
2.43.0

