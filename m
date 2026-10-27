Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074592;
	b=dBDqPyFc2z37P2eGcKPcTUr8dpt90ljmcZvxqFYuiSxez6EVjcOtIRZrwqhipZX5j15j
	 uKs7DiIPn1ZaOnS03rESJQOp8zrPG1YecVOHw+M/Q21+imFwRer+pua20OAGow1ifeuUc
	 Xvase0BBRIHQIgSKShru2pQmsRZtsd6e8Ky4drOvNnA56DgUHB2JsZJ4pGphAgRKfR2dT
	 iNZbXYZPZvFj8p14DnXtssvSF+Ago50YQyXctZfRjYkSV9LIYAN29kY5ZDpGXnCKZMhvN
	 2sHj3+UqPtKy+3pUR4R2Tu2j142g+JZzXLnqYlIOeA5DJd6IORsbFcOrzjWdEZXWZvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074592;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=OKh7RMy4z39rK+91H91FMymRIBmqD8DV3FbJDx+waE4=;
	b=4vevk0u4ZyrvzKxvN1Wj3ZVcHUm0ouFeiQKwkSTD8YluxenEJVrsalV+0DKM3yl3esim
	 dOyT51hK0/DTlL0nKd4qidPDp4Y5gs++jy0u3Yl/MEW+nlBTnw1Zws9QRxE4b64VUHxWL
	 kWZI+quKam/DqTrOk2Bdf73z1yJeCB6tZk6Rm1bMcpL0kTkNO7nSoSXzs+YdOmWsSW4BK
	 uPd9uAi1kxA1yJlgYpnPTRJ0vkVUd8HfwzWBcBKw19KAzaW5qYywWXY1l53gJ5fiYmrNs
	 /BI3mo0qwlYBraH9lk/pggfDCt04MPVqyenzq4wko632ETAHxCiE9t8+Mgmjjkiim0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959E606A331;
	Tue, 27 Oct 2026 04:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3959E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Axj9GdJeBq7bIZAA--.9482S3;
	Tue, 27 Oct 2026 12:16:29 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx1cycJeBqcY4wAA--.7654S2;
	Tue, 27 Oct 2026 12:16:29 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Enable signed division and modulo overflow tests for LoongArch
Date: Tue, 27 Oct 2026 12:16:27 +0800
Message-ID: <20261027041627.20792-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
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
X-CM-TRANSID:qMiowJAx1cycJeBqcY4wAA--.7654S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw47XFyfXr1xKFyruryUurX_yoWrXw1fpF
	WUuFZIgrs7Xw17uFWYvF4UJFs0q3WkuayrWF1rAw1Iy3s8JFnIq34Igws5Ca1rtFn5uw1F
	vF17ZasFv3Wjg3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUc0eHDUUUU

The LoongArch hardware divider handles signed overflow boundaries (such
as INT_MIN/-1 or LLONG_MIN/-1) natively and perfectly well on physical
silicon: (1)for division operations, it naturally returns the dividend
itself; (2)for modulo operations, it returns 0. Thus enable the signed
division and modulo overflow tests for LoongArch in verifier_sdiv.c.

Before:

  $ sudo ./test_progs -t verifier_sdiv | grep "MIN/-1"
  #731/121 verifier_sdiv/SDIV64, overflow r/r, LLONG_MIN/-1:SKIP
  #731/123 verifier_sdiv/SDIV64, overflow r/i, LLONG_MIN/-1:SKIP
  #731/125 verifier_sdiv/SDIV32, overflow r/r, INT_MIN/-1:SKIP
  #731/127 verifier_sdiv/SDIV32, overflow r/i, INT_MIN/-1:SKIP
  #731/129 verifier_sdiv/SMOD64, overflow r/r, LLONG_MIN/-1:SKIP
  #731/131 verifier_sdiv/SMOD64, overflow r/i, LLONG_MIN/-1:SKIP
  #731/133 verifier_sdiv/SMOD32, overflow r/r, INT_MIN/-1:SKIP
  #731/135 verifier_sdiv/SMOD32, overflow r/i, INT_MIN/-1:SKIP

After:

  $ sudo ./test_progs -t verifier_sdiv | grep "MIN/-1"
  #731/121 verifier_sdiv/SDIV64, overflow r/r, LLONG_MIN/-1:OK
  #731/123 verifier_sdiv/SDIV64, overflow r/i, LLONG_MIN/-1:OK
  #731/125 verifier_sdiv/SDIV32, overflow r/r, INT_MIN/-1:OK
  #731/127 verifier_sdiv/SDIV32, overflow r/i, INT_MIN/-1:OK
  #731/129 verifier_sdiv/SMOD64, overflow r/r, LLONG_MIN/-1:OK
  #731/131 verifier_sdiv/SMOD64, overflow r/i, LLONG_MIN/-1:OK
  #731/133 verifier_sdiv/SMOD32, overflow r/r, INT_MIN/-1:OK
  #731/135 verifier_sdiv/SMOD32, overflow r/i, INT_MIN/-1:OK

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/progs/verifier_sdiv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index d6cbe1e27fd6..5e8bf781e073 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -775,6 +775,7 @@ SEC("socket")
 __description("SDIV64, overflow r/r, LLONG_MIN/-1")
 __success __retval(1)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r3 = -1")
 __xlated("3: r4 = r2")
@@ -839,6 +840,7 @@ SEC("socket")
 __description("SDIV64, overflow r/i, LLONG_MIN/-1")
 __success __retval(1)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r4 = r2")
 __xlated("3: r2 = -r2")
@@ -887,6 +889,7 @@ SEC("socket")
 __description("SDIV32, overflow r/r, INT_MIN/-1")
 __success __retval(1)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -953,6 +956,7 @@ SEC("socket")
 __description("SDIV32, overflow r/i, INT_MIN/-1")
 __success __retval(1)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = -w2")
@@ -1001,6 +1005,7 @@ SEC("socket")
 __description("SMOD64, overflow r/r, LLONG_MIN/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r3 = -1")
 __xlated("3: r4 = r2")
@@ -1061,6 +1066,7 @@ SEC("socket")
 __description("SMOD64, overflow r/i, LLONG_MIN/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r4 = r2")
 __xlated("3: w2 = 0")
@@ -1105,6 +1111,7 @@ SEC("socket")
 __description("SMOD32, overflow r/r, INT_MIN/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -1169,6 +1176,7 @@ SEC("socket")
 __description("SMOD32, overflow r/i, INT_MIN/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = 0")
-- 
2.42.0

