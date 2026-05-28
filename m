Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88D3B0ACB
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992144; cv=none; b=D+vasD0bwIcwA1VDa2p/BvlX4uzzLS1dF+XOjSmS+nZnwbHj+20GY//yPQ/71DaH66YmwnXqZtLRVWx8w9kDMiAHeXIisxkr88ju4juXgdZEZU2Tgmn752E7UZ27qjEt5PUkqixt+pLYEWs61+dBGPQmtt2nK9S+0hP4IgCzEsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992144; c=relaxed/simple;
	bh=txMu01KjucEoOKi+8r43T/l0P3U+27sc53TOyM5mnzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SlZyNrx/s9pDznwFErb4jherojDiDYmC9/3GdapUoCYsNlSPnQF9c4fyXrzAJlwSaPYkQdpItXjf6gO1I0Crgygyhxc7969ICMVHaqbuVRZLM7Pv/RG8N+qf167/G3o7jd5g4lI883ymnYC+FVcCKHtygiWRba8KzQsq5EppJsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdVZYKRy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdVZYKRy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso114179375e9.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779992141; x=1780596941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQX8hZNxC4zVFC9oQ5fkL8QmxnfomEWJcAfydp9X/3g=;
        b=kdVZYKRy3KD00Y5ZMtL8rkhhpQzgRv1yPff8OxA+y6C6Ub4jMKkqs1GrpyMwRbCG4u
         ILhxFI+UPY05oxcPbqTptbj+VE75hrnalAOScS3FLgE1arDbYu87IeeEMkVFeTCBvGAk
         4fXui56EwliExJAERTvblW+dPxfycKKOgWiiYqT2K6WHPVV8Pe3/XyQq+jVL9E17Wq58
         L4s1TyX/zAp+sTz/zZNPi3pj/s/N0RkW2Prdayaz5AyUAZhFqpLs0aql0JyHib7hqZ21
         4I6fZ4fKmANcTDtCLe7PBvtwgMwdbsdDjkpEZUcmuCZZtPwpOiTGx88PFmpcyDVRzxW9
         VG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992141; x=1780596941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQX8hZNxC4zVFC9oQ5fkL8QmxnfomEWJcAfydp9X/3g=;
        b=Wjtb9PwselPjMed2kwdXBBN81PEoqcbKNt9HuXyO3KR62SD+yW2XMqF7nUSwfT0CKV
         inR9Sifgf7h+bGE4bGMjfDeLhjMnhdBgssI+XRDsyAjb/ajp8PhRHjr5olelqF/692ca
         5KT1RJaiiqvZ2AtqDc8hAIeBOTd2AtDJfRFH1sraLTeln0T0p8YWwVS7ULofmBVufDTb
         xsBwSYp5HartcY811KOrvDnYpsb8vloKeuYUo6pxHwWB225GLc9JhUgIAkmm5yvm/xc9
         gvryLzMKwVfKzLgC/DG0JYLKOYe4cer+JBYOmR7cmmi/ojt2sj7GUQdZFVUdQmjCMbN2
         VpMQ==
X-Gm-Message-State: AOJu0YwNM4sUsLWy8l4O+AqY6gWbVlD5M8jRNVQUa2t3r4jPkmyhWYBJ
	X9xqKsSvMYUrREJcv3L/nJuW7ORdbbkqSYHRLynGQ6ve1+UrJUqs85GMXzdBZQGi
X-Gm-Gg: Acq92OEsL0tzwwQEWat0Mhv466NiFifTml1qL5ZHUYcW+QuuFs4oAT22Mr9C1ND1Sts
	fu7pzg5044EZB0WfeI4Sn12yVz0NzRJ2z8ASy1p3fD530ca/9EsWd/30OVG397LlplERQuAtw/P
	h2Bzja+/l2TrJh9a6RgODpu4z0dWhz45eIpKwVeYU8vX1fa9RwVW5CvuQU3nRAQ7qPxnLmVsB7k
	EQMBipX9om+tDs8PBsc/Gl8PJO62EbRZsYQ/M3omxnPdjDtVThEEHR2NqjYCOB2WKL9vLb9KjQb
	+xmT+KBEqN/I2wU8G91gEFb+13PN3QrJDw7olyyLtsPlLLs9Kxis6A7qMSJhPvHyflkJd1odPMK
	UJtd1nQl/Tz8zVtPzmyJPz129WxhjdGiQ9KHFxXbRDyLvdHNRPW0rQZ+fSmUfOFcUbqIYLnLHCB
	jL2HNLUcaxbHKH9YS7VmuOjEWo
