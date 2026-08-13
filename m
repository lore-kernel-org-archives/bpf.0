Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BA49505A
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639036; cv=none; b=ILwOPfMkTjSB91eAGXWVMoeZS+rheoxL6I71TQzZCVdzc+9P/HitS27wYLwkO9lPmikkfEG9Wpxt5Pe7ayEuJh6X+YZkEGaOqiR+0T/InCNZEtmDVdib5fYrXabjDls/npGtt4AP/6uUMgEimCkApXJl927eP8G5Ldk3d5tqKWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639036; c=relaxed/simple;
	bh=YS9a2jQAc3by0zKtY5MUX6kyXU6dIg9kjzItxET27VA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DkzCHmRJpg0idSyBYirQ8KkxU5uKEHf+lVOCnxy9rle4UYmS90x2ZUuTGItQFWKWWnXR+mbMwgimgh9cozojNljUB8tgaJTObotsIvGMf+5x4NDeBaEbzzP8P6TYSlbbG1yTLl/DlswSQHUgSCRSGnxzYrUDzXOxNB1dWlJxBEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMfFXjeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMfFXjeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9404E1F000E9;
	Thu, 13 Aug 2026 16:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786639033;
	bh=jOmQf5PrCMG3gdu+SiPIRUqtrR9Oxgm50ckGVEwyxj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jMfFXjeBq5hi+XaT14bGRH0ok9Ox+r3jWetdzspPQICTl2lY6r7nm+qghQDFiwXtn
	 FwqCcKT6FxMDyoi9trKInfuv//GQv6aDeYs51brEirrb7IaR0PT9oh9z29S37BmtX0
	 OKVnw+gdLAo9Z6Lulie30NMf4nvwNQ3LsjUG5woxZdfjhmBSnFmYipvaT20OU5BUu5
	 qRZkghOANAFl4gZohz5RO9pt1Y8MMJRJ1TeIpl5O80b0IByslt6VTjrUzxLDfu7I3s
	 x7oqXXbuQ+gP09n1YOWrkFgtHoSxHQHhLuYLESQTANmQ3S5EwSOkCltIR8/b2tQoVe
	 Akp0YcVce6LQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 1/1] ip: orphan prefetched skbs before multicast
 forwarding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiling Zou" <zhilinz@nebusec.ai>
Cc: bpf@vger.kernel.org
In-Reply-To: <0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai>
References: <cover.1786552223.git.zhilinz@nebusec.ai>
 <0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 16:37:12 +0000
Message-Id: <20260813163713.9404E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_sk_assign on ingress paired with bpf_redirect (TC redirect=
) or bridge forwarding allows an SKB to escape the RCU read-side critical s=
ection without being orphaned, causing a Use-After-Free of a UDP socket.
--

--- Patch [1]: [PATCH net v3 1/1] ip: orphan prefetched skbs before multica=
st forwarding ---
commit 94ee963b9e52780b05e88dd7a54693c9630a26fb
Author: Zhiling Zou <zhilinz@nebusec.ai>

ip: orphan prefetched skbs before multicast forwarding

IPv4 and IPv6 input preserve an skb->sk association installed by
bpf_sk_assign() so that local delivery can use the selected socket under
RCU. Both address families can also prefetch a socket in UDP early demux.
In both paths (BPF and UDP early demux) a reference is not guaranteed to
be held on the socket. This patch orphans the skb before each non-local
multicast forwarding path.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

> ---
> changes in v3:
> - Describe UDP early demux consistently for both IPv4 and IPv6.
> - Drop the IPv6-specific unicast-MAC discussion from the commit message.
> - Leave the BPF-only TC redirect and bridge paths for a separate patchset.

[Severity: Critical]
This is a pre-existing issue, but since the TC redirect and bridge paths are
left for a separate patchset, is there still a risk of a use-after-free for
UDP sockets here?

If a BPF program on TC ingress uses bpf_sk_assign() to assign a socket to an
SKB without holding a reference, and then calls bpf_redirect():

net/core/filter.c:skb_do_redirect() {
    ...
    return flags & BPF_F_NEIGH ?
           __bpf_redirect_neigh(skb, dev, flags & BPF_F_NEXTHOP ?
                                &ri->nh : NULL) :
           __bpf_redirect(skb, dev, flags);
}

This pushes the SKB to the egress path via __bpf_redirect() -> __bpf_tx_skb=
()
-> dev_queue_xmit() without calling skb_orphan().

A similar sequence exists in bridge forwarding:

net/bridge/br_forward.c:br_forward_finish() {
    skb_clear_tstamp(skb);
    return NF_HOOK(NFPROTO_BRIDGE, NF_BR_POST_ROUTING,
                   net, sk, skb, NULL, skb->dev,
                   br_dev_queue_push_xmit);
}

This pushes the SKB to egress via br_dev_queue_push_xmit() ->
dev_queue_xmit() without orphaning it.

Does this allow the SKB to escape the RCU read-side critical section with a
dangling socket pointer if the socket is closed concurrently?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0c52eb3d7532aaf8bcc=
f37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai?part=3D1
