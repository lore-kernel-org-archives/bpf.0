Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9F3D75C9;
	Mon, 28 Sep 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621751; cv=none; b=H3pdAxwzBDHo/Xxo8RNTHzZ84FjS46QLtYSYtyx8yPkFkdcGXOnIK804virXQEGLjazhQjSBbtXV7cpxanLtF+0ZpmOKYdycUOR4a7NSBq6tvDuXODcbRG7kbl+hK1+zhQiR+tluoMPxTlZdLQiDWvqwtWRDUsKFOYld1TGaLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621751; c=relaxed/simple;
	bh=naNDds+Kqtr0lUqt3doxppISikcMBTF1nLFEAHBDxI0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkZzokgQEwEh9mSWqNKcSVdQgfWxCBfRF955eCtdv5wwcw5p6rhegO+MfOxU6HcU5qK/sKaLjSipY82wxck8yG8Bkcwvunuz7AF6aesJfqjv+H6lbwAWxuFT6fRrIbOSi6CCMgnhHRjR+h+ZQYwnZaLSVVpb3eIm/RL60Pa7H8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2lu+l2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2lu+l2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DDF1F00893;
	Mon, 28 Sep 2026 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621749;
	bh=X4tCQobttmSQQ+nRSmT2XagRWyA7UmaIFP5CEtTsXz8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=o2lu+l2+DfDviCGhomCeaUehDcZ/pNLI6yEP9INFx94TrFwju23ksOMs34pOtitmr
	 12LMhnhxLhAmrCrdwqnB/qzITico58gD5BQk5zBwohjFc0uriR9Rqej8SXohBxj2mZ
	 D7+taonG8izw2Ujn879CoychP1poBv85GC03OpuE4grfS2ER8+/X/74equVwKQbzka
	 piWtcu4ESQIMh3DVwxQ4RLjwUoIc/LWt55FqoCoAnRbKWEpWmtf4a0WJtBc5e2UgSy
	 /SOrJAZsktobsgiX5yfrLHhpYQFZ1q3xaWiRsWj5r6CFMZTtbyKph2H8OYAfRaLHh5
	 aLEOLJfZZG/EQ==
Subject:
 Re: [PATCH net-next 4/6] ipv4: convert do_ip_getsockopt() to sockopt_t
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
Date: Mon, 28 Sep 2026 18:55:47 +0000
Message-ID: <179062174764.3145.7414686101186998778@kernel.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-4-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-4-c3ef2e3bb5c0@debian.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The conversion quietly fixes a bug where getsockopt() could
  return a positive value, but the commit message does not mention it…

Pre-existing issues:
- [Low] ip_get_mcast_msfilter() and compat_ip_get_mcast_msfilter() in
  net/ipv4/ip_sockglue.c set opt->optlen (to gsf_size or len) before…

--

ipv4: convert do_ip_getsockopt() to sockopt_t

This patch moves do_ip_getsockopt() and ip_mroute_getsockopt() from a
sockptr_t optval/optlen pair to sockopt_t, and removes the IP_MSFILTER
and MCAST_MSFILTER bridges. ip_getsockopt() now builds the sockopt_t with
sockopt_init_user() and always writes optlen back to userspace.
sol_ip_sockopt() in net/core/filter.c builds a kernel sockopt_t with
sockptr_to_sockopt().

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 1f452b6ea86e9..2e78b11d294a9 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c

[ ... ]

> @@ -1620,16 +1618,15 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  		rcu_read_unlock();
>  
>  		if (opt->optlen == 0) {
> -			len = 0;
> -			return copy_to_sockptr(optlen, &len, sizeof(int));
> +			sopt->optlen = 0;
> +			return 0;
>  		}

[ ... ]

