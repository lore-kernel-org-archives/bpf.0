Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEB3CAE66
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780325600; cv=none; b=FzwhPUqD0pd1iyE5VausiFD5SkKydobjloa3kTc32WYwXGnHT7ZPLs0ylKizeRF/ps8UAsiu9grfsI3uxwVOVllupi2g4mBeVse0z6Y2M4m0k6u4q6fscvzMVKerMg7ONJcEp2hwaqQ/n7/r737HAodjmM9wHhBnheFMgu1wE8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780325600; c=relaxed/simple;
	bh=xiQUMkR7UOdZhhl/sVNZBEvY/qGg1U4+w0VidMXvdpE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mL14S2gnSu1K2gdCqnj2NSfI7sQNfotFTxnhGAEGc4lo7BhPrHgGeU9mwcG+YnAQH+JBmlSVmwqYN7UrMTC9IRByWyN3wJkIVidahKM3Tz+blPulVk3d7PjiarG3c7SyBzSCpNeqIjPX5FqJt43eSzUt0pu29igjwHKoQKUFrv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcDv7JBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcDv7JBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8751F00893;
	Mon,  1 Jun 2026 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780325599;
	bh=xiQUMkR7UOdZhhl/sVNZBEvY/qGg1U4+w0VidMXvdpE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=AcDv7JBXv1WuUyybHXbNhCxJc3oOpdXhk7ixtIqrNz429V0cBKGsHpoNWlfy4KzNV
	 nz8uVF2PWvWVekKVwtrkdawEeGIq7I45cAyHLWU5Ar18hskeNTHkZniqkGyz3lCz3K
	 C5w697+eSrqpqovKTdEYhxc2J5Rp+eir44635M31NU8/7+pHWMyROGdifDECzq0vER
	 VUeMbXWYK2FMmSOT3l3h4Ufkj8AmUpvB7jSh7t0fjCSmfFKHDzOFTvCIEADY+VeMiz
	 OZU4kURbqF9inCO8x4Cd5dc8gU3ou4/UcaTPeo0RhhK3KribGsy3gSYF6MfQqSe3lA
	 HM+9ctma9YcUw==
Message-ID: <264ec41c-dd1f-4957-9032-943fe719dffe@kernel.org>
Date: Mon, 1 Jun 2026 23:53:11 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 3/4] bpf,slab: Add slub-backed allocator for
 bpf_arena
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com, vbabka@suse.cz, harry.yoo@oracle.com, david@kernel.org,
 tj@kernel.org, roman.gushchin@linux.dev, peterz@infradead.org,
 linux-mm@kvack.org, Hao Li <hao.li@linux.dev>
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
 <20260530011345.99342-4-alexei.starovoitov@gmail.com>
 <ca1bb6bf-f25e-44ba-87c5-e23e4939dbd5@kernel.org>
 <acc86e41-21d7-4b1b-b5de-fdc02064a959@kernel.org>
Content-Language: en-US
In-Reply-To: <acc86e41-21d7-4b1b-b5de-fdc02064a959@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FIHDtU9jdxgAacPQ0ZAKZUFE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FIHDtU9jdxgAacPQ0ZAKZUFE
Content-Type: multipart/mixed; boundary="------------RIxoiKPUGgqRDcEnXTMRgjKn";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com, vbabka@suse.cz, harry.yoo@oracle.com, david@kernel.org,
 tj@kernel.org, roman.gushchin@linux.dev, peterz@infradead.org,
 linux-mm@kvack.org, Hao Li <hao.li@linux.dev>
Message-ID: <264ec41c-dd1f-4957-9032-943fe719dffe@kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf,slab: Add slub-backed allocator for
 bpf_arena
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
 <20260530011345.99342-4-alexei.starovoitov@gmail.com>
 <ca1bb6bf-f25e-44ba-87c5-e23e4939dbd5@kernel.org>
 <acc86e41-21d7-4b1b-b5de-fdc02064a959@kernel.org>
In-Reply-To: <acc86e41-21d7-4b1b-b5de-fdc02064a959@kernel.org>

--------------RIxoiKPUGgqRDcEnXTMRgjKn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 6/1/26 11:36 PM, Harry Yoo wrote:
> On 6/1/26 11:06 PM, Vlastimil Babka (SUSE) wrote:
>> On 5/30/26 03:13, Alexei Starovoitov wrote:
>> I'm far from sure the masking is enough to contain all the bad things =
that
>> can happen as a result of a corrupted freelist. Even the hardened vers=
ion
>> wouldn't help much I think, if a malicious program can both read and w=
rite,
>> it doesn't have to know the secret seed to craft valid freepointers.
>=20
> I hope "a malicious program" doesn't have CAP_BPF, or am I being too
> hopeful?

AND (hopefully) distros that care about security don't allow
unprivileged BPF programs these days?

--=20
Cheers,
Harry / Hyeonggon


--------------RIxoiKPUGgqRDcEnXTMRgjKn--

--------------FIHDtU9jdxgAacPQ0ZAKZUFE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCah2c1wAKCRCGXBN6rc5S
1uRYAQD4ZwK7PnE6cNfZQnbEzHAyAQZF0oKc/wLME8pIDNGGRAD/alPo/FTKCWSR
ThPaEsBmdazfnhU2b/OP6afE0MHz0QU=
=Re/5
-----END PGP SIGNATURE-----

--------------FIHDtU9jdxgAacPQ0ZAKZUFE--
