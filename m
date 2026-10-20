Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504167;
	b=q6lqwXMFm0jmYhfDBgbplmAynJ6o1x2+GMY/JTL+wA8G8UaJMp/gvXQYFcqMcXuGxLSm
	 CnnO3lszDwElVV4MoxlwSqOMItUhCr1lMuU3egB73eNzmh/ulXdyYDQxszNnL6GoCHRpM
	 VB4zV3GLSTOEEpZ4ymXShzVMHkDRvVmOzJXjnmogvzMcII998tjXC09mL1m+Uyxc/MHML
	 B7dGWTFvAnG+OeVstvs/YWALouL5kude2SoFld6y/W31Q6Ek4E+xxbnW5SImU89JeA92n
	 5R594FK+gMV3oC8xwY3zDAWlmgOQo3+KwcPN7qdkjBLqhJQBPFpvriBdEgNZ+UuTb/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504167;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=jeplPnuQo0sODASjlB4eO4jD/iKQX6bJqSyIn82/aAg=;
	b=AwL1c2eTiEy4MHebVRokjudGLnU2Fyevx2tsv4syiDoZfb1xkh6rhDnzFRoR+UTPN7Ke
	 j/kp1SH99NuB6pyct4alSYERtyYqzjA+17RcEyP9fopDMnD7vvRroo9SsclclJX/SyJLs
	 38EaX9YNBtvKh3YCQOvlHkarYivmLKjP+3Xm0YSd06Ul0z3EyVyqRtGZ94ZXcBACVwonA
	 NBRyzMdcWJyz+PCRHuCEhlGQTAgUqHjtsLDFaCsLz2OVIERSPOPtWxlmGXoLpXMUaujBj
	 sNo1quLqoo1BNMAswPfpb2tqmHdHWyAbo0m6WheGCtKo3OLqGurdtt297gemz/ZrR9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD178606F467;
	Tue, 20 Oct 2026 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD178606F467
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn45pfzYQtvG;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8F9B8409A7;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S14;
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
Subject: [PATCH bpf-next 12/16] libbpf: Introduce arena percpu helpers for user space
Date: Tue, 20 Oct 2026 13:22:57 +0000
Message-ID: <d56952f063f90acb07c0a37c96a83851bea227d8.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S14
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW8Aw1fAF1UWFWkKF4UJwb_yoWruw1fpF
	1IkryrGrs8Zr4fu393Ww4rtr45Crsaga48Gw4xGa4UZw1IgrW3GrW0k3W3AF1agwsagw4a
	yryakr1IkrW7JrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFc
	xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_
	Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r
	43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1KFAJUU
	UUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Introduce two helpers for user space.
- bpf_map__arena_percpu_base(): return the base address of the arena
  percpu. The generated skeleton will call it to set up its arena
  percpu data.
- bpf_map__arena_percpu_ptr(): translate a variable address in cpu 0's
  chunk to the address in the target cpu's chunk.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/libbpf.c   | 49 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 26 +++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 77 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index be2ddaf96631..0edce476451c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -12287,6 +12287,55 @@ void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
 	return map->mmaped;
 }
 
+void *bpf_map__arena_percpu_ptr(const struct bpf_map *map, void *ptr, unsigned int cpu)
+{
+	struct bpf_object *obj;
+	uint64_t base;
+
+	if (!map || !ptr)
+		return libbpf_err_ptr(-EINVAL);
+
+	obj = map->obj;
+	if (map->def.type != BPF_MAP_TYPE_ARENA || !obj->arena_percpu.present)
+		return libbpf_err_ptr(-EINVAL);
+
+	if (cpu >= obj->arena_percpu.nr_chunks)
+		return libbpf_err_ptr(-ERANGE);
+
+	/*
+	 * obj->arena_percpu.chunk is freed by arena_percpu_populate(), and only
+	 * then the map is mmaped
+	 */
+	if (obj->arena_percpu.chunk)
+		return libbpf_err_ptr(-EINVAL);
+
+	base = (uint64_t)map->mmaped + obj->arena_percpu.offset;
+	if ((uint64_t)ptr < base || (uint64_t)ptr >= base + obj->arena_percpu.chunk_sz)
+		return libbpf_err_ptr(-EINVAL);
+
+	return (void *)((uint64_t)ptr + (uint64_t)cpu * obj->arena_percpu.chunk_sz);
+}
+
+void *bpf_map__arena_percpu_base(const struct bpf_map *map)
+{
+	struct bpf_object *obj;
+
+	if (!map)
+		return NULL;
+
+	obj = map->obj;
+	/*
+	 * The per-cpu chunks exist once the map is created and populated;
+	 * obj->arena_percpu.chunk is freed by arena_percpu_populate(), and
+	 * only then the map is mmaped
+	 */
+	if (map->def.type != BPF_MAP_TYPE_ARENA || !obj->arena_percpu.present ||
+	    obj->arena_percpu.chunk)
+		return NULL;
+
+	return map->mmaped + obj->arena_percpu.offset;
+}
+
 bool bpf_map__is_internal(const struct bpf_map *map)
 {
 	return map->libbpf_type != LIBBPF_MAP_UNSPEC;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3e0b7bc91bef..31d3982226cc 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1230,6 +1230,32 @@ LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
  */
 LIBBPF_API void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize);
 
+/**
+ * @brief **bpf_map__arena_percpu_ptr()** translates an address within
+ * cpu 0's chunk of the arena's per-cpu area (e.g. the address of an
+ * `__arena_percpu` variable as seen in the skeleton's arena_percpu
+ * section) to the per-cpu chunk of the requested @cpu.
+ * @param map the ARENA map
+ * @param ptr address of an `__arena_percpu` variable (cpu 0's chunk)
+ * @param cpu cpu id to obtain the chunk for
+ * @return pointer to the variable in the chunk of @cpu; error pointer, if the
+ * map is not a loaded ARENA map with a per-cpu area, @cpu is out of range,
+ * or @ptr is not within cpu 0's chunk
+ */
+LIBBPF_API void *bpf_map__arena_percpu_ptr(const struct bpf_map *map, void *ptr,
+					   unsigned int cpu);
+
+/**
+ * @brief **bpf_map__arena_percpu_base()** returns the base of cpu 0's
+ * chunk of the arena's per-cpu area in the user-space-visible mmap of
+ * the arena, i.e. where the skeleton's arena_percpu section points.
+ * @param map the ARENA map
+ * @return pointer to the start of cpu 0's chunk; NULL if @map is not a
+ * loaded ARENA map whose per-cpu chunks have been populated (e.g.
+ * before load, or for a map with `autocreate == false`)
+ */
+LIBBPF_API void *bpf_map__arena_percpu_base(const struct bpf_map *map);
+
 /**
  * @brief **bpf_map__is_internal()** tells the caller whether or not the
  * passed map is a special map created by libbpf automatically for things like
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index eeba4072a5da..eda89ab60543 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,6 +458,8 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_map__arena_percpu_base;
+		bpf_map__arena_percpu_ptr;
 		bpf_map__attach_cgroup_opts;
 		bpf_prog_stream_open;
 		bpf_program__add_flags;
-- 
2.47.3

