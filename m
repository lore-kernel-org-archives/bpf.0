Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98EF39734E;
	Wed, 30 Sep 2026 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743097; cv=none; b=W4QD8srKpUCsUB95UM5xme2+ekkMDrP1Y2fwNWoerv1Mug36VUy7LYNTE0Ge3QjHAzJBX/x52vkUpDwhWrjctuhpkejXSeJAVlY7hPEWOV8a9MfM8vRokDdzZHhRJNxvHLl4/c+t7+dwPOl8xffFX2fTQ3/mRgkNjNDCQm6fSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743097; c=relaxed/simple;
	bh=KJWFaIPO7DIN2wgaorX8AfU+BU2orI5fAfBjsbOyH6U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEqkNjs6xMZ4xwwlYdSFjyZ0NdzWW+g4jpDMw/usY9YJqhVlnhbM7o4b6TfEe21i9YrhuwvZ0VoMyKf8X103PPEvzkAAJiZgsQNmIk/Xk8ecMgzivTK3AfznlHUULh0c/mF6761SDdDJRjnkg1S41EqA6y+1RHjNwxsInDhep+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEbdJsNe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEbdJsNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858411F000FF;
	Wed, 30 Sep 2026 04:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743095;
	bh=AzmSAnPbPGl8lJnzyiXzL8GoB+Sc8WOAqFGO7DEqMLo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OEbdJsNeDiFVmDvlpanZyzf9dDgYQ3tG58j+PZFlKIj01odRNroqibYtkN1BgRvKj
	 YWRh3iGM3DnVUsTuFqDBWFN88Cj6ni4Qy3PGtSB3Xi5aAkIpydmcBPPg2zS7ijIWyT
	 umSiaE87Fe7YipcWzYtpUruT9te9inUPkzkmImi9ihNHfRiN80PKOp6Tf9ROrCw/o4
	 Qg5Wq1tTNkMoLklEYTTRMXidwivQpubjXM/fnibnkN6lN1z0BQPke07v+AonUL5AXu
	 64m1BLX6II3/Uq8Bz3UhFrfbIppItWDUtmUbAzOAF4TICplInCxxL0ueluuOr27jNI
	 szqxY5KVowYYg==
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: check tcp-data-split
 against an already attached XDP
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, aleksander.lobakin@intel.com
Date: Wed, 30 Sep 2026 04:38:14 +0000
Message-ID: <179074309407.434549.3573384940642371107@kernel.org>
In-Reply-To: <20260928223648.2739371-4-kuba@kernel.org>
References: <20260928223648.2739371-4-kuba@kernel.org>
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

- [Low] In tools/testing/selftests/drivers/net/hds.py, xdp_bond_set_hds()
  (lines 298-301) wraps `_xdp_attach(cfg, "hds-bond")` in a bare `except…

--

selftests: drv-net: check tcp-data-split against an already attached XDP

This adds two hds.py cases covering the reverse direction of the
HDS/XDP rule: enabling tcp-data-split must fail once a single-buffer XDP
program is running on the device. xdp_set_hds() attaches the program
directly. xdp_bond_set_hds() installs it on an active-backup bond, which
pushes it down to the device.

> diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
> index 606e26d75951f..5fe82b98c1fbf 100755
> --- a/tools/testing/selftests/drivers/net/hds.py
> +++ b/tools/testing/selftests/drivers/net/hds.py

[ ... ]

> +@ksft_disruptive
> +def xdp_bond_set_hds(cfg, netnl) -> None:
> +    """
> +    Like xdp_set_hds(), but the program is installed on a bond and pushed
> +    down to the device rather than attached to it directly. The device is
> +    running it either way, so HDS must be refused all the same.
> +    """

[ ... ]

> +    ip("link set dev hds-bond up")
> +
> +    try:
> +        _xdp_attach(cfg, "hds-bond")
> +    except CmdExitFailure:
> +        raise KsftSkipEx("device can't be an XDP bond slave")

[Severity: Low]
Is this skip too broad? Any failure of "ip link set dev hds-bond xdp obj
... sec xdp" is reported as a SKIP here, and that includes failures in the
propagation path this test is meant to cover.

The skip message only matches one refusal in bond_xdp_set():

drivers/net/bonding/bond_main.c:bond_xdp_set() {
    ...
	if (!slave_dev->netdev_ops->ndo_bpf ||
	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
		SLAVE_NL_ERR(dev, slave_dev, extack,
			     "Slave device does not support XDP");
		err = -EOPNOTSUPP;
    ...
}

The same command also fails if netif_xdp_propagate(), which the previous
patch rewrote, wrongly refuses the program:

net/core/dev.c:netif_xdp_propagate() {
    ...
	if (bpf->prog && dev_xdp_has_own_prog(dev)) {
		NL_SET_ERR_MSG(bpf->extack,
			       "unable to propagate XDP to device with an XDP program of its own");
		return -EBUSY;
	}
    ...
}

It also fails if the lower driver's ndo_bpf fails, or if the
hds_config or memory provider check rejects the program by mistake.

Now that netdevsim has ndo_xdp_xmit, the attach should always succeed
there. A failure on netdevsim would be a kernel regression, but this
test would report it as SKIP rather than FAIL.

Attach failures are also handled differently in the two new tests.
xdp_set_hds() calls _xdp_attach() without a guard, so a failure there is
reported as FAIL.

The regression named in the commit message (HDS accepted under a
propagated program) is still caught, because in that case the attach
succeeds and _hds_enable_expect_fail() fails. The selftests/bpf
xdp_bonding tests, which a later patch in the series extends with a
nested-bond case, cover some of the attach path too.

Could the skip be limited to the "Slave device does not support XDP"
case, for example by matching that extack text in the CmdExitFailure
output, or by checking the lower device's capabilities first? Other
failures would then be reported as FAIL.

> +
> +    _hds_enable_expect_fail(cfg, netnl)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928223648.2739371-1-kuba%40kernel.org
