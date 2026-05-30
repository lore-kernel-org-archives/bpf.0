Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E682EA173;
	Sat, 30 May 2026 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780121931; cv=none; b=rb7x9A8HJCZa285LppHpwh8M/Q+Urs+iVSUqRF3ekhJjEvxvIu3KdBuXLDWrsIgXdyV1vMMWktbrLNs2VIOVJ7aCjZTwSCIKC8gJsrymKoRBHgU3uuG/wL79j8ICD9BvTHsrXgn3Txro90+YlIFWFHPxIUg3zm8dTZtqzqvn0jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780121931; c=relaxed/simple;
	bh=UpSPt6Bi16HD8cafM0SI0polEBfu0O8m12tvC5Pp4nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEc0NG/UZP7Bq59nX+PTWEAVMyj6yWGZ6sVJUgZgQny0Z7XO2Amv8ysP3nhUo3Xab+U1id+I6/Gs3uYRyNor+8HF3pZL+9gF8f1mFab+5uN1YhFjAOthg89UjGLbT6DDzpPqd2u357CVgRdlgP3f6sioAT31menadZAECQBrS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gS94g64PHzYQtp6;
	Sat, 30 May 2026 14:17:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D2C4540561;
	Sat, 30 May 2026 14:18:40 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgDnr1s8gRpqNcqdEA--.3341S2;
	Sat, 30 May 2026 14:18:38 +0800 (CST)
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
Subject: [PATCH bpf v2 0/3] Add validation for bpf_set_retval helper
Date: Sat, 30 May 2026 05:55:54 +0000
Message-ID: <20260530055557.549474-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnr1s8gRpqNcqdEA--.3341S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfWFyrZFykKFy8Kw17Jrb_yoW8WFy5pa
	93Gr98tas29F47GF4fGayq9F4rCa1vgr45urn3Xw13AanxJryUJw1Igr4agr9xtF9rZryY
	v3Wa9F93Ca4UAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
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

[1] https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn

v2:
- Extend validation from LSM cgroup BPF type to all cgroup BPF types

v1: https://lore.kernel.org/bpf/20260523085806.417723-1-xukuohai@huaweicloud.com/

Xu Kuohai (3):
  bpf: Add validation for bpf_set_retval argument
  selftests/bpf: Fix cgroup bpf tests broken by bpf_set_retval
    validation
  selftests/bpf: Add tests for bpf_set_retval validation

 kernel/bpf/verifier.c                         | 21 +++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/cgroup_getset_retval_hooks.c    |  6 +-
 .../selftests/bpf/progs/sk_bypass_prot_mem.c  |  2 +
 .../selftests/bpf/progs/verifier_cgroup.c     | 87 +++++++++++++++++++
 5 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup.c

-- 
2.43.0

