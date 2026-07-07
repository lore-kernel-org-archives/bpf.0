Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FE13C1969
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418782; cv=none; b=N9ous8A+V9tbnZZqEiBO8nEkjRyjfxI9WW+L32NEOvvdM2Ce8mmwjgwxGFS+0GPlVwQE3EFcU3IgxK1xYIPtvMaDU9Be7yb86l+Kwk6iqu0H28Z06D5zRDx2OxHCa3aUZymwi5mgbXcPS8QB8siJngvdORoLlIYuJOA7NjgI6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418782; c=relaxed/simple;
	bh=OAKB6REpwMAL3mD8f/kvOYmQD6X0GhKuKto/VKRSscc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNSmW/TxwkXB4kmfKKqo4/0CxhVC9iHl//nRBIdO1bDfuDw7WhF3eAwzrgQOBCHj//vTlR3G21QR8oa4/N62GhtdyPT9Kkw0ol5BpM7lHckH+puCLPf8GqxCfbDm271CqbFIDgIZpcQylvEiVPrNn8Tcqq2/WNdMYbH2vpBkAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4Y7Q7RH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Y7Q7RH"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so25852855e9.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 03:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783418779; x=1784023579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7nKMzBrNPng+OFv7tZKgSIEKfGOpCS7rDlLCvXC7fDo=;
        b=V4Y7Q7RHfgFf+JB6BGzY4VjhE15lIDP66ULj9x8I3S2HI4TtCPN6Eu1i6y1EiplEWP
         ztCXpnHktjsci8m22o2YhPgew1YkXfShxQ5g/AkhARIjckpIEQr31cQdQnk6LKS7B8+u
         h+DmlPSkE1dSVPHhnBZMzIhzidx4Bj+HTzTrAo50r+12kNBvYVZ/wTxxWtlwDGDYRr+5
         AXIeHShm970EQMyISxF1YDcXZ4hEgs/hnBbd9qr7y939XJ3CM97M/6cL/ZyHmtbbzVu5
         GU5yBasEG0wg1ZRZioCpAlpQmGXRZ9zsltZyMlb1eDpTdYgPDH+iCrHYAcH6tJhI0ZUl
         mgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783418779; x=1784023579;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7nKMzBrNPng+OFv7tZKgSIEKfGOpCS7rDlLCvXC7fDo=;
        b=FTAfp/4TnJm8OAXRhFc22OAOcu4a8NP8ynamlOTRwHFUu4DcQCYHViPsFBa/mxVEt3
         UVB7aChKgH9l474b8OGK7AgDpMppX4bU68UekDch97GIqcYzsCq1a/fTZ3J20Seqz+iB
         94Yl48vB1cl1vzhJqIsO/woaGKn2itAnKb5Xibs5nXCwJczXIOLVrF/ykdDZTONVtw25
         lUOdWuUVAfJpqX6R/e3vjLpDFvbtud8MWC/XCjp4DoJdJImJ/i+Y+72yQnw4mRlrz+/f
         0WW9+PjLm59pnhC+Ywm7djEAMUAQzQECmMtCbvg4NNll2otQwYDb7b8TEXUp9vZFMCFs
         NkDw==
X-Forwarded-Encrypted: i=1; AHgh+RrxqBYfpDx69NIt9xxGESoVB3AvpRHLxkHRjusWrZf58AGTVucTSYVBSSHEESBdjBsZRkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IxU1aw6yLZ1kQ3b+FDsGONpb1B6zfsktIcoyvgcXIRzHJSe4
	eaQKNFk9aSLRvj7UgBsRBHTizN2gvg1y97VJ1hbHpLeSAoE8olDxe5xT
X-Gm-Gg: AfdE7ckBzumf0LPClp+nKUNDzTvMMbWFdA+rt3uB5NAHGqsF6ucQUAHMXHTlRwccqzw
	zS24/VDIed/orZqUHqQp3W/68q6y8P9qlBMc5KMBRr61tnvAAGvzLMIsUX1A4cSVvsnD3AxtD7m
	haUE++y9Q8VHYAbGq6hqmYe27p+I9m64e0biJrtb9h4awsZ2RM4hdh2qRGoX4V7L2qHwkMaC54g
	f91hLvM87fRRGYJ9oLIp59tjS5WnJen/SNvO2Xf5HTplUTR9Csq3NdYPNAWYcLOtjdj3f1L3ZZu
	snNJN9YN/0+9RPlxaQ/fi6pdoQwP+ZnXT9MupT524Xa8AaJt0yqh6sPbmfdir6zP9KrVsSX+yTZ
	G6vSal+ee6aIv5772YsngNs+pvpwAm32LoEB9IUt/qJ4hCJpBsxT3d5wEO+VR03LCMnsdrzPxRP
	HW5PxVRM05gzlSi1HwYlRU9XJRwUC0tOIez1czRNxmMljV
