Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504165;
	b=S/WOH83jtyByNx+lCNW5zGPR0oNnjSKK9Ayol+j2EOAqYCGQLsi68A/DrQfJzablVDzL
	 2QwGPA8ZAwYHqkBTPNXAlczcRHglZ4NQ58DxX5vx6Awk244FM29onrlb0X93xav2n4Cdp
	 CJnMj3jsUpLTuj5msHHxq2APp+WtP5iaIYdItifqhfM4K4CNywEH9CaydvdMOgK2XS0ju
	 Q5kvwaFZ/xEOF9Q4kYNIJ8P6mjeqJk8Cs0MsCJOCD7Oi829VgxON8KYc8inIQKPasJWYs
	 1CD+ryjvfP0RnCd0EpsdvbJsH3+RH93zsCo360OcPbKspPYLUSvgCjELuXSn8na9ZzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504165;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=2COAk/CcWgyuKoSCiG2BraDacDuukk9ckYGnLhe88x4=;
	b=y2d6EiEFt9vr38QN+uOptJMhFY68xQo+zjvUHGPi0DmQ4G4XMRfe0j5Zhr3WfJoKf+yI
	 kzQKX3OpT46WqmJahm1yfXmSmZtwIixo4X8vFJa5xBt5nwhII6OeodDzrEL6kAgg0L6TI
	 +ow1D4Hskgm9HUzc68B+KkrjFVtS+HTgFbhDz/pO9+EhaWqn/yXGk69RQf5pPp6FSlSvD
	 l2hYIQJsVS2ipXA/w+8mk9JkZDoX2ENZXWew0kn9RHv6hwWgThv6WrFMETr6kHGrfVEqP
	 qaFFOlPjfHjXkNSeDGZq588BJPMU9KVFz415gk00lHzCH/pod0TMV5JRQL4tamrxCOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC5606AB39;
	Tue, 20 Oct 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7AC5606AB39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKd1hPczKHMWm;
	Tue, 20 Oct 2026 21:49:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2F70D408E5;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S7;
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
Subject: [PATCH bpf-next 05/16] libbpf: Add the arena percpu chunk attribute to map creation options
Date: Tue, 20 Oct 2026 13:22:50 +0000
Message-ID: <e596c9878df94ac93c172d93106c8ebd2dac4bb7.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW7XFWkZry3Wr47KFy8Krg_yoW5uFy8pF
	43CFyxCr15Xr45Z3yDWa1Fvw4YgFnxWry2y3y7JryUZFZrZw1fAry2kanxAryagFZ0yw17
	u3yagryUXFyxZrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Add the percpu chunk offset and size information to the map creation
attribute, and set the values when creating an arena map.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/include/uapi/linux/bpf.h | 4 ++++
 tools/lib/bpf/bpf.c            | 4 +++-
 tools/lib/bpf/bpf.h            | 4 ++++
 tools/lib/bpf/libbpf.c         | 6 ++++++
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6f70db7515dd..246f52361372 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1615,6 +1615,10 @@ union bpf_attr {
 		__aligned_u64 excl_prog_hash;
 		/* Size of the passed excl_prog_hash. */
 		__u32 excl_prog_hash_size;
+
+		/* offset and size of an arena percpu chunk */
+		__u32	arena_percpu_chunk_off;
+		__u32	arena_percpu_chunk_sz;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index b49822d212ae..3d5fd7e23898 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -210,7 +210,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
+	const size_t attr_sz = offsetofend(union bpf_attr, arena_percpu_chunk_sz);
 	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
 	struct bpf_common_attr attr_common;
 	struct bpf_log_opts *log_opts;
@@ -246,6 +246,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.map_token_fd = OPTS_GET(opts, token_fd, 0);
 	attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
 	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
+	attr.arena_percpu_chunk_off = OPTS_GET(opts, arena_percpu_chunk_off, 0);
+	attr.arena_percpu_chunk_sz = OPTS_GET(opts, arena_percpu_chunk_sz, 0);
 
 	log_opts = OPTS_GET(opts, log_opts, NULL);
 	if (!OPTS_VALID(log_opts, bpf_log_opts))
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 826d9cc9ab65..15a544488eb5 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -70,6 +70,10 @@ struct bpf_map_create_opts {
 	const void *excl_prog_hash;
 	__u32 excl_prog_hash_size;
 
+	/* offset and size of an arena percpu chunk */
+	__u32 arena_percpu_chunk_off;
+	__u32 arena_percpu_chunk_sz;
+
 	struct bpf_log_opts *log_opts;
 
 	size_t :0;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3d18ba483f6e..0b0c9d72b353 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5816,6 +5816,12 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.map_flags = def->map_flags;
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
+
+	if (obj->arena_percpu.present && map == &obj->maps[obj->arena_map_idx]) {
+		create_attr.arena_percpu_chunk_off = obj->arena_percpu.offset;
+		create_attr.arena_percpu_chunk_sz = obj->arena_percpu.chunk_sz;
+	}
+
 	create_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
 		create_attr.map_flags |= BPF_F_TOKEN_FD;
-- 
2.47.3

