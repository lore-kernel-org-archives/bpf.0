Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785311;
	b=pKcBL2DVxCaiInlGKInTkI4iIh6ezlK03DhxYJ15noQvofJfwTqAazeMgLNweakDT/zj
	 dfui5Q5iHJ9DGL4sjV8VD4IpBqDQGk3HUNH5gNl2fGehUbUl/XDlMbvIaYnYaynUknrZF
	 rvTDobfayA0Ba/NVAL/0C2GowV6vMMbhq9fWjk1FNo+iJMUQK5VGjPpctWYwQP7HaqKqr
	 EpVGQ/Y7ZM5x0uM4AmYfY15zTPn7NYLlwo9U0i3nd7JXSw2SyobYIFbys7xUubaJa1vvH
	 UJGc/jAkbDU6mVNWqMUdHNSF1NsSIpRflpiZf6TD/nUJkxETN28EaOrHHM6Dz7d9UFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=UBeykY1+H/vPJmkPV2pLCmI2Bs+Pj25kP6+DXgtUhEg=;
	b=XD/ckvWXxNzn5fFIC00htvJ0f3jqSxUBTOt/C8hCh8zQrq4qPZSVmgyfmTxRZM+lm6eq
	 yuJAjICY4p3Q/o/Ik/zIECuVMPdJkP+eN84xFJ7AegvYf+6NVIVrAPGSGklxjkkWHFDhu
	 UIZ87ogMzfAA/sdNSqt25LpPo81dTJKR+Qlv74/PPny9gImnhpNW6d44lBp0iY7RCfhRD
	 03CCu/ELqLwWSF+reUNgCbfpQK/XAqXsfj/rpvVqFwVLvcgCb/gnI6ay9FSW3f2T+VUpz
	 8M0MUXPreNBBNWu93sZTjT7ML7M66zTHfUEay1KPDUdHcIkJPyjmw9LKIPAy/aoUiCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R4X8Y8HY;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0CB606A330
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 23:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B0CB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R4X8Y8HY
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9ae391a05so15808015ad.1
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 15:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794785310; x=1795390110; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UBeykY1+H/vPJmkPV2pLCmI2Bs+Pj25kP6+DXgtUhEg=;
        b=R4X8Y8HY8JvXK9sdMGMllaKudzpsfMfDLWS/qg6c0goxa2kUGuYQv/8mPEQn7MTQwN
         9RpdlbNq0uFqewcYwl+PkyM/jUdR6c5AkuMetaUc3nP6yyslFlaUUprBo0FDyhiCpcx1
         0nqgdtFlgbGe4nQG7wQaHZtPTeB6PxsPL4ESMRO1CCXaBMoVQKRwYCZ/4nuE0Wal6v+N
         8530jNemiaGvpVK93xW7ndcQ9X3tvuspHUk6ZlHK/ECwo1u0FgJ8qU6+DVzh6IEaCW1E
         z1cI3F9z5KnNORNVANdIaxAI9mLinedBuq5zYc/IKacgWB6knVUmOcAeyTaNsxctGQgz
         6VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794785310; x=1795390110;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UBeykY1+H/vPJmkPV2pLCmI2Bs+Pj25kP6+DXgtUhEg=;
        b=sWUDrs0zsfK9Dd7LNldhTKgwdvUzjyz/x6DS4IJOPyBLkv2+J2w0CWvJHt4WnLnXJd
         7oI7V/AdRMMgUq5HOoovtBqHWLXPuQ8MQUE2pe3Jj85TzEMK8YbOFz0bnnJpuE0WgzOZ
         WFsIJoYLQOe480wSj4w5YB43WFf1kDYWApyIKcOCDqW2NkSdSwYTjQ2YHY89v06GXZ7y
         NdwxjyIL3Vuji6TxMH6mz800LOJKWWoWPu2ZC1S2uy2ODMA8AyMrGd63cRmDqIkMw4dD
         KynH8pBL64wSKUVl7xxXw+I/4G8TjUHYi1Vk5lYQ46acDZ7KCxcM0yM9qN2uM+UkUhtZ
         Ry8g==
X-Forwarded-Encrypted: i=1; AL+hErHpy7pDm5McJIphqIhjpB4guEnx1XnCWCdMDfb7e0SEU4ytSe+QV+wmILHwbcZVUg/Dnq0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8W/hGHqf3G9aK5da85fjIROnGIyBLN5SZaHFHZ7uNTZOCtXMA8
	ilc/P71Pzi7ZQIrq8aYNMT74nDpEO15mcxUK+uSCig90L3q65WWbRk3A
