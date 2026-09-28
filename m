Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2195632;
	Mon, 28 Sep 2026 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621745; cv=none; b=qPOr9+fAtzWkWXCwXbnNxcjgdDhkH2hr6ybU8huoq+xFpDPJY1MWSMyvbq39IeQ1bvWGX3Q4+UyXqzDdDCTw4mgeEr3nYUHJs1cZJIJHNdOAmD7Kz8KySYRAuWmPUDYU/2E+ygsZqz7mGe2gTvmyAxVievFOKKVX8O1oxCysKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621745; c=relaxed/simple;
	bh=onZDiNCv4SpLXbclYO7QTRI0/zTxTJio8MMiVpSA3ys=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G1ZMk3w8aoWLJ4/CjU9ICxsYo0TEfNUmUCu3BDPIHqX656zF9hG4jBm4JQiBqgerkJ1TISxvm9JIU2SfOsx/bfyq9LIUqIbkSP0TLMDp0DjSS8am08IGj4RaqVRdrss1pt7t6uGR6npa0JJyyZ+xRpo8AvANU3xDNzO/q3A9AWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHmy2ePq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHmy2ePq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA091F000FF;
	Mon, 28 Sep 2026 18:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621743;
	bh=LV5foDq0te//h3ZFoq+eAVN3kgz2N/aXomur4SLjfrs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RHmy2ePqKXcwoZ6sOF7EkuTmUGsyy55qFEnR3bxmPV1Md1l2SfmzNinWLsWWYVIbP
	 FIs5DyhSATA5lJBx14pPb7T8WFefOrpjQo7hd5tLPTq1Hq7lA2+Tz3ogCVa58Dm9J5
	 hye2SrWsvIn0NJinRY7xbAQUM7cHTh/aL3xLwKgAfxPrSwFz0cEGr9HySQwNIuG8V1
	 JEs4uuUfDn8pmTlqDb7BeUApsz8sj9gHf9P781S0VgS/nBHT6M64zisqGiVP6qLnCw
	 UT1Z88sVXIaHIzRD8oCujjnxZ8mTYMTaFXXBhfEwPwmZZULbTvr9TFwg9s2WxTCQh0
	 CVrDnOsMYT7rA==
Subject: Re: [PATCH net-next 1/6] ipv6: reject a negative optlen in
 do_ipv6_getsockopt()
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
Date: Mon, 28 Sep 2026 18:55:41 +0000
Message-ID: <179062174160.3145.8573490114986242294@kernel.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-1-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-1-c3ef2e3bb5c0@debian.org>
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

- [Low] The commit message misdescribes how a negative optlen behaved
  before the patch.
- [Low] The commit message frames the change as a standalone bug fix
  ("the fix stands on its own here") for user-visible behaviour, but it…

--

ipv6: reject a negative optlen in do_ipv6_getsockopt()

This commit makes do_ipv6_getsockopt() return -EINVAL when the optlen
read from userspace is negative. IPv4's do_ip_getsockopt() already does
this.

> IPv4's do_ip_getsockopt() rejects a negative optlen right after reading
> it. do_ipv6_getsockopt() never has, and nothing downstream treats it as
> an error either: len is an int, but every consumer compares it unsigned,
> so -1 behaves as a huge value and each site clamps to its own reply
> size.

[Severity: Low]

Is this an accurate description of the old behaviour? Two cases in
do_ipv6_getsockopt() in net/ipv6/ipv6_sockglue.c don't seem to match it.

For MCAST_MSFILTER, ipv6_get_msfilter() and compat_ipv6_get_msfilter()
already use a signed compare, because size0 is a const int:

	const int size0 = offsetof(struct group_filter, gf_slist_flex);
	...
	if (len < size0)
		return -EINVAL;

So len = -1 already returned -EINVAL before this patch.

For IPV6_2292PKTOPTIONS on a SOCK_STREAM socket, len is never compared
or clamped:

		msg.msg_controllen = len;

msg_controllen is __kernel_size_t, so -1 becomes SIZE_MAX. That value
passes both size checks in put_cmsg():

  msg_controllen < sizeof(struct cmsghdr)
  msg_controllen < cmlen

As a result, every pending cmsg is written to optval with no limit from
the real buffer size. This covers the cmsgs from ip6_datagram_recv_ctl()
and from the sticky rxopt put_cmsg() calls. After that:

		len -= msg.msg_controllen;

reports the number of bytes written, not a clamped reply size.

The writes only land in the caller's own address space. The BPF kernel
sockptr path through sol_ipv6_sockopt() only allows IPV6_TCLASS,
IPV6_AUTOFLOWLABEL and IPV6_TRANSPARENT with *optlen == sizeof(int).
So this is a changelog problem only, and the code change covers both
paths.

Could the commit message mention the IPV6_2292PKTOPTIONS case, and drop
the claim that every consumer compares len unsigned?

> This is a bug ready to bite us in the near future, let's get this fixed.
>
> I've found this because testing the rest of the patch was returning
> inconsistency when optlen = -1.
>
> Later patches make the check unreachable, since sockopt_init_user() and
> sockptr_to_sockopt() both reject a negative length before the switch
> runs. Keep it as a guard; the fix stands on its own here.

[Severity: Low]

Is this meant as a standalone fix, or as preparatory hardening for the
series?

Userspace can see the change on the baseline. The IPv6 proto_ops have no
getsockopt_iter, so do_sock_getsockopt() takes the legacy
ops->getsockopt path and never reaches sockptr_to_sockopt():

do_sock_getsockopt()
  sock_common_getsockopt()
    udpv6_getsockopt()
      ipv6_getsockopt()
        do_ipv6_getsockopt()

Nothing on that path checks the sign of len. With len = -1,
getsockopt(udp6_fd, SOL_IPV6, IPV6_TCLASS, buf, &len) reaches:

	len = min_t(unsigned int, sizeof(int), len);

It then writes 4 bytes and returns 0. With this patch it returns -EINVAL.

If this is a fix, should it have a Fixes: tag and target net? The
unchecked len predates git history, so something like this would fit:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

If it is hardening for the net-next series, could "a bug ready to bite
us" and "the fix stands on its own here" be reworded?

Also, "the rest of the patch" and "Later patches make the check
unreachable" refer to the series. Once this is in git history, readers
won't have that context. Could those sentences be reworded too?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0%40debian.org
