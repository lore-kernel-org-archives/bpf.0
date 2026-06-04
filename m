Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7E47D928;
	Thu,  4 Jun 2026 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579690; cv=none; b=nRN0lDNMP1NEzcwVGoCAgFophqa8uNavSHqf6DHtsqgmYG9fNx5Q7A91tGMo+KYm4AMKNfBi3WNxBAtoyJ+334CjXvu2NYONALAo1hKd00uypCoWS0K2/3DgofnND33dphlwtXY0tGeX+qN/k61hCypkQc6PSSGHs+j6Yayf4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579690; c=relaxed/simple;
	bh=3xL+xXvz+ujIGbdFSG9WKF70uk+vMmJ+p99LnzcmWck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCSM4VztroEUwACJ5MPKySTroZu7adOZ0221iGeAh4Ro03DKIiMGqo2za0cucY/jdc0+crA29gqnYyrvIbQCmWJPk9/1JlG/urK3B3ISCbRK9RhWX64bwjdN0Npe4PPfUOeDJ6cNB6eEJDMvKWZyCbmRK0tvSJzYlYIwfSRGw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gWQNK0YY7zKHMWZ;
	Thu,  4 Jun 2026 21:27:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9949840592;
	Thu,  4 Jun 2026 21:27:56 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP2 (Coremail) with SMTP id Syh0CgCH_oNZfSFqyEtmAg--.28555S2;
	Thu, 04 Jun 2026 21:27:54 +0800 (CST)
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
	Stanislav Fomichev <sdf@fomichev.me>,
	YiFei Zhu <zhuyifei@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH bpf v4 0/3] Add validation for bpf_set_retval helper
Date: Thu,  4 Jun 2026 13:04:55 +0000
Message-ID: <20260604130458.617765-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCH_oNZfSFqyEtmAg--.28555S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfWFyrZFykKFy8Kw17Jrb_yoW8tFyUpa
	yfJr9xt3sF9F47Wr4fG3yDuF1fCw4vgr45Zrn3Xw13AanxKryDJr4I9r4ag34ayr9rury5
	uF1a9FZ3Ca4UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The bpf_set_retval() helper is used by cgroup BPF programs to set the
return value of the kernel hook. The argument type for this helper is
ARG_ANYTHING. This allows setting a positive value, which no cgroup
hook expects and can cause issues, such as the kernel panic reported
in [1].

This series adds validation for the argument of the bpf_set_retval()
helper.

For BPF_LSM_CGROUP, the same validation as BPF_LSM_MAC is enforced,
i.e. validate the argument against the LSM hook specific range, which
is returned by bpf_lsm_get_retval_range().

For all other cgroup program types, restrict the argument to
[-MAX_ERRNO, 0], which matches the kernel convention of 0 for success
and negative errno for error.

BPF_CGROUP_GETSOCKOPT is an exception from this restriction, since valid
getsockopt implementations may return positive values (e.g. optlen), as
allowed by commit c4dcfdd406aa ("bpf: Move getsockopt retval to struct
bpf_cg_run_ctx").

[1] https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn

v4:
- Remove the return value limit for BPF_CGROUP_GETSOCKOPT type
- Refine the range of return value of bpf_get_retval helper

v3: https://lore.kernel.org/bpf/20260530101239.590395-1-xukuohai@huaweicloud.com/
- Mark R1 as precise to prevent validation bypass via branch pruning (sashiko)

v2: https://lore.kernel.org/bpf/20260530055557.549474-1-xukuohai@huaweicloud.com/
- Extend validation from LSM cgroup BPF type to all cgroup BPF types (sashiko)

v1: https://lore.kernel.org/bpf/20260523085806.417723-1-xukuohai@huaweicloud.com/

Xu Kuohai (3):
  selftests/bpf: Restrict bpf_set_retval argument in sk_bypass_prot_mem
  bpf: Add validation for bpf_set_retval argument
  selftests/bpf: Add tests for bpf_set_retval validation

 kernel/bpf/verifier.c                         |  54 +++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/sk_bypass_prot_mem.c  |   2 +
 .../selftests/bpf/progs/verifier_set_retval.c | 107 ++++++++++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_set_retval.c

-- 
2.47.3

