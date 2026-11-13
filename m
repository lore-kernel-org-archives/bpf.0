Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613999;
	b=SR84U2ak6rgb/UYnndeO21YzXMO1xn0moK/EWG/EJxrP11h8pm3VOtJW5fCDdHHZHbSe
	 Zi5VjbWPzdC8+jlp31bSguTR5cummFOzANXzmib317G7pMxbzOuj6n0b9VT6DUzrIOITt
	 DxQRt6Z4HdB3TrRBjrJCcEuM52nViuJdxuzhXGuaxQLU5VRypFkabg5xiSksSXJ47huR6
	 nGn0xMs0NuXWFpJBasYjg2+F7FskzwHCsRcG9tW0uDHsot7bKzLKqhMct6rDQoaW8wsb0
	 w5+W7bRY6hjVQuGPn04FJPVhMI9qoNJhSt392O5JzOwTeIGiIii+kjYDUyq8k1fboKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613999;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UO7zCD/dIdmHwhrdXFwbWOIaFNY3ih4tudZtgmKXEUw=;
	b=2st43GoksBDnxAQOJucKbjziICX65TX8mnngJjl9HYRp7XvluLwQ0l38L9H9Ufq3qvJg
	 FYxBsGMIOmO8cbFPw4gh49iwsefWQems8aZP2LqRqrgzj3KsghQ2j1SRt9CMvVJW3CVRP
	 vSPTU2zA18Pn52vxUbnZsYTVW0g6xgHupO7lE94qbJjl3s6ZT8q1s3SzWGPAdmpU85BUI
	 sR5uVwWuZWJL9YB1B5xJqA942AWIkW9MWqlr1JKyDqooHICEelq2WkMKNgQuhS0f4CeLM
	 l08UVd17p2VRPDEBF6kcTbVtTfgCysLm8cbWPw5NF7W4sDq2Y8ghCnoc/aemK1dxYmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVNyIedS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708D606A891;
	Fri, 13 Nov 2026 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVNyIedS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB061F000C9;
	Fri, 13 Nov 2026 23:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794613998;
	bh=UO7zCD/dIdmHwhrdXFwbWOIaFNY3ih4tudZtgmKXEUw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cVNyIedSVPLpDQ0RaCVl3M62/3SASAjvCWdUk8cop69qQl+JHHn2m2oJPbA9BOLvs
	 PwuEkt/HAic9grpGOOkb2eMYzh+BY5xEhFFDHAqt7Xo/U5B7HsTgE5B84eapfxsaTQ
	 sauJmAl2vf7lHFdnsFWRkUoLsl8aTUXZIxwonPGZomLx42RdU8uhQfxPgS5mqx1OBO
	 YPopFb9x8lr/0WtghAGQPkf0BaRVeUc0jBdDBAyBEOToeSFdcOQt6Fq47czmQIamZW
	 p8k1V50AR+0GEdiPqqmuserdM42IQmd4lfPL45AtQ+mMjMn9/UxUSOC/WLWxvpXSkU
	 TU2p8eHRy1gyQ==
Subject: Re: [PATCH net-next 5/5] selftests/bpf: check replacing and detaching
 XDP on a bond through a link
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 haiyangz@microsoft.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 23:53:17 +0000
Message-ID: <179461399762.2199510.9496726183772456630@kernel.org>
In-Reply-To: <20261112235027.4072149-6-kuba@kernel.org>
References: <20261112235027.4072149-6-kuba@kernel.org>
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

- [Low] The commit message of "selftests/bpf: check replacing and
  detaching XDP on a bond through a link" leaves out two things a reader…

--

selftests/bpf: check replacing and detaching XDP on a bond through a link

This adds an xdp_bonding_link_update subtest. The subtest attaches a
program to a bond through a link, replaces it with bpf_link_update(), and
detaches it with bpf_link_detach(). It checks that the veth slave follows
each change and that the replaced program is released.

> Check that the slave follows the replacement and the detach, and that
> the program which got replaced is released - the bond used to leak it.

[Severity: Low]
This isn't a bug, but could the message name the fix this test guards?
The leak appears to have been fixed by commit 184b5ddf82d4 ("bonding: fix
the program leak when XDP is replaced"). That commit's message says the
selftest would come in the net-next series.

The message also leaves out that the slave-side assertions depend on
"net: record XDP programs propagated to lower devices", which is earlier
in this series. The previous patch, "selftests/bpf: check XDP attach on a
nested bond slave", does name that dependency.

bpf_xdp_query_id(veth, XDP_FLAGS_DRV_MODE, &id) reads
dev->xdp_state[XDP_MODE_DRV] through
rtnl_xdp_prog_drv()->dev_xdp_prog_id().

Before that patch, netif_xdp_propagate() only called ndo_bpf() and never
recorded the program on the lower device. A bond slave therefore always
reported id 0.

In test_xdp_bonding_link_update() in
tools/testing/selftests/bpf/prog_tests/xdp_bonding.c, the first slave
check jumps to out before the leak check runs:

	err = bpf_xdp_query_id(veth, XDP_FLAGS_DRV_MODE, &id);
	if (!ASSERT_OK(err, "query veth") ||
	    !ASSERT_EQ(id, old_id, "veth runs the old program"))
		goto out;
	...
	fd = bpf_prog_get_fd_by_id(old_id);
	if (!ASSERT_EQ(fd, -ENOENT, "old program released") && fd >= 0)
		close(fd);

On a kernel that has 184b5ddf82d4 but not the propagation change, the test
fails at the first veth query and the leak assertion never runs.

Could the commit message reference both of these changes?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112235027.4072149-1-kuba%40kernel.org
