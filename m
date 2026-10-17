Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA7395240
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278625; cv=none; b=J65RX/dg/7AU44xRI1O4eW9KVd+/7RgrP7sYFR7THanxEHlLfOjfM9jhLCr3YYsNYO2s3prigo1lkm3oG53UgS79HEiozBd7NieeD+5aYhI/J+2f0CHJ0No5ZFLtribXS6k62KUJj1rYGsm094FfRMOdntsa6rRHIlVv6/osnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278625; c=relaxed/simple;
	bh=JqcqHdBn5tsuQnc7ZwG/G5kNLWAhhu0aVgdJKW9K5E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kel+PF+J2wzj8Ah+KxB0ODe//YB/yTfNz0myP6WoQjQcqpv0aiSXnA9bKtDP1L2isHItve8NJLoGVdKExsp7eZL3ArOjL++5HoaOTV9H2WmSy7xLddezB7Cv98wRYNiEZFDMEUFo3+RNw6ZpY0sJ5GIWfN/rAfy3fPRtdfi0wnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2C1iCdV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2C1iCdV"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso657428a91.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278623; x=1792883423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CAWL+6VZJHdjnc8VEKgQH0h2WRZ6E/79pEmf7BXtx0k=;
        b=j2C1iCdV56Hi50AQSkmqvkRavD3eTfIwmPkn53n/GG9qWo8LnxJGYmERfv7e/CFvDU
         4F1Jjn8ARV7Upj25COtm4cgXGGvZ6ixYkWufUl+Xvmkm0e49fuAy0E82gf/Yb/E7Y0Gr
         pQ+OjCmyr3gP/XHcH8m5qdiJIeFHsVOc6ypPQEMWPXF5KRa5ScLKfVYy2XimwheD8bEd
         4Kkyi7dALAS8ACFFpKDmdCMqa7gjpjIdWOJHgKk1syZJ6g+uDjcdowWjS2eMo2Fb5Q/D
         yt0ZBohNa6CeW2i3BgVZKJdOrlG8PlSpXZNa/htSVkbvrhQZ9CxRjjZM5GGUXvaFZb5u
         +x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278623; x=1792883423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CAWL+6VZJHdjnc8VEKgQH0h2WRZ6E/79pEmf7BXtx0k=;
        b=p8MOJ0Thm2f5vm7n/m0tif5kNah9FWbau4n/ruG6K5EhUyfe5J5jbgVdflXfLsCp5q
         Pd69Yn+9UrS0Ezd3UzsbUG3B3Hd2pV8B0WaYMSdpN/Sxgo/mUWI+cxgClgsykjsW13aE
         Je0UJlpiwbnG6IqawmKXoKiTWLb0vUhqIklbKMQ5bXySnOTSMEsbvYP8dMuM9EVZbPgt
         2wKDxnUof5mQQDowznRFmFT6lsYk744q0sX1bUXqgVK/111E0Q76uS55OGjOXn5ZlGwY
         dyQz5pP5Vx0T9gZDtHFIBLDoC6c+DZM472Ibtv633acJ6s7ht8WmzlcSINKq9CX4VCEw
         x+sA==
X-Gm-Message-State: AFq9FYLjF8xP+sx+jHJtys2bizpus3S6UP4qnM688n3sJJwn65Z6fogc
	d17v14ljmVXh4cuYFNda1F+P+vfhX/WhGR2WsMgMd7CcayT2UNlyB57AN2wOWg==
X-Gm-Gg: AYBFou2A4emze+dnRbj5E+Cpx7PPFsY7lu840890TX6Tm7e5pWIoZ8z7qajJCkid0kV
	cxDJ3d+IkwP3rFSi/Xh/RFdAShUwkascSB2j4rPJnniYQiPnJ0KuVkHqT5b1bxb/K46wRY40Qnq
	jJkVYTYl24CPqrDqI6A082eygz7Wj60ZZHW0ZnweqgLd5SRC3KsLiWvLzuiM3Bd6+Bebw3mtLUL
	T8lbHZWeYAursoB8ZzcfQTC7D/kYPUe3PjfYOI7CENrE6gQ3+H928+YrlinfaHm7wp5cwDHAaDQ
	Oj4paH36pkNLUzb7JYuZ/PvS102T2r/OGiPD/0uwZMYn3L3E4YxpAyoysanXWBijyqScIWT5giV
	MlOaLnzKlo/STtagpdAen9QXlSHuxLlS+02hQjYBd1PfByyKbPS8OiYgyOe2ciowPYUmx2Lc4Ir
	HH+89b7Jr5Ql+PeS6x6xZFAIOWfUPsoiob0ULADV2iGg0MJaZjzhSs6tSQvAvKsZhUbUup7sHV3
	pR49anwtuKIXDbZrk69Uc2sbsQWNqrMXa2R2ggAO9SqNHWRYTwjWPLd+Zq5UNug1+xUTe5LyNaA
	wYX+sb51FSkK1PHecxfo8kCnZfL7JkvgHv1IZxGTDwA=
X-Received: by 2002:a17:90b:57ec:b0:3ac:6fcf:81a2 with SMTP id 98e67ed59e1d1-3acef5c49bbmr3233314a91.57.1792278623350;
        Sat, 17 Oct 2026 16:10:23 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc46ee274sm9452278a91.4.2026.10.17.16.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 05/16] bpf: Keep the symbols of a program until it has ended
