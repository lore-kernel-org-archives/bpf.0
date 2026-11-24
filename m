Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560668;
	b=dXTCbrE89tLJ5seYTPsCzd8jlMUgWGZmO0a1EFTj7hx1G87MLAgPwouQlpDjeXOw6egC
	 368vDI8XwnDJpP6pY1DyavZ8RDp0SU6Hxx+a1K3bjFJVKfw6HMp9gOAfBb6v5jDKc+jIa
	 ve+qEQHDnOzFlWtY0FWdrtDKN6ySVAmoUo3QdBtwxPZOxUqugO9Ef7XYnP6sLn5g7TIZU
	 6AtVx4nE/Tbpmpg5WB1IqFDZy9RCC3bHlZY9xuRFIxRmNrGH9cgkhbW8PgT7eb5GJVZIB
	 Dm1lXi7Mi2hf/QgCIMRtTHDQQTZihwHF/NMZd1Nh60Q7tIb1bVEA9emMxLduYQi7ANQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=jrigqiEu/nUvTtr8hgpZahiDD4O3PEjOJSdql4Qjodk=;
	b=lQSluydpi9etrtVTejcNwxFp6PWFMHsLwRTnJgEdRakK5QSxHpjpFRP7qNz7k2RAafMz
	 aOoOIE/5QopII90gMZpAZlqLpra8ZtmnR71UYCbN7x8W7nKH3LZceLyRZnBUkw/gyJdZE
	 EjQ5CBK+8aTHGFk8oPCkDHKY71c2ngYGmw/vgUI3G18BKme4B23HyW5Vh6LoEvvBdIZXs
	 axeNK8F3q0AyJbjkSE8IkpztZTP8qd2Cp+bIKBxx26OrV4bnhug4K+dMAUv6Jx3skYilU
	 EYleUwjzL1koQtN8WZW+1OOIaIDcCtjngzvCqynqPMV4sxqNUwmzVUyZB56+LR94cBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IwU9Qbho;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03661606A683
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 22:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03661606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IwU9Qbho
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bba5e17728so545935e9.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795560666; x=1796165466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jrigqiEu/nUvTtr8hgpZahiDD4O3PEjOJSdql4Qjodk=;
        b=IwU9QbhodXzlLDRauWBLrFbli/b9ei5ev5Yr6svDKdoANACaA9KLxcnMoSiHjB2uQL
         Fcdp5U9gh74slg4rFlwZHdSadfT6fhg4WDhi1i3MABxRtGG6ZDLzyDi7/+7EHkmIEl34
         S8KIhqYfbkxrK85wMruIrUnGuvmWJKChn7HwavPJsaDZ8C89ZfgYugOKlQjmdbHR7GcC
         HXjCYimCXcEMPCd7mKCxsIf90YhibXQBMus2F3VR+zJLk/Sy8ZBoqsmldO6zjOstdVyD
         l3ZweCwHPPW5c4cDA2tRXMo+yhYDHUqNsc2Qomy96/mVnHn5FtmOKe8Fy3oNPk/cubNM
         bVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560666; x=1796165466;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jrigqiEu/nUvTtr8hgpZahiDD4O3PEjOJSdql4Qjodk=;
        b=HgKXnYkfAZ6SNO6yEq0EkMNl675E6iYyYhJcwNkzHYjmdsHrVqjPiaSSkd8fX8wa/D
         qdgUGVjgA2H89mnUHvpKH3brvPmQWp9YvC7UHUrsFHPp4cRm4maCo4HzN6lztMwtfzzh
         s+ePOAz9iNVU/8AAKLzTAX/bJ1JmvF4Hm2vkGMorS3h5hL/iFok97V5ftXnJVKh6d1zs
         wLsnZS7zipygVrByoQPiCgyxvGOHNx7RDLcbLjuTg345VccRdWriE8xdutSkMspOOHHx
         txOe53zyTCgaWPNJk0Lu1dHary5KOOAzx+ZMsKHp3N2FhiiMZstIYX0bGI/qmb3M8q1c
         tQbA==
X-Gm-Message-State: APuU4Z+wx5kq3RXtYlXDTyuaAk/FJiori6VkY8Tj8meG5xjBSE8wYodX
	VIpIVyNcru2Sh7eJCeudXa1W0UdaSFJc1Y3Yz9Pnts0lpraTAqLAGiSno5YHjs4=
X-Gm-Gg: AZFdTZevBWzsleczn22f8BsYNScFrtPBcY4r63VjEKHwK55Oya+UIdkXaDe/x9hBHsU
	kI3aVQBvenyLHfHcbh9ghyBH4TRT6CS/r6QTwIndvGMrn1TGLGPokWkkoQHgooTL08nJN3Hip/7
	DP1gu8u79k/kk/p7ZcA6zDmW+eqoRLKReit0BERw/0FjKw4scRp/H2YC5bGdvY2vmINvY/LZeqQ
	zMmd/idz5KXprOsQ/vw5kieTQbNklGbPvjY1r6K1hcENfUc0jlXiNQBlTy4Jjm2kgvIry7vOF1u
	15BEmD1/zOlU9WN5ZSsxESycxbz3SrE1Fd87JUjI57d8X4kaYHcm1DJXCAwJe0AepBIijiYNSDr
	4apx9R42A7FkYu5eznVQS3zGtjQn58u9pxS7Na6w6loWtx7CGpPywgHLgYdiiHh2wmiiv/ALP7c
	EqOwiajhCFsKWJqLJ1omrjJNj6bdD+pEHVrvvQw8oFP+95Vq6CwhyGbie+Uc9zI29j6lAZLfgr1
	b1O7IDF928SaeN1WmZ953UvWBh01wxOcpzO8lSsrrNdpwruPR3Wd1Gm+X0F98DPYYMgH49GrpjN
	d47hFMHkZpO+fzgVgD9riz7Kd5nR3/2xUQxjtLNqc1BZgcIpQpEgdiY7qPwYgNWaLrtFH08wqBm
	dJ/iEiIEJbhooX3Emw2+o7sIbK8wNX+7N+NCauyNGDBfj22qc5w/0UgTTOD2/5HzWPmwwLNBhUz
	sMsaZeX2W+/kjnpqdhjn1bL7Cma8nmpiSP
