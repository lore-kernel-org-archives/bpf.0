Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589B48C3FF;
	Thu, 13 Aug 2026 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637459; cv=none; b=FLtMInQJElbhY2wrAsKYmsvfJpyxi8KryDSI7RvgyPW/P44nZnFeBAdr3EGvNAgfugzWitr+ORlHbxZf9S7FUuyRRSvnhI/yIpPLvS5AKAQjh44eUXSRahShmTCYcyHmfPU2baI4r2iZXnTv2bSz8r4oaRt2IL24cXwB9YSg9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637459; c=relaxed/simple;
	bh=m+K51MO81waEGflQda2mnL1hqEASJ8ZRztgXp7SXUS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m6KF0GSbNe49sB835261rl1zN7d1lwZJW5khGNa/QAhfXrWLcooXJo6yjxk/4tYwlhKd7QcBsuHf4QKnMphuCIIc5zf+QqnOey2sZWK+xmm/bBfE6clpAVxTnjGaPe/+Jl8ZpgOSCzZ2GiAzqTX0a0Xhdvzw1SZ3QwWPGI02ero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UHJvIZbB; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UHJvIZbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Hi
	kGhVWf4pY0nRs1YNMJqz3rQKJ07L1gT/o+/qOR8PY=; b=UHJvIZbBCrf1jgN/fv
	XOt+MeQBYtUn/5GNNAZD9teIC6it9XkllkIjL3H0UgYrP3JQw+29mWzTiRa44RyS
	+ffVcvmuZRIzuFbhhqb3MW7v8+mhJJEgZ/OklTvQdcXwePKjcaeY7EA7YD6JnJDt
	vMxa6Qm61ExJEOO+lEEGw5WY8=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXnxVH7H1q2LswPA--.33402S2;
	Fri, 14 Aug 2026 00:09:44 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	leon.hwang@linux.dev
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sh_def@163.com
Subject: [PATCH bpf v2] bpf: fix BPF_F_CPU validation for sparse CPU IDs
Date: Fri, 14 Aug 2026 00:09:00 +0800
Message-ID: <20260813160858.1042834-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXnxVH7H1q2LswPA--.33402S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFW5tF1rGw1kWFy8XF4kCrg_yoW8ZFyrpF
	WkWa109rs7GryFyayag3yxCr18Cws5Xw4Ikas8Kw15Zw4Yq3WxW3sYkFnIvr9Ykrs5Jr4U
	KF1IyrWkuaykZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbXo7UUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6glHpmp97EnGVQAA3j

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
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Hui Su <sh_def@163.com>
---
Changes in v2:
- Keep the CPU ID check on one line as suggested by the review.
- Add Leon Hwang's Acked-by tag.

v1 Link: https://lore.kernel.org/lkml/20260813101229.680523-3-sh_def@163.com/

 include/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..353f13bb066d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -4202,7 +4202,7 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
 			return -EINVAL;
 
 		cpu = flags >> 32;
-		if ((flags & BPF_F_CPU) && cpu >= num_possible_cpus())
+		if ((flags & BPF_F_CPU) && (cpu >= nr_cpu_ids || !cpu_possible(cpu)))
 			return -ERANGE;
 	}
 
-- 
2.54.0

