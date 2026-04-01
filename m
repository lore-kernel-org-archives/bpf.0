Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEF139FCB1
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775061247; cv=none; b=SP3CZT0NvIFw+p0eIT16dJosTB4EW9h8DokCtgZnaYZbKrJ8vyl/emK0No3sNrmKJqzKCgMzQTyoRbSJpsmcox+m056aXWLWexW3yrcR0M8T5dfHnqZrw4211pgb7kCRPbmKlJkuN7Mm5SaqEjHplEt7xmSWschPxN3omAby0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775061247; c=relaxed/simple;
	bh=+OcjdzbsVS5n2WpHiH5AzE1B2okZQS9quvYX7YODvQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiX1QcmRrDespPkMcMs4g5pbQiIzdtVhiM/8xTf5EbpNH+AbjqN3rN3U3rVJgDsH7TI+UvPUcY1AEWl2/qcobTTRooNFCXgcMrThoUGBR4IKI89G51i4Ea/gT1Ff/YUYyPTAH+6aJD8yVR2ziNBQNfoqsAcLk7nk2JNs/oSII58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVZAsx50; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVZAsx50"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c87871133dso2726eec.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775061245; x=1775666045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdMpVTZuf6oWX3f0mlEuicX/hJ4K7vnvO6vekEBOAm0=;
        b=bVZAsx50sgRISknFsJkBzeV0zBAw/Td1rUgrckv4kS0tndO45oAUoyNzfq0iBHX56b
         mIRSSOaoVvcM2Xjb1jUm0o34D03dY7xyaRhiXKeBujDJ3C6FaoMMs9S7JQExVOqcBD4E
         sqgTRR8Bih3BuCjEACOhVzJ072pPZHP85/4XcBNSYdCkWtJ57r6OApIIIsukNcSaNeeU
         mN/qjEcNOHCCJAZZcrAuS0Jk/gtTlUhyDWp4VWXv2ySh0XEUJ4NWN1EEbK9fyvG8aJq0
         D6IQ3QWq2U5rqWk0ZpMmG+bNt8OF8lQfz9TxygSC4gcOlXxAOHsl9/teDY6dS8d4Yf3/
         NuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775061245; x=1775666045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdMpVTZuf6oWX3f0mlEuicX/hJ4K7vnvO6vekEBOAm0=;
        b=ZqcTRUxvmaiqGv+RFxrMAjLpCEeByi8uR0Fz3xowX40N8vlhpcvXklUP2D1r22sFXE
         qsiB1wlh38EiSjcaaoFI5CZwOIF6pQ35q/trU+wiu7IdGPd0Kzxag9e/fW47z2KlxbJb
         rgXPKN+W4nBQGHse3zsQPOZJDW0hFL8YlVVt+qa2s99U1ekSBEshKuUq+p/rUXob4Kxp
         iiRLQTYQw9TrQk78DG6x6rboLxC4genhvQPJhIKrQ8E4jUB31svGuryw14pnKOpf8nRo
         Jlj/R5H4i1EIf4Sq1t6Nl52a+SQp6adE4sI2CMRCCAuXfwIt62xx9McL0YqGGd94Iv5r
         2dLA==
X-Forwarded-Encrypted: i=1; AJvYcCW6UM4BBgjf+o/8oCAodq1LBIPMgLoEFrgFMvILZVLOutIzmDnYlIXJuYwV5ceyiM2FpYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfB+4Pz2/N2Cfw2leC/tZF1JpgcCiq0dSHbtJ//YtkenMrWtXr
	Mr+4bf428Fi+H+pNs3dWituWx+ucX/7lT5EKODmCf0pEz9j13YhW6yM=
