Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802B3348457;
	Tue, 10 Mar 2026 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125127; cv=none; b=SRLiAMJ3grFFjMusE7+4fRbDXiFX5fvNS366Y5kPvgDoYVzdHRSHbaZPKnUV11OfuIMKj+JsFtv5yMb6WE5I+hQI45uox4L+MJzijgUsbGxod5+OV6oJutrh2kBomAcf2qY4d508j3KK5tkUpos3lcFdKeK1VbuQZrJoB/url+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125127; c=relaxed/simple;
	bh=0aVAiHmBG3wfAE5Zdb0lJbmJG9vphW+wFTv0ZFo9fDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyeSiAVPxMC0t693/JubRsddeVh+KUyqXxmmG8Uollpk75TS+xnhCXnbn089o6J2THTR95jnOCs8SarUwCUxcBdhYW2NdpGQ+G4Vh8iuWB/LP7APeHzEh8AGHzSj2ay0Jvk3mrw8VsDjaRTeuhITO8Mn1hMGW8iJzXbrUWM6ACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxPMP+va9plGoZAA--.9076S3;
	Tue, 10 Mar 2026 14:45:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxOMHzva9p8edRAA--.11000S4;
	Tue, 10 Mar 2026 14:45:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add alignment flag for test_verifier 190 testcase
Date: Tue, 10 Mar 2026 14:45:07 +0800
Message-ID: <20260310064507.4228-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260310064507.4228-1-yangtiezhu@loongson.cn>
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxOMHzva9p8edRAA--.11000S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1fCF4rXFyUJw4DuFW3Jwc_yoW8Xry3p3
	WrAayqkF92qF1xCFy7AanxWFWrWFZYqay3CF1jkry5Zw18C3srJrWIgF1UJr9Ig395Jw4S
	y3s3ta12v3WkXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUFc_-DUUUU

There exists failure when executing the testcase "./test_verifier 190" if
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set on LoongArch.

  #190/p calls: two calls that return map_value with incorrect bool check FAIL
  ...
  misaligned access off (0x0; 0xffffffffffffffff)+0 size 8
  ...
  Summary: 0 PASSED, 0 SKIPPED, 1 FAILED

It means that the program has unaligned accesses, but the kernel sets
CONFIG_ARCH_STRICT_ALIGN by default to enable -mstrict-align to prevent
unaligned accesses, so add a flag F_NEEDS_EFFICIENT_UNALIGNED_ACCESS
into the testcase to avoid the failure.

This is somehow similar with the commit ce1f289f541e ("selftests/bpf:
Add F_NEEDS_EFFICIENT_UNALIGNED_ACCESS to some tests").

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/verifier/calls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 86887130a0ef..29e57f0e56c3 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1521,6 +1521,7 @@
 	.errstr = "R0 invalid mem access 'scalar'",
 	.result_unpriv = REJECT,
 	.errstr_unpriv = "invalid read from stack R7 off=-16 size=8",
+	.flags = F_NEEDS_EFFICIENT_UNALIGNED_ACCESS,
 },
 {
 	"calls: two calls that receive map_value via arg=ptr_stack_of_caller. test1",
-- 
2.42.0

