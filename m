Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1E3F1AD9;
	Mon, 17 Aug 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981990; cv=none; b=GX5k2dMHCfRgNECtpxCnRnDco14UvmIf0iy+a7V4Oe4r+YjbnNA4fsrnzjCUnyGqOpDg3Sfe1fzBeFxteBoUp49dpjS8P8O1hCWeO1DreozDm8toAH6W/6IjDPAt6Lj1Z3HIN8OdC7Nr078Z19hR/ouRzK4ZWTNaDydfCFqgMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981990; c=relaxed/simple;
	bh=3f6A9eVUX5ObcDJKGhj0aLiMhZyUTTcxeQQ41tz1Mus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6zuCT1GgASTkYwQALpCGVlgZkcXCjHy6Fzwp7CHwihml89bs0lEUUmsKlYEJ1bMfaaGKQfYZoPOGaINrORuxopqIvyyYcDP+INCimM0IRnLkJ5ZqlzQT0hAczZV0Zpd/jHHHc3MBEhwPDdmRLBIYuj/Ux4Q9mDuSumae1sXL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT7nuqZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT7nuqZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BFF1F000E9;
	Mon, 17 Aug 2026 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981989;
	bh=3f6A9eVUX5ObcDJKGhj0aLiMhZyUTTcxeQQ41tz1Mus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mT7nuqZy6XDBUFBDw9i7O7/1g3AO9YbXdcCtB3iJXwAth08qe0qHZULXIZ/DwAOIw
	 Oj+CE5AtWvkZK8qlu7XyvIwYptyLx4ibtrU+0UElr42xx12thyiSKQfQM3VhOYwyzF
	 GiFpnWt2f1i7ssn8U1h8PoAAH/i7LQaA9j42I2jxx+yUNiFvFqgdhZmJKtoeWUdmw0
	 Vzyd/R+lC9eFs8AS8TwU4SGEnZvVp8GOusDN1iOpQzj5VaowAkZTLLmNLLjJv+6nK6
	 7xgClSHRQmm1MgxdGPSy9M/r8jFH0bsFQ+Mk5gdeJWDWk7qZBKfj6njDlDOxyu0HJJ
	 IFlKlbtOBkywA==
Date: Mon, 17 Aug 2026 08:53:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn
 <willemb@google.com>, Ankit Garg <nktgrg@google.com>, Tim Hostetler
 <thostet@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen
 de Borst <jeroendb@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net 0/6] gve: various XDP fixes
Message-ID: <20260817085308.2ccab72e@kernel.org>
In-Reply-To: <CALuQH+WN+xftDONAk=T8zeB1qF5y=yaJ4F23DAg4W6puP+jToA@mail.gmail.com>
References: <20260814234845.773189-1-joshwash@google.com>
	<CALuQH+WN+xftDONAk=T8zeB1qF5y=yaJ4F23DAg4W6puP+jToA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 22:29:39 -0700 Joshua Washington wrote:
> Quite a few review bot concerns on this patch series. I will respin to
> address the concerns and manually run Sashiko to hopefully catch any
> other lingering issues before resubmitting.

Please beware that we have more models running in netdev,
the emailed out ones are just from Gemini.

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814234845.773189-3-joshwash@google.com
