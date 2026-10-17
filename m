Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0E3AA9CA
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255095; cv=none; b=W1X+UY4HF1INn0nkHZV7+9jmx/VaYO+fm11ueKenu9MmzZY+NQ5Tz7ZRDq1Y+SsulJGYESDOMDjG7YOz1QRWOUqb4HjnTns/kiaOfopDzQ711t0gbJ3LD2PVAY62yl/dKmS5s08riSNtAaL8zF+9wwYeTBU3OdlEh6runK82z6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255095; c=relaxed/simple;
	bh=Mps3K95bysn2domJc15iSVRvaN4uM/Wx0eycYzLjYbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAOmORiQenHm9zDKOQXYV80QNjBDFzku1kzj22iQKkvG02jlZNjQJRARYtZZiWWvoWu6hNVWZ4AUG/Xd6gyU6t/7Zxlvl5ROXahThqKJModAZLX8fi9nL0Z6AT/jYkFL+Jly+BnLF8TcJH4prmkzcfcmj/tmGoAtXmwES0Xdc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQ79exeP; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ79exeP"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso505100a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255093; x=1792859893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MQ46KHX71wWXVIIjA17KhwdyjOo8Gd7eqr8a5r+ZKlo=;
        b=oQ79exeP8BZ9SroBXxUVyLCvXSXOzbGCdKG9vBv4W2YhK2WGEJx+nbfw1ETOZ5jMio
         sYFWs506M+sWhwaUnggKeQLFb2nck6AyGJKBIcIo6w+QY8cWMNFOoRDj38bSvzB3J0FS
         yp7Uz0OZtHAnZPlJ6WDZQPrg1u3rsC7jnUQyST1YXypq0KuiObZxj2gpBm1vIxjr7n9M
         81GMikWRv3RkumdM1bkb99RVEPY5GO2k5nzYlBA29bxDPxRzu5DqRm6zZd0q436s9ORO
         4yDdLGbhPzu0W43AH4QzOJ6LK5+4nANTOsf2v6/n7Hs1vplEuiSdl5m+k2MQpk/7JHKH
         eWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255093; x=1792859893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MQ46KHX71wWXVIIjA17KhwdyjOo8Gd7eqr8a5r+ZKlo=;
        b=wGrgGDDCffsSwHRLFnOGmwcpoOaKvoYmiB+wHp4nTynqXlVwo3p9TQJsY7+beaevu6
         tzwl+PJv2HIVDN22BcHsLSjmpS1lBJoADBJUrTdGPJENn7q29Gn+Lh1JuQNSuoqkT9ki
         bfAvWQoQwPzJl0pX2zh/nMazMMX5rUJkXVxJ8HxXDKbpHjXY0B7a8sfUowwhhkv8rjM9
         0vRpilclKf8Dz/0rdNnkGrvsZR2D1iGrF8EKv5SpGuTAfJFfQooa6R2qBqsS11zkF0i6
         qDPR069j7j/RlMBXsu9HGeH1RVMNEotMbulwJfrU+xkwe2n7fbCtUlIQoLtW6XNSErDQ
         dZHQ==
X-Gm-Message-State: AFq9FYI1SCPMH6sedPlSVqtacM97pFbSGS7n3sDAcpozng897diMLLvV
	/Z1RyUkAKJTFJWruoVaIpIjtEE4TRvWiiM+7XWb1JRLAglUOl/k8b8XOj6kJsQ==
X-Gm-Gg: AYBFou3OT0hbWfyXB1c8lZPG6HMfacbf6yMUmDgABplEiPkCFKLL99PffY++pPDS2Vo
	epxrKScxLus7FZoiXggr5XOyrwDzUJktQwPwU4DXTtKtttfli1K4x4KWZBl1AoPuDIibiGU9QRv
	MFCkWotRCkVXpwgOuF7gG9pRMfqbjoEZhGiPdLbLtxLJn1qMHX9lEFTQ97p94g11LnCUHuX2mwY
	Z4tqz1LIuFpj9VBpL5olbBuXonrRLcL1h8JX14UfTeDFTcdyPU5awqqRv+Keuon2jNU6duuocr3
	sTOGxF+Nm+Z/1cObgrdyXKcO0PvACp7Opypl9mS+Uufh7bTBatHtQAii7mgWLWsoZSS2W6rcXP9
	MGtJgt10O/hXCnDstfpgJ3ZtpjKPcTysaFA5ENzth+t+16ilO9BFN5UNedve+i2eIOY998y9GTX
	+fshtiZn1iTCIOGq03JGqWLm6caiZxWseWyLMmPSyAygOgenJTbaQFc+jKagZBRLA8eixNcc/YH
	vMnf6ozIfqhdZfaRzyhUsdBPT3gBGfeGPYfeYC0uaJTfT4O74h8RQzpvBxRxkluiO90bG0BSsYF
	fMd54LUEsj5Io3pJUdAcS4ZdP/PLpTSZ6wSP8rLtoS0=