X-Received: by 2002:a05:600c:3b8a:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4bb8892da25mr318594355e9.22.1795560666345;
        Tue, 24 Nov 2026 14:51:06 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-2ec1-8a00-a10d-4335-1e05-e7ae.310.pool.telefonica.de. [2a02:3100:2ec1:8a00:a10d:4335:1e05:e7ae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm393839525e9.9.2026.11.24.14.51.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 14:51:05 -0800 (PST)
From: Tobias Philipp <tphilipp@gmail.com>
To: bpf@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks@slashdirt.org>,
	Stijn Tintel <stijn@linux-ipv6.be>,
	Daniel Mack <daniel@zonque.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Philipp <tphilipp@gmail.com>
Subject: [PATCH bpf-next v2 1/4] bpf: Fix alignment of memory allocator objects on 32-bit archs
Date: Tue, 24 Nov 2026 23:50:52 +0100
Message-ID: <20261124225055.87344-2-tphilipp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124225055.87344-1-tphilipp@gmail.com>
References: <20261124225055.87344-1-tphilipp@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

The BPF memory allocator prefixes each object with a header that holds
struct llist_node while the object sits on a free list, and a pointer
to the owning bpf_mem_cache while it is allocated. The header size was
sizeof(struct llist_node), so on 32-bit architectures the memory handed
out was offset by 4 bytes from the 8-byte aligned kmalloc allocation.

The verifier assumes that allocated objects are 8-byte aligned and
allows BPF_DW atomic instructions on their u64 fields, e.g. on values
of non-preallocated hash maps, objects from bpf_obj_new() and local
storage. On arm32 the JIT does not implement atomics, and the
interpreter executes them via atomic64_*(), which are implemented with
LDREXD/STREXD on ARMv6K and later. Those instructions require 8-byte
aligned addresses; a misaligned address raises an alignment fault and
crashes the kernel.

Pad the header to 8 bytes to preserve the alignment provided by
kmalloc. Store the percpu pointer of percpu objects at the new header
offset instead of assuming the header is pointer-sized, and update the
copy of the header size used by the hash map memory usage accounting.

Fixes: 7c8199e24fa0 ("bpf: Introduce any context BPF specific memory allocator.")
Reported-by: Thibaut VARÈNE <hacks@slashdirt.org>
Reported-by: Stijn Tintel <stijn@linux-ipv6.be>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/all/20260717183632.99195-1-nbd@nbd.name/
[tphilipp: rebased onto bpf-next, adjusted context in hashtab.c.
 Local storage no longer uses bpf_mem_alloc in bpf-next. On 32-bit
 this patch moves an IPv4 lpm_trie value from 0 to 4 mod 8; the next
 patch fixes that, so both have to be applied together.]
Signed-off-by: Tobias Philipp <tphilipp@gmail.com>
---
 kernel/bpf/hashtab.c  | 2 +-
 kernel/bpf/memalloc.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a2d0bfd4c..b84911054 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2594,7 +2594,7 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 		else if (!lru)
 			usage += sizeof(struct htab_elem *) * num_possible_cpus();
 	} else {
-#define LLIST_NODE_SZ sizeof(struct llist_node)
+#define LLIST_NODE_SZ ALIGN(sizeof(struct llist_node), 8)
 
 		num_entries = bpf_map_sum_elem_count(map);
 		usage += (htab->elem_size + LLIST_NODE_SZ) * num_entries;
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 15684d0fc..29d62d864 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -33,7 +33,7 @@
  * Every allocated objected is padded with extra 8 bytes that contains
  * struct llist_node.
  */
-#define LLIST_NODE_SZ sizeof(struct llist_node)
+#define LLIST_NODE_SZ ALIGN(sizeof(struct llist_node), 8)
 
 #define BPF_MEM_ALLOC_SIZE_MAX 4096
 
@@ -148,7 +148,7 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 {
 	if (c->percpu_size) {
-		void __percpu **obj = kmalloc_node(c->percpu_size, flags, node);
+		void *obj = kmalloc_node(c->percpu_size, flags, node);
 		void __percpu *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
 
 		if (!obj || !pptr) {
@@ -156,7 +156,7 @@ static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 			kfree(obj);
 			return NULL;
 		}
-		obj[1] = pptr;
+		*(void __percpu **)(obj + LLIST_NODE_SZ) = pptr;
 		return obj;
 	}
 
@@ -262,7 +262,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 static void free_one(void *obj, bool percpu)
 {
 	if (percpu)
-		free_percpu(((void __percpu **)obj)[1]);
+		free_percpu(*(void __percpu **)(obj + LLIST_NODE_SZ));
 
 	kfree(obj);
 }
-- 
2.54.0 (Apple Git-157)

