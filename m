Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0599143F4AD;
	Sat, 10 Oct 2026 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623578; cv=none; b=Ul8rWpqKaw1dgSKz6EdcfUh9VGx+Qm9pCUtoG1T0PTvwqfb9kOan1tvYhMaeXHwaCB1i+DalzTbiSxhUDUha7ZAwJnexHY93/RWnhNkEJTiU926NCfy08S796srfPs9w71nZj0s/qST7mplUk1qYYuQwv0Tava9mkmlx/oe1GAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623578; c=relaxed/simple;
	bh=4rbHja6V6uJPJge/FBMjVQiDVIAL/w7Fk4fAo5iBOKo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o6A7L/DZ0yUaZ/uiUIcVmTfC2VDNAbU5Xyiko8tMAjn2P2CBPYRXA31gL0pD+bkAEXgL1fArqg9xA7xCQhOp9t+EXKPDTQceeQs7fTPi6JZ05d3x8cLUxA+uBTkSB8TLfzPVjnK2F7OXzTq31jlDeswHB+jRe6AUBkdbW5nIx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYUaFQ1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYUaFQ1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF97F1F000FF;
	Sat, 10 Oct 2026 09:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791623576;
	bh=TJhxxtNiYuWjBaXSrJYPSLPaCSBUqRIZ3ID1IfTSBO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aYUaFQ1Z1WPxgDsYvR8hxW/xZ65gajL1iccl/yeEbGAEbVRp5kbNUBrDILJNob/H0
	 +hkceUHBdpT2naF0fbJNYKpu23yymKo1LZ3ULLuF0ne2q4/Qc7IVUZ2ifGa/ptYwjw
	 KRsq/bqMTb795Uoma6DS9DCcI9yHxAu9yVVCvEZOfGUGiS+BArnBDmGJFgcYWTQXlz
	 tMPCw40I2CbaREmOFy/cWEQijsD7ZK3NwtuTmvXrxnUMpXHFGUNtLzKMjzhV2sDRrZ
	 CCXTo915V99e38DxXoV/4NYZu59+yyDupeXz0/Q9mJsifg6TVfhkF7YlFMf9PMj6IG
	 Fbp2hj2qWixgw==
Subject:
 Re: [PATCH net-next v2 5/7] ipv4: convert do_ip_getsockopt() to sockopt_t
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org,
 edumazet@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 david.laight.linux@gmail.com, kernel-team@meta.com
Date: Sat, 10 Oct 2026 09:12:54 +0000
Message-ID: <179162357442.434549.2735086321626235140@kernel.org>
In-Reply-To: <20261009-sockopt_expand_out_v2-v2-5-8ac08c469ecb@debian.org>
References: <20261009-sockopt_expand_out_v2-v2-5-8ac08c469ecb@debian.org>
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

- [Low] Undisclosed errno change on calls that already fail.
- [Low] The commit message leaves out two behaviour-relevant parts of the
  patch.

--

ipv4: convert do_ip_getsockopt() to sockopt_t

This converts do_ip_getsockopt() and ip_mroute_getsockopt() from a
sockptr_t pair to sockopt_t and removes the IP_MSFILTER and
MCAST_MSFILTER bridges. ip_getsockopt() now builds the sockopt_t with
sockopt_init_user() and always writes optlen back. sol_ip_sockopt()
converts its kernel buffers with sockptr_to_sockopt().

> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index d573c5bf8f038..bf00810cdd7a1 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -2763,12 +2763,13 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf, sockopt_t *opt)
>  	if (err)
>  		return err;
>  
> -	opt->optlen = msf_size;
>  	if (copy_to_iter(msf, IP_MSFILTER_SIZE(0), &opt->iter_out) !=
>  	    IP_MSFILTER_SIZE(0))
>  		return -EFAULT;
>  	if (len && copy_to_iter(psl->sl_addr, len, &opt->iter_out) != len)
>  		return -EFAULT;
> +
> +	opt->optlen = msf_size;
>  	return 0;
>  done:
>  	return err;

[Severity: Low]

