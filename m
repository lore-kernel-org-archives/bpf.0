Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329C2444713;
	Sat, 10 Oct 2026 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623583; cv=none; b=jZ5SQFqJC3L7NbuF/ZMVIfw+TxUgZ+ifiH90CPw4AsEIjaRUyHGeTpBtxQu7rfn8aurtBoztqGYnh37C1QjL84WIcRzzoxna+RKtuD+p9UFbvlPo2BeAyxiAG8tRc/vYDaUK2w0YWvu7X0i1iXyqcKvSKuxgnaekjmsoJBoTQsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623583; c=relaxed/simple;
	bh=ND1giJhTP5OlB71Z5D8wkAfOiW7LSG4QZd78LP0fgiw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pfcHMaU5QlDjl/8JgCXEXA3dSIIA3MdrAegw/JdiLPaZazRONUnLx6/LAK0UPU6YwcQNYEq87qQUVgr4UdxS9ALVqJg/mZcMCRTeOUeoCTZOwrL68tA6p4pWsObv2+UmEVw37iPhCKWbSoqVY69ONR5r8L7J+La7PyN3KhW4GpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn/wbT1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn/wbT1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778C61F000FF;
	Sat, 10 Oct 2026 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791623581;
	bh=FUG+gz+C80r+8tdjKS4k5zRgWIFK6yUZeC4/dP/SevQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bn/wbT1PZ6OSWE28WoX/9oUAZNC9n0jMK0jyqs1kbReTKXkDFtYNuNIzmb4sk3Kxz
	 rZ7IOhUlrLVcb3IzciYrEbC5zBxk6FOFD4/w7kANaTk1Zb3Du+7SxKwSTnUawg2yhx
	 9EqmaWS1Htahy+MlM5owxoIt6snurWFaMGRKfUGholAVtANPnbjl5OeQUGWAiXCXMc
	 izctduhAx6bBzNbuyG1OJHsFR0rHqIMII+WPgb/hljsQAkCgB9jSFah4ZMFRMUv4bm
	 Ejl1D85WnOmH0j2U/AcENAG7jkV18cKaitZ///5GPYytJgrUzPcy0aga+hFPvG2dDR
	 HM+MyAtyFM4ZQ==
Subject: Re: [PATCH net-next v2 7/7] selftests: net: getsockopt_iter: cover ip
 and ipv6
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
Date: Sat, 10 Oct 2026 09:12:58 +0000
Message-ID: <179162357899.434549.5846968713018971046@kernel.org>
In-Reply-To: <20261009-sockopt_expand_out_v2-v2-7-8ac08c469ecb@debian.org>
References: <20261009-sockopt_expand_out_v2-v2-7-8ac08c469ecb@debian.org>
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

- [Low] In tools/testing/selftests/net/getsockopt_iter.c, the ipv6
  fixture's negative_optlen test only exercises IPV6_UNICAST_HOPS.
- [Low] The new TEST_F(ip, mroute_wrong_type) needs CONFIG_IP_MROUTE: it
  skips when /proc/net/ip_mr_vif is missing.

--

selftests: net: getsockopt_iter: cover ip and ipv6

This adds ip and ipv6 fixtures to getsockopt_iter. They check the
returned length and errno for several buffer sizes, for the branches
that answer empty, for an unknown optname, and for the MRT_*/MRT6_*
options dispatched before the switch. The MRT tests skip when
/proc/net/ip_mr_vif or /proc/net/ip6_mr_vif is missing.

> diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
> index 6c2408df46123..252a46d44e522 100644
> --- a/tools/testing/selftests/net/getsockopt_iter.c
> +++ b/tools/testing/selftests/net/getsockopt_iter.c

[ ... ]

> +/* The MRT_* options are dispatched ahead of the rest of the switch and
> + * want a raw IGMP socket. Without CONFIG_IP_MROUTE they are not
> + * dispatched at all and the switch also answers ENOPROTOOPT, so the
> + * config check has to come from somewhere other than this errno.
> + */
> +TEST_F(ip, mroute_wrong_type)
> +{
> +	socklen_t optlen = sizeof(int);
> +	int val;
> +
> +	if (access("/proc/net/ip_mr_vif", F_OK))
> +		SKIP(return, "CONFIG_IP_MROUTE disabled");

[Severity: Low]
Should tools/testing/selftests/net/config also get CONFIG_IP_MROUTE=y?

The config fragment already has this line:

    CONFIG_IPV6_MROUTE=y

It has no CONFIG_IP_MROUTE entry, though, and nothing in net/ selects
IP_MROUTE. So whether this test runs depends on the base config.
x86_64 and i386 defconfig enable it, but arm64 defconfig does not. On
an arm64 kselftest-merge build, /proc/net/ip_mr_vif is missing and
ip.mroute_wrong_type always skips, while ipv6.mroute_wrong_type runs.

The commit message says:

    A kernel with CONFIG_IP_MROUTE or CONFIG_IPV6_MROUTE built in no
    longer hides that regression behind a skip.

With the current fragment, the selftest config only builds such a
kernel for IPv6.

> +
> +	ASSERT_EQ(-1, getsockopt(self->fd, SOL_IP, MRT_VERSION, &val,
> +				 &optlen));
> +	ASSERT_EQ(EOPNOTSUPP, errno);
> +}

[ ... ]

> +/* Unlike SOL_IP, a negative optlen has always behaved as 4 here. */
> +TEST_F(ipv6, negative_optlen)
> +{
> +	socklen_t optlen = (socklen_t)-1;
> +	int val = 0;
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, SOL_IPV6, IPV6_UNICAST_HOPS, &val,
> +				&optlen));

[Severity: Low]
Does this test cover the negative optlen change made earlier in this
series?

IPV6_UNICAST_HOPS is an int option. Before the series, it already
turned a negative optlen into 4 through:

    len = min_t(unsigned int, sizeof(int), len);

The earlier patch "ipv6: treat a negative optlen as 4 in
do_ipv6_getsockopt()" added this in ipv6_getsockopt() for every option:

net/ipv6/ipv6_sockglue.c:ipv6_getsockopt() {
    ...
	/* Historic bug compatibility: the int options have always taken a
	 * negative optlen as 4, so take it as 4 everywhere.
	 */
	if (len < 0)
		len = 4;
    ...
}

According to that patch's commit message, a negative optlen now cuts
sticky headers such as IPV6_HOPOPTS to 4 bytes. It also makes
IPV6_PATHMTU and IPV6_FLOWLABEL_MGR fail with -EINVAL.

hopopts_roundtrip, hopopts_undersize_clamped and pathmtu_undersize all
pass a positive optlen. If the clamp were removed or broken later,
ipv6.negative_optlen would still pass.

Could a negative optlen case be added for IPV6_HOPOPTS or IPV6_PATHMTU?

Also, the kernel comment limits "always" to the int options. The
comment above this test does not, so a reader may think SOL_IPV6 never
changed how it handles a negative optlen. Could the comment say this
only holds for the int options?

> +	ASSERT_EQ(sizeof(int), optlen);
> +	ASSERT_EQ(42, val);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-sockopt_expand_out_v2-v2-0-8ac08c469ecb%40debian.org
