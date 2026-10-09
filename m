Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDF33BBBD
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513040; cv=none; b=So0wKphBonb9psnnptyynNmOXMMnS40F8TgRkMzppZu4JWxM7hjvfVsSVcdE9k6+5AkMoMQjXbsmONHG2GSFfKQ/nNmS50jwIeGQyvKYRdD29gMGWtpUo/PkSH3UWusWo71mzTolHuAXqY3i3IUEkZ33jKzCo06vfxo991AQ8Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513040; c=relaxed/simple;
	bh=dX/McukFhHVwfBJrYKGs9rVZ5eLM+2TcYjBQI0cGXi4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Yc/5wFJdf8la8BROydY9xqeSCxfzFHqL9jiFXNWNmu18D9Y8Ut2ly1N/aIT8NC25vc8UoVh9Tdyy5nz4sEWaIWGbP+Edr1xIsGPvvBPfU4Ur4YbUH6QLKBfiqgdnkhLiP6cKa4HzqpogBZAIpMFKGcD03hPhWLx33QUEVk10/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VD0nrIij; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VD0nrIij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C211F000FF;
	Fri,  9 Oct 2026 02:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791513037;
	bh=UkJyRsQFMenCjoQw2Yxf4QhcjNvSExxEFhuS3IoM9lg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VD0nrIijhUmGDzqZD3KwGuakYG/7k8y/ygYUWEH5PvCj0nABUQSNnw5c1xfFITPYz
	 v8Qw75fSlW/AgMd9xUPh9XvUQ2P8CtDooNkM5/4Hckc5LCaSyvJ4drGUb3IeDmrwBI
	 cpDU0TZIpm3y9zSk8sw0ez6Ptp3cMSRxmptDdKX5rZ1HCbpq02LZf0RliOyO22YiDe
	 RpNpF/2ZYKqRz6snQtSi1puoQNwXkUl0Lw+eRdK84CZdIyq4eVD92iWbIWU8XThmww
	 3dFbuNjaMbsgEOtO5Ac5tKTqE0fpvDYf+nNW5b1V+dDvUnTu3Lb+EHJy/sw5JSAT19
	 Qlg4NVN6mN35g==
Message-ID: <sashiko-outbox-164727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: netmem: document netmem and memory
 provider design in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mina Almasry" <almasrymina@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261008023030.1089616-2-almasrymina@google.com>
References: <20261008023030.1089616-1-almasrymina@google.com>
 <20261008023030.1089616-2-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 02:30:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: skb_try_coalesce() mixes page and net_iov frags, deadlocking =
tcp_recvmsg()
--

commit 9c60c371b94dbd05fff282258637a7b536efd5da
Author: Mina Almasry <almasrymina@google.com>

net: netmem: document netmem and memory provider design in comments

Clarify the netmem, memory provider, page_pool, and skb fragment design
principles in header and code comments. It documents that all fragments in
an skb must share the same backing memory type and adds a check to avoid
coalescing skbs with different fragment memory types.

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 43ebe61c7fc48..2c42a218dcc00 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6206,6 +6206,9 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk=
_buff *from,
>  	if (to->pp_recycle !=3D from->pp_recycle)
>  		return false;
> =20
> +	/* All frags in an skb must have the same backing netmem memory type;
> +	 * do not coalesce skbs with different frag memory types.
> +	 */
>  	if (skb_frags_readable(from) !=3D skb_frags_readable(to))
>  		return false;
> =20

[Severity: High]
Does this fully prevent mixing fragment types if the source skb has
linear payload?

If both skbs are unreadable, they pass this check. But if the source skb
has linear payload, skb_try_coalesce() unconditionally converts the
linear payload into a struct page fragment and appends it to the target skb:

skb_try_coalesce() {
    ...
    if (skb_headlen(from) !=3D 0) {
        ...
        page =3D virt_to_head_page(from->head);
        ...
        skb_fill_page_desc(to, to_shinfo->nr_frags,
                           page, offset, skb_headlen(from));
        ...
    }
}

Would this result in the unreadable target skb containing a mix of net_iov
fragments and a struct page fragment?

If this mixed skb reaches tcp_recvmsg_locked(), could it cause a permanent
socket deadlock? An skb marked unreadable forces reads through
tcp_recvmsg_dmabuf(), which aborts upon encountering a readable struct page
fragment. This causes recvmsg to repeatedly return -EFAULT without advancing
the offset.

Additionally, on transmit paths, validate_xmit_unreadable_skb() only checks
the first fragment. Could mixed skbs bypass these transmit checks and reach
drivers, potentially causing issues if they incorrectly cast the page to
net_iov?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008023030.1089=
616-1-almasrymina@google.com?part=3D1
