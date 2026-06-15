Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159623DBD57
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781517919; cv=none; b=YT7plVefA/Wzo60wBralucUdh2x6B+1w+7GPkpF19dz03t7yqbrZQxaoOjlBIYqBSnoGJ0GsOb7b1L3CQAPuH0gehr/OktRdpBcuwcCRUBo6hZJg8sSHYXsdRzYnl38rnPuWRtkVuBZ9istjCXQzSRdDET7ZIst4QWMWxaH32OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781517919; c=relaxed/simple;
	bh=OapWD31uSsDKIvHXHB85c6FEXRB2lgQVk8YWNChvW+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7Ojch2M5BTWcgKemDNlG6HRV0sG+dA+fb2vXCW7FgsbjaIvkmITDNyMhSHksUGH3FF/YxSPZ0Gik4Z5p4potfGfnkqvdmD3KR3cGktbHD/eCPzZV/4SiKJ0haFMm+EzBO4JWgNooOF9+MfnRyM8Kw4U9ZYXKXv6iqlkfR2t9XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxf+tczi9qPE0UAA--.52756S3;
	Mon, 15 Jun 2026 18:05:16 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxzsJTzi9qlgOnAA--.55069S6;
	Mon, 15 Jun 2026 18:05:15 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Test jited inline of bpf_get_smp_processor_id() for LoongArch
Date: Mon, 15 Jun 2026 18:05:06 +0800
Message-ID: <20260615100506.19558-5-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxzsJTzi9qlgOnAA--.55069S6
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7GFWkGr1xtryDCrW8uF13WrX_yoW8JF1kpF
	yku3sFyw18GFy2gayxCF4UJFy5XFn5Z3yrZr1093yDGF18Jr1DJr93Kr1ayr98uFZY93sY
	va12qF4Sga4UZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzKZXUUUUU

Add the testcase for the jited inline of bpf_get_smp_processor_id(),
only for LoongArch currently.

Here is the test result on LoongArch:

  $ sudo ./test_progs -t verifier_jit_inline
  #604/1   verifier_jit_inline/inline_bpf_get_current_task:OK
  #604/2   verifier_jit_inline/inline_bpf_get_smp_processor_id:OK
  #604     verifier_jit_inline:OK
  Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../testing/selftests/bpf/progs/verifier_jit_inline.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
index 8560577f2557..02e562f56f9d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
@@ -21,4 +21,15 @@ int inline_bpf_get_current_task(void)
 	return 0;
 }
 
+SEC("fentry/bpf_fentry_test2")
+__success __retval(0)
+__arch_loongarch
+__jited("	ld.wu	$a5, $tp, 16")
+int inline_bpf_get_smp_processor_id(void)
+{
+	bpf_get_smp_processor_id();
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.42.0

