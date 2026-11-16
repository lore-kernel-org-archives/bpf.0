Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850835;
	b=muzseKSwZVnQR0ofI+GwUF7qQWDfCHmzWaQJBF19/nUw0qHQGG8u00pZLZnsT2z/R625
	 GdbJ23TV9cwBWCd2zTEria81KgeyMlbkQfbftC5NHnpAKxKE7qJKMroWbaYicxzSME/mt
	 EYnu5RYfm/BdpA71pQ6qksBqL7sYl9oGMkBfeU6V6cByyA7OtTVzvRpEaq4LQRUb0RgZM
	 50p/GuSXohHxmidNTwm7rtF0PLo2sy5Oqndzm1W6/AriapJIMT9Vad3hSF5RM7je24tdA
	 REMPE8F/M+7QzxlE13vWYl0QiCVzmp1PDlUUIOpZoNEn6D/b8+T0LHauoPiro2RnI6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1FezqDDMFBi/NoKe5GwcJGa6+JE4zrE9BjELtGPCyAU=;
	b=mCuuj0IYE1AOAJIzjoEMbCuCKLzRhvL4udLgSLG4fSZSAS6Ff4o2y5kMupdvgLfySljl
	 X9NfJjQfl77Pl/tQ+jRRAkiM7nersPDUzBW4t2mW3i/tSlx0tSNEfXI8QW9j/+bicQXBp
	 damn1MWeU3nefyzxMGu4yD1MNiotx0G8QUM8yeOsCFLEVKnt6MSnpLsXwE3bxW/YQQydS
	 Uzmet/b0s6HUe2UOuOsYbgN1gbdxXRKFXtbXxJyPi5HxwDFKOQpA6NXGbRZBcxvZ7wR5J
	 GGml4lUdMAhPqBdDm0gLoLrUqdI6YU+1Tl28ijM77gYDOw/ecu3qkiBKo9zwdVduiCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8HWctyr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A48606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8HWctyr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771331F000C4;
	Mon, 16 Nov 2026 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794850834;
	bh=1FezqDDMFBi/NoKe5GwcJGa6+JE4zrE9BjELtGPCyAU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=d8HWctyrwWnAwyM1dpin+CeovVNflmKgY/Q8cigQVEOknd1l+MBKvD+IvpoK9o3NL
	 NqHdVkSuU5aYkJ3Z4Gg+UHfXdu9PJc/Sid4B8EUlZ0pU60PnWZAa3fEAxcTTgKz7Ic
	 cOl6aTjn0dCh4GiQOAQmhr6cnq19izX1/JPHE8eI4A+dVUs1W+fyEDndKBAKfAUXah
	 Rh2iNKACQ8eVTmJDa6OgIE6G/JVx79L83zp7P4ZGltGjeJXvCoWrEdc/VbCPNyP15/
	 tNmttBQ3+wfWTH/Mn9QfAtva/FvPUWXIy98E7daVu7XCs7++fNY8I+qBzAoNbVMyBX
	 mLHkaivw1dE2A==
Message-ID: <sashiko-outbox-217437@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 06/21] bpf: Resolve BTF structs and arrays
 first
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116152626.4032587-7-alexei.starovoitov@gmail.com>
References: <20261116152626.4032587-1-alexei.starovoitov@gmail.com>
 <20261116152626.4032587-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:40:33 +0000
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
- [Low] bpf: missing Fixes trailer for BTF loop detection in
  btf_check_all_types()
--

commit f2b6216605cc6af96cb5995fe77081d986ad71b1
Author: Alexei Starovoitov <ast@kernel.org>

> bpf: Resolve BTF structs and arrays first
>
> btf_resolve() does not see this loop:
>
>   ptr -> typedef -> array -+
>             ^--------------+
>
> The walk from the pointer stops at the array and marks the typedef as
> resolved. Only the limits of the later walks end the loop. The walk for
> special fields is going to lose its limit.
>
> Resolve structs and arrays first. Then a type that holds itself is always
> found. Such BTF does not load any more.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

[Severity: Low]
This fixes a bug in BTF type resolution where resolving a pointer first
marks intermediate modifiers as resolved and hides self-referential loops
through structs or arrays.  Should this include:

  Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152626.4032=
587-1-alexei.starovoitov@gmail.com?part=3D6
