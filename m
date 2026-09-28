Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4473E1D13;
	Mon, 28 Sep 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621755; cv=none; b=oL79fThoJp+7fw/urLJA9XcUmOTkOxHj7czO7UxrRfHmZW5ipRQCnrm7JPDBEDqNkDuBfBgxiNNxb4U9asd2Ad0GtbsEZDKjixmd5w3MdZGz7WDR8xioWtddoQG3gADIjddX4fpO4EBgoxBh+dH4HHnF0NdvQFeN0yCbu7AmhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621755; c=relaxed/simple;
	bh=U5zzI6jBLe7Ep66VszHPCWuoR7tENWXyFWqKR865KLo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HaUrqK0/UwpZJrQZosXipCZN1Q7dsmDWXA3nUZZ6G3OaPmh5FAbOeSG+h1IJu7x6IeViX+AqYSPzy/jz+aTmKhG8vGlxEEsVf1NOA3EUdMquw9zer014xhWD/5dr/kglPfsFf+rMl2RFSL07xtJeKY3S/R0e9o8RpUFu/UWP2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7dY41rv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7dY41rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347E81F00893;
	Mon, 28 Sep 2026 18:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790621753;
	bh=QZt0gbSYbDwXWUlFamvSsf4l1w+KWApqoB86UH9Es+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k7dY41rvReb4voa6Ito8INyhbCze0K8Ta4eOiNwhEKH9EHBR3Npi5CAyIm7ue8r+M
	 1pxZ8AI8h0Ew/RZUCUjQHU0B24DdPjwWgeQFhYVSYHWfCKn2+jJqcakbfTvLc1JqJc
	 gLxVRDh6PD/iIRjfu822kkJrZOg9rzd2yzdV2d/Y3JKKNkbDYUuB/0YHG9TUdkeqxF
	 zlowrf7w6V4gpu1ow9ZYrOD0lqalQfP2A+4PAaex+ry1gtjK3Gg7xDW1wC7FbfKOUI
	 HsH2fW0kkMwxOqJfDAZtL1RFdqoFqFt+gYVw3h4oO/s7XUHUrr20w69Z4uY4nD7xoY
	 MBZQvpLz4gSpg==
Subject:
 Re: [PATCH net-next 6/6] selftests: net: getsockopt_iter: cover ip and ipv6
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
Date: Mon, 28 Sep 2026 18:55:51 +0000
Message-ID: <179062175174.3145.17201750089772911183@kernel.org>
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-6-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-6-c3ef2e3bb5c0@debian.org>
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

- [Low] The ipv6 fixture does not test the SOL_IPV6 length handling that
  the commit message describes.
- [Low] FIXTURE_SETUP(ipv6) sets IPV6_HOPOPTS and SKIPs the whole fixture
  if that fails.
- [Low] ip.mroute_wrong_type and ipv6.mroute_wrong_type read ENOPROTOOPT
  as "CONFIG_IP_MROUTE / CONFIG_IPV6_MROUTE disabled" and SKIP.
- [Low] The "roundtrip" and clamp tests check only return codes and
  lengths, not the data that comes back.

--

selftests: net: getsockopt_iter: cover ip and ipv6

This adds ip and ipv6 fixtures to the getsockopt_iter selftest. They
check the returned length and errno across buffer sizes, the branches
that answer empty, an unknown optname, and the MRT options dispatched
before the main switch.

> diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
> index 6c2408df46123..32b6e0a50f1f9 100644
> --- a/tools/testing/selftests/net/getsockopt_iter.c
> +++ b/tools/testing/selftests/net/getsockopt_iter.c

[ ... ]

> @@ -492,6 +499,301 @@ TEST_F(rawv6, bad_optname)

[ ... ]

> +/* The MRT_* options are dispatched ahead of the rest of the switch and
> + * want a raw IGMP socket. Without CONFIG_IP_MROUTE they are not
> + * dispatched at all and the switch answers ENOPROTOOPT instead.
> + */
> +TEST_F(ip, mroute_wrong_type)
> +{
> +	socklen_t optlen = sizeof(int);
> +	int val;
> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IP, MRT_VERSION, &val,
> +				 &optlen));
> +	if (errno == ENOPROTOOPT)
> +		SKIP(return, "CONFIG_IP_MROUTE disabled");
> +	ASSERT_EQ(EOPNOTSUPP, errno);
> +}

[Severity: Low]
Can this SKIP hide a regression in the early MRT dispatch? A kernel with
CONFIG_IP_MROUTE=n returns ENOPROTOOPT here. A kernel where a conversion
dropped or reordered this dispatch returns the same errno:

net/ipv4/ip_sockglue.c:do_ip_getsockopt() {
    ...
	if (ip_mroute_opt(optname))
		return ip_mroute_getsockopt(sk, optname, sopt);
    ...
}

Without that dispatch, MRT_VERSION falls through to the default case and
gets -ENOPROTOOPT. ip_getsockopt() then skips the nf_getsockopt() fallback,
because !ip_mroute_opt(optname) is false. The test sees ENOPROTOOPT and
skips.

