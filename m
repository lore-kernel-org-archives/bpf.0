Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385DA35AC32
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378906; cv=none; b=mnSRisKTxy2FEwk9ZsUsrkTJRCbkUg5Tf/KkVNT4/hR6U7yQoJ9mfe3GGFTduVLOl4Zxo/nAhvK9cDJfLQySvj3h8WROAJn7rO1gDVDPqSqNMjP1XdaF7+oO0qTM7OF9SOSomDqsAN70SzKh+EPpwhSKAsWiedcb7G8nd4qVI60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378906; c=relaxed/simple;
	bh=2fcJP08/HSUH1wuSTGx+vBhClLrtN4O9zNgxlhnCbX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vu7ZoIGRzUkygrGuhyfuwS9BMxh2leHa5Eivz8h2SxnZXR1Lw0/GK6Fl6nrW4Jx5Nqe/wy57xpcIzEfVzbbpwaVwUg6m/PWNy9wZ0zjhd57LE7+9uMTA6cuFM+fGfyIiCWp80TQyFtmlA2SftdUgEb+/2ToUHCYE+4ZsrbPlLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MaqfLxci; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaqfLxci"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84777e9b51bso8843312b3a.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783378903; x=1783983703; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4OKH8nLpRPfbp1hgj6REqr4yMvAGngFItE2YoOJh7A=;
        b=MaqfLxci+7yU4xbgzhJ7Yft+fgtHLcaVKgIDMH/w/QqxbYBpNW6RvvMyUZb6zTGddG
         gsi7pa1dKRhDE0GSR34GWGmvigUjd/OPo/f8v+tAS0NRr07+zOk0OifwzXmm+CmzClek
         f14ZZA4OL96xP+l/o22mvz2cCi44rno0VJvFQYcV5xgrD9m9WdPiT2CwQ4qfJ3eKEIFw
         /FtLCGYICBcJoTeW8LuxNCYel56kyCUFXOW5EAjs+lgymmlZcp0x1heY1VW112487g1p
         1u28O0/G3etokeXBlSNVsBvsUH0DKx1+YzZc87ZvFghLGHFbcpte1tnHgvmGAHZrQByE
         IWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783378903; x=1783983703;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4OKH8nLpRPfbp1hgj6REqr4yMvAGngFItE2YoOJh7A=;
        b=Uui2r+5hCTfpYIH6cS07gJRXT6rRSpfFYoUZSvMxoiCZrLdl8NYhVSboGSnQD+yd0n
         0uwZHQO5ni+ukUpIxDlha4URNbYWuG+sZA6I4ZfvbjZYaOTk3cH4MPZiPNM8KLmVatd/
         fq83RAaRzr8Vi+jHmP0VjURE1tjuS1z5RmEzMPWnCxhSyfrR2O8+Miuw+3Eymupyae2H
         DmPZQcCLxm5JGm7x1VJM/G03p/tY8MUBDNY299S/4PxSBFGFI0Dgs+2fhycBp21/HDQz
         ophjqp22Je3APMDqwu03LZ+SQ9aoJZWJf5qQabactTTz4ZwwZP9eWKsKj/iROHpjhvyp
         anhA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6gH9Pv0gRpMk1qQVpF2T9wlPjgWs6JmBQtZD89cvkgVbQUVql5f1dEfykxL37aE8giWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUmF4bdu5WKwNIjzKJ3onnQv4OYuOmOygtW4MSvHbE8iaMlSx
	yNIXILopQiHtS9hJIhGNes4EG+vI6e11fKrqj4L2G/GyxKT3l5QdFr/n+PiT7oKnaCOiKXnzm0Q
	rCqbzGQ==
X-Received: from pfll10.prod.google.com ([2002:a05:6a00:158a:b0:847:ada8:bf86])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd81:b0:847:8650:69cd
 with SMTP id d2e1a72fcca58-84826dad939mr2513930b3a.33.1783378903005; Mon, 06
 Jul 2026 16:01:43 -0700 (PDT)
Date: Mon,  6 Jul 2026 23:01:27 +0000
In-Reply-To: <20260706093525.13030-3-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706093525.13030-3-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260706230142.1691146-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
From: Kuniyuki Iwashima <kuniyu@google.com>
To: mahe.tardy@gmail.com
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Mahe Tardy <mahe.tardy@gmail.com>
Date: Mon,  6 Jul 2026 09:35:21 +0000
> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
[...]
> +static bool bpf_ksock_send_enter(struct bpf_ksock_send_guard *guard)

Can we do this better with assigning a single bit to task_struct ?