X-Received: by 2002:a05:600d:6451:10b0:48a:563c:c8c0 with SMTP id 5b1f17b1804b1-4904249d11amr347993555e9.7.1779992141061;
        Thu, 28 May 2026 11:15:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49091d57c0dsm86441635e9.0.2026.05.28.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:15:40 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 28 May 2026 11:13:25 -0700
Subject: [PATCH RFC bpf-next 2/3] Documentation/bpf: Refresh
 map_lru_hash_update.dot for rqspinlock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-lru_map_spin-v1-2-4f52223170cf@meta.com>
References: <20260528-lru_map_spin-v1-0-4f52223170cf@meta.com>
In-Reply-To: <20260528-lru_map_spin-v1-0-4f52223170cf@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779992135; l=5661;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=ymz1WhS83aLTzHxc1/P+ygO0/ld089ltpBnsy7Icpn0=;
 b=A4ayNEmTNBHF5/oAE2SPxoD4UrJ+rH7qDqKXDs0yCGc/pbvAztsBnKmCNdRXJFPE7hIRRvv2l
 XE+YfJqr2+fDIlzlnYTcZQoeFXkZ0+JIEyvcZz0OuOkejL2Zj7au8aN
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Reflect the rqspinlock conversion and orphan-recovery paths added in
the previous commit:

 - All LRU locks are rqspinlock_t; any acquire can fail (AA or
   timeout). A shared "rqspinlock acquire failed" terminal collapses
   to the existing -ENOMEM exit. Dashed arrows from each acquire site
   mark the failure paths.

 - The per-CPU local freelist is now lockless (free_llist).

 - Post-steal: re-acquiring loc_l->lock to insert the stolen node
   into the local pending list can fail; on failure the node is
   published to free_llist instead of being orphaned, and the call
   returns -ENOMEM.

 - Steal-loop victim lock failure is silent: skip the victim and try
   the next CPU.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 Documentation/bpf/map_lru_hash_update.dot | 44 +++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/map_lru_hash_update.dot b/Documentation/bpf/map_lru_hash_update.dot
index ab10058f5b79..412bc8b3b57e 100644
--- a/Documentation/bpf/map_lru_hash_update.dot
+++ b/Documentation/bpf/map_lru_hash_update.dot
@@ -21,10 +21,18 @@ digraph {
   // names that initiate the corresponding logic in kernel/bpf/bpf_lru_list.c.
   // Number suffixes and errno suffixes handle subsections of the corresponding
   // logic in the function as of the writing of this dot.
+  //
+  // All LRU locks are rqspinlock_t. Every acquire can fail (AA self-deadlock
+  // or contention timeout); on failure the corresponding helper returns NULL
+  // and the caller propagates -ENOMEM. The "rqspinlock acquire failed"
+  // terminal below is reached via the dashed arrows from each acquire site.
+
+  rqspinlock_failed [shape=rectangle,
+    label="Any LRU rqspinlock\nacquire fails\n(AA or timeout)"]
 
   // cf. __local_list_pop_free() / bpf_percpu_lru_pop_free()
   local_freelist_check [shape=diamond,fillcolor=1,
-    label="Local freelist\nnode available?"];
+    label="Local freelist\nnode available?\n(lockless free_llist)"];
   use_local_node [shape=rectangle,
     label="Use node owned\nby this CPU"]
 
@@ -82,6 +90,15 @@ digraph {
     // fn__local_list_pop_pending()
   }
 
