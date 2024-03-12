Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F77E2
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206398; cv=none; b=fNY9oTOZ89bt8i1fLYn1VLyklmE9u9x28UigzZ/1pwndvdSo+fhY4YahMo+THrCTC+iicqQVSlE/18Vlv+LYVCNbcQKTQ+xWo3ofYAVX1lxDimYAoW/K9Ht7EP3b/BTxcg1a+zeY6/UD1Bt9L3GZjeFl1ZTFu7p70z/7kXJPWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206398; c=relaxed/simple;
	bh=dI0riwDfoP61JeTNTpT0U0KvhVTd9kh4zS5y45KzRKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+0LDi2uHMip6JqNBw6Ss4dTe8mSRstvQH3BSw4o0lsN8Pto/3hwG2yPSuRwh4dV9fsZKYW7B9l/zWkoXklMHYFbPWkbBvowHbz2Xw5eYPN1WcXcGux5mWx2jAF9+Z4rGPH5zyqNcYsibAR0gJW8pKDFrSBTCtxvnccFv+LmI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TtwmP3dLlz4f3jqC
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 09:19:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2B3A81A016E
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 09:19:53 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with SMTP id cCh0CgB3kgu3re9lU5K1Gg--.27799S2;
	Tue, 12 Mar 2024 09:19:52 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org
Cc: Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH v2] drivers/perf: riscv: Disable PERF_SAMPLE_BRANCH_* while not supported
Date: Tue, 12 Mar 2024 01:20:53 +0000
Message-Id: <20240312012053.1178140-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3kgu3re9lU5K1Gg--.27799S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1fCFWDJFy3Gr1rXFyftFb_yoWkZFg_Ca
	y7WrZ7KrWDJasIq3WUAw1DurW5t3y8Za4kXFn2g34fAF97Xw1Duw42vrW7t34UAr47ZF97
	Jr1DWryxXrW2gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

RISC-V perf driver does not yet support branch sampling. Although the
specification is in the works [0], it is best to disable such events
until support is available, otherwise we will get unexpected results.
Due to this reason, two riscv bpf testcases get_branch_snapshot and
perf_branches/perf_branches_hw fail.

Link: https://github.com/riscv/riscv-control-transfer-records [0]
Fixes: f5bfa23f576f ("RISC-V: Add a perf core library for pmu drivers")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 drivers/perf/riscv_pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index c78a6fd6c57f..b4efdddb2ad9 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -313,6 +313,10 @@ static int riscv_pmu_event_init(struct perf_event *event)
 	u64 event_config = 0;
 	uint64_t cmask;
 
+	/* driver does not support branch stack sampling */
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
 	hwc->flags = 0;
 	mapped_event = rvpmu->event_map(event, &event_config);
 	if (mapped_event < 0) {
-- 
2.34.1

