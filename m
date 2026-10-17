Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D34C37C925
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200449; cv=none; b=rrB2Qa1b2GtkNkBHT32kuytgkKn2N+3Er08k1Hnsahb2hk5pyig/AyYwgWInhXUN1qEe390FaPHjnhNAc2yfY8SY2tkugQXlZ+6qzY8x8E9aAy5oSoy4h3Zzd0WC/cm93CtCcoVMWv1Ool+uLKYEWz7KZkVazaasKy+jFLpGKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200449; c=relaxed/simple;
	bh=M8ES0kL0OPES6hbTArznFgO3NVcCTS5zVjhh6KSPQtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC3ZvKMAxbM4RoTZ3+UKCL+i2ARJIBw6V5olKqn1opuU2TGC007xfuoOIS8gWzTdWtDVMBIOYO+fPrU3RLiOTIEuroAXftECO8UouOTHpO9FmUET3tKk3x/bdITn4yWvp0Z6ccsC8OVmXeElgYcPXy7xVwvVfyTcNM8OVwMxPjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2cGTRNM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2cGTRNM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso271278a91.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200448; x=1792805248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4LioG1TfRbQbbPeFWnF473ae+LrllOtiRpu5PoIzCrE=;
        b=r2cGTRNMaBYoc1wKb7mTH5zmcgDxi1ioMn3ZjzMmdxGIpef4Acg55t6RZLuHKS44yI
         Jyx1ICXi9LWbV29dbUpahebPA9ASMctEzaggAM3XHRHiFLA1gmC0auR040D7VBtZFxxd
         lfVkaWHVoQd9jDPjGym5GCUmc5K+Bn7K1tgW2kYygqZTOLHpPbUjK+HH+flME3UfHUoL
         qqLZMktcdvTe3og5YrbAqcHNwMJbCLP7pt3v8GneM2wX3rwffEgDrhbvN+MYAvR2QDzY
         AjIFNL5gLHCJMHLJkcTYGspuPOxxMGK/tWQLq3lP9KoYC6ZlmOpjUvQIb31A+JTHhC5P
         Qr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200448; x=1792805248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4LioG1TfRbQbbPeFWnF473ae+LrllOtiRpu5PoIzCrE=;
        b=YXX1/m7YcvDiz3n2SeaupwMy1zDZE+txaRSVRf+uvvJnaq9Z9NSDLYYiKYLbjIP7vc
         LRqsg5Dl9TuxbCghkhs9ialMFlxMcA28htK8Ds4fb7jYKj4fWMnE3nvyHzTD+LFFClgw
         Gm/ysxA99cXAuT1nMtVzyEBuMk+r+HsAkdBqUw2z02xvOdqd+4Df9tGqCfO85C4Rrb2a
         PhMBzhp/b4voBDIpQDcbB649ZdLc3MLtq6aalOLMMrUM6NirdQ6Al/1uCJ1utubT2Zy6
         CnkNqba3M74QjiVQ1WHlMUs9D9raq2mRh2irONurq6ANZtCNmDEjFcVk6UkwqymcQh0m
         q2FQ==
X-Gm-Message-State: AFq9FYL6p61DuedGBUIzf8F35u1TkNB4ZmTVAisnS1tUjkVUIe2maZuQ
	q49wPqGMZDvBjX2z5wPi//jWRU5Tna32SFa5FUf9Pk3+8TMCzNUWFuzXI/59FXCa
X-Gm-Gg: AYBFou2Kvb/iMPRGzd68E2pbuRsBMxd8NcYZqwWjz0gc4V05LqTOUPuqA/MuJRhitbr
	qHBtrJPGzPUewmHXTnzONbbrNg7v3QuyMK9sGuDMw4CUoGCPRG+097QIUvjoFFWvdoMZE2hLj7f
	J9FDE7/weOf32x003zCEwCQp7R9hVi7GoboXmPc7XiqXgw8Jvsqt/08OodcWFhhSrNKjQYL270w
	BpRzLk4g2ZGx1khUsQV1t/erAdEtSmNIWquTz8KvhmrHIiPoYYbVY6wUARz7RKsxFzpCAZ1HyuP
	vKskMhN6op45vdLu9HfhdJ2subbPJYbcrhmdVHENVZTlnAhNvyE1tsGrwHvVyWogjM17DRvRNU8
	98pHXLXEQwvbPqu/ZsQ5m7bHSfK7vUjCh4y+g9YMpqHa1+BUnkdF9cMl2sFhkfnxW/ospiujuGh
	bxcr4PGytkEjdWgtwF26Plcaqvy4FQ8cQfX/mKOSAz5d4kEclY3TAU8iIN6eZwq0bnwzfHoa6Us
	7Q0OLx2IEQokuIgV8bEVAnDScyqY46CEGBB/WCHZcoutjchL0PhAftN+B9U1YrI+BuBE28AM6iJ
	pfNyciMgwxGYWXwCdecntcHs9VADv+fmSMmPfKGLh7s=
X-Received: by 2002:a17:90b:4c49:b0:3ab:c674:cad1 with SMTP id 98e67ed59e1d1-3acef51ec78mr1289943a91.50.1792200447558;
        Fri, 16 Oct 2026 18:27:27 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487e509sm6188375a91.9.2026.10.16.18.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:27:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 16/38] bpf: Hold the socket in the sk_storage map iterator
Date: Sat, 17 Oct 2026 01:24:29 +0000
Message-ID: <20261017012451.364800-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
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

