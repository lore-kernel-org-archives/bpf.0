Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498E9522EF5
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911428; cv=none; b=DKcjh+SLTYMsc15DtB1J71RQ5qrIv5hYk17nKPopimD8uzLR2F0FAqF6Vzi2MRmeYYHyAYTenWBxojZ5sOc4qAQfySk0ItzaTwfjBnienmO1igylREK4Ul+QIy3t/D1cC5xljNinHm31eVJ1IjO4c6KvpSkMYbhBGDwYJc8qVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911428; c=relaxed/simple;
	bh=8Mnb9rp0/KendOgopy9yG9eEoskvig2agjZXLTmvHSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVBTK4UaSYB2vQhsvUiUGpcuvFUvXZLPbVDSMslfcKLVcO5Mb/APfB6VFWcp+dRu7OkX046zIL2sP8q7YIS9WjnmlhQFTPtEY53MRGVo75QUkfXp9zCSzgtB8nezYBKth1R+AiXnX5HtUDAAtDA0wddJrQNMlJPhblTCKcFFT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzOYc+kd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzOYc+kd"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1832600f8f.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791911425; x=1792516225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o0KDBwBs4i6tsVXtOM7HjXD+EUyQMAjasdWbMXcJZLA=;
        b=mzOYc+kdWFeSdJVQFBXti+v74yBmVMNJqS3ISyhau555jpWcUlMugOo46RXrWwUyn7
         QgStKVpRlz8dxZpG1tB8h6BaFgPPC1AqMsJLSFEFHn8QO6/3CMOyHLOtweBbmKUu1TFq
         McqOuLU54GJfWpwcgCgvaW+SjrMVUzZyCh0l9FzCq+CWRgg5N6ZWBGWjrGh+HSGcKxVx
         E9s7qE8zOr9XYR17UnaxiFibfGKe5baDIy2jmhAmpluqrns1QFfGgFY8Og2QTuHiM1Uh
         HoRECdPEZ/PRarbWZdpfMLMt3Go1042BiLzATvb31r7oGeJs/e5wXMMKdlycRvPrUhky
         qIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791911425; x=1792516225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o0KDBwBs4i6tsVXtOM7HjXD+EUyQMAjasdWbMXcJZLA=;
        b=sig+Xd0nnSCjigitkEKC/+RFsOqMpmItgKtPFCN2RWJwLqdboO72ZDP0ZLxkWTPofS
         v0PNIqXCs2MEzv2vcoPdqHnM3FdOfbz3mVHf7Ry7lHP0i+5nQS9ZFvpTGUb180+yT26u
         4D6GEhiQGMyr6ra20KWspg/2ZYoIoAGhYJvnY2zkPTPUmFBrfqRvGydwthWHHpHfQ7TR
         NSwHegH2GRlGV/8hlNVoFdlGSmZhnWTbTzYubhwuSvZAwH1c6bVv/r2FeiTMAYK+iiH0
         Mhze+K0lBph4ZYsNr36MU9qYTCNmBv4AB1G0pL4QYRBt9XVoacX4QzMrujefP2yAp7xS
         SVfQ==
X-Gm-Message-State: AFq9FYLOvkaVHxYMXMobsudQpnNQyZ97SO2WiikiU9dCgSUBr4FzakEr
	Rirjqz7mz4UFfJY0sR/d62Fe5EwiH9axtb33wJoZzR+9ubuwrSiOK9Yb
X-Gm-Gg: AYBFou1s8vi9blZERDnEmKwYDm0BQQ/boX/Hjk47XTzXHlaUVUOl55wNqsW7jMMrMdI
	x1EbrR1wD/R+c7reIOQDVZS5ufEV9RtEQkrvw1uXF5MG82oTgIBmhIcp/XWqPisDf97Ojre3+ud
	VFGywaT+vpDMpLb4yXl/g4v6yrHTZ+k1BdDMz1lMw/kfsp259/CxTRMeqCs8JO86yjzePXjURAW
	lN1EuGYwOOt92KQ1EWE/I+HTmDHYysSalRL/FSeMS1MQeotQ4I1w8T5AW3zhp1MSnbwIitPvbpi
	1Nk0xYIwKED7BXCMAE/4Fydv36LugTQ7x8bwXm6VlYzTYJ7ZOiJC9ZiJM57yzFCia45qJO605dG
	5EbaaLr1hzg1/isFp3dMnC48T1BMY06kcomZ5IswXBZrwkd5U6kDVd0+yNld7THg/KvkFroVOtR
	1uMnB8rpcifMuU2F8ZsxNEYG4eaIF+9rV4OiWn0YXsfnZ+Noz0mvgsd0cSYoZ6jH/I1YRGH+nxA
	feTv2Z7i+dgMJ3UXsgwCxswChki0oJuWi4rgb799/1993A=
