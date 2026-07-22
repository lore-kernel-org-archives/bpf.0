Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA3D3368AE;
	Wed, 22 Jul 2026 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704740; cv=none; b=tKjWO8mnFA2V5mm59h4JG9hszH4d7akeYLSnRza+QK2yHO0VbFHjNvIvn560e/qb5WJvKX0DgRSwwlmj5SJ7AqleR5B7Btm2JG1cZYEiOFzHxlsNy8dcfJ9Qbm5Hl98M7WGnM5sft/6ECch9uZNJPGHHcYKPtbUF1yOWmZa5IrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704740; c=relaxed/simple;
	bh=TVAiwxkPVs0wdJ5UhjUxgslZDYIRTtRfV+motjp8xdc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uval2lk3e1RV5e+4gRG9Xxw4aJUHOO6UOEc5J9ro1nec3tFrhI+W40/yEO0bzRFg++OEiie2vpN6QzZIBUZNxjEgYtUdxeCnpqlPtgDb64PTMsLYSB59Nd/mmzh0IrAhpAqsS3g8PIJVwgvVhQHFH51IJT3A/adxhdjo2YVg+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4lwL5myYzYQtt8;
	Wed, 22 Jul 2026 15:18:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6B47D4058C;
	Wed, 22 Jul 2026 15:18:55 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCHl3PfbmBqGBB_CA--.17870S2;
	Wed, 22 Jul 2026 15:18:55 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v6 0/4] Fixes for bpf link update 
Date: Wed, 22 Jul 2026 07:23:22 +0000
Message-Id: <20260722072326.1545677-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCHl3PfbmBqGBB_CA--.17870S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1kKF4UWF43KFW5Xr4Dtwb_yoW8trWkpF
	WfZr15Ww10grWaqrsxCw129ry5Jan5J3WUGFnrGw1FvF4Y9F1j9rWxur4rZFy3Zryvga4j
	qr1agF95K34jva7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUU0zuJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

This patch series addresses a few concurrency UAF issues within bpf link update.

v6:
- BPF_F_LINK flag set means the relative id_or_fd is a link, not the object being
  attached. We can not get the link while attach a bare prog with relative link.
  So passing expected link type from callers of bpf_mprog_attach/detach. (Sashiko)
- Add comment to explain that why ptype == UNSPEC in bpf_mprog_detach. (Emil)

v5: https://lore.kernel.org/bpf/20260721041048.1394085-1-pulehui@huaweicloud.com
- Remove rcu_read_lock_trace as rcu_read_unlock is sufficient. (Mykyta)
- Improve commit msg for patch 2. (Amery)
- Add Reviewed-by tag by Amery.

v4: https://lore.kernel.org/bpf/20260720134547.1289964-1-pulehui@huaweicloud.com
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

 drivers/net/netkit.c       | 13 ++++++-----
 include/linux/bpf_mprog.h  |  6 ++++--
 kernel/bpf/cgroup.c        | 44 +++++++++++++++++++++++++++++++++++++-
 kernel/bpf/mprog.c         | 23 ++++++++++++--------
 kernel/bpf/net_namespace.c | 14 +++++++-----
 kernel/bpf/syscall.c       | 21 ++++++++++++++----
 kernel/bpf/tcx.c           | 13 ++++++-----
 7 files changed, 99 insertions(+), 35 deletions(-)

-- 
2.34.1

