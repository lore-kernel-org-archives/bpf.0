Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8AE33F373
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151221; cv=none; b=U9VdWCJelaSIBr76j++VhBiZcT17kXYj9Je73zOXE7zliBiuFjesU5rvgh1/X2O2Xj3Z/0EJ8AYAOS+9pzUVFc+955P2n11gKr75f0bR0Ao1Wv6+B7ps096OJqiIvs/3OtQ8Dn9DSC0ZH2nCyg8absyBWWHHUi6KIwhrsS/O96I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151221; c=relaxed/simple;
	bh=R4bVNgPSOuISio+sF6d5eMFrwXNB4GTN0DEMumh+Xxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrNY/Ctjb9T/VEHz4Xf0W2gsMJ4NhQMXP1q1351BKHORgctfIhFJjIGezr1WamY9L5GCC1ZcncHQtJuZlydTnD9b73PNEoZAYcoXYMXjzzBpwUHM5CjLILAPbnNDRqWnKpM9GT/GOdNB6SmVD4frIJRWIC5DkDp9nO+glipwAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r9SDwZF4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+KaEiaxB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zJYEOQ6n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zu0/l55j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r9SDwZF4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+KaEiaxB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zJYEOQ6n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zu0/l55j"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75F555BCCC;
	Fri, 23 Jan 2026 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769151190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxNrmkpJY7trZ5HkdIEifD6rdzJ14H6U8LzdlLiW4qU=;
	b=r9SDwZF4N5TMq/bCCut8xI+Pjln70vZFRv8koGZo5bEWihsI7fKqnL1MAPDEEzPwSmN7l+
	r0iNQ+d0swbjqe8AIVBrKHTklk1F4EUnDddtcPF+8QAgnj5FLLv6jcml2J5A4PKHvv7Sw6
	S1k6LKAOKca87eTdXUcsApg3/OJtd3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769151190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxNrmkpJY7trZ5HkdIEifD6rdzJ14H6U8LzdlLiW4qU=;
	b=+KaEiaxBlb6Kw4QyXdzkq5GJf8zS2+XD4WH4j526MoG897CGza3rE4Sj1WYR+gG6abz9s5
	7yTAn/aqisq1kHBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769151189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxNrmkpJY7trZ5HkdIEifD6rdzJ14H6U8LzdlLiW4qU=;
	b=zJYEOQ6nDd47AnNranBn7tPqVXbIkAhvbd9zVe17RexRVcQTM9EJzs06vFu09j0Q7B/ZXI
	gaPZG/jgBPl6rXhD+uudSyoEghq2zYI0U1v/IUNNXJ1WXK14CzDblR4RUeNtsIx3L8EIsy
	FBl4Jen84LBEIpc2hqptJA/EGg7qGiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769151189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxNrmkpJY7trZ5HkdIEifD6rdzJ14H6U8LzdlLiW4qU=;
	b=zu0/l55j3CmO8XvZQyGq97d8ZgDFfpsrpT8z9vAdJ9GxBwBI137EYW4Um1l167fGHiea9P
	1hXa4iSb9V1zb+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42C03139E9;
	Fri, 23 Jan 2026 06:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qOsGENUac2k4YgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Jan 2026 06:53:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Jan 2026 07:52:40 +0100
Subject: [PATCH v4 02/22] mm/slab: fix false lockdep warning in
 __kfree_rcu_sheaf()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-sheaves-for-all-v4-2-041323d506f7@suse.cz>
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
 Vlastimil Babka <vbabka@suse.cz>, "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: b4 0.14.3
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
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,qemu.org:url,suse.cz:mid,suse.cz:email,oracle.com:email]
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 

From: Harry Yoo <harry.yoo@oracle.com>

kvfree_call_rcu() can be called while holding a raw_spinlock_t.
Since __kfree_rcu_sheaf() may acquire a spinlock_t (which becomes a
sleeping lock on PREEMPT_RT) and violate lock nesting rules,
kvfree_call_rcu() bypasses the sheaves layer entirely on PREEMPT_RT.

