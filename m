Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694736;
	b=KgkXJof7mm90Km3dkWFMueoyXS69uVOZqA/BvBivgrva8BjxUWVTKkGe2QKU9oM1B7Pj
	 lAjpcgvrVJzNSvkM8bDCWX9PyXt0WDitV7tWzB0eyfZ4XKiF6kgEyhj5zGH29mpDg4p/b
	 SVohUomZv131C9amOuvb9MeYgW1bJ492Elg8ghcUQLcPNHwV2LxOJJGO+JMGuwOntwlIp
	 CCtbLG7RzfsceUEJ1NmcpzRxB4iPRMnCotIe5GoM1TCEunDU2tFu40pclvOeXbJtjzt37
	 3+adywQMuI0FtvgGiXZML8L/CjVRMJpzPcyUJ5C25Owsfjbq95GXtv9KSumK6R+UV1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694736;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=G28HEn/VXJld9jkYtD/8yZsBEWZtFggug0SssZsruNY=;
	b=SkJ7jvtaAc21WN8/3HMuTi2IS8qvPShY29amGl3DkOHMqxSBhbzoDOmAkOtbPTas+tIN
	 Tl8+rBVKmnt5o7Me1QwJmr8aRUFVKLN5cjjcLzEOhJDjoObRFM9Q63fJPOY9tO2OUVOAJ
	 lwdKk3wu16F6XO9lHQeERm7Akk5AvywnthURq3re0mVANKLrT8SlHDJ1Fpke291d7CX51
	 hisj0e8tkjS4JZe6zwBouj83Ul7qpAGBPIMyBEMtJ6kUO5W3w+4QYkNpidfeWAjc3Cu9m
	 TdlpXAFsez7OU6x1/X4+IS9/vOcdXYofDBhOIaMMCQGH9DpEXNzE8ylB4JJbfPi8nmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9U6yV6z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1F6606A31B;
	Thu, 22 Oct 2026 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9U6yV6z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AE81F01825;
	Thu, 22 Oct 2026 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694735;
	bh=G28HEn/VXJld9jkYtD/8yZsBEWZtFggug0SssZsruNY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=h9U6yV6zctGDT2s7FTFQvlXT/pcrtKGrr/d4BaOX6gvREBJ3jce3VwauedN+iElUr
	 tyEFBos984982QJRYf+xj2sjb6P8y6x+9gaF+wu5KkN4cxDjtuMAdn4PaMYOfyX1/h
	 ZVZ23TPw4t7+QHQkEtu1NUYWFjqJ+zqRP+E04PeX5idWkGqsWLaa6ybUAQt4IWAmOv
	 12qZhnJomhUI8ZwysUlQBoTvipZUaP84fHOD/aYkVPiaFh7neTBZBdVqf7aDgHrllV
	 r1iDHHQ4+RFuNSs0muMfpGboKIaSQvnsAdJrVLljYVkHGIEJtBCgDasmd0rZa26LLe
	 Lz5caL7PrK9Kw==
Content-Type: multipart/mixed; boundary="===============8279392703451209759=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e31194dd72efd3c182707e870b7e7a6d67b78be23cea06aded0275678373c64c@mail.kernel.org>
In-Reply-To: <20261022181620.247201-1-mahe.tardy@gmail.com>
References: <20261022181620.247201-1-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_ksock_bind() kfunc
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,willemb@google.com,eddyz87@gmail.com,edumazet@google.com,john.fastabend@gmail.com,kuba@kernel.org,horms@kernel.org,liamwisehart@meta.com,martin.lau@linux.dev,pabeni@redhat.com,song@kernel.org,netdev@vger.kernel.org,sdf.kernel@gmail.com,yonghong.song@linux.dev,jolsa@kernel.org,kuniyu@google.com,memxor@gmail.com,emil@etsalapatis.com,almagui@kernel.org,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 18:45:34 +0000 (UTC)

--===============8279392703451209759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_ksock_bind() kfunc

TL;DR: bpf_ksock_bind() called from a bpf_wq callback runs with kworker's full
capabilities, so a CAP_BPF-only SYSCALL program may bypass the privileged-port
(CAP_NET_BIND_SERVICE) check; the review asks whether to block it.

> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> index 37168f43c16c..c7b487d90cd0 100644
> --- a/net/core/bpf_ksock.c
> +++ b/net/core/bpf_ksock.c

[ ... ]

> @@ -178,6 +178,33 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
>  	return NULL;
>  }
>
> +/**
> + * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.

[ ... ]

> +__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
> +			       const union bpf_ksock_addr *addr, u32 addr__sz)
> +{
> +	struct sockaddr_storage sa;
> +	int addrlen;
> +
> +	addrlen = bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
> +	if (addrlen < 0)
> +		return addrlen;
> +
> +	return __sys_bind_socket(ks->sock, &sa, addrlen);
> +}
> +

Can the CAP_NET_BIND_SERVICE check for privileged ports be bypassed when
this runs from a bpf_wq callback?

bpf_ksock_bind() is added to ksock_init_kfunc_btf_ids, the same set as
bpf_ksock_connect().  Commit 60bbe76a3f9e ("bpf: Allow ksock connect/send
calls from wq") made the kfuncs in this set callable from bpf_wq callbacks
of SYSCALL programs, and tools/testing/selftests/bpf/progs/ksock_wq.c
already calls bpf_ksock_connect() from such a callback.

bpf_wq_work() runs that callback in a kworker, where current->cred is
init_cred with cap_effective set to CAP_FULL_SET (see init/init_task.c).

The bind path is:

  bpf_ksock_bind()
    __sys_bind_socket()
      security_socket_bind()
      inet_bind() -> inet_bind_sk() -> __inet_bind()

and __inet_bind() then does:

    snum = ntohs(addr->sin_port);
    err = -EACCES;
    if (!(flags & BIND_NO_CAP_NET_BIND_SERVICE) &&
        snum && inet_port_requires_bind_service(net, snum) &&
        !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE))
            goto out;

__inet6_bind() has the same check.  With init_cred, cap_capable_helper()
walks up to init_user_ns and finds the capability raised, so the check
passes for any netns.

For example, a task holding only CAP_BPF can load a SYSCALL program, since
is_net_admin_prog_type() does not ask for CAP_NET_ADMIN for that type.
Such a program could bind its ksock to UDP port 53, 123 or 514 from a wq
callback, while the same call made synchronously from the SYSCALL program
returns -EACCES.  A bpf_task_work callback looks like it has the same
problem in a different form, since the check would be evaluated against
whichever task the work was scheduled on.

Commit 60bbe76a3f9e only argued about LSM checks ("bypassing LSM checks for
BPF-created sockets could be acceptable"), and connect and send on a UDP
ksock have no capability gate.  bind appears to be the first ksock
operation that does, and the commit message does not address the wq
context.

Should bpf_ksock_bind() refuse to run from kthread context, the way
bpf_ksock_create() does with its PF_KTHREAD check?  Alternatively, should
it be kept out of the set that is reachable from wq callbacks, or should
the commit message state that bypassing the privileged-port check is
intended?

No fix for this was found in the provided range; 76406b1f799f
("selftests/bpf: Test bpf_ksock_bind() kfunc") only adds tests.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39831790314
--===============8279392703451209759==--
