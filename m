Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724483;
	b=jt1uAoeuI6mya4dw7Dl2zQd1MXMLKMhLZa4QQRWlUMHPqQ9EGoIGr5l8MUiCZjjfXNjS
	 T4JzQHOfzJn21FrYQsGOXISRIJR61vX3qbRu8ezko0opms1pHLQ5qr7qNR05dbK2kccts
	 XZGDreizUAXGyRz+aXJXHH0jtiF5gjsnRF2LBaGZ+ZlfvdrnvPjvuGfqw1aUvb5iBSpW6
	 GZDOMWKd53VSLHoJTsMVp+ktMRc9Zzg8S2pfrX/URf4weV5ojfACQf+9ufaWJTx9s6Dui
	 AxLKbLnU8ygDnco1NKLGp4Ljzm62X9uYAOQdPJBeS0KKD6jENqPIcSNSc2N1BCZ7fXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=Z66jJjlHLe1RRcDLXYugbClF1c/XdOutVGg1s/XEUxo=;
	b=O7zzO7EDfcRUMAI68cx0YtyQVFoBK3oNkM5yTfcnz4rC8O24fIY5QhyzBhPaPuzWtngl
	 a1MJhMXSQjnBKzu3jWWsQLX1oXVgt1lrYwoV6yAjhtEPKmz3zfKJbKxhE0xfODR0k3BBW
	 Ww/wSxmWP7Y0+yucb98qjhV9+V/wCWd6EQzPZYt+PR8uKsTQ9R96A2W05Ajb1tF6e560p
	 TQcYYX1pBSwIY9Wx2zbhOEapr5tsFboEnFs4rm1zzVQyIWxpsqkYTAh1kpUONsPqwvJ1n
	 IusWCw1B+QlF5UmSmJxeCxL3h7q6p6xwvNPFw8XvyLEGPUC/C/LETDcmOuQGEG5V0Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AUgNyTcw;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA54606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 16:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA54606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AUgNyTcw
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso2670257a91.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793724483; x=1794329283; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z66jJjlHLe1RRcDLXYugbClF1c/XdOutVGg1s/XEUxo=;
        b=AUgNyTcwXW5IN1eDDI5qx5MqUDkUMwXCKmBIeY0vMys+XMxTLiOcRFK5GB8hNDt+v/
         mk/NTjJXXTqBxgtO9mRln9/qI4hw/BNQvxnd7l0KYtZCG6qAtsamC07QNVJfRblu95rJ
         ZZcAkSjO3glThGjqxqOae/Pniz7cGkTmIVyIf+wQpMlJJSSxPB1Z3NqqircVzeVEWYrU
         0SWO6TTbBQBM1UwRUSKkC1s6NT/e9aLeeME6O8bbB8mdkenTiSEA+d78I7A7dyNr7fzA
         JDHKm62Gvcqhvb+cCmOvR3846AUCea2wCGatqEh5p2QRzaOa9mRFtAhpiON0pZOkfi67
         s2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793724483; x=1794329283;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z66jJjlHLe1RRcDLXYugbClF1c/XdOutVGg1s/XEUxo=;
        b=TSynlHgpr0bFFoF6m0V7CrGpj9GoM7q14Ww61O4mJjbPDMg7Q9r0MOqTpSEiGjJ4Om
         GyguURG9Aj04uWT0xU4fedhd+ts2AHUDPKlacKaDRNvd2fbxRmVi9NI8LqHseYh4PHvj
         4Cv7OJsqLZZc7Ej/MQltriZADCypQjv4ekH9ylLWtjFiQ22jG5WQKpB9qVYTJms1VGTV
         bWDmRcpTfQmQlwxVEa+pHsmtZQ/Ke0enbIqC78v9PXeN65XWGWCzb2hTg3Bn6xW2ze7s
         a0Ne4rz6w8g1GoX/tn2BTEo6pk6crJRHTG3u+mT9M1sAPzC0e9Hi6Vuuilrwb1paGyWQ
         8y3g==
X-Forwarded-Encrypted: i=1; AKwUvBzRzyPQd9Zc6ADkmYxNcDSOH2tjMyfuCbFHN9dBahPIYINNzVvAddEf0x530ChhfVGkhYo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hQebs4gjQR5pJhqrZ53+ic4g4WCJXlVsTe3l516+oDasRJ7YO
	YKEvCY9Klke4Jj8fZa2dUwwaF5S9qCmJg/+odVZF5+X69GDNFpiGCuiIhIytbA==
X-Gm-Gg: AYBFou2qYlJIoPs+qjJ6JAZaImv/E3y+4f+5CRO7ZpNzmB1cY14e24JQLX9O28QFFsG
	I9E2DMJ624Bt6Ol+SjyPwM77AdzIjVkYAFs+D2TSaAOmpCUf9mlNkUt+fMgBT9SKrKZeOcCjsae
	Dgkfji3Wf/a/CRRN44yFmIClXad8vTtxeUwVNJDSxKOpkIkPKFpUzpNZvUa+G6r7FgNTJ9TZj4M
	LVu164aQST51Ck3y5ImmYsjAOjt5FkSJXP72yhXqNOJ1mBdVIN0J5sa/KtLLdLrFUvAGkJ9xfWG
	CbSgbOHRSaXUQE5we4to4LG9Hz0RXLpfED7wvD11dFkG1671pNyGscz68um2oMD5c1LKzQr+I8l
	N7BcE8EERzTSq25pGFBk9i+rNOgSWRJRt9skDX43aWB8ySWfRsumHTIsNsrL1gWFz3Jo68Wnnxv
	XjUL4OsJWHrvGB7w4hbG7peavZqbBGZ5RR8duFrQs5KAvLJ1pOrMeNYPsNm1GoCRjgDhOLlBMLH
	MV6uE5gbYPdd6zWqrlJQZdpCwGyA1OstrqbnYnAXSwzp6eMm2b15ZCZge5yu9x/flgPE7Xlr8Fs
	lZjXPXfwe7YwV3MmJZs5dSuysjptnMs2TnhQWqy10dS4/ae339ezL6y6x/tQVcM9IKLwYIFlRD+
	qYnSCAz6OOsodS++Nthh5W+TbMkMf0d9Yeg==
