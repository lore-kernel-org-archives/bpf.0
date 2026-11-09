Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248467;
	b=wJrZa/pXUN8UyOxGUdt7lyPgHm2TWNhf0JXvaLlTUg9SBiDPCRVrN3LiJam0qg2SvLRx
	 7ZEiCnZHEQ5LMPkZGmTvzZH7FWV/85mhtk4UKMEroJRMYJIMyG4Q3hj+5La4oDaIcDzJv
	 WTkT905aUbr39XFd+PvIHdCwOQXFUU65mA3AXRWQQKMPqDtnOasO98+EzYgFg781qcX9x
	 UeNrtsS8rjEUy1soIR8xGmpyhfbiFspna+otAXWyey47avrfVOcAMdkEOcyfDse+kOHYT
	 yZWDHyDxO1k4lkJPPYuK9aCGsygw9qHeoaQkqpPxBCDzZSP5GNnKx33mzza9mOh6sZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kBTFDmr0hg9j51YQ7mr3X1vYxMgnUHmJxEg8X7KqKHA=;
	b=UIGJeQSll3lZgpnQxl3BMCEMZxe7Qow9s3k5BDzqwyz3qdp3Kqiyn3UtrTwMtw1M/SfU
	 /RgZLzjmjgtV2ZpVnqKVaor2+v5VCeFNH+WiOWHxTlwSTHCynUjUtCmXD44C7AaIVeNXN
	 ZvIkg0FcIqFaVmnujg1jDFUlanpAL2lNIc/AtLMaPwOkvL14gOZHH/C7lqDmDzNoAH5Uq
	 +sia2dDJyLJN4cKx1/8JPfcdnJKUda4SG4Lp3OOd99bbOA34tyz/KJLGzsX2Q2FFRp6Z1
	 9vTed5uC/DdtcgLhvLiMmcr26wgn/t4gygIW4bd9ZI9q3nmCUk9Rr2wk1+wVlNKxlEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b="FOkbzdV/";
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B4560A3808
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29B4560A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=FOkbzdV/
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso609219a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248466; x=1794853266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kBTFDmr0hg9j51YQ7mr3X1vYxMgnUHmJxEg8X7KqKHA=;
        b=FOkbzdV/v7dGJdxhxMzF1HdCG/GbetgaRItDVccIho5Kbxq5tANSrIdcGdnofHtf+v
         /cRdk1OD5AnE7af2cz3MONXQehckRiIUwRkKmQszwVe0fVKHLTWqyXpxpHhfoz8eE1b4
         ZVvY1c8OPKbaFboP64ErBPIHlg/we2nCNFE4mnYmTPhQi4tmbW40HqX3zZtYeWW0/FSW
         iiGTzWMjSQiI0Y1aGFTNgV6SyNoROA/civRXlqTzsFFTMEFomTmDCDlDJdt3+Ix3LIvy
         Gde0OZAg8EWqjcSZ4FlFbIlheaORQv9o3VyQ4D3G7xDR/vsQu1eRiQWMVsx5PTNY7Ta/
         G/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248466; x=1794853266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kBTFDmr0hg9j51YQ7mr3X1vYxMgnUHmJxEg8X7KqKHA=;
        b=vM9lNttnHLATDM94n2EDQLA5/t2sWC9STXagMSDXaeLwPrpLyNinIPE68MtsfhTh9G
         evUWk0EyOLExmQ/6yYrrYFEOe6jqokdBySiDPgdEkZAoQ3JxoRGZtdyf2O59kFYMkQGm
         hBIydzVcGzAJQZ1bjEMxL2B0VX50tp89zw2m51HBGk0RPfD23AwofigV2CQLNnTlGhv2
         ZZTVO+o7J4IXojFMBFK9tnF/YuC0XxeIUB63tqMsdx3WCG8itFFnbC96GHUVUMZicHIW
         kDaOhLoX552gou0k+7EtpxvJb+HlU+Q9ZdHDIN/E7YJiErLE0Ez/zikR5O4CYz2BiTVw
         Jwzg==
