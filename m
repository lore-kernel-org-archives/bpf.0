Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E82D46CE
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791689803; cv=none; b=kug1shnWSUyDdFTtdYFxjIjvDR6ijDwcPcNpLiUOzVdwW9u37rv05C5IcVI1HDifg40Up7i1GmVmMu7I4yfxLnX7t39Q4S+H9WyLO2a+d8kaukULeA4scIM8Zv+o4tAU1C6gr1d1fn8R10DD9/W5OIAhuVPch8Ck3pRy4Z3638E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791689803; c=relaxed/simple;
	bh=Tx1otybjQRr7JU7XAK4xurO0IrZZuCar/iFoQC+XX/w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=F2iDvKLntlzlYKI8094/Z4/xdwZwlyGHm0UvRiCYQ8WBM2rGO8CXv9VgAJz3P0a9yEDgxDrS3STZ8E/ofgGeYmwpHkjhKrv6Lj/4Vrqs2xJuURJdncdCbDMTC7tR11sSfh88iYTQnrop/e3AKOGfKQlBeu9MUwrPhu4PJuH4S9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orbA6zhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orbA6zhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FF51F000FF;
	Sun, 11 Oct 2026 03:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791689801;
	bh=GWne1mmwTU+fVH8H3u3GXuaZ0+d31xnxSqCzMF6EG+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=orbA6zhQMHMrbP0+xTFxMaLy5hasAYMuiklq8jOEkahL40Yfllfh6YFVFeycBbOD4
	 DYTxXwod9Y0822/8VtZVjIKc3Cmqf3WyRSLB1RhcrSWGzRqihzsD6wj+gVGuiJez8L
	 Bdu5EvAvPN6QkoikrrMc3/NW/fu8R39ZrQvWdmzvsfZrmdVjGrlXzZT8XEpDBgYL9n
	 WXch8Rk92q8YHLnxsrNNAT14Gx/Dg8vuITrKPb7umIUSWCTZ9ffBeC8KlRn3LwkXG3
	 UpX3oa5tTOZP3Rm98Tue36CzKcqvASJUr73OLqfuRQnIWfrA9fyQrBjPcMsuS1vv/g
	 Hj2wmmHqHW1RA==
Message-ID: <sashiko-outbox-166995@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: netmem: document netmem and memory
 provider design in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mina Almasry" <almasrymina@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261010033630.1171692-2-almasrymina@google.com>
References: <20261010033630.1171692-1-almasrymina@google.com>
 <20261010033630.1171692-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 03:36:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: skb_try_coalesce() allows mixing fragments from different mem=
ory providers
--

commit e4f91f2e0cb9de813eeecc8b5549e79dc322d463
Author: Mina Almasry <almasrymina@google.com>

net: netmem: document netmem and memory provider design in comments

Clarify the netmem, memory provider, page_pool, and skb fragment design
principles in header and code comments. It documents that all frags in an
skb must either all be struct page-backed or all belong to the same memory
provider instance, and adds a check in skb_try_coalesce() to enforce this.

Link: https://lore.kernel.org/netdev/20261008023030.1089616-1-almasrymina@g=
oogle.com/
Link: https://lore.kernel.org/netdev/20261005004958.3603059-1-almasrymina@g=
oogle.com/

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d56f4f0102f75..69d3d27e29d97 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c

[ ... ]

> @@ -6210,6 +6210,10 @@ bool skb_try_coalesce(struct sk_buff *to, struct s=
k_buff *from,
>  	if (to->pp_recycle !=3D from->pp_recycle)
>  		return false;
> =20
> +	/* All frags in an skb must either all be struct page-backed or all
> +	 * belong to the same memory provider instance; do not coalesce skbs
> +	 * that would mix them.
> +	 */
> +	if (skb_frags_readable(from) !=3D skb_frags_readable(to))
> +		return false;

[Severity: High]
Does this check reliably prevent mixing fragments from different memory
providers?

If a socket receives packets from multiple RX queues (e.g., via RPS/RFS or
multipath) where one queue is bound to a devmem provider and another to an
io_uring provider, both packets will have skb_frags_readable =3D=3D false. =
This
condition then evaluates to false !=3D false and allows skb_try_coalesce() =
to
successfully merge them into a single SKB.

If this coalesced SKB is processed by the TCP receive path, it can cause a
failure. When tcp_recvmsg_dmabuf() iterates over the fragments and encounte=
rs
the io_uring fragment, it will trigger the following check:

net/ipv4/tcp.c:tcp_recvmsg_dmabuf() {
    ...
            niov =3D skb_frag_net_iov(frag);
            if (!net_is_devmem_iov(niov)) {
                err =3D -ENODEV;
                goto out;
            }
    ...
}

This breaks the receive path and drops the payload.=20

Additionally, if memory providers supply CPU-readable netmems (as
architecturally allowed by this commit), the check evaluates to true !=3D t=
rue,
which fails to prevent mixing system pages with memory-provider fragments.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010033630.1171=
692-1-almasrymina@google.com?part=3D1