Date: Sat, 17 Oct 2026 23:09:39 +0000
Message-ID: <20261017230950.802052-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

When the last reference to a program goes, __bpf_prog_put_noref() takes
its symbols out of the kallsyms tree and frees its line info at once, and
waits for the grace periods only with the rest.  But the program may still
be running: the link or the array it was called from is gone, the call is
not over.

search_bpf_extables() finds the exception table of a program by its
symbol.  A load that faults, and that the table is there to fix up, is
fatal from then on:

  Oops: general protection fault, probably for non-canonical address
  0xdead0000000006f8: 0000 [#1] SMP NOPTI
  RIP: 0010:0xffffffffc06008f6

It takes a program that is detached and closed on one CPU while it runs on
another.  Unwinders and bpf_prog_find_from_stack() do not know the program
any more either, and the stack dump of a BPF stream reads the freed line
info.

Free the line info behind the grace periods the program needs, as it is
done with the BTF that its text comes from.  Remove the symbols in
bpf_prog_free_deferred(), which runs behind them as well.  The symbols are
looked up under rcu_read_lock(), so the images and the program itself are
freed one more grace period later.  All that the program refers to is
released when it was before.

Fixes: 3dec541b2e63 ("bpf: Add support for BTF pointers to x86 JIT")
Fixes: d7c431cafcb4 ("bpf: Add dump_stack() analogue to print to BPF stderr")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h  |  1 +
 kernel/bpf/core.c    | 50 +++++++++++++++++++++++++++++++-------------
 kernel/bpf/syscall.c |  5 ++---
 3 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a10af47978a4..feb7de6483e3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1971,6 +1971,7 @@ struct bpf_prog_aux {
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
+		struct rcu_work rwork;
 	};
 	struct bpf_stream *stream[2];
 	struct mutex st_ops_assoc_mutex;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e1216927373a..6e32db9777c2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3085,12 +3085,40 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 	kfree(aux->used_btfs);
 }
 
-static void bpf_prog_free_deferred(struct work_struct *work)
+static void bpf_prog_free_images(struct work_struct *work)
 {
 	struct bpf_prog_aux *aux;
 	int i;
 
+	aux = container_of(to_rcu_work(work), struct bpf_prog_aux, rwork);
+	for (i = 0; i < aux->real_func_cnt; i++) {
+		/* We can just unlink the subprog poke descriptor table as
+		 * it was originally linked to the main program and is also
+		 * released along with it.
+		 */
+		aux->func[i]->aux->poke_tab = NULL;
+		bpf_jit_free(aux->func[i]);
+	}
+	if (aux->real_func_cnt) {
+		kfree(aux->func);
+		bpf_prog_unlock_free(aux->prog);
+	} else {
+		bpf_jit_free(aux->prog);
+	}
+}
+
+static void bpf_prog_free_deferred(struct work_struct *work)
+{
+	struct bpf_prog_aux *aux;
+	bool ksyms;
+
 	aux = container_of(work, struct bpf_prog_aux, work);
+	/*
+	 * A prog that still runs when its last reference goes needs its symbols,
+	 * by which its exception table is found.  It has ended by now.
+	 */
+	ksyms = aux->real_func_cnt || !list_empty(&aux->ksym.lnode);
+	bpf_prog_kallsyms_del_all(aux->prog);
 #ifdef CONFIG_BPF_SYSCALL
 	bpf_free_kfunc_btf_tab(aux->kfunc_btf_tab);
 #endif
@@ -3109,20 +3137,12 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 #endif
 	if (aux->dst_trampoline)
 		bpf_trampoline_put(aux->dst_trampoline);
-	for (i = 0; i < aux->real_func_cnt; i++) {
-		/* We can just unlink the subprog poke descriptor table as
-		 * it was originally linked to the main program and is also
-		 * released along with it.
-		 */
-		aux->func[i]->aux->poke_tab = NULL;
-		bpf_jit_free(aux->func[i]);
-	}
-	if (aux->real_func_cnt) {
-		kfree(aux->func);
-		bpf_prog_unlock_free(aux->prog);
-	} else {
-		bpf_jit_free(aux->prog);
-	}
+	/* The symbols are looked up under rcu_read_lock() */
+	INIT_RCU_WORK(&aux->rwork, bpf_prog_free_images);
+	if (ksyms)
+		queue_rcu_work(system_percpu_wq, &aux->rwork);
+	else
+		bpf_prog_free_images(&aux->rwork.work);
 }
 
 void bpf_prog_free(struct bpf_prog *fp)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d026ab779ce8..849bc9136299 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2461,6 +2461,8 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
 
 	btf_put(aux->btf);
+	kvfree(aux->jited_linfo);
+	kvfree(aux->linfo);
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
 	free_uid(aux->user);
@@ -2485,10 +2487,7 @@ static void __bpf_prog_put_rcu_tasks(struct rcu_head *rcu)
 
 static void __bpf_prog_put_noref(struct bpf_prog *prog, bool deferred)
 {
-	bpf_prog_kallsyms_del_all(prog);
 	module_put(prog->aux->mod);
-	kvfree(prog->aux->jited_linfo);
-	kvfree(prog->aux->linfo);
 	kfree(prog->aux->kfunc_tab);
 	kfree(prog->aux->ctx_arg_info);
 	if (prog->aux->attach_btf)
-- 
2.55.0

