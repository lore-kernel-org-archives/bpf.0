Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542EA30F543;
	Mon, 15 Jun 2026 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547614; cv=none; b=Xbmba09BdA0F6JAHRWb/oXak2ebcHEXFoeAOsP43IkiU8biGBRvn1s0rjADnkCDS4UX/uvGqp3qouwM05b+jm5kEwf5KI688N8hs0f9EJD77vgKU+Uyg8IIS9RuKc0m+Bp9jWMTjioFvW/P7sAWyNB5H1Zk9shcHwd6pFQnF/bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547614; c=relaxed/simple;
	bh=h32wpJsp/xrTGtrDfL+Ul3zDeFlZDsQsEMsulK6wA6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/B/tYYwU3fLRzsM/n1G6fUwvEjP+LyOLohterX9Z3gbQicM0KD166E8fTg1zJYJfiKJ5/tQXgtTtP0MFtuwivX4l1ChVSGNwXKyUHLgv91rV/AWEGaIVovr0cQcL2VraLD26T6czf84lW/iI835xbIABb/BmZIM6kmee90josk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaaY8KbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaaY8KbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5171F000E9;
	Mon, 15 Jun 2026 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781547613;
	bh=mpVy7q9szpqVcji+j8EGdp+IteMSj6DFjJSGue7xDio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JaaY8KbTX33Ba85cgmzsRO28GOup5tLn4fl/Gadb4wOACcXPWSbq4jxZZDcysOoEx
	 DNQICdDSMfhrVSy5C1WZRl4otXfIW18l0KposRDLoN5SI94FRrttxyUXQxfKp8WaVi
	 eLASZqttyAaUpE0zZM0xph6w1DL0ngAVmsaUt4aIYRcFBDR2fxTL1z3OrfT7MZcFzt
	 MsBkCf8hSpCLupLlJwFPSLvHQufzy4ru4uPSNbDcEpN5i7ADXEnNOvqTd4a8X58wyS
	 DDCe0BbFc/cZn6jA6pR0kG9L9DPMvqLkslXLiITeFJVFuKyPYoQudV/6Hjn1kfGtbK
	 qFB4uCfj/c7Rg==
Date: Mon, 15 Jun 2026 11:20:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com,
 sd@queasysnail.net
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
Message-ID: <20260615112010.3f8e0efb@kernel.org>
In-Reply-To: <87bjddc4xm.fsf@cloudflare.com>
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-2-kuba@kernel.org>
	<cbfca457-d118-44cf-b51e-9b0221ae0973@redhat.com>
	<87bjddc4xm.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 21:12:05 +0200 Jakub Sitnicki wrote:
> On Sun, Jun 14, 2026 at 10:09 AM +02, Paolo Abeni wrote:
> > On 6/14/26 3:40 AM, Jakub Kicinski wrote:  
> >> TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
> >> Bugs which may be more or less relevant for real users but they
> >> are definitely exploitable.
> >> 
> >> We could not find anyone actively using this integration so let's
> >> reject this config. Adding a TLS socket to a sockmap was already
> >> rejected by sk_psock_init() through the inet_csk_has_ulp() check.
> >> We need to reject the attempts to configure the TLS keys (rather
> >> than adding the ULP itself) because checking prior to the ULP
> >> installation is tricky without risking a race with sockmap getting
> >> added in parallel (sockmap does not hold the socket lock).  
> >
> > Aren't both tls_ctx_create() and sk_psock_init() under (write) the
> > callback lock? Isn't that enough to avoid races?  
> 
> +1, but we would have to tweak inet_csk_has_ulp() to check for
> icsk_ulp_data in addition to icsk_ulp_ops. Only icsk_ulp_data is set
> under sk_callback_lock.
> 
> espintcp faces the same race...

Right, some deeper restructuring is needed for that. Also - I'm aware
of the race that Sashiko points out but we need to draw the line
somewhere if we want to hit the current merge window.

IOW I decided to keep it simple and focus on removing TLS+sockmap
integration, races in ULP vs sockmap init is a separate can of warms.
