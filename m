Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926C54A3407;
	Wed, 17 Jun 2026 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714768; cv=none; b=BlCf8UhpeH557Z6CR+dlHWRydPlWvIZptd9vCmmkzwsf+3LNf/7wMn+sEpinn/Qxw6d4Dc8v+GkPJWyZzMMLoG5wOotEDr9sQPy3TXEVm7ny1gdR2NY3KTKFxi+dBJqFtDXB2qT9MniPVP+I1ZRoZKLCPnAImD5LStDJILaMEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714768; c=relaxed/simple;
	bh=TxA/GMyfEtXid4vLtOA0LpW0bDr+lSoc4vKrJRDxEqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozilTplu3ZEpnSU3rhRj/W0UH4E7SZlxvQ+TwXERz4JtgbafO82LNYwfOAx+ZWgZndIwdsKp4YENVtGpVVL9YUuNZ0au0RtVnWVkqb3lIc2nyYC+1D3Kh7Stz1b2mLasmXB5dpyC+hs886wO7ddr4u2Tt01OFc4cPtUeRmYBzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=eAhcBPPb; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="eAhcBPPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=9375B2zXhMeSdvs5cw7DKAxe9sMAc8H
	BR76s1Wae8no=; b=eAhcBPPbpnAR5UpfQFHLej82g605inQqlTPajKVpMOoj/3g
	foUUPfu8SDk+TT/oYRwTYw++biGPwdAFTpRD1xhoMYtrELiCOprHbq+YrUCIl9Ay
	Qv/xOVlUTZ6VipfR/O3yfimKnOA1BOIAD6PMMdC1w/GPCZrZbnjKv9+yy1ss=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQA38cA1zzJqb498Ag--.43034S4;
	Thu, 18 Jun 2026 00:45:42 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Thu, 18 Jun 2026 00:45:44 +0800
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover stack nospec slot indexing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-f01-11-stack-nospec-slot-index-v2-2-ede9495359b6@mails.tsinghua.edu.cn>
References: <20260618-f01-11-stack-nospec-slot-index-v2-0-ede9495359b6@mails.tsinghua.edu.cn>
In-Reply-To: <20260618-f01-11-stack-nospec-slot-index-v2-0-ede9495359b6@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781714744; l=1452;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=TxA/GMyfEtXid4vLtOA0LpW0bDr+lSoc4vKrJRDxEqM=;
 b=UjO5G1XvFicCtli6iF1t5mXT4yGmYOSgGPbwweQAr0OwFoFVjQF1OxyBavHtAlI5SWCXdUWg8
 dX1QTOLiyCfD0nRw7U8p7g84HhK28h06FFDorSSs84q5NvlO6kT9vqE
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQA38cA1zzJqb498Ag--.43034S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWkAr4DKFy3Jry5Aw1fJFb_yoW8Xr4rpa
	4vgF9Ik347WF12gr1fAFW8GFyrJr4kXrWUCF4Sq345ZanxAr9aqFs7G347J3Z3AFs3ZFZ5
	ZF12vas8u3WkAFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1U
	M28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAac4AC62xK8x
	CEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1s
	IEY20_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x0Jjb_-PUUUUU=
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgEBA2oytAo7NwAAsr

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
index c16f8382cf17d..d54e5b59e62e5 100644
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
+__xlated_unpriv("*(u32 *)(r10 - 4) = r0")
+__xlated_unpriv("nospec")
+__xlated_unpriv("*(u32 *)(r10 - 8) = r0")
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

