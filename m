Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEF0375F83;
	Wed, 17 Jun 2026 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718649; cv=none; b=Uf9ZgwQfkeRuOACM83J7s2+7v4QlKQHcT+qyUTdQBBSW4k/fUYe0B8pVySj41kAbDsK8+lLl+Wo5BFGN2ozrn5ro+NpFfWoODzL2MSFQTcizsIDiHXHYqD1hYDH6Qi5ePadeB+/KnBeTEx8AA9rFiHCsmwLB1Bude+shMEZ9H4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718649; c=relaxed/simple;
	bh=YGCkL4+VwLbmw+P8YhfzOBV2MLQFbWpu25t0MVr1DQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dM+JN4D29N/L5k5dL/zOm8r/00QkCdHzkbYF9RpRd9ijceLJUH7Q+f2/d4VPmZlKTlKOZ0npcxAG26lg2f68l6YULQgwkR8RMnn7JHE8pAJ1lZekSxdo+SpI+X3WnVOqXUO/7FnGOPF5415S+kHEHqcwG+wJ5NnkZs6Ls3d2pCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=OI8EoXWf; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="OI8EoXWf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=SkphgGfBm++rhgPZmW4mvpglQY8Z6wk
	2YsauD2JMrts=; b=OI8EoXWfxr7zIXR7NuSiPVr7jjX2cRttYZmUiByJBJwvyX2
	ycQtJwY2X742q1bG9GbXdxXrPXajtXvpZS38aGmsNpW1xSBcHgooLaYI/sc52f3W
	66B/++upJBTUrPAxxMeZ6se/M83pbzy3tEzqQllJVQBfxPxuXjlhzfHTOp4c=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQAH5Jtk3jJq2CFbAg--.21290S4;
	Thu, 18 Jun 2026 01:50:29 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Thu, 18 Jun 2026 01:50:27 +0800
Subject: [PATCH bpf v3 2/2] selftests/bpf: Cover stack nospec slot indexing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-f01-11-stack-nospec-slot-index-v3-2-780297041721@mails.tsinghua.edu.cn>
References: <20260618-f01-11-stack-nospec-slot-index-v3-0-780297041721@mails.tsinghua.edu.cn>
In-Reply-To: <20260618-f01-11-stack-nospec-slot-index-v3-0-780297041721@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781718629; l=1450;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=YGCkL4+VwLbmw+P8YhfzOBV2MLQFbWpu25t0MVr1DQs=;
 b=S05KVCQ8aZgkNnd8hsCO3pk/WURTInr/OhgDzXgsbgx1abyS0NNIQCfk/8dzEXFz7dPfs5f6A
 obypI1gdsdsA93auTu/cZMWsDs/cWnQYXpB2x0CMXUnt2QNjXuhquhs
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQAH5Jtk3jJq2CFbAg--.21290S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkAr4DKFy3Jry5Aw1fJFb_yoW8Xr4rpa
	4vgF9IkwnrWF12gr1fAFW8GFWrJr4kXrWUCF4Sq345ZanxAr9aqFs7G347JFn3AFs3Zrs5
	ZF12vas8u3WkAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxV
	AIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv
	8VW8Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II
	8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl
	c2xSY4AK67AK6r4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU8G9aPUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgYBA2oytApKsQADsY

Add a verifier test for the fixed-offset stack write case where two 4-byte
stores initialize opposite halves of the same stack slot.

The test runs through the unprivileged loader lane and expects both
half-slot writes to emit nospec in the translated program.

Acked-by: Luis Gerhorst <luis.gerhorst@fau.de>
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index c16f8382cf17d..49f7bd05edad2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -976,4 +976,26 @@ l0_%=:	exit;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("unpriv: Spectre v4 stack write slot index")
+__success __success_unpriv
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
+	r0 = 0;					\
+	*(u32 *)(r10 - 4) = r0;			\
+	*(u32 *)(r10 - 8) = r0;			\
+	exit;					\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.34.1