+  // Post-steal: re-acquire local loc_l->lock to insert the stolen node into
+  // the local pending list. If the acquire fails, the stolen node is published
+  // to the lockless local free_llist so the next pop on this CPU picks it up
+  // instead of orphaning it.
+  post_steal_lock [shape=diamond,fillcolor=1,
+    label="Acquire local\nloc_l->lock\nto add pending"]
+  post_steal_to_free_llist [shape=rectangle,
+    label="Publish stolen node to\nlocal free_llist (lockless)"]
+
   fn_bpf_lru_list_pop_free_to_local2 [shape=rectangle,
     label="Use node that was\nnot recently referenced"]
   local_freelist_check4 [shape=rectangle,
@@ -97,10 +114,19 @@ digraph {
   fn_htab_lru_map_update_elem_ENOENT [shape=oval,label="return -ENOENT"]
 
   begin -> local_freelist_check
+  // The initial per-CPU lock (loc_l->lock for common, l->lock for percpu) is
+  // acquired before the local freelist check; rqspinlock failure here exits
+  // directly to -ENOMEM (no recovery needed: nothing was removed yet).
+  local_freelist_check -> rqspinlock_failed [style=dashed,
+    xlabel="acquire fails"]
   local_freelist_check -> use_local_node [xlabel="Y"]
   local_freelist_check -> common_lru_check [xlabel="N"]
   common_lru_check -> fn_bpf_lru_list_pop_free_to_local [xlabel="Y"]
   common_lru_check -> fn___bpf_lru_list_shrink_inactive [xlabel="N"]
+  // Global lru_list lock acquire failure in pop_free_to_local: skip refill,
+  // fall through to the steal path. Not ENOMEM by itself.
+  fn_bpf_lru_list_pop_free_to_local -> common_lru_check2 [style=dashed,
+    xlabel="global lru_lock\nacquire fails"]
   fn_bpf_lru_list_pop_free_to_local -> fn___bpf_lru_node_move_to_free
   fn___bpf_lru_node_move_to_free ->
     fn_bpf_lru_list_pop_free_to_local2 [xlabel="Y"]
@@ -120,13 +146,27 @@ digraph {
   local_freelist_check6 -> local_freelist_check7
   local_freelist_check7 -> fn_htab_lru_map_update_elem
 
-  fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem3 [xlabel = "Y"]
+  // Steal-loop victim lock failure is silent: treat as "no node found here"
+  // and continue to next CPU; same edge as the existing "N" path.
+  local_freelist_check5 -> fn_htab_lru_map_update_elem2 [style=dashed,
+    xlabel="victim's lock\nfails: skip"]
+  // After a successful steal, re-acquire the local loc_l->lock. On failure
+  // the stolen node is published to free_llist (recovered, not orphaned)
+  // and the update returns -ENOMEM.
+  fn_htab_lru_map_update_elem -> post_steal_lock [xlabel = "Y"]
+  post_steal_lock -> fn_htab_lru_map_update_elem3 [xlabel = "OK"]
+  post_steal_lock -> post_steal_to_free_llist [style=dashed,
+    xlabel="loc_l->lock\nacquire fails"]
+  post_steal_to_free_llist -> fn_htab_lru_map_update_elem_ENOMEM
   fn_htab_lru_map_update_elem -> fn_htab_lru_map_update_elem2  [xlabel = "N"]
   fn_htab_lru_map_update_elem2 ->
     fn_htab_lru_map_update_elem_ENOMEM [xlabel = "Y"]
   fn_htab_lru_map_update_elem2 -> local_freelist_check5 [xlabel = "N"]
   fn_htab_lru_map_update_elem3 -> fn_htab_lru_map_update_elem4
 
+  // Shared rqspinlock-failure terminal collapses to the same -ENOMEM exit.
+  rqspinlock_failed -> fn_htab_lru_map_update_elem_ENOMEM
+
   use_local_node -> fn_htab_lru_map_update_elem4
   fn_bpf_lru_list_pop_free_to_local2 -> fn_htab_lru_map_update_elem4
   local_freelist_check4 -> fn_htab_lru_map_update_elem4

-- 
2.53.0-Meta

