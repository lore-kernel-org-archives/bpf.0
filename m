Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4A3AEF36
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255174; cv=none; b=dohjkvI4OW5Ne61/UjkwNDAYb+we1jsOvCBsyEwpsuIvkAoWUJ5WBUTTOgwKf9Zk2FMv0zbH+9/7WtUqikmBaY49utM15M1/r82MMJXBJQq0219/waAOVHYCQz+NfRaPr5bPWxscQaJ86QG6t1AWh0s9Sz1TvXaGUku8uC+UXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255174; c=relaxed/simple;
	bh=M8ES0kL0OPES6hbTArznFgO3NVcCTS5zVjhh6KSPQtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1AYKJEnonsfcNC+a5bR5AYYRPRS13JBxqIANODA5/qaIgTJy2jsUDPeAydmkjtDALXlOFCadUPpw9yiiCwg6v3XHETuUzrPTyVaATvaLNGp43qm5MT1PdU3nIqDfdYvwkJ9hHZKgF2OxTgCXVd0Jc0wush7Ig0yK377VLxfXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8Nu7cdU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8Nu7cdU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9d1114320so238895ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255172; x=1792859972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LioG1TfRbQbbPeFWnF473ae+LrllOtiRpu5PoIzCrE=;
        b=T8Nu7cdUN5RI2YNr4lbNB7ftELHjufitmqI+1qUCQwsYUCb0VtGtnyfLNrraUCz6+C
         AW1qzY4doxpQXZ6nZgUtkzG4OP6lyEshDbzxBNR30ljKWge6koL3VoN1LY2dxA0T/Gvh
         sG58wWefNUmiTm5wmr4w7uwF5Q1y15yVK4/yMUKMxzmDGYRfER910ABFGdYlEnFofQYt
         b10TtKJadYKoZSGbq2VJGcG3udGWBz+qoJrLCGLw6wJ6hJYePSlij/tBAttaKvMFwGWx
         fdmBfI14cW5WKX4PlvHdslt3rSeKUcEPhFz8rU7O1aK7YyktAW3fXd3QQy3LDQQPA4TR
         6ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255172; x=1792859972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4LioG1TfRbQbbPeFWnF473ae+LrllOtiRpu5PoIzCrE=;
        b=yfbrZAenSEy5DqvqHAFllSKBRsq31j+5Mvy7DNC76TIt2j2DtS3T1b8i2ili/c9JCa
         IR+7tEGgfkLLacMbcKW6zihnJ4pSCu80WYj9ZZAwVjXaE+sf9nH9qxDZcnAMydCIeZAz
         YGbdqCeQIK7mXCnZGnTCiOHMFBBPz7x8vZKioNp17E6NRx6vTVX46A0MwjYWYecW0/nW
         mu3ntbrAAzEpNcMMm3RaRTYBkI+zMGRomMB2itd+SgcwQTwe5cI21Regb1qNFLR4m0qQ
         EKYdpSXEUJlXEZN8BTEp9Q1wi/LMs1BiD7bb6xkuRDGi+N3LBwdOy5Vpmbe/Hot2yO1G
         pJIA==
X-Gm-Message-State: AFq9FYLI3w4hzWgcafePeugGY4924ApMr0zRCxULtflETPK8pr4QeLzY
	pfCK/0gb2Foj0PpMug7noWx6WtWXfNTL9EYOBjM4QMqRo9lGexriNYHzePTUtg==
X-Gm-Gg: AYBFou1hVvVDi5Su/i/sv8u3PnuJQeVdaPZqPi28M6geYI9uafHOTjjRaoVh1XQRozv
	vUZJUCjbrLkykqxsWQRaRvnDK8leAsd04JuArMPYYyNktra3IPdkLNZcJuBb0bYsS1MLyMw1I3O
	2QJMOSNEVtzG22y/yTcZV9cPqoe26NBfecBY3AOJyIjTcGRi7JfENzCcSp7+czswaIsdZZuGc7s
	vC/IV6SunZeB1ik75T0MSrVrfg4sC9jLGeoWDbqdgByZ9nBlmxidj+eXzCDhyUNVJrY6owfrA42
	U1BiTsPvsjeIJ+s11gH6n4XTazuxahNs7ksLadTz7pqXgWATcR4+Gb2/72np++QyF1NRwfC+I/D
	VysyxlLhL/tP/QYCyFp82xa+OnIEPRL7W4jPBztwMA79GWbNDjwe2GXuufxccgoeLmqcvF0cKpN
	E0a/C959K1e1Tv1sBrPSacfKjya7lhSmoidtdWjLs/luo2A5516Fh7kcRU++zAfKqUsLLkbGVnK
	inx015IFj6ig/5l6+TekMOgrzTcZSNTWk5Clenw1weHLq0QvvyvvQd8CywBvWu2RBSU04NTDkpx
	G0dqcJVWfcFWT4sZe+9dZzTWMGtaSkjFcQJsDaplKP4=
X-Received: by 2002:a17:902:dac8:b0:2e9:5829:9b41 with SMTP id d9443c01a7336-2e9a6c02ce4mr32214835ad.37.1792255172188;
        Sat, 17 Oct 2026 09:39:32 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1dd8sm22180545ad.69.2026.10.17.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 17/43] bpf: Hold the socket in the sk_storage map iterator
Date: Sat, 17 Oct 2026 16:37:19 +0000
Message-ID: <20261017163745.3341787-18-alexei.starovoitov@gmail.com>
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

The iterator over a sk_storage map passes the owner of an element to its
program as ctx->sk, without a reference. All that it holds is the RCU read
lock, which keeps the element and the storage, not the socket.