X-Gm-Gg: AYBFou3tzsi+t1TbMdmdgaxvr+Mvkb9B4DDjvK5lMtpoKQJJ42ykzUQwKqLWqzxXwXD
	LLfzvYIeKWXc32IY6zJm2Rd7PFPOSlIS+UZ0n3RdB1uzyXYW2ti4LPJd2rOOvhjFEQEozClVrM0
	il/1M+fgEa0b7nHKCJeY3RNqDrihUpdvS/kfxj8fVrJeJ+rBiBWIFDn+tzUt7WsNZ8Wm+jBG7s2
	ficvoy6BZ21DWUFzBknFgRKZLo/3X6CY8AcLp/kks0Cjw1eFn1IOJf/8uIMEY+1OdbN3JPWyXuB
	KZbog7lDweQg2QabDdfqxw53pKY+1ex7tY+8p57biUVNLb8gOpWkEFiJTwO7LhwHb8wuBHALAyi
	gntOk6k8O3C2srGzwQbwRrLa3/paZgzGN/+1ft688afStfvlNx2DK2opJjNS97ljL5nrL8I734F
	r8zKy7U8WR5FwBI3vc4KBQzx5ZbYtcNZWnEVwKkI1MuTWwu7RU/rC/ArVsuZ68Nw0L/7HGAvSCJ
	96SAPwW7CTCEC/+eSyFRX8PPntbydYv6sm21/gOPDCNXwPFAtQ1p6XN9PQTBpEwk29wriEHFI2L
	UG1F2I9hddw7O8Mi/kV7w5j7gUFnxEotdjhPOn2DapCnbwj49pAMnB2+S2vQnXPoS3pAbUOdrTe
	3XWIddBDOm8u5tNQdz3anjAWpks8dlklyeQ==
X-Received: by 2002:a17:903:2a87:b0:2e9:199c:f800 with SMTP id d9443c01a7336-2edf2212d5cmr82331265ad.37.1794785310143;
        Sun, 15 Nov 2026 15:28:30 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f75b467sm30194865ad.20.2026.11.15.15.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 15:28:29 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 15 Nov 2026 23:28:28 +0000
Message-Id: <DMW6AKE8C8K5.H33UQQDOD34J@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Eric Dumazet" <edumazet@kernel.org>, "David S
 . Miller" <davem@davemloft.net>, "Andrew Lunn" <andrew+netdev@lunn.ch>
Subject: Re: [PATCH bpf-next v2] bpf, mprog: Defer RCU synchronization until
 peer reuse
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qi Wu" <shijing.wuqi@linux.alibaba.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <20261115144556.41927-1-shijing.wuqi@linux.alibaba.com>
References: <20261115144556.41927-1-shijing.wuqi@linux.alibaba.com>
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

On Sun, Nov 15, 2026 at 06:45 AM Qi Wu <shijing.wuqi@linux.alibaba.com> wrote:
> An attach within a grace period of the previous change still waits
> (e.g. a tight loop); spaced-out attaches do not. Detach retains its
> post-swap synchronization; peer reuse can add a conditional wait
> before a detach. Functional checks pass and a 300-cycle attach/detach

The extra wait before a detach was my suggestion, sorry.
I looked at the next attach only.

A detach that follows a detach or a replace now waits twice.
The first detach waits in tcx_entry_sync(). The old entry has no users
after that. Then bpf_mprog_commit() takes a new state, and the next
bpf_mprog_peer() waits for it. Nothing needs that wait.
A replace doesn't swap, but it takes a new state too.
To close N links of one hook takes 2N-1 grace periods under RTNL.
Today it takes N.

Grace periods that the second change waits for, when it comes within
a grace period of the first one:

  first     second    today   v2   diff below
  -------   -------   -----   --   ----------
  attach    attach      1     1        1
  detach    attach      1     1        0
  replace   attach      1     1        0
  attach    detach      1     2        2
  detach    detach      1     2        1
  replace   detach      1     2        1

In the attach/detach row the attach saves one wait.
The sum is the same as today.

Pls add "detach after detach" to the table of numbers.

> @@ -243,6 +251,7 @@ static inline void bpf_mprog_commit(struct bpf_mprog_entry *entry)
>  	bpf_mprog_revision_new(entry);
> +	entry->parent->rcu_state = start_poll_synchronize_rcu();

Only the swap in attach needs the state.
Lets take it there, in place of the sync that goes away.
Detach and replace leave the old state alone. bpf_mprog_peer() waited
for it already, so the next change doesn't wait.
The build is clean on x86-64. I did not boot it:

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 82e608e..75a1a56 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -772,7 +772,7 @@ int netkit_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!ret) {
 		if (entry != entry_new) {
 			netkit_entry_update(dev, entry_new);
-			netkit_entry_sync();
+			bpf_mprog_defer_sync(entry);
 		}
 		bpf_mprog_commit(entry);
 	}
