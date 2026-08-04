Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB16481666;
	Tue,  4 Aug 2026 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865838; cv=none; b=oZEFOoDkhmi6OPDRTBzZIsLFGfdVd4x605xjHbjDlyeP4Nl3yG2Qh5iUdYK+XXXT3aISPjddju19qASQpFigNQAiw4KWywhdhzrw+PQ3p8nLIHf27Bqt+FhTB0WfAYM5m7KOClMXy0tmhCk5aTRMvFvS5+luplALCwzwTsS8Jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865838; c=relaxed/simple;
	bh=e9a/7Oqz7GBGN+eJw9yuf/3sL88FM5sLM8T82AVBfSI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=avSvj6TPsjoXwCC32dndEN29d9O+4ode3sWvQhzv9ry9A9LQ/eHWRyVeIxrHpOoktbRCucOaYmFkmRAjCcaaxTVN+FedmjRcGZLGNELz90c1iv5juXjRMfda3UtnH5yPqCooDeXUIdp9XeOJmbsYzH8ngBurFuOfrnq9MKtXhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT9WAsmM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT9WAsmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A60F1F00A3D;
	Tue,  4 Aug 2026 17:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785865833;
	bh=TaUAjSJm0qoKI37sVpsfjlEefZNyhINpuwSXJvVo2G4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UT9WAsmMRCSjGVHwf5W6eYhmPDqCCiPM+DenQmo5nYmXTdSMyKo8nKRsBznbC4F2Q
	 1BbMgydNH/ekjHYVRD1qwgX1Ew2UejWfc3a0H8XQTqUyxurnWz86HZxHWfPiYbe9Im
	 mnGskZEBwnC7qk1+o9R/jECox2ocdPzwB061m9UT4mOfOLCUpKpXUl+jCa+u7EwXkC
	 DD5rG7vNNdy8grHn+ZmgH7wCb45wd4aC2p4DTjpVvIeiWvJ+YTHgH5++pX5oQhXUva
	 L5NZCishhurZsQOQJnMBLa3RYSofxDAKMj0akUGFRSFijN7MnECzFxMpgRoeDXwK+j
	 7Y5RdVW3J+rYQ==
Content-Type: multipart/mixed; boundary="===============0033367096857308003=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <be51310236705738f5be0b63a0709a8af33c1f20b6d8994449f082ca6d371f01@mail.kernel.org>
In-Reply-To: <20260804164652.296919-2-mahe.tardy@gmail.com>
References: <20260804164652.296919-2-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] net: Add __sys_connect_socket() helper
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Aug 2026 17:50:32 +0000 (UTC)

--===============0033367096857308003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/socket.c b/net/socket.c
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2115,27 +2115,31 @@ SYSCALL_DEFINE3(accept, int, fd, struct sockaddr __user *, upeer_sockaddr,
>  *	include the -EINPROGRESS status for such sockets.
>  */
>
> +int __sys_connect_socket(struct socket *sock, struct sockaddr_storage *address,
> +			 int addrlen, int flags)
> +{

This isn't a bug, but now that __sys_connect_socket() sits directly
under this comment block, would it read better to keep the comment
attached to the function that actually copies the address in from user
space? The first paragraph mentions "The address is in user space so we
verify it is OK and move it to kernel space," but __sys_connect_socket()
takes an already-copied struct sockaddr_storage pointer. That user-copy
step now lives in __sys_connect() via move_addr_to_kernel().

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
>  int __sys_connect_file(struct file *file, struct sockaddr_storage *address,
>  		       int addrlen, int file_flags)
>  {
>  	struct socket *sock;
> -	int err;
>
>  	sock = sock_from_file(file);
> -	if (!sock) {
> -		err = -ENOTSOCK;
> -		goto out;
> -	}
> +	if (!sock)
> +		return -ENOTSOCK;
>
> -	err =
> -	    security_socket_connect(sock, (struct sockaddr *)address, addrlen);
> -	if (err)
> -		goto out;
> -
> -	err = READ_ONCE(sock->ops)->connect(sock, (struct sockaddr_unsized *)address,
> -					    addrlen, sock->file->f_flags | file_flags);
> -out:
> -	return err;
> +	return __sys_connect_socket(sock, address, addrlen,
> +				    sock->file->f_flags | file_flags);
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30931766736
--===============0033367096857308003==--