X-Gm-Gg: ATEYQzyex3/kqdi5tzL/29bR+znZxcerDCqsjshb7a898CViSt7grTcylOAVxi84TgF
	R2fobu37A71pQ97weEcn6XaySAFFTQv5P68kN+hvC6CXbijzQVZk4l1gW8SFyhFBWbloDiyYpBx
	MmeoxPNys/noGwpmKPwSRwPa0Dje+pyXJw9Kaj+Ww0wbn8Jppo4SIVnTyz1BmbwfvL6ctHk1QRY
	2Q+V9+N452+nR0haxsO/7VC0UCFKwp6kOEBYLsizzRvzBcMN+F5EXubgea9GFikVlf5rSjk/d6y
	epF/dp3TiZ9PDygraLsUKAYwLeBGZxQbeNlcHnKA05p87+6jZy1t3j/GHr8snfIDBQd3UhZRwrX
	kSlw3fiiY6/atK8I1f3O45WqhVB0nhbBYkRVFa83PMgeI90d3LZmNSd43j1F+XrUCnIO3IY/QyI
	B7jHQMvf2ogSNIYLLLSfblzuBxqJo7Fwms1UfagwRPUT6apRtKaZqXumw/vxQH7vWDDYphAQIpZ
	DpQd833MIDq4KhRIMlcahUoE/Rk
X-Received: by 2002:a05:7300:fd13:b0:2c1:161f:ac39 with SMTP id 5a478bee46e88-2c9325b1fddmr2057364eec.26.1775061244975;
        Wed, 01 Apr 2026 09:34:04 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7c3010e9sm237887eec.14.2026.04.01.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:34:04 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:34:04 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>, metze@samba.org,
	axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
	io-uring@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/4] net: call getsockopt_iter if available
Message-ID: <ac1I_CMr43XTpvHj@mini-arch>
References: <20260401-getsockopt-v2-0-611df6771aff@debian.org>
 <20260401-getsockopt-v2-2-611df6771aff@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401-getsockopt-v2-2-611df6771aff@debian.org>

On 04/01, Breno Leitao wrote:
> Update do_sock_getsockopt() to use the new getsockopt_iter callback
> when available. Add do_sock_getsockopt_iter() helper that:
> 
> 1. Reads optlen from user/kernel space
> 2. Initializes a sockopt_t with the appropriate iov_iter (kvec for
>    kernel, ubuf for user buffers) and sets opt.optlen
> 3. Calls the protocol's getsockopt_iter callback
> 4. Writes opt.optlen back to user/kernel space
> 
> The optlen is always written back, even on failure. Some protocols
> (e.g. CAN raw) return -ERANGE and set optlen to the required buffer
> size so userspace knows how much to allocate.
> 
> The callback is responsible for setting opt.optlen to indicate the
> returned data size.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/socket.c | 48 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index ade2ff5845a0..4a74a4aa1bb4 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -77,6 +77,7 @@
>  #include <linux/mount.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/security.h>
> +#include <linux/uio.h>
>  #include <linux/syscalls.h>
>  #include <linux/compat.h>
>  #include <linux/kmod.h>
> @@ -2349,6 +2350,44 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
>  INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
>  							 int optname));
>  
> +static int do_sock_getsockopt_iter(struct socket *sock,
> +				   const struct proto_ops *ops, int level,
> +				   int optname, sockptr_t optval,
> +				   sockptr_t optlen)

If we want to eventually remove sockptr_t, why not make this new handler
work with iov_iters from the beginning? The callers can have some new temporary
sockptr_to_iter() or something?

> +{
> +	struct kvec kvec;
> +	sockopt_t opt;
> +	int koptlen;
> +	int err;
> +
> +	if (copy_from_sockptr(&koptlen, optlen, sizeof(int)))
> +		return -EFAULT;
> +
> +	if (optval.is_kernel) {
> +		kvec.iov_base = optval.kernel;
> +		kvec.iov_len = koptlen;
> +		iov_iter_kvec(&opt.iter, ITER_DEST, &kvec, 1, koptlen);
> +	} else {
> +		iov_iter_ubuf(&opt.iter, ITER_DEST, optval.user, koptlen);
> +	}
> +	opt.optlen = koptlen;
> +
> +	/* iter is initialized as ITER_DEST. Callbacks that need to read
> +	 * from optval (e.g. PACKET_HDRLEN) must flip data_source to
> +	 * ITER_SOURCE, then restore ITER_DEST before writing back.
> +	 */

Have you considered creating two iters? opt.iter_in and opt.iter_out.
That way you don't have to flip the source back and forth in the
handlers.
