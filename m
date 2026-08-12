Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8940B108
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530300; cv=none; b=i6vXbugA6EUuzYWMGgaB/0jvKIhBPla6weihFic947mCrQkc0ev6y862Dyy/gHVLFsRspRZ9YdbmwmoXXb44h9+8BiuoHgtmj7B3w+Galg0IOiG17Fs4h/0wmTZsafZe3MMxO0Xob/jNUmF2Ih7KrKqBaijknfgsWZr9+Dlpsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530300; c=relaxed/simple;
	bh=Qp+y/SeSG/kpHWEx+TYjHQ+d/h1+AxCCoDwBmzms+CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oygwQi9z+aS+XW3EzFaGJYAD1Seaghv5L1IsJDccfFdlwn090/fE35mh5e/7nFDctmSqjYVdx+Ysv6dzSQi3XWnzQbLyKHyzA3jIXv/GCEk0RAt/c83qJQMd04uXNiez4MycCZVhz5VAA11m2VaA6QcR92lV1MAc8CLTuksX/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY96yvK7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY96yvK7"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso7742385e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786530297; x=1787135097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x5cpP0HL/qqPELpuQ7nAOZNoj6U9tHfxyp0fJqorhyI=;
        b=TY96yvK7Csdii1eXvyZ98J1f/tFXr9Cg/MoPVXKQHWcXqzjJo/HZu9rXAt9jalr7mW
         aC38s5EO+JG78OeV2zXjOJHBVtc/SusWOoiwXFW9GaLTd9XR4InWKO6i64yqyTCgpUPV
         wuqhbLWQiA39sweFceM2hJTp18pqjtnfaKiL85z4PerIErm5cYZxijrBJmGD44Rc108z
         /olfPoaOr1UW3tjZ6n5MDoUp5sjJI1dCTzpPV11cN+Qxf1BIwE5BjnFMolUDzOJJVybr
         gyxywjPl7ggkEo8wUYIhGc8AH/hxyXoAGHeaSZBPCzrKYDKhE+fFQunf56ueLqalD8Tv
         tbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786530297; x=1787135097;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x5cpP0HL/qqPELpuQ7nAOZNoj6U9tHfxyp0fJqorhyI=;
        b=FokdOkOxbyAZpgmwckECDhtXytbu0/wNcF2quVagbt2NLgNTsX6kdbIZ2pbe9IXpTT
         33lOyFlyFZ+YMJOAzgfdnOshTRZWC9JiY6SYyGiRAB4mmDr5/oGLhLZ+MV+Tfs8WkP+p
         V4M6yX+AUMLRJYbHUQABdoelMSuCW/h/6pofo6DlS0cDX65irpDway2TuGdE1xpYsjbm
         FJuHkQ24RAru/0DKVKjUeDeqISLBtoHLs8uOz5CGh64Wj+e16agtXWy04xeLmrAV6MPe
         X3NQ/KMIwYECb7YAC5L+UXel7WaaWPr8/fNS1MDgRaA6cBuWBVMkGuFNRM8kmHgcOsZB
         R1wA==
X-Gm-Message-State: AOJu0YztGzUN/9yO4W9cSLLgMuLYc3NsSUNPcHQtTHvSkifhRngp4yH1
	ZFl3zzYtZ1b7UmS6OXbOshvMgyy67ZxTIC8kMKZ4ko/WSJhTfJrrlw3F