ipv6.mroute_wrong_type does the same for the ip6_mroute_opt() dispatch in
do_ipv6_getsockopt(). There, nf_getsockopt() also answers ENOPROTOOPT for an
unknown optname.

tools/testing/selftests/net/config sets CONFIG_IPV6_MROUTE=y. So on a CI
kernel, the IPv6 skip would hide a real regression.

Could the tests tell these two cases apart, rather than treating every
ENOPROTOOPT as a config skip?

[ ... ]

> +FIXTURE_SETUP(ipv6)
> +{
> +	/* an 8 byte hop-by-hop header, so the sticky options answer */
> +	static const unsigned char hopopt[8] = { 0, 0, 1, 4, 0, 0, 0, 0 };
> +	int hops = 42;
> +
> +	self->fd = socket(AF_INET6, SOCK_DGRAM, 0);
> +	if (self->fd < 0)
> +		SKIP(return, "AF_INET6 dgram socket: %s", strerror(errno));
> +
> +	if (setsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, &hops,
> +		       sizeof(hops)) < 0)
> +		SKIP(return, "set IPV6_UNICAST_HOPS: %s", strerror(errno));
> +
> +	if (setsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, hopopt,
> +		       sizeof(hopopt)) < 0)
> +		SKIP(return, "set IPV6_HOPOPTS: %s", strerror(errno));
> +}

[Severity: Low]
Does this make the whole ipv6 fixture skip without CAP_NET_RAW? The
IPV6_HOPOPTS setsockopt is privileged:

net/ipv6/ipv6_sockglue.c:ipv6_set_opt_hdr() {
    ...
	/* hop-by-hop / destination options are privileged option */
	if (optname != IPV6_RTHDR && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW))
		return -EPERM;
    ...
}

When that returns EPERM, all nine ipv6 tests skip. Six of them never use
the sticky header: hops_exact, hops_oversize_clamped, pathmtu_undersize,
pktoptions_wrong_type, mroute_wrong_type and bad_optname. hopopts_absent
opens its own socket, so it doesn't use the header either.

The ip fixture sets a router alert IP_OPTIONS, which needs no capability.
So the two fixtures behave differently under the same privileges.

Could the IPV6_HOPOPTS setup move into the hopopts tests that need it?

[ ... ]

> +TEST_F(ipv6, hops_exact)
> +{
> +	socklen_t optlen = sizeof(int);
> +	int val = 0;
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, &val,
> +				&optlen));
> +	ASSERT_EQ(sizeof(int), optlen);
> +	ASSERT_EQ(42, val);
> +}
> +
> +TEST_F(ipv6, hops_oversize_clamped)
> +{
> +	socklen_t optlen = 64;
> +	char buf[64] = {};
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, buf,
> +				&optlen));
> +	ASSERT_EQ(sizeof(int), optlen);
> +}

[Severity: Low]
The commit message says:

    SOL_IP answers a sub-int buffer with one byte where SOL_IPV6 clamps the
    int.

ip.ttl_single_byte covers the SOL_IP half. Is there an ipv6 test for the
other half? The ipv6 fixture only has hops_exact and hops_oversize_clamped.
Nothing matches ip.ttl_single_byte, ip.ttl_zero_len or ip.negative_optlen.

So no test runs the clamping tail of do_ipv6_getsockopt() with a sub-int
buffer:

net/ipv6/ipv6_sockglue.c:do_ipv6_getsockopt() {
    ...
	len = min_t(unsigned int, sizeof(int), len);
	sopt->optlen = len;
    ...
}

An earlier patch in this series, "ipv6: reject a negative optlen in
do_ipv6_getsockopt()", added a negative optlen rejection. It now lives in
sockopt_init_user(), called from ipv6_getsockopt(), and nothing here tests
it.

rawv6.hdrincl_undersize_clamped doesn't reach this path either.
rawv6_getsockopt() sends IPV6_HDRINCL to do_rawv6_getsockopt() instead.

Would it make sense to add sub-int, zero-length and negative optlen cases
for IPV6_UNICAST_HOPS?

> +
> +TEST_F(ipv6, hopopts_roundtrip)
> +{
> +	unsigned char buf[64] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, buf,
> +				&optlen));
> +	ASSERT_EQ(8, optlen);
> +}
> +
> +TEST_F(ipv6, hopopts_undersize_clamped)
> +{
> +	unsigned char buf[4] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_HOPOPTS, buf,
> +				&optlen));
> +	ASSERT_EQ(sizeof(buf), optlen);
> +}

[Severity: Low]
Should these tests compare buf against hopopt[]? Both only check optlen.
ipv6_getsockopt_sticky() copies the data separately from returning the
length:

	len = min_t(unsigned int, len, ipv6_optlen(hdr));
	if (copy_to_iter(hdr, len, &sopt->iter_out) != len)
		return -EFAULT;
	return len;

A conversion that copied the wrong bytes, or skipped the copy entirely,
would still pass as long as the length was right.

The IPv4 tests have a similar gap. ip.options_roundtrip only checks
buf[0] == 0x94, and ignores the length byte and the value bytes of
ipopts[]. ip.options_undersize_clamped only checks the length. In both
cases the data comes from the copy_to_iter() of opt->__data in
do_ip_getsockopt().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0%40debian.org
