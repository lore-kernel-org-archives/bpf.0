Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC439BFFF
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776683731; cv=none; b=me+OeMlk06DR2BU0c2lojIeFpjsq8g60pygFIMq+2ma3zp7QvjSztAs9X8FN6NNsRVPo//mD6g0sZj1eUTNJdosq5KI1q+0kOIj8TIAuDHzXY9TShEhdmKyyd3DLzcJAtaJGN8I754EOnWfo0UCX/5NBhlU4Aod1j5b902EhZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776683731; c=relaxed/simple;
	bh=qFtPQ6zGbQOeQ2lOBNYN3zDf9AMvxXROvLX7pZ6IxLY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cDqKR6AQ1AKRgaKS2x9HKrYfKZqLaAesDLZi5Ehfm7BE0bc2xzXMGHu0CmBw6XvLJGWuBhlsnUAgf9QZPjaxl2rxrxIiYRTDceUsb8eWVtnCCezli5MlPtxmWasMCGO+OBD25GNIxP+WpujTOxQg9mll/8rCZk76L/S4E70TOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx4erHCuZpbRUCAA--.8037S3;
	Mon, 20 Apr 2026 19:15:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxLMLFCuZp00RxAA--.17475S2;
	Mon, 20 Apr 2026 19:15:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH RFC bpf-next 0/2] selftests/bpf: Add support for get_preempt_count()
Date: Mon, 20 Apr 2026 19:15:14 +0800
Message-ID: <20260420111516.19982-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxLMLFCuZp00RxAA--.17475S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFy3CFy5Zw4UAFWkAF15KFX_yoWfWwb_uF
	Z7Ca4DGFW8CF90yFZ2q3W5ZayDJr4Iq3yrtFWUWr92q348Gr47Wa1xGF92y34fZ345GrZx
	taykJFyfCw42qosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UUUUU==

This series is based on the latest bpf-next tree.

I can not test the patch #1 on riscv due to no riscv machine, I only
tested the patch #2 with the same change on LoongArch based on the RFC
"LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK" [1], it works well.

I think the patch #1 is right for riscv in theory, because it supports
CONFIG_THREAD_INFO_IN_TASK and there is member preempt_count in struct
thread_info. I hope someone from riscv side can help test this patch.
If no, I will try to test. Thanks in advance.

[1] https://lore.kernel.org/loongarch/20260420102907.4617-1-yangtiezhu@loongson.cn/

Tiezhu Yang (2):
  selftests/bpf: Add riscv support for get_preempt_count()
  selftests/bpf: Add LoongArch support for get_preempt_count()

 tools/testing/selftests/bpf/bpf_experimental.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

-- 
2.42.0

