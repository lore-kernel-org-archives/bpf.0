Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D963CBE80
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555498; cv=none; b=jK57rOv4+4kTAHrcaISQsOpi5f6UuUTNeUjHLF0zwzCcVVNPF/iZ90yFb1QFl3brzUSG8MGn4+UK7FuwfdHDSySLoO+5/y0iLI6FMgph8UOFQbCHnX7Mu34oNnr1/z/gyJKp8wv1r7Qgz1WxtTWDOZWvX/klswMPSWgeYKGy9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555498; c=relaxed/simple;
	bh=eg1wO0x1ENq/IsXBJXt2gj46nNJYx81jKKCliiCgZLU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=n3OWZsk8OdbauC158SZj7DVgJwe3izbNyNZj58NqTrzgYnv7K8flwqMeNLdYQ8wx3wZ8WawX/SgOC3EqWhSJ2qWFwKOfhI7wEU5QxuYSJSDMniQL1/VZCU//U4Es8E2IbHs/ILvuQIVvz6H1kTWZJfbUkJepCkUmUGgSiVr47V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSINESaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSINESaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD531F00893;
	Thu,  4 Jun 2026 06:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555495;
	bh=eg1wO0x1ENq/IsXBJXt2gj46nNJYx81jKKCliiCgZLU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=kSINESaEKV7JW5BpKKWTTJLN2/ROfMq1dt1OAHj8IfNMYKL2MLNJ66QCsHWkO0lXJ
	 YtTchJHjUYP7utCwVMrFTJBZVlq6ZbMUl1Ly4Nefp7TxoWRxpx6S6U/pzwIHhjuKuw
	 shrkgCZq3tVOokqWtM5bHelh8wbCpQJGuqcMDHt6AEg9xW2oveFYQfEI6aTsr6fXPg
	 BcBWRyKlRe9n7nlgztHjCUBViF3rUstPFCK439VKoMRRsnCegTIY9AVtuQsJbdtbe1
	 cjsnyWWxuLhZSjgBpgHpI59eO2mKuM6ykjZzApUhEpTILD+TPXQc/2du324kXUR92r
	 TM2Hdamrbccug==
Message-ID: <045f9e77-7264-48b9-81e3-c4995d84d026@kernel.org>
Date: Thu, 4 Jun 2026 15:44:34 +0900
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
 <264ec41c-dd1f-4957-9032-943fe719dffe@kernel.org>
Content-Language: en-US
In-Reply-To: <264ec41c-dd1f-4957-9032-943fe719dffe@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0VNFm27eFE0tres1yP8QrSXf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0VNFm27eFE0tres1yP8QrSXf
Content-Type: multipart/mixed; boundary="------------JelRG0POZLUZAiAcIUC1l3PH";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com, vbabka@suse.cz, harry.yoo@oracle.com, david@kernel.org,
 tj@kernel.org, roman.gushchin@linux.dev, peterz@infradead.org,
 linux-mm@kvack.org, Hao Li <hao.li@linux.dev>
Message-ID: <045f9e77-7264-48b9-81e3-c4995d84d026@kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf,slab: Add slub-backed allocator for
 bpf_arena
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
 <20260530011345.99342-4-alexei.starovoitov@gmail.com>
 <ca1bb6bf-f25e-44ba-87c5-e23e4939dbd5@kernel.org>
 <acc86e41-21d7-4b1b-b5de-fdc02064a959@kernel.org>
 <264ec41c-dd1f-4957-9032-943fe719dffe@kernel.org>
In-Reply-To: <264ec41c-dd1f-4957-9032-943fe719dffe@kernel.org>

--------------JelRG0POZLUZAiAcIUC1l3PH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/1/26 11:53 PM, Harry Yoo wrote:
> On 6/1/26 11:36 PM, Harry Yoo wrote:
>> On 6/1/26 11:06 PM, Vlastimil Babka (SUSE) wrote:
>>> On 5/30/26 03:13, Alexei Starovoitov wrote:
>>> I'm far from sure the masking is enough to contain all the bad things=
 that
>>> can happen as a result of a corrupted freelist. Even the hardened ver=
sion
>>> wouldn't help much I think, if a malicious program can both read and =
write,
>>> it doesn't have to know the secret seed to craft valid freepointers.
>>
>> I hope "a malicious program" doesn't have CAP_BPF, or am I being too
>> hopeful?
>=20
> AND (hopefully) distros that care about security don't allow
> unprivileged BPF programs these days?

I think we need some input from BPF folks about whether it's enough
to perform best-effort, cheap sanity checks to avoid letting the kernel
crash in most cases, or assume that a carefully written random,
malicious BPF program might try to crash the kernel and try harder to
prevent that.

--=20
Cheers,
Harry / Hyeonggon

--------------JelRG0POZLUZAiAcIUC1l3PH--

--------------0VNFm27eFE0tres1yP8QrSXf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaiEe0gAKCRCGXBN6rc5S
1oJNAQDFXIYveJocYCTW+3lbDX/I0UmTYyRpXNoIdkCynpoz+wD3agpdnu0bi3Dm
/Z8gZShtV431bsDrNIpS3P73bRvhAg==
=XtUT
-----END PGP SIGNATURE-----

--------------0VNFm27eFE0tres1yP8QrSXf--
