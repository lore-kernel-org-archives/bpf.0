Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5BF3FB7E7;
	Wed,  5 Aug 2026 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969844; cv=none; b=iw6pbd57PcfYv0S2dfHRGQOUimk7Swf5pxdEE+9PtpJxhB/Ucf/LPkP7Vc9+ZJuPskXQmN/qpXetoXjPfuoyoQmj1CFORvZ1B1VGE4N392/lH54TJEuk+HZvnGFmXVzcsB5uR+W2KdSXVRtHg/+r8woX0Y8QseNb6WvZIF43p3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969844; c=relaxed/simple;
	bh=XUz+4hcoQweAZNbF3WW/NSHXXddh7fWVTahBj/PryEQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=aYmnELLCQXlmAn9ycDtObw3cvUrdQOQQ5Wp3cwO//aDw4BY/NB0Z3PMnK85yOPKF44tIn28hIRXiVIdLqo2yEoozanEy68IUv5vvmg+TDwovScPXckTXJCnvDWHnpGpWZ9CHI1+SM6SbSaAolgXWVJJW975VycLlUL2WUP1Yqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TS3Ec8sY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CzzugxKy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TS3Ec8sY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CzzugxKy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B92DF14000EE;
	Wed,  5 Aug 2026 18:44:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 18:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1785969841; x=1786056241; bh=ncQvJEDewSxGoUTyHvavnRM3eimONEWeNOy
	5Mz+Rhc8=; b=TS3Ec8sYR7w7+JW4738NzDJxalzloU10Av61LtG2MFF0gktqzti
	jWCm7iV5GM7ujy50lYUmxNXchmhBK+CfgPhW84v/1ba8ZrSpsiF3voFeMendTqSR
	BXMFEoqx3GpevfP62IcsrqOCSu3pTtk8+XxsXSbpgJo/8fgqMRnQm+tSGUuu/TPK
	VHbWNERKxz5t7Y0UQoyN+g8bRjX6TpWEJviZzy//vcD0r0LH/O7i7pj12N/o+BoJ
	Ptrh5DK+bo4hVH6FIhlByHUJ0LURsED9DFjfcCNCOHEl3KXdT3qHwxr1em0klqR+
	bPDJJxXYSN84h+GXwJ9azT+kEPyJPavcEHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785969841; x=
	1786056241; bh=ncQvJEDewSxGoUTyHvavnRM3eimONEWeNOy5Mz+Rhc8=; b=C
	zzugxKyLMo7F9va4lUDiI/rz7EU9hdlgq2xvjrfMQ6xgS2uN5BK/m63htV5DaYKo
	y6z1Hl98zzWgkTP0kwhMwOamFOk7HVB2errtbEWRMhMiisAs+pKbOUMjweaUa6VV
	QM0eRH+QlZ4Gwnb3LyBnF1BdOM/uM4EFtyAmBSB6PKzAtNiYVW+nHCXTn3oBa9Wa
	mvvgZ/oYj3YONu+JQi0Na/rW7QFs9B6YjZreNT01+Y90dzRcZImudVFhKGv102x5
	787cA39CzOrLXZl5P8nrN0FvI/1gZxIqucnCLhfywqZLR3/WUDFsAYD9FbNUbYUt
	LBwrrtxrT5c1+z5CYsPKw==
X-ME-Sender: <xms:sLxzas28_ntKKfOrPRx0dAJo9IQJuRKB1BIRcWX-JDoP9SPrFRF9pg>
    <xme:sLxzanhYf5dzVToKd6sA3Huqzv_sPd70NRo1rV4MoIPG9DwJQtXi3Ql-xwyum06If
    MftjGTTDN7HTpCM3VAU5eo8pqFy9ejRZpctvAfik4KmDbUojQ>
