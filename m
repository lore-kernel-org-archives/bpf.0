Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA93332601;
	Thu, 13 Aug 2026 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622935; cv=none; b=XZwLYStd5jYtJjXKGvtH3r5XvVMy7R6wX5oGWsHtPyxKdMb2QaDlyvky54HXCBt6rNqpP2rEDbZnRziNqJw+vSjEdGJKZmy/nhZ//hADL/hl8o68cCKBSz3l9tF1MNMBXVLClRxU0Z1iVTZ/EnKKCJZzeEq1sjr+Lsz7l1FUErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622935; c=relaxed/simple;
	bh=y6EEHl+w8lpxa4lAmwUMWF6GyorO7UQOtTXZYbA005o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iODUFyDEqLwmKIjU6Tvtjfk/CPcw0FXUHhQZVBEQ1icjnxdvhokE7cSNtVgNXWXNu9pLFiUxJSLNAHEv3+FvfHOy7b7apPgT5XstMHJC5AdnPkufk0ZfsidLxsAvEhBG44/gsWqgNV+j06HohNABrIS47ACN2mbqfJ6sMwH6dnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RE147qHt; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RE147qHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Eo
	lNU0nzB1S5Hraj4SzJwbg+Yw0AcJphFmyGyN/FzhE=; b=RE147qHt1FnAI6ikQa
	iKjoocx9SNuxscAZOf7Ad1k9U0p0Thu5SQ0FQvRM9/bqRq/lfu45nLxakplFfPIH
	lfKWgaARmSWXArCr0BDGJYD47wr4PgSEnm46G+KRTGhfZO4DxtG8O+Usk2S5kNKA
	akfOdp0KsT8GuU80KnY66Xt38=
Received: from localhost (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDngBmWs31qhis5MA--.17457S2;
	Thu, 13 Aug 2026 20:07:52 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hui Su <sh_def@163.com>,
	sashiko-bot@kernel.org
Subject: [PATCH bpf] bpf: fix percpu map update indexing with sparse CPU IDs
Date: Thu, 13 Aug 2026 20:02:53 +0800
Message-ID: <20260813120250.796934-4-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDngBmWs31qhis5MA--.17457S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw15tr1kZrW3AF4kJF1rtFb_yoWrXrW7pa
	95Ka4jvr47Xr4Fv3yrK34xuFZ5Gwn8Xr17Ka98GryFyr42qwn2qr1DKFy3XFW5KwsFqr4a
	yFnYvrZ0qay8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRwSdgUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwhgNbGp9s5gpFQAA37

Per-CPU array, hash, and cgroup storage map updates without BPF_F_CPU
or BPF_F_ALL_CPUS use a value buffer whose per-CPU slots are packed in
possible-CPU order. The buffer is sized as:

  round_up(value_size, 8) * num_possible_cpus()

The update paths iterate over possible CPUs, but use the logical CPU ID
to calculate the source offset:

  value + size * cpu

This only works when possible CPU IDs are contiguous starting at zero.

For example, with a possible CPU mask of 0,2-3, the buffer contains
three slots corresponding to CPUs 0, 2, and 3. CPU2 is therefore
expected to use slot 1 and CPU3 slot 2. Instead, the current code uses
slots 2 and 3 respectively, causing incorrect per-CPU values and an
out-of-bounds read from the update buffer for CPU3.

The corresponding lookup paths already use a dense offset while
iterating over possible CPUs. Do the same for the array, hash, and
cgroup storage update paths, advancing the source offset once for each
possible CPU. BPF_F_ALL_CPUS continues to use the same value for every
CPU.

Fixes: 8eb76cb03f0f ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps")
Reported-by: sashiko-bot@kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/bpf/arraymap.c      | 5 +++--
 kernel/bpf/hashtab.c       | 4 +++-
 kernel/bpf/local_storage.c | 5 +++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..cc3f8c25a28b 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -405,7 +405,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	void __percpu *pptr;
 	void *ptr, *val;
 	u32 size;
-	int cpu;
+	int cpu, off = 0;
 
 	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
 		/* unknown flags */
@@ -437,9 +437,10 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 	}
 	for_each_possible_cpu(cpu) {
 		ptr = per_cpu_ptr(pptr, cpu);
-		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
+		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + off;
 		copy_map_value(map, ptr, val);
 		bpf_obj_cancel_fields(map, ptr);
+		off += size;
 	}
 unlock:
 	rcu_read_unlock();
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9f394e1aa2e8..298b16ac4cc0 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1026,6 +1026,7 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 	} else {
 		u32 size = round_up(htab->map.value_size, 8);
 		void *val;
+		int off = 0;
 		int cpu;
 
 		if (map_flags & BPF_F_CPU) {
@@ -1038,9 +1039,10 @@ static void pcpu_copy_value(struct bpf_htab *htab, void __percpu *pptr,
 
 		for_each_possible_cpu(cpu) {
 			ptr = per_cpu_ptr(pptr, cpu);
-			val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
+			val = (map_flags & BPF_F_ALL_CPUS) ? value : value + off;
 			copy_map_value(&htab->map, ptr, val);
 			bpf_obj_cancel_fields(&htab->map, ptr);
+			off += size;
 		}
 	}
 }
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 23267213a17f..83cd527a2542 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -220,7 +220,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	struct bpf_cgroup_storage *storage;
 	void *val;
 	u32 size;
-	int cpu;
+	int cpu, off = 0;
 
 	if ((u32)map_flags & ~(BPF_ANY | BPF_EXIST | BPF_F_CPU | BPF_F_ALL_CPUS))
 		return -EINVAL;
@@ -245,8 +245,9 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
 	}
 	size = round_up(_map->value_size, 8);
 	for_each_possible_cpu(cpu) {
-		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + size * cpu;
+		val = (map_flags & BPF_F_ALL_CPUS) ? value : value + off;
 		copy_map_value(_map, per_cpu_ptr(storage->percpu_buf, cpu), val);
+		off += size;
 	}
 unlock:
 	rcu_read_unlock();
-- 
2.54.0

