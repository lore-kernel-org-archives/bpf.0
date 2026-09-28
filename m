Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8BE3C8731;
	Mon, 28 Sep 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621747; cv=none; b=U6iHWvEAAtgO/aAI2yIzWZwEUgny0cy0aVorAl7am9l8QQhiToz4lkeL+s5wl1tzuRHNdh9EJlil0Juc8xNqZ98BNubsUEhXwAajcXpI2NxnIyO2T+pDqaf5eX9glJuLJp/MWWT4HU87d6RpLriK0iEmo93ge7Ch0Ul0A6a2tt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621747; c=relaxed/simple;
	bh=FQImyCIQfu/0wyGd1ruSkPH2qByF9oMeBDCMjrIWHi8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HSMTPOBRzPDmSHmyCpE656/kBimIfaWu1o5ekvcLHgBoAeSqo0akyfEAzKKxhKW2C3wAYrjKC+QEXX10VFF/MLl9d0/rt5Cv5VPWp+OG8DeWXUmqMEZvWHdNzZs5xeWjyIevhaxzgHZoBAHF7N4YbwxjY39+XBlbUpy2snfcGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1pP9wZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1pP9wZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090751F00893;
	Mon, 28 Sep 2026 18:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621745;
	bh=y0Re+p2VfD8QFUNRmRMvJV9RM03+UtxkKr129YbFPLw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K1pP9wZIun0o6oZMiZiEBtnoHNTyxy4QdeCi3laayBYG14sCAkbi/2JKUFGwAj+y4
	 bzO6g82GkBfPn37pqcjqcWZ0nlHRlMFtXYm/uits3j4V8nWei+u/Cw3z9iUxhpl2bF
	 uCB7aZgAezTeD+IK/4zEZ3hOmdDM4hWHK0t+olScfxt9bJFBpTF4VphS25ga4emPx5
	 aTmOUF7KXsnv7dddvBgIighlXasucZd+94lfZ4o3X6zzCjgz2dW9Px/IWCTo7WU/j6
	 rNVFpGoVut3YeZy9/oA2Q3GitNSxnzNFGCtQICR99nJCQiDyztNYhGMROTUAdWB9MU
	 88j6QQABqq2rA==
Subject:
 Re: [PATCH net-next 2/6] ipv6: mcast: convert ip6_mc_msfget() to sockopt_t
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
Date: Mon, 28 Sep 2026 18:55:43 +0000
Message-ID: <179062174358.3145.16558457435132516078@kernel.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-2-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-2-c3ef2e3bb5c0@debian.org>
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

- [Low] The commit message says the -EFAULT returns "still" leave the
  caller's optlen untouched.

--

ipv6: mcast: convert ip6_mc_msfget() to sockopt_t

This converts ip6_mc_msfget() and the MCAST_MSFILTER getsockopt helpers
from sockptr_t to sockopt_t. do_ipv6_getsockopt() builds the sockopt_t.
The source list is written through iter_out after sockopt_expand_out(),
and the callers then rewind to write the fixed header. The *optlen store
moves to do_ipv6_getsockopt() and happens only on success.

> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index 5c6a0819a2aaf..1bdb3e001e4fe 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -922,48 +922,51 @@ static int ipv6_getsockopt_sticky(struct sock *sk, struct ipv6_txoptions *opt,

[ ... ]

>  	sockopt_lock_sock(sk);
> -	err = ip6_mc_msfget(sk, &gsf, optval, size0);
> +	err = ip6_mc_msfget(sk, &gsf, opt, size0);
>  	if (!err) {
>  		if (num > gsf.gf_numsrc)
>  			num = gsf.gf_numsrc;
>  		len = GROUP_FILTER_SIZE(num);
> -		if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
> -		    copy_to_sockptr(optval, &gsf, size0))
> +		opt->optlen = len;
> +
> +		/* ip6_mc_msfget() consumed the whole reply; rewind to the
> +		 * fixed part.
> +		 */
> +		iov_iter_revert(&opt->iter_out, len);
> +		if (copy_to_iter(&gsf, size0, &opt->iter_out) != size0)
>  			err = -EFAULT;
>  	}
>  	sockopt_release_sock(sk);
>  	return err;
>  }

[ ... ]

> @@ -974,18 +977,22 @@ static int compat_ipv6_get_msfilter(struct sock *sk, sockptr_t optval,

[ ... ]

>  	len = GROUP_FILTER_SIZE(num) - (sizeof(gf)-sizeof(gf32));
> -	if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
> -	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_fmode),
> -				   &gf.gf_fmode, sizeof(gf32.gf_fmode)) ||
> -	    copy_to_sockptr_offset(optval, offsetof(struct compat_group_filter, gf_numsrc),
> -				   &gf.gf_numsrc, sizeof(gf32.gf_numsrc)))
> +	opt->optlen = len;
> +
> +	/* Rewind to gf_fmode, which gf_numsrc follows. */
> +	iov_iter_revert(&opt->iter_out,
> +			len - offsetof(struct compat_group_filter, gf_fmode));
> +	if (copy_to_iter(&gf.gf_fmode, sizeof(gf32.gf_fmode),
> +			 &opt->iter_out) != sizeof(gf32.gf_fmode) ||
> +	    copy_to_iter(&gf.gf_numsrc, sizeof(gf32.gf_numsrc),
> +			 &opt->iter_out) != sizeof(gf32.gf_numsrc))
>  		return -EFAULT;
>  	return 0;
>  }
> @@ -1006,9 +1013,23 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
>  		return -EINVAL;
>  	switch (optname) {
>  	case MCAST_MSFILTER:
> +	{
> +		struct kvec kvec;
> +		sockopt_t opt;
> +		int err;
> +
> +		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
> +		if (err)
> +			return err;
> +
>  		if (in_compat_syscall())
> -			return compat_ipv6_get_msfilter(sk, optval, optlen, len);
> -		return ipv6_get_msfilter(sk, optval, optlen, len);
> +			err = compat_ipv6_get_msfilter(sk, &opt);
> +		else
> +			err = ipv6_get_msfilter(sk, &opt);
> +		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
> +			err = -EFAULT;

[Severity: Low]

The commit message says:

    The *optlen store moves out to the call site, guarded by !err so the
    -EINVAL, -EADDRNOTAVAIL and -EFAULT returns still leave the caller's
    optlen word untouched.

Is "still" accurate for the -EFAULT that comes from writing the fixed
header?

Before this patch, ipv6_get_msfilter() stored optlen first and then wrote
the header:

    if (copy_to_sockptr(optlen, &len, sizeof(int)) ||
        copy_to_sockptr(optval, &gsf, size0))

compat_ipv6_get_msfilter() used the same order for gf_fmode and
gf_numsrc. So when the header write faulted, the caller got -EFAULT and
optlen had already been set to the reply length.

With this patch, the helpers write the header through iter_out, and
do_ipv6_getsockopt() only stores opt.optlen when !err. After a fault on
the header write, optlen is now left untouched.

The write order is also reversed. If optval is writable and optlen is
read-only, the header now gets written before the -EFAULT. The old code
never wrote the header in that case.

This seems to last only until a later patch in the series. In "ipv6:
convert do_ipv6_getsockopt() to sockopt_t", ipv6_getsockopt() writes
sopt.optlen back unconditionally. Both helpers set opt->optlen = len
before the header copy, so a header fault reports optlen = len again, as
the original code did.

Could the commit message describe this intermediate change instead of
saying the behavior is unchanged?

> +		return err;
> +	}
>  	case IPV6_2292PKTOPTIONS:
>  	{
>  		struct msghdr msg;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0%40debian.org
