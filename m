Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B738F64E
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502683; cv=none; b=VulLOzJ05p/HC8JIrW2b8rqDkc6Rip89OV0zJ+jpQcqtLszCVxJi+CdCb3DjBSkPP0fBOkWQ9R8wBq9d6L4EqfGRIAe0KnrlAFHiR0NeoMwgKew+fklPG5hbwVxrH2y8U5W6JFjAS4ncQf3x3hyvwaT3ywLhw4J9LYaxpeHIubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502683; c=relaxed/simple;
	bh=N0z+iOgnUpZcR0PR9xBIKBcM60dzWmlW1AX1IsrHgr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdlpiYNveL+3nJuZfT64NflMDgFzLkA821qc0Jq9BH53hltfEF2kTc/8TznIzvGCKAbAKXA7vTNIqqzvx858G4gXij4WjtX/hneg8VuL4AUsWSmi9O5uc1czRRqVq1EQRYmJBueXZMWUO2auqUl2TuKurwPjkQ/Ie8knb7dosjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rimCT7I/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rimCT7I/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35c124d2613so370207a91.2
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 22:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774502682; x=1775107482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVXUr8D+l0ObA6lwaJJ/rqnWu9Wd+yhlgQ59VMrWnqg=;
        b=rimCT7I/YYF6x7Am3HHffKbzOgfe1t30d1aIm3K/DC2J71cRLZbG2u3de8FSEgKSmB
         m6AlTkOGIOIyk4FFr5uTdIwRuf4qbfMOMoxqJiX8iG2YW4gE8zDf5adOJATSciFQaAGY
         OUa6F5Fr54nicdR4obp9lNoteWMq0RmYVwi7fDZG5HutD5hWO4B6O0SevNW5f0PV+d4O
         lMO+qFi1++CNvN9eJVdUNMzJ9TM8QRtrpkhP199E2klWkGZZ5rVviyw65z2F/Q45N/nV
         F2k1FD+96bOyBXxS5IeLKJKJT0xzDa6Qsp06uo29tEiWm3oXYNS2pltgvqKEAGiOTUoZ
         nDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502682; x=1775107482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zVXUr8D+l0ObA6lwaJJ/rqnWu9Wd+yhlgQ59VMrWnqg=;
        b=ddlACoAJER5a4SNxQNP3+rn47RDkJmV8MaKFtxezQBFhxpAPFxjNS5qRXsOWJcTft4
         Wn2V1FS9lExsLlqSsH5NpQ0tICvBHl17faanRi2WanJNMIyhLbcU+zcX6ab+Xs5SaxOx
         ao4CY4prv9t8vHut72ntVpxJ98rKwWQ1l/794/Cxuhb9penqBKC/yvoAImkgJNNMMyBX
         bJ7++s40cMQdXJSxzjiBuVd9NYcPFsCqNEr/BheBQVcc9y9q0J9JrRCqiGphtiV1FQWX
         fIqvO8HRleUJq8ADplmpH2r4qnoD11DU6y6aCKAGeMEIw7lLld1xRm3Ha10Dnxxkx8AX
         lGwQ==
X-Gm-Message-State: AOJu0Yw/cyYfjN2tEs8RxeG+n5oJHbV4TLm3JDmRvFcsETGFOeVtgyse
	xZVnxSNKuB4NcIDB8UHvlEM1zHycQXyR0CWiwZ9WmARwSG6bLVQoa5Pci0okUg==
X-Gm-Gg: ATEYQzwXKM1+5fSxjCMyYhE9VASy/O25d3fmut41XQ4rvw3S4/K3Vxpn0syfy8ncIfu
	gtrghGjKlYrmaslqXzG2jU3KT1LGkTauq6RKKye4bE5aNqnw4vhFWKNqz/CmZd/D3DEZg80pevm
	f54Z/pfQ61g8YGJZ2SUoYBKfHLNTt0PAP/NrXA6/v7AAoDqskwVUpvz/aKQTU1eLDWPhAeUqA6J
	tvOX80B93E4MJcecLXL3bz1X1uJhbYgbWD9txGM7IIoGYNo2TGi+BRYumgX8COnVCKXqQ4WfL+B
	nSM4jy7eV7nY+MHJZ2TyVgm15jSXHuARTkGIvKkXzH8mOrXvIs3YSZXTJGx4s8UBg89orvT9FhO
	pvMh66pJMTCtw9BDf3LEqqaUExim4i4PEp++8gEqhxsD7txXiaybt6FyPt7AbAWx+kbkF5dycVJ
	121JSFOUA2PUMu/nDiid/zajgn
