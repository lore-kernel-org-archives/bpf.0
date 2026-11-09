Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196992;
	b=uD2KfiqBLzpie8+4wh8Fh2kR9tPBP1Q+b5yJY+oztjHI6Lh8WiYWVQNUznAQxUhoHtkl
	 l9ee+zycNeqztYs81LRr0oJ2YmowAabzuOltxcG8W4o0I4K8Ie9ju2FGtGN07o5VLBRYf
	 BfBfBdhX/yKzf17EX06eWbGZKV3UxDVY2HH9k/sk63ZsnsMcR8UA5uHSe25CpKbl29kwU
	 hpCTSoN5Lm3QgcIcStU08ndYbOK21qFSEMxtcrZC9RIz2tPGCHT8DTK0InHtKeU1ZZQkv
	 WxwSR7Eyx9jcXCkhZCoCdPKVFuIckRMJ0qarFw3aA8Y02BsVD1av5jZoGc+HhdJQj+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196992;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=i/f88ckO3Qq3qO65j9srmB+LjpsKuGFHQJlvd3jhpgo=;
	b=lwGmjqRR0HwVlaeXYHv/TZ/IMJc4SXwTq+J86cZRX1JX6vFCgcWNqJe8jOunG7WhqH4b
	 7cBlbImTKl3CHx5xq2B2KkB5QlTzasuACPGFRmIl6POWv1r/mJ6wCCOe2z7CxdaBj6Wtt
	 5Pr4hmint+QvAloGwUan6JRvXRoS3VrtCppAmhtshpE+h6nPbUfNGvlR82Q/MhwNOu+8a
	 rNIBSzNbG5qbIBZBi5v7FuyxHF/St5x7Xw7Pb5Vmsj41b0S+eTIn/RwfsXfwhT0O4gVac
	 /RdyBWAOCpx1fAhLe5L5qVlHIK1qiI6sYKHymUrRbIdQkBj3oPihDaRGDstU4/xHn0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF119606A322;
	Mon,  9 Nov 2026 04:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF119606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxUNH8RfFqAbMdAA--.20536S3;
	Mon, 09 Nov 2026 12:03:08 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxlMz7RfFq9hszAA--.11822S3;
	Mon, 09 Nov 2026 12:03:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] LoongArch: BPF: Make arena support depend on 128-bit atomic cmpxchg
Date: Mon,  9 Nov 2026 12:03:05 +0800
Message-ID: <20261109040306.11536-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261109040306.11536-1-yangtiezhu@loongson.cn>
References: <20261109040306.11536-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxlMz7RfFq9hszAA--.11822S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCw4DWryrCry3JFWUJFyxZwc_yoW5Aw45pF
	W3uFs8Krs0qw1Sy39rGw1kWw15AFWrKrW5Ka1fAryUA3s8Xw17Jry8Cas5uF4ktrWru3WY
	9a4jyF9F9a1kCagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

When testing bpf selftest "jit_insns/cast_to_user", there are different
behaviors on different Loongson machines.

(1) Loongson-3A6000
  $ sudo ./test_progs -a jit_insns/cast_to_user
  ...
  Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED

(2) Loongson-3A5000
  $ sudo ./test_progs -a jit_insns/cast_to_user
  ...
  libbpf: map 'arena': failed to create: -ENOMEM
  run_subtest:FAIL:unexpected_load_failure unexpected error: -12 (errno 12)
  ...
  Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED

This is because the arena range tree uses kmalloc_nolock(), which requires
128-bit atomic cmpxchg; this is provided by not only hardware SCQ extension
but also assembler support on LoongArch. On CPUs without the SCQ extension,
or if the older versions of assembler do not support that sc.q instruction,
arena map creation fails with a misleading -ENOMEM error.

Since system_has_cmpxchg128() and arch_cmpxchg128() are only available when
CONFIG_AS_HAS_SCQ_EXTENSION is enabled, guard bpf_jit_supports_arena() with
an #ifdef block to preserve compile-time robustness first, and then safely
return system_has_cmpxchg128() if defined, otherwise falling back to false.
This ensures that arena map creation cleanly fails with -EOPNOTSUPP on the
systems without either the assembler support or the hardware SCQ extension.

With this patch, here is the test result on Loongson-3A5000 without SCQ
extension:

  $ sudo ./test_progs -a jit_insns/cast_to_user
  ...
  libbpf: map 'arena': failed to create: -EOPNOTSUPP
  run_subtest:FAIL:unexpected_load_failure unexpected error: -95 (errno 95)
  ...
  Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED

It is better to mark the test status as SKIPPED rather than logging a
false-alarm failure if the feature is not supported, but this belongs
to a separate bpf selftest patch.

This is similar to commit 536b523b4073 ("bpf, riscv: Make arena support
depend on ZACAS").

Note that BPF should not depend on a SLUB debug-mode escape hatch, so
no need to consider the slub_debug exception.

Fixes: 4fdb5dd8aeba ("LoongArch: BPF: Implement bpf_addr_space_cast instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/net/bpf_jit.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3ab039d0afb6..b845083d1d74 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2489,7 +2489,16 @@ bool bpf_jit_bypass_spec_v4(void)
 
 bool bpf_jit_supports_arena(void)
 {
-	return true;
+	/*
+	 * The arena range tree uses kmalloc_nolock(), which requires 128-bit
+	 * atomic cmpxchg; this is provided by not only hardware SCQ extension
+	 * but also assembler support on LoongArch.
+	 */
+#ifdef system_has_cmpxchg128
+	return system_has_cmpxchg128();
+#else
+	return false;
+#endif
 }
 
 bool bpf_jit_supports_fsession(void)
-- 
2.42.0

