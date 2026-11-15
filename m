Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794762064;
	b=SeWTOSGhQTEaFvFxhJ8aHhQQuqrQilyR1Fuy2Jnt3aGtF/psJ+B6I8EO+eJuDEaYVVbm
	 Ogq8zVtSe0ey5qBxpNj98D6pmNeFnS3L7JnfrFPLIt6ue+iVLeZ16qrxK8CiXqOjqIENo
	 XBxP5PaUBzCK78GgU0pY7CGC8eVMC3/odgI6r/3aDmcTm6TUL6s4vKTMi2JaBevMKAa5E
	 aJxuCEnjlj8EvsXiDAVTQeOUDmbgkQ8kiuUNnJcvZs8GBqAjt5IzqKyrkRsJt4ukPfbU7
	 ONJoqeu9KnwUKYXwG6qozSQhDGrTfmPBEdNt+IJ75Q8YSjl/2x1//wHdFobKhz7ygog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794762064;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vlZl5lyf06RdJazenuU5uu1ZB2/A9/qrv1wTC/8Uozw=;
	b=o13MQrOrDAw/+LGOSyMAnqMk8wx40uIK7rkpwQO8mAjpKohDiGu2gCwg79jViFzERkvG
	 ta/r0igl1x0J03PZhrles1sbwhYTVX7zcUTBovSOYnzBJajwH67EcCDPoU+AjSXJzhpki
	 LnHXO1y7jOUDDF17Ci+PSKV1YbAd96XT+xLn/o965tXZESODEUy0x94xZjH00ZVSczMUW
	 yZLINvHRRxTJAYfazEcGxJsN5bBqdpAFf3Dvs8jQlIc33WiZJCBR+MuSn95dri9IybTdq
	 jPzOArV0Z75dCQ8Ah7orVrxG8M39nxsG9ptLao68Lpt6uLVo307NYp37BBoUMg6Izjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmVluvr9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99EF606A31F;
	Sun, 15 Nov 2026 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmVluvr9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B70A1F000C4;
	Sun, 15 Nov 2026 17:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794762064;
	bh=vlZl5lyf06RdJazenuU5uu1ZB2/A9/qrv1wTC/8Uozw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gmVluvr9Qad3/lxS3sb/8u4thCf/3QNGBR2/ohidWYqSHICI9N0UpVtAfWeyH9m5N
	 aoW+u2icFuLdYPRiim+Swdxu2N/HQvonFUUSxy1+aj2DUW8O93zSYhcCzMMaPqQ6o0
	 ViP6pc+qcn0P0YEfOD8NgUJ7FhN00DlQctsglE4bFoZHSF/B39Fi5oCJgmj0O07+uy
	 hUYJOk/UCZccG/HHysttMpjsfp7vcIoxlzEI7NDjiP/+4hqhDM9WIqC3AF+xZGq/gh
	 9V5dLKey+nnoMIIEGsSqFxbfE1nr/MTixiK9wdEOb+pnnxaPgTc8KrzGtLO/jjjvYO
	 AQidKyzVH5Law==
Subject: Re: [PATCH net-next 3/3] selftests: net: getsockopt_iter: cover tcp
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 ncardwell@google.com, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Date: Sun, 15 Nov 2026 17:01:02 +0000
Message-ID: <179476206200.2199510.1878424671448402630@kernel.org>
In-Reply-To: <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>
References: <20261112-getsockopt_phase7-v1-3-1eb759dd0929@debian.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In tools/testing/selftests/net/getsockopt_iter.c, the test
  tcp/nodelay_undersize_clamped is commented "Unlike IPv4, TCP clamps…
- [Low] In tools/testing/selftests/net/getsockopt_iter.c, the test
  tcp/zerocopy_receive_oversize_clamped is commented "A larger struct is…

--

selftests: net: getsockopt_iter: cover tcp

This commit adds a tcp fixture to the getsockopt_iter selftest. The fixture
sets up a loopback connection with TCP_SAVE_SYN on the listener. The new
tests cover do_tcp_getsockopt() clamping, zero-length replies, the
TCP_SAVED_SYN length-then-EINVAL path, and the TCP_ZEROCOPY_RECEIVE struct
size handling.

> diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
> index 2367fce226d4c..4e51c8aa6a855 100644
> --- a/tools/testing/selftests/net/getsockopt_iter.c
> +++ b/tools/testing/selftests/net/getsockopt_iter.c

[ ... ]

> +/* Unlike IPv4, TCP clamps the reply rather than shrinking it to a byte. */
> +TEST_F(tcp, nodelay_undersize_clamped)
> +{
> +	socklen_t optlen = 1;
> +	int val = 0;
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_NODELAY, &val,
> +				&optlen));
> +	ASSERT_EQ(1, optlen);
> +}

[Severity: Low]
Does this test actually show the difference the comment describes?

With optlen = 1, both paths report the same length. do_tcp_getsockopt()
clamps:

net/ipv4/tcp.c:do_tcp_getsockopt() {
    ...
	len = min_t(unsigned int, len, sizeof(int));
    ...
}

and do_ip_getsockopt() also ends up with optlen = 1:

net/ipv4/ip_sockglue.c:do_ip_getsockopt() {
    ...
	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
		unsigned char ucval = (unsigned char)val;

		sopt->optlen = 1;
    ...
}

So if TCP started shrinking sub-int replies to a single byte the way SOL_IP
does, this test would still pass.

The ip/ttl_single_byte and ipv6/hops_sub_int tests in the same file use a
3-byte buffer, which does tell the two apart. Would optlen = 2 or 3, with a
check that optlen is unchanged, match the intent of the comment better?

[ ... ]

> +/* A larger struct is cut down to the kernel's, if its tail is zero. */
> +TEST_F(tcp, zerocopy_receive_oversize_clamped)
> +{
> +	char buf[256] = {};
> +	socklen_t optlen = sizeof(buf);
> +
> +	ASSERT_EQ(0, getsockopt(self->fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
> +				buf, &optlen));
> +	ASSERT_GE(optlen, sizeof(struct tcp_zerocopy_receive));
> +	ASSERT_LT(optlen, sizeof(buf));
> +}

[Severity: Low]
Should this assert the exact clamped length? When the tail is zero, the
kernel sets optlen to the size of its own struct:

net/ipv4/tcp.c:do_tcp_getsockopt() {
    ...
	if (unlikely(len > sizeof(zc))) {
		...
		len = sizeof(zc);
		sopt->optlen = len;
    ...
}

That is the uapi struct tcp_zerocopy_receive from include/uapi/linux/tcp.h,
which is 64 bytes.

The test includes netinet/tcp.h, so sizeof(struct tcp_zerocopy_receive) here
is the 16-byte glibc struct the commit message mentions. That means any
optlen from 16 to 255 passes. A clamp to the wrong size, such as one of the
older 16 or 40 byte layouts, would not be caught.

raw/icmpfilter_oversize_clamped in the same file uses ASSERT_EQ against the
exact struct size. Could this test do the same with the kernel struct size
(64)?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-getsockopt_phase7-v1-0-1eb759dd0929%40debian.org
