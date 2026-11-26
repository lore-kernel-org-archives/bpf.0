Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686511;
	b=UF5R9rDoVh3FScMJHTXp9P7XkO1aPBFoNQmcT/z4Ullst6tWqQn7m/LHCIFP+X2xNasd
	 UeKz4Afqq5p3ztPm36elzwlOCGDjA4prFhm6LqeYCiPILIGy4E0PJhjpe89HRBfL72CPz
	 y6TlbUBlnj2WVTHVbhT3ILitN7ahlZEbZqSchoJ1A+qUg5z+QIDToYwNkBLzqwJof5m+O
	 HTSwoYp+JdQImh11N2AuNP/+VIg3GmUkZMwmxrta38NsMw+UbljZGNrOzZTLz3/MdT29+
	 L/52vpYrpca309CAv4h/K4dTsXk1YdJkrO8EkGOUdx/neJ4a2t2G5Tqa6uvfowz+/cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686511;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:Date:X-Clacks-Overhead:Message-ID:MIME-Version:
	 Content-Type;
	bh=6cgl+cJCPo6MGV5UvUz5o9puShPO80wHEGZQxQESbN4=;
	b=nQYw5ZWvqt/7uDD+v2BP6VqamiJR2CcPZZhTab5ay97KOBq9C4JWTltGqmF/n0UCaO+e
	 S/97Q3p5Xc7DFWICObrkq+aRWYmv3Bi+7bn1ve9brC6Be6JpVywIqOj9IjUb/dr7SmjQ/
	 pS5xni8MTWRe4wMU9MsHGLkv12HJV9qZCavdX6SdLxha1x+WM7klfvOR2HmTqVrb7sUb/
	 5x79n++pNQkjnsoYPYDCUx5/TumBpAF7KqS8wpPZOciB/5YVskXQevIAmGXKFT1R4mIJO
	 ta2NbYltCT2UzHqc03qMrfv1haeejC9bAR3alT4XL4lLNaGAya/qhOuiDIz5pEM8lDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=nrOIkOBD;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4757A606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 09:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4757A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=nrOIkOBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795686508; bh=nZGt73YLaZAHBOiJWhisNMK8lPIrbp3MkoNI3ZvYB9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nrOIkOBDVbuUfJw1NDKoMEnjqARSAUagsEPzRwpTkwCzZaQ2qm5HPWtadL1G42hcE
	 nJG2PXz49Hx1zPpL9B3AiIMRb9n+L57d54cn0MksLZvlp7r1SIPX1RZWX2fiyQBlD6
	 MLCcTJH1JFMoJlazJaR1pbcZ/+T20lpCzykd7xtA0U21G1gbUbTizdYOhOeHGBHsxX
	 SIZhM8gq7Cqh9KatluasrOXwU0Q1v13GSI0tgU58Ezlen45EPiT2K6JhdFMO11A6Jr
	 lW3Dgv3hrP5ToOty6sELAMc6U7tVGy8nOIcX0EDwNpBX9ZoouhdeS7ueYcivl8NEu0
	 JOo3RWlS7eXlw==
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/7] libbpf: Add bpf_*_get_next_id_opts()
 functions
In-Reply-To: <sashiko-outbox-233673@kernel.org>
References: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
 <20261125-bpf-relax-get-next-id-v1-2-49175227c8cf@toke.dk>
 <sashiko-outbox-233673@kernel.org>
Date: Thu, 26 Nov 2026 10:48:27 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87zeuvditw.fsf@toke.dk>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] libbpf: wrong opts struct type in OPTS_VALID() in
>   bpf_obj_get_next_id()
> - [Medium] libbpf: new bpf_*_get_next_id_opts() symbols placed in
>   LIBBPF_1.8.0

Will fix these and the other issues pointed out by the bot and respin.

pw-bot: cr
