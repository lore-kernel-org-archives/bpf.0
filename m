Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A997081A;
	Tue, 12 May 2026 16:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601825; cv=none; b=H9TLjP9w8G3gqvBCg/FMpYr4SZMnaUStgiupgrkU8Na38P3PLKQm5PtXx+eHvpUMs4LzW8p3zGKxpXeDU3QEbyMoh51eau8J/eHsigPPoys88r3KBRJSR0PSTs+b2VR4gBg2JKAjqak24t+iHzdwBtSF4ikimXCilTHLX6TUY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601825; c=relaxed/simple;
	bh=hN8ptaNvSOxU6v4Xfdr3YqfTxz2H8Z45w+RCfymBy6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJvpNL6o1WRqFl3ISRUXLcO361S/rNsuxVBiakygNTyEid6UNRco1nK06OUpKzCKQbNDDsDZ3V/usGfgD4UEl9NpyLQfzAoyEVrht5MvMU2M3cjuknCOVgDgPYo0BNDf9g9YQ3WoLMMHTobWOIbXcufFOCX9S/p6xuYIvO5VLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5/1cDWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5/1cDWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E81C2BCB0;
	Tue, 12 May 2026 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601824;
	bh=hN8ptaNvSOxU6v4Xfdr3YqfTxz2H8Z45w+RCfymBy6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5/1cDWGdzrK0q2TXSNVKVDSwRY1lJWE/V+/TqqMqmiuzM10S6USpy1hhOdzJ98fW
	 I4vStU//h4Ewv21SBlEvE2FAhTLj6R9Y6rWOlQCTDJZtrOyUvdYcw1nMlo8b4E/qXT
	 Pi49Itb+wkdnDonCxkCar0maTzTll6hH5suEQz+NytndoGOimRamUkgmi7/+3AMxqC
	 fApZuB3Fp0iRYYKywsr5Lz2B5iz1w4ri+Jqs6iK7rfDsViTmwo6GVWccMZzTCnPmBb
	 eEy2+SD3rxIcpA6+r8kunNB24J8OfpS6rAe0utvyKO+OKNawC1Gwnz9cJSMVPIdBxN
	 b5RtRBtTW1RDg==
Date: Tue, 12 May 2026 09:03:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org, Sashiko
 <sashiko-bot@kernel.org>, daniel@iogearbox.net, jonathan.lemon@gmail.com
Subject: Re: [PATCH net v2 2/4] net: tls: prevent chain-after-chain in plain
 text SG
Message-ID: <20260512090342.15779c9a@kernel.org>
In-Reply-To: <agMKcBrJYK5UIcsZ@krikkit>
References: <20260511174920.433155-1-kuba@kernel.org>
	<20260511174920.433155-3-kuba@kernel.org>
	<agMKcBrJYK5UIcsZ@krikkit>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 13:09:36 +0200 Sabrina Dubroca wrote:
> 2026-05-11, 10:49:18 -0700, Jakub Kicinski wrote:
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> > index 2608b0c01849..3bfdaf5e64f5 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -789,21 +789,33 @@ static int tls_push_record(struct sock *sk, int flags,
> >  	i = msg_pl->sg.end;
> >  	sk_msg_iter_var_prev(i);
> >  
> > +	/* msg_pl->sg.data is a ring; data[MAX+1] is reserved for the wrap
> > +	 * link (frags won't use it). 'i' is now the last filled entry:
> > +	 *
> > +	 *         i   end              start
> > +	 *         v    v                 v            [ rsv ]
> > +	 *  [ d ][ d ][   ][   ]...[   ][ d ][ d ][ d ][chain]
> > +	 *    ^   END                                     v
> > +	 *     `-----------------------------------------'
> > +	 *
> > +	 * Note that SGL does not allow chain-after-chain, so for TLS 1.3,
> > +	 * we must make sure we don't create the wrap entry and then chain
> > +	 * link to content_type immediately at index 0.
> > +	 */  
> 
> All this wrapping with extra "hidden" slots is so confusing...

Yes, always takes me an hour to swap the context back in.
I was hoping the diagram would help.

> > +	if (i < msg_pl->sg.start)
> > +		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
> > +			 msg_pl->sg.data);
> > +
> >  	rec->content_type = record_type;
> >  	if (prot->version == TLS_1_3_VERSION) {
> >  		/* Add content type to end of message.  No padding added */
> >  		sg_set_buf(&rec->sg_content_type, &rec->content_type, 1);
> >  		sg_mark_end(&rec->sg_content_type);
> > -		sg_chain(msg_pl->sg.data, msg_pl->sg.end + 1,
> > -			 &rec->sg_content_type);
> > +		sg_chain(msg_pl->sg.data, i + 2, &rec->sg_content_type);  
> 
> Probably a silly question: why do we need to chain the content type?
> Could we just drop it directly into the right slot of msg_pl?

Good question, IDK either. Maybe anticipating the need for padding?
Do you prefer that as the fix, or follow up in net-next is fine?

> (I'm also a bit puzzled by the "last_filled + 2"/"end + 1", because
> that would leave an empty slot between the last_filled slot and the
> content_type? and maybe even overwrite the first actual message chunk
> if we had filled the message?)

Incredibly confusingly the value passed to sg_chain is the arrays size.
So it's entry target + 1. IDK if that answer your question but it always
confuses me. I even added it to the comment above but looks like I ended
up removing it.
