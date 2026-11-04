Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823249;
	b=ORaw54Al5bOPhXIvJbcWf2A55wC7Q+5KzDAj75npy2gY2Ik5WA1YWnyrPyJFJwVInkTU
	 5iQh3LimsxBNmMEgy2BzBcWy1jYt4eMDIICk486vhklsVvTBIpwJZVd60ec1GhqSCJKQ8
	 hO2kLyWOppWBW8GQBB5S6aOAtIh9d0yM/x21rbFgaThIrQ1P938FfY9qDG+c3On4uIE3D
	 Hc4uAwNXrcga91P6TzLtUzxGZChE2cdejJQ4vIkrUw6/Ay/kGFsXLm5rtxF2XVgFWSyE3
	 ubkU7km9hX18zx+pnd+vt69ZDjv1EsylegyxQmXM+OGW+HJsGiOeXcJYSwbhFpUVqTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823249;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:Date:
	 From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=7jJ7rZhR/RZuRnAPG07TM1AxcQZjBAxPgS58g9my108=;
	b=bcRhFumaVQt9Ik64SiDwlyEQ4+UOF97gfVYUsizLKWH4xJBxN4Zw5E9S047qe2aLT06Y
	 oiLoRBJHj52w/LJVakOcpZdJZY3Sflfzf+2NaDycvIbAlGTTcd4IY/hXT9UY+S6VvuyBM
	 8jGza/68bRjJc9PGKDmVDfClDjcrVmuyy3oQmKubz7GooyHy+XlTul3EjkgKH2fBgd1M6
	 B6mUoyvD6HFSzEKUhT71Elw7jMnelra1BgLkwzVCvDeAqHIXnMc1PfbPlfj0ZRnRsUXFx
	 WxVx6ox/WMa6wsb9k7WS6WDJO1P06ktvXivOfd5FSE4OeF272i9GyzK5htA89pPQUdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=QaUScylS;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=Rvkz0H3z;
	arc=none smtp.remote-ip=160.80.4.35
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.35])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C884F606A331;
	Wed,  4 Nov 2026 20:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C884F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=QaUScylS;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=Rvkz0H3z
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6A4KDOvu025984;
	Wed, 4 Nov 2026 21:13:29 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 4C52D121681;
	Wed,  4 Nov 2026 21:13:20 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793823200; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jJ7rZhR/RZuRnAPG07TM1AxcQZjBAxPgS58g9my108=;
	b=QaUScylS77oxqOdjv+06mPgody1sZJqj0PaFfLendc0FDJFxaUO1pUpCpFvxTCWCGow81v
	GpWHWo0epkj4dPBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793823200; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jJ7rZhR/RZuRnAPG07TM1AxcQZjBAxPgS58g9my108=;
	b=Rvkz0H3zARBQLYxOnoA9dQ7RX/gUWZckCSmEdP9HrjFdj4g7J66mpWNril99QK2brJEEcc
	cwyWvSqMbzD6ttP3VnT4yzOz7Q+4OpoR0Mo+G1nYgV7mjpTe0yvYX6sY6VsZDzKoFsmXR8
	dc2TDvZCquLESvG+VBAIzvsXd+SExvckp3N+us3hlR/uOpJ0k1TN+Nqkm+ck7YPP5/luEE
	BkxWtsxknhnu55CDrrqMFMlrqWmrzOssUEZaMNSXMqzc+nP6glojr7E1hXTXpMVX53mlC3
	T0idyUSgb2OSdvRaCSW4Brxiht6x/+7l3WC+4TMRe6Ue3px9RbBdUTlMZPG0iA==
Date: Wed, 4 Nov 2026 21:13:20 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern
 <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        bpf@vger.kernel.org, David Lebrun
 <david.lebrun@uclouvain.be>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Lebrun <dlebrun@google.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer
 <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net 4/6] seg6: discard CHECKSUM_COMPLETE after the
 End.BPF program
Message-Id: <20261104211320.8ad5cbc7408d3229e4f34693@uniroma2.it>
In-Reply-To: <aulG5DJroKs6BuzS@fedora>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
 <20261031225033.64-5-andrea.mayer@uniroma2.it>
 <aulG5DJroKs6BuzS@fedora>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 3 Nov 2026 10:28:52 +0800
Hangbin Liu <hangbin.liu@linux.dev> wrote:

> [snip]
> > +	/* The program may have changed the packet and seg6_bpf_has_valid_srh()
> > +	 * may rewrite the SRH Hdr Ext Len below.
> > +	 * skb->csum may then no longer be the checksum of the full packet.
> > +	 */
> > +	skb_checksum_complete_unset(skb);
> > +
> 
> Should we move this a bit later?
> 
> >  	if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
> >  		goto drop;
> >  	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
> > -- 
> 
> e.g. after this. As there is not need to do the setting if the skb is dropped.
> [snip]

Hi Hangbin,

Right, I will move it there in v2.

Thanks,
Andrea