X-Received: by 2002:a05:6000:440e:b0:487:13f:f612 with SMTP id ffacd0b85a97d-48dbacdbd23mr18284968f8f.37.1791911425160;
        Tue, 13 Oct 2026 10:10:25 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de77b35b5sm599458f8f.21.2026.10.13.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:10:24 -0700 (PDT)
Date: Tue, 13 Oct 2026 19:10:22 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: allow ksock kfuncs call from wq
Message-ID: <as5l_nMk7EV_dUs6@gmail.com>
References: <20261013163101.205638-1-mahe.tardy@gmail.com>
 <sashiko-outbox-170139@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-170139@kernel.org>

On Tue, Oct 13, 2026 at 04:42:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] bpf: bpf_ksock_create causes NULL pointer deref on task exit
> - [High] bpf: bpf_ksock_create in workqueue escapes network namespace
> --
> 
> commit 34ed977b7943eebacf7e605dc8f26f2576ba2664
> Author: Mahe Tardy <mahe.tardy@gmail.com>
> 
> bpf: allow ksock kfuncs call from wq
> 
> This commit relaxes the constraints on ksock kfuncs by removing the check
> that ensures they are executed in a user task context. This change was
> made to allow ksock kfuncs to be invoked from asynchronous workqueues,
> bypassing the original LSM hook considerations.
> 
> > diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> > index e9943aeeadd32..21d5fd1eb403d 100644
> > --- a/net/core/bpf_ksock.c
> > +++ b/net/core/bpf_ksock.c
> > @@ -73,16 +64,6 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
> >  	struct bpf_ksock *ks;
> >  	int err;
> >  
> > -	/*
> > -	 * sock_create() derives the network namespace, credentials, and cgroup
> > -	 * from current. Kernel threads, including BPF workqueue callbacks, do
> > -	 * not carry the context of the task that invoked the BPF program.
> > -	 */
> > -	if (!bpf_ksock_has_user_task_context()) {
> > -		err = -EOPNOTSUPP;
> > -		goto err_out;
> > -	}
> > -
> 
> [Severity: High]
> Does removing this check expose us to a NULL pointer dereference during task
> exit?
> 
> If a sleepable BPF program running via task_work during do_exit() calls
> bpf_ksock_create() after exit_nsproxy_namespaces() has cleared
> current->nsproxy, it appears this could trigger a kernel panic.
> 
> Without the bpf_ksock_has_user_task_context() guard, bpf_ksock_create() will
> now unconditionally call sock_create():
> 
> net/socket.c:sock_create() {
> 	return __sock_create(current->nsproxy->net_ns, family, type, protocol, res, 0);
> }
> 
> Is it safe to allow sock_create() to dereference current->nsproxy here without
> checking if it is NULL?

Indeed, in do_exit(), it seems we have this ordering:

	exit_nsproxy_namespaces(tsk);
	exit_task_work(tsk);

The first line will put nsproxy to NULL and the second will schedule any
remaining work and call the bpf callback set up with the wq. So this is
valid.

The fix would be to add some NULL check to prevent the panic in this
specific case (or see the next point).

> 
> [Severity: High]
> Additionally, does this change allow containerized workloads to escape their
> network namespace?
> 
> When bpf_ksock_create() is invoked from a workqueue callback, the executing
> context is a kthread.
> 
> Because sock_create() uses current->nsproxy->net_ns, a kthread will resolve
> this to the host namespace (init_net), causing the socket to be created in the
> host namespace rather than the container's netns.
> 
> Could this allow BPF programs inside containers to bypass container routing
> and firewall policies by creating host-namespace sockets?

Also agree, maybe socket creation should still be behind the check, I
think it's still useful to be able to connect and send from a workqueue
but preventing to create via workqueues might be a good limitation.

Let me send a v2 with create still using the runtime check, that should
fix this and the above issue.

> 
> >  	if (!opts || opts__sz != sizeof(struct bpf_ksock_create_opts)) {
> >  		err = -EINVAL;
> >  		goto err_out;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261013163101.205638-1-mahe.tardy@gmail.com?part=1
