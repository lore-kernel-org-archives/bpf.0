Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865A3A3E98;
	Thu, 13 Aug 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616043; cv=none; b=GSnO1wZ9Ht/bEets5FwUEur/BHEMlNJdVsjE3DUa+r/DgNvv4rJsgMy6CVPGD2iFpEDjtisA7NVztrF2N+j42moKs2EusGuT30DuQ0Lo0oFNg/5qIAEjQaBqpH14V3o3o10WYePGCwxbT6JIL/WDBohMM3T27XXyE1AEpbGQACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616043; c=relaxed/simple;
	bh=4xAQ+1f1Bxn5TI6PG1laJxODQO5WLptHRyOa+YBQGqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWGE6FWO3jFwsvvSt49wJxRX+KGC+rPfH/hz0oMW+r48QmESKVxmGiYuF9wVv7/VVPCDNAa/0eA4QlOzI5UNdpqVJTacjMMJj+WMtEhU3oooLzX3Ep1sWVMfy3vxaW85FbQNY3x8qnDSUG0N878vHgRKmmsNRGMdEPtPSOa4Ikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=k5clw6g5; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="k5clw6g5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Rl
	0XR4fvs2TYUR4oHTzLrhvAqZiGuNJUIesBad1TIYI=; b=k5clw6g5EeSvfzPflH
	L2nfwkPEJbP5u7YN+j7gFhOJ/pqpDUB04ZSlW3tOF1Q6mokbio7eL2oRGbeR94WV
	VNzyPLwCp9F5oT2mxRD5qI6DbLR1bHvXw0SbH6mLlsJDM0f3phHX03iZ2h7dhPQp
	oqB7Qs+VMydKcpjXo2QuaoYdo=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn99ilmH1qvYhWPA--.62762S2;
	Thu, 13 Aug 2026 18:12:54 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH bpf] bpf: fix BPF_F_CPU validation for sparse CPU IDs
Date: Thu, 13 Aug 2026 18:12:31 +0800
Message-ID: <20260813101229.680523-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn99ilmH1qvYhWPA--.62762S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW5tF1rGw1kWFy8XF4kCrg_yoW8AFy5pF
	yvgay09rs7GryFy3y3K3yxC3W0kan5Zr42kas8K345A3yaq3WfX3s5AF1qvry5Crs5Jr4j
	gF10vFWkZayDZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjXdUUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6QZJqGp9mKbnqwAA3r

BPF_F_CPU stores the target CPU ID in the upper 32 bits of the map
operation flags. bpf_map_check_op_flags() currently compares that ID
with num_possible_cpus(), which is the number of possible CPUs rather
than a bound on CPU IDs.

On an arm64 QEMU guest with a CPU device-tree hole, the possible CPU
mask was 0,2-3. A userspace program using raw bpf() syscalls creates
a BPF_MAP_TYPE_PERCPU_ARRAY and performs update and lookup operations
for each CPU by setting BPF_F_CPU and the CPU ID in the flags.

With the old check, CPU 1 is incorrectly accepted while valid CPU 3 is
rejected with -ERANGE. The CPU 1 update then reaches the per-CPU map
access path and triggers:

  Unable to handle kernel paging request at virtual address ...
  pc : __pi_memcpy_generic+0x5c/0x22c
  lr : bpf_percpu_array_update+0x2dc/0x2e8
  Call trace:
    __pi_memcpy_generic
    bpf_map_update_value
    map_update_elem
    __sys_bpf

Check the CPU ID against nr_cpu_ids and cpu_possible() instead. This
rejects CPU IDs outside the valid range and CPUs absent from the
possible mask, while allowing valid sparse CPU IDs.

Fixes: 2b421662c788 ("bpf: Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags")
Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/bpf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..282f7022d984 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4202,7 +4202,8 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 			return -EINVAL;
 
 		cpu = flags >> 32;
-		if ((flags & BPF_F_CPU) && cpu >= num_possible_cpus())
+		if ((flags & BPF_F_CPU) &&
+		    (cpu >= nr_cpu_ids || !cpu_possible(cpu)))
 			return -ERANGE;
 	}
 
-- 
2.54.0

