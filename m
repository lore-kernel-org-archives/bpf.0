Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9BB2E7F25;
	Wed, 27 May 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888295; cv=none; b=IyjykZrcz4VEcjoVP+hvfPE1XSS2hRT+fFX7d58zKnpMYj94gGA4TyIMtFWvc/95bRQ8nJxiY4BLx07V9TEiKzx3iFaNfcVwxzgX4+6ZBUtwOtCKojmyox7V2ujUovn0p5X2si4u0uBXkS6Skc09/7fx2iRFLXJTICTM5kiQqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888295; c=relaxed/simple;
	bh=0HGClSyXBXxyXG26RzRZS7w3G2ipIvuqzIRh1ydQ3W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB2uMv2gsvjtkn1aivfrYhvRBQZ0+LTHHpYNSKF26vPiyBGaWlEvpEuUx9caWiKuJaXNC0aGhwoNuiReHlhoX+ya5sjBdQIV+6ncpKF8MeWIrdmaMZkkNGBMqQhErj42UCG3PDY90FFcWrzKgORo53+xn06G3T9sB7mKid4X9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FumuuEQW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FumuuEQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412E91F000E9;
	Wed, 27 May 2026 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779888294;
	bh=0HGClSyXBXxyXG26RzRZS7w3G2ipIvuqzIRh1ydQ3W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FumuuEQWtmuF/BJmD55PoeOE/v92cl36iWgBylm0ngcfZoD5L83yq4/kULhaU0p23
	 u0pQrFsLbF/Qo3blkzBhKeYDfpqLO+j+HnohfXhchKZmk9G2+7zwY07glrG74TllxR
	 K7+W8KtC6tlm0ZfvXD0s7pFosIfdud18beEfJ1uwj2z4jQrmAYTO84FJxrv2gJMCHC
	 8eDlQAR8n6LhGolaf4aM8yVD8GXt41OKRHN6XWZyO2EBsJL6cie5HtUKWGhf8YAILm
	 FvtynKWoSEsAAsI5/00B67ltc/IgmGDRbHFDp47JG/xQZpZ5StB50qGuQ2oNbn/tyN
	 8EBowBhM5Traw==
Date: Wed, 27 May 2026 14:24:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Message-ID: <23a429b4-bdf1-4f96-b3af-7ab3186e99d3@sirena.org.uk>
References: <ahWOVFZZScPjm2Ow@sirena.org.uk>
 <CAADnVQ+yjm0SJ0UQMeuS82MLDeo1bvZKSMMDh-K8D9-PNu=p8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yBgt/TPiuRRzj/+6"
Content-Disposition: inline
In-Reply-To: <CAADnVQ+yjm0SJ0UQMeuS82MLDeo1bvZKSMMDh-K8D9-PNu=p8w@mail.gmail.com>
X-Cookie: No alcohol, dogs or horses.


--yBgt/TPiuRRzj/+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2026 at 03:08:06PM -0700, Alexei Starovoitov wrote:

> thoughts on the best way to fix it ?
> Pls send it to bpf-next. I think it's fine for it to be in one tree only.

That's fine from a -next point of view since bpf gets merged first,
you'll also need to ensure that the sched_ext stuff doesn't get sent to
Linus until the bpf changes have landed or flag the dependency up to
him.

--yBgt/TPiuRRzj/+6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoW8KAACgkQJNaLcl1U
h9Ax+Af9FshkywdeD8aHR6Ecrc7ZYwpMdLWtt7h+Pz6LHttcHF+i8KOxs0akomXc
meW86c2er19FNqtrRzSe0+OlQc2fmjWlWN0Ybh1TSvt6n/99pf4JtdT96bp6/zri
ckZHaTx4R/WSENn+uS5TRrxfWvBFhOrDmtc9QjQtMwRPdgS4Jj6xyBAjekn7k5G3
RZWFpbz/dP6Ka2Zsq4ZLdMmHlbhm3lY9UcYRWuVHqk+2D+VGZf/WBqEQxWkzlAdj
MH1Z9KJaQJAga+bVoTA1i34S9FuySv9HjKj7cdGYrT9wqgpqZWUqCQJ5UKAAJ+bd
5Ot3/uZVMG116Joev//DMYUMLCbSig==
=gKeV
-----END PGP SIGNATURE-----

--yBgt/TPiuRRzj/+6--
