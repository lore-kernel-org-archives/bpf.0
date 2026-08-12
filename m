Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D1456DE8;
	Wed, 12 Aug 2026 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556347; cv=none; b=Bw/jjzhFBbVd9djAAS+uExVqRfaTsIutMWrpT8DAZppP+bta8Nb3jTB/QOhLwwoYKRedzXCZGFcb4S4ihB4+zPR8gjVPKa2wT8TgzMbaqSGklWkZr6GaYVUrKQNBJGgsOf5TPvRzFqTapnk2MADVrTLrVtle59BghqIugz9frUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556347; c=relaxed/simple;
	bh=QJF/BFi5EZyW0qI+YYuUl2wtS6ZYEGk+zxuBAVVDU58=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DpG6GOJrprmBf4H7U17oi6glRaEU+HAfea5YvEmYvRu0/dI0j+4wJPbFXtrKZ8Wl8XZPyD9Pr7LL2sCGW1/N+W/is+launJTIH+vXkcJ8ZWiZ68yuN2+V2apRFN39yYE4DY5TbdAHb0TysvqjgThW7+IAskuJ6PK/2XuJqFuU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI1TXLeG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI1TXLeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280461F000E9;
	Wed, 12 Aug 2026 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556346;
	bh=WUUenJUUqyvTinuyhJ3k7pC3cHhJzKTCrp5eiekfCAY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VI1TXLeG78LNyT+8fZZQXZf5Z/AiNOZIiAn0UQGkDS2lBmCdBuDa/Y0Bi//Ag90wu
	 6yYM7MOUk2G/3DKKPSD6AoVcPgA2CQ+x7ioh9Ck9ksoqtXy6/W7QLpfV8nBQSO/o3A
	 /KDlMxckf/g0byrMCmPU/6sCYMza+B+Lrwe/ZD37Dg6oHLnGm6c1tojbd/zciAatmr
	 qj7k4hGJmtxxTK42HGaUX0i2nupU/s5iGoOEbpAU+RmybjYbifIRwtSJIwBUSFsPKI
	 2hx45VL4b/us3tj3hyla4nIhPlss202GkzjxC1aHrhYiw5ZgMKvGnUB3Wa1Z8abXtf
	 BMNOqIPuVp4Rg==
Content-Type: multipart/mixed; boundary="===============9198130356862027984=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bfa71c9ba8543efcd226101c79e3de51aa6531f56ca0874c7239f1567e1f457b@mail.kernel.org>
In-Reply-To: <20260812154328.72834-3-mahe.tardy@gmail.com>
References: <20260812154328.72834-3-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/5] bpf: Add ksock kfuncs
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,ameryhung@gmail.com,kuniyu@google.com,memxor@gmail.com,jiayuan.chen@linux.dev,mahe.tardy@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 17:39:05 +0000 (UTC)

--===============9198130356862027984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/Makefile b/net/core/Makefile
> index b3fdcb4e355fa..a9295b7859010 100644
> --- a/net/core/Makefile
> +++ b/net/core/Makefile
> @@ -44,6 +44,9 @@ obj-$(CONFIG_FAILOVER) += failover.o
>  obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
>  obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
> +ifneq ($(CONFIG_INET),)
> +obj-$(CONFIG_BPF_SYSCALL) += bpf_ksock.o
> +endif
>  obj-$(CONFIG_OF)	+= of_net.o
>  obj-$(CONFIG_NET_TEST) += net_test.o
>  obj-$(CONFIG_NET_DEVMEM) += devmem.o

This isn't a bug, but would 'ifdef CONFIG_INET' be preferable here to
match the rest of net/? There are zero occurrences of 'ifneq
($(CONFIG_...),)' and fourteen occurrences of 'ifdef CONFIG_...' across
net/**/Makefile, and this is the only conditional block in
net/core/Makefile.

> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> new file mode 100644
> index 0000000000000..d65200679b65d
> --- /dev/null
> +++ b/net/core/bpf_ksock.c

[ ... ]

