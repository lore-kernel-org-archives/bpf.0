Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1217F37BE7C;
	Sat, 30 May 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137332; cv=none; b=ZasnYEoStwhLMPGUnEKoOzs8sgNNI3gyMliEomcxJzBpnbcz8U4LYOUk4NfEEaegj7G6jgEpj+Mist4QA8s3UgxQzoCimmbuks6lujSeRgz36SdPeznHTZ3MNYYU6RvHpZfraawBov8Owxm0Hb0JbHD7Ns2VIY7cQ8o1TNJFg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137332; c=relaxed/simple;
	bh=GZaJdgEzYC2NW1K/0HyhrZ+l8xcpwGD00PAfQW4h1ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPPZ5u7EccKySTGfj7lEVo/gvkXRXdsaKLJl6nXU/Cb/aU81ryrJU1L1ftQDE9gkfzNO5d3xyDiNll5kEyOt02aX7O/UDwv4eQNukuHFXyVVDiyy+K7Q7uNZ1gbNcFsD+W5RKVNy+m5JG6MPbyMutzIGZ9sjMsaX2FqTNRKV5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gSGmv6XMVzYQttN;
	Sat, 30 May 2026 18:34:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 38D554058C;
	Sat, 30 May 2026 18:35:25 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP4 (Coremail) with SMTP id gCh0CgCXrFhpvRpqo6izEA--.19629S2;
	Sat, 30 May 2026 18:35:23 +0800 (CST)
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
Subject: [PATCH bpf 0/3] Add validation for bpf_set_retval helper
Date: Sat, 30 May 2026 10:12:36 +0000
Message-ID: <20260530101239.590395-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXrFhpvRpqo6izEA--.19629S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyfCr4fGF4kZF47AF4ruFg_yoW8Aw15pF
	Z3Jry5tas29F47Jr4fGayDuF4rCa1vgr1fZrn3Xw13AanxtryUJr4I9r43Wr13tF9rZryY
	v3WagFZxCa4UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

v3:
- Mark R1 as precise to prevent validation bypass via branch pruning (sashiko)

v2: https://lore.kernel.org/bpf/20260530055557.549474-1-xukuohai@huaweicloud.com/
- Extend validation from LSM cgroup BPF type to all cgroup BPF types (sashiko)

v1: https://lore.kernel.org/bpf/20260523085806.417723-1-xukuohai@huaweicloud.com/

Xu Kuohai (3):
  bpf: Add validation for bpf_set_retval argument
  selftests/bpf: Fix cgroup bpf tests broken by bpf_set_retval
    validation
  selftests/bpf: Add tests for bpf_set_retval validation

 kernel/bpf/verifier.c                         |  25 ++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/cgroup_getset_retval_hooks.c    |   6 +-
 .../selftests/bpf/progs/sk_bypass_prot_mem.c  |   2 +
 .../selftests/bpf/progs/verifier_cgroup.c     | 114 ++++++++++++++++++
 5 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cgroup.c

-- 
2.43.0

