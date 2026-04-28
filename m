Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11C4964F;
	Tue, 28 Apr 2026 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363270; cv=none; b=D/zTlfLrhaHX6bo0EPZcwcUwXf62TPAmMQgUoLdf/+zXMa30u/GXhc9qxuVuMzxlTtUu2g3O9HNByw3I0EJY/QnJNIvzKB7yjPBirkzIp6Lp3PQW1kAf4O3KxZb8gdrcWdgVt5qB0hYEV7yGBBq/1wi89IReVsO6VaiGc1yQbAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363270; c=relaxed/simple;
	bh=FieUpwOBR8HtTCGeu/pw06K9Hj31waF0WzfGpHA1Y5I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OsvM5duGzJ3dYh8Y3X4CiG/yQQZ5jOTlgP0e2pgT2YXKyaKh1eFEczg6ILg1x8rDbng701tNGkOyZofkSMZCXqSkfH0WrqzgZgMWokQXWo7CrZVQaHNaIjQDlO7qxXHc+uK41os5yuKkCvk2Q85l/oX/za+tYWQHFME0S4gWi44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx3ek4afBpDa0EAA--.15438S3;
	Tue, 28 Apr 2026 16:00:57 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAx38I1afBpmWt2AA--.27930S2;
	Tue, 28 Apr 2026 16:00:54 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 0/3] selftests/bpf: Test inline helpers for LoongArch
Date: Tue, 28 Apr 2026 16:00:48 +0800
Message-ID: <20260428080051.20938-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx38I1afBpmWt2AA--.27930S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtF4fJFy5tFyfXr1rGr18Xrc_yoW3XFgEvr
	40yrykJayUZFn0yFy2gFn5urZ8tayYgrZxAr1kWryIkw45Xr15JFWvgFyav347WrZYqrZI
	yF4kAa4vyr45WosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UiiSdUUUUU=

The arch-specified kernel code is still in the pipeline [1], but
I think it can submit these testcases within the same development
cycle. At the very least, it does not introduce any regressions.

[1] https://lore.kernel.org/lkml/20260428072021.7289-1-yangtiezhu@loongson.cn/

Tiezhu Yang (3):
  selftests/bpf: Add __arch_loongarch macro to limit test cases
  selftests/bpf: Test inline_bpf_get_current_task() for LoongArch
  selftests/bpf: Test jited inline of bpf_get_smp_processor_id()

 tools/testing/selftests/bpf/progs/bpf_misc.h        |  1 +
 .../selftests/bpf/progs/verifier_jit_inline.c       | 13 +++++++++++++
 tools/testing/selftests/bpf/test_loader.c           |  5 +++++
 3 files changed, 19 insertions(+)

-- 
2.42.0

