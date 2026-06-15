Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D933DBD64
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517918; cv=none; b=WR1JZaOmGo1FZrax1fLOf5EcIKyWldM9o+0p1zueYEb+idbki91Nu5/AQnfzbePWV1xNJG9ESxY34KopRA+VdBX4lNvg9apuDC3felpALn0jVCNKCUBsPiD8NIigbcYyJ1wbDzIGUM6VynXJ5NKEH8vpSNcBSFkyH1A0178bzu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517918; c=relaxed/simple;
	bh=TNI2UoLg7cuo24OiaHsB/Z1sFLXocFo2+eoqDTfnVjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rptMmvswZ06m2JJ84IiXDFW5DyuT2UJFv+2QToRXx30vYNrn9u0AvNjm6MSuaEau7m2OHxH2goXxqsdYL8Nlnq006S0DjEiYf02aid3AixSKuOaHUkfVWFEekBk8aneSz4fAk9SI/Ro6E5JIJDDfAkJ6m07Pub9bk2KJ3L89VTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxX+tbzi9qOU0UAA--.52995S3;
	Mon, 15 Jun 2026 18:05:15 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxzsJTzi9qlgOnAA--.55069S5;
	Mon, 15 Jun 2026 18:05:15 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Test jited inline of bpf_get_current_task() for LoongArch
Date: Mon, 15 Jun 2026 18:05:05 +0800
Message-ID: <20260615100506.19558-4-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260615100506.19558-1-yangtiezhu@loongson.cn>
References: <20260615100506.19558-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxzsJTzi9qlgOnAA--.55069S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWruFW8Wr47GF1xZr15WrWrXrc_yoW8Jry5pF
	Wkur9rJ345Aa42gay7AF4DJFy5WFn5Z3y5Xr10gw47GF4DJr1DXrn8Gr12kry5WFZYk39a
	vwnF9F4vga48JFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7eT5DUUUU

Add the JITed inline instruction of bpf_get_current_task() for LoongArch
to pass the test case.

Before:

  $ sudo ./test_progs -t verifier_jit_inline
  #604/1   verifier_jit_inline/inline_bpf_get_current_task:SKIP
  #604     verifier_jit_inline:SKIP
  Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED

After:

  $ sudo ./test_progs -t verifier_jit_inline
  #604/1   verifier_jit_inline/inline_bpf_get_current_task:OK
  #604     verifier_jit_inline:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/verifier_jit_inline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
index 76d80605ec7f..8560577f2557 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -12,6 +12,8 @@ __arch_arm64
 __jited("	mrs	x8, SP_EL0")
 __arch_riscv64
 __jited("	mv	a5, tp")
+__arch_loongarch
+__jited("	move	$a5, $tp")
 int inline_bpf_get_current_task(void)
 {
 	bpf_get_current_task();
-- 
2.42.0

