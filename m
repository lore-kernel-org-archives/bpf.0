Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C179D3A9D9B;
	Mon,  6 Jul 2026 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783309155; cv=none; b=WrjWfgX5HRN79OnEWsbT7n5GBDN96CXfpTlNaZ5cnqhflVqwk9s5cfArpPGyx+U2VL4ZOkHQIUy7pabaVNErITa7BxPyJJXCb5H8QzN30v/JV6OtwBtWHl89TuFYWtclbLCKZvPougrwbSzGsWIiPbU1zdlE9fkX9NR0e+WcsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783309155; c=relaxed/simple;
	bh=PH77AhTUJx3zvGAbs2xGTdjsLN+bCJb7FSnkmuPeyuM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/r+JMlDnwLwV832BRZweTLzkmPTsNIK8PX3tKtuxYlHwQ7+PQarLYc1hTuNeE/cqCRpyr5UvolmU7zevOoiKU6Dku85t3L085+vKzAQxZeGn+BcEAwNDMNgNw1Npz4CYyCmr7MDg/iopcd0wJLiSxpYDxmcEwj1rkLiMucAlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx5+pdI0tqU0QAAA--.1299S3;
	Mon, 06 Jul 2026 11:39:10 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx3cZbI0tq3LoBAA--.10774S2;
	Mon, 06 Jul 2026 11:39:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Optimize BPF tailcall for LoongArch
Date: Mon,  6 Jul 2026 11:39:02 +0800
Message-ID: <20260706033906.1988-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx3cZbI0tq3LoBAA--.10774S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw43CF1xuw4xCFyfXFW7Jrc_yoWkXwb_ua
	4xtaykGw4UXFW7CF129F1fZr97Cayj9FyUGrWvqrWku3y3AF1DZr4kWrW09wsFgrZxKr90
	y39F93yxZr1a9osvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb3kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWU
	XVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x07j5GYJUUUUU=

Based on 7.2-rc1, tested on a Loongson-3A6000 physical machine.

This version addresses the review comments of AI, changes are isolated
to patch 3/4, the rest of the series remains unchanged.

v1 -> v2:
- [Patch 3/4] Use ctx->image to inject a safe dummy offset during
  Pass 1, safely bypassing the 16-bit signed immediate range check.
- [Patch 3/4] Update the commit message to reflect the new code.

Here are the test results:

  $ sudo modprobe test_bpf test_suite=test_tail_calls
  $ dmesg -t | tail -1
  test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]

  $ sudo ./test_progs -t tailcalls | tail -1
  Summary: 1/37 PASSED, 0 SKIPPED, 0 FAILED

Tiezhu Yang (4):
  LoongArch: BPF: Optimize redundant TCC loads in epilogue
  LoongArch: BPF: Move arena register slot below TCC context
  LoongArch: BPF: Refactor jump offset calculation in tail call
  LoongArch: BPF: Implement branchless conditional move for TCC

 arch/loongarch/include/asm/inst.h |   6 ++
 arch/loongarch/net/bpf_jit.c      | 112 +++++++++++++++---------------
 2 files changed, 63 insertions(+), 55 deletions(-)

-- 
2.42.0

