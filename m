Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332514ABE;
	Tue, 18 Aug 2026 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787017147; cv=none; b=bVhQz4E/cKsIkURxGxTR2pJRGfFpHrrKilzj7EaJyaw49Mi33CydS6CKoAU2b+W7aJEVVLasPB5MWm6ZWhRi6NtcjKvLU79G1VHttR1ensXjSBhbsneW3HXofz+mksHRyx4LGb4GtLDGH31fjxeIUMBzWix3nn4gOUOlfkVSeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787017147; c=relaxed/simple;
	bh=vp2K5bzWEaPNLxRc148jCzldoAl7xwlvwFxk67Gypm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWZPmEATcMiAjhDfOSmp7M+svovUHilkHQbZXAwsvVth75Yz0d3/mzzmi6pZTu4FERqVQf4HUQNdL34bt9i2gm1LQjsmG31UH702DNSFFcKlnc1H1s6mE4pQ9Pnr/TBGCBeIanf2opVe7eFkyWH97ym0C44JHWqL6eqYLZZ+G5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGKclVhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGKclVhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019401F000E9;
	Tue, 18 Aug 2026 01:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787017145;
	bh=vp2K5bzWEaPNLxRc148jCzldoAl7xwlvwFxk67Gypm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TGKclVhLRJBDFmocL6UF8aDNvxDrY0PNdHCwrZoTlqDszETaSAzy34Yuy0/LwsDsz
	 PCERbSl2Q9x2/Nf0RiS7Dhqz+PBCVkNJaGx3xbTqpduUIG/GDD9bbUkIPUONIyTpbG
	 a6Ka+CvYR7kfQDSiQNMu40/4XmQeeFp/ARDK5oculqQvxrG/2b2AOk9S6RXh9pEbNh
	 8ZK4cEG0IxXJyDoL6Wqp2LM77oNYCcJ5eMh4jluqIAKIAWBPtxt/3WBoG7TiJ9lEbX
	 EJG3Ha8TXYwp9Q0avIpnatFrn0HsZGZ8BwA6CXcz1hGfb3uS/x6ZBSFr3BTvHNouJc
	 vappa8zrDjC1w==
Date: Mon, 17 Aug 2026 18:39:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 willemb@google.com, nktgrg@google.com, maolson@google.com,
 thostet@google.com, jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 debarghyak@google.com, kees@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/15] gve: AdminQ mode related refactors
Message-ID: <20260817183904.6e0fd5a5@kernel.org>
In-Reply-To: <CAEAWyHerP_n3ucJaEqrCZqVFQTPKzydYXOPYZkk8d0iKf8UWow@mail.gmail.com>
References: <20260814021406.3044324-1-hramamurthy@google.com>
	<CAEAWyHerP_n3ucJaEqrCZqVFQTPKzydYXOPYZkk8d0iKf8UWow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 14:45:08 -0700 Harshitha Ramamurthy wrote:
> Sashiko has spotted a few issues - will look through them and fix them in v5.

net-next has closed. I'll take the first 3 from v4 and the rest has to
wait until after the merge window.
