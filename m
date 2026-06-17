Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E7347DD64;
	Wed, 17 Jun 2026 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709647; cv=none; b=MnrQ6TgFUxX+VnR5G+QIFlhF8gZXzvVv/PCrjC8LJA0dJLLHO7CvUFjT1DakVNYeEwozgWIZjbtC28LlYs2nsXpcmIfAKV1VOsnei7ZfFW66IAaVzgKLJPBzWbiUSrfXAQOVP4MBrqyx8OgVGu7T9uWy7OU8PRjzMvJPZTb8zFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709647; c=relaxed/simple;
	bh=xxSMyiyIWZCLNOXvVfnN2XjxhJMl38vibdmw8HH4SjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSoHiXAjKVwzi2H+y4ymj6nGi4wqWODAIQvdgV1DyV/gz3ncH6Q2dWtd1gSQ5dACkhcYvGhENCX0T2XPBQhz1jbBwCx5xHnANGP5tCN8+aJUd5eksse/VYIgiqlGlP41Ww5KYRMJZ0eJcLLfOO6bS3kSLzIdQKC1BszYZfrZHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=QEkB0HvG; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="QEkB0HvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=l9g4qUlwh8jYYn4wE6ky9fxMpRaXYWC
	3azIJs+136CQ=; b=QEkB0HvGYEuQU4u8FvXoHBiwoegdt5f0/6dFcy4gOptH+lt
	auZHZeoY/BejSBuWodqLgBnBtoQOxupY6Rb3JbphJF2bQkIKSl++hnSe60/Or5Kl
	c9vZmJ7DC6iyhXX3uWqmsDriWFej5hXoFCd4PLP7xl6TkCK+1Mhmznjf9+Fc=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcJg6uzJqVHJaAg--.59129S4;
	Wed, 17 Jun 2026 23:20:27 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Wed, 17 Jun 2026 23:20:21 +0800
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover half-slot cleanup of
 pointer spills
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-f01-06-half-slot-pointer-spill-v2-2-42b9cdc3cf64@mails.tsinghua.edu.cn>
References: <20260617-f01-06-half-slot-pointer-spill-v2-0-42b9cdc3cf64@mails.tsinghua.edu.cn>
In-Reply-To: <20260617-f01-06-half-slot-pointer-spill-v2-0-42b9cdc3cf64@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781709629; l=1537;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=xxSMyiyIWZCLNOXvVfnN2XjxhJMl38vibdmw8HH4SjA=;
 b=EYrlHREFgjcsY/FfWgWBJjWcWzI1i5uzhppx6DPEUeUoIf7KcrOQgACuClPmhA+qViivzcd+x
 qTyrgpovgXCBWoujtKKSANXRAnAgekQerFF+lhE7LRePH77na5/X3Au
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcJg6uzJqVHJaAg--.59129S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkJry7WFWfXF48AFy3XFb_yoW8Xw45pr
	97WasxtFZ5urn7C3W3AFWkGF1rKF1vqryF9F4SyFyUJF18tr1qqr4kKF4UJrsIkan5Xw4F
	vFySq3ZrWF1UJrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU4uc_DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgMBA2oytAoJJgACsI

Add a verifier regression test for a pointer spill whose high half is
cleaned dead while the low half remains live. Force checkpoint creation
with BPF_F_TEST_STATE_FREQ and assert the verifier log reaches the
checkpoint and the subsequent 32-bit fill before rejecting the partial fill
from a non-scalar spill.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/verifier_spill_fill.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 6bc721accbae..0174887e28f5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1359,4 +1359,22 @@ __naked void var_off_write_over_scalar_spill(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("partial fill from cleaned pointer spill")
+__failure
+__log_level(2)
+__msg("1: (05) goto pc+0")
+__msg("2: (61) r0 = *(u32 *)(r10 -4)")
+__msg("invalid size of register fill")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void partial_fill_from_cleaned_pointer_spill(void)
+{
+	/* Spill R1(ctx), then force a checkpoint and half-slot cleanup. */
+	asm volatile ("*(u64 *)(r10 - 8) = r1;"
+		      "goto +0;"
+		      "r0 = *(u32 *)(r10 - 4);"
+		      "exit;"
+		      ::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.34.1

