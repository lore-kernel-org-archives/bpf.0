Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9679635D613
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151256; cv=none; b=gZDBuEwN0z6mHt0RNAVb79lMWuFmLftP5tqxJozSgwjlqfO9zSC2NrrvvCSDbCCXnQMaCew3S6oJ53AM8UuCazv1gjIoBhhv2eRjyK+Wx+fqhNZadULqpIdEN79SP2od26WnyuHLbjbCMxEfDxCsn7RrgB9prT4mgJ5JFKgbyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151256; c=relaxed/simple;
	bh=OFj95S/K2FAPlyl585935MsVlYYLr4XZmAEwxn0S/Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXQPdgRxxWdppFDFRNUVfrgLrVsvhP0+LGCfJAvA5Y/KuMwo0uzKkS3NroPyW70wEUewye8q+ggH8FddFjJOOnmC3YfBQ2gMGS+V+YGk1lljvGSiPnpx3jGhEl0qjd0jTaWB60IzUjBVZXgtNlVRdAbhYBcmXBpqcDYmRKXwPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27Uk3vvZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JtJZs1kb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27Uk3vvZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JtJZs1kb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27Uk3vvZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JtJZs1kb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27Uk3vvZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JtJZs1kb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 600B95BCD7;
	Fri, 23 Jan 2026 06:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769151191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSBhOPdL5sebK+aDhtX6/iV+qHkNH9ah4WZSL6is/IE=;
	b=27Uk3vvZIfiU/vSZ3nJW8pVCR0fwz18zznV7LcWuQYal1NmYlXiuIfjC981V6w04AS+ZKo
	3RFrrcR1KfnAiENMeYDFuX2JeFwX5/8uLt7JZbcaoRAb5oILHpCAIffRy75R72JX2hzlBU
	phrUxg732baj/ER2XQSIo1in2EjJMn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769151191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSBhOPdL5sebK+aDhtX6/iV+qHkNH9ah4WZSL6is/IE=;
	b=JtJZs1kbHObd8fveITzrAnKn7NAI6Um7nVyW5cvUinKDkh+dIor6PZNDiltOxli1IrMjqX
	R2dWEhOl/JyrKBCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769151191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSBhOPdL5sebK+aDhtX6/iV+qHkNH9ah4WZSL6is/IE=;
	b=27Uk3vvZIfiU/vSZ3nJW8pVCR0fwz18zznV7LcWuQYal1NmYlXiuIfjC981V6w04AS+ZKo
	3RFrrcR1KfnAiENMeYDFuX2JeFwX5/8uLt7JZbcaoRAb5oILHpCAIffRy75R72JX2hzlBU
	phrUxg732baj/ER2XQSIo1in2EjJMn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769151191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xSBhOPdL5sebK+aDhtX6/iV+qHkNH9ah4WZSL6is/IE=;
	b=JtJZs1kbHObd8fveITzrAnKn7NAI6Um7nVyW5cvUinKDkh+dIor6PZNDiltOxli1IrMjqX
	R2dWEhOl/JyrKBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38A441395E;
	Fri, 23 Jan 2026 06:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wC+KDdcac2k4YgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Jan 2026 06:53:11 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Jan 2026 07:52:58 +0100
Subject: [PATCH v4 20/22] slab: remove frozen slab checks from
 __slab_free()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-sheaves-for-all-v4-20-041323d506f7@suse.cz>
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
In-Reply-To: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
To: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

Currently slabs are only frozen after consistency checks failed. This
can happen only in caches with debugging enabled, and those use
free_to_partial_list() for freeing. The non-debug operation of
__slab_free() can thus stop considering the frozen field, and we can
remove the FREE_FROZEN stat.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Hao Li <hao.li@linux.dev>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d9fc56122975..3009eb7bd8d2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -338,7 +338,6 @@ enum stat_item {
 	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
 	FREE_FASTPATH,		/* Free to cpu slab */
 	FREE_SLOWPATH,		/* Freeing not to cpu slab */
-	FREE_FROZEN,		/* Freeing to frozen slab */
 	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
 	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
 	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
@@ -5109,7 +5108,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			unsigned long addr)
 
 {
-	bool was_frozen, was_full;
+	bool was_full;
 	struct freelist_counters old, new;
 	struct kmem_cache_node *n = NULL;
 	unsigned long flags;
@@ -5132,7 +5131,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		old.counters = slab->counters;
 
 		was_full = (old.freelist == NULL);
-		was_frozen = old.frozen;
 
 		set_freepointer(s, tail, old.freelist);
 
@@ -5145,7 +5143,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		 * to (due to not being full anymore) the partial list.
 		 * Unless it's frozen.
 		 */
-		if ((!new.inuse || was_full) && !was_frozen) {
+		if (!new.inuse || was_full) {
 
 			n = get_node(s, slab_nid(slab));
 			/*
@@ -5164,20 +5162,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	} while (!slab_update_freelist(s, slab, &old, &new, "__slab_free"));
 
 	if (likely(!n)) {
-
-		if (likely(was_frozen)) {
-			/*
-			 * The list lock was not taken therefore no list
-			 * activity can be necessary.
-			 */
-			stat(s, FREE_FROZEN);
-		}
-
 		/*
-		 * In other cases we didn't take the list_lock because the slab
-		 * was already on the partial list and will remain there.
+		 * We didn't take the list_lock because the slab was already on
+		 * the partial list and will remain there.
 		 */
-
 		return;
 	}
 
@@ -8753,7 +8741,6 @@ STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
 STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
-STAT_ATTR(FREE_FROZEN, free_frozen);
 STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
 STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
 STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
@@ -8858,7 +8845,6 @@ static struct attribute *slab_attrs[] = {
 	&free_rcu_sheaf_fail_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
-	&free_frozen_attr.attr,
 	&free_add_partial_attr.attr,
 	&free_remove_partial_attr.attr,
 	&alloc_from_partial_attr.attr,

-- 
2.52.0

