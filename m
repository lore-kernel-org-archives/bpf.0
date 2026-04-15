Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A13921F8
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776237169; cv=none; b=ZD0ffLBZB1MHWnAeh3t6438LUu1z283NE0tJCKZwmeimeExOTJ118dZ9+ehaDpUKCiOnGWvC5a2zJRsoqAqSBHTZ3lOqTanC8zTbk23f7h6hfKcfSTrEyJyID72cpaCtx2EUQAOd/oMiLQ5NphI8f6h8Gfwo7W8hlytMpGSDY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776237169; c=relaxed/simple;
	bh=3I7702ceSydfqaaMeSGnzV2CbViGuf3igaLyaU0P0j4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZmKslhrkKbjDCq+t+kuQXYNcEef4kv5UQ7pFRTgH7CzZAbu75TZv2DMc/GJ/bYJRUlJod0MlZG812d1A6PUho3/fh7dg5KfIKDVVh2L8rjSIjUgrlmBq8Rm2u89P/xljMHyAeWFpn7nuGTgGFxGDCguI0uE5ZlmxF7Jkhu2e7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ur9b0v08; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ur9b0v08"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so2304219a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776237167; x=1776841967; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fYUlJNwbejT61N5mhS5KKBtXDFEFhfy7OHMbarqXtps=;
        b=Ur9b0v08IlgJVq9G9yhP0RoWoWMWH282HZ7HG2oieKzF/jGAW0/xKQodpHlBgwr5+T
         fl6Y4AHAt9wExRo4KZXx5vMrht4ayPy45LwWMH4B8+7sHfB6wCxTPQ3x9p9KcF0FYEM6
         3P/oJUSemblt62HZtDvdjxKEBC5IFoYTlBaWGhJhd4reoGnvLhyH53WmOneaWcD5rXOl
         nqschY8zRs+3whOOyTJHdrIEgxl998Xm01JKYZemQ2w+HUfGd0g5OF+PUIHHaRzEttOc
         x4GtWNX48XM4TaSShVrdUs1opznbXc3xmlpvAHsByCE9rDs8QAkRn0oOrSiRfX/psxgR
         1iCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776237167; x=1776841967;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYUlJNwbejT61N5mhS5KKBtXDFEFhfy7OHMbarqXtps=;
        b=HOfWL4AUyijtBGsK49V4rr0WFuPZ/FahzqUqvKGqAK94hQtqsxcQjZ9zsDutbZOMIM
         BnqjreBOBLJzJUjRu2dRRFjxbTAQLxwHl/c3u1kHHubnMXPvoR1h1RoVhx1PhMNQCc2D
         41gpQwFj4QunzJWFw73TMNhdyAAUyazYjM8KNa0xzjmsBq7/K/jgpO/3/Xq5eNv2avoH
         g4D5mL1l9cpqLtb8cAHII2zthVavylcPMcFkT+baijrYd7g9otNVHDEzUD7URe7ZxsQL
         9cFpDc3xkL+SBPZuUYJkvUxp51QMaoMsvT6H60feZxtPJ+6svOXwG2wmdPj9Iax+dNB1
         9jUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dv/LLpPIOtjiXUQvlbWxx2kkUGrCuq803i35fFLVmRwzUsHLgdd5fpdUfP+AkNp/PeeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2qbg+CMvtPbq4BLQLwU5+T4yBbkeh2QgwN3kCE/9mwuVdaJr
	XMqCmCuMpCAk4FcP2jELHedarg0DT5tz1Xz78KYEgbhihXVdvrNeqO9a
X-Gm-Gg: AeBDietT0RC8qpktXmDHnnBgRqdp35cNLee3HlJV2jNElkBzYNn6deMUPoaArA3BlbZ
	ZI5lSZGIMRBrV9ZOhHNquZ9CV3SLYaG3HmVl+dlnOWgK/zx7IPNya22fYNcCA+NYtBla0qJbvcR
	VxqlGNBK24oOiX/eAz1c6GbbXQkgS+aUGOT0wySrWmapMb0bBbNawXgAk1EqESFYRgbuHcwYybq
	7N+JIvQSUVWrPKc59RL2xnhhu8c042laStqO77IDfpcIFzmDpoogat5CLoYBpHsMfa2VBb3iipJ
	y6TJm2Ipj4eHO5B8L8e8vBfcC61Oi10j5DsyCSXQUexktgyCiqu6oX41VVmvKs9mff/TK3ipfhP
	n6W7wtv9yUBpTWJAtCw3Ow93sYertNRSBO+cUIEJhaOHs/J+Ni+tbUv0Qt+CzPOlke0gXotyF0f
	MuCfqPB4PzhG7L3fTw8U8A5h7ceLRC4eik8H5vUNq51wRr93fOC1Xm80x5EOKImbeHKkgJb3rZH
	Ndymv1wzEOwyKHPm5v3BgNFJRM=
X-Received: by 2002:a17:903:2acb:b0:2b2:50f6:cdd9 with SMTP id d9443c01a7336-2b2d59764f9mr197248345ad.8.1776237167209;
        Wed, 15 Apr 2026 00:12:47 -0700 (PDT)