X-Received: by 2002:a05:600c:3b05:b0:493:bb45:d54d with SMTP id 5b1f17b1804b1-493df09e3a9mr49840045e9.37.1783418778334;
        Tue, 07 Jul 2026 03:06:18 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f3676dsm47709045e9.5.2026.07.07.03.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 03:06:17 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:06:15 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	netdev@vger.kernel.org, pabeni@redhat.com, song@kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Message-ID: <akzPl9lLtjcRFXxD@gmail.com>
References: <20260706093525.13030-3-mahe.tardy@gmail.com>
 <20260706230142.1691146-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706230142.1691146-1-kuniyu@google.com>

On Mon, Jul 06, 2026 at 11:01:27PM +0000, Kuniyuki Iwashima wrote:
> From: Mahe Tardy <mahe.tardy@gmail.com>
> Date: Mon,  6 Jul 2026 09:35:21 +0000
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> [...]
> > +static bool bpf_ksock_send_enter(struct bpf_ksock_send_guard *guard)
> 
> Can we do this better with assigning a single bit to task_struct ?

Yes, that would be way simpler but I avoided touching task_struct. If we
are okay with that then it could be simplified.

> 
> > +{
> > +	struct bpf_ksock_send_guard *entry;
> > +	struct hlist_bl_node *pos;
> > +	struct bpf_ksock_send_bucket *bucket;
> > +
> > +	bucket = bpf_ksock_send_bucket(current);
> > +	hlist_bl_lock(&bucket->head);
> > +	hlist_bl_for_each_entry(entry, pos, &bucket->head, node) {
> > +		if (entry->task == current) {
> > +			hlist_bl_unlock(&bucket->head);
> > +			return false;
> > +		}
> > +	}
> > +
> > +	guard->task = current;
> > +	INIT_HLIST_BL_NODE(&guard->node);
> > +	hlist_bl_add_head(&guard->node, &bucket->head);
> > +	hlist_bl_unlock(&bucket->head);
> > +	return true;
> > +}
> > +
> > +static void bpf_ksock_send_exit(struct bpf_ksock_send_guard *guard)
> > +{
> > +	struct bpf_ksock_send_bucket *bucket;
> > +
> > +	bucket = bpf_ksock_send_bucket(guard->task);
> > +	hlist_bl_lock(&bucket->head);
> > +	hlist_bl_del(&guard->node);
> > +	hlist_bl_unlock(&bucket->head);
> > +}
> [...]
> > +__bpf_kfunc struct bpf_ksock *
> > +bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> > +		 int *err__uninit)
> > +{
> > +	struct bpf_ksock_create_opts opts_copy;
> > +	struct bpf_ksock *ks;
> > +	struct net *net;
> > +	int err;
> > +
> > +	/*
> > +	 * sock_create() derives the network namespace, credentials, and cgroup
> > +	 * from current. Kernel threads, including BPF workqueue callbacks, do
> > +	 * not carry the context of the task that invoked the BPF program.
> > +	 */
> > +	if (!bpf_ksock_has_user_task_context()) {
> > +		err = -EOPNOTSUPP;
> > +		goto err_out;
> > +	}
> > +
> > +	if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
> > +		err = -EINVAL;
> > +		goto err_out;
> > +	}
> > +
> > +	opts_copy = (struct bpf_ksock_create_opts){
> > +		.family = READ_ONCE(opts->family),
> > +		.type = READ_ONCE(opts->type),
> > +		.protocol = READ_ONCE(opts->protocol),
> > +		.reserved = READ_ONCE(opts->reserved),
> > +	};
> > +
> > +	if (opts_copy.reserved) {
> > +		err = -EINVAL;
> > +		goto err_out;
> > +	}
> > +
> > +	if (opts_copy.family != AF_INET && opts_copy.family != AF_INET6) {
> > +		err = -EAFNOSUPPORT;
> > +		goto err_out;
> > +	}
> > +
> > +	if (opts_copy.type != SOCK_DGRAM) {
> > +		err = -EPROTONOSUPPORT;
> > +		goto err_out;
> > +	}
> > +
> > +	if (opts_copy.protocol != IPPROTO_UDP && opts_copy.protocol != 0) {
> > +		err = -EPROTONOSUPPORT;
> > +		goto err_out;
> > +	}
> > +
> > +	ks = kzalloc_obj(*ks);
> > +	if (!ks) {
> > +		err = -ENOMEM;
> > +		goto err_out;
> > +	}
> > +
> > +	net = current->nsproxy->net_ns;
> > +	if (!bpf_ksock_net_try_charge(net)) {
> > +		err = -ENOSPC;
> > +		goto err_free;
> > +	}
> > +
> > +	/*
> > +	 * Use the normal current-task socket path so LSM/cgroup policy,
> > +	 * socket labels, and the active netns reference match a socket(2)
> > +	 * created by the BPF program's caller.
> > +	 */
> > +	err = sock_create(opts_copy.family, opts_copy.type, opts_copy.protocol,
> > +			  &ks->sock);
> 
> This also triggers LSM in __sock_create() so needs the loop
> detection, no ?
> 
> Same for __sys_bind_socket() and __sys_connect_socket().