X-Gm-Message-State: APuU4Z96cCBHt7GFByD/oJrcVXv7sUBVHOJtJyGuk47JW7bmMJljqefe
	u3STnR6Rn59S7dIKpAHP6GBFCYyH2HYSPo1jQ0Dc6MnwcD4iJccUhkwfyuhUGU8T0e/xf0V1CtJ
	Hp0hIqkU=
X-Gm-Gg: AYBFou3WwHR1qnJEtsogNBZCB0r0UTO1r1MmFH2b3lCROWm4feaVEoc5GXKb4N7L4si
	73lgAf2rYCZ69camTh/Yh3fAlaFYLDl6RnnfZSfzw/RTmY/VNjTlkbGfMLMdVctWykWN+RuSneW
	lclbCCSzyS7AqOW/j9VEg5H14UdBylShEW08hmJKU7xF+tSXZPoEgyH/vMQBWdptfggdWtMFT88
	0c22UPzBjXE/NFbwuwF0qmd8qVtwVT5W3Eicf6TtTRS3r3VqzrESqvKC+gLd6LbwxyzcGGOJY1O
	6BtGBSO8N839wDgZXj7GvlFgCspSO/4mbMH3T69RtXPSXMqj4HyidT+W8dOxiqJ/7zKcxjgAxCn
	dmha+bxfk0QBPXc5slSNBXDSy/Eg3GZBq1qHtuQpA44/I050FJVR2vjK8gdGV32H4PfYMR9R8E+
	YOaTUGKjSA+Y9tgZM20aODk4WwU94v1gRnkWO6QyBIzugNfDWhuxrjeuXI0eb8zVklkksNnk6Uy
	gMRhBFICat5lMLbO0MwmT0cZu9fpKWWmtC/VJHUkEo1XHuhwrNL8JiCZjc2Yxn9Si9JQUyAxbNg
	8rApKsDBIucKxQ+Q/FAgdvOKE+AhJjqsqM/O4WReQxd8uTkq2nnIaVygzKNqYbLqHXxmZryW4U1
	Vax/KXMlieg9oQtIQZ89+oPscUgQ=
X-Received: by 2002:a17:90b:4ad0:b0:3ae:5572:c4e2 with SMTP id 98e67ed59e1d1-3b166fd8b9cmr431503a91.57.1794248466338;
        Mon, 09 Nov 2026 10:21:06 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1676e2974sm474860a91.9.2026.11.09.10.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:21:05 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 6/9] selftests/bpf: libarena: Handle NMI reentrancy
Date: Mon,  9 Nov 2026 18:20:51 +0000
Message-ID: <20261109182055.7581-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109182055.7581-1-emil@etsalapatis.com>
References: <20261109182055.7581-1-emil@etsalapatis.com>
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

An NMI can interrupt the buddy allocator while it holds the buddy lock, so
code running in NMI context must not wait for that lock.

Use trylock for buddy operations in NMI context and normal locking in other
contexts. If the buddy lock cannot be acquired, allocations return NULL
and frees transfer ownership to an intrusive deferred-free list.

Drain deferred frees on a later successful lock acquisition, including
from NMI context.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |   3 +
 .../bpf/libarena/selftests/test_buddy.bpf.c   |   2 +
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 128 ++++++++++++++++--
 3 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index ec5e79a07540..7553ad5a879d 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -49,6 +49,8 @@ struct buddy_header {
 	u32 next_index; /* Same for the next allocation. */
 };
 
+struct buddy_deferred_free;
+
 /*
  * We bring memory into the allocator 1 MiB at a time.
  */
@@ -103,6 +105,7 @@ struct buddy {
 	arena_spinlock_t lock;			/* Allocator lock */
 	u64 vaddr;				/* Allocation into reserved vaddr */
 	struct buddy_cache __arena *percpu[BUDDY_CACHE_MAX_CPUS];
+	struct buddy_deferred_free __arena *deferred_free;
 };
 
 #ifdef __BPF__
diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
index 85a7ea8b2e97..e7c6ac76433c 100644
--- a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
@@ -44,6 +44,8 @@ __weak int test_buddy_create(void)
 		ret = buddy_destroy(&buddy);
 		if (ret)
 			return ret;
+		if (buddy.deferred_free)
+			return -EINVAL;
 		if (buddy.percpu[0])
 			return -EINVAL;
 	}
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index 13c55cf53e52..4d4d21356935 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -6,6 +6,7 @@
 #include <libarena/buddy.h>
 
 #include <bpf_arena_spin_lock.h>
+#include <bpf_experimental.h>
 
 _Static_assert(BUDDY_CACHE_MAX_CPUS == _Q_MAX_CPUS,
 	       "buddy caches must cover every CPU arena spinlocks support");
@@ -46,10 +47,14 @@ static int idx_is_allocated(struct buddy_chunk __arena *chunk, u64 idx, bool *al
 static u64 arena_next_pow2(__u64 n);
 static u64 size_to_order(size_t size);
 static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size,
-					int order, size_t norder);
+					int order, size_t norder, bool grow);
 static int buddy_free_unlocked(struct buddy __arena *buddy, u64 addr);
+static bool buddy_deferred_free_pending(struct buddy __arena *buddy);
+static int buddy_deferred_free_complete(struct buddy __arena *buddy);
 
-#define buddy_lock(buddy, flags) (arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
+#define buddy_lock(buddy, flags)						\
+	(bpf_in_nmi() ? arena_spin_trylock_irqsave(&(buddy)->lock, (flags)) :	\
+			arena_spin_lock_irqsave(&(buddy)->lock, (flags)))
 #define buddy_unlock(buddy, flags) (arena_spin_unlock_irqrestore(&(buddy)->lock, (flags)))
 
 /*
@@ -747,6 +752,7 @@ __weak int buddy_init(struct buddy __arena *buddy)
 
 	if (!asan_ready())
 		return -EINVAL;
+	buddy->deferred_free = NULL;
 
 	/* Reserve enough address space to ensure allocations are aligned. */
 	ret = buddy_reserve_arena_vaddr(buddy);
@@ -817,6 +823,7 @@ __weak int buddy_destroy(struct buddy __arena *buddy)
 
 	/* Clear all fields. */
 	buddy->first_chunk = NULL;
+	buddy->deferred_free = NULL;
 
 	return 0;
 }
