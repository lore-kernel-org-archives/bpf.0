Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5242668B;
	Mon, 20 Jul 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554889; cv=none; b=s7ABERt8Kj0RO7KO1OmeRNlNSXBY8cNOdvxsl7k8gGcWzOaQedcYgOMH6Iu9vJZ5WFhPc8mtehruXvFXRrHHZE5CmFGcwKkqZpDJQIOPFHhYqtNAcdC6pmrIqTi8/NdDKrLbSI5UXqdTctYI2hX0mRzDhtJ40Q3TiqQ3hf+uzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554889; c=relaxed/simple;
	bh=SiLXOl3RxbSLlZm+ORSzeCsWdkP2WPNPCACgh2HE+wU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pi48hTrFWXCVM0QaGLlXruurjMeO2o6YlCKxroJV9/YRd7vRA3w3Ht7/TlcXyxH0Y+ePWeru6I9urxGBiX/hFaKdBx1zLiB59yJq7xlslqGgpe46C2lOyZCSNZzxC1ytEPOurOHsswoq8tmxcbHE4/WLlZLVe/BDZJRl5MZTFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h3hVX2xk8zYQtxT;
	Mon, 20 Jul 2026 21:40:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 17CF24056E;
	Mon, 20 Jul 2026 21:41:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDn9XF8JV5qIAesBw--.40451S2;
	Mon, 20 Jul 2026 21:41:17 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v4 0/4] Fixes for bpf link update
Date: Mon, 20 Jul 2026 13:45:43 +0000
Message-Id: <20260720134547.1289964-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn9XF8JV5qIAesBw--.40451S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryUXrW7GrW3tryxKF4xtFb_yoW8GF4kpF
	43Zr15Xw1UKrWIqrsxGw429r15Xan5JF1UWFnrGw1FyF4jyF10934I9r1rZFy3ZF9rKa4j
	qw1agFWrKryjvwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

This patch series addresses a few concurrency UAF issues within bpf link update.

v4:
- Add new fix for UAF due to missing link type check in mprog. (Sashiko)
- Add new fix for UAF in bpf_netns_link_update_prog. (Sashiko)
- Include the storage and flags rollbacks to patch4 for sake of code rigor,
  as it's hard to make update_effective_progs fail in __cgroup_bpf_attach.

v3: https://lore.kernel.org/bpf/20260720033055.1215477-1-pulehui@huaweicloud.com
- Add new fix for UAF issue when reading bpf link info. (Sashiko)
- Add new fix for storage not restored when update_effective_progs
  failed. (Sashiko)

v2: https://lore.kernel.org/bpf/20260717073343.958862-1-pulehui@huaweicloud.com
- Fix invalid access for in-place update when storage changed. (Sashiko)

v1: https://lore.kernel.org/bpf/20260714014659.401063-1-pulehui@huaweicloud.com

Pu Lehui (4):
  bpf: Fix potential UAF in bpf_netns_link_update_prog
  bpf: Fix UAF due to missing link type check in mprog
  bpf: Fix potential UAF when reading bpf link info
  bpf, cgroup: Fix storage null-ptr-deref after replacing prog

 kernel/bpf/cgroup.c        | 44 +++++++++++++++++++++++++++++++++++++-
 kernel/bpf/mprog.c         | 15 ++++++++-----
 kernel/bpf/net_namespace.c | 14 +++++++-----
 kernel/bpf/syscall.c       | 27 +++++++++++++++++++----
 4 files changed, 85 insertions(+), 15 deletions(-)

-- 
2.34.1

