Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6C3570B1
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813278; cv=none; b=fY7g0StN7hEZ0lL4QvmcjgjnPt64M2DH5V7yfsXCfCbhCQmxi3L/65hlDGPH8eJo3+KFteFS+vdTpqaGMttfVgendY1wU1WXHyOZnu3liRknxmbaPv7B82OTGpXmv+0MFw+SmMZPyGuvDUhTiYcMYWQc73wJHW66UmB6ZJzXBzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813278; c=relaxed/simple;
	bh=KcUQ1q2ALIp6GQbsuyiFX7GWULQTAiWrMXNKUDp6gDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AScXSkQJ6Wqfe8BLJhekkuKTYT0wF3j4XibFx8imk9A3JyiJo+VDIk7C3VhuJLA83Ty1/mmXZ5AQdAbONYtrpKhIEC5osNC6OX7nMNDETj5gZBVHBMGlSHB4ZSrP9RIcyKZ4cQiKCP89IIFQRqbufOs8v/zW4xJMsEqB5qPXmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kd8bVprN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kd8bVprN"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b76844f89so2428557e87.1
        for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 14:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769813275; x=1770418075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkVCe2Fm0X1zwm2m79SvkIhPjHfte2ufPAVZoEONEas=;
        b=Kd8bVprNS+PU2+IyvcIQf/vxg6q/qdpShs2y9fajVXAYcuEyVMrT9xIFdAAOCgODJU
         GibFCGveSCmr6hpVKDV1+ESy1h5B8ZWRFThsswlC0nfd6slbMKTvzbAykY5DmvBXoi6T
         9yEhgeBG0kjReQMjVR3u+8mXSawcBTg3v6IJTgMqcBwGS+lGDqWuHCFss6UVXU/epxvT
         rP9dwbQ/Yh2GpsXz4rk9xkoNyLQbM2oelMXuh4oWQERvVtNIl4Hi6St3LA40kmGUj8/C
         Bho4ZytAs5WMgOVSJJO8/4mLwPT/OXmVMG4nAOBNVdIzqw4iq/OiN5x0YQa9mdJjvq76
         XMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769813275; x=1770418075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZkVCe2Fm0X1zwm2m79SvkIhPjHfte2ufPAVZoEONEas=;
        b=PTtWXXVXoJxDvC6PtwxC1wCmcnQo+FBQNQOFyJbnB5hn/pp0KGp7q0iue+aedYCy3L
         LZIqbEKXZIGAPTghkXVAqLQOPUuGG7HmoX0pxianfdFYQZrm5H/Qv6LuhmNS7Sy4ccUY
         QgFL4D8pTixu1QDfPOCju6Wp7BwenH40VXipX7ls6cMTopu5Ko9qGzWAfkUFg+iLp9x7
         NCk3syJQAXxS7WSJV2sV/Nf2ugfKkkayOx17drpQmp/t7I9HzYlezCpLHJow/ciGSgeL
         5PRHIOiun7DMOYJBqRFCocXr+MAXe89i6+Mmdv8dp+VCjsAQJzYyH0wdd5Ux553XKdm6
         8S8w==
X-Forwarded-Encrypted: i=1; AJvYcCUYvvDNs0jgjOot3xXH9ecsXjfhKrvbjskffAQKhlXaGXFOzt8PshjvMLkHiutepX1tE90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEw/0l9M0lxJ7FudoDHI4ZoSu+LUK1nfTX+9P17AoZDkUYUztV
	ffh2dGZ4LkaVkYAbindIAhuz5X9t5wX6OL0sBkXJZ27XDzQNdYh3OaJFREEm3A==
X-Gm-Gg: AZuq6aKdVN9okkM4E9tcLwJIglGyprYPHuby9vOek6zaxgBD5Rzem288EyRR2lI9Jgp
	evhlIBgj68vFGTPdRPVPmM+2UQyJY3LUgufmPMWGqt8LbStUR7SUZcKpJA2WVl0Pk/054/rJi8s
	vl0YlimjEdVZou2ntGwfabIiNY8kAHMLsOVh29xrB0D98WhKDN0yVvjA4oAFhyaHj5RPUc2yMZl
	1LxcIypkZFXCAnI0OXscu4vht43paCaCOtoIjdJJC60goJGm/Ah4L1hcDh8xVuPWDZLhwnUo/ri
	NZ5rvD6Zsl/jgyMrIB5KS/LP8byl/3HKD0qN5b0Ot/ABOQpr/OgP4XoSbbR+D6eR6feGt3x8Z1E
	4/ymXa/m2sjNAKDCcrL0Ssl8R1hXHU0evo7Ad2nilYQDcrwl0rCQJyeG/nUN7mrzUvySxC9F0NJ
	Ymepts39iz0PfsE4PQ68ekm622aoFz1Y0TmS2kJJSu6P0XUwg+6371