> +{
> +	struct bpf_ksock_send_guard *entry;
> +	struct hlist_bl_node *pos;
> +	struct bpf_ksock_send_bucket *bucket;
> +
> +	bucket = bpf_ksock_send_bucket(current);
> +	hlist_bl_lock(&bucket->head);
> +	hlist_bl_for_each_entry(entry, pos, &bucket->head, node) {
> +		if (entry->task == current) {
> +			hlist_bl_unlock(&bucket->head);
> +			return false;
> +		}
> +	}
> +
> +	guard->task = current;
> +	INIT_HLIST_BL_NODE(&guard->node);
> +	hlist_bl_add_head(&guard->node, &bucket->head);
> +	hlist_bl_unlock(&bucket->head);
> +	return true;
> +}
> +
> +static void bpf_ksock_send_exit(struct bpf_ksock_send_guard *guard)
> +{
> +	struct bpf_ksock_send_bucket *bucket;
> +
> +	bucket = bpf_ksock_send_bucket(guard->task);
> +	hlist_bl_lock(&bucket->head);
> +	hlist_bl_del(&guard->node);
> +	hlist_bl_unlock(&bucket->head);
> +}
[...]
> +__bpf_kfunc struct bpf_ksock *
> +bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> +		 int *err__uninit)
> +{
> +	struct bpf_ksock_create_opts opts_copy;
> +	struct bpf_ksock *ks;
> +	struct net *net;
> +	int err;
> +
> +	/*
> +	 * sock_create() derives the network namespace, credentials, and cgroup
> +	 * from current. Kernel threads, including BPF workqueue callbacks, do
> +	 * not carry the context of the task that invoked the BPF program.
> +	 */
> +	if (!bpf_ksock_has_user_task_context()) {
> +		err = -EOPNOTSUPP;
> +		goto err_out;
> +	}
> +
> +	if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	opts_copy = (struct bpf_ksock_create_opts){
> +		.family = READ_ONCE(opts->family),
> +		.type = READ_ONCE(opts->type),
> +		.protocol = READ_ONCE(opts->protocol),
> +		.reserved = READ_ONCE(opts->reserved),
> +	};
> +
> +	if (opts_copy.reserved) {
> +		err = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	if (opts_copy.family != AF_INET && opts_copy.family != AF_INET6) {
> +		err = -EAFNOSUPPORT;
> +		goto err_out;
> +	}
> +
> +	if (opts_copy.type != SOCK_DGRAM) {
> +		err = -EPROTONOSUPPORT;
> +		goto err_out;
> +	}
> +
> +	if (opts_copy.protocol != IPPROTO_UDP && opts_copy.protocol != 0) {
> +		err = -EPROTONOSUPPORT;
> +		goto err_out;
> +	}
> +
> +	ks = kzalloc_obj(*ks);
> +	if (!ks) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	net = current->nsproxy->net_ns;
> +	if (!bpf_ksock_net_try_charge(net)) {
> +		err = -ENOSPC;
> +		goto err_free;
> +	}
> +
> +	/*
> +	 * Use the normal current-task socket path so LSM/cgroup policy,
> +	 * socket labels, and the active netns reference match a socket(2)
> +	 * created by the BPF program's caller.
> +	 */
> +	err = sock_create(opts_copy.family, opts_copy.type, opts_copy.protocol,
> +			  &ks->sock);

This also triggers LSM in __sock_create() so needs the loop
detection, no ?

Same for __sys_bind_socket() and __sys_connect_socket().


> +	if (err)
> +		goto err_uncharge;
> +
> +	ks->sock->sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
> +	ks->sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
> +
> +	refcount_set(&ks->usage, 1);
> +	put_unaligned(0, err__uninit);
> +	return ks;
> +
> +err_uncharge:
> +	bpf_ksock_net_uncharge(net);
> +err_free:
> +	kfree(ks);
> +err_out:
> +	put_unaligned(err, err__uninit);
> +	return NULL;
> +}
> +
> +/**
> + * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
> + * @ks:		The BPF kernel socket context.
> + * @opts:	Pointer to struct bpf_ksock_addr_opts with local address.
> + * @opts__sz:	Size of the opts struct.
> + *
> + * Binds the socket to the specified local address and port.
> + * This is optional; if not called, the kernel will auto-assign.
> + *
> + * This function may sleep while binding the socket, so it can only be used in
> + * sleepable BPF programs (SYSCALL).
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
> +			       const struct bpf_ksock_addr_opts *opts,
> +			       u32 opts__sz)
> +{
> +	struct sockaddr_storage addr = {};

nit: we don't need to initialise here since bpf_ksock_get_addr() does.


> +	int addrlen;
> +
> +	if (!bpf_ksock_has_user_task_context())
> +		return -EOPNOTSUPP;
> +
> +	addrlen = bpf_ksock_get_addr(opts, opts__sz, &addr);
> +	if (addrlen < 0)
> +		return addrlen;
> +
> +	return __sys_bind_socket(ks->sock, &addr, addrlen);
> +}
> +
> +/**
> + * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
> + * @ks:		The BPF kernel socket context.
> + * @opts:	Pointer to struct bpf_ksock_addr_opts with remote address.
> + * @opts__sz:	Size of the opts struct.
> + *
> + * Connects the socket to the specified remote address and port.
> + *
> + * This function may sleep while connecting the socket, so it can only be used
> + * in sleepable BPF programs (SYSCALL).
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
> +				  const struct bpf_ksock_addr_opts *opts,
> +				  u32 opts__sz)
> +{
> +	struct sockaddr_storage addr = {};

Same.
