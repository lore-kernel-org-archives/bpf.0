Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504167;
	b=ZdSp0msX/t4UcSm7NSseq4iWPiC0L24oaxX2K3CtijZHOYohObhtBV6gmSkIh293eyz2
	 jJ5HAaHr8jOEwxzhc+QB+vPNY3SWRNd0uVrg74AmEWPYfAgsAwMRfJWoiec6FIhKmRvhj
	 hiAiu7B6UV4XudtiQwYwcCR6L0JYFoTCypjFLBWgNo3BXxNYnYw5Rxwhg9BL7XOYWEWHF
	 5g14PWkcLMUuyn+PkgWlIi7T5h1JanYHXe/VqUszkqYUfPhAd0QqfyX3JMpiM1yD16b/t
	 F9kiFmZNXywofzSxpf4LwwzAb4Z61CaGgmLp7Uq5ywRJsh7aik2pPIeV20INg3zo8Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504167;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=BK0JjgCFFAkm4X58pCZuDp9JVPOjdN8lMjaFcj46rJY=;
	b=LoQMkbw/qgJrBPk/x9rKP5lBAAooEdu/eZtAlvoOvnOuC7+8C48YQNOiw1uPSkcUsfLd
	 l0tD4KtDluKYTYnMrFn1TlSb87jzUpajJUzcCGpU0hW8PhUBevJ2HyxCKGM4BvREUEuMD
	 M4oEDe5ci8EjGIjAuCGLnBTWePdGYhiP3r+gBkOJRixmLJZYbv/r7bxhD//Jg8uPe0wjc
	 aHom0pGmrf47xQlxfSi77ECYAKUu4Hg9J0XIt510Q1SeV4gaH3nxMRuqbLii3eELMwZkO
	 TXe4hqyVuh28qMXNOawdNpk4xnCxXNDTyrZBDkFI1VsHH9d9ZCQv3eXYHScoabMtksw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE8606F45F;
	Tue, 20 Oct 2026 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72DE8606F45F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn2NpFzYQtr5;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 55593408EF;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S9;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 07/16] libbpf: Add arena percpu feature probe
Date: Tue, 20 Oct 2026 13:22:52 +0000
Message-ID: <10e58b0ec9fab53a862d5efe45c8de932e0f5a6b.1792503001.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S9
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4DKw1UXryfKry3Gw45ZFb_yoWrWF1DpF
	nakFy8CryrXw1fZas8Ww1FkFWYkr4Sqay7GwnrGry5Zr1aqa15Xr10vFnIyrnxW398W3Wa
	krs0vrZ7uFyDZr7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
	xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
	6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1KFAJUU
	UUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Arena percpu requires kernel and JIT support for the percpu pseudo
ldimm64. Probe it at load time and fail objects carrying arena percpu
data with -EOPNOTSUPP when it is missing.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/features.c        | 50 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.c          |  6 ++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 3 files changed, 58 insertions(+)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index adb5d2e7fdfa..f9c7d1545c1e 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
 #include <linux/kernel.h>
 #include <linux/filter.h>
+#include <sys/mman.h>
 #include "bpf.h"
 #include "libbpf.h"
 #include "libbpf_common.h"
@@ -728,6 +729,52 @@ static int probe_kern_percpu_data(int token_fd)
 	return probe_fd(ret);
 }
 
+static int probe_kern_arena_percpu_data(int token_fd)
+{
+	int possible_cpus;
+	size_t page_sz = sysconf(_SC_PAGE_SIZE);
+	bool *mask = NULL;
+	struct bpf_insn insns[] = {
+		BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_ARENA_PERCPU, 0, 0, 0, 0),
+		BPF_EXIT_INSN(),
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, map_opts,
+		.token_fd = token_fd,
+		.map_flags = BPF_F_MMAPABLE | (token_fd ? BPF_F_TOKEN_FD : 0),
+		.arena_percpu_chunk_sz = page_sz,
+	);
+	LIBBPF_OPTS(bpf_prog_load_opts, prog_opts,
+		.token_fd = token_fd,
+		.prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	void *mmaped;
+	int ret, map_fd, insn_cnt = ARRAY_SIZE(insns);
+
+	ret = parse_cpu_mask_file("/sys/devices/system/cpu/possible", &mask, &possible_cpus);
+	if (ret < 0 || possible_cpus <= 0) {
+		free(mask);
+		return -EINVAL;
+	}
+	free(mask);
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARENA, "arena_percpu", 0, 0, possible_cpus, &map_opts);
+	if (map_fd < 0)
+		return 0;
+
+	mmaped = mmap(NULL, possible_cpus * page_sz, PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, 0);
+	if (mmaped == MAP_FAILED) {
+		close(map_fd);
+		return 0;
+	}
+
+	insns[0].imm = map_fd;
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &prog_opts);
+	munmap(mmaped, possible_cpus * page_sz);
+	close(map_fd);
+
+	return probe_fd(ret);
+}
+
 typedef int (*feature_probe_fn)(int /* token_fd */);
 
 static struct kern_feature_cache feature_cache;
@@ -824,6 +871,9 @@ static struct kern_feature_desc {
 	[FEAT_EXCL_MAP_FD_ARRAY_CNT] = {
 		"exclusive map bound through fd_array_cnt", probe_kern_excl_map_fd_array_cnt,
 	},
+	[FEAT_ARENA_PERCPU_DATA] = {
+		"kernel supports arena percpu data", probe_kern_arena_percpu_data,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 8634778e8ba5..be2ddaf96631 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8288,6 +8288,12 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 			return -EOPNOTSUPP;
 		}
 
+		if (obj->arena_percpu.present && !kernel_supports(obj, FEAT_ARENA_PERCPU_DATA)) {
+			pr_warn("map '%s': kernel doesn't support %s variables\n",
+				arena_map->name, ARENA_PERCPU_SEC);
+			return -EOPNOTSUPP;
+		}
+
 		if (data_sz + percpu_sz > mmap_sz) {
 			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold "
 				"global %s of size %zu plus the percpu data size %zu\n",
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index e90b5336bac0..2aaf681f8cb8 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -408,6 +408,8 @@ enum kern_feature_id {
 	FEAT_FD_ARRAY_CNT,
 	/* Kernel checks an exclusive map bound through fd_array_cnt against the final digest */
 	FEAT_EXCL_MAP_FD_ARRAY_CNT,
+	/* Kernel supports arena percpu data */
+	FEAT_ARENA_PERCPU_DATA,
 	__FEAT_CNT,
 };
 
-- 
2.47.3

