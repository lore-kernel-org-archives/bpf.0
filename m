Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912EF33AD9B;
	Tue, 16 Jun 2026 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629098; cv=none; b=LtgtnbgPC5Xg74oSzjocHWXy+RsnvZhMMgJMZqYvB0/WNF6eLO5J3XtL4V0gZUzXpiCiScQ0njMDHKwccpd6phtCz8rd6rqsUR3olDw4Z3G9cBK3UAwD6U5ES231z+fhTcK5FVfLry0qHHo5Xq01Md7yAT2fu/1JClArKSmKEvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629098; c=relaxed/simple;
	bh=+dNQk66iZLl1hXIly5cn5vELYpkbJBzGkEzSPgeFOKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gu1X4URHs+TgyIxyztYNroOmpE1HHK68Ez0gYPhEBidZEFuNS8WFaR74cIkuRp95wPwtME8f5JyqUxE6lz0YtMmKEVVYkiVGhxYk+QSh23usTAa8pku5ye9cwkWPE/tgailt6NbIpmbUKUFqVfRVjr8nLJtkB37Q25jKIvQatsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=Ey1fmg9T; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="Ey1fmg9T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=snvsb6VD95Gi4ytz6Pwvl4jwEfiPU7m
	qT610BL69bbY=; b=Ey1fmg9T94NX2CRmEhEQXgHzlAarrsepezN8rU4c/psEyUt
	6Re4rdCKEosoZNFEDtxZwgfnUwpM2fyqM4qzxYvuSYh3KEWcsvwoUAiF5oESpdkm
	xP5oAavfdRVTv5X3u7rEEKfw5VXppG8EB1hByzCDMPIeaDkwr4Bhvr8mN70o=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQBneJ2VgDFqKUxPAg--.57407S4;
	Wed, 17 Jun 2026 00:57:57 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Wed, 17 Jun 2026 00:57:56 +0800
Subject: [PATCH bpf 2/2] selftests/bpf: Cover stack nospec slot indexing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-f01-11-stack-nospec-slot-index-v1-2-e3a080b0cd7e@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781629079; l=1480;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=+dNQk66iZLl1hXIly5cn5vELYpkbJBzGkEzSPgeFOKA=;
 b=NilFRY5Hs82Ps02tipPyYNLT773zSFAond0IwdaH4T/CC1usbtNdR+1kTN1QbTZve54efdzwE
 9m8LbBzfA41BLBopzRl/R3z7mKQAGGH+sto0/mUECObO7NxgI82cH36
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQBneJ2VgDFqKUxPAg--.57407S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkAr4UKryDXw1xtw1DJrb_yoW8XrWDpa
	4vgF9I9347WF12gw1fAFW8GFyrJr4kXrWUGF1fZw15AanxAr9Iqrs7K347J3Z3AFs3ZFZY
	vF12vas8u3WkAa7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU8TqcUUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEAA2oxeAYIeAABsX

Add a verifier test for the fixed-offset stack write case where two 4-byte
stores initialize opposite halves of the same stack slot.

The test uses the CAP_BPF-without-CAP_PERFMON loader lane so Spectre v4
mitigation remains active. It expects both half-slot writes to emit nospec
in the translated program.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index c16f8382cf17d..9ebbd4b531df1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -976,4 +976,27 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("noperfmon: Spectre v4 stack write slot index")
+__success __success_unpriv
+__caps_unpriv(CAP_BPF)
+__retval(0)
+#ifdef SPEC_V4
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("*(u32 *)(r10 -4) = r0")
+__xlated_unpriv("nospec")
+__xlated_unpriv("*(u32 *)(r10 -8) = r0")
+__xlated_unpriv("nospec")
+__xlated_unpriv("exit")
+#endif
+__naked void stack_write_nospec_slot_index(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	*(u32 *)(r10 - 4) = r0;			\
+	*(u32 *)(r10 - 8) = r0;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.34.1

