Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F43A4F57
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547226; cv=none; b=k0LkpdHhA67cThRZAJeQLtnZB1KVUJ/E0EckjSrGvezjKvPx9lKALDPjxSMNQf/vO5oXVEcrXke0OsYiM5QxWvtyhR25xX1Ak0FGjS9++7uZN199ksOhCZsQwPa+xNWwdxy3opeSdae4fxS0mBr27GGJLKGCogm24shoQjd/kdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547226; c=relaxed/simple;
	bh=RwOeZuDntQiOkufXw34x5v5jQvnOyx6eTCn5k8bUTYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NB54hLMzmygsRgo1Y0otnJb35UHNyX3pLE8Xs5wOlDXQhNx9uNLyXeFdtb+sM/HmemmBDgaowRRNL9JCxOt7HiyhkzTaJbS8bj44iDi26INU8lo82kYjtncax8p8qIb7cGnqEUX9AjRWpe493Z4/rcZVNNGnWzeVzJ8Kk50jnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy0ET4JH; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy0ET4JH"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c175635a33so727405eec.0
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774547221; x=1775152021; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lJlNlfb6ZtTTywDrK0lBlWSOnHP/QihHZy3n9CzlFq8=;
        b=Oy0ET4JHgXUfnwFFj62XF4R65EhVscylRwlp3fqNvdpIe87HSPqAs/52jICrFhD334
         Ij60uqr8m8JVvbjibbKt/ncV6jZSgdYTvlwpL7KUi8MMopZ7mfE39RMRU20iNxoZyt99
         +nK4RXQxdUy0fPGl6MDI7J/WWGckAqn9XOM/QtjMTQdRl+R5fqaBWyIx8voeN8ruaQst
         AgGKIcAgCzE/0d4A3J5uXB1WK1jfhpyGzrOmgkK90boaTLibxNOEGxqLAjEZlDux36w0
         70wmGRy3ndXXvvJdFwyBV8grGOZfvkQQEmLeZOdggmeVrTlffidU9GpUpo/SEDBMuDvz
         Y05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547221; x=1775152021;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJlNlfb6ZtTTywDrK0lBlWSOnHP/QihHZy3n9CzlFq8=;
        b=dkJhU+VVCiHM6QIj2yy/A6fVGRb2/vxMb5ng255cC5BURVzOqeQw3TB9EYkSoLFwTA
         5CtbF0ScN17B6YecnjIJOa3J00NzZ5slzMeKOfPxWRRDXy+aWaTWI+Qb3YX0QhgsuHcM
         zPJKbNiy0PoASaoHgNPrZ+2+7n5ihdr5srYXURHDr3zSoQscz1s2aiLjB5/LIjeBbRWg
         veh9TUCasL7/aZuWDrHc1oIER7ja3ZiChMSRKTN2dIjacuZXyc2YbZFQvYfiJr+Wo3rW
         K6c3Y6PwfzqI0hi32+2jjEjsuQep5yT5va1P4hhwlkKmIiTEI7+iNBXWY5STmbycrXeM
         9Hhg==
X-Gm-Message-State: AOJu0Ywaq/07A37+KN4jMz51a4mW4/3GTXBqTRCPgCATO1gdno0V+D0S
	r4eYl8EkCiwEKQiL+IsS8JU8+eiB68NPq0yHp7xSC8zirfqXGrRWFKdW
X-Gm-Gg: ATEYQzzZowOf6QLjTFTs+MIVeiSTaRrdacuKJdf9H8lJC5G6hy+WMvra7lShiuA+jnF
	kgUsEXQmWtCtkIbDj2Ylcw8pHxDZSd6Kjq08QUGjhH4WBw1ksakKpR/aSbMXPuTCYZTw5H3gc7s
	yuRuZ04g+aHae/qKSjFICMmtNymVwn6l+qyM0Ek/qIjEqGAaIZtgWJysA0vUMt9dEhHWeIyowec
	qjPAWfUxG52nGnxFUjFkxYaU7ret7rNmNd8tWO71XT1aEZ3v/nSfUTNWjrVK4T6BWyuewUszCOP
	VBepOZMnfst7dacjVE2szvhNUvjPcEBnGLo1iHmTjuqYMt/EbswbRd0ZTgawxNIhe6ytQuJ/pG0
	OZ/bJwuJMyeKqcxyKCjrh5UCMbP5st3Qzp6Mt0iGU+l8bQOBe4Oo44RNBVWU2s7SOdtLC4/dMwy
	4wA3GZ0MA06ADZiIOefgJfeMgnSYG9g8E+1Phy9krhZMxv3u7s44dvOVlYB1CgoDBABScHGslVM
	E4AXPX1qqKpDJhA1Dg=