@@ -854,7 +854,7 @@ static int netkit_link_prog_attach(struct bpf_link *link, u32 flags,
 	if (!ret) {
 		if (entry != entry_new) {
 			netkit_entry_update(dev, entry_new);
-			netkit_entry_sync();
+			bpf_mprog_defer_sync(entry);
 		}
 		bpf_mprog_commit(entry);
 	}
diff --git a/include/linux/bpf_mprog.h b/include/linux/bpf_mprog.h
index 0b9f4ca..2e180a4 100644
--- a/include/linux/bpf_mprog.h
+++ b/include/linux/bpf_mprog.h
@@ -30,8 +30,8 @@
  *   if (!ret) {
  *       if (entry != entry_new) {
  *           // swap @entry to @entry_new at attach location
- *           // ensure there are no inflight users of @entry:
- *           synchronize_rcu();
+ *           // nothing is released, no need to wait for users of @entry:
+ *           bpf_mprog_defer_sync(entry);
  *       }
  *       bpf_mprog_commit(entry);
  *   } else {
@@ -104,9 +104,13 @@
  *
  * Fast path accesses the active bpf_mprog_entry within RCU critical section
  * (in case of tcx it runs in NAPI which provides RCU protection there,
- * other users might need explicit rcu_read_lock()). The bpf_mprog_commit()
- * assumes that for the old bpf_mprog_entry there are no inflight users
- * anymore.
+ * other users might need explicit rcu_read_lock()). In the detach case the
+ * bpf_mprog_commit() assumes that for the old bpf_mprog_entry there are no
+ * inflight users anymore. In the attach case nothing is released, and the
+ * old bpf_mprog_entry only has to stay intact until its users are gone:
+ * bpf_mprog_defer_sync() records the RCU state after the swap, and
+ * bpf_mprog_peer() waits for it before the old bpf_mprog_entry is written
+ * again.
  *
  * The READ_ONCE()/WRITE_ONCE() pairing for bpf_mprog_fp's prog access is for
  * the replacement case where we don't swap the bpf_mprog_entry.
@@ -147,6 +151,7 @@ struct bpf_mprog_bundle {
 	struct bpf_mprog_cp cp_items[BPF_MPROG_MAX];
 	struct bpf_prog *ref;
 	atomic64_t revision;
+	unsigned long rcu_state;
 	u32 count;
 };

@@ -158,12 +163,23 @@ struct bpf_tuple {
 static inline struct bpf_mprog_entry *
 bpf_mprog_peer(const struct bpf_mprog_entry *entry)
 {
+	/*
+	 * The peer was active until the last swap and the caller is going
+	 * to overwrite it, therefore ensure that there are no inflight
+	 * users on it anymore. Paired with bpf_mprog_defer_sync().
+	 */
+	cond_synchronize_rcu(entry->parent->rcu_state);
 	if (entry == &entry->parent->a)
 		return &entry->parent->b;
 	else
 		return &entry->parent->a;
 }

+static inline void bpf_mprog_defer_sync(struct bpf_mprog_entry *entry)
+{
+	entry->parent->rcu_state = start_poll_synchronize_rcu();
+}
+
 static inline void bpf_mprog_bundle_init(struct bpf_mprog_bundle *bundle)
 {
 	BUILD_BUG_ON(sizeof(bundle->a.fp_items[0]) > sizeof(u64));
@@ -172,6 +188,7 @@ static inline void bpf_mprog_bundle_init(struct bpf_mprog_bundle *bundle)

 	memset(bundle, 0, sizeof(*bundle));
 	atomic64_set(&bundle->revision, 1);
+	bundle->rcu_state = get_completed_synchronize_rcu();
 	bundle->a.parent = bundle;
 	bundle->b.parent = bundle;
 }
diff --git a/kernel/bpf/tcx.c b/kernel/bpf/tcx.c
index 02db011..12a1620 100644
--- a/kernel/bpf/tcx.c
+++ b/kernel/bpf/tcx.c
@@ -42,7 +42,7 @@ int tcx_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
+			bpf_mprog_defer_sync(entry);
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);
@@ -156,7 +156,7 @@ static int tcx_link_prog_attach(struct bpf_link *link, u32 flags, u32 id_or_fd,
 	if (!ret) {
 		if (entry != entry_new) {
 			tcx_entry_update(dev, entry_new, ingress);
-			tcx_entry_sync();
+			bpf_mprog_defer_sync(entry);
 			tcx_skeys_inc(ingress);
 		}
 		bpf_mprog_commit(entry);

pw-bot: cr
