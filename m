Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4F330321
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151194; cv=none; b=e4Zme4vdP7AWK4jTHYuTapDwmcw+lCLrXPoORfmXV0Ogm3C8XEb9rdLCXb4ysT3E67uwTS70iTCC/Y3JV5sDQFLa+09EXOO8Qd0SlPGaeLGPpVgcuZrJf8tqeIyngHTEU28Lena7b67fYwSdhcwu8Bso/4m9B91hk25RpENIwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151194; c=relaxed/simple;
	bh=LX7IQPdJVzhw24Vkwc5tUgkwdulu/ZqBNkdur0x8MAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m6km3X1JSfS4be2iQOTU3ciGZNusH+ZRYuvRkXr9EJE5s5pZkXxSo10gurp9plSZgBEAqAfDRSS/jaXHZp9+gvwC3gZ7I4j0/i92F/vbOQkBKHGF1qVi+gtuENXAxjNVAPSZFdufsEM6EzRIQdnOJST5gTdAjSibF5JKbS5OMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WZgDDmnw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gnFCVeRb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WZgDDmnw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gnFCVeRb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95E685BCCD;
	Fri, 23 Jan 2026 06:53:09 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769151189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1HSP8e11HaumGUNzZ8v9KE8CG2FWMpTiIvIoTBcPSA=;
	b=WZgDDmnwgSFIVN9eK+o6iWr5OJFyCQ+Kb3BW8u693CP0/uQzTyRAjjILPzFXfQ+Qk0sZMw
	yyx7gNG9XTG1TrW0kzFafNOlo+vOiQWgT5URXow5I9+2+CKWZkv0dBB9EgHvqx+butrY5i
	nWaEj8+DMwZ5n/rPjADQssEBeFt9Rfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769151189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1HSP8e11HaumGUNzZ8v9KE8CG2FWMpTiIvIoTBcPSA=;
	b=gnFCVeRbIsPX31z3chUGfEkPi1tOAjKcm2WzVvRAI47B1Mef3iwY9ohZvqFw015ggqPIWT
	QbF8XnEge4sXtnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61D11139EA;
	Fri, 23 Jan 2026 06:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLyTF9Uac2k4YgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Jan 2026 06:53:09 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Jan 2026 07:52:41 +0100
Subject: [PATCH v4 03/22] slab: add SLAB_CONSISTENCY_CHECKS to
 SLAB_NEVER_MERGE
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-sheaves-for-all-v4-3-041323d506f7@suse.cz>
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
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 95E685BCCD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)]
X-Spam-Flag: NO

All the debug flags prevent merging, except SLAB_CONSISTENCY_CHECKS. This
is suboptimal because this flag (like any debug flags) prevents the
usage of any fastpaths, and thus affect performance of any aliased
cache. Also the objects from an aliased cache than the one specified for
debugging could also interfere with the debugging efforts.

Fix this by adding the whole SLAB_DEBUG_FLAGS collection to
SLAB_NEVER_MERGE instead of individual debug flags, so it now also
includes SLAB_CONSISTENCY_CHECKS.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index ee994ec7f251..e691ede0e6a8 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -45,9 +45,8 @@ struct kmem_cache *kmem_cache;
 /*
  * Set of flags that will prevent slab merging
  */
-#define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
-		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
-		SLAB_FAILSLAB | SLAB_NO_MERGE)
+#define SLAB_NEVER_MERGE (SLAB_DEBUG_FLAGS | SLAB_TYPESAFE_BY_RCU | \
+		SLAB_NOLEAKTRACE | SLAB_FAILSLAB | SLAB_NO_MERGE)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)

-- 
2.52.0