X-ME-Received: <xmr:sLxzaqW-El7oqASMExh0nW4lHrVTbJKtbqEHFbGdcPVBA_ktPBlsrx_p5KwMU0XXu3pZMNNgX28XTA5lQy1BWAMQGx40IKs>
X-ME-Proxy-Cause: dmFkZTGMIger68+t0INX8N6IauvbQ+y0Hc01K2KE+G8ksam4Q3FUoPmP0pc4+YOujk8nQ7
    b1rP732xrvY83AoQCFcob/EEPHkZKqeKJfKxriE+K0abCWYZGxOzBk4b0byQuYj/GXb3Mw
    rsft3QZOFDQXdMl5gc6c5DI/7PKQcc2ixMHpEpBtidwilDGqJ2IYibD9EuS5eZPTlBwvVY
    g+GMCTWbfcZL6QaJjQX/7W65f3e8xtCfNcSXWedVVKy8+5gAQywJ82fcBXWiyqJ2DGzMvN
    CnS1S9oQoQ6rKlbfwIcLHvIiBfxZ3JdoVI9HwhV633wvd65wz/Fj8sEM2rEp2x8wYfO9Zy
    glNo+nKwmeYNL1UkA5DfwaPO6FPTHUlSn/MXa3o2xMg1Il4ddMy/RxFWGF8AczbtA4L9Nf
    RX1k+Vh1ILgDMMItSDH0fiPAZQ23FFsfvZjzzJssPIxbnPv6iGvVNOQJcEIVPOpDSZBtn5
    FCi8N72L4ksXzvXfQPVbEDWaRybnqQIabHXxp4i7zV4rco8I6oX8/+not3gXjpUB6BwuSG
    ZKC0KPdWhG1KMG7+owCTJuGcI7CVnLBrbSm30JDaaV563BLL8+6/QZRNn22ko/0c93IRR2
    VuXVCfR7DVrmNVMvOl5TZ1KaoCt1H2P8fqCB2z9ywkHRvNmlwdvmSb/JsUmQ
X-ME-Proxy: <xmx:sLxzajzBl9HU-J4NG-FZNRqadLSGersBFPGzrUtjbe88iMZRsjx05A>
    <xmx:sLxzai6nQLi2NvPon-V9F8a3VPNjK0dQNuJm5IICRawXUfExXIn1uw>
    <xmx:sLxzatiJ66Hf8ATtbQCJXKeuYkKgbJK1D4vXNU0Tp8gjSRPkS2P6vA>
    <xmx:sLxzalimA1lUm6C7fOeiHhBrXTXmuVYOeqgDbUMGmBvvQ9q5nH8o3A>
    <xmx:sbxzarIqZG8fxMXPPF89vUbEnEntJMT3dlo6g2-d76HbJghEDmPXB1Hf>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 18:43:54 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "quanyeyang" <quanyeyang@proton.me>
Cc: "Quanye Yang" <quanyemostima@gmail.com>,
 "Justin Suess" <utilityemal77@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Song Liu" <song@kernel.org>, "Jiri Olsa" <jolsa@kernel.org>,
 "KP Singh" <kpsingh@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Yonghong Song" <yonghong.song@linux.dev>,
 "Emil Tsalapatis" <emil@etsalapatis.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Subject: Re: =?utf-8?b?5Zue5aSN77ya?= Re: [PATCH] bpf: disable lockdep while
 running BPF on lock_release
In-reply-to: <178592062568.3252194.6464683099845305898@noble.neil.brown.name>
References:
 <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
  <anEuaSqiCVsQ6I4P@zenbox>
  <178583246611.3252194.4318729338489544399@noble.neil.brown.name>
  <CABcBDJuznu=BgDhevsD6PybX8+6fcaO1xyTcuGuv8F_+MfeZoQ@mail.gmail.com>
  <178588373680.3252194.4414470901360919775@noble.neil.brown.name>  <46Fu_iB0xOxZXb0l5G6pslLArj7TrP_AOICffhfZKoviSn7zVUVVVSMfWaVBYNqt9RiCWWHhSAvlMc3RaJvRFSnvbV2EcBz9VUBQzb2wSkw=@proton.me>
  <178592062568.3252194.6464683099845305898@noble.neil.brown.name>
Date: Thu, 06 Aug 2026 08:43:50 +1000
Message-id: <178596983056.3252194.16986843925963956795@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 05 Aug 2026, NeilBrown wrote:
>=20
> One thing I didn't like about the original patch is that it seemed to add
> a lot of noise to the code, passing keys around in multiple places.
> Maybe the cleanest approach would be to embed the keys in the "struct
> rhashtable" so each table gets its own key.
> Then use lockdep_register_key() in rhashtable_init and use it as needed.
>=20
> You could even have just one key and use the different subclasses for
> the different locks.
>  0 for rhashtable.mutex
>  1 for rhashtable.lock
>  2 for the bit locks
>=20
> but maybe that is needless complexity.
>=20

So I thought about this some more and came up with this approach which
might be a good compromise.  I builds but I haven't tested it.
What do you thing?

