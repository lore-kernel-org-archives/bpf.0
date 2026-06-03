Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949B3F5BCD
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512958; cv=none; b=URPMxHIiPVNiJiDrcvfF4jFvR7UZ/5hVcih2dVu8MSDv7OUQkaRyasD5bTjgnhBb1hJcvedq+w3qkVTKfHo7APnbGhWjuNl6T+tC4WK+ChafAr8O1XeEdWlUOPINFAHQC2xSH0nYJzN7aShP+AwkgS0aRYdR4X1/wvqLer7NiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512958; c=relaxed/simple;
	bh=txMu01KjucEoOKi+8r43T/l0P3U+27sc53TOyM5mnzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aVqOL3/kc4TG/KpDPxEOutm7eVziNYNqBZ/N3J7VV/y07u2PL4RHYPZF6V7aUWLcM6fQsB1ANgwf43u2tnf3faTQvW2cJz61I/9uhr4WbFwHfkr2FRm0LbLioBUIcVYxe2z9bFkdWpoavdCc6DSMxoB7j7kgUaS+4IWVdKGWTrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSkKdRSX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSkKdRSX"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b7866869so12578465e9.2
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512956; x=1781117756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQX8hZNxC4zVFC9oQ5fkL8QmxnfomEWJcAfydp9X/3g=;
        b=LSkKdRSXu39FRkAiDssDIBOs4i17m2T2K9a1yGWgGnDuY7MLvV2G7IBKCZdvZAcxfu
         SNvt0tMnYjxwxUY81ep9bZ8u7xd/s2KA7y0qg0pwXfZw35QvyEMaiN/eWtTA7YRg89lY
         Wq3gbM7CXyn6vJARjBbpM7XI/JRaUbdoXMViBteacODe7rzzJYeFpagcVOWR1H8O7F6c
         roJ0xSZrFDv5ZPvMOxhZQQdeR79I1CICKhpVYRHpVQM1Lpx1nfTdIWxHdYKTatDL51p5
         yyApuTbISmZ5ZzHCG4VGjgVUaoSCRT9zbw6ygwSCy2V7AeiYmgj06pzujnuBAnkiu+xI
         SICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512956; x=1781117756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQX8hZNxC4zVFC9oQ5fkL8QmxnfomEWJcAfydp9X/3g=;
        b=B7GVZ0P9/gbJtqX9yQRfi/ZSv1PL/UF5TmaavLqmsEH/fbY+qeWnErtTiQOLLZT8fQ
         FKzCPuEiv1xXH7xIp3NpTWL8EIHKF1Aj++bo/L5YClrLAiK9nBbPiDJPMPNXGLlSftHx
         Lk2Ncm6fFMmrsyzm01J8UYB9z9gBcJIbKB5xtt8POk30D39duP1DHW+YYQMAAtBqok9f
         bDouoVNFMNNFgaLxrnvKkbPqebJrCih5eb3RxqkNkTe0feYBzNloAUcXG+6EcL2eqvn5
         UFGNnkxpX46IAa764VeeRfG701dacxDrnoakoKqmNbf14l+xBnVHatqkk/RySb7axJu2
         2ymQ==
X-Gm-Message-State: AOJu0Yw32oFMlso58r7AAKfVvShYGo3W9Mu0DRAMaCCNynmPwzKBozpz
	ESJZwFmvbeaZ48tqFuAu5YFqYnwjWhzp4itoYFiFJG8U0c9TD39KIj/V
X-Gm-Gg: Acq92OGLUJbdZl6vMBGwfGvSu77LY0LLbRBj9SWQ0K4eZrWrSW/fn4ZMYLd7QWRp8IG
	wtshcXu6VsxPkBadDPNx8Cw7Fmty/nozXq6C/5ZwCkRqTfMdqxMGiynHVKbCuDxTX+8qe3ycNkf
	Jp3rmV4RCm5TIu5ob4dOhpNekAbGrFXkMveogGI/wZ26zsCwasiCyDWlROzhB1M/KFUXo07KF5r
	I6B27jn+dd2q5YlOTtb2tXPAv9S76wN4JQQ9LBMPMlaB5rwFCo9s5TvvQPCNyP+DZewZTsFfjSF
	uk5hHD5FHK5IEjf+QSdLMHrK/5YSv9GPOGQLrUAd5CZqPGYxpiik3FIGMDPiRtDAQSoU/Rucsfw
	o9AsmZzIOB52KO/rA5bhgA2FgIEFQuGRn9VM1SMHv+wB7YkQ7um/qH1Sq9hSBsQbdXP/tMZimfl
	PlXatbUcvDlCLadktsRbCUEJA=
X-Received: by 2002:a05:600c:1d86:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490b60de617mr72019495e9.16.1780512955604;
        Wed, 03 Jun 2026 11:55:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm11166045e9.13.2026.06.03.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:55:55 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 03 Jun 2026 11:55:26 -0700
Subject: [PATCH RFC bpf-next v2 2/3] Documentation/bpf: Refresh
 map_lru_hash_update.dot for rqspinlock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-lru_map_spin-v2-2-7060cfb6cdac@meta.com>
References: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
In-Reply-To: <20260603-lru_map_spin-v2-0-7060cfb6cdac@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780512951; l=5661;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=ymz1WhS83aLTzHxc1/P+ygO0/ld089ltpBnsy7Icpn0=;
 b=M90G690e/rt1Xb9oYCCqE2JqTo9zxIRSghXo6I/0aC0R6j+JDpYJtWQdQMG6zzpe1swuYPGqX
 wlYl0ltBoThD6V6RfbE5s2ZbMoXKsJ0c0YS8z9OmRTry/NT3inAMj6c
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

