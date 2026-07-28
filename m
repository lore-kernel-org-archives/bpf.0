Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456843634A;
	Tue, 28 Jul 2026 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241686; cv=none; b=gnI5eGEWyuPIsZghIdjFuYXd4EXckVIe1o7vXRewrwC7OW/W3Xx389iTkFQ8QBmZHmp4vkDKKcCB2O+UiJN94pbkQ+qbccyz+s+aPJ2IUknqT/ds18QlH10DF24sswZGQVFy1AuHHu58E00mMEfq2G4BsoRWfhbACpG226mjBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241686; c=relaxed/simple;
	bh=ottuM6Bbi1T2E42uT05V9SSRubMnzC0Mc00qtROYwh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQs+wDbkVgBiUpt90rMfAVTTaKO+mUWJ9RRsoZdbBRW+9Si646SBqYvFibrQrMjRIMbo43YGo+iMk823RXlFUjb3lOfYMY+tvY6EughNjFvArNQNlZ0H6DhRdTmEM9OlZ1AuFaXoFw9YPLUD1mII0+0DEsZNOwcTips149iqffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h8ZTk2mYhzKHMrp;
	Tue, 28 Jul 2026 20:27:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C78C3405A0;
	Tue, 28 Jul 2026 20:27:59 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDHtUROoGhqdIMFAQ--.41491S2;
	Tue, 28 Jul 2026 20:27:59 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Eliminate unnecessary clone/restore due to constants blinding
Date: Tue, 28 Jul 2026 20:25:48 +0000
Message-ID: <cover.1785240296.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHtUROoGhqdIMFAQ--.41491S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3tFW8ArWxtr4kAF4Utwb_yoW8WFy8pF
	93Gw1akr4qvrnxWr47Gw42kr4Sgw4rWr17JF17K3y8XrnF9r97CFWIgw4rZFy3JrWkZw10
	qr40v3sYkw4Uu3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_
	Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr
	1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v
	6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU08Oz3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

This series eliminates the unnecessary clone/restore overhead
introduced by patch d3e945223e0158c8 ("bpf: Move constants blinding
out of arch-specific JITs"), which moved constants blinding from JIT
code to general verifier code, and added env->insn_aux_data and subprog
starts duplication and restoration around constants blinding operations
to resolve the inconsistency between the metadata and instruction arrays.

Patch 1 eliminates the insn_aux_data duplication/restore. After JIT
failure, bpf_clear_insn_aux_data() is the only function that requires
insnsi and insn_aux_data to stay in sync as it accesses them using the
same size and index. However, the insnsi access is unnecessary as it is
checked to skip the second slot of an ldimm64 instruction which can be
absorbed into the jt check itself, so removing it eliminates the need
for the duplication/restore.

Patch 2 eliminates the prog clone and subprog duplication/restore
when the interpreter fallback is not available on JIT failure.

v2:
- Address UAF in bpf_fixup_call_args() (sashiko)

v1: https://lore.kernel.org/bpf/cover.1783775928.git.xukuohai@huaweicloud.com/

Xu Kuohai (2):
  bpf: Eliminate dup/restore of insn_aux_data
  bpf: Remove unnecessary dup/restore subprog_starts and prog clone

 include/linux/bpf_verifier.h |   1 +
 include/linux/filter.h       |  22 ++-----
 kernel/bpf/core.c            | 120 +++++++++++++++++------------------
 kernel/bpf/fixups.c          |  73 ++++++---------------
 kernel/bpf/verifier.c        |   4 +-
 5 files changed, 88 insertions(+), 132 deletions(-)

-- 
2.47.3