X-Received: by 2002:a17:90a:d605:b0:35b:90e7:c453 with SMTP id 98e67ed59e1d1-35c0dcb0d47mr5876944a91.6.1774502681592;
        Wed, 25 Mar 2026 22:24:41 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a4c36fsm272488a91.4.2026.03.25.22.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:24:41 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/3] selftests/bpf: Simplify task_local_data memory allocation
Date: Wed, 25 Mar 2026 22:24:36 -0700
Message-ID: <20260326052437.590158-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326052437.590158-1-ameryhung@gmail.com>
References: <20260326052437.590158-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify data allocation by always using aligned_alloc() and passing
size_pot, size rounded up to the closest power of two to alignment.

Currently, aligned_alloc(page_size, size) is only intended to be used
with memory allocators that can fulfill the request without rounding
size up to page_size to conserve memory. This is enabled by defining
TLD_DATA_USE_ALIGNED_ALLOC. The reason to align to page_size is due to
the limitation of UPTR where only a page can be pinned to the kernel.
Otherwise, malloc(size * 2) is used to allocate memory for data.

However, we don't need to call aligned_alloc(page_size, size) to get
a contiguous memory of size bytes within a page. aligned_alloc(size_pot,
...) will also do the trick. Therefore, just use aligned_alloc(size_pot,
...) universally.

As for the size argument, create a new option,
TLD_DONT_ROUND_UP_DATA_SIZE, to specify not rounding up the size.
This preserves the current TLD_DATA_USE_ALIGNED_ALLOC behavior, allowing
memory allocators with low overhead aligned_alloc() to not waste memory.
To enable this, users need to make sure it is not an undefined behavior
for the memory allocator to have size not being an integral multiple of
alignment.

Compared to the current implementation, !TLD_DATA_USE_ALIGNED_ALLOC
used to always waste size-byte of memory due to malloc(size * 2).
Now the worst case becomes size - 1 and the best case is 0 when the size
is already a power of two.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../bpf/prog_tests/task_local_data.h          | 60 +++++++------------
 1 file changed, 22 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index a52d8b549425..366a6739c086 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -50,16 +50,13 @@
  *   TLD_MAX_DATA_CNT.
  *
  *
- *   TLD_DATA_USE_ALIGNED_ALLOC - Always use aligned_alloc() instead of malloc()
+ *   TLD_DONT_ROUND_UP_DATA_SIZE - Don't round up memory size allocated for data if
+ *   the memory allocator has low overhead aligned_alloc() implementation.
  *
- *   When allocating the memory for storing TLDs, we need to make sure there is a memory
- *   region of the X bytes within a page. This is due to the limit posed by UPTR: memory
- *   pinned to the kernel cannot exceed a page nor can it cross the page boundary. The
- *   library normally calls malloc(2*X) given X bytes of total TLDs, and only uses
- *   aligned_alloc(PAGE_SIZE, X) when X >= PAGE_SIZE / 2. This is to reduce memory wastage
- *   as not all memory allocator can use the exact amount of memory requested to fulfill
- *   aligned_alloc(). For example, some may round the size up to the alignment. Enable the
- *   option to always use aligned_alloc() if the implementation has low memory overhead.
+ *   For some memory allocators, when calling aligned_alloc(alignment, size), size
+ *   does not need to be an integral multiple of alignment and it can be fulfilled
+ *   without using round_up(size, alignment) bytes of memory. Enable this option to
+ *   reduce memory usage.
  */
 
 #define TLD_PAGE_SIZE getpagesize()
@@ -68,6 +65,8 @@
 #define TLD_ROUND_MASK(x, y) ((__typeof__(x))((y) - 1))
 #define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
 
+#define TLD_ROUND_UP_POWER_OF_TWO(x) (1UL << (sizeof(x) * 8 - __builtin_clzl(x - 1)))
+
 #define TLD_READ_ONCE(x) (*(volatile typeof(x) *)&(x))
 
 #ifndef TLD_DYN_DATA_SIZE