However, lockdep still complains about acquiring spinlock_t while holding
raw_spinlock_t, even on !PREEMPT_RT where spinlock_t is a spinning lock.
This causes a false lockdep warning [1]:

 =============================
 [ BUG: Invalid wait context ]
 6.19.0-rc6-next-20260120 #21508 Not tainted
 -----------------------------
 migration/1/23 is trying to lock:
 ffff8afd01054e98 (&barn->lock){..-.}-{3:3}, at: barn_get_empty_sheaf+0x1d/0xb0
 other info that might help us debug this:
 context-{5:5}
 3 locks held by migration/1/23:
  #0: ffff8afd01fd89a8 (&p->pi_lock){-.-.}-{2:2}, at: __balance_push_cpu_stop+0x3f/0x200
  #1: ffffffff9f15c5c8 (rcu_read_lock){....}-{1:3}, at: cpuset_cpus_allowed_fallback+0x27/0x250
  #2: ffff8afd1f470be0 ((local_lock_t *)&pcs->lock){+.+.}-{3:3}, at: __kfree_rcu_sheaf+0x52/0x3d0
 stack backtrace:
 CPU: 1 UID: 0 PID: 23 Comm: migration/1 Not tainted 6.19.0-rc6-next-20260120 #21508 PREEMPTLAZY
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
 Stopper: __balance_push_cpu_stop+0x0/0x200 <- balance_push+0x118/0x170
 Call Trace:
  <TASK>
  __dump_stack+0x22/0x30
  dump_stack_lvl+0x60/0x80
  dump_stack+0x19/0x24
  __lock_acquire+0xd3a/0x28e0
  ? __lock_acquire+0x5a9/0x28e0
  ? __lock_acquire+0x5a9/0x28e0
  ? barn_get_empty_sheaf+0x1d/0xb0
  lock_acquire+0xc3/0x270
  ? barn_get_empty_sheaf+0x1d/0xb0
  ? __kfree_rcu_sheaf+0x52/0x3d0
  _raw_spin_lock_irqsave+0x47/0x70
  ? barn_get_empty_sheaf+0x1d/0xb0
  barn_get_empty_sheaf+0x1d/0xb0
  ? __kfree_rcu_sheaf+0x52/0x3d0
  __kfree_rcu_sheaf+0x19f/0x3d0
  kvfree_call_rcu+0xaf/0x390
  set_cpus_allowed_force+0xc8/0xf0
  [...]
  </TASK>

This wasn't triggered until sheaves were enabled for all slab caches,
since kfree_rcu() wasn't being called with a raw spinlock held for
caches with sheaves (vma, maple node).

As suggested by Vlastimil Babka, fix this by using a lockdep map with
LD_WAIT_CONFIG wait type to tell lockdep that acquiring spinlock_t is valid
in this case, as those spinlocks won't be used on PREEMPT_RT.

Note that kfree_rcu_sheaf_map should be acquired using _try() variant,
otherwise the acquisition of the lockdep map itself will trigger an invalid
wait context warning.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Closes: https://lore.kernel.org/linux-mm/c858b9af-2510-448b-9ab3-058f7b80dd42@paulmck-laptop [1]
Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() operations")
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index df71c156d13c..4eb60e99abd7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6268,11 +6268,26 @@ static void rcu_free_sheaf(struct rcu_head *head)
 	free_empty_sheaf(s, sheaf);
 }
 
+/*
+ * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
+ * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMPT_RT),
+ * this would violate lock nesting rules. Therefore, kvfree_call_rcu() avoids
+ * this problem by bypassing the sheaves layer entirely on PREEMPT_RT.
+ *
+ * However, lockdep still complains that it is invalid to acquire spinlock_t
+ * while holding raw_spinlock_t, even on !PREEMPT_RT where spinlock_t is a
+ * spinning lock. Tell lockdep that acquiring spinlock_t is valid here
+ * by temporarily raising the wait-type to LD_WAIT_CONFIG.
+ */
+static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
+
 bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *rcu_sheaf;
 
+	lock_map_acquire_try(&kfree_rcu_sheaf_map);
+
 	if (!local_trylock(&s->cpu_sheaves->lock))
 		goto fail;
 
@@ -6349,10 +6364,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 	local_unlock(&s->cpu_sheaves->lock);
 
 	stat(s, FREE_RCU_SHEAF);
+	lock_map_release(&kfree_rcu_sheaf_map);
 	return true;
 
 fail:
 	stat(s, FREE_RCU_SHEAF_FAIL);
+	lock_map_release(&kfree_rcu_sheaf_map);
 	return false;
 }
 

-- 
2.52.0

