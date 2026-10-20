Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504166;
	b=o0HTta2ZZOfs9Ky4ElW4TxXIYapZm8cWo1G5v4PUXSH+3+7Nb/CzZWw8JCfVsyQlLm8Y
	 Bglhu0H+n1RRTXMPWFNUFj6YLdOB61FNjHS0rVMenzdlwpGP8DU1Eca/p1KmVXRz01+51
	 MknWabk0cCI+UnOFZqMMDtNwu4XDkPsM8Og2Zq0PgmoK77uv5bEenp/d5qjYBfVTCks24
	 n3qc9IF3kFgQ9ZQ+7Jan6fEplIVqUsb7a1Osz72J1N8X8kZ1MsrS+HFWYDEXKCZGxxCLL
	 TZXqSV0bz+LtzzhuaqdQ9iqO8pdQKNlKfpgLsKhC4K3PvL8P3s5wWWmVQLmzdM5ge/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504166;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=DmEdG+4BO3wGyDQM2YKAlemOerP12b8rIDXdelaHtqE=;
	b=Ro/0LGDZFtiRlECkaLR3qftL6vBnDKhOdNTN99M0zdiMFU0YSQ+D3I3cbfnB9gQq92MF
	 CR5mKW0eQ7qk8tjFTjQwPHg1WKddOBfydhMQndoENvPP14M11Bwtifz8fwBSDzB4R3SQ3
	 GDGYaTYvrfP705Y5c8YRY2V6eOOR7/MRIoXwIaV3z1ri71cgzH6hAq1CD1tgqVmuZtHWW
	 LdpF5hsJJjrLo3wGmHn1hKoT0QnKKtURYAJuSS9yU7va6EYQ8I5kJA61hMZ514J2ufTL/
	 WjTFRikjx/RqaYYvIBuYQODexihL0S8LZUXq0arVkXqpEaJDE2DFyP5Ng38d9ruNYyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D34606B651;
	Tue, 20 Oct 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D34606B651
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn0NjwzYQttK;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 127B440578;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S4;
	Tue, 20 Oct 2026 21:49:18 +0800 (CST)
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
Subject: [PATCH bpf-next 02/16] libbpf: Create arena percpu chunk from the arena percpu ELF section
Date: Tue, 20 Oct 2026 13:22:47 +0000
Message-ID: <09a19ff6dfc65af56dca0ec5cee051766470f36a.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4DXFyxJF1UGw4UuF1UAwb_yoW7CFWrpF
	W3Aa4rKrWUJr4xZw1fWw45tFWY9r4fXF18Ga45Ga48Ar1xXanrtFW0kFn3ZF1agrZagr13
	G3yIvr9rurWDArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBGb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8Zw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jo5l8UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Before replicating the initial values for each possible cpu, create
one chunk holding a single cpu's variables. The chunk size is rounded
up to a page multiple, so each cpu's copy gets its own pages and can
be placed on the cpu's NUMA node. The data comes from the ELF section,
zero-padded to the chunk size.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/libbpf.c | 75 ++++++++++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h |  7 ++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d79fc382319e..02ee57e3f6c7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -829,6 +829,13 @@ struct bpf_object {
 	} *data_ptrs;
 	size_t data_ptr_cnt;
 
+	struct {
+		void *chunk; /* copy from section .arena.percpu, zero-padded to chunk size */
+		size_t chunk_sz;	/* chunk size, page-aligned */
+		size_t nr_chunks;	/* how many chunks, one chunk per possible cpu */
+		bool present;
+	} arena_percpu;
+
 	void *jumptables_data;
 	size_t jumptables_data_sz;
 
@@ -3267,6 +3274,41 @@ static int bpf_object__init_arena_data(struct bpf_object *obj)
 	return 0;
 }
 
