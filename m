Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA33CF02B;
	Mon, 28 Sep 2026 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621749; cv=none; b=evIrHfHDB15Pcsov2F/WLvdNj/6j81i58JdoA4ioXSxxdqduJ1fk69oU1EdGZj/NUHY8VmRXcWKB63bOvvv6KqIDEQRa4rUqx8hpU+Xs7mnGk6/8mc3cKOw3j6Hk6zJLAaQyIon3PRheQwBlDCrDPzDx7hitGyXpTH5gIoCikoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621749; c=relaxed/simple;
	bh=qKhQSM3kh5mUPRjME/pgMTzjDhc/XZ0eQYGAZooIQWI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=minyRoVppFnTsHaICTigaUsrF/FwKRlnEsodRoFr06aH0htxQHG3KEM2ug67unatjoqU0F8xrPcmigfn35zyMmCS6zpvvGY/bD2gRyrbUQgWUqhqjWg02e0u8AyxkP9mFUTvmfBurQFO3abBMkyKca4KkDS2+DEHBG1DgmYxN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpEL43qb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpEL43qb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC271F000FF;
	Mon, 28 Sep 2026 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621747;
	bh=scQMDbOsIkNG/UBQlZCCsfp2fkBGioxNzHt8VdI1ALY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MpEL43qbiKhgto0GGp1YC0qrUfxde5+LL9o6giYWoHkhikNBFQJwoVYHURU/E/iOL
	 UaOaTElnWcRsrxlbHysIX+sHS/KD2bV/w8mhzkvSzlL4mOXZWGGjfi3i9M1W7OW9fp
	 TWFySdkgOxIQoBIAUA1Lb5hq6eg7xFCXe+M97bTbJXun43xE9ycXmmwsV/SA+aWSdJ
	 Dc+g3FR+1orIYwsxV2XVZ+NcY0bUQs/rxRr/s58SnNFGh4jdngABvWStXRSh1xyDEp
	 xaQyuiG6zuWFVfJWpqeAKkaiIHxWZmHSIFunzu4DWky3Bi9Pi6GQc6Tewvav0y9RC+
	 WfbXVDYNbG6VA==
Subject:
 Re: [PATCH net-next 3/6] ipv4: igmp: convert ip_mc_gsfget() to sockopt_t
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
Date: Mon, 28 Sep 2026 18:55:45 +0000
Message-ID: <179062174570.3145.4474714642379786219@kernel.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-3-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-3-c3ef2e3bb5c0@debian.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ip_get_mcast_msfilter() and compat_ip_get_mcast_msfilter()
  (net/ipv4/ip_sockglue.c) rewind the output iterator by passing the…
- [Low] The commit message says the optlen store is guarded by !err "so
  the -EINVAL, -EADDRNOTAVAIL and -EFAULT returns still leave the…

--

ipv4: igmp: convert ip_mc_gsfget() to sockopt_t

This converts ip_mc_gsfget() and its two MCAST_MSFILTER callers from
sockptr_t to sockopt_t. The callee now expands iter_out, advances over the
fixed part and writes the sources. The callers then rewind with
iov_iter_revert() and write the fixed header, and the *optlen store moves
to do_ip_getsockopt(), where it only happens on success.

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index e06c1f48ecad6..1f452b6ea86e9 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1442,45 +1442,46 @@ static bool getsockopt_needs_rtnl(int optname)

[ ... ]

