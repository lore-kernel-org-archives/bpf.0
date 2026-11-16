Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794801553;
	b=FaTJxkdJ7W5uMD1tj1MCKix8z4x8c2bkojDlswgE89cLXHtzlF68fQtAQCukZbkO7xvF
	 7IISq4O7f2if62LYIXLKLRgKtuP/rs7rylOAxwhT+RHZwdLa0aaFvkvXt36d0qYXC4YzY
	 UXk7m8zB8CXDmEjrzXiQH3TpQ+6QzJCqlAnhknBjObc/rRMVjKp7Lvbn6kH6h/Q6KExZ0
	 Zu4ArFaepdxpke4W6ks6NOtp3LedJeAjcqBHg6Zb52D3M2jnWhHDnBQ2mEFr36iSEMVWs
	 HpUgzeDrDcKjcTPmEb35Hurrj0syZWSEvonu5iqddAXastYZmlT0bO4fVEpaEqVj14g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801553;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=QKL1PfMWl48y+cokHvC06JvN8TNyTmGSQuhTvZ3WXjs=;
	b=PmcYhiGIFTv/gjEQtxoN4siaNGiWOb7MMa12ZpyMfJdp2l2QUx0OEDy2rcaappcl2Zfz
	 +Cwd2qcz2+34o+BO6I5V000KoFdRjRqJ84ddNDPatHExXTDT+U4H3wu365W9Y2+HzBznS
	 JWPeYhlE6LIklt07/hIWTcYZaxlMLSB43OA5eLHOUvMmG7GOBIXmSboa5lPxZSd2A81fU
	 lAKdLyW4VMQSxn3gqLTgpBLdr4987Xv46F3WCRaZlDCF0Sf+jEmhePSYsSXBUFVMo1g+m
	 8pU6h0AUzlksLyG2MzC8Ju6dBNgHntxJYW8XJEk2ggDJtmA4g2BCDnbTogN1BWsfESQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E709606A323;
	Mon, 16 Nov 2026 03:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E709606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Axj9GOf_pqPwAgAA--.27058S3;
	Mon, 16 Nov 2026 11:59:10 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBxJs2Mf_pqKNE0AA--.64529S3;
	Mon, 16 Nov 2026 11:59:09 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/4] selftests/bpf: Add SKIP_TESTS() helper for test_loader
Date: Mon, 16 Nov 2026 11:59:04 +0800
Message-ID: <20261116035907.4215-2-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJBxJs2Mf_pqKNE0AA--.64529S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr48tr45CrW3WrW7Xw4rCrX_yoW8Kr1Upa
	y8Ja1UKr9rJ3W3Xw1UJayUWFWftr1kJ3WfAr10qr1vvr13XryUtr1fK3WxtFnxW3yFqw1f
	Zas29w4a9r1UJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxU2puWDUUUU

When running BPF selftests on underlying hardware that lacks specific
execution extensions (such as BPF Arena support), loading certain test
skeletons failed, logging unexpected failures instead of declaring them
as skipped.

Manually hardcoding a skip list of subtest names inside the prog_tests
runner files is fragile and prone to silent omission when new subtests
are appended to the skeleton.

Add a `skip` field to `struct test_loader` along with a `SKIP_TESTS()`
macro (mirroring `RUN_TESTS()`) so test runners can iterate through
and mark all subtests in a skeleton as skipped.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/test_loader.c | 5 +++++
 tools/testing/selftests/bpf/test_progs.h  | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index d24e4fedae46..b5e85bb627d3 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1374,6 +1374,11 @@ void run_subtest(struct test_loader *tester,
 	if (!test__start_subtest_with_desc(subspec->name, subspec->description))
 		return;
 
+	if (tester->skip) {
+		test__skip();
+		return;
+	}
+
 	if (spec->skip_reason) {
 		printf("%s:SKIP: %s\n", __func__, spec->skip_reason);
 		test__skip();
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index adc18f5eceb6..89572c762b57 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -530,6 +530,7 @@ struct test_loader {
 	pre_execution_cb pre_execution_cb;
 
 	struct bpf_object *obj;
+	bool skip;
 };
 
 static inline void test_loader__set_pre_execution_cb(struct test_loader *tester,
@@ -553,6 +554,13 @@ extern void test_loader_fini(struct test_loader *tester);
 	test_loader_fini(&tester);					       \
 })
 
+#define SKIP_TESTS(skel) ({							\
+	struct test_loader tester = { .skip = true };				\
+										\
+	test_loader__run_subtests(&tester, #skel, skel##__elf_bytes);		\
+	test_loader_fini(&tester);						\
+})
+
 struct expect_msg {
 	const char *substr; /* substring match */
 	regex_t regex;
-- 
2.42.0

