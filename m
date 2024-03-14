Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0823CE
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411277; cv=none; b=jfETX50VCGVWMEcLa121jsbaDp1oX37psdmejz0Dp+sfGUcljanqxidMXjeJHWXndA3gR7e+pjaRvlcGg+Pm175PhZQsN+e4R4UhMT3D2xbVCqP8YZ6PdRp0NZrwbl2XS5Eh7BgHtuj4tWJXduJs8MvvYnoWyVqmt6GmoiIimb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411277; c=relaxed/simple;
	bh=zTvUg845h6m7/dTinl8sQQHZMm1T+BR7QOAWBDt8dwM=;
	h=From:Message-ID:Subject:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfB5s3kpy0V7nr8oAgOqGuX4hZya5g3345HnW2G0z36E7lGjGUavcVkJQ715ZHrO9xr8rmQDmYy8t+jTGE+q6OCPywg6YByFvrW7VVkgfkRsxbLrMmcI68ElFXGFTYrddKr//oKgT5nPEgwsYMD1ygnCCqLgI8+xtL+GTz9xaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOgXhiwn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOgXhiwn"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a450bedffdfso82185866b.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710411274; x=1711016074; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bx6LJTXPYGH9CPOiqpWwws3oS3w4MuR87xu9iX8JkdY=;
        b=eOgXhiwnZ2+pKj7hL8I0ezJhsNcSXtkMtXkmpABhU7wOV+B+5VJgVig1kDe5c99SEH
         HufRt5lNKToUcJWy1nrmHmsbwym53VL9Si77E90PZSRXpqvGWUGHpVAZWpeOXQ/PgDxc
         S29yz859V2/0RSmeyI8oFRd8YMb3+OwKElQy/N44QxVjsdWIi7Z7bcmmqGjwG9HhbBvb
         1w3O758FcnH6gVrVtIdwZo6DO8L+j32lgZNWDA0BhexQdfSqD39Awmvlz4cvTTFrH7Ud
         B1UhfQ/aFa3z4foni3xnZSzhTE/m9bpw+Ly6c3ekIlkal9BGmjSoFcheC7GfYXLM9IeT
         BmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710411274; x=1711016074;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:subject:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bx6LJTXPYGH9CPOiqpWwws3oS3w4MuR87xu9iX8JkdY=;
        b=AzPtst1PPc+HyFudmaSKrWFzTeQ2myLMSyECf7mCeMuu/OQsPkh9MwmX/K/S7abUUZ
         ySJTYKyo+QuVNgWvGrwnehMb8AlvoEHGpe3tR1sbDC9PtwFThkxlQ3AfcVkKMBcoZV05
         yyCw6qXN1Kt/1FB6bETMgw5VSO+c6WWhfqyaqQJn5OXx5w0RuQhp/ttxtLQISmzqMrHm
         B2poN+RMViY4fmDYyQHhz+znaemq4lYlYnyQYZuzxgbTPnadiaVBIkLDRltdSqhLz+O8
         1ZcdnyyCPBvLZZ55IXzgagMfeGeaIbXzdB1pQB6Mf/S8ldAvUqxb2+l0bsNMHFjV34i0
         bR9A==
X-Gm-Message-State: AOJu0YzbI4cyTTGZmeJZj//s66ex6LpF58xLMyHzSuPDIo2LkriDw/jS
	uCaNHSaBVtOcdKTlZ/mHoyg7tR3sle6sWk9i7lUgQWwbgrUsBuh4
X-Google-Smtp-Source: AGHT+IFP25NoUjaj5KlhSi6M8vudFmRA2Syr+uB0Sg//aXoJ/e6uh5ogV3dSJ7/Ssu0jJ8xwBJR0uA==
X-Received: by 2002:a17:907:6a0e:b0:a45:e221:44f with SMTP id rf14-20020a1709076a0e00b00a45e221044fmr1075566ejc.36.1710411273696;
        Thu, 14 Mar 2024 03:14:33 -0700 (PDT)
Received: from 192.168.10.34 ([39.45.134.55])
        by smtp.gmail.com with ESMTPSA id jl27-20020a17090775db00b00a45c9945251sm554630ejc.192.2024.03.14.03.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 03:14:33 -0700 (PDT)
From: Muhammad Usama Anjum <musamaanjum@gmail.com>
X-Google-Original-From: Muhammad Usama Anjum <MUsamaAnjum@gmail.com>
Message-ID: <d70edf15e42fe7e75d2ba8ef3a3a8181facab9e6.camel@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] development/troubleshooting workflows for BPF
To: Manu Bretelle <chantr4@gmail.com>, lsf-pc@lists.linux-foundation.org
Cc: bpf@vger.kernel.org
Date: Thu, 14 Mar 2024 15:15:04 +0500
In-Reply-To: <ZeAG7EYG/JwFEYg2@surya>
References: <ZeAG7EYG/JwFEYg2@surya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 20:24 -0800, Manu Bretelle wrote:
> Hi all,
>=20
> Building upon the learnings and knowledge of BPF CI [0], I would like to =
present
> ways that can help developpers make their workflow easier, and improve th=
eir
> development and troubleshooting velocity.
>=20
> While there is probably thousand different ways to get to the same result=
, and
> people may have their personal preferences, I will be presenting an appro=
ach
> which is close to what is used by the CI.
> Feedback and suggestions would be greatly appreciated.
>=20
>=20
> Some topics I have in mind:
>=20
> - Reproducing CI error in CI environemt. Until recently, it was challengi=
ng to
>   Re-using artifacts produced by the CI, how to reproduce
>   the issue within the CI environment, and poke at the system.
I've been looking into the BPF CI. Sometimes vmtest.sh isn't effective
in reproducing the failures from BPF CI. I've shared this info over
the mailing list. But I've not got any response over what should be
done when vmtest.sh doesn't reproduce the same results as the BPF CI.
So if we can discuss what are the possible ways to circumvent this
problem, it would be very beneficial.

> - Building and running tests for a foreign architecture. Method to cross-=
compile
>   and run tests for a foreign architecture.
> - local development workflow. While most people may already have their ow=
n setup,
>   here I am proposing a workflow which is simple and allow for fast itera=
tion.
It would be beneficial as well. vmtest.sh solves some problems. But
there may be even faster way to test regressions?

> - bisecting issues: leveraging bpf selftests and vm testing, how to lever=
age
>   `git bisect run` to "quickly", or at least with less friction, identify=
 a bad
>   commit.
>=20
> Thanks,
>=20
> Manu
>=20
> [0]: https://github.com/kernel-patches/bpf

