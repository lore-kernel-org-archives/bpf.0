Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794665211;
	b=ceH67phqn+P4sPOOKaC4mKIZZV1MjQ0gXrozP4FjmsUuvOj+BZVlcvvohtlLte3+JjQI
	 lAKjy3mjg93OGRfyi7tM4emLDME18HdefnPkicslzzncPk1HrmSGoiyeQUnhGqDkT3zxP
	 T0vHW7QExRhK94B5zkQa6wgQwe2fr1x5KmDJamN2+KQkisEhYgMz+MiQHMO6zWOfVQVEu
	 /g4rjIsxHJM+G05siU38qWH4/V0+OtohPNnheyhmFhQ6H2ZsnSAYKgRonGWOM5UG3LoE+
	 733cRqLzV1nL7vmaxUap7ckHzTieE2FPa/daql/UgPGf55oPtDzzJQIN74Q/6tFuQtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794665211;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+b+IR0Sc9aIyrc9NQuKmEzFBz/W8nHq32ixnl1kXGFQ=;
	b=KaygcEP3CPpuVRiWJnYMZqqKAiSz88Rx0DpM1+1rV1igOPPwKrSDj4ubdZuLKw9P19J7
	 7hSmJfRnHMRpMH7fTJA/RIAkWBofLZCOt2SVzjyuTLoymeiBriqAAucsuFJFdWQbrga7s
	 kJ/3tYK4FGKw4xeJyZSP3NwoBM+bSOvwpRuiKa811UFdF7xPc9Ln+di8xtpZ+k6fXVuCx
	 6VAHOUw+NQQwBnB0DZiGqsQYgQGwwRep4DfK9xd382hI12FOqkGqJZOEfLVZ/kQtjECMS
	 CY6ci8WZ4qgb1v0u96Y2wbptUNUTZc7OaWLv9nhvfDzXDGiOYRV6Lbu+NVBH2For8tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NU1vzrFU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A8606A32D
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NU1vzrFU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D753D1F000C4;
	Sat, 14 Nov 2026 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794665211;
	bh=+b+IR0Sc9aIyrc9NQuKmEzFBz/W8nHq32ixnl1kXGFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NU1vzrFUmAEvV0uFsn1ALXTURzMjen7VwezBBtkWrRTzVpDLHa7u5QQbKr9BRdXED
	 o0wq+eY6S1NlTQE5DMqMMAvf5+mYZKGWupyw9awe16yJT1pKBhJhTSaCQTvYUDNTzs
	 IZzV2ceW72gZVO5O83O0VoRU4HI7TCjj6q0aVe5CtkqIiFt6lIK4MlHxnzX7nyR6LP
	 gpdVxAFKmhBpA2dTlrS6kj0kvhl/oP/ZHh7qafkqxZ+pkGvo+oBClIFDFv3YaEBkOA
	 2ql6RTgWP4FklHu/XZW+aJRQBojGOIA1K5e0YcR4M80fbc1E6qqCVOAPgPYfXpUrVg
	 1/QWroJetsq7g==
Message-ID: <sashiko-outbox-214603@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/6] bonding: check XDP support before
 enslaving changes state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261113-bond_enslave_restruct-v1-1-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
 <20261113-bond_enslave_restruct-v1-1-364c549e78db@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 14:06:50 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bonding: missing Fixes trailer for bond_enslave() XDP check fix
--

commit 13721b74b0f4f7f2e2971839a9fe53fd558da85a
Author: Hangbin Liu <hangbin.liu@linux.dev>

> bonding: check XDP support before enslaving changes state
>
> The XDP capability checks (ndo_bpf/ndo_xdp_xmit) and the slave XDP
> program count check in bond_enslave() run after the slave has already
> been opened, attached and made visible to the datapath. In particular
> the slave can become bond->curr_active_slave, or be published via
> bond->slave_cnt, before we verify that slave_dev->netdev_ops->ndo_xdp_xmit
> exists, so bond_xdp_xmit() may call a NULL ndo_xdp_xmit.
>
> Move both checks to the validation section at the top of bond_enslave(),
> before the first state change. On failure nothing has been mutated yet,
> so the function can return directly. The dev_xdp_propagate() setup is
> left in place for now and still uses the same error path.
>
> Error messages and errno values are unchanged (-EOPNOTSUPP with the
> same netlink extack strings), and the success path is unaffected
> beyond running the read-only checks earlier.
>
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

[Severity: Low]
Since this fixes a NULL ndo_xdp_xmit dereference when enslaving a slave
on an XDP-enabled bond, should it include a Fixes: tag?

  Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver=
")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-bond_ensla=
ve_restruct-v1-0-364c549e78db@kylinos.cn?part=3D1
