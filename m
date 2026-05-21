Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A892F1FF4
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376754; cv=none; b=YWUziLtjLM/nd7RAaVQBVscPGRWOxwKAKi4T4CV/PJ/qXjTPD6PH8Z61YabTCkfgGaHuNzOOdAlnK5jkLGRU7snj17m50mp6wakdk+ShQ1cmeAD3LNcBcdThWBH+Zb1//pQQ4YZTEnddUZWTdJ2e9qIVXhwWpumKx4Oea8J4/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376754; c=relaxed/simple;
	bh=gS3/Si68oxgv+rk5k1AwYfSRkOIXRjb3lG03XzyucLk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pS84GD3Jm2CaZBEDqusmnNmfU4JWoQ/6XfYnOELU9GgPoe/OpSX1Uep+xhiD6+jJrIneQclrmNBjiiPEymbFp+isHofJulSH9m94yA4lKg6mu99V4U2nUAq22yg0xCRZyuuewdIWK92zaVhMK8fPa2MpMcG0bQunb/ZisxWq4CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTBuP24b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTBuP24b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D4B1F000E9;
	Thu, 21 May 2026 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376752;
	bh=0mWdeo3KC6m7awO/zjRKDVTuzfk6iiFidmUUPLpY5+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jTBuP24bwZPPJRkf8oBOR0C7j7a1I51798/no3ICDYX6cipaIrNHr8dXGS2ccT0ss
	 wXoNlCEV16ukMLFkQc4CREecYP07yogRYvXsZZpBBVUboTAPQA8sDfcLh4534LpIiq
	 ASa9ItFhwAcOTkcUTbAYKn3eUbRm+k53sRaGLHwwP5qJ7Sk4W6aBIvWbPgy+F4iIwX
	 ubjwF6usDoboXrdKE2d4HJ3TOHuYxcwweS8ax/3yCoPM36OlwTx+06n1wn0774LfDz
	 BBhOjwmd2yol8O9V7giLSQSzBQYvo3R5eKcI3Rrvrt8PCGrISesxVEkOHe1QUJDxtT
	 xx2MCFSAwXq9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 10/20] unwind_user/sframe: Remove .sframe section on
 detected corruption
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521142546.3908498-11-jremus@linux.ibm.com>
References: <20260521142546.3908498-11-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 15:19:09 +0000
Message-Id: <20260521151911.55D4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Concurrent removal of a corrupted or unmapped .sframe section trig=
gers a user-controllable WARN_ON_ONCE.
- [High] Valid but paged-out .sframe sections are permanently removed due t=
o transient page faults.
--

commit b574618cbc641ef52e2678be129e34a64bc4fb53
Author: Josh Poimboeuf <jpoimboe@kernel.org>

unwind_user/sframe: Remove .sframe section on detected corruption

To avoid continued attempted use of a bad .sframe section, this commit remo=
ves
it on demand when the first sign of corruption is detected.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 41ece3ca62a1f..e0eb2adf5a074 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -371,10 +371,15 @@ int sframe_find(unsigned long ip, struct unwind_use=
r_frame *frame)
>  			ret =3D __find_fre(sec, &fde, ip, frame);
>  	}
> =20
> +end:
> +	if (ret && ret !=3D -ENOENT)
> +		WARN_ON_ONCE(sframe_remove_section(sec->sframe_start));

[Severity: High]
Can a concurrent unwind cause a user-controllable warning here?

If two threads concurrently fail to read a corrupted .sframe section, they=
=20
could both reach this code. The first thread would successfully remove the=
=20
section, but the second thread would fail to find it in the maple tree,=20
causing sframe_remove_section() to return -EINVAL.=20

This would trigger the WARN_ON_ONCE(), potentially allowing an unprivileged=
=20
user to crash the system if panic_on_warn is enabled.

> =20
>  	return ret;
> =20
>  Efault:
> -	return -EFAULT;
> +	ret =3D -EFAULT;
> +	goto end;
>  }

[Severity: High]
Will this permanently remove perfectly valid .sframe sections if they happe=
n=20
to be paged out?

User space unwinding often happens in atomic contexts like perf NMIs where=
=20
demand paging is not permitted. If a valid .sframe section is temporarily=20
swapped out or hasn't been faulted in yet, the memory read operations will=
=20
cleanly fail and jump here, setting ret to -EFAULT.

Since -EFAULT is not -ENOENT, the error handling logic jumps to the end lab=
el=20
and treats this transient failure as permanent corruption, permanently remo=
ving=20
the section from the maple tree. Applications might lose unwinding capabili=
ties=20
simply because their memory was temporarily paged out during a profiler sam=
ple.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521142546.3908=
498-1-jremus@linux.ibm.com?part=3D10
