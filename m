Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8E2BF002;
	Tue, 21 Jul 2026 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784606792; cv=none; b=XDDyrc9o6DhIFkyOOdyCf/039Gs3qmak3vetLtPU6HxdSejkf30qx3l+wK7iYN/X7u6KKOso4abB4J2mpgAniSUzURW0n4lWic+XZqXCPeOxygAqhPTdfikCA+W4WfR0V36knX0bYRHKS9dh64mDsH5vgQm81L6BbAiFcml4y4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784606792; c=relaxed/simple;
	bh=3cMuXraz/y//OYD6ETLi905neoFCvctNXnc/KoR4IbE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aU4OkCdhiFPGgyFb2YAKiAqzsnvWMr0TvHB4jRzw/thXZwoKo44RUu7GbrsUxzc1FEWyCxsKbjiJ9UClHeIZOF7zUi6RAUlRPWLlRMbA04O5uzgUj3K4z6VD33MN4lZ2IP9qM9Y0w8868SmLM7RgVwyEN3I+ZJ0KGkFIILZ6rkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h43hb6spGzYQtjN;
	Tue, 21 Jul 2026 12:05:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id A0D8F4076C;
	Tue, 21 Jul 2026 12:06:18 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAHF3M58F5qwav1Bw--.64145S2;
	Tue, 21 Jul 2026 12:06:18 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Amery Hung <ameryhung@gmail.com>
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
Subject: [PATCH bpf v5 0/4] Fixes for bpf link update
Date: Tue, 21 Jul 2026 04:10:44 +0000
Message-Id: <20260721041048.1394085-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHF3M58F5qwav1Bw--.64145S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4kGFW3ZF4fury7tw45GFg_yoW8WF4xpF
	W3ur15Ww18Kr4IvrsxGw109r15Jan5GF1UGFnrGw1rAF4YvF1j93yI9r4rZry3ZasrKa4j
	qw1agFWvk34UZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

This patch series addresses a few concurrency UAF issues within bpf link update.

v5:
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

 kernel/bpf/cgroup.c        | 44 +++++++++++++++++++++++++++++++++++++-
 kernel/bpf/mprog.c         | 13 ++++++-----
 kernel/bpf/net_namespace.c | 14 +++++++-----
 kernel/bpf/syscall.c       | 21 ++++++++++++++----
 4 files changed, 77 insertions(+), 15 deletions(-)

-- 
2.34.1

