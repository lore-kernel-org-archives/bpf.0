Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42054071C8
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780864274; cv=none; b=iHtXvENqKupmdM3dDTBQwxk3PZC2OBRoYP1SdMy3/lnF6VdXpI6ZJx9l7aHFMbKnRlruW/cH/HEnjgHCTw0ENS8X9G2SIIwoYiyq2BHK8wi1gUwa696hlO8kaWQwT1jcLQ1h2IkeRfLXE/eouf007vu0WOZEZntfe12jbXN7Cjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780864274; c=relaxed/simple;
	bh=txMu01KjucEoOKi+8r43T/l0P3U+27sc53TOyM5mnzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JvPjvOxC6K9hscjeaVgnT4LNHzK823+MsMUSBzeoNB67OhAPeIb9eYHM0W5SzFlfgaeL3C+3cOO8icB2GSEPBNf8S/ici0RPpJ/99tvjHU2MSUWlMtUySuaR0HbDyvb+Bg1fLDslb21d1AUYnhewS7KTcnY47IYxSVXoIkJPskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qwkz5iu0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwkz5iu0"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso1757292f8f.2
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 13:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780864271; x=1781469071; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQX8hZNxC4zVFC9oQ5fkL8QmxnfomEWJcAfydp9X/3g=;
        b=Qwkz5iu0v9vlGTWU3w3QHLQR0BRov3J9I61GYzyvFgQYo6ARXZwEFOoU2aRKSx6djf
         rDVbfIqyIyc/S+3iAFpyAqV50vCIZXc9U9FXi/2QrUeVyzoURdADFV9TKAPkXuohj1fO
         a1znAv5MHtULRkBh7KW/uyYiRbj33oe6mUODt+DWq5GhCkx0fveJklZ9pHLGyiqAbMqb
         cZE/QKJoavQA1CR3PnQE3CzTb4fCtmYgqtxs7svNexdwTSBbnvPNjxe1GkxBT6R2U5y5
         n4tUEhV4Xy0ISIMEYPUA/5FUXdmsrDmKOMsWJs+bjttgsSkrJXD6St2rbag+FGfoVT0k
         sgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780864271; x=1781469071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YQX8hZNxC4zVFC9oQ5fkL8QmxnfomEWJcAfydp9X/3g=;
        b=rWEj4LSAkp73XEUtyXMVGRFc0k32zezCZGX5Qx4WIi2059VzX1YDDXqs2RpHN6fD9T
         61Y6gBPVBbQa0APU5Yk2k19R2r9Cl5pQ7tkoEsaXeztox041Z4pSkbaypFOFcwIciXI6
         Zw+NuHndGA4ey0xfC66YT8PSCCbgRBcfhUSAaHMKH78+1R3dZNSXQheMcBbDMtjgMxte
         IoTdQFoSLWbaXBjsj+xFb/ZJTN6KpHSaR9aiSGn66BD5YbQcJ8MjwhkesDGTGFd3WQbu
         NamKVk7hp9sTfsPT+LSibaXNAfi8/rzjc+IJOksVlTdThJ+4jiNMF0W2d+NgHwiknZig
         r40w==
X-Gm-Message-State: AOJu0YyjyyI0baqHxj9TUGO29U9eQ0+8fvSZtmt9XCUpR8Su+q7i8ByF
	KeBcmSAJWwlVJtSQIZFZPmd0Ka9EE4lAd07Bvs/Kh28u4ssxiN9IcfOD
X-Gm-Gg: Acq92OHa/KQ3EF+SRlNE3kTheUtQlbXdmRc/XKnqp0I5SuYUsWHwo9vXlcWTFGjXWZx
	uT8IxOttPpM1eM90F4t7zYq8pbXOsV86okUE+TP0jWe16A8NhfELPH/1N0+Qnt/WDvCCKXV/OWP
	mFdye09lzCeMBsunRDLai+5MttyHfKXU4JLJDdj4DVQhbJQCGJ8IEyb0vM6n8weB4n1KDyuK5pV
	++CsKea79ekamyxPyk362YkUDgOb4uvISLWCkvSDsZzkEWcylUuzetN/uizGfOMrXFPhN43DGSQ
	K08gC729ZXxtway+AGz6JNtP8AwMb9wdx8q0tcp7gFcSh4Elcu1koFIm5r61AIeFvhH/pl7sq/w
	AsoSRWha8gYvnfx3CDqdURCv3dc+jYKFxJcivAA8/pGeuwlCjlWHhsPb81Qz51bGra4VZGD+8C8
	VzQ02ux45GLHUajHKitNFJMTk=
X-Received: by 2002:a05:6000:240f:b0:456:b23d:e57 with SMTP id ffacd0b85a97d-46030182732mr20646811f8f.0.1780864271224;
        Sun, 07 Jun 2026 13:31:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm44689549f8f.25.2026.06.07.13.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:31:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Sun, 07 Jun 2026 13:30:42 -0700
Subject: [PATCH bpf-next v3 2/3] Documentation/bpf: Refresh
 map_lru_hash_update.dot for rqspinlock
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-lru_map_spin-v3-2-bcd9332e911b@meta.com>
References: <20260607-lru_map_spin-v3-0-bcd9332e911b@meta.com>
In-Reply-To: <20260607-lru_map_spin-v3-0-bcd9332e911b@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780864266; l=5661;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=ymz1WhS83aLTzHxc1/P+ygO0/ld089ltpBnsy7Icpn0=;
 b=k0Ti+OkfFywQUK4I9yd0p/dstiiS7SWEkCti3tOWO4HYH5FjT+vXEyFYNtDZAYhytyFZejCW8
 TGorcRKOwRKC0UgUH/EbuFbwHeEkvLUj4t/jQU5ir2AyrWxf+4FVc+s
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

