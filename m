Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577513;
	b=vH+9QuhuESWElCl00/Ea4GD1Z8BD6+CeNIONSuQkF+ekPR8wyhvIdX+2dDpysODQ4Kqd
	 vImKi+CqUSAVXnrc1I/HtWKHqk5K5am53rGei4bWfvn+Shz+L4yYed34nUSmE97ufEHzE
	 gxoDKl+mtsgbvwA3wqYW2l2lpRr9nrlsemWn0chabGgAhj2zvIkUmddgI18fMt31weO4F
	 IWfPAvl5Tpr8Ste6Amx7KB+xb98kpEtHh1fWKOstTvlNMPNAlAM8ZxvjHLhSw9l5zoZ+n
	 i7CgWfaJ17Ma9IhGJVJGDaWv/4WpceSaJLCQlhpjHVnur2MzGjnlSuEhVmCwWe2lcNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9chou4crN0e+3SUaG+DHDloGg2ccL6dMpeBFBEcUABM=;
	b=f1sqIscylHfVf3WC6R1qdaqTvBWpGbceND8UFdOuZ1RLGK5nCfT1oW8CRHfk7q3V11JX
	 FKvCDrwG8tQtnuACj8Nagrei+QikNDlaJcB57dF6W0dwHIUPzs0EE9x4BQ18LdLzsG5cO
	 EKzSjMUELCQq5Li9jaacHOnh7KZBv0UF2zY8u+DH/QKTrwmiX9wtp98qdOghJEb10lMbT
	 ioivPVzFyDLEtiDujjHVu/Uka/MNnJ5HNSdh+BqCAsfBgOY+diMWGace8YHWtfPvOcOzA
	 I86sy8Zq6WRC93VQq0TZKejC43/0sQ95NVegGpTs+RO/nwvPi56uCtb7LqgJPIsO07Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dW5/ElnW";
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0853606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0853606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dW5/ElnW
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b904d10882so2135044b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577512; x=1796182312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9chou4crN0e+3SUaG+DHDloGg2ccL6dMpeBFBEcUABM=;
        b=dW5/ElnWRL/MLhzFMgjlwLntwUqQ5T6jGYJhBGzsrz+Ks+4JrH47fO4BzVxTWaCNbj
         28bQ416pc3X5myntpwfOAisl/YR/EXv0em7UdMxUJFhBViEZi8GaBYNhaFBZfbjZ2eks
         68fHlgaxTYSkLzhaIWeuZqDUb3Lxik1VXVAIXwCrYKPMhyK48CAYupA+aHnkueS4vUww
         cCd40MSYVlaVhxzdW+wjp4Oj3eZIU2DZz29ei/h8Rr1sEMYyeXGdrTbEf8W+6QkBbSBN
         /AsyvzKEKjFz7aTrfh3WASnAnM7zKG734KVE9NaByLe4WHoBR/epJ8nSWprR41BI5HUH
         UhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577512; x=1796182312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9chou4crN0e+3SUaG+DHDloGg2ccL6dMpeBFBEcUABM=;
        b=iPnfWlFBaVKiYMPLZCn964ynvsmMf0ef7ztRoPUfmE6GA6br1nIuFVW0hz+yBYulqB
         VuSj26W/GUE/o4RhsV1gIioDgOXS81ML+3bPysmfTfJ6E7KQNX4dkSqXXxNnPZGScx30
         dyFE7DDI6vhP46QWhGPn/Sb+uffYcXHXQymCTIIDRxQvtLOjILu66Nr3xfscgKVmjae+
         7YrHaaPEIiWUdIS1jNwIsnk8nXs3EfgT4AskJL16zbbfx52mGQCJL3xjWj/unBTH0obg
         E6Bdzma4q9qJ5yeldFoE909Z0EHDndmnRcAJ5XFj1sDPQQBOy6NmPMVUTOYxIMq2aTj+
         UFmg==
X-Gm-Message-State: APuU4Z96VDBHFSQqoeQ5EmLVaYbM9Y3EgGIpmFxbkcahn/6oQAALpg3M
	FROnL2JqCf38vcz5dYp7vToP/TnQ1p7NXjqLNSa3+Ed34Zo+XF0CqwAYtZlczCRu
