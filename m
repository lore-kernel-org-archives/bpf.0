Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351593;
	b=cNhInUuGopzEvE9qshVMkchueCVUXgDTjvTLF4Dqy7NBv38jwFbaUuyykX3YQZLHfMRt
	 dT6j3xobOH6t7A8hpq2QKH6+rqCuM45ICQJRU3EQHySoqhUKXfeTMTO2MzjPs51vWpvGr
	 jpMkczP9ZExoCZ0nLJFj6v9SYPjWLhvrGmYQH0H4TgmkJMVn1BNsyTydx5sWMwTKx2lEE
	 v4eyyPELDjScHk2joUX75+PJR22Vl45uUVwsTtX6CrCPZFtsG3WLHJkQgyfHQ1ahEMVkg
	 TuPaQ/mocGVR9moFbCaYiTXYGguzq8R7BCxG7rlzHTvIF1RtOgm7JY2Lqcczs9Y2D/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351593;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=XmIjZzmN9QtdmMFdq/RvopM7L7VH+D444+wD0S3j5jA=;
	b=Z7ufi9gInSXvbzcBSQEOUCfhTgOgOuRWiQJd1DCBR/T19MeLB1iyA+x7i1iRT8ddc9cv
	 E4JViAgqZELaFO87JiGONf3KgRJPvf0XLnW1CyrH9EzeWS5es9iNfe/KrY7tL63kxSQJJ
	 t5GBxiuL1XsnZM4xL/d6z0wDXstPgjtwd92H9OHo/iqvBYPKFaOlRJo2//sI+55N9RmSL
	 GBio/T72btl3mt3vN5FSpsn5zMMWVz0pYAOePmNim4Khg1WX7oHfnRK9DK51Fq3K54gO4
	 lUFO2X+ohq9u+irL8Yqz8Bo5/gdkd0AaZTWKpoHyzpenbmhX90ePDEL6pG6Muy6sSLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35697606A31C;
	Fri, 30 Oct 2026 09:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35697606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Cx_9KkX+RqZckaAA--.12333S3;
	Fri, 30 Oct 2026 17:13:08 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJDxTs+iX+Rqp2sxAA--.37235S2;
	Fri, 30 Oct 2026 17:13:07 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Enable signed overflow and small value tests for LoongArch
Date: Fri, 30 Oct 2026 17:13:05 +0800
Message-ID: <20261030091305.3277-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJDxTs+iX+Rqp2sxAA--.37235S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAw47XFykXFyfWFyxGF1kXrc_yoWrKFWfpF
	WUu3sxGr48Xw17WrZIqFWDGF45ZFn2ga4rWr9Yqr1fAw4DJr9Fqw1Ivws5GayYqF18uwn0
	9F17Z3ZIq3Wjy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

The LoongArch hardware divider handles signed overflow boundaries (such
as INT_MIN/-1 or LLONG_MIN/-1) natively and perfectly well on physical
silicon: (1) for division operations, it naturally returns the dividend
itself; (2) for modulo operations, it returns 0.

Furthermore, small value signed calculations with negative divisors work
correctly as expected.

Thus add the __arch_loongarch macro tag to these 16 test cases to enable
them for LoongArch in verifier_sdiv.c.

Before:
  $ sudo ./test_progs -t verifier_sdiv | tail -1
  Summary: 1/128 PASSED, 16 SKIPPED, 0/0 FAILED

After:
  $ sudo ./test_progs -t verifier_sdiv | tail -1
  Summary: 1/144 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../testing/selftests/bpf/progs/verifier_sdiv.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index d6cbe1e27fd6..4ac92335da91 100644
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
@@ -810,6 +811,7 @@ SEC("socket")
 __description("SDIV64, r/r, small_val/-1")
 __success __retval(-5)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 5")
 __xlated("1: r3 = -1")
 __xlated("2: r12 = r3")
@@ -839,6 +841,7 @@ SEC("socket")
 __description("SDIV64, overflow r/i, LLONG_MIN/-1")
 __success __retval(1)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r4 = r2")
 __xlated("3: r2 = -r2")
@@ -865,6 +868,7 @@ SEC("socket")
 __description("SDIV64, r/i, small_val/-1")
 __success __retval(-5)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 5")
 __xlated("1: r4 = r2")
 __xlated("2: r2 = -r2")
@@ -887,6 +891,7 @@ SEC("socket")
 __description("SDIV32, overflow r/r, INT_MIN/-1")
 __success __retval(1)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -922,6 +927,7 @@ SEC("socket")
 __description("SDIV32, r/r, small_val/-1")
 __success __retval(5)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -5")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -953,6 +959,7 @@ SEC("socket")
 __description("SDIV32, overflow r/i, INT_MIN/-1")
 __success __retval(1)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = -w2")
@@ -979,6 +986,7 @@ SEC("socket")
 __description("SDIV32, r/i, small_val/-1")
 __success __retval(-5)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = 5")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = -w2")
@@ -1001,6 +1009,7 @@ SEC("socket")
 __description("SMOD64, overflow r/r, LLONG_MIN/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r3 = -1")
 __xlated("3: r4 = r2")
@@ -1031,6 +1040,7 @@ SEC("socket")
 __description("SMOD64, r/r, small_val/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 5")
 __xlated("1: r3 = -1")
 __xlated("2: r4 = r2")
@@ -1061,6 +1071,7 @@ SEC("socket")
 __description("SMOD64, overflow r/i, LLONG_MIN/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 0x8000000000000000")
 __xlated("2: r4 = r2")
 __xlated("3: w2 = 0")
@@ -1083,6 +1094,7 @@ SEC("socket")
 __description("SMOD64, r/i, small_val/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: r2 = 5")
 __xlated("1: r4 = r2")
 __xlated("2: w2 = 0")
@@ -1105,6 +1117,7 @@ SEC("socket")
 __description("SMOD32, overflow r/r, INT_MIN/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -1137,6 +1150,7 @@ SEC("socket")
 __description("SMOD32, r/r, small_val/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -5")
 __xlated("1: w3 = -1")
 __xlated("2: w4 = w2")
@@ -1169,6 +1183,7 @@ SEC("socket")
 __description("SMOD32, overflow r/i, INT_MIN/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = -2147483648")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = 0")
@@ -1191,6 +1206,7 @@ SEC("socket")
 __description("SMOD32, r/i, small_val/-1")
 __success __retval(0)
 __arch_x86_64
+__arch_loongarch
 __xlated("0: w2 = 5")
 __xlated("1: w4 = w2")
 __xlated("2: w2 = 0")
-- 
2.42.0

