Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A6449991;
	Thu,  9 Jul 2026 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623292; cv=none; b=C6wXvZgyDQOj7OZbR0L3/1nfl6gV/rKtMPiJaVY25ph68rGCWNwxGiJAD+BKeWAz6v+yO9HOXdovPF5psXcGxDoLZXOXLOxUQlezQk1HUM/DWZTsKq/iWvPKqgxrdjCP4GymK8toP1w3xySWydJa/PF4H25mt58sXhsjoctN8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623292; c=relaxed/simple;
	bh=nOp9dRAkZZmsy/4LfZiAoN1/cIRVppzj441qbWbpMuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch857iYNGkcHIpXopiXe1FZpWTBGzIAmRrPhcnQtK01jpZLnNUcBtUT5/QarB1WuWY3mWTpXNPgQ1V+nhU2IzwDAs45w6zVrQ9DNctwiOHNOWqqDr/iNp2NC5bXlLyNTnc2a6nadExwgmJeGvQpmVanR5I6eM0472Nqw1r/sKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=emhDrfC3 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="emhDrfC3"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6C6AA40E014C;
	Thu,  9 Jul 2026 18:54:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QSY5mcnhEz1a; Thu,  9 Jul 2026 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783623268; bh=Yt27dIER6EH7BwDBybe7TUBMtfov7ivN1wC7w3HKW/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emhDrfC3quKVcEPIFTu8eG9PS1i4nA82mTENb6wCFa3nSbzzVN/RWuSWGXNkNzBH1
	 f9bD3lriYyfsVUj9PSHvksBJ6VCuYlX65BPUixuw77oLzFYQfm3PhV8IyzpvSF8GQq
	 0zWHDal2OEZJKekYcN3dYewXT/t0u/vcGxNT8hi5dzHJnLwx3vjm7X8FedJQkrV6lJ
	 Nz0ftw7VxbjBJ7k3f7z00lnSZHw4LnSGmds+dljejm3SrPOLjYiMFub1s/WSq/nroW
	 7YbNo1ZKD2Rmh8rX1psPIu1/1cM/G51xW89Z+uwj1m7JR0pIvYvk6ZlBXAI+JBLGGU
	 +4RiWZT6djLdeQFZl4N0BUP4Lq/PbBnz6YUXFR9GFgOlraXVlDtRz0LaXFuVNu6irG
	 iiGKSwjNVQaFX3vRQCt6NU/SjH4N74jUoImsEk98GIIU/4ahmg9E1KmY7/JkZxuCJo
	 UG4twzvTzKc5+sT9YXiZdYADOdBizMf1Kbqh8rpE76naHzWzYUFT4MhetNhuQB95XA
	 dn42pG34NPEtgsqs6io8G9OY1ogmyzZTOSXl0wHL8FzU2Vz4K+oGQZ9ZiEEwIncqW9
	 V5Nrb+/Z9nfr126ItKmxS1cSZVYhlnubllLwAaarX9Ohs+wiCIyFwk5XoFwTsKByLP
	 HbMjSzJ5vUUJpKGvWoeUchRw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5420B40E02B5;
	Thu,  9 Jul 2026 18:54:03 +0000 (UTC)
Date: Thu, 9 Jul 2026 11:53:59 -0700
From: Borislav Petkov <bp@alien8.de>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, ebpf@linuxfoundation.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 00/10] bpf: add support for KASAN checks in
 JITed programs
Message-ID: <20260709185359.GAak_uRxyxfsSjCSyA@fat_crate.local>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 12:01:41PM +0200, Alexis Lothor=C3=A9 (eBPF Found=
ation) wrote:
> Hello,
> this is v5 of the series aiming to bring basic support for KASAN checks
> to BPF JITed programs.

Can we slow down a bit here please?

From: Documentation/process/submitting-patches.rst

Don't get discouraged - or impatient
------------------------------------

After you have submitted your change, be patient and wait.  Reviewers are
busy people and may not get to your patch right away.

Once upon a time, patches used to disappear into the void without comment=
,
but the development process works more smoothly than that now.  You shoul=
d
receive comments within a week or so; if that does not happen, make sure
that you have sent your patches to the right place.  Wait for a minimum o=
f
						     ^^^^^^^^^^^^^^^^^^^^^

one week before resubmitting or pinging reviewers - possibly longer durin=
g
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

busy times like merge windows.


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
