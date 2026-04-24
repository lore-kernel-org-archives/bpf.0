Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D99238C3B
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057313; cv=none; b=h7lX3TYoGWZs1d7YGsIJIo3TWBQ9LBsObrDRROGIVs9v82Ra7Ao1G8WSx8g7WL8OykwLhNseRekKOBr/dugeuyGl1Bsy/pNOndpZEdPwLy5xR0S22ieoJjDnXT+i6kqZtBUs2kfr8EoUgpDKredBpK9ZVgvdIgIX6gzSb/24L0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057313; c=relaxed/simple;
	bh=PqFG63PvsX5UFYNxq5zDup7MKsUXBizdshCR4ltY3PI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fi+VQRRjETUAwgmlxiS1XvTWyvmkQsjrnk3n9URCiV1bDIpFFda4rU/vsku+R5JjNlnDD81TyikBEvptydPvCCspY2nGmeGavMnWQbPXLPVZUqOEZ20yr+n3qBak4BhNyJRe0/tt1VuxxNzB7tfG/Roe5RNtFhT+lVluXf3OcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiVqRm81; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiVqRm81"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2dee127b3c5so11546978eec.1
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777057311; x=1777662111; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TOrjKZWvodM2m1dWi23aOnWH7z08V/Wk0Glr0KLJTDY=;
        b=eiVqRm81Vo/n9caLN71saXJyOqwTXuga+Ny3zJg6RhkHejCVB1d3ox8270rXurhAUZ
         Ktriwg3cepOYEwJ+ZbbH5/p0AeroKZj8uE2I2iA3KUuqamvhuWCnK6gIwXYP4J2/zMTN
         9o1I7hxOvmStjh/X+XJZCmhS5UlpdK5D75tfZgf5zf0+Lcf0fSAGR6jczPaSYVaXW0bF
         5jA9K0aJlUjsFepF9pRQG1e/MnEJ5LZJNg7y8b86pKBD3i63cFTGeNH0QVzuSBKZf431
         BaX8ElqYdAp0heEWd3eIPeqPa3NFO3kzbH1uvSRsRTJ7kxRLE0unY7KfGl1GzShI4OU3
         Rdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777057311; x=1777662111;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOrjKZWvodM2m1dWi23aOnWH7z08V/Wk0Glr0KLJTDY=;
        b=aLHxf1YV8FGyxDTg6YVIVCryDj5+nihZZmc1UREty9MWclsls1S35sFUohAktaFH2t
         4gJQiPoz3Yqb8OEnGb/JKNqbikb2YrL5Ipuescsp2HHPNn480dijBQfwbxsiVz4BPJmP
         e/wPSgWusFYmiLjQa0BYL9MrgpsCEnIA6vVMSKWPXMMkhEsdq3YFuLD+Q2u0cB3mJM9C
         3TyqbbW+YHkcyuAnRGELzTMHSTZghARROborFYfbtRIFv65MPCDZHkhUzg6TjK/7JR4p
         hHfW//QqC8YcrH4jH0zMz9kV4TeWvP2BcSlLLKAUkeMINHJL6GV4zTv2pGJJvBsMUozr
         duYg==
X-Forwarded-Encrypted: i=1; AFNElJ8fCLrCA61GHAKEi5lQnWZUA+3gVblucLBKSHxSImek385cXgjAl8cYCWkV6saBvrnO6Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNgKYETe5YuIYed2deTSP9RAIMQdlxJPiHGwiyDbVCe2Jm2mZ
	RIfiJkE98taHKP25ZcY2BXhngJVMq7wBUUOsj0l0QwKB0TB5XTRxxGuV
X-Gm-Gg: AeBDieslvvcxXPuBA+rOjmHqtgUndHJz6ZihnXY5GF0sSQwKye05uNq/PEtMn7z/Yuu
	PNmP4KvhKYDoe7EytMLRwFiQ0TZwkISqDczNE3mASb0/9hmlU3CYtwDIpcMKaZgUzFeSwg2322K
	mryGfeShaMxh6BZNGeph5kb0yl1LckMCW1LBQGlfddJjTfhR4zvqpp3wY1+f/D1UhbVDOlIwFv+
	Dp/QYJsc4tJOUFViIi0YZgVubxp4i9BCxGVDev0wGQ1pA8LZGZDutJDBHxLNANHldwPyoIk2iy7
	mP56NyzcGnITFVJf971ur734puOviJy+m83M2Q6sxGAA1M88FR/p5wNhOs4uU6tQahrfmkj0mD0
	vppAciTqtRrfJ2Ha4gz107QMKxTMRBQbFtF60UF39/uKbHWG8TfPW4nnmWfcOK4ZudD+ZOWh+eD
	JqX3zd8VcwCBids1H5ONq0vMxdkIVwzHaN95eewvZ6Y9fy788PHEnpzzlk4etWnW74kpt/8Hz1n
	n5wvl6Z2MmnGZ78UOOI
X-Received: by 2002:a05:7301:1293:b0:2ea:ed3e:d0b7 with SMTP id 5a478bee46e88-2eaed3ed5f5mr28012eec.18.1777057311236;
        Fri, 24 Apr 2026 12:01:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:92a1:14f3:18de:3c64? ([2620:10d:c090:500::1:b6b2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b944bsm33341339eec.28.2026.04.24.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:01:50 -0700 (PDT)
Message-ID: <c4fb60bafd526ae2d92b86e2250255aef0ba5ee1.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] bpf: replace min/max fields with struct
 cnum{32,64}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, shung-hsi.yu@suse.com, 
	paul.chaignon@gmail.com, harishankar.vishwanathan@gmail.com
Date: Fri, 24 Apr 2026 12:01:48 -0700
In-Reply-To: <DI1GETNIDN91.BJPVEP02OODT@gmail.com>
References: <20260424-cnums-everywhere-rfc-v1-v2-0-57091924c9d7@gmail.com>
	 <DI1GETNIDN91.BJPVEP02OODT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-24 at 07:27 -0700, Alexei Starovoitov wrote:
> On Fri Apr 24, 2026 at 1:17 AM PDT, Eduard Zingerman wrote:
> > This RFC replaces s64, u64, s32, u32 scalar range domains tracked by
> > verifier by a pair of circular numbers (cnums): one for 64-bit domain
> > and another for 32-bit domain. Each cnum represents a range as a
> > single arc on the circular number line, from which signed and unsigned
> > bounds are derived on demand. See also wrapped intervals
> > representation as in [1].
> >=20
> > The use of such representation simplifies arithmetic and conditions
> > handling in verifier.c and allows to express 32 <-> 64 bit deductions
> > in a more mathematically rigorous way.
> >=20
> > [1] https://jorgenavas.github.io/papers/ACM-TOPLAS-wrapped.pdf
> >=20
> > Changelog
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > RFCv1 -> v2:
> > - Dropped RFC tag.
> > - Dropped cnum{32,64}_mul(), too much complexity and no veristat
> >   or selftests gains.
>=20
> Nice. Less complexity the better.
> I think it's also strong signal that _div(), _mod() versions are not
> needed either.

It might be the case, yes.
The 'union' function from RFCv1 would be needed later,
if we plan to build data flow analyses on top of cnums.
I have v3 with fixes in comments on stand-by.
Hope to hear some thoughts from Shung-Hsi, Paul, Harishankar.
