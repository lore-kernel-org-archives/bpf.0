Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EC11A3166;
	Sat, 11 Jul 2026 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747483; cv=none; b=NIy2xRmzIMXklHGFkfaaw4MgArwKq09dyF9fNkVsnmNE2miajEvKyFKHBHJ+72Dykt/J3YUFBeij3kURGAiFegiYSg5MNv14YzURou+7c0SQz6KH+rdy2cDPGOhXEpBD16CpcHDpCP9wMx6gjGCb6L8tNEFoT9+Gi9g1PJVNVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747483; c=relaxed/simple;
	bh=AoZJsJe0xCythpOXoYDKY/IgC3z9iaoeTFbCUHxfyMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Byk6nGY1kPUxnHzde47qBHSM1WLVrj7W7PSIU+5TmDQidsq05c1Uj73VUiKSFJfAQ75zlHOjZIj38Qy8YLdwjxrLln8wKo9ktXHz5bjxTff6nULWLVJTX1yk7BIktx6MPnHLYN01/Enx2IrFlShW5N06mgRdtS8tfVzdVj1OGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gxxvZ2h5kzKHLwm;
	Sat, 11 Jul 2026 13:24:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B094440592;
	Sat, 11 Jul 2026 13:24:35 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBndnKS01FqF1tCAw--.37295S2;
	Sat, 11 Jul 2026 13:24:35 +0800 (CST)
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
Subject: [PATCH bpf-next 0/2] bpf: Eliminate unnecessary clone/restore due to constants blinding
Date: Sat, 11 Jul 2026 13:23:10 +0000
Message-ID: <cover.1783775928.git.xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBndnKS01FqF1tCAw--.37295S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1fAFW3GF1kKrWxZFW5Wrg_yoW8Xr1rpF
	93Gw1ayF4DJFy3Wr17Aw4Ikr4Sgr4rWwnrtF15K3y8XrnF9r97AF42g3WrZFy3JrZ7Zw10
	qr40q34DCwsruaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_
	JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr
	0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v
	6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjxUIhSdDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

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

Xu Kuohai (2):
  bpf: Eliminate dup/restore of insn_aux_data
  bpf: Remove unnecessary dup/restore subprog_starts and prog clone

 include/linux/bpf_verifier.h |   1 +
 include/linux/filter.h       |  22 ++-----
 kernel/bpf/core.c            | 120 +++++++++++++++++------------------
 kernel/bpf/fixups.c          |  68 ++++++--------------
 kernel/bpf/verifier.c        |   4 +-
 5 files changed, 86 insertions(+), 129 deletions(-)

-- 
2.43.0