>  	num = gsf.gf_numsrc;
> -	err = ip_mc_gsfget(sk, &gsf, optval,
> +	err = ip_mc_gsfget(sk, &gsf, opt,
>  			   offsetof(struct group_filter, gf_slist_flex));
>  	if (err)
>  		return err;
>  	if (gsf.gf_numsrc < num)
>  		num = gsf.gf_numsrc;
>  	gsf_size = GROUP_FILTER_SIZE(num);
> -	if (copy_to_sockptr(optlen, &gsf_size, sizeof(int)) ||
> -	    copy_to_sockptr(optval, &gsf, size0))
> +	opt->optlen = gsf_size;
> +
> +	/* ip_mc_gsfget() consumed the whole reply; rewind to the fixed part. */
> +	iov_iter_revert(&opt->iter_out, gsf_size);
> +	if (copy_to_iter(&gsf, size0, &opt->iter_out) != size0)
>  		return -EFAULT;

[Severity: Medium]
What happens here if gsf_size is larger than MAX_RW_COUNT?

iov_iter_revert() refuses large rewinds:

lib/iov_iter.c:iov_iter_revert() {
    ...
	if (WARN_ON(unroll > MAX_RW_COUNT))
		return;
    ...
}

MAX_RW_COUNT is (INT_MAX & PAGE_MASK), but sockopt_expand_out() only
rejects sizes above INT_MAX:

	if (size > INT_MAX)
		return -EINVAL;

That means ip_mc_gsfget() can expand iter_out to a size in the range
(MAX_RW_COUNT, INT_MAX] and then use all of it. For example, with
n = 0xffffe0 sources the native reply is 144 + n * 128 = 0x7ffff090. That
is above MAX_RW_COUNT for both 4K pages (0x7ffff000) and 64K pages
(0x7fff0000).

When that happens, the WARN_ON fires and the iterator is not rewound.

If optlen only covered the fixed part, iter_out is empty, copy_to_iter()
returns 0, and getsockopt fails with -EFAULT. The old code handled the
same request correctly.

If optlen was at least 144 bytes larger than the reply, no expansion
happens. The fixed header is then written right after the source list,
offset 0 is never written, and the call returns success with the caller's
own gf_fmode and gf_numsrc still in the buffer.

The compat path in compat_ip_get_mcast_msfilter() looks like it has the
same problem:

	iov_iter_revert(&opt->iter_out,
			len - offsetof(struct compat_group_filter, gf_fmode));

Its unroll is 8 + n * 128 (0x7ffff008 for the same n), so gf_fmode and
gf_numsrc are not rewritten at their offsets either.

Reaching this needs net.core.optmem_max and net.ipv4.igmp_max_msf raised.
Both are writable per-netns, so root inside a user+net namespace can set
them. It also needs about 16.7M sources installed with IP_MSFILTER and a
~2 GiB buffer.

The ~64 MiB kmallocs in memdup_sockptr() and sock_kmalloc() are more than
KMALLOC_MAX_SIZE allows on x86-64, but they fit on configs such as arm64
with 64K pages. The compat variant also needs AArch32 compat support.

The old copy_to_sockptr_offset() writes used size_t offsets and had no
such limit. This code is also unchanged at the end of the series. Both
revert calls are still the same after "ipv4: convert do_ip_getsockopt()
to sockopt_t".

Should the expansion be capped at MAX_RW_COUNT instead of INT_MAX?

[ ... ]

> @@ -1727,12 +1732,22 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  		goto out;
>  	}
>  	case MCAST_MSFILTER:
> +	{
> +		struct kvec kvec;
> +		sockopt_t opt;
> +
> +		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
> +		if (err)
> +			goto out;
> +
>  		if (in_compat_syscall())
> -			err = compat_ip_get_mcast_msfilter(sk, optval, optlen,
> -							   len);
> +			err = compat_ip_get_mcast_msfilter(sk, &opt);
>  		else
> -			err = ip_get_mcast_msfilter(sk, optval, optlen, len);
> +			err = ip_get_mcast_msfilter(sk, &opt);
> +		if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
> +			err = -EFAULT;

[Severity: Low]
The commit message says:

    The *optlen store moves out to the call site, guarded by !err so the
    -EINVAL, -EADDRNOTAVAIL and -EFAULT returns still leave the caller's
    optlen word untouched.

Is that accurate for a fault on the fixed-header write? The old
ip_get_mcast_msfilter() wrote optlen first:

	if (copy_to_sockptr(optlen, &gsf_size, sizeof(int)) ||
	    copy_to_sockptr(optval, &gsf, size0))
		return -EFAULT;

So a fault on the header write returned -EFAULT with optlen already set to
the reply size. The old compat_ip_get_mcast_msfilter() used the same order
for gf_fmode and gf_numsrc.

Now the header is written by copy_to_iter() after iov_iter_revert(), and
optlen is only stored when err is zero. That -EFAULT now leaves optlen
unchanged. It can be hit with a read-only optval header, a writable optlen
in a separate page, and zero sources copied.

The order is also reversed when the optlen write itself faults. The header
is now written before -EFAULT is returned, and the old code never wrote it
in that case. If optlen aliases gf_numsrc, the value left in that word
changes from the source count to the reply length.

Later in the series, "ipv4: convert do_ip_getsockopt() to sockopt_t" makes
ip_getsockopt() write opt.optlen back unconditionally. That restores the
old optlen value on header-write faults, but optval is still written
before optlen.

Could the commit message be updated to describe this?

>  		goto out;
> +	}
>  	case IP_PROTOCOL:
>  		val = inet_sk(sk)->inet_num;
>  		break;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0%40debian.org
