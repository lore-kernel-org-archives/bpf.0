Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152315;
	b=Y/dsjeU62M+hPRbZL+4IisQxMlXCgef9pexL62OragoIIZ9BFlAt7f9T2k5ZdMxSj/wn
	 VuUZZ2TpIBDLtSRuuM0DpZWt8yeYSZ0dTMG5qrjxG+RD+tkV5jUPd6TcGeNSLP+8TfUW6
	 OIQPKIINh4EYHV7EP943XXe0oYpLKGapl362TOq/uYPRyk2WPxmgdfjQv26+GOcs1p0C2
	 lNirb/xgZeIXrsIeWpNlzbXuo/9+ey0gnCyc6200Bl9F//K+S7VIQ76CaMDVrLFIE3WDK
	 IO7ypf3Wp4LYJy+FTJcXEUpjOGyowpGLd0Tl+oS/UZRHUMh1plhrAJIazqt8BHXKheQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gCN3H/3wNGpPnAQtKEVAjqxPnsh0XrrZ2KtDWIg4384=;
	b=ygX3yrWCMf9trLSYN7pudKOg8gNm915k1mjmFgI68zNQzfW82hR5r3NRo0NSsoRe4JXE
	 iOJJTSWUnbSZ/QU//shL3a5waY2tC6B1istHwc/qJVYuBDTCqibWx1/x3JZFF3921cpn4
	 /AaVx4dhHDAKAszR1jLF+w4GWEr+5KzEcEwqYJBHn6kJXed+1gfZxg9yhJpSbVznManoV
	 bpje7yN1Bp2+7k5wAtdrkEGhwk6V5D/q2GmC2dBypMfZMhC0dEeeaVVIs0mKVzyusE04U
	 74c9hco0aLyr10cydWpt1o11eWxDyim0N+9GBtZJjXkaNvjrRiTh/XT87TRzaScKzww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=GkBb7lde;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0E606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 01:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE0E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=GkBb7lde
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso3583225e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793152313; x=1793757113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCN3H/3wNGpPnAQtKEVAjqxPnsh0XrrZ2KtDWIg4384=;
        b=GkBb7ldeyMOh7Hvn1sjvWMkAzyM9J1G91BGH3q0nCAd4x2Q1vq9snxAqbJBla21zz2
         QTJJ6yAirUEmipEzxswJ7/JPs3+KoQEb7ro8/luIoNTJSYKGE5CBUoqitlZ8iJBQq9SV
         BUaYTdlJzYgFjiYVrkP5msfyevEZloecoKc5wbIhvbuiXOXBKzJBqb6cwm0oFS1YwkdY
         y0OU1w/AX2vKf0ADdsRkAWf/qUVCWpZidGir/kY4T3KiBC0c7Q6SAkoj8RXJW1P1oNtt
         a3hTH1bpVyXPdT7tl6eQhnnLaMoWL6pyJFeNIS/HsuWgV4XqDlv5be0xyipyKQpWNtGE
         4KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793152313; x=1793757113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCN3H/3wNGpPnAQtKEVAjqxPnsh0XrrZ2KtDWIg4384=;
        b=vctWrMiAJy0PcqXWrlQmLM7PMpCIvc533QZI5lAx1oEmhQBOVAGCT1Y6DcJcjimH8+
         lslzIxSMu4nCefshW2RmGKVQipudUpOonTVM48XgN6hjQcB8TLS1a6TJfCcJaIlVk4fq
         y2PIJfMRDvm6S8PqX/jrPAT8jnR5Yy3QH/lFSkZX3vsdnIdWXJdewidorf8qaHKZlaEl
         ivCLQgz8bgbxb5j3IYZfc19tBYOtHaHimVtn5nDfWQV+/En5ZYzgrTxfmvVkOOJOusC7
         J4BtF8kt2tDHmo0x9V3j2t0xnxLAPRqkNQfcazmY8J8LXcung4RGprwL9tUM4AUZy4r3
         nBDQ==
X-Gm-Message-State: AFq9FYJMaAuehbMZc/d4kugHr9pjaaSuFQr1eeL8Qm1f3ZEy3Tpxyw5w
	SYu7/iA6p2If8cJlG0tRYUtAfmY2W9u/cMydHWKtv43xoGW2o4za1o/lN7HtjFGsi/JJfiZtjzk
	Rhz+Lwy9R/A==
X-Gm-Gg: AYBFou1lKeond62scwoYPU6S0Xh6sLk3gKNqqhIeRxu2o4v0p+/UYe4XoEDGrz85kgX
	C/rwECl0Yt/wK6zU22vzEfjQRCvQ4Mg5Cpqz7OxTYGeBt8xOVirFZaQzzYRCNeCPSoWAEVIFSr2
	R837hvpTE6HytONjtPDKCKyaHitpFxpwTogGia5cqljgK+sYbECVZB9kN7wlkIOu6BICa5Jgvbl
	Ri+Zovdt9Zty+cnfx06skIbUFOhulY2Up8NvTZB+1P89jpcxDYMAzLBbXd41HZVLGxlkf/8DzY5
	C78O06Fu/3da4JFMi/u7N/rBd9GCKGoc49Fv89tcBhAzVRmf5KOT+8XNih4KCmwYoliTtlVoiIV
	nkIrbxRbIzTz3pwJGtBHmqEguywknPUi5u1X9RBrDYOtUexJ73vREbv9b7if+bo6AdWMG+Kw3ZT
	W1CQ0wicNq08g8I3bS9SJyRiZep9sekH3coWfPjkE60JvP5hbFWY6RUvKnS4QMvzIIjiqiIqEvV
	79YMofKEvukYpjowSB4sQlR637lYSI0vn5YhkWp7cBOUsjoTKYFvA/y633AUPYj4YQHaf0P1BsR
	DHO28zmxcOxfLnn6JnkYizjGBg3AnpbrITt/geQ=