X-Received: by 2002:a05:6000:2004:b0:42f:b690:6788 with SMTP id ffacd0b85a97d-435f3a6baa6mr6239935f8f.10.1769806350269;
        Fri, 30 Jan 2026 12:52:30 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e267aad1sm21831845e9.15.2026.01.30.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 12:52:29 -0800 (PST)
Date: Fri, 30 Jan 2026 20:52:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 metze@samba.org, axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next RFC 0/3] net: move .getsockopt away from __user
 buffers
Message-ID: <20260130205227.6fb1d9ad@pumpkin>
In-Reply-To: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 10:46:16 -0800
Breno Leitao <leitao@debian.org> wrote:

> Currently, .getsockopt callback cannot be called with kernel buffers
> because it requires userspace addresses:
> 
>   int (*getsockopt)(struct socket *sock, int level,
> 		    int optname, char __user *optval, int __user *optlen);
> 
> This prevents kernel callers (io_uring, BPF, etc) from using getsockopt
> on levels other than SOL_SOCKET, since they pass kernel pointers rather
> than __user pointers.

I had thoughts about this as well.
I think using iov_iter is over the top and may have measurable performance
impact for some paths.

I think the first thing to do is sort out 'optlen'.
There is absolutely no reason for the user pointer being passed into
all the per-protocol functions.
(and the code that changes that use sockptr_t are just stupid...)
The system call wrapper can do the user copies, it can also suppress
the write if the value is unchanged (which matters with clac/slac).
The obvious change would be to pass the length itself and make the
return value -ERRNO or the size.

The annoyance is the few places that want to return an error and
change optlen.
That might be best addresses by something like:
#define GETSOCKOPT_RVAL(errval, size) (1 << 31 | (errval) << 20 | (size))
which would get picked in the rval < 0 path.
It would also let 'return 0' mean 'don't change the size' requiring
a special return for the one (or two?) places that want to set the
size to zero and return success.

The length passed should also be 'unsigned int' - with a check for
negative values in the system call wrapper.
(There are many broken drivers that treat negative lengths as 4.)

There is not much point making the 'optval' parameter more than
a structure of a user and kernel address - one of which will be NULL.
(This is safer than sockptr_t's discriminant union.)
You can't police the length because it is sometimes only the length
of a header (and in some recent code as well).

I have looked at some of this change - it is enormous.

	David


> 
> Following Linus' suggestion [0], this series introduces a wrapper
> around iov_iter (sockopt_t) and a temporary getsockopt_iter callback:
> 
>   typedef struct sockopt {
> 	  struct iov_iter iter;
> 	  int optlen;
>   } sockopt_t;
> 
> Note: optlen was not suggested by Linus' but I believe it is needed, given
> random values could be passed by protocols back to userspace.
> 
> And the callback becomes:
> 
>   int (*getsockopt_iter)(struct socket *sock, int level,
> 			 int optname, sockopt_t *opt);
> 
> The sockopt_t structure encapsulates:
> - An iov_iter for reading/writing option data (works with both user
>   and kernel buffers)
> - An optlen field for buffer size (input) and returned data size
>   (output)
> 
> The plan is to enable getsockopt to leverage kernel buffers initially,
> but then move .setsockopt from sockptr_t into this as well.
> 
> This series:
> 
>  1. Adds the sockopt_t type and getsockopt_iter callback to proto_ops
>  2. Adds do_sock_getsockopt_iter() helper that prefers getsockopt_iter
>  3. Converts one protocol (netlink) to use getsockopt_iter as a proof of
>     concept
> 
> This is what I have in mind for this work stream, to make it more
> digestible:
> 
>  * Keep the temporary getsockopt_iter callback allows protocols to
>    migrate gradually.
>  * Once all protocols have been converted, getsockopt can be removed and
>    getsockopt_iter renamed back to getsockopt with the new API.
>  * Once the protocols are converted, the SOL_SOCKET limitation in
>    io_uring_cmd_getsockopt() will be removed.
>  * Covert setsockopt() to also use a similar strategy, moving it away
>    from sockptr_t.
>  * Remove sockptr_t in the front end (do_sock_getsockopt(),
>    io_uring_cmd_getsockopt()) and start with sockopt_t (instead of
>    sockptr_t) in __sys_getsockopt() and io_uring_cmd_getsockopt()
> 
> Link: https://lore.kernel.org/all/CAHk-=whmzrO-BMU=uSVXbuoLi-3tJsO=0kHj1BCPBE3F2kVhTA@mail.gmail.com/ [0]
> ---
> Breno Leitao (3):
>       net: add getsockopt_iter callback to proto_ops
>       net: prefer getsockopt_iter in do_sock_getsockopt
>       netlink: convert to getsockopt_iter
> 
>  include/linux/net.h      | 19 +++++++++++++++++++
>  net/netlink/af_netlink.c | 22 ++++++++++++----------
>  net/socket.c             | 42 +++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 70 insertions(+), 13 deletions(-)
> ---
> base-commit: 4d310797262f0ddf129e76c2aad2b950adaf1fda
> change-id: 20260130-getsockopt-9f36625eedcb
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
> 

