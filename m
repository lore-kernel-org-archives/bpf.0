Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372091;
	b=SzncnV9KzPHayp2N6zkpNqRdQ6DSTrN0FdJ30fCw5Jiko07yInLUp42zlAuGKDi8fFGN
	 5z06nAKI2Xem9rjF2vTlYjPg9VdQsrkYoJ+YasKZFxEaOGUrTG1tumohzCESR1vQa3q4z
	 G9snl4It1WEKCmp+xHvBLHvR3n0+SLCu3NO8VB0DttaMV5V2ll3kFf5KRJSVuRS8SSZv+
	 zVKLEK+Kw9NJd9embv1lkr2XQGEJI47typ8MUSTRNP0bgd3rowAXcln80Tp1rF6iu4F1m
	 KWvkZDbUGXbZgxHn+Xm4cXOx6Z8tWg33+isPkgCz7XISP4D4jSRoX0OaHadZlM/SNGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372091;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y4oTKIy2Os+THkNAlv+lYotxKoAHQctUcjcwZrJAY2U=;
	b=yQvugAmV6yQej3ipXzDKoyC1J563XMOi4KOGAr3z3Ugq60r9gvh9d7yLOS8JjfrwqTxT
	 Tf8vkGPl0KOeiiP3Jgl1lYMasqCzp6lH2X1p29XUfAfaRJSMJIJsxgiVQCpqqw4vMA9Vl
	 UN9VijYBkajAgnsBIatAcWPIlKEotbhg7mHA/JgNYfm+4+aJEEUd4/pfIE7lDZiAmuRWG
	 oaibf8hVp6cAKwWADLv/OkjL31B98sTdmAaJS7EKBEAZCHwq7ESvO2yIkyujM1hfPvRq7
	 MRvh1+QuyZq+5m3IkNHZH7wP0maViTodjFSl0t47qYpqlnemznWOptzSWgP7otmNTfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSDaMrMf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21896606A333
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eSDaMrMf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7381F000C6;
	Sun, 22 Nov 2026 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795372090;
	bh=Y4oTKIy2Os+THkNAlv+lYotxKoAHQctUcjcwZrJAY2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eSDaMrMfcQdp5WxXXuHiT3hmv4r2crKkiQXOcB4bUI+2N5On3IKa9K6f8CVArohiL
	 4+CnP8+JV/otaK0CCqp57xGUh4UrVG3GQ8ynZsMFNIMk5T9t6BoWmrC82Rc9HYGOhE
	 yJJ5gdV3qK18TGH9lmIGT1D8xjHWKN3a83E+iHjY877jhIJVSUE9/77EyS18H7fuVR
	 O14cIIoOBf9whaM0IjEb7Wjw5e5ovRsDCXPuagiadh49Sc9ScSl5Jb1YAJMmaI/gCB
	 o+ylIPb27R19R82fYgFfJk6P2Myg/mycgR8S2JfSUSKnBCe4G7MB+hP2HsDokfk401
	 HOocHO2V6a1MA==
Message-ID: <sashiko-outbox-228181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 3/3] selftests: net: veth: propagate
 bad-settings check failures to exit status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omokefe Emmanuel Onanaroghene" <emmaonana18@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261121182217.4609-4-emmaonana18@gmail.com>
References: <20261121182217.4609-1-emmaonana18@gmail.com>
 <20261121182217.4609-4-emmaonana18@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 18:28:10 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests: net: veth: missing Fixes: trailer for bad-settings
  exit status fix
--

commit 8ddb499da6652b523173fb5185c64f0e2151d257
Author: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

> selftests: net: veth: propagate bad-settings check failures to exit status
>
> Three more checks in veth.sh print "fail - set operation successful
> ?!?" without setting ret: "bad setting: XDP with RX nr less than TX",
> "bad setting: reducing RX nr below peer TX with XDP set", and "bad
> setting: increasing peer TX nr above RX with XDP set". A kernel that
> wrongly accepts any of these invalid operations would be reported yet
> the script would still exit 0. Wrap each fail branch so it sets ret=3D1.
>
> Reported-by: Tianyi Gao <tianyi@cloudflare.com>
> Link: https://lore.kernel.org/all/CAG4wq-cd01i7YrcFPmma=3DBXUcwn_PK=3Dwne=
KW=3DvyEBYzQ3Bn7QA@mail.gmail.com/
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

[Severity: Low]
This fixes the three negative channel checks added in 1ec2230fc721
("selftests: net: veth: add tests for set_channel").  Should this include:

  Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121182217.4609=
-1-emmaonana18@gmail.com?part=3D3
