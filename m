Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010AF3C0A04;
	Fri, 16 Oct 2026 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138228; cv=none; b=cPJCZP2G8y79am6T39zQD2m+kbZBsjiyBV2v3AdDBHJKlnirL+jwuActX+a9NOv2NEus33qu+alam7fW9U1XeTq5206wOucpgdzHCaw81vUjWQiJ4pgI22nwpJrKeVNAzaOAXP+oUyPvu5WE0HVYJi2X6y0b3Ob369LCSp20Sg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138228; c=relaxed/simple;
	bh=EworvDPRsWhd9IFYTOb23xuCpZRyTVLzaVPkgA1nJjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5d0ohPAJDPEA3DcXRj7NdV/dIcigu1YrFWAcQ9kTzU8WpH0e+edmKiwLaUgwefk/x+wnQHPIh8FJZw++4UnZGZfVX+WHwqq6JMAceh4XsScDVS117ZHmGSPkBpP/keaWbbt8kgP6ZCQOATIq1UiCNeQs2OzN2pbDjKmOs88tEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxD9Pt29FqK3AWAA--.65316S3;
	Fri, 16 Oct 2026 16:10:21 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJBx5czi29FqOAwtAA--.2269S2;
	Fri, 16 Oct 2026 16:10:15 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] LoongArch: BPF: Refine move_imm() and optimize 32-bit operations
Date: Fri, 16 Oct 2026 16:10:03 +0800
Message-ID: <20261016081006.26069-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx5czi29FqOAwtAA--.2269S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF43GF4xKFykJF13Xr47GFX_yoW8Gw48pF
	ZxArn3Kr4UGFyfZF10yay8Zr15Ka1fCwnFqayYk34UJFn5XF1jqF18KF4kXFyDt3yFqryF
	qrykGw4YgFWDXacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJUUUUU=

v3:
  -- Add a prerequisite patch to detect CPUCFG2_DIV32 feature.
  -- Fix a hardware compatibility bug by checking cpu_has_div32
     before emitting native 32-bit div/mod instructions.

This version is based on v7.3-rc7 and has been tested on Loongson-3A6000
and Loongson-3A5000 physical machines.

All of the testcases of test_bpf passed on Loongson-3A6000 (with DIV32)
and Loongson-3A5000 (without DIV32), here are the test results:

$ sudo modprobe test_bpf
$ dmesg -t | grep Summary
test_bpf: Summary: 1061 PASSED, 0 FAILED, [1049/1049 JIT'ed]
test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]
test_bpf: test_skb_segment: Summary: 2 PASSED, 0 FAILED

For the BPF selftests test_verifier and test_progs, there are no any
regressions.

Tiezhu Yang (3):
  LoongArch: Add CPUCFG2 DIV32 feature detection
  LoongArch: BPF: Clean up and decouple is32 parameter from move_imm()
  LoongArch: BPF: Optimize 32-bit operations using native instructions

 arch/loongarch/include/asm/cpu-features.h |   1 +
 arch/loongarch/include/asm/cpu.h          |   2 +
 arch/loongarch/include/asm/inst.h         |   6 +
 arch/loongarch/include/uapi/asm/hwcap.h   |   1 +
 arch/loongarch/kernel/cpu-probe.c         |   4 +
 arch/loongarch/kernel/proc.c              |   2 +
 arch/loongarch/net/bpf_jit.c              | 381 ++++++++++++----------
 arch/loongarch/net/bpf_jit.h              |  25 +-
 8 files changed, 234 insertions(+), 188 deletions(-)

-- 
2.42.0

