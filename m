Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FC3128B2;
	Thu, 18 Jun 2026 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781817145; cv=none; b=trhc/KsovuGXTKJ942KhF8IFMusmvCfnI1ZZNl2AoRcN+LpopOXtW9j3mc/5TKhPGtYFejEStBXRE/hvb2SI8GroFfCEHQDvCNUsC2J7ZFaEdL9hds/jQDraRyqhu1TtAa+6JuoUtnmpPUoLKHYoOpWQSSwfwuau4R8x58D9UJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781817145; c=relaxed/simple;
	bh=0wFyWqsckZjscNPwEBKHH24OfGu482IMvCdFzpTj73E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type; b=qMVshtmlMu25wquQRj2GEqlSnnA9kaIMi6jEjBqfyPMKO2IQv9TcCNhYRwKY2Z7yMgnT2URSWbmBbNeNWX2See+Ep0dxDGWDoGHCcsFlYvC0vIUKmlfoAl+2z4okyMpVZtnR9PW5g1aRunpNcJw57qPMFAoW4kzJoc/Q95Ggn2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvH6jaw4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvH6jaw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728171F000E9;
	Thu, 18 Jun 2026 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781817144;
	bh=0wFyWqsckZjscNPwEBKHH24OfGu482IMvCdFzpTj73E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NvH6jaw4s4BQ3d7SKQ2ij1OCWq4+r3zIxOpzGnK0ezhK8XfzFaQRL3W/y9K8ykZ34
	 M+D3WWTP/VTNX8ioo2VJ1PEDO/0QEEE54S5on/ajdZx0chAc8hVTZd3k46pg4iWwc7
	 NZ3CstK77xsmFXkURStyacKlQdlks6ksQ0Y1lnFwupytBx8apeArW8y6K0Qri2jSFM
	 /Nr0ZdsIC04uQsC9K1eO7PHLuP7yTYVfKu7F3o9SW777c81Od0A//MlsaOpBuPf5FI
	 ELq2zgvhXfzUSRdyfK5w6EzLO9Znchb2DCGQcpnOTYa+/Oqs5OQ26cNUPF9swm7Htp
	 uHleaVQXaeSQg==
Date: Thu, 18 Jun 2026 17:12:01 -0400
Message-ID: <deddbbbc947400fa0cb3f0a6e164c290@kernel.org>
From: Tamir Duberstein <tamird@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf 3/6] libbpf: ringbuf: Handle position counter wrap
In-Reply-To: <DJAXGXLF4NHZ.17HAW2R1YDK7I@etsalapatis.com>
References: <20260613-bpf-ringbuf-fixes-v1-3-e623481cb724@kernel.org>
 <20260614020552.022A11F000E9@smtp.kernel.org>
 <DJAXGXLF4NHZ.17HAW2R1YDK7I@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, Jun 16, 2026 at 09:19:43PM -0400, Emil Tsalapatis wrote:
[...]
> This seems like a fair point, if we're going to modify one let's also
> modify the other. Wrt the "32-bit binaries on 64-bit" Sashiko warnings
> they're a bridge too far, we have to draw the line somewhere.

Yep, my clanker also flagged the 32-bit-on-64-bit problem -- I agree
it doesn't make sense to tackle here. The other two now have their own
patches in v2.

> Can we also add a comment as to why we're using != in both locations?

Done in v2.
