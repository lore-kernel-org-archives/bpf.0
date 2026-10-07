Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A64DEC0E
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 19:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403190; cv=none; b=n2X9bOwP0GGDlLNaNxiLzPjYL2Y6rB+3Bx+FJeBuX6Muuvr8cKWBvBWLgH5RId5qnudb/gVL4kbqmAsbzjSG2I8BWY+DAu8o5QYX82LJcrOnIy+LUucrGpt10VyhBryWRZgCC/B/gQFZCcdfZJFaGE27u2StWEETXMC+uZSuKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403190; c=relaxed/simple;
	bh=ovwJuZ7EJ7wjONSARifAxDAgx4Ym9sF+zZfy3Xmc8xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp8ULItZioDzhBRhK7khOqH6A2j6A0nUArTCiJE76u/LGAo51PfzFRe+7gyNUC1xm2jl7LPGuTvkUr1LpzkI7dYKMOYAXTnnigNknuozNlSYSYuS86d8ID/qnvYP5Zl6MSGWo1AjtzKp0V1T2Rd778bG/PaSMpR7jI1eFUuGNV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=iCzA9hes; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="iCzA9hes"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6df7f544919so1493363eaf.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1791403186; x=1792007986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmuguSQcbeAhN/rpcSMJYygZi4fbgxuPSkkmPTezGHI=;
        b=iCzA9hesvuVKzkmkz7qhh9jpt3FnVy5N+0O3h+vRxYuQ/e+5jmAricm53rdIAAGVkw
         m9gMK34V01eL03vHJxCK+6zJiVTQmcgKsaXeaRhZBTGSoFebwvEbGNTBULVfXDWj/muL
         Rz7L1VxvDmbcTrKUejGL17sY3Djqxr9NoUeIXPUYmUpCq6BzOVQs8Y9JjBlwJxXxxzbh
         envauYfZyWJ4kMqEQc7kSWfFuzo4E7+r+9PuUZcdnKHsP8kjlpzItZEQX7U5IBPx0d6i
         lUvSO0Mznx0rbzYj/RYKVECsNSi88dtsiIfJMjbDKN/mE94zAHtsWyaABxeSPQI4o/Zy
         klZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791403186; x=1792007986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmuguSQcbeAhN/rpcSMJYygZi4fbgxuPSkkmPTezGHI=;
        b=lGvGET9sdlxN8ALhDY9ntEWmVnLVMJee4tNbjPe8y8lBBpw4OMyCZq7QJXOK9qMOVc
         lgQZ0wZUGjFEf3c1/s8GgJWj9ukniCZRUOqN+Osv315xHJvill1OnES9bTRtmyqIvxjq
         lUs7wjhq02g9vTiZZB7JvJsUms0hO0RnECbFNWEsEWKaeG27IJsLxTBtKuM5zDdLDVI+
         QaqxLRCVbmtNtT4fpjC468xFfO5BCwmnNgyFlGvfyM3QYrHH+uMbuAFuzZP6lPkBuVrq
         I7YqA0GcXi+4X4q68EnRhZJ5K8r9iDPRaC1dhaOEieJYIbtQ9On2FHq7bkqSeEvSgxuP
         7PaA==
X-Forwarded-Encrypted: i=1; AKwUvBzpwh6rsFaF3mV9EwfRHSlyljS7Sz/e9ZMHrFm10XdspqaVVxN/EUzFUIkhlyddHzxqW/w=@vger.kernel.org
X-Gm-Message-State: AFuF++kqNOC2zd591z+6atbgUZn5Eegtgw4YSNAzuQETONmKvNLC+gB1
	7Cwa3Ts0B8RyBzRCqGxJpQ8yNJsd8zqgPgDy/UiEWp/cq8t1G9PFkAK0auGt1osBfBdwv2m32li
	BxzPd
X-Gm-Gg: AYBFou3WlEmkRFK1pbfKWDjneloYXW/QnH9FSzx3K43T6/4f5VnRvpPu2/2oPNEmcb0
	34UlGl2rwemPHcUCXTZiwPvp1XCSWgPlUqBZct+CnCaJ6aR0onM4lueJLhufy1DS96Jnm2DHaR+
	LbHHIC0aj3jotZHQX1pBYz1EXnOmNY8mC0hooTIiUiKMpk2fNtEDA27qWkYPcmEb5FrQ4TPuGsa
	1n76XsVAJzFojF87X2cczB4epF0kE8lNq0hs7KnHdN6a1lRsSDZZ0CFb1MAHEUd69R3X+Xz0mxh
	uAFY5LaKOfA9SgaxdOtY3iPfkCRxVKsgjJm6te7rs9LeQk214pdm3EF5HGGm650VLqPCPOvOsBL
	3ZO0yfx1/4o7LBRz80wPXpHOOIVVuTWcfAeoB2wXXJdeAhgGR2M5MBWQgPnrWDMwB4x//JB9Ph8
	jRCsVE3lALAb/c+9evOfX6zdTeiDSy++jcqrKD+E+NR4wSUpsW6c5x8VI/R/V40qyTfP+cg1UHb
	uZ+Z22QL2bEMdpPWTf7mop8IcxqulJmFVJxswHe2g==