@@ -111,7 +110,6 @@ struct tld_map_value {
 
 struct tld_meta_u * _Atomic tld_meta_p __attribute__((weak));
 __thread struct tld_data_u *tld_data_p __attribute__((weak));
-__thread void *tld_data_alloc_p __attribute__((weak));
 
 #ifdef TLD_FREE_DATA_ON_THREAD_EXIT
 pthread_key_t tld_pthread_key __attribute__((weak));
@@ -153,12 +151,10 @@ static int __tld_init_meta_p(void)
 
 static int __tld_init_data_p(int map_fd)
 {
-	bool use_aligned_alloc = false;
 	struct tld_map_value map_val;
 	struct tld_data_u *data;
-	void *data_alloc = NULL;
 	int err, tid_fd = -1;
-	size_t size;
+	size_t size, size_pot;
 
 	tid_fd = syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
 	if (tid_fd < 0) {
@@ -166,48 +162,37 @@ static int __tld_init_data_p(int map_fd)
 		goto out;
 	}
 
-#ifdef TLD_DATA_USE_ALIGNED_ALLOC
-	use_aligned_alloc = true;
-#endif
-
 	/*
 	 * tld_meta_p->size = TLD_DYN_DATA_SIZE +
 	 *          total size of TLDs defined via TLD_DEFINE_KEY()
 	 */
 	size = tld_meta_p->size + sizeof(struct tld_data_u);
-	data_alloc = (use_aligned_alloc || size * 2 >= TLD_PAGE_SIZE) ?
-		aligned_alloc(TLD_PAGE_SIZE, size) :
-		malloc(size * 2);
-	if (!data_alloc) {
+	size_pot = TLD_ROUND_UP_POWER_OF_TWO(size);
+#ifdef TLD_DONT_ROUND_UP_DATA_SIZE
+	data = (struct tld_data_u *)aligned_alloc(size_pot, size);
+#else
+	data = (struct tld_data_u *)aligned_alloc(size_pot, size_pot);
+#endif
+	if (!data) {
 		err = -ENOMEM;
 		goto out;
 	}
 
 	/*
 	 * Always pass a page-aligned address to UPTR since the size of tld_map_value::data
-	 * is a page in BTF. If data_alloc spans across two pages, use the page that contains large
-	 * enough memory.
+	 * is a page in BTF.
 	 */
-	if (TLD_PAGE_SIZE - (~TLD_PAGE_MASK & (intptr_t)data_alloc) >= tld_meta_p->size) {
-		map_val.data = (void *)(TLD_PAGE_MASK & (intptr_t)data_alloc);
-		data = data_alloc;
-		data->start = (~TLD_PAGE_MASK & (intptr_t)data_alloc) +
-			      offsetof(struct tld_data_u, data);
-	} else {
-		map_val.data = (void *)(TLD_ROUND_UP((intptr_t)data_alloc, TLD_PAGE_SIZE));
-		data = (void *)(TLD_ROUND_UP((intptr_t)data_alloc, TLD_PAGE_SIZE));
-		data->start = offsetof(struct tld_data_u, data);
-	}
+	map_val.data = (void *)(TLD_PAGE_MASK & (intptr_t)data);
+	data->start = (~TLD_PAGE_MASK & (intptr_t)data) + sizeof(struct tld_data_u);
 	map_val.meta = TLD_READ_ONCE(tld_meta_p);
 
 	err = bpf_map_update_elem(map_fd, &tid_fd, &map_val, 0);
 	if (err) {
-		free(data_alloc);
+		free(data);
 		goto out;
 	}
 
 	tld_data_p = data;
-	tld_data_alloc_p = data_alloc;
 #ifdef TLD_FREE_DATA_ON_THREAD_EXIT
 	pthread_setspecific(tld_pthread_key, (void *)1);
 #endif
@@ -375,9 +360,8 @@ static void *tld_get_data(int map_fd, tld_key_t key)
 __attribute__((unused))
 static void tld_free(void)
 {
-	if (tld_data_alloc_p) {
-		free(tld_data_alloc_p);
-		tld_data_alloc_p = NULL;
+	if (tld_data_p) {
+		free(tld_data_p);
 		tld_data_p = NULL;
 	}
 }
-- 
2.52.0

