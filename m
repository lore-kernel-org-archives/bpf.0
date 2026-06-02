Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21DB30C637
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 00:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360898; cv=none; b=XDAMwa9WfVl8MacyxgpA8ICbB5Nd1e8oyrYPW/UQGdoJJX3/mp7/7/bTo/z6Tz9eTuBsHW7qsQq4+6Ug43xkgllIVyK3LScypbRKYsXy2N2T0NYoxsF38e9OrwfCR2du4abuzLhcH6NuZ7U8zoLtXJcemxWUy/Rpnv3ZNBZ35nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360898; c=relaxed/simple;
	bh=sdCe9MxbLk9eDM5yR4uzUvv9RVBREfEwU6cFymJz1EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gllLt7QYaTbm9Mq+RTMSauU3xPzDOAZTxxXs4k14U2L70b2Dz6AmvPkvEkBWvzKiY0Nz+K+ja48p1aWRGDMTLo4GyuvNLdw9pfH1BVMeeRiYscsiq8EvNyyQtv/cmHEiuTskx1+XQWczM9fF9eRFg9jGDwwSKj9ychMvxumJ61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=aWwP8pLP; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="aWwP8pLP"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304545f5206so14842784eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 17:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780360896; x=1780965696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkE+DDtvKiradbMJHxOIKNN8/izZ/y0QI8WToXPVs1I=;
        b=aWwP8pLPullGx6Q+07N1fUmy7T0mFoFSM3RdWq/j6prsyGNMYYXs6ly6g8z7M0JGi3
         VlWMjk2IwIBE+IUM/WQiobjOPgnPvYNoKpbkbESL5m0hwGhZmncEyquGTGMFKE0kN/zd
         NJ1BkKwvdMDN4olV2K38BeNcJYVicIyhANxR/ce/IEKOD/pvLrpVufXCrzX8nO4madm5
         Jb7hcW5GGUdoHmgrZTsCotZwPmmgEDqpQmMg6dFWbB/bhzzg39ZDA+AHvLBhsLfYU2+b
         F/3AFYhXsd3MChhfte3WfTEBDUqyKe88EnqY7CqUWsoq15cDNfeAbcCZu9LGuezV2WpB
         PMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780360896; x=1780965696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YkE+DDtvKiradbMJHxOIKNN8/izZ/y0QI8WToXPVs1I=;
        b=q4YdmSfdSR9n+Is0eCHLq7//C/8yB6Y8fLt4ThTsk0yosRO9wuyHiG+2wEMZ0nOOz8
         OeBYrhUqjI8iYfGHibv1jPGrp2MeAPIMomWect3d8eVRdHzQhhIfYkVJliAjATmjEdHf
         uVponDinfmuzozin4bSPSTnUZt+HkqtyPxULluAyyNZHioDUwFzz8FzxVHS3+W43G+MU
         SbY3/rl47u31v6g2b3aQ9KtC5dQwYsEtdP03bGM1tnLLcVLFeuzSGRcKzqqm3KGfeCLi
         ynAiC8ygfqxJCZIglslxLVe6GiEr+5VACRF8LqjBQwL9SDZC7YycdbXWQA1Esn1Y3C9J
         covA==
X-Gm-Message-State: AOJu0YzcDaIaoX3ofGvPHWc1qMiWaUTnRJ26pOnVbBfbQlf8t1Mogh+h
	oGjEp1RC7yRzSX57HYlGfGfQnb5cJ/LtVT5S1PQ9WcRlLtSqUhTrcjufYLkaj026HpCHOAnSti5
	o2qc9mo3WM29G
X-Gm-Gg: Acq92OFwcEsfaZVsuQyLoo5HrNGWPZURuUo0f3HdXuHf307YGsyTxc56Xw0WjAj6BiQ
	DSiOyAIhd8C/xKsmZD26a1wRT0qLNoWKlCx9LjMoxGRwwRktCkLCugV2QYIWAGltqbd8QWXgBlP
	ZauOeOAFAcjVrlwkmeKEUT5CNv4o9zkrIqbve2lZ7Js3Y4C8C+GFeL+GE19W4ldVfAQck0H61nB
	/3wEz+JnJU5cPIfTKLeB596Yr/nRcxT5jbBJVMZFnamUlaXrOiq2v1gprMRG8D1B1w5xtKX3fcg
	ATw+4+loB6Reuyphiyf7LdHAG+VkDBmBL3a2TMBTteQ+2xQsoKG2ryNQ3hVDy9Iqa7Sv54wpeOp
	92lNpRsOrE6Bzpa+Js5fXpqPXkItE5L8kcsLN0kq6ALnRqI7hYq7zDRAg1HYIQIKWMtWxphhlfm
	KNcgeCeK1fZsS5QhqCG5jjCav8EBbJtA==
X-Received: by 2002:a05:7300:ef83:b0:304:b14:ec53 with SMTP id 5a478bee46e88-304fa647e11mr5776594eec.27.1780360895937;
        Mon, 01 Jun 2026 17:41:35 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::4f12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed5d5385sm10172018eec.28.2026.06.01.17.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:41:35 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	mattbobrowski@google.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 5/6] selftests/bpf: libarena: Directly return arena pointers from functions