@@ -970,6 +977,13 @@ static void __arena *buddy_alloc_memory(struct buddy __arena *buddy, size_t size
 	if (buddy_lock(buddy, flags))
 		return NULL;
 
+	if (unlikely(buddy_deferred_free_pending(buddy))) {
+		if (buddy_deferred_free_complete(buddy)) {
+			buddy_unlock(buddy, flags);
+			return NULL;
+		}
+	}
+
 	address = (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order, norder);
 	buddy_unlock(buddy, flags);
 	if (address)
@@ -1176,10 +1190,90 @@ static __always_inline int buddy_free_unlocked(struct buddy __arena *buddy, u64
 	return 0;
 }
 
+static bool buddy_deferred_free_pending(struct buddy __arena *buddy)
+{
+	return buddy->deferred_free != NULL;
+}
+
+static __always_inline void buddy_deferred_free_push(struct buddy __arena *buddy,
+						   void __arena *first, void __arena *last)
+{
+	void __arena *head;
+
+	do {
+		head = READ_ONCE(buddy->deferred_free);
+		*(void __arena * __arena *)last = head;
+	} while (cmpxchg((void __arena * __arena *)&buddy->deferred_free,
+			 head, first) != head && can_loop);
+}
+
+static void buddy_deferred_free_start(struct buddy __arena *buddy, void __arena *addr)
+{
+	/*
+	 * Make a linked list by chaining the allocations into a linked list.
+	 * Possible because allocations are 16 bytes minimum and so fit a pointer.
+	 */
+	asan_unpoison(addr, sizeof(void *));
+	buddy_deferred_free_push(buddy, addr, addr);
+}
+
+static void buddy_deferred_free_start_bulk(struct buddy __arena *buddy,
+		 void __arena * __arena *addrs, size_t naddrs)
+{
+	void __arena *first, *last, *addr;
+	unsigned int i;
+
+	/*
+	 * Chain the allocations into a local linked list. Possible because
+	 * allocations are 16 bytes minimum and so fit a pointer.
+	 */
+	first = NULL;
+	last = NULL;
+	for (i = zero; i < naddrs && can_loop; i++) {
+		addr = addrs[i];
+		if (!addr)
+			continue;
+
+		asan_unpoison(addr, sizeof(void *));
+
+		if (!first)
+			first = addr;
+		else
+			*(void __arena * __arena *)last = addr;
+
+		last = addr;
+	}
+
+	if (!first)
+		return;
+
+	/* Splice the local list onto the deferred-free list. */
+	buddy_deferred_free_push(buddy, first, last);
+}
+
+static int buddy_deferred_free_complete(struct buddy __arena *buddy)
+{
+	void __arena *head, *old;
+	int ret = 0, err;
+
+	head = __sync_lock_test_and_set((void __arena * __arena *)&buddy->deferred_free,
+					NULL);
+
+	while (head && can_loop) {
+		old = head;
+		head = *(void __arena * __arena *)head;
+
+		err = buddy_free_unlocked(buddy, (u64)old);
+		ret = ret ?: err;
+	}
+
+	return ret;
+}
+
 __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 {
 	unsigned long flags;
-	int ret;
+	int ret, err;
 
 	if (!buddy)
 		return -EINVAL;
@@ -1193,20 +1287,28 @@ __weak int buddy_free(struct buddy __arena *buddy, void __arena *addr)
 		return 0;
 
 	ret = buddy_lock(buddy, flags);
-	if (ret)
-		return ret;
+	if (ret) {
+		buddy_deferred_free_start(buddy, addr);
+		return 0;
+	}
 
 	ret = buddy_free_unlocked(buddy, (u64)addr);
 
+	/* Drain any frees stranded during NMI/lock failure. */
+	if (unlikely(buddy_deferred_free_pending(buddy))) {
+		err = buddy_deferred_free_complete(buddy);
+		ret = ret ?: err;
+	}
+
 	buddy_unlock(buddy, flags);
 
 	return ret;
 }
 
 /*
- * Fails only when the arguments are invalid or the buddy lock cannot be taken.
- * Nothing is freed in either case. Objects that buddy_free_unlocked() rejects
- * are reported there.
+ * Reject a NULL buddy or a NULL address array for a nonempty batch with -EINVAL.
+ * Valid objects are freed under the buddy lock or deferred on lock failure.
+ * Objects that buddy_free_unlocked() rejects are reported there.
  */
 __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *addrs, size_t naddrs)
 {
@@ -1224,8 +1326,10 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
 		return -EINVAL;
 
 	ret = buddy_lock(buddy, flags);
-	if (ret)
-		return ret;
+	if (ret) {
+		buddy_deferred_free_start_bulk(buddy, addrs, naddrs);
+		return 0;
+	}
 
 	for (i = zero; i < naddrs && can_loop; i++) {
 		/* NULL pointers are ignored. */
@@ -1235,6 +1339,10 @@ __weak int buddy_free_bulk(struct buddy __arena *buddy, void __arena * __arena *
 		buddy_free_unlocked(buddy, (u64)addrs[i]);
 	}
 
+	/* Drain any frees stranded during an NMI/lock failure. */
+	if (unlikely(buddy_deferred_free_pending(buddy)))
+		buddy_deferred_free_complete(buddy);
+
 	buddy_unlock(buddy, flags);
 
 	return 0;
-- 
2.52.0

