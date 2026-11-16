Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801554;
	b=jULjmeQNy8b7J9qVFl6vM2ktYbZP9dcY8Ci3BvqzfUKOAtzwUtGTBuUtkGeyFo8/bDWf
	 reOmZRykiwVzbm+RTH6DYL2PuPrMWD1RV3gKC8Yn4aXgUg89zZUtzjcWvpXKJuWg9wl1O
	 oFK8xSyQtNYvSVCvDWGXflHr0s+T5PgEVqXCVnmgfKgtF42FhqdfnGG4qTSYbqhhBKkKx
	 soDEqNwAFhE/tK+9R8e+wTcc0lLyrPNUMp5MVMDxA5Jq9CLH9YLtMUnGej81NxCxkanAj
	 1SRNRMlPBI6JRT5xDjtfYxL2ga0ZQMf1M5hetqEsLSqp6Dad/3h12J9UXIj0En9r1IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801554;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=gAtJiO5K2fmnWxGzxYN4gQDwpjSMMgPlhXq1rkQgr+M=;
	b=D+US2BIc9YDvH5GeI22TuAWD0SGZJVKBn4y/4nqzlxnq7felJGxM4cIpUCKE8G7XvExQ
	 faytyVgD3Qv2AOzAORxHIbelXk031cAIrItMB7bQ1sbtBZX6BZSokMwDapUFvzCPjhsV/
	 zWyvnl4YCFUjN8rQ0OdeHYZQZcUUxziSqX4FY0GoKSWUWUYDVEwIc+ClGH5RyeBcnIFI/
	 XEXFQF9f1hmmohuTo4+g5aMvuEE+TnI0FFOqYFodCVRCHD0TeP+it5Ojdp0oWp0Ys8O0j
	 FtXP4sLtroYMIvFZPUcH0UYIYcm7VKopTOzXOwgEgimK4aUV6gClTMmoVALFCk+VR4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30573606A32C;
	Mon, 16 Nov 2026 03:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30573606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxYdGPf_pqRAAgAA--.27638S3;
	Mon, 16 Nov 2026 11:59:11 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs2Mf_pqKNE0AA--.64529S4;
	Mon, 16 Nov 2026 11:59:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 2/4] selftests/bpf: Skip jit_insns_arena tests if not supported
Date: Mon, 16 Nov 2026 11:59:05 +0800
Message-ID: <20261116035907.4215-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261116035907.4215-1-yangtiezhu@loongson.cn>
References: <20261116035907.4215-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBxJs2Mf_pqKNE0AA--.64529S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1kKF1DuFyfXF4ruFW8Xwc_yoW8Zry7pF
	ykCw1vyryfX3WSv34UXrZrZ3yjkF4kGF98Cr1rJw4xJrnrXr1aqr1xKa4YgFs3WrWxZw15
	Zwn2kr9a93W7AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
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
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU4AhLUUUUU

When loading a BPF skeleton program via test_loader, certain test cases
such as jit_insns/cast_to_user may fail if the underlying hardware lacks
specific execution extensions required by newer features like BPF Arena.

Use libbpf_probe_bpf_map_type() in prog_tests/jit_insns.c to explicitly
check for BPF_MAP_TYPE_ARENA support before loading the jit_insns_arena
test skeleton. If the JIT backend or hardware does not support Arena,
use SKIP_TESTS() to cleanly report all subtests within the skeleton as
skipped.

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
 tools/testing/selftests/bpf/prog_tests/jit_insns.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/jit_insns.c b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
index 0aaab23a2eef..4110b1ff6ff8 100644
--- a/tools/testing/selftests/bpf/prog_tests/jit_insns.c
+++ b/tools/testing/selftests/bpf/prog_tests/jit_insns.c
@@ -3688,7 +3688,11 @@ static void test_tail_call(void)
 
 void test_jit_insns(void)
 {
-	RUN_TESTS(jit_insns_arena);
+	if (libbpf_probe_bpf_map_type(BPF_MAP_TYPE_ARENA, NULL))
+		RUN_TESTS(jit_insns_arena);
+	else
+		SKIP_TESTS(jit_insns_arena);
+
 	if (test__start_subtest("alu_imm"))
 		test_alu_imm();
 	if (test__start_subtest("alu_reg"))
-- 
2.42.0

