Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504166;
	b=e3IfsbRdbXs7pPkPBJd1xJnZsgFOl7JiwQFICsz7wdYc2cAgxP7Aj4kDusuyas67N6g1
	 TasNBCtD8gQKSyVW8VzDVqJHp/gumL9ua5lk7SoLap7VgkXmfVqR0/ghmZSJLRCO88Vx7
	 t9qM6Ligem9tQ/sYiCcKBgnVT/bgnArh+RSnX6vs7aCUyi3czC2QSq04naA2oWR6NY1Yy
	 mZBPPDiNo+/yTlWgTM4fQAGIk/chieD7Ro1iszi9WvkoMq+drmo5EiOAnqtTpRUF7bcEH
	 QuuEeDhmqms4nM4DDPL+NGnmmvsUmEBlYWYXmxWBGHBBy8Gwjoi1ZYm8jCIG9AAtSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504166;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Torqv/G2ZCtdeRRGEInhExYmid8QlzHORZuFadcT4cs=;
	b=q9tZv3rAjKn4YZbGgWCT3NuJU1eI6UwAFlH3IGFoU1lFe01BwomE+RelACDDgvk2OgbZ
	 E/jW7X2akLmXluUECSmwxCtY0eBG2C5UfpuHisKWn+YdDNd0SpnmAiGU9ZXpiIJDplzS1
	 Ze261kXzxzIiGC7jQEZD5wo/QnbptgWRFM6kEhJnQdJ8O6tLQZgcvgSDlUyR7qb0t8mkW
	 nKHfWWa4N55Af5rt9FN7Ux7+SG6rW4x6C7+U25T6wHTGOu1YxLHLComP4T41u/deCHysC
	 oZhiAuLhH3AjejjPi3Hm0rHZCOt6IxvOEAMB/wdNweAHqr5MejD0rhregnz6eMWpGAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FB606F45A;
	Tue, 20 Oct 2026 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557FB606F45A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn2bzTzYQttK;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5C948409A4;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S10;
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
Subject: [PATCH bpf-next 08/16] bpf: Extend syscall to accept arena percpu information
Date: Tue, 20 Oct 2026 13:22:53 +0000
Message-ID: <2f1a53eb72a6fdb93346cb4e1d04a5d472177b1c.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S10
X-Coremail-Antispam: 1UD129KBjvJXoWxJw48Jw4xtr1kWF15uFWruFg_yoW5ZFy8pF
	s3GF98Xr4jqr4I9ry3Jw4UGrWY9wn5X34xCayDCFy0yry2qr1vkFW0va1Yqa4Y9r43ur1f
	KrWIgryFga47AFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Extend the bpf syscall to accept the arena percpu chunk offset and
size. Both are checked at arena creation time to make sure they are
page-aligned and the percpu chunks live inside the arena vm_range. If
the checks pass, the values are stored in struct bpf_arena for the
verifier and the JIT.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/uapi/linux/bpf.h |  4 ++++
 kernel/bpf/arena.c       | 18 ++++++++++++++++++
 kernel/bpf/syscall.c     |  2 +-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9e5fa52c9bc2..6b17dcfc36b4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1628,6 +1628,10 @@ union bpf_attr {
 		__aligned_u64 excl_prog_hash;
 		/* Size of the passed excl_prog_hash. */
 		__u32 excl_prog_hash_size;
+
+		/* offset and size of an arena percpu chunk */
+		__u32	arena_percpu_chunk_off;
+		__u32	arena_percpu_chunk_sz;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 868589f07330..05cd6397adae 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -67,6 +67,9 @@ struct bpf_arena {
 	struct irq_work     free_irq;
 	struct work_struct  free_work;
 	struct llist_head   free_spans;
+	/* percpu chunk offset and size */
+	u32 percpu_chunk_off;
+	u32 percpu_chunk_sz;
 };
 
 static void arena_free_worker(struct work_struct *work);
@@ -298,6 +301,17 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		/* user vma must not cross 32-bit boundary */
 		return ERR_PTR(-ERANGE);
 
+	if (attr->arena_percpu_chunk_sz) {
+		u64 offset = attr->arena_percpu_chunk_off;
+		u64 size = attr->arena_percpu_chunk_sz;
+
+		if (!IS_ALIGNED(offset, PAGE_SIZE) || !IS_ALIGNED(size, PAGE_SIZE))
+			return ERR_PTR(-EINVAL);
+
+		if (offset > vm_range || size > (vm_range - offset) / nr_cpu_ids)
+			return ERR_PTR(-E2BIG);
+	}
+
 	kern_vm = get_vm_area(KERN_VM_SZ, VM_SPARSE | VM_USERMAP);
 	if (!kern_vm)
 		return ERR_PTR(-ENOMEM);
@@ -311,6 +325,10 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	if (arena->user_vm_start)
 		arena->user_vm_end = arena->user_vm_start + vm_range;
 
+	arena->percpu_chunk_sz = attr->arena_percpu_chunk_sz;
+	if (attr->arena_percpu_chunk_sz)
+		arena->percpu_chunk_off = attr->arena_percpu_chunk_off;
+
 	INIT_LIST_HEAD(&arena->vma_list);
 	init_llist_head(&arena->free_spans);
 	init_irq_work(&arena->free_irq, arena_free_irq);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 849bc9136299..240c7349284d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1396,7 +1396,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 	return ret;
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash_size
+#define BPF_MAP_CREATE_LAST_FIELD arena_percpu_chunk_sz
 /* called via syscall */
 static int map_create_alloc(union bpf_attr *attr, bpfptr_t uattr, struct bpf_verifier_log *log,
 			    struct bpf_map **mapp, struct bpf_token **tokenp)
-- 
2.47.3

