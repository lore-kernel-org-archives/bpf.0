Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7A034B18E;
	Tue, 10 Mar 2026 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125129; cv=none; b=UX1FFEddXY+gt6AhUi+t6cs7BZiFJcTo7Uy0ffOf7QBwPhzS0lz5IBJZI7hnikS84cbJOPXAAwjiM4TL5pwfT0VXyfrih4sTiXyYhlYPDQ3tgsM/paYjm9H+iUiUz0UvjXMdVUXrX/vwK/pOlMcnRLMMlh/ZcO9Ztae5SjPtWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125129; c=relaxed/simple;
	bh=L7yUsAXBQukTf4riI0ud3QV9+JjBI45f38a8XFQUDY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkKNJqwTAIZRpNaYHifEu1TKZ6sJjePLKm8XpeSNWErgTA8nN/sHQysoBb9vcMFJJDiwjXuN8umQJWPA1D8GVhVarcPy7nUqOuRDIwP1b7wJbKs+kUsmVUGeW5mE+qnqDVkdOXEye/1GowLFuSRBXPi2eDPGqtQBZESYcT5YHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxAfEEvq9pl2oZAA--.9392S3;
	Tue, 10 Mar 2026 14:45:24 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxOMHzva9p8edRAA--.11000S3;
	Tue, 10 Mar 2026 14:45:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 1/2] selftests/bpf: Check alignment flag if expected result is REJECT
Date: Tue, 10 Mar 2026 14:45:06 +0800
Message-ID: <20260310064507.4228-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJCxOMHzva9p8edRAA--.11000S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4DAry7tryrZFW8AFyDCFX_yoW8Wry3pa
	yxtFyq9F4ktF17Gry7C3yDuFW0qr1vqry3ZF10y34UJFn5Aryxtry0gFy8XF9IgFWFqa1S
	v34S9w1Y9F13XagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
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
	Ja73UjIFyTuYvjxU4AhLUUUUU

CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set unconditionally for the
most archs such as x86_64, aarch64, ppc64el and s390x, but this config
may be not set by users for riscv64 and loongarch64.

If CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set, the BPF verifier
detects if a program has unaligned access and then rejects them. So it
should also check the flag F_NEEDS_EFFICIENT_UNALIGNED_ACCESS if the
expected result is REJECT and set alignment_prevented_execution as 1,
then the message "(NOTE: not executed due to unknown alignment)" can
be printed for some testcases of test_verifier to reflect the reality.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/test_verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a8ae03c57bba..a1ae2f044e96 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1640,6 +1640,11 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 			printf("FAIL\nUnexpected success to load!\n");
 			goto fail_log;
 		}
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+		if (fd_prog < 0 &&
+		    (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS))
+			alignment_prevented_execution = 1;
+#endif
 		if (!expected_err || !cmp_str_seq(bpf_vlog, expected_err)) {
 			printf("FAIL\nUnexpected error message!\n\tEXP: %s\n\tRES: %s\n",
 			      expected_err, bpf_vlog);
-- 
2.42.0

