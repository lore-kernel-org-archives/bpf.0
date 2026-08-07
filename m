Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4131A238F;
	Fri,  7 Aug 2026 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126312; cv=none; b=FSDYxqGd9fmY8HkiffGCHjPqAnBvbeHAkyG3A+I5vGVzHmMHOZyywsMPegMMz/Zyz1YRYTUyxYxeoOUr9MayQrLNC9WRIMkcSuf8dbU8rEOjByrhGuZzCwzMX12vYiD+iVm1T98LjypPHAxhcXLAVzZ/8sXYu/xiV2zIYG4IV7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126312; c=relaxed/simple;
	bh=ZSW5AEalbuQC057fVffBfKe+krjNcLDAy9fh3ffgLO0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MZiLpX7sOMBHEkj/dl42eR2NozSQJKhtTRDk3bO//ht67H34S1qbo/0LMmPm0pfYT3dAWiYwcRe04C4rmC5Rtqk5rrBO7qwsbP5Kr/gj/38NoQH6S3lK1QRvKxjTx6gjjMVvle8dufI0fInMJW9zBFG9ywsmulJeq+dcylI38DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NViKPaao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NViKPaao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3931F000E9;
	Fri,  7 Aug 2026 18:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786126311;
	bh=nay5RC2CHfuLl3chelYXkbTUlw4S/GT/LRVPuNblyrY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NViKPaaoSdSQ0hl6zFKLMattFtKsEWaYu66/gys/+vTsJE+vL/wl02iNyok5LBmWJ
	 rNVYeSfRPbT/Q0PhyfBwhMin+lKkd3tMUqv/rVYS4gNkjcmGg67DwqDYK2K8OkQ9tg
	 IJK0lIg2yyKKsDhlbIJlP9iWzI2KbBjuLlhvtCdDaUNqtaHSGqd0ZeGzABsMDjKp77
	 xyJVN+1nHATSV048gbPXDCz9vQkRjtArDsoyUtSX9MV7WXFvZ1/NwX3ZroPYI++YwI
	 Lbjp95qJ/3+lL9KUD4WwjO9g23raJGHmSgcz8Q3x9kSWbkKO2dsoHAXCMZFasZsmhv
	 WcDrFv0zTQKfg==
Content-Type: multipart/mixed; boundary="===============2622278696798544287=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bbfbdee48bdf4ff655479e02a00828655b8dc1580c321feb46bfbb864e46dff7@mail.kernel.org>
In-Reply-To: <20260807171532.125149-2-mahe.tardy@gmail.com>
References: <20260807171532.125149-2-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/5] net: Add connect_socket() helper
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 18:11:50 +0000 (UTC)

--===============2622278696798544287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index 2a8d7b14f1d1..5a5eb1250103 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -461,6 +461,8 @@ extern struct file *__sys_socket_file(int family, int type, int protocol);
>  extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
>  extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
>  			     int addrlen);
> +int connect_socket(struct socket *sock, struct sockaddr_storage *addr,
> +		   int addrlen, int flags);
>  extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
>  			      int addrlen, int file_flags);
>  extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
> diff --git a/net/socket.c b/net/socket.c
> index 63c69a0fa74e..8f18f124d92a 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2103,6 +2103,20 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
>  	return __sys_accept4(fd, upeer_sockaddr, upeer_addrlen, 0);
>  }
>
> +int connect_socket(struct socket *sock, struct sockaddr_storage *address,
> +		   int addrlen, int flags)
> +{

This isn't a bug, but would a name closer to the neighbouring helpers,
such as __sys_connect_socket(), read better here? The equivalent
socket-level helpers in the same file follow the __sys_<op>_socket() or
__sys_<op>_sock() shape (__sys_bind_socket(), __sys_listen_socket(),
__sys_shutdown_sock()), and the declaration is added in the middle of
that same helpers block in include/linux/socket.h. Also, net/socket.c
already has kernel_connect(), which performs the same
READ_ONCE(sock->ops)->connect() dispatch and differs only in not calling
the LSM hook, so the two names don't signal which one a caller should
pick. Could a short comment note how it differs from kernel_connect()?

> +	int err;
> +
> +	err = security_socket_connect(sock, (struct sockaddr *)address, addrlen);
> +	if (err)
> +		return err;
> +
> +	return READ_ONCE(sock->ops)->connect(sock,
> +				    (struct sockaddr_unsized *)address,
> +				    addrlen, flags);
> +}
> +
>  /*
>   *	Attempt to connect to a socket with the server address.  The address
>   *	is in user space so we verify it is OK and move it to kernel space.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31202489240
--===============2622278696798544287==--
