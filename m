Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.229
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489053;
	b=5nD0iUfuNjm54LPpwkIJbgUxsSNAiliXJNWeTwHtYzupVTNB3Yty5hBqQFlj2hsqX8/8
	 q/ZSB7dQ1rnGZbd5zp7dWLffqUPse43nXQ4Nx7mY9UFyDa7WSDxZBJFeljlyGr/b6Lfif
	 SDzG7ZDaRnkw9XUmEwfvY3ae4+MxsRjsXtu7K63deREx/Ru+JVk1BnBLPCnAgJK6oQi6g
	 M0LFv+Fb5DTKO2GZ2uVFhNi3b40qBBxnHqCqiZUhPS22KryU6n+2zDIZy+l+3oLrpHiZS
	 ElL7vpfIg3iQZRzkY7vqLdZxiiRyIptberNgEtfEMo/lrDv3PuCrTU8XijUrbY74FBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489053;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5WLV9GwJEw5snsivwVTcevybITAUjlFSXt5ZHXYJVNM=;
	b=4lgI9SHGV+0JgO1+SJa3iOxJe9dRyE3G6wFf+AM7P7X0YdCLjNo0xQqfzg0x7nCYhLwk
	 FlgKKCVCko8NbGqz/zkWUXtPT5qOeR0iUMRCPJHz/61x6mvOGRvrVhrDJbrn3G9V1d/BB
	 bkm2Tef8spgCSkbzpXz/K/8KxJeJog3KOE43JoEhYu/mC9ts9raOKl5v1Lukeok/FQDny
	 7Mm2JTxQ+SD0AH+uhQmN1ZBK3P/Vm5jNPEZKljOKMACsWB5STnBZagLxNiKCDzjvuSK1R
	 mkzHDEohc87Xfrmb9Gt/wePqwuobtsbjQlXqVGInVbqaFV5n6EfDb2zMjsO8uxZuTPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="sibHd4/I";
	arc=none smtp.remote-ip=91.218.175.229
Received: from mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33960A380E
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 13:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE33960A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sibHd4/I
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1ASfApR/tWCoxARtdYT6Dnyb/jCq3rXoAd9CiF8q4Us=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794489051; v=1; x=1795093851;
 b=sibHd4/IY2DocB0iDzYKQYfmRweYlr2RxY4mGvZ3KRUatGk+6djqlV1tichgJEz7Mi+Spm5b
 F3gb6nhs7zO7Pq8RrcyatNx+zCmY5itpWL2FNM0tNYyYetLt2h07u75vVFzzHdWF/NiRQk7NYuB
 nk+pwIogBCV23n7WB2Mge40E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 960a86b2038b9ab9;
	Thu, 12 Nov 2026 13:10:51 +0000
X-Mizu-Trace-ID: 960a86b2038b9ab9
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	usama.arif@linux.dev,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 5/6] tools/sched_ext: scx_flatcg: Don't strand a cgroup on the ENQ_RACE path
Date: Thu, 12 Nov 2026 21:09:33 +0800
Message-ID: <20261112130934.563321-6-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112130934.563321-1-cui.tao@linux.dev>
References: <20261112130934.563321-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

cgrp_enqueued() bails out on the ENQ_RACE path when bpf_kptr_xchg()
returns NULL: the node is either back on the rbtree or in the hands
of try_pick_next_cgroup(), which found this cgroup empty and is
deciding whether to stash it back or re-add it to the rbtree.

The bailout relies on the assumption that a task being enqueued is
already visible to try_pick_next_cgroup()'s emptiness test. That
doesn't hold: inserts from ops.enqueue() are deferred till after
ops.enqueue() returns, so try_pick_next_cgroup() can see an empty DSQ,
clear ->queued and stash the node while ->queued stays at 1 from this
enqueue, leaving the cgroup off the rbtree with every subsequent
enqueue skipped; the whole group strands until it is destroyed or the
scheduler is reloaded, and the kernel watchdog eventually kills the
scheduler with SCX_EXIT_ERROR_STALL.

Instead of bailing out, wait for the picker to resolve and retry:
grabbing the node when it's stashed back, or bailing out when the
picker has re-added the cgroup to the rbtree. Exhausted retries mean
the cgroup is in the common cases either going away with its node
dropped or already back on the rbtree; a narrow window with the picker
still holding the node in flight can strand the cgroup the same way
the unpatched code does, at a rate orders of magnitude below stock.

Verified in qemu: driving ops.enqueue() races under CPU saturation strands
cgroups into scheduler-killing stalls 6/10 rounds on stock, 0/10 with the
change.

Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_flatcg.bpf.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 1d168d492203..5f2b9d0b867a 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -285,11 +285,24 @@ static void cgrp_enqueued(struct cgroup *cgrp, struct fcg_cgrp_ctx *cgc)
 		return;
 	}
 
-	/* NULL if the node is already on the rbtree */
+	/* NULL if the node is on the rbtree or in the picker's hands */
 	cgv_node = bpf_kptr_xchg(&stash->node, NULL);
 	if (!cgv_node) {
+		/*
+		 * The node is either back on the rbtree or in the
+		 * picker's hands; bailing out strands the cgroup. Wait
+		 * for the picker to resolve and retry.
+		 */
 		stat_inc(FCG_STAT_ENQ_RACE);
-		return;
+		bpf_repeat(CGROUP_MAX_RETRIES) {
+			cgv_node = bpf_kptr_xchg(&stash->node, NULL);
+			if (cgv_node)
+				break;
+			if (scx_bpf_dsq_nr_queued(cgid) > 0)
+				break;
+		}
+		if (!cgv_node)
+			return;
 	}
 
 	bpf_spin_lock(&cgv_tree_lock);
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
