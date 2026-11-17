Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926414;
	b=JfZ3GdlNpMvYMQ9EejZahmNJZYWcTvIX+BrMxPdxpVy5Z4XZRq9ikcyKGNhmnIoo5ebU
	 ocsPraBTLpy+XlVZoqdiOLfBVsiHdyuxE8mGcc8CsKFTd4vstObP74roUFsRnS0/toUsJ
	 XUmnSCyvIuMArneWhegre2N8NviDSCW1EU6yW5R4FBk0uyDZKBGWZgD6Im1+kIN1xzbbW
	 6fJms2HeK8lRL5tQq293Weha/N1N2jPUpBrOcyzBf4hIlJAkcRxRZvqXSwxhA2xe1m3Ix
	 qvmhELteRltSjgdKi7vqtzi2vS4e2hzPtpPNxgI+CecLyhecsYfvIMZ00IfWqINbziw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926414;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WthlfORmHr381B6mMH+xwS5vVfrpofwjdyuXKbp+s14=;
	b=TzqzKreyeHSrKKVntOvLDSLA/xt4DqKfbkB017ztnNoCmkVL3QpzdAzybJkVYfQ84Hud
	 3UAl7eKEl2MHcCSQ+xcXVidoQWtC9pG91wAbNDHMCgKyCn35GLex3/kj7kkKsUV7hvqZP
	 RjdzKKQlUcOmsWupz1q/zBlSdTMhNJ+09kstKXjbOiBnNxcYsdfUL+aAUaKkaTBoIjVwr
	 vGBDPSsFvAZ1sfNb4vaRcc7Nafrue0KFIHYfwmVOVGnDJO7WNixXsLpc3sxzUz38p1z4y
	 w0TdvLgoH4DeN6heAX6SC4cy85XGA2Vv5WUx8Hgc0O0lIaRR7ebd0qH5Tco7Zd9Rv8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SF4UFEju;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B55606A88A;
	Tue, 17 Nov 2026 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SF4UFEju
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5521F000C4;
	Tue, 17 Nov 2026 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794926414;
	bh=WthlfORmHr381B6mMH+xwS5vVfrpofwjdyuXKbp+s14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SF4UFEjunxygYzlzdr2ZZ1qyS6uV97tC+HamldVnYUmAo8epAwNKOJDgqQBbjAfgV
	 L5aQ0TFL4OxEnBSZsgmTcDv1QPtFQYjmXZVi1hodepSXmVWd61n/WJ0KaIF0RivKpZ
	 6zxI2uQSs2yO8JuwS9/B93jdORcpp58q9Zl2gPzQPpsm7oBq5AsVQzgaSMKIlIk9uT
	 emuJ1XSy0qwLn4+XGA6U0b+Csph+C+pNjlLW9x+oDOpugQVm0u6jmRfufC6tnuOSQa
	 7ZEDz9TthdcPvEFuvF6ZlfpNU8GkCk269U/R87veEkDsljpyaJOaqRJEaVZmISEprT
	 /ZnHmPNZEyk7g==
Subject: Re: [PATCH net-next 6/6] bonding: factor out bond_enslave_validate
From: netdev-bot+sashiko@kernel.org
To: hangbin.liu@linux.dev
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Tue, 17 Nov 2026 14:40:13 +0000
Message-ID: <179492641344.3136.5360540192397591551@kernel.org>
In-Reply-To: <20261113-bond_enslave_restruct-v1-6-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-6-364c549e78db@kylinos.cn>
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

- [Low] The commit message says the new bond_enslave_validate() helper
  (drivers/net/bonding/bond_main.c) does "all read-only checks".

--

bonding: factor out bond_enslave_validate

This commit moves the fail-fast checks at the top of bond_enslave() into
a new static helper, bond_enslave_validate(), in
drivers/net/bonding/bond_main.c. Behavior does not change. The moved
block runs from the ARPHRD_CAN check through the bond_slave_xdp_check()
call.

> bond_enslave() is a long linear function whose flow is hard to see
> behind the inline blocks. Factor out bond_enslave_validate to do
> all read-only checks.

[Severity: Low]
Is "all read-only checks" accurate here? The patch moves only the checks
that already ran before the first mutation. Several other checks that
only read state are still inline in bond_enslave().

Two of them run before any mutation:

drivers/net/bonding/bond_main.c:bond_enslave() {
    ...
	if (!bond_has_slaves(bond)) {
		if (bond_dev->type != slave_dev->type) {
			if (slave_dev->type != ARPHRD_ETHER &&
			    BOND_MODE(bond) == BOND_MODE_8023AD) {
				SLAVE_NL_ERR(bond_dev, slave_dev, extack,
					     "8023AD mode requires Ethernet devices");
				return -EINVAL;
			}
    ...
	} else if (bond_dev->type != slave_dev->type) {
		SLAVE_NL_ERR(bond_dev, slave_dev, extack,
			     "Device type is different from other slaves");
		return -EINVAL;
	}
    ...
}

The infiniband mode check only reads slave_dev->type and BOND_MODE(bond).
It runs after the first-slave type change block, though, and exits
through err_undo_flags:

	if (slave_dev->type == ARPHRD_INFINIBAND &&
	    BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
		SLAVE_NL_ERR(bond_dev, slave_dev, extack,
			     "Only active-backup mode is supported for infiniband slaves");
		res = -EOPNOTSUPP;
		goto err_undo_flags;
	}

For a first slave, the bond has already gone through
NETDEV_PRE/POST_TYPE_CHANGE, dev_uc_flush()/dev_mc_flush() and
bond_setup_by_slave() at that point. err_undo_flags then calls
dev_close(bond_dev) and bond_ether_setup(bond_dev). This behaves the same
before and after the patch.

The fail_over_mac check after it also only reads state.

The helper's own code comment, and the "Failures return directly, no
undo needed at that point" sentence, are accurate for what the helper
contains.

Could the commit message say that the helper holds the checks that run
before the first mutation, rather than all read-only checks?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-bond_enslave_restruct-v1-0-364c549e78db%40kylinos.cn
