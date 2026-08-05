Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE623C98BF
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785908475; cv=none; b=uVKczAJd49t8sXKmny0omelPccWwQgwz/GnUxAudTtqQkkUo2P5g1K4bqF+r+HxaxNQnCR1TUv7wln4ApgOHBL1nPbQ/twfhNsrSNJ5BwN+j4XvJ2J47ofoptf3Jakl5u9vCVsoURHnKGVmh4hOmRUSXVUyhl9YfhUrYRdNqvMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785908475; c=relaxed/simple;
	bh=mwV+1SLS45jSxFMdVUs5h1bva6Rbsz/3qRIrqBcpwP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qjB0Vi54RJqLdvzjAsZ6ED22eZZnGdEaBgw+wzect7elU0PMYQqLwRzzc95FodpQZyw94zoXfsc6sVXmMp7Xo91AZ8hffiOS1sq8YIPvDnFnOxydGttbe8LpX9XXwjsfxINCJrHVu+NAtGH00KKNiqrJDA2L3zcdM9x2zYgDCdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUI+6HI0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUI+6HI0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4C71F00A3A;
	Wed,  5 Aug 2026 05:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785908470;
	bh=QEkMpiSekQ/YGSlJZ/88R/iE72v3dbrEtt4wrLjDnx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SUI+6HI0Eut33y9XaIwzKjnMlMv34mMnaPg9fFnrX7ODuL27u9Hxl/2TW0Vo9fWLG
	 SHwHWBlhj9dykRsHeROJjXz4ZG4adaPhZsxzHhyR99qbtQmf5S7/72sFvFfMROM3HM
	 jXvPXGiUG9ci/TReLtMBwKv4WNuE4SJqZB6Ijf5+ptMphjWvenMvEDbPY7JZpq2Fo8
	 Z0OcYIMo2SqXzOZaGyunYmKk7NoTw4O3+iM/X9HreSbVYKmt3D59/r6bJgVr/pXmPI
	 getYZ/OK4YRpON5YyKKcPmVmA2h9z45K81W+XblBglH+rvfTo68wTRFOOv4tpNt1Tw
	 Ef/Dp1lNA0dxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 2/2] veth: fix skb length accounting after XDP
 frag adjustment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sun Jian" <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804054040.613675-3-sun.jian.kdev@gmail.com>
References: <20260804054040.613675-1-sun.jian.kdev@gmail.com>
 <20260804054040.613675-3-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 05:41:09 +0000
Message-Id: <20260805054110.3F4C71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling __skb_pull() before updating skb->len and skb->data_len tr=
iggers a BUG_ON() panic if the XDP program expands the linear area and shri=
nks the head by a large amount.
--

--- Patch [2]: [PATCH net v3 2/2] veth: fix skb length accounting after XDP=
 frag adjustment ---
commit 0dd43470e1427eba807058df83fcecbe72fdc551
Author: Sun Jian <sun.jian.kdev@gmail.com>

veth: fix skb length accounting after XDP frag adjustment

This commit synchronizes skb->len and skb->data_len after an XDP program
adjusts the fragment area in veth_xdp_rcv_skb(). It also uses
skb_set_tail_pointer() instead of __skb_put() to handle non-linear skbs
safely.

Link: https://lore.kernel.org/bpf/80687d9c-9c27-494c-b3f2-efd0230b1895@gmai=
l.com/

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 00e34afd858e7..f80f6584a6ff9 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -865,18 +865,24 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth=
_rq *rq,
> =20
>  	skb_reset_mac_header(skb);

[Severity: High]
This is a pre-existing issue, but does calling __skb_pull() just above this
line risk triggering a BUG() panic before the skb length synchronization lo=
gic
executes?

If an XDP program calls bpf_xdp_pull_data() to pull bytes into the linear
area (increasing xdp->data_end), and then calls bpf_xdp_adjust_head() to
advance the head by a large amount within the newly expanded linear area,
veth_xdp_rcv_skb() will call __skb_pull(skb, -off).

Because this executes before the new skb->len and skb->data_len
synchronization logic below, __skb_pull() subtracts the large adjustment
from the original skb->len.=20

If this causes skb->len to drop below the original skb->data_len, wouldn't
this trigger the BUG() assertion in __skb_pull()?

> -	/* check if bpf_xdp_adjust_tail was used */
> -	off =3D xdp->data_end - orig_data_end;
> -	if (off !=3D 0)
> -		__skb_put(skb, off); /* positive on grow, negative on shrink */
> -
>  	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> +	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
> +	 * from skb->len before updating data_len, then add the new one back.
>  	 */
> -	if (xdp_buff_has_frags(xdp))
> +	skb->len -=3D skb->data_len;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804054040.6136=
75-1-sun.jian.kdev@gmail.com?part=3D2