> @@ -1680,8 +1677,8 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  			int tos = READ_ONCE(inet->rcv_tos);
>  			put_cmsg(&msg, SOL_IP, IP_TOS, sizeof(tos), &tos);
>  		}
> -		len -= msg.msg_controllen;
> -		return copy_to_sockptr(optlen, &len, sizeof(int));
> +		sopt->optlen = len - msg.msg_controllen;
> +		return 0;
>  	}

[Severity: Low]
This isn't a bug, but the commit message doesn't mention that these two
branches also change the getsockopt() return value.

Before this patch, the empty IP_OPTIONS branch and the IP_PKTOPTIONS tail
both ended with:

    return copy_to_sockptr(optlen, &len, sizeof(int));

For a user optlen, copy_to_sockptr() returns the copy_to_user() count of
bytes not copied, not -EFAULT.

Take an optlen on a page that is readable but not writable (for example
PROT_READ). The earlier copy_from_sockptr(&len, optlen, ...) succeeds, the
write fails, and do_ip_getsockopt() returns +4. That value passes back
through this chain:

    do_sock_getsockopt()
      -> sock_common_getsockopt()
        -> udp_getsockopt() / tcp_getsockopt()
          -> ip_getsockopt()
            -> do_ip_getsockopt()

As a result, getsockopt(2) returns 4.

With this patch, both branches only set sopt->optlen, and the put_user()
in ip_getsockopt() returns -EFAULT. That looks correct.

Could this be mentioned in the commit message? Another option is a separate
patch with a Fixes: tag, so stable can pick it up.

[ ... ]

> @@ -1711,43 +1707,25 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,

[ ... ]

>  	case MCAST_MSFILTER:
> -	{
> -		struct kvec kvec;
> -		sockopt_t opt;
> -
> -		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
> -		if (err)
> -			goto out;
> -
>  		if (in_compat_syscall())
> -			err = compat_ip_get_mcast_msfilter(sk, &opt);
> +			err = compat_ip_get_mcast_msfilter(sk, sopt);
>  		else
> -			err = ip_get_mcast_msfilter(sk, &opt);
> -		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
> -			err = -EFAULT;
> +			err = ip_get_mcast_msfilter(sk, sopt);
>  		goto out;
> -	}

[Severity: Low]
This is a pre-existing issue, but it now shows up again. With the !err
guard gone and the unconditional write-back in ip_getsockopt():

    err = do_ip_getsockopt(sk, level, optname, &opt);
    if (put_user(opt.optlen, optlen))
        return -EFAULT;

MCAST_MSFILTER can return -EFAULT after it has already changed the user's
optlen. ip_get_mcast_msfilter() sets the length before its last copy:

net/ipv4/ip_sockglue.c:ip_get_mcast_msfilter() {
    ...
	opt->optlen = gsf_size;

	/* ip_mc_gsfget() consumed the whole reply; rewind to the fixed part. */
	iov_iter_revert(&opt->iter_out, gsf_size);
	if (copy_to_iter(&gsf, size0, &opt->iter_out) != size0)
		return -EFAULT;
    ...
}

compat_ip_get_mcast_msfilter() does the same thing: it sets
opt->optlen = len before the gf_fmode and gf_numsrc copy_to_iter() calls.

One trigger is an optval that is readable but not writable. The
copy_from_iter() of the header succeeds, then the header copy_to_iter()
fails.

The pre-series code already wrote optlen before the optval copy in these
helpers. So the end result matches the original behaviour, and only
reverses the !err guard from the previous patch, "ipv4: igmp: convert
ip_mc_gsfget() to sockopt_t". The IPv6 conversion later in the series
(ipv6_get_msfilter() and compat_ipv6_get_msfilter()) uses the same
set-then-copy order.

This patch does move ip_mc_msfget() to store its length last, though. So
IP_MSFILTER and MCAST_MSFILTER now act differently when the final copy
faults.

Should ip_get_mcast_msfilter() and compat_ip_get_mcast_msfilter() also
set opt->optlen after their copies, to match ip_mc_msfget()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0%40debian.org
