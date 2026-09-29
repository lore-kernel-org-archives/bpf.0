Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B15568FDA
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710368; cv=none; b=oJbuAt8jDPJBlzoDv3ZWPyeyLgGcq1R6p8VC+L8lOz/9LM1R0MUqjyLsamgSB1NfIvMUL/qlcMG9LGV1hiLYoVaBBl73KiM7yd1gFkndGsmCd96uYx07HAP1lEz0b1L4o2oXSs4Wpr9sRzS6j1+WB1HA+ej86hfH97BTfDv67b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710368; c=relaxed/simple;
	bh=N9RzRbSUcvJObtrRHwvqdGPb+L4RSVYXsgifPiP8EDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=efhI5lNA16JmO756BrSR62ngwxQPx4pD0rn24xCI62OjC6dpbabMwoHVqoyIAzCBbEzuI22DTjAN7k/FAunAv9ADht0vboRs2X01A7REBxViobBvZPVdjyGW6n4nnX5omOSD2eO3FnUT60Fk1ZsXdxtCrLY0BnaeZ79M9L6JA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaMpkNEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaMpkNEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0F01F00893;
	Tue, 29 Sep 2026 19:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710365;
	bh=e2Ow9x4JxE/ZuGaDvoI86RhfsPMka1Pmyong3cGfmK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WaMpkNEIj6JiXAEMBKzblcT1Zg+bMqKHqMNwL+6YDAU24427Sgwx/jza0Klw0fKSa
	 +GCHwrAT5mFEK5SwQG/hwX/mpBfigk1u8xQxpFHQYNAaYUx+VXs0NsZs3dywm3EnPO
	 GVz43WZA0mXsPagmd9kLqJfpYFo5DVyQ4oJvlT2ksiftRk3wS4Kam3FgzlLdknRDFs
	 8LLzQQu0MIh0kVxunUUXwD5bohWYTbEvGiy990q6PPbTVgrmknUfEajNSjTh5b9vBo
	 6svlYEoNrTg6WrE2ufVzvMHGnFXkIH95tD2XaOuVg0YLJSzH1dDinYrwjVKshmE5M8
	 pmfA4WSzcXTxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/16 net-next v2] ipv4: udp: split IPv4 specific logic
 into udp_ipv4.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928193046.6698-7-fmancera@suse.de>
References: <20260928193046.6698-1-fmancera@suse.de>
 <20260928193046.6698-7-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 19:32:44 +0000
Message-Id: <20260929193244.CA0F01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: IPv4 BIG TCP UDP support broken by length extraction truncati=
on in udp_rcv()
--

commit 348e86f71529a8963fd2bec33bd3ebd366457c18
Author: Fernando Fernandez Mancera <fmancera@suse.de>

ipv4: udp: split IPv4 specific logic into udp_ipv4.c

This commit moves IPv4-specific UDP socket functions from the generic UDP
infrastructure into a new file, udp_ipv4.c. This change enables compiling
the INET subsystem without IPv4 support.

> diff --git a/net/ipv4/udp_ipv4.c b/net/ipv4/udp_ipv4.c
> new file mode 100644
> --- /dev/null
> +++ b/net/ipv4/udp_ipv4.c
[ ... ]
> +int udp_rcv(struct sk_buff *skb)
> +{
> +	struct rtable *rt =3D skb_rtable(skb);
> +	struct net *net =3D dev_net(skb->dev);
> +	struct sock *sk =3D NULL;
> +	unsigned short ulen;
> +	__be32 saddr, daddr;
> +	struct udphdr *uh;
> +	bool refcounted;
> +	int drop_reason;
[ ... ]
> +	uh   =3D udp_hdr(skb);
> +	ulen =3D ntohs(uh->len);
> +	saddr =3D ip_hdr(skb)->saddr;
> +	daddr =3D ip_hdr(skb)->daddr;
> +
> +	if (ulen > skb->len)
> +		goto short_packet;
> +
> +	if (ulen < sizeof(*uh))
> +		goto short_packet;

[Severity: High]
Does this change in udp_rcv() break support for IPv4 BIG TCP UDP packets?

By replacing the robust udp_get_len() helper with a direct ntohs(uh->len)
call and downgrading ulen to a 16-bit unsigned short, ulen evaluates to 0
for BIG TCP packets (which intentionally have uh->len set to 0).

Because ulen evaluates to 0, the subsequent bounds check (ulen < sizeof(*uh=
))
will evaluate as true (0 < 8), causing valid BIG TCP packets to jump to the
short_packet label and be incorrectly dropped with
SKB_DROP_REASON_PKT_TOO_SMALL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928193046.6698=
-1-fmancera@suse.de?part=3D6