> +/**
> + * bpf_ksock_connect() - Connect a BPF kernel socket to a remote address.
> + * @ks:		The BPF kernel socket context.
> + * @addr:	Pointer to an IPv4 or IPv6 socket address.
> + * @addr__sz:	Size of the address union.
> + *
> + * Connects the socket to the specified remote address and port.
> + *
> + * This function may sleep while connecting the socket, so it can only be used
> + * in sleepable BPF programs (SYSCALL).
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_connect(struct bpf_ksock *ks,
> +				  const union bpf_ksock_addr *addr,
> +				  u32 addr__sz)
> +{
> +	struct sockaddr_storage sa;
> +	int addrlen;
> +
> +	if (!bpf_ksock_has_user_task_context())
> +		return -EOPNOTSUPP;
> +
> +	if (!addr || addr__sz != sizeof(*addr))
> +		return -EINVAL;
> +
> +	/* Kfunc memory arguments may be unaligned. */
> +	memcpy(&sa, addr, sizeof(*addr));
> +
> +	switch (sa.ss_family) {
> +	case AF_INET:
> +		addrlen = sizeof(struct sockaddr_in);
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		addrlen = sizeof(struct sockaddr_in6);
> +		break;
> +#endif
> +	default:
> +		return -EAFNOSUPPORT;
> +	}
> +
> +	return connect_socket(ks->sock, &sa, addrlen, 0);
> +}

This isn't a bug, but could the #if IS_ENABLED(CONFIG_IPV6) guard be
dropped? struct sockaddr_in6 is defined unconditionally in
include/uapi/linux/in6.h, and union bpf_ksock_addr in the new header
already references it without a guard. bpf_ksock_create() accepts
opts_copy.family == AF_INET6 unconditionally and relies on sock_create()
to return -EAFNOSUPPORT when IPv6 is not built. With CONFIG_IPV6=n, the
net effect is identical (-EAFNOSUPPORT either way), so dropping the guard
would make bpf_ksock_connect() and bpf_ksock_create() validate families
the same way.

[ ... ]

> +/**
> + * bpf_ksock_send() - Send data through a BPF kernel socket.
> + * @ks:		The BPF kernel socket context. Must be an acquired reference.
> + * @data:	Pointer to the data to send.
> + * @data__sz:	Size of the data to send (max 65535 bytes).
> + *
> + * Sends data on a connected socket, best-effort and nonblocking. This may sleep
> + * (kernel_sendmsg), so it can only be called from sleepable BPF programs.
> + *
> + * Return: Number of bytes sent on success, negative errno on error.
> + */
> +__bpf_kfunc int bpf_ksock_send(struct bpf_ksock *ks, const void *data,
> +			       u32 data__sz)
> +{
> +	struct msghdr msg = {
> +		.msg_flags = MSG_DONTWAIT,
> +	};
> +	struct kvec iov = {
> +		.iov_base = (void *)data,
> +		.iov_len = data__sz,
> +	};
> +	int ret;
> +
> +	if (!bpf_ksock_has_user_task_context())
> +		return -EOPNOTSUPP;
> +
> +	/* Early check for UDP. Exact limits enforced by kernel_sendmsg(). */
> +	if (data__sz > IP_MAX_MTU)
> +		return -EMSGSIZE;
> +
> +	ret = kernel_sendmsg(ks->sock, &msg, &iov, 1, data__sz);
> +
> +	return ret;
> +}

This isn't a bug, but is the 64K cap intentional for AF_INET6 sockets?
The early size check uses IP_MAX_MTU, an IPv4-specific constant (0xFFFF),
even though bpf_ksock_create() also accepts AF_INET6. udp_sendmsg()
rejects len > 0xFFFF so the bound matches exactly for IPv4, but
udpv6_sendmsg() allows up to INT_MAX - sizeof(struct udphdr), so AF_INET6
sockets are silently capped at 64K by this kfunc rather than by the
protocol. Also, should the comment say udp_sendmsg()/udpv6_sendmsg()
instead of kernel_sendmsg()? kernel_sendmsg() performs no length
validation - the limits come from udp_sendmsg()/udpv6_sendmsg() and
ip_append_data().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31618864886
--===============9198130356862027984==--