NeilBrown

diff --git a/include/linux/rhashtable-types.h b/include/linux/rhashtable-type=
s.h
index 57c11ec9dc64..2029fba216a8 100644
--- a/include/linux/rhashtable-types.h
+++ b/include/linux/rhashtable-types.h
@@ -97,6 +97,9 @@ struct rhashtable {
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 	struct alloc_tag		*alloc_tag;
 #endif
+#ifdef CONFIG_LOCKDEP
+o	struct lock_class_key		*lockdep_key;
+#endif
 };
=20
 /**
diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 79f83b6eec27..f8358d43691b 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -320,18 +320,6 @@ static inline struct rhash_lock_head __rcu **rht_bucket_=
insert(
  * When we write to a bucket without unlocking, we use rht_assign_locked().
  */
=20
-static inline unsigned long rht_lock(struct bucket_table *tbl,
-				     struct rhash_lock_head __rcu **bkt)
-	__acquires(__bitlock(0, bkt))
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	bit_spin_lock(0, (unsigned long *)bkt);
-	lock_map_acquire(&tbl->dep_map);
-	return flags;
-}
-
 static inline unsigned long rht_lock_nested(struct bucket_table *tbl,
 					struct rhash_lock_head __rcu **bucket,
 					unsigned int subclass)
@@ -341,10 +329,18 @@ static inline unsigned long rht_lock_nested(struct buck=
et_table *tbl,
=20
 	local_irq_save(flags);
 	bit_spin_lock(0, (unsigned long *)bucket);
-	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
+	/* subclass 0 is used for ->lock and 1 for ->mutex. 2+ for bitlocks */
+	lock_acquire_exclusive(&tbl->dep_map, subclass+2, 0, NULL, _THIS_IP_);
 	return flags;
 }
=20
+static inline unsigned long rht_lock(struct bucket_table *tbl,
+				     struct rhash_lock_head __rcu **bkt)
+	__acquires(__bitlock(0, bkt))
+{
+	return rht_lock_nested(tbl, bkt, 0);
+}
+
 static inline void rht_unlock(struct bucket_table *tbl,
 			      struct rhash_lock_head __rcu **bkt,
 			      unsigned long flags)
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index d459bef245f4..17340433d983 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -189,7 +189,6 @@ static struct bucket_table *bucket_table_alloc(struct rha=
shtable *ht,
 	struct bucket_table *tbl =3D NULL;
 	size_t size;
 	int i;
-	static struct lock_class_key __key;
=20
 	tbl =3D alloc_hooks_tag(ht->alloc_tag,
 			kvmalloc_node_align_noprof(struct_size(tbl, buckets, nbuckets),
@@ -205,7 +204,10 @@ static struct bucket_table *bucket_table_alloc(struct rh=
ashtable *ht,
 	if (tbl =3D=3D NULL)
 		return NULL;
=20
-	lockdep_init_map(&tbl->dep_map, "rhashtable_bucket", &__key, 0);
+#ifdef CONFIG_LOCKDEP
+	/* bitlocks must use nesting level 2 or more */
+	lockdep_init_map(&tbl->dep_map, "rhashtable_bucket", ht->lockdep_key, 0);
+#endif
=20
 	tbl->size =3D size;
=20
@@ -428,7 +430,7 @@ static void rht_deferred_worker(struct work_struct *work)
 	int err =3D 0;
=20
 	ht =3D container_of(work, struct rhashtable, run_work);
-	mutex_lock(&ht->mutex);
+	mutex_lock_nested(&ht->mutex, 1);
=20
 	tbl =3D rht_dereference(ht->tbl, ht);
 	tbl =3D rhashtable_last_table(ht, tbl);
@@ -1172,8 +1174,14 @@ int __rhashtable_init_noprof(struct rhashtable *ht,
 		return -EINVAL;
=20
 	memset(ht, 0, sizeof(*ht));
+	/* mutex_lock must use nesting level 1 */
 	mutex_init_with_key(&ht->mutex, key);
 	spin_lock_init(&ht->lock);
+	/* spin_lock can use nesting level 0 */
+	lockdep_set_class(&ht->lock, key);
+#ifdef CONFIG_LOCKDEP
+	ht->lockdep_key =3D key;
+#endif
 	memcpy(&ht->p, params, sizeof(*params));
=20
 	alloc_tag_record(ht->alloc_tag);