X-Received: by 2002:a05:7300:b505:b0:2be:85d4:4a2a with SMTP id 5a478bee46e88-2c15d252470mr4793486eec.1.1774547221252;
        Thu, 26 Mar 2026 10:47:01 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:4a82:c020:f551:481c? ([2620:10d:c090:500::1:634a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec257b4sm2855941eec.6.2026.03.26.10.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:47:00 -0700 (PDT)
Message-ID: <8373439c3cd675107c5ce55b1675b805fd98a6b5.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 1/4] bpf: representation and basic
 operations on circular numbers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, 	paul.chaignon@gmail.com,
 harishankar.vishwanathan@gmail.com
Date: Thu, 26 Mar 2026 10:46:59 -0700
In-Reply-To: <pptqk4ehfb4zptc6ubd7h7rrup72xkaqzgkdguf25iunp4j4ot@n3ddkhculaok>
References: <20260318-cnum-sync-bounds-v1-0-1f2e455ea711@gmail.com>
	 <20260318-cnum-sync-bounds-v1-1-1f2e455ea711@gmail.com>
	 <pptqk4ehfb4zptc6ubd7h7rrup72xkaqzgkdguf25iunp4j4ot@n3ddkhculaok>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-03-26 at 11:46 +0800, Shung-Hsi Yu wrote:
> On Wed, Mar 18, 2026 at 09:28:58AM -0700, Eduard Zingerman wrote:
> ...
> > + * cnum32: a circular number.
> > + * A unified representation for signed and unsigned ranges.
> > + *
> > + * Assume that a 32-bit range is a circle, with 0 being in the 12 o'cl=
ock
> > + * position, numbers placed sequentially in clockwise order and U32_MA=
X
> > + * in the 11 o'clock position. Signed values map onto the same circle:
> > + * S32_MAX sits at 5 o'clock, S32_MIN sits at 6 o'clock (opposite 0),
> > + * negative values occupy the left half and positive values the right =
half.
> > + *
> > + * @cnum32 represents an arc on this circle drawn clockwise.
> > + * @base corresponds to the first value of the range.
> > + * @size corresponds to the number of integers in the range excluding =
@base.
> > + * (The @base is excluded to avoid integer overflow when representing =
the full
> > + *  0..U32_MAX range, which corresponds to 2^32, which can't be stored=
 in u32).
> > + *
> > + * For example: {U32_MAX, 1} corresponds to signed range [-1, 0],
> > + *              {S32_MAX, 1} corresponds to unsigned range [S32_MAX, S=
32_MIN].
> > + */
> > +struct cnum32 {
> > +	u32 base;
> > +	u32 size;
> > +};
>=20
> Minor note, memory are vague, but despite having 'size' available seems
> to make some calculation easier, I end up finding using 'start' and
> 'end'[1] more intuitive and feel to me less indirection, as well as
> being closer to existing implementation. E.g.
>=20
> ...
> > +/* True if this cnum represents two signed ranges. */
> > +static inline bool FN(srange_overflow)(struct cnum_t cnum)
> > +{
> > +	return FN(contains)(cnum, (ut)ST_MAX) && FN(contains)(cnum, (ut)ST_MI=
N);
>=20
> To check overflow in signed ranges, just do `(sT)end < (sT)start`, which
> should be more familiar to most.

Yes, start/end is what the paper [2] uses as well.
I used 'size' because it was more convenient for intersection
implementation. Don't have a strong opinion here.

[2] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf

>=20
> 1: https://lore.kernel.org/bpf/20231108054611.19531-2-shung-hsi.yu@suse.c=
om/
>=20
> > +}
> ...
