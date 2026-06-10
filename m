Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726E4406825;
	Wed, 10 Jun 2026 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093894; cv=none; b=Nzbv2uQ1Xf7xtHSRduxtSM7TgJpn5K1kVj4WWek+ekieYuK8cMc++RPwK7SIO938WmWfEbiiXSYsFV16xrwyOT4f68/CSGDvVZ4jIGMRSZ4ihRZvgGCa0D0uZV1+ZFbQQH/M1x7HyoX1VI9dVfx4zhZE8saoNaJy0YBOFYPrEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093894; c=relaxed/simple;
	bh=jqhrZgNZ1OLogk8SLxUworo9k/b7NA6PR2w9gMLmZcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WiCqSEezP3XhuZBJQJIK3WtXqSjACjx5WHimdXiiMIuJWkWSZ6OpQEXqH6RKv6oyIOi+mUC20Ot4Akjgo4bVqwwbEcTOIIW1sZMhpcmRf13LlidzuypBgSG31s2JK/LUF7Eu+WM/THbep5DAGWDWHrDifLt9tPZp9chO7jYa4NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gb4Y62dvqzYQtvb;
	Wed, 10 Jun 2026 20:17:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E0A2540561;
	Wed, 10 Jun 2026 20:18:04 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with SMTP id cCh0CgAXZzz5VSlqXFgyBQ--.57310S2;
	Wed, 10 Jun 2026 20:18:02 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Matt Bobrowski <mattbobrowski@google.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 0/2] bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno
Date: Wed, 10 Jun 2026 20:17:22 +0000
Message-ID: <20260610201724.733943-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXZzz5VSlqXFgyBQ--.57310S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWfZFy8CF1rZF1rJr4DXFb_yoWDuFg_C3
	yUAry8Gr97A3WUKayqgrsxKrZrG3yrJFy5AayDJrnIgFy5Gr45XF4kGF98WFy8ZF4rJ39r
	GF93u34Ivw4qqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY
	1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jIKZXUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

This series fixes the issue reported by sashiko in [1]. The issue is that,
when a cgroup BPF program exits with 0, bpf_prog_run_array_cg() sets
the hook return value to -EPERM if it is not a valid errno. This is
correct for errno-based hooks, which return 0 on success and negative
errno on failure, but wrong for void and boolean LSM hooks. Boolean
LSM hooks should only return true or false, and void LSM hooks have
no return value at all.

Fix it by skipping setting -EPERM for hooks not returning errno.

[1] https://lore.kernel.org/bpf/20260605144232.95A141F00893@smtp.kernel.org/

Xu Kuohai (2):
  bpf: Fix setting retval to -EPERM for cgroup hooks not returning errno
  selftests/bpf: Add retval test for bool and errno LSM cgroup hooks

 include/linux/bpf_lsm.h                       |  6 ++
 kernel/bpf/bpf_lsm.c                          | 20 +++++
 kernel/bpf/cgroup.c                           | 47 ++++++++---
 .../selftests/bpf/prog_tests/lsm_cgroup.c     | 79 +++++++++++++++++++
 .../testing/selftests/bpf/progs/lsm_cgroup.c  | 30 +++++++
 5 files changed, 169 insertions(+), 13 deletions(-)

-- 
2.43.0