X-Gm-Gg: AZFdTZenJ8BjZMzDBlZwJzHe8gKvRY2Om7O/iBGYys4zuKGun8e4E/s0m/oE019VfOs
	6fHARh2BIHH68B/gzcwzZ/tO6ERE/F8iJRt928Q7FghBo2J02m0xYmVb/asP76h3KabLEvSLCCt
	VmfVHI+CsIw9M5neFBTu51NOCHKyLp5T29AltDsW3HLDeNl06xPJNkNbZT+6wZYn5qj5bt1NA2x
	MPCIMY9i9322s5UsHL4ORp5ACCQTbJ7XvFeaQ1OfVehfitWIonkRdkNMFfosgTV0qnSZT+M4cdW
	j7RnzAHlmpgjCvZJkbRcQt1MKuK/+y8FkDqwP1fkSM/nHX8c589hqTjPbK4jMbsw2PCac/FSoBM
	e3CA8UaVMMRFt0/weJ/jbRqk8rKZhVDCGXfMiTsHjaL63Vm3FKqmCjrkNoXt17H45spf4w5bVMV
	AYrWVIQSpN2trIgXj7oHgiNi1LDGTc3kmRBGggWt50xklZcKy649au15UB9yvBLswpDQDm/NucB
	lnclsk69M1PVZGjdaUW50ex4COPJCSbyHSIz+yR2CmbmGtItEsZgmcCggQVIT4Z0WKGzuOof+1A
	fzwFrrjhIRpyITITKIIdVc2FTN+O0SLNcfNOCFjWBRFWR0gSHekZ7hp+yC0zKQvIdyEP0GYl4Ja
	1bHtTws2Y/mKIqCpUV3poFWmUtr9UDHeNp8XBgXlr7rKo8hVq1V/e0Fi8HYZoc2fiC5mOLivwww
	==
X-Received: by 2002:a05:6a00:39a3:b0:8a0:59d2:7d41 with SMTP id d2e1a72fcca58-8c87dcdf45cmr16113391b3a.56.1795577512068;
        Tue, 24 Nov 2026 19:31:52 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c263sm8087615b3a.11.2026.11.24.19.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 22/47] bpf: Flush TLB when a page of arena replaces the scratch page
Date: Wed, 25 Nov 2026 03:29:13 +0000
Message-ID: <20261125032938.670542-23-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A fault of a kfunc maps the scratch page. An allocation at that address
puts a new page in its place. flush_tlb_before_set() is empty on x86,
so all cpus that have touched the address keep the scratch page in TLB.
The program reads junk from the page that it has got, and its writes
are lost.

The flush takes an IPI. Do it after the lock is dropped when the caller
can sleep. Otherwise fail and free the range: the work unmaps the
scratch page and flushes TLB. The range is taken until then. As with
any deferred free, it stays taken when kmalloc_nolock() of the span
fails.

Fixes: f64c723741c9 ("bpf: Replace scratch PTE atomically when allocating arena pages")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/arena.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 2c6ddec747de..56bd02b783f9 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -149,6 +149,8 @@ struct apply_range_data {
 	struct bpf_arena *arena;
 	struct llist_head *pages;
 	int i;
+	bool can_flush;	/* the caller can flush TLB of all cpus after it drops the lock */
+	bool flush;
 };
 
 struct clear_range_data {
@@ -189,6 +191,12 @@ static int apply_range_set_cb(pte_t *pte, unsigned long addr, void *data)
 			continue;
 		if (WARN_ON_ONCE(pte_page(old) != d->arena->scratch_page))
 			return -EBUSY;
+#ifndef flush_tlb_before_set
+		/* The scratch page is in TLB, and it takes an IPI to flush it */
+		if (!d->can_flush)
+			return -EBUSY;
+		d->flush = true;
+#endif
 		ptep_get_and_clear(&init_mm, addr, pte);
 		flush_tlb_before_set(addr);
 	}
@@ -571,6 +579,7 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vmf)
 	}
 	llist_add(&new_page->pcp_llist, &pages);
 	data.arena = arena;
+	data.can_flush = false;
 	data.pages = &pages;
 	data.i = 0;
 
@@ -803,6 +812,8 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 		goto out_memcg;
 
 	data.arena = arena;
+	data.can_flush = sleepable;
+	data.flush = false;
 	data.pages = &pages;
 	data.i = 0;
 
@@ -833,17 +844,18 @@ static long arena_alloc_pages(struct bpf_arena *arena, long uaddr, long page_cnt
 
 	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
+	if (data.flush)
+		flush_tlb_kernel_range(kern_vm_start + uaddr32,
+				       kern_vm_start + uaddr32 + (mapped << PAGE_SHIFT));
 
 	addr = clear_lo32(arena->user_vm_start) + uaddr32;
 	goto out_memcg;
 
 out_unmap:
-	/* Error handling: Undo partial mappings. */
+	/* Error handling: Undo partial mappings, unmap the scratch page. */
 	flush_vmap_cache(kern_vm_start + uaddr32, mapped << PAGE_SHIFT);
-	range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);
 	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
-	if (mapped)
-		arena_free_pages(arena, uaddr32, mapped, sleepable);
+	arena_free_pages(arena, uaddr32, page_cnt, sleepable);
 
 out_free_pages:
 	/* Error handling: Free back any unmapped pages. */
-- 
2.55.0