X-Received: by 2002:a05:6820:200b:b0:6df:428f:f17e with SMTP id 006d021491bc7-6e7a65caaa2mr3346065eaf.39.1791403186071;
        Wed, 07 Oct 2026 12:59:46 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a274c9c520sm1084285fac.16.2026.10.07.12.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:59:45 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org,
	Daire Byrne <daire@dneg.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH RFC v2 5/9] SUNRPC: dispatch control events ahead of data within a client
Date: Wed,  7 Oct 2026 15:59:30 -0400
Message-ID: <c7a3a17e887512ce20a8ea90b706816dcbf8c785.1791402701.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791402701.git.bcodding@hammerspace.com>
References: <cover.1791402701.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Coddington <bcodding@hammerspace.com>

A transport that needs a connection accepted, closed, or a handshake
run waits its turn like a transport with data, behind every transport
of its client queued before it, and a client with many connections can
hold a close back for k rounds of all the busy clients.  None of those
events costs the service a request's worth of work, and a close frees
resources the sooner it is served.

Give each client a second per-pool queue for transports with XPT_CONN,
XPT_CLOSE or XPT_HANDSHAKE set when they are enqueued, and have the
dispatcher serve that queue before the client's data queue.  The
client's turn in the round-robin is unchanged; only which of its
transports goes first.  A transport that is already queued with data
when it is closed is served in its original order, as before.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 include/linux/sunrpc/svc.h      |  2 ++
 include/linux/sunrpc/svc_xprt.h |  3 ++
 net/sunrpc/svc.c                |  1 +
 net/sunrpc/svc_xprt.c           | 60 +++++++++++++++++++++++++++------
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5d8e35c5379e..02a8eb5d3357 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -66,6 +66,7 @@ enum {
  * of the service does not grow with its connection count.
  */
 struct svc_client_pool {
+	struct lwq		cp_ctrl;	/* ready transports with a control event */
 	struct lwq		cp_xprts;	/* ready transports */
 	struct lwq_node		cp_ready;	/* link in svc_pool.sp_clients */
 	unsigned long		cp_flags;
@@ -74,6 +75,7 @@ struct svc_client_pool {
 
 enum {
 	SVC_CP_QUEUED,	/* on sp_clients, or held by the thread that took it */
+	SVC_CP_DATA_NEXT, /* last turn served a control event; data is owed */
 };
 
 struct svc_client {
diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 10c18e948b42..e05d7c8610ff 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -116,6 +116,9 @@ enum {
 				 */
 };
 
+/* events a client's queue serves ahead of its data */
+#define SVC_XPT_CTRL_EVENTS	(BIT(XPT_CONN) | BIT(XPT_CLOSE) | BIT(XPT_HANDSHAKE))
+
 /*
  * Maximum number of "tmp" connections - those without XPT_PEER_VALID -
  * permitted on any service.
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4adf113d067b..92c6737e5905 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -405,6 +405,7 @@ struct svc_client *svc_client_alloc(unsigned int nrpools, gfp_t gfp)
 	refcount_set(&cl->cl_ref, 1);
 	INIT_HLIST_NODE(&cl->cl_hash);
 	for (i = 0; i < nrpools; i++) {
+		lwq_init(&cl->cl_pool[i].cp_ctrl);
 		lwq_init(&cl->cl_pool[i].cp_xprts);
 		cl->cl_pool[i].cp_client = cl;
 	}
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 735f4d92bf5d..14a7483886fc 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -646,7 +646,10 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 
 	percpu_counter_inc(&pool->sp_sockets_queued);
 	xprt->xpt_qtime = ktime_get();
-	lwq_enqueue(&xprt->xpt_ready, &cp->cp_xprts);
+	if (READ_ONCE(xprt->xpt_flags) & SVC_XPT_CTRL_EVENTS)
+		lwq_enqueue(&xprt->xpt_ready, &cp->cp_ctrl);
+	else
+		lwq_enqueue(&xprt->xpt_ready, &cp->cp_xprts);
 	if (!test_and_set_bit(SVC_CP_QUEUED, &cp->cp_flags))
 		lwq_enqueue(&cp->cp_ready, &pool->sp_clients);
 
@@ -654,6 +657,11 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 }
 EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
 
+static bool svc_client_pool_empty(struct svc_client_pool *cp)
+{
+	return lwq_empty(&cp->cp_ctrl) && lwq_empty(&cp->cp_xprts);
+}
+
 /*
  * Put @cp back on the pool's client queue if it still has ready
  * transports.  Otherwise clear SVC_CP_QUEUED and look once more: an
@@ -662,21 +670,47 @@ EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
 static void svc_client_pool_requeue(struct svc_pool *pool,
 				    struct svc_client_pool *cp)
 {
-	if (!lwq_empty(&cp->cp_xprts)) {
+	if (!svc_client_pool_empty(cp)) {
 		lwq_enqueue(&cp->cp_ready, &pool->sp_clients);
 		return;
 	}
 	clear_bit(SVC_CP_QUEUED, &cp->cp_flags);
 	/* the clear is visible before the re-test; see svc_xprt_enqueue() */
 	smp_mb__after_atomic();
-	if (!lwq_empty(&cp->cp_xprts) &&
+	if (!svc_client_pool_empty(cp) &&
 	    !test_and_set_bit(SVC_CP_QUEUED, &cp->cp_flags))
 		lwq_enqueue(&cp->cp_ready, &pool->sp_clients);
 }
 
 /*
- * Dequeue the next transport: one from the client at the head of the
- * pool's client queue, which then goes to the tail if it has more.
+ * A client's control events go before its data, but not two turns in a
+ * row while data waits: a listener re-arms XPT_CONN after every accept
+ * and would otherwise hold the anonymous client's turns for as long as
+ * connections keep arriving.  Only the thread holding @cp touches
+ * SVC_CP_DATA_NEXT.
+ */
+static struct svc_xprt *svc_client_pool_dequeue(struct svc_client_pool *cp)
+{
+	struct svc_xprt *xprt = NULL;
+	bool data_owed;
+
+	data_owed = test_and_clear_bit(SVC_CP_DATA_NEXT, &cp->cp_flags);
+	if (!data_owed)
+		xprt = lwq_dequeue(&cp->cp_ctrl, struct svc_xprt, xpt_ready);
+	if (!xprt) {
+		xprt = lwq_dequeue(&cp->cp_xprts, struct svc_xprt, xpt_ready);
+		if (xprt || !data_owed)
+			return xprt;
+		xprt = lwq_dequeue(&cp->cp_ctrl, struct svc_xprt, xpt_ready);
+	}
+	if (xprt && !lwq_empty(&cp->cp_xprts))
+		set_bit(SVC_CP_DATA_NEXT, &cp->cp_flags);
+	return xprt;
+}
+
+/*
+ * Dequeue the next transport from the pool's client queue: one from the
+ * client at the head, which then goes to the tail if it has more.
  */
 static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
 {
@@ -688,7 +722,7 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
 				 cp_ready);
 		if (!cp)
 			return NULL;
-		xprt = lwq_dequeue(&cp->cp_xprts, struct svc_xprt, xpt_ready);
+		xprt = svc_client_pool_dequeue(cp);
 		svc_client_pool_requeue(pool, cp);
 	} while (!xprt);
 	svc_xprt_get(xprt);
@@ -1371,15 +1405,15 @@ static int svc_close_list(struct svc_serv *serv, struct list_head *xprt_list, st
 }
 
 /*
- * Delete the ready transports of @net that are queued on @cp; the rest go
+ * Delete the ready transports of @net that are queued on @lq; the rest go
  * back in their order.
  */
-static void svc_client_pool_clean(struct svc_client_pool *cp, struct net *net)
+static void svc_xprt_lwq_clean(struct lwq *lq, struct net *net)
 {
 	struct llist_node *q, **t1, *t2;
 	struct svc_xprt *xprt;
 
-	q = lwq_dequeue_all(&cp->cp_xprts);
+	q = lwq_dequeue_all(lq);
 	lwq_for_each_safe(xprt, t1, t2, &q, xpt_ready) {
 		if (xprt->xpt_net == net) {
 			set_bit(XPT_CLOSE, &xprt->xpt_flags);
@@ -1388,7 +1422,13 @@ static void svc_client_pool_clean(struct svc_client_pool *cp, struct net *net)
 		}
 	}
 	if (q)
-		lwq_enqueue_batch(q, &cp->cp_xprts);
+		lwq_enqueue_batch(q, lq);
+}
+
+static void svc_client_pool_clean(struct svc_client_pool *cp, struct net *net)
+{
+	svc_xprt_lwq_clean(&cp->cp_ctrl, net);
+	svc_xprt_lwq_clean(&cp->cp_xprts, net);
 }
 
 static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
-- 
2.53.0