This should be okay as create/bind/connect can only be called from
SYSCALL progs and not LSM progs. We only care about recursion from the
kfuncs in the ksock_kfunc_btf_ids group which are also allowed from LSM
progs (release/acquire/send).

> 
> 
> > +	if (err)
> > +		goto err_uncharge;
> > +
> > +	ks->sock->sk->sk_rcvbuf = SOCK_MIN_RCVBUF;
> > +	ks->sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
> > +
> > +	refcount_set(&ks->usage, 1);
> > +	put_unaligned(0, err__uninit);
> > +	return ks;
> > +
> > +err_uncharge:
> > +	bpf_ksock_net_uncharge(net);
> > +err_free:
> > +	kfree(ks);
> > +err_out:
> > +	put_unaligned(err, err__uninit);
> > +	return NULL;
> > +}
> > +
> > +/**
> > + * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
> > + * @ks:		The BPF kernel socket context.
> > + * @opts:	Pointer to struct bpf_ksock_addr_opts with local address.
> > + * @opts__sz:	Size of the opts struct.
> > + *
> > + * Binds the socket to the specified local address and port.
> > + * This is optional; if not called, the kernel will auto-assign.
> > + *
> > + * This function may sleep while binding the socket, so it can only be used in
> > + * sleepable BPF programs (SYSCALL).
> > + *
> > + * Return: 0 on success, negative errno on error.
> > + */
> > +__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
> > +			       const struct bpf_ksock_addr_opts *opts,
> > +			       u32 opts__sz)
> > +{
> > +	struct sockaddr_storage addr = {};
> 
> nit: we don't need to initialise here since bpf_ksock_get_addr() does.

Ah actually I didn't know that compound literal in C would zero the rest
of the struct. Thanks, let's remove those two then.

> 
> > +	int addrlen;
> > +
> > +	if (!bpf_ksock_has_user_task_context())
> > +		return -EOPNOTSUPP;
> > +
> > +	addrlen = bpf_ksock_get_addr(opts, opts__sz, &addr);
> > +	if (addrlen < 0)
> > +		return addrlen;
> > +
> > +	return __sys_bind_socket(ks->sock, &addr, addrlen);
> > +}
> > +
> > +/**
> > + * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
> > + * @ks:		The BPF kernel socket context.
> > + * @opts:	Pointer to struct bpf_ksock_addr_opts with remote address.
> > + * @opts__sz:	Size of the opts struct.
> > + *
> > + * Connects the socket to the specified remote address and port.
> > + *
> > + * This function may sleep while connecting the socket, so it can only be used
> > + * in sleepable BPF programs (SYSCALL).
> > + *
> > + * Return: 0 on success, negative errno on error.
> > + */
> > +__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
> > +				  const struct bpf_ksock_addr_opts *opts,
> > +				  u32 opts__sz)
> > +{
> > +	struct sockaddr_storage addr = {};
> 
> Same.

Noted