X-Gm-Gg: AR+sD11F5cory/U7gyFUNOOsKf5tOG3jc++TIY4cV1/wfjC1rU6iZBgqpjVoUeG0Crz
	Hy42DP2eLRtKUFQMUt/laDTwqnJrzh3JNUgi+wqLr7bq4lPq0YlIRZhYofP+otEJgsqYXntUBNj
	MijqRgmozkSIBTpK+AW1912rIBVKxbxBZRsZvWDa/lur+6otVgiKuKx21NJ5EyAFJTQAHOWmQo9
	wXjq6UErdzX5IR6ncxTp4xL+YBiW1ZazmUWy4SoY186hi7hU61SurzcZAdd9ztyx6A5cibwM0Am
	c11wkWHLCAe/KmoWKCBFdXjGv1BHQoSgIzZqdfonh2xa68mZRLi2lFjZ0JUOpBBe2yLQSQKFTma
	REInXO23FV3k2ah1bunDUZWIkNLytI1SqOWAFPXrVgCMzIFieo58nVmEbNkLRu4KS+hAoDddD7n
	kz/grTuIXHe/D7LM8icBU7ssuYjScfodGBPGhoUjnfiT/MrehZMrnX4c2igpVnMZm/dIIwU+QVN
	BAHymaWEd+kxgvEpqOw
X-Received: by 2002:a05:600c:4e87:b0:499:757f:a9ba with SMTP id 5b1f17b1804b1-4997c138c1bmr36155775e9.9.1786530296968;
        Wed, 12 Aug 2026 03:24:56 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997abf917csm72482195e9.13.2026.08.12.03.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:24:56 -0700 (PDT)
Date: Wed, 12 Aug 2026 12:24:54 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
	kuba@kernel.org, liamwisehart@meta.com, martin.lau@linux.dev,
	pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org,
	sdf.kernel@gmail.com, ameryhung@gmail.com, kuniyu@google.com,
	memxor@gmail.com, jiayuan.chen@linux.dev, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v5 1/5] net: Add connect_socket() helper
Message-ID: <anxJ9jHrut761-_M@gmail.com>
References: <20260807171532.125149-2-mahe.tardy@gmail.com>
 <bbfbdee48bdf4ff655479e02a00828655b8dc1580c321feb46bfbb864e46dff7@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbfbdee48bdf4ff655479e02a00828655b8dc1580c321feb46bfbb864e46dff7@mail.kernel.org>

On Fri, Aug 07, 2026 at 06:11:50PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index 2a8d7b14f1d1..5a5eb1250103 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
> >  extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
> >  extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
> >  			     int addrlen);
> > +int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> > +		   int addrlen, int flags);
> >  extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
> >  			      int addrlen, int file_flags);
> >  extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> > diff --git a/net/socket.c b/net/socket.c
> > index 63c69a0fa74e..8f18f124d92a 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
> >  	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
> >  }
> >
> > +int connect_socket(struct socket *sock, struct sockaddr_storage *address,
> > +		   int addrlen, int flags)
> > +{
> 
> This isn't a bug, but would a name closer to the neighbouring helpers,
> such as __sys_connect_socket(), read better here? The equivalent
> socket-level helpers in the same file follow the __sys_<op>_socket() or
> __sys_<op>_sock() shape (__sys_bind_socket(), __sys_listen_socket(),
> __sys_shutdown_sock()), and the declaration is added in the middle of
> that same helpers block in include/linux/socket.h. Also, net/socket.c

The __sys prefix was removed from this comment from Song[^1] which I
think makes sense instead of following the convention around.

[^1]: https://lore.kernel.org/bpf/CAPhsuW5ZTqfzpxNf=S6JbmGxWf2m9qPZGberdzRdLuvv2-Xwgw@mail.gmail.com/

> already has kernel_connect(), which performs the same
> READ_ONCE(sock->ops)->connect() dispatch and differs only in not calling
> the LSM hook, so the two names don't signal which one a caller should
> pick. Could a short comment note how it differs from kernel_connect()?

This is the whole point of this new function indeed.

> > +	int err;
> > +
> > +	err = security_socket_connect(sock, (struct sockaddr *)address, addrlen);
> > +	if (err)
> > +		return err;
> > +
> > +	return READ_ONCE(sock->ops)->connect(sock,
> > +				    (struct sockaddr_unsized *)address,
> > +				    addrlen, flags);
> > +}
> > +
> >  /*
> >   *	Attempt to connect to a socket with the server address.  The address
> >   *	is in user space so we verify it is OK and move it to kernel space.
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31202489240

