Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B32E6116
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549128; cv=none; b=NUTjNNrXSkLfwPXC/N+f8GhLiI6+kEtVlYW2r8U8mxmtXilq1Xop52n1ICum7ogfzrNafgbXnguMbXcsxD4JQBwxWvKg+457OIrbR6QAISerbsdGA++coJ10IgLdOaYCmnPa7Rp/PeVeon5IoIlCekw34HQqXbo2egMOZuvryEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549128; c=relaxed/simple;
	bh=y2PIwVUXoCW9TnSY2n/aKtOQkJRqNDHne/v+icBH9dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWJimiMKA0s3uvUntoLJyk8vti4J7S2xrDruE/pI1Ar6WSX8Ksdcbsb5zjCvIfYIV+WSSivGnMXP5uzGYcvdBAr4qDDUzv7cbTzssCXrFYNJb520H4+UWt6FaqYkta1lhrG5H4sHNKPUK6cT/jgWlxwJxAEF7T6kOgk995a7O9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AecFFvZC; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AecFFvZC"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68d23430690so6893832a12.3
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781549124; x=1782153924; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2PIwVUXoCW9TnSY2n/aKtOQkJRqNDHne/v+icBH9dY=;
        b=AecFFvZCFUH+cdH3xWC23SZCDdYeUbTajF5x2BOZ9BujrUyVGpfbKNhK6GDYs2fp+N
         fQhk/eclpof/q8Hr6r6g90pavh/L5kjBaugKJEmmLI+3gE/00OBCvS51QGIBWJwjqZ/x
         ihijKdSUBNQGrcnXtMvNaEtmdQpH844E2JOvwcl8HjMlyuxZaAkJMbfosyHng5oyC2Er
         nmMhtQU43pCHTiX254XOvSGxYR2NU+mxysr69PKVxiwzQphaeeewXOYHacfx82xWtVAQ
         3WZ1r+Udf7PEPInyWWMV08aK7AFq7Dwt9RVIxD4loVIULKs3hF5Gethnac+pyYz21OYv
         2eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781549124; x=1782153924;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y2PIwVUXoCW9TnSY2n/aKtOQkJRqNDHne/v+icBH9dY=;
        b=EUcsPMIuBN5MlCoQAjif8jpRQO1RyHpJRSSNCt2broQpJmZ+hy0VhR68DAiL34TMkO
         VKmJ1I6oRqZYcMGMXEWqTl8wNEYYE/xCNXszkQl/7LcrSAK88nPHREw3gwIzm9DfeFwM
         GgU4crKM2vZTxpV8l/Ah3+vF4FZ0Ajg0gKrta8i/DM1ZgC9LIRqi9OaaFk4kcRlsXua1
         a/jzE+EYp+m8oxfwfsidTC2WPE2y5ud4dfqvaVpJZX8wiPlWYdGKiK9kVvHfrbvg919W
         vLbCDcmYHBwrIYOLTP6eGs6ggxSDuBhirOKzBW0Kz0ROpes/lw6Hjk0FaaIeypKBsOyn
         SL1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/NW3RlwmGXrHn+IvnYctigYKo/FKSATqwcz9+GJikC1W5jbF7G30WjOO0137UqLaLzvrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7B3dyT9aZFw1UChIueXOG9pUBIZOmRk+8R8NjrM3FPF9G9fJ
	2w6BP4jtodlCxakClffVdrsdx6Q5KtCuLihdjhq5cVvTYvcP6aGc4QtWTsbEosBrj0E=
X-Gm-Gg: Acq92OFYVWufvHjuAFLuU2MXHYy7Qqckw+HIWsXHszMYfCfnsiwamPPqiA2UC1J1h5E
	3IZNSHWUP8uQPPLUjpMLS+Bb2j75u/r8BffY4hZV6yNs32dVHwF9J4YjtGkctJ87hOo+DXFyGcd
	TGYR5p0xmNmnYnBq6pIhpzMENgNgx5Q+HlOudkgg9hrvILg4wo3Kbuz7RDfVQoutfi05RdPSQ6M
	45/7pbuZbijXR2YRoSoxNIG+auk5r2NHxPU48D4KwHPp4IytRNC/OZVjW39v/AaX4aXwCtSHuRn
	XsCrdrex4tNjgyRyUtp5ok/RMcUuzsyeoOdo24BCiYKZfy321x6An+Cv5cIFCGoSeyEVLRk36qZ
	oAMm+WyKUPmSwnqwujtl9gmMvliKdtvkyhrqad9k94K2dNdTnQj5ncpQljakj3C+zFAK8aUQDgD
	SkeIu6UXbTnL3Cf1mpDvSU7WgXtM+GhJW7o7w7
X-Received: by 2002:a17:906:8473:b0:bfe:ed35:e85a with SMTP id a640c23a62f3a-bff4c9eaf3bmr461429766b.50.1781549124175;
        Mon, 15 Jun 2026 11:45:24 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb5223309sm513470166b.28.2026.06.15.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 11:45:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  bpf@vger.kernel.org,  john.fastabend@gmail.com,  sd@queasysnail.net
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
In-Reply-To: <20260614014102.461064-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 13 Jun 2026 18:40:56 -0700")
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-2-kuba@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 15 Jun 2026 20:45:21 +0200
Message-ID: <87tsr3bq2m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jun 13, 2026 at 06:40 PM -07, Jakub Kicinski wrote:
> TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
> Bugs which may be more or less relevant for real users but they
> are definitely exploitable.
>
> We could not find anyone actively using this integration so let's
> reject this config. Adding a TLS socket to a sockmap was already
> rejected by sk_psock_init() through the inet_csk_has_ulp() check.
> We need to reject the attempts to configure the TLS keys (rather
> than adding the ULP itself) because checking prior to the ULP
> installation is tricky without risking a race with sockmap getting
> added in parallel (sockmap does not hold the socket lock).
>
> This patch is a minimal rejection of the feature. Subsequent patch
> in the series will do a light dead code removal. Full cleanup would
> require a major rewrite of the Tx path, we don't need skmsg any more.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

SGTM until we can come up with a generic way to exclude sockmapped
sockets from ktls and espintcp.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
