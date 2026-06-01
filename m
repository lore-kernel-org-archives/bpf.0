Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414453BFE3E
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324622; cv=none; b=R3IyRhBAAClL6uxsyd8HU1WegOG8g8hEIxiq09UgsMRT4eTE1T5u1ZQqTeWs4wp4e+3wKbCNy44YqsUNqEMHpNUp1KBbKdtJ3lj8DDZq4Y5Ui7wh8FUllogXX+FZLIc0U4xDCqq44buaIyLdKSB41VgSdxWBcso9bMVSNaE9VYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324622; c=relaxed/simple;
	bh=utYY376O0tIN3OMpoj+vaOv10GRBPQ5gdY6+wo4nwAA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l003/xW/gYWiL+RvkaAwAWQOV02cEwI3qtGJL3cUDg1fBtiX60cW5einc8yWNmUc4wuv/4GLaL0R7TnJGzoHn0bPWM3RtZjK1rIq5phc8axk5IqK4BPbRBkdmTpB0A+IiyVyOXgigabIGmvvAiQ6s0QAKVA7dtk5TErBXse6hD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCK4GrMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCK4GrMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57D21F00893;
	Mon,  1 Jun 2026 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324612;
	bh=zRKpWRkZ4ryEYnP0BvmhMwCXktSUqM4/n/CosorTgos=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=eCK4GrMpxysTYwY8EZJPpFuHiu6VI7DBD6K8Ki/npJnVOVcQyYNc8CspSCpdBTNwj
	 E4tajNF8aT6REAYDpHRIYfSQwP3xp6Yk02g8sTnsWdevTyV/qYfUnbmKW4MFPbi4P8
	 FGaYSB4UU6JqunyueTw62Uo5hVVSLr35lE+cB2lCBRMzeBQQaqKgOCQOAqdMcKNbY+
	 Tu+5fT2iB4Fa9Md11n7OTlnOK9DKLUuRiY7Aw8JBkscNLQEnjYJQsOi90s0ZqFmXY1
	 rOkV5utFG9Cwi3X0t3yk9ATrXANpSERrXu7/CMYNMOHLG+MEe1751D5DsTzFSPsCWT
	 tCgc2S9wLCspg==
Message-ID: <acc86e41-21d7-4b1b-b5de-fdc02064a959@kernel.org>
Date: Mon, 1 Jun 2026 23:36:42 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harry Yoo <harry@kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf,slab: Add slub-backed allocator for
 bpf_arena
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com, vbabka@suse.cz, harry.yoo@oracle.com, david@kernel.org,
 tj@kernel.org, roman.gushchin@linux.dev, peterz@infradead.org,
 linux-mm@kvack.org, Hao Li <hao.li@linux.dev>
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
 <20260530011345.99342-4-alexei.starovoitov@gmail.com>
 <ca1bb6bf-f25e-44ba-87c5-e23e4939dbd5@kernel.org>
Content-Language: en-US
In-Reply-To: <ca1bb6bf-f25e-44ba-87c5-e23e4939dbd5@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------diUOyBzkGLryZKA9cu0CPqC5"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------diUOyBzkGLryZKA9cu0CPqC5
Content-Type: multipart/mixed; boundary="------------a3oHRHPtqA3xITJLmDGgU0kC";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 eddyz87@gmail.com, vbabka@suse.cz, harry.yoo@oracle.com, david@kernel.org,
 tj@kernel.org, roman.gushchin@linux.dev, peterz@infradead.org,
 linux-mm@kvack.org, Hao Li <hao.li@linux.dev>
Message-ID: <acc86e41-21d7-4b1b-b5de-fdc02064a959@kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/4] bpf,slab: Add slub-backed allocator for
 bpf_arena
References: <20260530011345.99342-1-alexei.starovoitov@gmail.com>
 <20260530011345.99342-4-alexei.starovoitov@gmail.com>
 <ca1bb6bf-f25e-44ba-87c5-e23e4939dbd5@kernel.org>
In-Reply-To: <ca1bb6bf-f25e-44ba-87c5-e23e4939dbd5@kernel.org>

--------------a3oHRHPtqA3xITJLmDGgU0kC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/1/26 11:06 PM, Vlastimil Babka (SUSE) wrote:
> On 5/30/26 03:13, Alexei Starovoitov wrote:
>> slub side:
>>
>>   - get_freepointer() clamps the decoded pointer to the same slab
>>     page via (object & ~slab_mask) | (decoded & slab_mask), NULL
>>     preserved. Worst case under BPF corruption: chain aliases within
>>     one arena page.
>
> Can't say I'm happy about this part. We potentially let BPF programs co=
rrupt
> the metadata and hope we catch any issue that would become fatal?

I wonder if it would be better to perform cheap sanity checks to
discover obvious memory corruptions (which would be beneficial for
others too).

It can't still detect very subtle memory corruptions though...

> And IIRC from the LSF/MM discussion it's not just cases where the verif=
ier
> would hypotethically have a bug, as the potentially UAF accesses are no=
t
> validated by the verifier at all, hence the different address space and=

> 32bit arena size trick, right?

That's my understanding too.

> I'm far from sure the masking is enough to contain all the bad things t=
hat
> can happen as a result of a corrupted freelist. Even the hardened versi=
on
> wouldn't help much I think, if a malicious program can both read and wr=
ite,
> it doesn't have to know the secret seed to craft valid freepointers.

I hope "a malicious program" doesn't have CAP_BPF, or am I being too
hopeful?

> The "freelist is outside of the arena" approach we discussed made more =
sense
> to me, even if there's memory overhead. I don't think it has to be 16 b=
ytes
> per object, could be just 8.

--=20
Cheers,
Harry / Hyeonggon


--------------a3oHRHPtqA3xITJLmDGgU0kC--

--------------diUOyBzkGLryZKA9cu0CPqC5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCah2Y+gAKCRCGXBN6rc5S
1rTRAPwO738syvKPEULll5+d2OMQJ04suk9k5ggwZJAtm191IgD+In4NjXn/rkxr
Y2mrVQOjT3d7N9BKDBsUydTmYc1hNAU=
=FNwU
-----END PGP SIGNATURE-----

--------------diUOyBzkGLryZKA9cu0CPqC5--
