Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794197532;
	b=tgCQLoNCBj0QGapKM7Q/bJsikN4NsKzb1jGrTrS1Z3ME7pEG8mdz8JMoFaBottQ/SLnG
	 r3j/ZH14RXMc6tktf9UeknC+WajfuW0ZcScG8OPu6OFpo6ZGbL8aFSEg083q6boD3f+GT
	 rnpTABo3usNmKKeD69ui38L2iXEYou8kYrkvg4nZE+53blITbFBoG2PFli1Jpk/iZ47wU
	 KMnmLWFVZZDJ3CfnZmP7SRzID43alT4jVbZl/YaTWzG+CpR67JuytjFFZ7zk1MbHasfQE
	 ck4Bhtka92CdzftAMfyLebgNAuHvU1KJ+0zPYwKyaBKWcsfOd0OYBaX+HqTLC5E9nFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794197532;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=2TguHwko21fivh+UAP4XrLKQb5/lOJ8y5+dOP7L0tb8=;
	b=CtmpPedMr5kbE3UmqfzF9pVtzV2gNKw9rmVhqCKMv/yuF7ed01/Cuv6eSXNp8zzemLLm
	 rAjZkikTT1Cqka7WBM4060qeSiCUeIpgAWkSg3XvvHG+ef/nArLfcEZxroRaa1X9sKx/5
	 RCoNq/sVT6ijtyiT6S8QsVA7+bWdXjQKOu+hKpfLuFNgHi8A4JKAksiPWfvb2r7YfbQas
	 RfDvFAFWh3xOtXJgpH7dQQLc9ODspPLjrzX/Da9qqB59SYu48up84tpz1d8ZWk0617ldO
	 lQi4z7Tc9fjTshT2vhryFr0vaApme04mIyGmZ9scpNh/Cv1FMxuL6yrERdxud4fcJLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69A7606A322;
	Mon,  9 Nov 2026 04:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D69A7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cxf9MZSPFqmrMdAA--.20149S3;
	Mon, 09 Nov 2026 12:12:09 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxxMwXSPFqQRwzAA--.11813S3;
	Mon, 09 Nov 2026 12:12:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Skip jit_insns_arena tests if not supported
Date: Mon,  9 Nov 2026 12:12:06 +0800
Message-ID: <20261109041207.15221-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261109041207.15221-1-yangtiezhu@loongson.cn>
References: <20261109041207.15221-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxxMwXSPFqQRwzAA--.11813S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1kKF48Jw13Aw4fWrWkKrX_yoW8Zw4DpF
	92kw4vvrySq3WSvayDXrnrXrWjkFs5GF98Gw1rtw4xJrnrXr4aqr1xKa4YgFs3WrWxZw15
	Zw1j9r9aka47AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4OzVUUUUU

When loading a BPF skeleton program via test_loader, certain test cases
such as jit_insns/cast_to_user may fail if the underlying hardware lacks
specific execution extensions required by newer features like BPF Arena.

Use libbpf_probe_bpf_map_type() in prog_tests/jit_insns.c to explicitly
check for BPF_MAP_TYPE_ARENA support before loading the jit_insns_arena
test skeleton. If the JIT backend or hardware does not support Arena,
cleanly report the subtest status as SKIPPED via test__skip().

This prevents false-alarm test failures on unsupported hardware while
preserving the core verification coverage for the rest of the standard
JIT instruction tests (such as alu_imm, alu_reg).

Before:
  $ sudo ./test_progs -a jit_insns/cast_to_user
  ...
  libbpf: map 'arena': failed to create: -EOPNOTSUPP
  run_subtest:FAIL:unexpected_load_failure unexpected error: -95 (errno 95)
  ...
  Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED

After:
  $ sudo ./test_progs -a jit_insns/cast_to_user
  ...
  Summary: 1/0 PASSED, 1 SKIPPED, 0/0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/prog_tests/jit_insns.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index 0aaab23a2eef..e8a0e5ec2d6b 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -3688,7 +3688,14 @@ static void test_tail_call(void)
 
 void test_jit_insns(void)
 {
-	RUN_TESTS(jit_insns_arena);
+	if (libbpf_probe_bpf_map_type(BPF_MAP_TYPE_ARENA, NULL)) {
+		RUN_TESTS(jit_insns_arena);
+	} else {
+		if (test__start_subtest("arena_zero_off"))
+			test__skip();
+		if (test__start_subtest("cast_to_user"))
+			test__skip();
+	}
 	if (test__start_subtest("alu_imm"))
 		test_alu_imm();
 	if (test__start_subtest("alu_reg"))
-- 
2.42.0