Date: Mon,  1 Jun 2026 20:41:19 -0400
Message-ID: <20260602004120.17087-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602004120.17087-1-emil@etsalapatis.com>
References: <20260602004120.17087-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the __arena annotation includes a BTF type tag, and the
verifier can identify arena pointers at BTF loading time, return
arena pointers as their true type instead of casting to u64. Remove the
preprocessor typecast wrappers used to hide this from the caller.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/libarena/include/libarena/buddy.h     |  3 +--
 .../bpf/libarena/include/libarena/common.h    |  3 +--
 .../selftests/bpf/libarena/src/buddy.bpf.c    | 20 +++++++++----------
 .../selftests/bpf/libarena/src/common.bpf.c   |  4 ++--
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
index 4d57fc1b5c26..528c69a1f38e 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/buddy.h
@@ -76,7 +76,6 @@ struct buddy {
 int buddy_init(struct buddy __arena *buddy);
 int buddy_destroy(struct buddy __arena *buddy);
 int buddy_free(struct buddy __arena *buddy, void __arena *free);
-u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size);
-#define buddy_alloc(alloc, size) ((void __arena *)buddy_alloc_internal((alloc), (size)))
+void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size);
 
 #endif /* __BPF__  */
diff --git a/tools/testing/selftests/bpf/libarena/include/libarena/common.h b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
index ca1a6c1d6477..a3eb1641ac36 100644
--- a/tools/testing/selftests/bpf/libarena/include/libarena/common.h
+++ b/tools/testing/selftests/bpf/libarena/include/libarena/common.h
@@ -48,8 +48,7 @@ extern volatile u64 asan_violated;
 
 int arena_fls(__u64 word);
 
-u64 arena_malloc_internal(size_t size);
-#define arena_malloc(size) ((void __arena *)arena_malloc_internal((size)))
+void __arena *arena_malloc(size_t size);
 void arena_free(void __arena *ptr);
 
 /*
diff --git a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
index f4ed4c3abb4b..c674ee5cfcc1 100644
--- a/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/buddy.bpf.c
@@ -750,25 +750,25 @@ static u64 buddy_alloc_from_new_chunk(struct buddy __arena *buddy, struct buddy_
 	return (u64)address;
 }
 __weak
-u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size)
+void __arena *buddy_alloc(struct buddy __arena *buddy, size_t size)
 {
-	u64 address = (u64)NULL;
+	void __arena *address = NULL;
 	struct buddy_chunk __arena *chunk;
 	int order;
 
 	if (!buddy)
-		return (u64)NULL;
+		return NULL;
 
 	order = size_to_order(size);
 	if (order >= BUDDY_CHUNK_NUM_ORDERS || order < 0) {
 		arena_stderr("invalid order %d (sz %lu)\n", order, size);
-		return (u64)NULL;
+		return NULL;
 	}
 
 	if (buddy_lock(buddy))
-		return (u64)NULL;
+		return NULL;
 
-	address = buddy_alloc_from_existing_chunks(buddy, order);
+	address = (u8 __arena *)buddy_alloc_from_existing_chunks(buddy, order);
 	buddy_unlock(buddy);
 	if (address)
 		goto done;
@@ -776,12 +776,12 @@ u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size)
 	/* Get a new chunk. */
 	chunk = buddy_chunk_get(buddy);
 	if (chunk)
-		address = buddy_alloc_from_new_chunk(buddy, chunk, order);
+		address = (u8 __arena *)buddy_alloc_from_new_chunk(buddy, chunk, order);
 
 done:
 	/* If we failed to allocate memory, return NULL. */
 	if (!address)
-		return (u64)NULL;
+		return NULL;
 
 	/*
 	 * Unpoison exactly the amount of bytes requested. If the
@@ -789,10 +789,10 @@ u64 buddy_alloc_internal(struct buddy __arena *buddy, size_t size)
 	 * unused bytes that were part of the header.
 	 */
 	if (size < BUDDY_HEADER_OFF + sizeof(struct buddy_header __arena))
-		asan_poison((u8 __arena *)address + BUDDY_HEADER_OFF, BUDDY_POISONED,
+		asan_poison(address + BUDDY_HEADER_OFF, BUDDY_POISONED,
 			    sizeof(struct buddy_header __arena));
 
-	asan_unpoison((u8 __arena *)address, size);
+	asan_unpoison(address, size);
 
 	return address;
 }
diff --git a/tools/testing/selftests/bpf/libarena/src/common.bpf.c b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
index ec9de29e6f3e..50be57213dfb 100644
--- a/tools/testing/selftests/bpf/libarena/src/common.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/common.bpf.c
@@ -38,9 +38,9 @@ __weak int arena_buddy_reset(void)
 	return buddy_init(&buddy);
 }
 
-__weak u64 arena_malloc_internal(size_t size)
+__weak void __arena *arena_malloc(size_t size)
 {
-	return buddy_alloc_internal(&buddy, size);
+	return buddy_alloc(&buddy, size);
 }
 
 __weak void arena_free(void __arena *ptr)
-- 
2.54.0