X-Received: by 2002:a17:90b:4a86:b0:39e:6795:f7da with SMTP id 98e67ed59e1d1-3aceefbde18mr2585035a91.19.1792255093359;
        Sat, 17 Oct 2026 09:38:13 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e7320sm13460227a91.6.2026.10.17.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:12 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 04/43] bpf: don't hand out a linked element as extra element
Date: Sat, 17 Oct 2026 16:37:06 +0000
Message-ID: <20261017163745.3341787-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

When htab_map_update_elem() replaces an element of a preallocated map,
alloc_htab_elem() takes the spare element of this cpu and puts the old
element into the per-cpu slot right away, long before the old element is
unlinked from its bucket.  The bucket lock disables interrupts, but it
does not keep out an NMI, or a tracing program on the return of
alloc_htab_elem().  bpf_prog_active only helps if both programs are
kprobe, tracepoint or perf_event programs.  A program that updates an
existing key in another bucket of the same map gets to use the slot:

  htab_map_update_elem(k1)              tc, xdp, fentry, raw_tp, ...
    alloc_htab_elem()
      l_new = *pl_new
      *pl_new = l_old                   still linked in bucket 1
      <NMI>
        htab_map_update_elem(k2)        perf_event program
          l_new = *pl_new               the l_old of the outer update
          hlist_nulls_add_head_rcu(l_new, bucket 2)
          hlist_nulls_del_rcu(k2's old element)
      </NMI>
    hlist_nulls_add_head_rcu(l_new, bucket 1)
    hlist_nulls_del_rcu(l_old)

If l_old was the first element of bucket 1, the outer add points its pprev
at l_new, and the delete takes it out of bucket 1 only.  l_new->next now
leads into bucket 2, where l_old stays with a poisoned pprev, on which a
delete of k2 crashes.  If it was not the first, the delete takes it out of
bucket 2: k2 is gone from the map, and the chain of bucket 1 still contains
l_old, whose next pointer leads into bucket 2.

Either way a walk of bucket 1 ends on the nulls value of bucket 2.
lookup_nulls_elem_raw() restarts whenever that happens, so every lookup in
bucket 1 which does not find its key spins forever:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
   __htab_map_lookup_elem+0x354/0x4d0

  BUG: KASAN: wild-memory-access in htab_map_delete_elem+0x30c/0x670
  Write of size 8 at addr dead000000000122 by task extra/102

An NMI between the load and the store of the slot makes both updates use
the same element, with much the same result.

Empty the slot when the spare element is taken, in a way that is atomic
on this cpu, and put the old element in only after it has been unlinked
and its timers and the like have been cancelled.  A nested update that
finds the slot empty, which is the case that corrupted the map, fails with
-EBUSY.

Fixes: 8c290e60fa2a ("bpf: fix hashmap extra_elems logic")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/hashtab.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9d4791ee1741..66ebb5a32807 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1279,11 +1279,17 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	if (prealloc) {
 		if (old_elem) {
 			/* if we're updating the existing element,
-			 * use per-cpu extra elems to avoid freelist_pop/push
+			 * use per-cpu extra elems to avoid freelist_pop/push.
+			 * The caller puts old_elem into the slot once it is
+			 * unlinked. Until then the slot is empty for an NMI
+			 * or a kprobe that updates this map on this cpu.
 			 */
 			pl_new = this_cpu_ptr(htab->extra_elems);
-			l_new = *pl_new;
-			*pl_new = old_elem;
+			l_new = READ_ONCE(*pl_new);
+			do {
+				if (!l_new)
+					return ERR_PTR(-EBUSY);
+			} while (!try_cmpxchg_local(pl_new, &l_new, NULL));
 		} else {
 			struct pcpu_freelist_node *l;
 
@@ -1459,11 +1465,15 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	if (l_old) {
 		hlist_nulls_del_rcu(&l_old->hash_node);
 
-		/* l_old has already been stashed in htab->extra_elems, cancel
-		 * its reusable special fields before it is available for reuse.
+		/*
+		 * l_old replaces the extra element that alloc_htab_elem() took.
+		 * Cancel its reusable special fields first: once it is in the
+		 * slot, the next update on this cpu can reuse it.
 		 */
-		if (htab_is_prealloc(htab))
+		if (htab_is_prealloc(htab)) {
 			check_and_cancel_fields(htab, l_old);
+			WRITE_ONCE(*this_cpu_ptr(htab->extra_elems), l_old);
+		}
 	}
 	htab_unlock_bucket(b, flags);
 	if (l_old && !htab_is_prealloc(htab))
-- 
2.55.0