Received: from ?IPv6:2605:8d80:58a1:f9b:2b0e:4f42:1db7:16dc? ([2605:8d80:58a1:f9b:2b0e:4f42:1db7:16dc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826ea53sm10630845ad.52.2026.04.15.00.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 00:12:46 -0700 (PDT)
Message-ID: <16990d86263fb24079e6f0b476a8854ec2366932.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: deduce_bounds_64_from_32 tightening with
 circular range logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Helen Koike <koike@igalia.com>, harishankar.vishwanathan@gmail.com, 
	paul.chaignon@gmail.com, shung-hsi.yu@suse.com
Cc: andrii@kernel.org, yonghong.song@linux.dev, ast@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Date: Wed, 15 Apr 2026 00:12:45 -0700
In-Reply-To: <20260410124035.297632-1-koike@igalia.com>
References: <20260410124035.297632-1-koike@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-10 at 09:40 -0300, Helen Koike wrote:
> Unify handling of signed and unsigned using circular range logic.
>=20
> Signed and unsigned numbers follows the same order in bit
> representation. We can think of it as a clock, were 12h is
> 0x0000_0000 and 11h is 0xFFFF_FFFF, regardless of its sign.
>=20
> Then, instead of dealing with max and min, we deal with a base and len,
> where len =3D max - min.
>=20
> Example:
>     range [-1, 3] is represented by base=3D0xFFFF_FFFF len=3D4
>     since (u32)3 - (u32)-1 is 4.
>=20
> And we can verify if a value v is in range if:
>     (u32)(v - base) <=3D len
> which is true if v is signed -1 or v is unsigned 0xFFFF_FFFF.
>=20
> This automatically handles the wrapping case, discarding the need to
> check if it crosses the signed range or not and handle each case.
>=20
> It also fixes the following current issues:
> * [(u32)umin, (u32)umax] falling outside of [u32_min_value, u32_max_value=
]
> * [(u32)umin, (u32)umax] falling in the gap [(u32)s32_max_value, (u32)s32=
_min_value]
>=20
> Fixes: c51d5ad6543c ("bpf: improve deduction of 64-bit bounds from 32-bit=
 bounds")
> [Circular representation]
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Helen Koike <koike@igalia.com>
>=20
> ---
>=20
> This is a follow-up from discussion:
>   https://lore.kernel.org/all/7fb97184-baaa-4639-a0b9-ac289bf2e54d@igalia=
.com/
>=20
> I didn't tag this as v2 since it is a completely different
> implementation.
>=20
> I did do an implementation[1] without circular range logic, by using
> if/elses blocks, but it feels I'm always missing a corner case and using
> circular range logic feels safer.
>=20
> Eduard, I didn't use the exact code you pointed, since it seems it is
> covered by your RFC, so I used the logic just for this case while your
> RFC doesn't move forward.
>=20
> Please let me know what you think.
>=20
> [1]
> https://github.com/helen-fornazier/linux/commits/bpf-min-max-if-else-solu=
tion/
> (3 last commits)
>=20
> Thanks,
> Helen
> ---
>  kernel/bpf/verifier.c | 77 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 64 insertions(+), 13 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 8c1cf2eb6cbb..2944c17d2b7b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2700,6 +2700,48 @@ static void deduce_bounds_64_from_64(struct bpf_re=
g_state *reg)
>  	}
>  }
> =20
> +/*
> + * Find the smallest v >=3D lo such that (u32)v is in the circular u32 r=
ange
> + * [b_min, b_max] (b_len =3D b_max - b_min wraps naturally for wrapping =
ranges).
> + */
> +static u64 u64_tighten_umin(u64 lo, u64 hi, u32 b_min, u32 b_max)
> +{
> +	u32 b_len =3D b_max - b_min;
> +	u64 a_len =3D hi - lo;
> +	u64 cand;
> +
> +	/* lo32(lo) already in [b_min, b_max]? */
> +	if ((u32)((u32)lo - b_min) <=3D b_len)
> +		return lo;
> +	/* Set lo32 to b_min and check if it's in the range [lo, hi] */
> +	cand =3D (lo & ~(u64)U32_MAX) | b_min;
> +	if (cand - lo <=3D a_len)
> +		return cand;
> +	/* Advance to the next 2^32 block */
> +	return cand + BIT_ULL(32);
> +}

Hi Helen, Harishankar, Shung-Hsi, Paul,

I think this algorithm is correct and covers all cases discussed earlier.
I also prepared simple correctness check using cbmc in [1].
It shows that for any valid input register state deduce_bounds_64_from_32
does not loose any values (check_soundness() function in [1], which validat=
es).
It also shows that there exist invalid input register state,
such that deduce_bounds_64_from_32() "fixes" it to be valid
(check_invalid_preserved() function in [1], which produces a counter-exampl=
e).

Now, the question is whether we want check_invalid_preserved() to hold.
Harishankar is working on an extension to simulate_both_branches_taken()
checking for additional cases of invariant violation.
Disagreement between 64-bit and 32-bit ranges is one of such violations.
The logic in deduce_bounds_64_from_32() can be extracted as "intersect"
function producing a signal describing if intersection actually exist.
So, the question is for Harishankar, would you like to have such
"intersect" function?

[1] https://github.com/eddyz87/deduce-bounds-64-from-32-checks

[...]
