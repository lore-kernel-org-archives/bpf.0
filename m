Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1F345741;
	Fri, 17 Jul 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314568; cv=none; b=mCYm7qqqTAmG41whzuZQLzcqfi0EPBLlw2i1Vgjf6zTs6YTENm0yS/sLo7iLmg4Or8+eBatQMAU02Bhr3n6y0Ge5i8tKSE10mjtiRcwk/bKxeSAWOTz7PwqChm1z26+F2qUDP/K4A9bS3iC3Q63RAy96GVOYdJgpm9MooKVrSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314568; c=relaxed/simple;
	bh=uPvXCQ8QkM0UXt5QJvDelT5fZ4wQhH2aRcTMXl9s6cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qxgiZ5UO2BQHPQAI2qQX5Vis6ij/2l0/P9NTzcAhX06w47TTUv5ByI7rT7OWfF7tQx1c5o1CFlBuPgWj91WzFHa8iAZfN6sJiUpKoe4SWM1Y9izWw7ifr97icVi8dpPXFAuWFfd9CNHyYMAHAorNV9pT8ug1oRCsjMQbxlhBiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=CVZ66Nbi; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="CVZ66Nbi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6fslNnrJYY4f0Iggtff566fAv2juiOH4sYdmgrxCIN8=; b=CVZ66NbiL24MRcEAxXEcPMBy3D
	F3QhglAPWmxdyuk+ryXZukF7Y9yttGSPQ4wCxqbWIDa7C1PjocwSlfWEVr3XtqhEZVR5UcaittWBV
	tO4MCoP96F0c8YQqPn9x4Loh6lQnZuDwuJojP7GwwPIfEW+wDzzXsXnnkuO6iCetcuWs=;
Received: from p5b015c4b.dip0.t-ipconnect.de ([91.1.92.75] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1wknQL-001a5c-3C;
	Fri, 17 Jul 2026 20:36:38 +0200
From: Felix Fietkau <nbd@nbd.name>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>
Cc: =?UTF-8?q?Thibaut=20VAR=C3=88NE?= <hacks@slashdirt.org>,
	Stijn Tintel <stijn@linux-ipv6.be>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: Fix alignment of memory allocator objects on 32-bit archs
Date: Fri, 17 Jul 2026 20:36:31 +0200
Message-ID: <20260717183632.99195-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 kernel/bpf/hashtab.c  | 2 +-
 kernel/bpf/memalloc.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3dd9b4924ae4..900c1851d264 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2337,7 +2337,7 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 		else if (!lru)
 			usage += sizeof(struct htab_elem *) * num_possible_cpus();
 	} else {
-#define LLIST_NODE_SZ sizeof(struct llist_node)
+#define LLIST_NODE_SZ ALIGN(sizeof(struct llist_node), 8)
 
 		num_entries = htab->use_percpu_counter ?
 					  percpu_counter_sum(&htab->pcount) :
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index e9662db7198f..ca7555b1da34 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -33,7 +33,7 @@
  * Every allocated objected is padded with extra 8 bytes that contains
  * struct llist_node.
  */
-#define LLIST_NODE_SZ sizeof(struct llist_node)
+#define LLIST_NODE_SZ ALIGN(sizeof(struct llist_node), 8)
 
 #define BPF_MEM_ALLOC_SIZE_MAX 4096
 
@@ -142,7 +142,7 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 {
 	if (c->percpu_size) {
-		void __percpu **obj = kmalloc_node(c->percpu_size, flags, node);
+		void *obj = kmalloc_node(c->percpu_size, flags, node);
 		void __percpu *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
 
 		if (!obj || !pptr) {
@@ -150,7 +150,7 @@ static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 			kfree(obj);
 			return NULL;
 		}
-		obj[1] = pptr;
+		*(void __percpu **)(obj + LLIST_NODE_SZ) = pptr;
 		return obj;
 	}
 
@@ -257,7 +257,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 static void free_one(void *obj, bool percpu)
 {
 	if (percpu)
-		free_percpu(((void __percpu **)obj)[1]);
+		free_percpu(*(void __percpu **)(obj + LLIST_NODE_SZ));
 
 	kfree(obj);
 }
-- 
2.51.0

