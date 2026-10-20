Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504165;
	b=VHqeKIVKqToOGD1x2cJTCUk4hsl6FqaMJxikLnfeufKPY0KYmm6HRAxfMNBx+Mk2HiOW
	 zas0x3r/LZ5TOT2BITRO8PObnEnrQ27eUjFdS9wShAp/ZnOLmOdaxM49Qk83GdhfjSGPn
	 VUFyjHVoujsT0hy9e6bBeOj/QiNGO1v/hiqMCej5LTknswnbteyNLMaJ/il04hAeACowW
	 MP21cjSVNGaE/blB5vTWRiqclvk/wHlWWMl7DVWxbNac9s1kRVScNFjs6pB71Sn01yN61
	 BPeMtGV3/inDXrzGFEGZj9KszQ9dI6+ARV+I8RWH0rS8t5g+kWJFJwniFVqijZNaR+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504165;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=udhWbDKTtlYUKEGPCeE+snq6+NaQ/xh3Jp3Vbbd6F5Y=;
	b=GZd9MRS84CPRQYQ0jt6eodPhh30L1nfZhgP0wZliNvwcu735IDOzwczxG3SHMVtPqPsK
	 //dbPWRruDHBp5RqoVcTLYv3BzU5d64K7ugnkjQvKQuVOylTCQqyINGLXU+2SMnwI+A+p
	 gTvfzA5ktHoQ62aXtGNz3y/KM7mnDGTwlHnk5GLXHMTMb6RZY5c5m75p1j1SJabIb9bmM
	 FEsJJ0rUFzt+zzW0OAO+y8V4XiT6RDLwWHugA84w4KoSQIN8jHoyAf9xDOXm/mOHg0aaa
	 LA5k7hHLVnTKn9ELvq5aHU6hBoEMfU27lJN87sjVLTfTAJ6oWGgv7FmOr7XTZacYuVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE9606AB38;
	Tue, 20 Oct 2026 13:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BE9606AB38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn12XkzYQtvk;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2604A40570;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S6;
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
Subject: [PATCH bpf-next 04/16] libbpf: Copy the percpu chunks into the bpf arena
Date: Tue, 20 Oct 2026 13:22:49 +0000
Message-ID: <114861b89f9ea8789e8572c53b1c88774c311460.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW5Ww15Ar1DGr13AF45Awb_yoW5Xw4fpF
	13Aw1rWrZ8Jr47Cw4fWa1FyrZI9wsaqr1jkFy3Aa40yr4aqw43GrW0kF15ZF15G3ya9F13
	C39rurya9ay7taUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
	xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
	6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUzku4UUUU
	U
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

After the arena is mmapped, copy the chunk into every cpu's replica
in the arena. Before each copy, pin the copying thread to the target
cpu, so each chunk's pages fault in from that cpu's NUMA node.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/libbpf.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6fc8c7f549d9..3d18ba483f6e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -25,6 +25,7 @@
 #include <fcntl.h>
 #include <errno.h>
 #include <ctype.h>
+#include <sched.h>
 #include <asm/unistd.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -5649,6 +5650,49 @@ static struct bpf_map *bpf_object__sec_map(struct bpf_object *obj, int sec_idx)
 	return NULL;
 }
 
+/*
+ * Copy the percpu chunks into the mmapped bpf arena, one chunk at a
+ * time. Before copying each chunk, pin the thread to the chunk's cpu,
+ * so the copy faults the chunk's pages in from that cpu's NUMA node.
+ * If pinning fails, fall back to copying on the current cpu.
+ */
+static void arena_percpu_populate(struct bpf_object *obj, void *arena_mmaped)
+{
+	size_t chunk_sz = obj->arena_percpu.chunk_sz;
+	cpu_set_t *saved_set = NULL, *one = NULL;
+	size_t set_sz;
+	void *base;
+	int cpu;
+
+	base = arena_mmaped + obj->arena_percpu.offset;
+
+	set_sz = CPU_ALLOC_SIZE(obj->arena_percpu.nr_chunks);
+	saved_set = CPU_ALLOC(obj->arena_percpu.nr_chunks);
+	one = CPU_ALLOC(obj->arena_percpu.nr_chunks);
+	if (!saved_set || !one || sched_getaffinity(0, set_sz, saved_set) != 0) {
+		/* no affinity info, fall back to copying on the current cpu */
+		for (cpu = 0; cpu < obj->arena_percpu.nr_chunks; cpu++)
+			memcpy(base + cpu * chunk_sz, obj->arena_percpu.chunk, chunk_sz);
+		goto out;
+	}
+
+	for (cpu = 0; cpu < obj->arena_percpu.nr_chunks; cpu++) {
+		CPU_ZERO_S(set_sz, one);
+		CPU_SET_S(cpu, set_sz, one);
+		sched_setaffinity(0, set_sz, one);
+
+		/* faults the chunk pages in from the target cpu's NUMA node */
+		memcpy(base + cpu * chunk_sz, obj->arena_percpu.chunk, chunk_sz);
+	}
+
+	sched_setaffinity(0, set_sz, saved_set);
+
+out:
+	CPU_FREE(saved_set);
+	CPU_FREE(one);
+	zfree(&obj->arena_percpu.chunk);
+}
+
 static int bpf_object__mmap_arena(struct bpf_object *obj, struct bpf_map *map)
 {
 	int i, err;
@@ -5669,6 +5713,8 @@ static int bpf_object__mmap_arena(struct bpf_object *obj, struct bpf_map *map)
 			obj->arena_data_sz);
 		zfree(&obj->arena_data);
 	}
+	if (obj->arena_percpu.present)
+		arena_percpu_populate(obj, map->mmaped);
 	for (i = 0; i < obj->nr_maps; i++) {
 		struct bpf_map *m = &obj->maps[i];
 
-- 
2.47.3

