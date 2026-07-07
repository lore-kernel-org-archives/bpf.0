Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198723DA7F8;
	Tue,  7 Jul 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419314; cv=none; b=RnIQGbNfU+1k/8Ng0fEFN/wyY2f2plA7IBU3KT2Y/WQmbGQtP+rynWDQgi/Us77cCf02PVde2XqDNoNZMZwNHSK6my5nlYcemfPnjcBuxd+onEMAlKVTe0gUhtX44Jenzk1XRnED8w22wRXmuhM3Z0HDfU3G2bR0NUAdhfh1kYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419314; c=relaxed/simple;
	bh=ztcGHIlmt8DZ8BUFAWSdk9147a815dNElBMb/vBgniY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CaEOrw6AMoZXLtAO4aEv8YN4bf6M5+EYb14tOcTbCeIuH0VC4ftbHwu891qnX+HNYC4uB3+OEIoYHvJHQilNJvXWvi2YFaiCvH+v32eEK+iQ+guerJoPlS2DFaSyE6cW1YFJWDERJ5heenZrKjkad0/d37ueTzNSNummeU1+KOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxquut0Uxq2uAAAA--.3857S3;
	Tue, 07 Jul 2026 18:15:09 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxIuSs0UxqL8kDAA--.22379S2;
	Tue, 07 Jul 2026 18:15:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Fix and optimize BPF tailcall for LoongArch
Date: Tue,  7 Jul 2026 18:15:04 +0800
Message-ID: <20260707101508.32283-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxIuSs0UxqL8kDAA--.22379S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Wr45Kry3KF4kXw4fGF1xWFX_yoWDAFcE9a
	4xtaykJ3yUuayayF1Ygrs3ZrZ7CrW8tFyUGrWqqr47Aw13Ar1DZF4kJw4Uuw4vgrZ8Kry5
	tr4UurW0yrnIvosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

Based on 7.2-rc2, tested on a Loongson-3A6000 physical machine.

Here are the test results:

  $ sudo modprobe test_bpf test_suite=test_tail_calls
  $ dmesg -t | tail -1
  test_bpf: test_tail_calls: Summary: 10 PASSED, 0 FAILED, [10/10 JIT'ed]

  $ sudo ./test_progs -t tailcalls | tail -1
  Summary: 1/37 PASSED, 0 SKIPPED, 0 FAILED

v2 -> v3:
  -- Patch 1: Add Fixes tag.
  -- Patch 2: Update the commit message and add Fixes tag.
  -- Patch 3: Update the commit message and add Fixes tag.
  -- Patch 4: Condense the code comments and update the commit message.

No code changes.

Tiezhu Yang (4):
  LoongArch: BPF: Optimize redundant TCC loads in epilogue
  LoongArch: BPF: Move arena register slot below TCC context
  LoongArch: BPF: Refactor jump offset calculation in tail call
  LoongArch: BPF: Implement branchless conditional move for TCC

 arch/loongarch/include/asm/inst.h |  6 +++
 arch/loongarch/net/bpf_jit.c      | 85 +++++++++++--------------------
 2 files changed, 36 insertions(+), 55 deletions(-)

-- 
2.42.0