+static int init_arena_percpu_data(struct bpf_object *obj, void *percpu_data, size_t percpu_sz)
+{
+	static const char *fcpu = "/sys/devices/system/cpu/possible";
+	bool *mask = NULL;
+	int possible_cpus;
+	int err;
+
+	if (percpu_sz == 0) {
+		pr_warn("arena percpu: empty %s section\n", ARENA_PERCPU_SEC);
+		return -EINVAL;
+	}
+
+	err = parse_cpu_mask_file(fcpu, &mask, &possible_cpus);
+	if (err) {
+		pr_warn("arena percpu: failed to get possible cpus: %s\n",
+			errstr(err));
+		return err;
+	}
+
+	obj->arena_percpu.chunk_sz = roundup(percpu_sz, sysconf(_SC_PAGE_SIZE));
+	obj->arena_percpu.chunk = calloc(1, obj->arena_percpu.chunk_sz); /* zero padding */
+	if (!obj->arena_percpu.chunk) {
+		free(mask);
+		return -ENOMEM;
+	}
+
+	memcpy(obj->arena_percpu.chunk, percpu_data, percpu_sz);
+
+	obj->arena_percpu.nr_chunks = possible_cpus;
+	obj->arena_percpu.present = true;
+	free(mask);
+
+	return 0;
+}
+
 static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 					  const char *pin_root_path)
 {
@@ -3335,6 +3377,13 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 			if (err)
 				return err;
 		}
+
+		if (obj->efile.arena_percpu_data) {
+			err = init_arena_percpu_data(obj, obj->efile.arena_percpu_data->d_buf,
+						     obj->efile.arena_percpu_data->d_size);
+			if (err)
+				return err;
+		}
 	}
 	if (obj->efile.arena_data && obj->arena_map_idx < 0) {
 		pr_warn("elf: sec '%s': to use global __arena variables the ARENA map should be explicitly declared in SEC(\".maps\")\n",
@@ -8141,12 +8190,24 @@ static int bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_pat
 		struct bpf_map *arena_map = &obj->maps[obj->arena_map_idx];
 		size_t data_sz = roundup(obj->arena_data_sz, sysconf(_SC_PAGE_SIZE));
 		size_t mmap_sz = bpf_map_mmap_sz(arena_map);
+		size_t percpu_sz = obj->arena_percpu.nr_chunks * obj->arena_percpu.chunk_sz;
+
+		/*
+		 * the light skeleton loader doesn't mmap the arena in user space, so the percpu
+		 * chunks could not be populated
+		 */
+		if (obj->gen_loader && obj->arena_percpu.present) {
+			pr_warn("map '%s': light skeletons don't support arena percpu variables\n",
+				arena_map->name);
+			return -EOPNOTSUPP;
+		}
 
-		if (data_sz > mmap_sz) {
-			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold global %s of size %zu\n",
+		if (data_sz + percpu_sz > mmap_sz) {
+			pr_warn("map '%s': declared ARENA map size (%zu) is too small to hold "
+				"global %s of size %zu plus the percpu data size %zu\n",
 				arena_map->name, mmap_sz,
 				obj->data_in_arena ? "data" : "__arena variables",
-				obj->arena_data_sz);
+				obj->arena_data_sz, percpu_sz);
 			return -E2BIG;
 		}
 
@@ -10649,6 +10710,7 @@ void bpf_object__close(struct bpf_object *obj)
 		close(obj->token_fd);
 
 	zfree(&obj->arena_data);
+	zfree(&obj->arena_percpu.chunk);
 
 	zfree(&obj->jumptables_data);
 	obj->jumptables_data_sz = 0;
@@ -12103,6 +12165,13 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 	return 0;
 }
 
+/*
+ * NOTE: For an ARENA map, the initial value returned covers the global
+ * data only. Percpu variables live in a different region from the
+ * global variables. We cannot return a flat initial value for both
+ * global and percpu arena data. Read and set the arena percpu data
+ * through the bpf skeleton.
+ */
 void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize)
 {
 	if (bpf_map__is_struct_ops(map)) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 03f794f4adb0..3e0b7bc91bef 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1221,6 +1221,13 @@ LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra);
 
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
+/*
+ * NOTE: For an ARENA map, the initial value returned covers the global
+ * data only. Percpu variables live in a different region from the
+ * global variables. We cannot return a flat initial value for both
+ * global and percpu arena data. Read and set the arena percpu data
+ * through the bpf skeleton.
+ */
 LIBBPF_API void *bpf_map__initial_value(const struct bpf_map *map, size_t *psize);
 
 /**
-- 
2.47.3

