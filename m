Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613996;
	b=W41uUUhTbziAqHt62G18fa7LPuKKQcWIEnKfbD2pB9QitG19gMiTqMCYSvcKsW+KNzSB
	 tRZsXTETz7LdFNPFeC5X8CKX8HaS/kSaO+oopo4FESEWVGGcW//OJCP7MLE0Sx7rXl51E
	 BTk444Bip5iI5izthaLyTR0ICN1gt+AmGjJw/0h7rFGZvHG6lY6VpPU4gPrijSqOdw5YW
	 wmEVjzowOWISrhohP79+NxAP27lGsu5z7wWhNBM/FPWd8LhCtPyitkFHaizMJhCBGqkP+
	 W6vKWT8zaeF0OfSkZiRFm9Fq/CCy63CmF4AtZv6p1AtbmKPnp7Px7+b9yko50wV+5lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613996;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LJx81VRcAx9Lj2nt6V6VRg7S2qbY7x1uKPTabp9ywdo=;
	b=f5eVhW+wkMta4EEVAS9nQgFnWRidFYSaWvD4hJGIvaIV6hCAD9jXZtcOzLWaqEIxYBIW
	 S7PlO7Nah/IGbPt3aZ2/NwQm8Dmmu0Qahge6VXovbpgiMy/zFKFb/d/nP4BkpBCvQ3UUj
	 ZtsmIJlD5KFAuYB8pZWdAi8ieGswmMJKBF5km3+jGhiUYb0pFphn0/8i6mQ1PxkmrAZ6e
	 dDs/D1/RRLJNzfERlB59Ua5AFkfMhbKVA/MsK9l/aWqmFaH1G6db4kF+e7pXr1+6iBUEc
	 xZ/uWTK/dNZTNo2/nQFya4e1SN+0I4aIb7HE2+TzAojAJF3S8NUd4ZeK0HqRMuwvNdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4um6IwA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C7606A323;
	Fri, 13 Nov 2026 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4um6IwA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D8C1F000C4;
	Fri, 13 Nov 2026 23:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794613996;
	bh=LJx81VRcAx9Lj2nt6V6VRg7S2qbY7x1uKPTabp9ywdo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H4um6IwAktFEaVD+58UoC/IAWNYoTtQ1GAWIMXncgBSzfITMoFgirSqpK4tnXAPnc
	 gwK8NGVclh++0ooTpk2RzDhaD+J9kjsAg2/61O11fl16YpJxeY7F1amyEOk/ZnnL3U
	 YbyEUBbBBsA8r4uvg5vfR2eZ6FCtLsqqP5JmDvzOBvc7qFBzF7X+MYUaJJGJDTZLsx
	 fsmjs2wlDmhKIv9mbVyVMjYC1pTpRF6Np0H9MlkXKZlfkl2qAFzRLGgvbdBjatJ9jK
	 I0L/b9XSBGyj5dKAwQWTTsNb6ZO+0w4D1O69wXeQa5V6NDA+hwDZwHZ5dWnoOF1iTQ
	 4WhTuRpGVvoVg==
Subject: Re: [PATCH net-next 1/5] net: don't safety-check device features for
 XDP uninstall
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 haiyangz@microsoft.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 23:53:14 +0000
Message-ID: <179461399476.2199510.18058765948144630080@kernel.org>
In-Reply-To: <20261112235027.4072149-2-kuba@kernel.org>
References: <20261112235027.4072149-2-kuba@kernel.org>
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

- [Low] The commit message of "net: don't safety-check device features
  for XDP uninstall" calls the change a "refactoring / consistency…

--

net: don't safety-check device features for XDP uninstall

This moves the tcp-data-split and memory provider checks in
dev_xdp_install() and netif_xdp_propagate() under "if (prog)", so they
only run when a program is being installed. netif_xdp_propagate() also
now hands commands other than XDP_SETUP_PROG straight to ndo_bpf.

> This way we don't have to worry about triggering WARN()s
> on cleanup paths mistakenly trying to un-install a program
> when there is none, and failing because device has a memory
> provider.
>
> This is a refactoring / consistency cleanup, later patches
> don't depend on this change.

[Severity: Low]
Is this really only a cleanup? It looks like it also fixes an XDP
uninstall failure that can be hit in the current tree.

Before this patch, netif_xdp_propagate() ran the memory provider check
unconditionally, so it also refused to propagate prog == NULL:

net/core/dev.c:netif_xdp_propagate() {
    ...
	if (dev_get_min_mp_channel_count(dev)) {
		NL_SET_ERR_MSG(bpf->extack, "unable to propagate XDP to device using memory provider");
		return -EBUSY;
	}
    ...
}

A lower device can run a program propagated from an upper device and
also have a memory provider bound. At this point in the tree,
netif_xdp_propagate() does not record the propagated program in the
lower device's xdp_state, so the reverse checks pass.
__netif_mp_open_rxq() only checks dev_xdp_prog_count(dev), and
ethnl_set_rings() only checks dev_xdp_sb_prog_count().

When a bond slave is in that state, removing XDP from the bond fails:

  bond_xdp_set(bond_dev, NULL)
    dev_xdp_propagate(slave_dev, &xdp)    /* xdp.prog == NULL */
      netif_xdp_propagate()
        dev_get_min_mp_channel_count(dev) != 0 -> -EBUSY

bond_xdp_set() then rolls back, so XDP cannot be removed from the bond.

In __bond_release_one() the same failure only prints a warning:

	if (dev_xdp_propagate(slave_dev, &xdp))
		slave_warn(bond_dev, slave_dev, "failed to unload XDP program\n");

The released slave keeps running the bond's program, and nothing about
it is in the slave's xdp_state. The program then cannot be seen or
removed through that device. netvsc_vf_setxdp(vf, NULL) fails the same
way.

The check being relaxed here came from commit 170aafe35cb9 ("netdev:
support binding dma-buf to netdevice"), which is in current LTS trees.

Should this patch have a Fixes: tag for that commit? Could the commit
message also describe the uninstall failure, rather than calling the
change a refactoring?

A later patch in this series, "net: record XDP programs propagated to
lower devices", fixes the root cause (a memory provider coexisting with
a propagated program). That patch has no Fixes: tag either.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112235027.4072149-1-kuba%40kernel.org
