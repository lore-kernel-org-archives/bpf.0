Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5205303A04
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200749; cv=none; b=CPH7NXb4CCKQEG/XwrZwAAOixB1/zxKnGOfPZLbImODG7iU9ZYGMgiKyoimLow6PAqypkeywOdq6shS8c4wpSKSwq9SIUZH3XtQIB/TNcSqsmfujgRj9g0T+ZCp9VqsAZ500jkvLMBNrJV4PpknVxP3iT5ukXmLCs1meNbLpHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200749; c=relaxed/simple;
	bh=CbWiyrsUDJ2cbbxFhp1RZzeSZXG5JlBksA4uu/R+Ed4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsg3sDX8XJieOqZlEisLFukwWEy1VyfSOEdx7ivLDAFe5s8pes0bhzJymWBytYOmhjui6GjAG6lfO7QkTVZzoYqjpz3u1GnhgcoX6suZjD584XCiusNj6oPBJy2IBSRbtU5rr0S/26YhcRHws3omxxqLCI4JaIS+J9Yl6+6OFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaocKlCH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaocKlCH"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3a706146559so421303a91.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200748; x=1792805548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eA2NZvNprPsSN5L4VbDShVJlzlwVtYc7SeTdmwQtIBw=;
        b=jaocKlCHSKLJv15KFgBELGbHqL8tnRwDbHlFMLLVaCiYiHD6o1mXty0kd8WgAwEMv8
         Qz4QhXzGONMFVhYK8WnIpyetgdTac+byKRdjZu2xz+VxTi3Ron/mQFL2ojsTQXGS3kgl
         Gpd3oS+r8UNSG5Ve1d4k8ztdCRWVlfsTfMO+1iV4ZHBQI4GD+viUf8Mw82XQfxjGRwiM
         G/3yVfKEOv+gMb4UmqpK4rjdZ/J9lrqmUHcp88QvCbLcALVfZbA777hndCpdyNEnnZ7c
         K4tIF5TzbgfdhadLaOAf8n+tGy329Zj8vUhxG6VS1hO0RarivGfhr9hk1de9Dl0NOZFw
         uM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200748; x=1792805548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eA2NZvNprPsSN5L4VbDShVJlzlwVtYc7SeTdmwQtIBw=;
        b=ZqI2yR5vhnq2R2RxbVC+LisQkPutlKRyLf9vpZVQwshYJ238MUfCoTfw4Ju2VxZUGX
         mjFhOlNlLgb+C9mEOux0zFPOme6I9bF7HHVj7piUyvJXlu8BZlN5A38jHafAhCgsDgld
         EDMZrYHNbIsyg6UeBPWLq0wR5ohMyQ1V2zQHmBYw2GS5eIozlnQrHM2EOlQb1n4w7J1T
         MSf0gQMb27aGzsZxGDfM+3Rw1GHI6egGzqZ3p2wlC8cc/2lVf2SQKvbx8WDCiOHgZb+B
         sbmDGbEREXBK82jvmMRv3tNlF7XTCNtST/A+ckdmTt0rqWbWCsSCQ4iW5a4pnEng1VBh
         qnmA==
X-Gm-Message-State: AFq9FYKFA8WdoWlSdASCLq1Lgzx9hQz4YbCKGfoDT3N61oQ7Oa5W0R3B
	EIsT6x1O4dQSdNhHgBMZ06zhObLSxw8PcS16EWm7LwRcuVJvNzTHsA8Vn2AwLtVK
X-Gm-Gg: AYBFou3uBr2RMRfXoqZjnjvZ+R4IcSb8T8Q6iwb5lYDWJRK4xGO13wdOWSeQBxI3oC3
	djmkRnKOcua8fSxioti3JMYYsRtwZOvxTLo9rQ9ydzltm5Ix7i/+vSgX62iMmn0YWHZnzPjHftf
	2dWaMt4eq5iBFNk9Z8P1VCwiKhr87SgfMzaIGZ1khLanCwrS5Bt6IsUCbs7z57p+8CM19cKWJEd
	W3x4RruFogYAOA4eXtTvufDgR6YzBs5NhTeSG7/z8m9knmo1+N8EeObe/8ZQvM8uRMSr+/rlg/A
	wGpRabvNflfoZxdkQMwzvvMl7/tQyPfwzYLdbGMJr8Qjmz4CiD0E6e9be5n6zlokdAFmn6z3D9W
	yltVi+JchlAoUWw6xMF6amkZ+ZhgloygOXrfT9FLnHNfclRutzII6D/8wq9rMsRZ3sVO0dfOkmr
	Cp3QldPwm6P3Brgtkx4zIhsd5QRYQ9nEKweEauU+sEVQuOhVzfUggDhhNJuiAmzwE8182QAusIV
	WX9qo+k+VntcBNkqSB3lp5Co/0At0+Ox+zYThMTdMZLN8Cdithxu1PuHC2ropm4PlfwhiD3tvlW
	JjpJ0votIOG4eENps9lOVhmGDn4+DaEoEKOPEMWld0c=
X-Received: by 2002:a17:90b:3148:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-3acef60f597mr1392108a91.61.1792200747853;
        Fri, 16 Oct 2026 18:32:27 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7548sm11370509a91.1.2026.10.16.18.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:32:27 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 30/38] bpf: Keep the symbols of a program until it has ended
Date: Sat, 17 Oct 2026 01:24:43 +0000
Message-ID: <20261017012451.364800-22-alexei.starovoitov@gmail.com>
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
index ad4ef937e112..c1d92fd10ef1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1963,6 +1963,7 @@ struct bpf_prog_aux {
 	union {
 		struct work_struct work;
 		struct rcu_head	rcu;
+		struct rcu_work rwork;
 	};
 	struct bpf_stream *stream[2];
 	struct mutex st_ops_assoc_mutex;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e98c79e8009c..956555fc5e9f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3087,12 +3087,40 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
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
@@ -3111,20 +3139,12 @@ static void bpf_prog_free_deferred(struct work_struct *work)
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
index 3f215f2509b2..c8bd92c95ac0 100644
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