An element is unlinked by bpf_sk_storage_free(), which __sk_destruct()
calls right before it frees the socket. That is no better for a socket
with SOCK_RCU_FREE: the grace period comes in front of __sk_destruct(),
so a reader which starts behind call_rcu() still finds the element. The
program and the helpers it hands ctx->sk to, such as
bpf_sk_storage_get() or bpf_sk_storage_delete(), use a socket which is
being freed on another CPU. It takes nothing but reading the iterator
while sockets with an element in the map are closed, by whomever.

Take a reference for the time of the program, and skip the element if
there is none to be had. To look at the owner at all, do what
bpf_selem_unlink_nofail() does for bpf_local_storage_map_free(): as long
as the element is linked under the lock of the storage,
bpf_local_storage_destroy() has not got past it, unless it has given up
on the lock, and then it waits for owner_refcnt.

The last reference may now be dropped by the iterator. The end of a socket
may want process context: rfcomm_sock_destruct() takes a mutex. So only
drop the reference under RCU, and free a socket whose last one it was when
the RCU read lock has been released, which is at the end of a bucket and
of every read() at the latest.

Fixes: c69d2ddb2072 ("bpf: Using rcu_read_lock for bpf_sk_storage_map iterator")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/bpf_sk_storage.c | 73 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index aea67b446c7c..ea22ec5ef5b1 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -699,8 +699,37 @@ struct bpf_iter_seq_sk_storage_map_info {
 	struct bpf_map *map;
 	unsigned int bucket_id;
 	unsigned skip_elems;
+	struct rcu_head *dead_sks;
 };
 
+/*
+ * sock_put() in two halves. The end of a socket may want process context:
+ * rfcomm_sock_destruct() takes a mutex. If the iterator drops the last
+ * reference, it keeps the socket until it has left the RCU read side critical
+ * section. Nobody uses sk_rcu before sk_destruct().
+ */
+static void
+bpf_sk_storage_map_seq_put_sk(struct bpf_iter_seq_sk_storage_map_info *info,
+			      struct sock *sk)
+{
+	if (refcount_dec_and_test(&sk->sk_refcnt)) {
+		sk->sk_rcu.next = info->dead_sks;
+		info->dead_sks = &sk->sk_rcu;
+	}
+}
+
+static void
+bpf_sk_storage_map_seq_free_sks(struct bpf_iter_seq_sk_storage_map_info *info)
+{
+	struct sock *sk;
+
+	while (info->dead_sks) {
+		sk = container_of(info->dead_sks, struct sock, sk_rcu);
+		info->dead_sks = sk->sk_rcu.next;
+		sk_free(sk);
+	}
+}
+
 static struct bpf_local_storage_elem *
 bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 				 struct bpf_local_storage_elem *prev_selem)
@@ -729,6 +758,7 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 			/* not found, unlock and go to the next bucket */
 			b = &smap->buckets[bucket_id++];
 			rcu_read_unlock();
+			bpf_sk_storage_map_seq_free_sks(info);
 			skip_elems = 0;
 			break;
 		}
@@ -796,12 +826,44 @@ DEFINE_BPF_ITER_FUNC(bpf_sk_storage_map, struct bpf_iter_meta *meta,
 		     struct bpf_map *map, struct sock *sk,
 		     void *value)
 
+/*
+ * Take a reference on the socket which owns @selem. RCU keeps the element, not
+ * its owner. As long as the element is linked under the lock of the storage,
+ * the owner has not got past bpf_sk_storage_free(), unless that has given up
+ * on the lock. Then it still waits for owner_refcnt.
+ */
+static struct sock *
+bpf_sk_storage_selem_get_sk(struct bpf_local_storage_elem *selem)
+{
+	struct bpf_local_storage *sk_storage;
+	struct sock *sk = NULL;
+	unsigned long flags;
+
+	sk_storage = rcu_dereference(selem->local_storage);
+	/* reset since ->next() looked: the socket goes away */
+	if (!sk_storage)
+		return NULL;
+
+	if (raw_res_spin_lock_irqsave(&sk_storage->lock, flags))
+		return NULL;
+
+	if (!hlist_unhashed(&selem->snode) &&
+	    refcount_inc_not_zero(&sk_storage->owner_refcnt)) {
+		sk = sk_storage->owner;
+		if (!refcount_inc_not_zero(&sk->sk_refcnt))
+			sk = NULL;
+		bpf_local_storage_unpin_owner(sk_storage);
+	}
+	raw_res_spin_unlock_irqrestore(&sk_storage->lock, flags);
+
+	return sk;
+}
+
 static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 					 struct bpf_local_storage_elem *selem)
 {
 	struct bpf_iter_seq_sk_storage_map_info *info = seq->private;
 	struct bpf_iter__bpf_sk_storage_map ctx = {};
-	struct bpf_local_storage *sk_storage;
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	int ret = 0;
@@ -812,14 +874,14 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.meta = &meta;
 		ctx.map = info->map;
 		if (selem) {
-			sk_storage = rcu_dereference(selem->local_storage);
-			/* reset since ->next() looked: the socket goes away */
-			if (!sk_storage)
+			ctx.sk = bpf_sk_storage_selem_get_sk(selem);
+			if (!ctx.sk)
 				return SEQ_SKIP;
-			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}
 		ret = bpf_iter_run_prog(prog, &ctx);
+		if (ctx.sk)
+			bpf_sk_storage_map_seq_put_sk(info, ctx.sk);
 	}
 
 	return ret;
@@ -837,6 +899,7 @@ static void bpf_sk_storage_map_seq_stop(struct seq_file *seq, void *v)
 		(void)__bpf_sk_storage_map_seq_show(seq, v);
 	else
 		rcu_read_unlock();
+	bpf_sk_storage_map_seq_free_sks(seq->private);
 }
 
 static int bpf_iter_init_sk_storage_map(void *priv_data,
-- 
2.55.0

