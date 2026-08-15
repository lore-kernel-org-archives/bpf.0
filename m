Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3238F255
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786781696; cv=none; b=gZBDkY78MTn4p6KXeVU5C2M1A9+zxkeWjca/IIyeo47ZQG9+GvifnzQZb6gHZ2Mo1x29cK1UbIxTPr2JREj0CzSh891/i0RXoY5ld0fEwH/HpOQikuSzcW5Zu2LvfThYGmW84mb7oy0l/I3GYVXLa5FXwoekLGpbsPH7uKuBMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786781696; c=relaxed/simple;
	bh=aguPrnnf1Aa7cePPgUXe7QqiG54Zw8yxMFbtRFxQZws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AHF0tZDX58DEhsrreQOvzvereVtuP+RrliUG1cdpTyek1tpE7juR+QYcEqB127mo5+2QwURp02x1RmlMa0Hoi4QGqL3o1glRHynyOd/i/j/0KbzZDsVe3bJ9ITuDSZ638dSNt/1oxNdTAfu93Rxs1xNxbUnbh1guw9d1v0CnZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPdru9cO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPdru9cO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAD01F00A3A;
	Sat, 15 Aug 2026 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786781695;
	bh=766n17FWqf3j+MVMGGYL+WanX6DTivBKvGuXOMz/QMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPdru9cOGqB7GqMiPJ8zoo+yBm+qg0o2end90/qh9yxzQFxJIf4195u4NbpkHSkyT
	 Z1FXeKD7tgnH6eyFdlVYKITDNw8gVlpMFRY14XBmA/IUHz1BHO+YF4j5OY91uo0kwJ
	 yaA4FFcmgbhc3ClO+sR7OssouXy/EZ9KBbk6UhBPhn0sYmZhtCJOmRK1aKPJtrWQ96
	 cD7rqxLNzzRxV0sXLCJlskBfYemOHjSFfIwE3CAfYpTGZa620gnD1i1DvArwWsjhJ8
	 xz0Hgk51a86sLbIShE5Q62VVjYEnJXKMT4H6T2bLjefej2Fb+HqNnkXxftcAJwyx99
	 5aTXR396mzBWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 09/14] selftests/bpf: Test skb_ext read from
 kfree_skb tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260814-bpf-meta-inside-skb-ext-v1-9-767edd862656@cloudflare.com>
References: <20260814-bpf-meta-inside-skb-ext-v1-0-767edd862656@cloudflare.com>
 <20260814-bpf-meta-inside-skb-ext-v1-9-767edd862656@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 08:14:54 +0000
Message-Id: <20260815081455.3DAD01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing validation of `recv()` failure before reading `errno`.
- [Medium] Missing return value check for `send()` can lead to infinite tes=
t hang.
--

--- Patch [9]: [PATCH net-next 09/14] selftests/bpf: Test skb_ext read from=
 kfree_skb tracepoint ---
commit 8897bd2269141881d412c939eda870a1cef5354d
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test skb_ext read from kfree_skb tracepoint

This commit adds a test that writes skb_ext at cgroup/skb egress, sends UDP
to a closed loopback port so the packet is dropped, and reads the extension
back from a tp_btf/kfree_skb program.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index e0ab0fccf9d7e..1e4e12d2b041c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
[ ... ]
> @@ -1186,6 +1186,69 @@ static void test_skb_ext_tcp(struct test_xdp_meta =
*skel, const char *name,
[ ... ]
> +static void test_cgrp_egress_to_kfree_skb(struct test_xdp_meta *skel)
> +{
[ ... ]
> +	ret =3D connect(fd, (void *)&addr, sizeof(addr));
> +	if (!ASSERT_OK(ret, "connect"))
> +		goto cleanup;
> +
> +	send(fd, test_payload, TEST_PAYLOAD_LEN, 0);

[Severity: Medium]
Is there a risk of an infinite hang here if send() fails locally?
If send() fails (for example, due to local buffer exhaustion or routing
issues), the packet is never sent, and the kernel will not generate the
expected ICMP error. Consequently, the test might hang indefinitely in the
subsequent blocking recv() call.

> +
> +	/* Wait for ICMP error -- confirms the packet was freed */
> +	ret =3D recv(fd, buf, sizeof(buf), 0);
> +	ASSERT_EQ(errno, ECONNREFUSED, "recv_econnrefused");

[Severity: Medium]
Should ret be checked for -1 before evaluating errno?
According to POSIX semantics, errno is only meaningful if a system call
returns an error. If recv() happens to succeed (for example, by receiving
a stray UDP packet), errno will contain a stale value, which could cause the
test to spuriously pass or fail.

> +
> +	ASSERT_TRUE(skel->bss->test_pass, "test_pass");
> +
> +cleanup:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-bpf-meta-i=
nside-skb-ext-v1-0-767edd862656@cloudflare.com?part=3D9
