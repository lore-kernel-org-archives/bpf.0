Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1853A6EE9;
	Mon,  8 Jun 2026 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914927; cv=none; b=o07QhB0o2F7NS8Tc+WFiXNKxoG9YTi/5DZCqpmGbOJgOf2CA77/5fFzBWjSZTkVxv0H5g6eVERXeQhJtz3/OQYIRum88eDyknsNQ8Fk811/v1MBLA9vwPzZwaqQbQ8wZgYuyT2cz42Eg0xv896IBjsvgEVh8x5yOCgGf3sv7PlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914927; c=relaxed/simple;
	bh=USjb7Tbsrh4MH7ZWDfykE81K39Hoa+48mu863rrvlLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2o8mUynIo+tCb0mH8alN8jPGjOpbWCwTSuYXmKZMg1J7ST+Hqm60lk7JX5gG0Zih/J25/EvbRJIWN/TH8o9z9gdGhzc8o5ctqTXauraNxxAT4VVeR/ecqdS68Dmosv5q990GdQaRwdLL4amrRkfl1VlVdeIqHxR3u7/+extOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxEuvomiZq6skRAA--.47771S3;
	Mon, 08 Jun 2026 18:35:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxSeDlmiZqLqafAA--.40549S2;
	Mon, 08 Jun 2026 18:35:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Move thread_info into task_struct for LoongArch
Date: Mon,  8 Jun 2026 18:35:13 +0800
Message-ID: <20260608103516.20643-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxSeDlmiZqLqafAA--.40549S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1DArW3JFWDuFWkXw1UArc_yoW8Ww15pF
	ZFv39xGrW8Gr93Aw1ay34Durn8Jw1vgw12g3ZFy34xCw43XF1UXr18Grn8XF98tw40qry0
	gF1rKwn0ga4UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=

This is a formal patch series, based on 7.1-rc7, addressed all
the review comments, tested with stress-ng, successfully passed
the 3-hours stress testing suite.

stress-ng --context $(nproc) --timeout 30m --metrics-brief
stress-ng --sysbadaddr $(nproc) --timeout 30m
stress-ng --fault $(nproc) --timeout 30m
stress-ng --pthread $(nproc) --timeout 30m
stress-ng --schedmix $(nproc) --yield $(nproc) --timeout 60m --metrics

Additionally, UnixBench benchmarking shows a steady performance
lift across all core counts.

Tiezhu Yang (3):
  LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
  LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers
  LoongArch: BPF: Inline bpf_get_smp_processor_id() helper

 .../core/thread-info-in-task/arch-support.txt |  2 +-
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/include/asm/current.h          | 30 +++++++++++++++++++
 arch/loongarch/include/asm/smp.h              |  3 +-
 arch/loongarch/include/asm/stackframe.h       |  9 ++++--
 arch/loongarch/include/asm/switch_to.h        |  6 ++--
 arch/loongarch/include/asm/thread_info.h      | 10 -------
 arch/loongarch/kernel/asm-offsets.c           |  6 ++--
 arch/loongarch/kernel/entry.S                 |  7 +++--
 arch/loongarch/kernel/head.S                  | 18 ++++++-----
 arch/loongarch/kernel/process.c               |  3 ++
 arch/loongarch/kernel/relocate.c              |  2 +-
 arch/loongarch/kernel/setup.c                 |  1 +
 arch/loongarch/kernel/smp.c                   |  6 ++--
 arch/loongarch/kernel/switch.S                | 13 ++++----
 arch/loongarch/net/bpf_jit.c                  | 26 ++++++++++++++++
 16 files changed, 105 insertions(+), 38 deletions(-)
 create mode 100644 arch/loongarch/include/asm/current.h

-- 
2.42.0

