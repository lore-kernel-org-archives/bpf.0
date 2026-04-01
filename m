Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57C12CDA5
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060462; cv=none; b=rNP112W7wvo0N//fMsWGfwXSi7kqFIg9tLsvNcC0UaTSixOLsRyFskMh+IzwVjoZlq+xtDtZKBnoKZAioxkkS0/wKhrsEmmPpNTxBpn0A3HSBL9NZIzzvoJ3i6YMvp4ajBm19URNezAQ0ipDeTeQclljW81nVyEf1h1VhTfy9LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060462; c=relaxed/simple;
	bh=vqf1PiQgIrSLvLOIqCuthN86/GGCYXPRBreHnHltp80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REbcPzipV86HYS1Okxeup1fQKXMZlcXKhXwYE0PZiY0JcVFG0XEpCzyQswGX/IOZrfqC2aQWx+zOfYK3B8XGS1Nz+D5+nvDXJQpWC88Rn6HEFBdJ+kluiR0JSsBqCXu/HXswYBIfS7eUtcFM/F1RZhU3wGrHjxKJhCqSh/BnzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNE45O+3; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNE45O+3"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c160cb021cso7419163eec.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775060460; x=1775665260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6brUS/+KN+QlXTcwRDDuVwUelenxIPcKdQxQmBulR1c=;
        b=BNE45O+3NVsAQGgQj1RNyaCUlBChtmDeBTLHeVtYINkc/ccArh4lb3w+uEBU5yahai
         UNh+Ndpqd9XuNVjqnqwdaq0xc3owzEU237n17YEGADTta8CUXIn4orZYlC/VrSxGpAOc
         Eh7dFf533GJO+rWiGiSInXk+Rvhn0y+ff4K/agx0KF4vqXSGo69d3Ygbv4O1AWDlZsMw
         GmTCjdKykQ7jVnwmcHACAXfMCThmI0Uc2wk1chAaWtIxoOnK2+oqHf1EwEl/7LxUjKyF
         W69NDNTHjl8nO5VW2zh4JPFrs3uOmeVM3ecRgox7fv3HLKiqQ/f5YGhEG+9a53YqUjuJ
         uBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060460; x=1775665260;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6brUS/+KN+QlXTcwRDDuVwUelenxIPcKdQxQmBulR1c=;
        b=BiFl/KNIOlRYpnXfQKBnDdxCc+O+Jn61BYB1t4k9rOmmS3LG2wosiDO4rLl+1pnb/F
         RV8IAvO2ECZqS38D3ayVuxLmj8LfrgBfyF3urfJyrGCCniKD7hIjiO8qWxZCyzyEsPw8
         RkkYg1USxDN98OL6MfMT7fiML4k7cjV8DWWhxN/ekDm+CZKLu4LvlFH9Sc/8YMLvXIjN
         nivYUIPSIcujjoebZdrf9r+CRTZkVMbzNW+jBDcXsbIu6R7MrT2Pm0D/W6ojZeEkPNBa
         F2SEv1HmPK0+3MYMdRmq0P5ak+EMD7e+xz7WTZUGoojs3TPu2lWS5k9bLeUZpZIzJKFn
         108w==
X-Forwarded-Encrypted: i=1; AJvYcCUE/nWMb6YlKbmlGVvydakwxY4PH0ZNVHLWfqe8erebsgoiEE1Fw2gB0Db8ljBYstr3TtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqL9ej5oUKKvNLrIt8lm6hGQA7v6xxPsJNoDnSF/cNcDCPqBFY
	oVEKd7m5B4fAp8zBHjpDEe1zjukd0omngJR/LBDSyoquJZx2qZ7DtOY=
X-Gm-Gg: ATEYQzzcUFEpOFiFP3wKdNlLTzyd+3mTReRbUnanr5kEzu7ntrVh2hmki5UmSFbKSki
	RxU/6tfSjwH6XVwOKapIIneQAj6kCoDt4whW3UJtS3GN71LCQJBYlOifK57MjUcVAJYPXX+8Iui
	Jw6yoryCbV0+Wton/zPvEq2Sh9o3IElnJlhcCFefaLPFi6XE+PrYM/wL1aVD2midqlQUDBSDfqQ
	5z7PFEJ4naCc6EyZ8ZPBlOIREeL0KW8wU6gtSmtZd5gKLcz6kySyCUdUxPOqs8sk1v5tZqviZ/o
	hmtKvbVgnBixdCatB/EjcBE8+FLBAGpFfmAQsbIIBS1+XyJT+uYcN5riIdmsiFbDkma6BDhpSgU
	pPKSJB06BD2FTxEEZN2tq3VCclt62lC8hzB9i7797a62/zxPUpfRVyVGlXZhJRsLYUZeh8kpVy2
	8/CI3ggur5QlzzDCJ7qq9VbV/JJpAu0DjEmOm5vpVDhUktL4GqoNuvpqWvLxv5wU5JrwVYvxgl+
	J+S1wn1F0BPsejefA==
X-Received: by 2002:a05:7301:4090:b0:2c1:b26:8424 with SMTP id 5a478bee46e88-2c933d8e814mr2313816eec.33.1775060459420;
        Wed, 01 Apr 2026 09:20:59 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca792f3f54sm144003eec.7.2026.04.01.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:20:59 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:20:58 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com, bridge@lists.linux.dev,
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
Message-ID: <ac1F6hIHcoZo-soO@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	Guillaume Nault <gnault@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>,
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	oss-drivers@corigine.com, bridge@lists.linux.dev,
	bpf@vger.kernel.org, linux-wireless@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
References: <20260401074509.1897527-1-dwmw2@infradead.org>
 <20260401074509.1897527-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>

On 04/01, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> There is no need to listen on AF_INET sockets; a modern application can
> listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
> the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
> socket.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  net/ipv4/af_inet.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>  	struct sock *sk = sock->sk;
>  	int err = -EINVAL;
>  
> +	pr_warn_once("process '%s' (pid %d) is listening on an AF_INET socket. Consider using AF_INET6 with IPV6_V6ONLY=0 instead.\n",
> +		     current->comm, task_pid_nr(current));
> +
>  	lock_sock(sk);
>  
>  	if (sock->state != SS_UNCONNECTED || sock->type != SOCK_STREAM)
> -- 
> 2.51.0
> 

Does this also need to look at the proto? inet6_stream_ops seem to be
using inet_listen as well.

const struct proto_ops inet6_stream_ops = {
        .family            = PF_INET6,
        .owner             = THIS_MODULE,
        .release           = inet6_release,
        .bind              = inet6_bind,
        .connect           = inet_stream_connect,       /* ok           */
        .socketpair        = sock_no_socketpair,        /* a do nothing */
        .accept            = inet_accept,               /* ok           */
        .getname           = inet6_getname,
        .poll              = tcp_poll,                  /* ok           */
        .ioctl             = inet6_ioctl,               /* must change  */
        .gettstamp         = sock_gettstamp,
        .listen            = inet_listen,               /* ok           */
