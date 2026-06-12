Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D112F39C7;
	Fri, 12 Jun 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226985; cv=none; b=oahXFryBXSMDiED3AOXqiXcDiBAnQrHCy6OZfO4sUq1tFIO3/WJgx4ZIjGZwlFlZHUW/Az0ChMYrZwCyP7UrFEtZWAjwmKasA6TL7eh7Y+2Yj2B+rWZD4I4VfbY4GEd4elsrXykvqOZJH8Cb146jscmZA7xrJ5M4T+gITMgefdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226985; c=relaxed/simple;
	bh=PYVQOp1p1a54cixrBqiRsT4ofByzH4S3OVNyLsK+ZQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UF76Oupk8JlBwe/NWIXNYB+akwsecLvlb5AwXHWfB5S1GrABuMoy0q7fwwPZMqnWoFJdSPOPyoAq7OJ8N/VTZKcSgl+XMXiVgCyF9U40wJr8n1V0fU8M/56meAdEOXZMOeKZa7QMxDKvaGoN5vSe6frZDDA+YHQELMUy7llGKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxEuvkXStqsU0TAA--.51417S3;
	Fri, 12 Jun 2026 09:16:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxvsLgXStqTHCjAA--.47687S2;
	Fri, 12 Jun 2026 09:16:17 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Move thread_info into task_struct for LoongArch
Date: Fri, 12 Jun 2026 09:16:13 +0800
Message-ID: <20260612011616.27771-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvsLgXStqTHCjAA--.47687S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kry8Ar4fKw4fGF18XF1rKrX_yoW8Xr45pF
	9rCrn8Gr4rGr93A3Zxt3yq9rn8Jwn2gw1aq3ZIy348Cr4aqF1UXw18GrnrXF90qw4rKrW0
	qFyrKw1agFyUJacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZUUUUU=

Based on 7.1-rc7, tested with stress-ng, successfully passed
the 10-hours stress testing suite, and UnixBench benchmarking
shows a steady performance lift across all core counts.

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
 arch/loongarch/kernel/traps.c                 |  8 +++++
 arch/loongarch/net/bpf_jit.c                  | 26 ++++++++++++++++
 17 files changed, 114 insertions(+), 38 deletions(-)
 create mode 100644 arch/loongarch/include/asm/current.h

-- 
2.42.0