This isn't a bug, but the commit message doesn't explain this hunk. The
move appears to be needed because ip_getsockopt() now always writes
optlen back. The old IP_MSFILTER bridge only wrote it back on success:

    err = ip_mc_msfget(sk, &msf, &opt);
    if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
        err = -EFAULT;

Without the move, a fault while copying the reply would report msf_size
to userspace along with -EFAULT. The previous patch in the series
("ipv4: igmp: convert ip_mc_gsfget() to sockopt_t") explained the same
reasoning for MCAST_MSFILTER. Could this commit message say so as well?

There is also a user-visible fix here that the message doesn't mention.
The old IP_OPTIONS empty path and the old IP_PKTOPTIONS tail in
do_ip_getsockopt() returned the result of copy_to_sockptr() directly:

    return copy_to_sockptr(optlen, &len, sizeof(int));

For a user pointer, that result is the number of bytes not copied. So if
optlen was readable but not writable, getsockopt() could return 4
instead of -EFAULT. Now those paths return 0, and put_user() in
ip_getsockopt() turns the failed write into -EFAULT. Would it be worth
noting this in the changelog?

Also, this sentence in the commit message is missing its final period:

    ip_getsockopt() builds the sockopt_t with sockopt_init_user() and
    writes optlen back unconditionally

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 1b7461f1569c3..90d0b5bee68b5 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c

[ ... ]

> @@ -1783,19 +1759,22 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  int ip_getsockopt(struct sock *sk, int level,
>  		  int optname, char __user *optval, int __user *optlen)
>  {
> +	sockopt_t opt;
>  	int err;
>  
> -	err = do_ip_getsockopt(sk, level, optname,
> -			       USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
> +	err = sockopt_init_user(&opt, optval, optlen);
> +	if (err)
> +		return err;
> +
> +	err = do_ip_getsockopt(sk, level, optname, &opt);
> +	if (put_user(opt.optlen, optlen))
> +		return -EFAULT;

[Severity: Low]

Reading optlen in sockopt_init_user() before do_ip_getsockopt() runs
seems to change the errno for calls that were already going to fail.
Is that intended?

Before this patch, do_ip_getsockopt() returned before touching optlen in
these cases:

    if (level != SOL_IP)
        return -EOPNOTSUPP;

    if (ip_mroute_opt(optname))
        return ip_mroute_getsockopt(sk, optname, optval, optlen);

ip_mroute_getsockopt() did not read optlen either before returning
-EOPNOTSUPP (not a raw IGMP socket), -ENOENT (no mr table) or
-ENOPROTOOPT (unknown MRT_* option).

Any level other than the socket's own protocol level ends up here. For
example, tcp_getsockopt() does:

    if (level != SOL_TCP)
        return READ_ONCE(icsk->icsk_af_ops)->getsockopt(sk, level,
                                    optname, optval, optlen);

udp_getsockopt() and raw_getsockopt() do the same for levels other than
SOL_UDP and SOL_RAW.

With this patch, getsockopt(tcp4_fd, SOL_IPV6, X, buf, &len) with
len < 0 returns -EINVAL instead of -EOPNOTSUPP. The same applies to an
MRT_* option on a socket that is not raw IGMP. An unreadable optlen
(for example NULL) now returns -EFAULT.

The commit message only describes the unwritable-optlen case. Could it
mention these errno changes too?

The selftest added later in the series ("selftests: net: getsockopt_iter:
cover ip and ipv6") only checks MRT_VERSION returning EOPNOTSUPP with a
valid optlen, so it would not catch this. The code is unchanged at the
end of the series.

Also, these negative checks look unreachable now. In
do_ip_getsockopt():

    len = sopt->optlen;
    if (len < 0)
        return -EINVAL;

and in ip_mroute_getsockopt():

    olr = opt->optlen;
    if (olr < 0)
        return -EINVAL;

Both callers of do_ip_getsockopt() already reject a negative optlen:
ip_getsockopt() through sockopt_init_user() and sol_ip_sockopt()
through sockptr_to_sockopt(). ip_mroute_getsockopt() is only called
from do_ip_getsockopt(). Are these checks still needed?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb%40debian.org
