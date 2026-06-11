Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181B2237180;
	Thu, 11 Jun 2026 01:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142814; cv=none; b=acq9ahKkTITxEXMGyUezI3ZO5RQJN0CrDJw22Hb1acuLEd313Clc1BF+Kx/mzK+ftMVVQ/874cUjhtww0S+YODUHcAPJAEgoeGHUgUnFZbHwbbro+xpy0fDTy+JlNqtdF0rjNtE6BZEAaYszRtApD0xNPxw0wC17sW3mbwFnlOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142814; c=relaxed/simple;
	bh=RDVFVRReQjfk9qU39UCYeD0z3cOE4puQLG6+tKjJJOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VI5hguQYL2Ca9HPhgGyEaOLCphVyW97OHZ6AqCr2rhPyklk0JLwOI2vCihc0kZWE3gPyw8tX/JfBHo48R/IE5fzPJkn8zGA9BX5ZWY/kQQx/y/vVtEiuOnWc5tBoxMdvwz4HECqvY38XDYYbj1szrU7ZsnVI5SqAwruzZrHa3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxVXgZFSpqCecSAA--.25541S3;
	Thu, 11 Jun 2026 09:53:30 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBx68EXFSpqrXaiAA--.43928S2;
	Thu, 11 Jun 2026 09:53:28 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Move thread_info into task_struct for LoongArch
Date: Thu, 11 Jun 2026 09:53:24 +0800
Message-ID: <20260611015327.12108-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx68EXFSpqrXaiAA--.43928S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWkur48KF48GFyfAFW8GrX_yoW8Xr1DpF
	9rCrn8Gr4rGr93A3Zxt34q9rn8Jw1vgw1aqanIy348CF4aqF1UXw18Gr1DXF90qw4rtrW0
	qFyrKw1agFyUJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

Based on 7.1-rc7, tested with stress-ng, successfully passed
the 3-hours stress testing suite, UnixBench benchmarking shows
a steady performance lift across all core counts.

Thanks Huacai, Wang Rui, sashiko-bot and bot+bpf-ci for your
review comments and valuable suggestions.

Tiezhu Yang (3):
  LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
  LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers
  LoongArch: BPF: Inline bpf_get_smp_processor_id() helper

 .../core/thread-info-in-task/arch-support.txt |  2 +-
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/include/asm/current.h          | 31 +++++++++++++++++++
 arch/loongarch/include/asm/smp.h              |  3 +-
 arch/loongarch/include/asm/stackframe.h       |  9 ++++--
 arch/loongarch/include/asm/switch_to.h        |  6 ++--
 arch/loongarch/include/asm/thread_info.h      | 10 ------
 arch/loongarch/kernel/asm-offsets.c           |  6 ++--
 arch/loongarch/kernel/entry.S                 |  7 +++--
 arch/loongarch/kernel/head.S                  | 18 ++++++-----
 arch/loongarch/kernel/process.c               |  2 ++
 arch/loongarch/kernel/relocate.c              |  2 +-
 arch/loongarch/kernel/setup.c                 |  1 +
 arch/loongarch/kernel/smp.c                   |  6 ++--
 arch/loongarch/kernel/switch.S                | 14 +++++----
 arch/loongarch/kernel/traps.c                 |  5 +++
 arch/loongarch/net/bpf_jit.c                  | 30 ++++++++++++++++++
 17 files changed, 115 insertions(+), 38 deletions(-)
 create mode 100644 arch/loongarch/include/asm/current.h

-- 
2.42.0