X-Received: by 2002:a05:6000:4006:b0:48d:ff71:dd9d with SMTP id ffacd0b85a97d-48e5d59972fmr2226596f8f.23.1793152313064;
        Tue, 27 Oct 2026 18:51:53 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c090:600::1:8dfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb9cesm26852693f8f.27.2026.10.27.18.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:51:52 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf 1/2] bpf: recover page faults across all arenas
Date: Wed, 28 Oct 2026 01:51:40 +0000
Message-ID: <20261028015141.10710-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028015141.10710-1-emil@etsalapatis.com>
References: <20261028015141.10710-1-emil@etsalapatis.com>
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

The current arena fault handling code accounts for
misbehaving BPF programs that free arena memory
while it is being accessed by a kfunc as part of
another BPF program's execution. This scenario
triggers a kernel page fault that is intercepted
by BPF arena-specific code. The code confirms
that the fault is within the BPF program's arena,
installs a scratch page, and marks the fault as
handled. This is necessary to prevent BPF programs
from being able to trigger an oops.

However, the protection against misbehaving BPF programs
is currently incomplete: Arena memory is accessed by
kernel code not just as part of a kfunc, but also from
non-BPF paths. This is the case with sched-ext that
includes non-BPF code paths that access arena pointers.
These paths do not have an arena associated with them,
and a fault there causes an oops. Such a fault can be
triggered by a misbehaving BPF program by unmapping the
pages nominally owned by the genpool allocator used for
cid management.

Extend the kernel arena fault handling to consider all
arenas in the system. The handler now scans a global
arena list till it finds an arena that includes the address,
and fixes up the address. Retain the stream-based reporting
code for when the faulting call stack includes the BPF
program that owns the arena.

Fixes: 9eca087deb0b ("sched_ext: Sub-allocator over kernel-claimed BPF arena pages")
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/arena.c | 54 ++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 868589f07330..992a0b123449 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -10,6 +10,7 @@
 #include <linux/btf_ids.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
+#include <linux/rculist.h>
 #include <asm/tlbflush.h>
 #include "range_tree.h"
 
@@ -46,10 +47,14 @@
 #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
 #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
 
+static LIST_HEAD(arena_list);
+static DEFINE_SPINLOCK(arena_list_lock);
+
 static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable);
 
 struct bpf_arena {
 	struct bpf_map map;
+	struct list_head list;
 	u64 user_vm_start;
 	u64 user_vm_end;
 	struct vm_struct *kern_vm;
@@ -332,6 +337,10 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 	if (err)
 		goto err_destroy_rt;
 
+	spin_lock(&arena_list_lock);
+	list_add_tail_rcu(&arena->list, &arena_list);
+	spin_unlock(&arena_list_lock);
+
 	return &arena->map;
 
 err_destroy_rt:
@@ -385,6 +394,12 @@ static void arena_map_free(struct bpf_map *map)
 	if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
 		return;
 
+	spin_lock(&arena_list_lock);
+	list_del_rcu(&arena->list);
+	spin_unlock(&arena_list_lock);
+
+	synchronize_rcu();
+
 	/* Ensure no pending deferred frees */
 	irq_work_sync(&arena->free_irq);
 	flush_work(&arena->free_work);
@@ -1207,31 +1222,32 @@ bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write, unsigned lon
 	struct bpf_prog *prog;
 	unsigned long kbase;
 	unsigned long page_addr = addr & PAGE_MASK;
-
-	prog = bpf_prog_find_from_stack();
-	if (!prog)
-		return false;
-
-	arena = prog->aux->arena;
-	/* a prog not using arena may be on stack, so arena can be NULL */
-	if (!arena)
-		return false;
-
-	kbase = bpf_arena_get_kern_vm_start(arena);
+	bool handled = false;
 
 	/*
 	 * Recovery covers the 4 GiB mappable band plus the upper half-guard.
 	 * Lower guard is unreachable from kfuncs; an address there indicates
 	 * a different bug class - leave it to the regular kernel oops path.
 	 */
-	if (page_addr < kbase || page_addr >= kbase + SZ_4G + GUARD_SZ / 2)
-		return false;
-
-	apply_to_page_range(&init_mm, page_addr, PAGE_SIZE,
-			    apply_range_set_scratch_cb, arena->scratch_page);
-	flush_vmap_cache(page_addr, PAGE_SIZE);
-	__bpf_prog_report_arena_violation(prog, is_write, page_addr - kbase, fault_ip);
-	return true;
+	rcu_read_lock();
+	list_for_each_entry_rcu(arena, &arena_list, list) {
+		kbase = bpf_arena_get_kern_vm_start(arena);
+		if (page_addr < kbase || page_addr >= kbase + SZ_4G + GUARD_SZ / 2)
+			continue;
+
+		apply_to_page_range(&init_mm, page_addr, PAGE_SIZE,
+				    apply_range_set_scratch_cb, arena->scratch_page);
+		flush_vmap_cache(page_addr, PAGE_SIZE);
+
+		prog = bpf_prog_find_from_stack();
+		if (prog && prog->aux->arena == arena)
+			__bpf_prog_report_arena_violation(prog, is_write,
+							  page_addr - kbase, fault_ip);
+		handled = true;
+		break;
+	}
+	rcu_read_unlock();
+	return handled;
 }
 
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip)
-- 
2.54.0