X-Received: by 2002:a17:90b:2248:b0:3ad:ce34:f63c with SMTP id 98e67ed59e1d1-3ae8974abd8mr10849510a91.30.1793724482638;
        Tue, 03 Nov 2026 08:48:02 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9928c4sm5287816a91.15.2026.11.03.08.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 08:48:01 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 16:47:59 +0000
Message-Id: <DMLQ9E8WRFZC.20C48J5Q1TMSL@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Don't allocate and free prog pack memory
 with pack_mutex held
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
In-Reply-To: <20261103142856.463063-2-puranjay@kernel.org>
References: <20261103142856.463063-1-puranjay@kernel.org> <20261103142856.463063-2-puranjay@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 06:28 AM Puranjay Mohan <puranjay@kernel.org> wrote:
> Progs are freed from system_percpu_wq too, and bpf_prog_free_deferred()
> sleeps on pack_mutex. When enough progs are freed at once, these work
> items take all active slots of the pool that purge_work was queued to.
> purge_work never runs and everything waits for pack_mutex:

Thanks for taking over.

Turned out Emil is fixing the same issue I was seeing:
https://lore.kernel.org/bpf/20261102073439.6822-1-emil@etsalapatis.com/

Thousands of work items that sleep don't belong in system_percpu_wq.
commit 117932eea99b fixed it for cgroup/bpf.

On Emil's patch I proposed to move frees into their own wq
with max_active = 1.

                                         this patch    own wq
  -------------------------------------  ------------  ----------
  work items per cpu that sleep on       up to 1024    1
  pack_mutex
  same deadlock on vmap_purge_lock       still there   gone
  N tasks find no room in the packs      N new packs   1 new pack
  pack_mutex held over execmem calls     no            yes

Row 1 also bounds the time that a prog load waits for pack_mutex.

Row 2: the s390 JIT and the interpreter call vfree() of
a VM_FLUSH_RESET_PERMS area for every prog.
vm_reset_perms() calls _vm_unmap_aliases(), so these work items sleep
on vmap_purge_lock. Its owner waits for purge_work in the same wq.

Row 3: see below.

Row 4 is fine. purge_work gets its slot, so the owner of pack_mutex
makes progress.

Then no need for the retry in bpf_prog_pack_alloc().

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fdbf638..6ce2e31 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -70,6 +70,7 @@ extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
 extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
 extern bool bpf_global_ma_set;
+extern struct workqueue_struct *bpf_free_wq;

 typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 831f73f..e83edea 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3198,7 +3198,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	/* The symbols are looked up under rcu_read_lock() */
 	INIT_RCU_WORK(&aux->rwork, bpf_prog_free_images);
 	if (ksyms)
-		queue_rcu_work(system_percpu_wq, &aux->rwork);
+		queue_rcu_work(bpf_free_wq, &aux->rwork);
 	else
 		bpf_prog_free_images(&aux->rwork.work);
 }
@@ -3211,9 +3211,26 @@ void bpf_prog_free(struct bpf_prog *fp)
 		bpf_prog_put(aux->dst_prog);
 	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
-	schedule_work(&aux->work);
+	queue_work(bpf_free_wq, &aux->work);
 }

+/*
+ * Many progs and trampolines can be freed at once and their work items sleep
+ * on pack_mutex. Its owner can wait for a work item of system_percpu_wq.
+ * Use a separate workqueue, so that they don't fill up max_active of
+ * system_percpu_wq.
+ */
+struct workqueue_struct *bpf_free_wq;
+
+static int __init bpf_free_wq_init(void)
+{
+	bpf_free_wq = alloc_workqueue("bpf_free", WQ_PERCPU, 1);
+	if (!bpf_free_wq)
+		panic("Failed to alloc workqueue for bpf free.\n");
+	return 0;
+}
+pure_initcall(bpf_free_wq_init);
+
 /* RNG for unprivileged user space with separated state from prandom_u32(). */
 static DEFINE_PER_CPU(struct rnd_state, bpf_user_rnd_state);

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 21d4608..a34e8a2 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -584,7 +584,7 @@ static void __bpf_tramp_image_put_rcu(struct rcu_head *rcu)

 	im = container_of(rcu, struct bpf_tramp_image, rcu);
 	INIT_WORK(&im->work, __bpf_tramp_image_put_deferred);
-	schedule_work(&im->work);
+	queue_work(bpf_free_wq, &im->work);
 }

 /* callback, fexit step 2. Called after percpu_ref_kill confirms. */

> +	mutex_unlock(&pack_mutex);
> +	new_pack = alloc_new_pack(bpf_fill_ill_insns);
> +	if (!new_pack)
> +		return NULL;
> +
> +	mutex_lock(&pack_mutex);
> +	goto again;

Every task that finds no room before task 1 adds its pack allocates
one more:

  task 1                     task 2 ... task N
  no room, unlock
  alloc_new_pack()           no room, unlock
                             alloc_new_pack()
  lock, list_add_tail()
                             lock, room in the pack of task 1
                             unlock, free the new pack

A pack is 2 Mbytes * num_possible_nodes(). Nobody is charged for it.
N is the number of tasks, not cpus, since alloc_new_pack() sleeps.
If we go with your approach the memory needs to be bound somehow.

pw-bot: cr
