Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9423313E31;
	Tue, 28 Jul 2026 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208591; cv=none; b=KdhKFkurYYF59vkpCROVyIs16vFtUZXUIB+yyLLYpUxs1FmxlirNveQFA4wAo+blc5+fS1RN6VUiVmL970JK3seum7gAbPEE0dWLy2rfplwbIQdA61nptW+gDU8F6KriexuTr0z/U4FAgfBXJadN5v665oPFte5Xf6XwfYUPCAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208591; c=relaxed/simple;
	bh=GYCTHOgVdqTt6JpiejCot5pKLn46PxB3FddKVKPIIks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDurTni9/iNcfC44iUXRpUraMF9pjsw0AWZX1he5nn3bCDuYGpkuvId8bNwxSEeAU7UqLRTW/JZK51A3Beb4ZUbTu1OlKwfXklEEd78SOi5yi1wEOkU5sc6E24bSTWz0gH7r94ihHW1jValZLX5L7kXMA9ivU3P0xZFmvSjwsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxVegEH2hquP8HAA--.4861S3;
	Tue, 28 Jul 2026 11:16:21 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxPcUAH2hqhzcbAA--.14265S2;
	Tue, 28 Jul 2026 11:16:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Refine move_imm() and optimize memory load
Date: Tue, 28 Jul 2026 11:16:13 +0800
Message-ID: <20260728031615.9389-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxPcUAH2hqhzcbAA--.14265S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFW7Xw1xGryxWr1Duw1UCFX_yoW8Xr1kpa
	9a9F43Kr4kJa4xZ34fCayjqr1Yya1fW397Gayaq34rWrZ8Zr1DXr1Igw4vqFyDA3yFgryF
	q34rCa4q9a1UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73
	UjIFyTuYvjxU7fMaUUUUU

This series is based on 7.2-rc5 and the following two series:

Fix and optimize BPF tailcall for LoongArch
https://lore.kernel.org/loongarch/20260707101508.32283-1-yangtiezhu@loongson.cn/

LoongArch: BPF: clean up for build_insn() paths
https://lore.kernel.org/loongarch/20260711100956.4351-1-yangtiezhu@loongson.cn/

The long-term goal is to eliminate frequent and redundant
zero-extensions and sign-extensions, but there are still
some issues to sort out. Here is the previous RFC patch:

LoongArch: BPF: Eliminate zero/sign extensions for 32-bit operations
https://lore.kernel.org/loongarch/20260711101656.7415-3-yangtiezhu@loongson.cn/

For now, just send out the stable and verified patches
first.

Here are the test results of test_bpf:

fedora@linux:~$ sudo dmesg -c
fedora@linux:~$ sudo modprobe test_bpf
fedora@linux:~$ dmesg -t | grep Summary
test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

Tiezhu Yang (2):
  LoongArch: BPF: Clean up and decouple is32 parameter from move_imm()
  LoongArch: BPF: Eliminate zero-extension for memory load operations

 arch/loongarch/net/bpf_jit.c | 123 ++++++++++++++++++++++-------------
 arch/loongarch/net/bpf_jit.h |   7 +-
 2 files changed, 79 insertions(+), 51 deletions(-)

-- 
2.42.0

