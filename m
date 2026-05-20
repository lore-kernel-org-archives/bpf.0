Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CAC26B756
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292920; cv=none; b=keuAPPxBvUnAZNXEyJ/aN6vPhyCgZkrlQXK68eLn+bcD3QiCvYv+bGA/6Fdf/9ynAi4Q+cmULyjV2FVDuiZFJtbGToXja+heddHgapfSdVFq3EkrP0O4W4MHQawy0rUon4R3DsSm/3fBuuBnsYnjjkDeYZc7i6E8xrnLadJJP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292920; c=relaxed/simple;
	bh=jOXxzxwxRaHbSil7/B/IOXJ+xmBhW5LQG9BaL6Mpbqs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MpQCjS/Ud3AMHnh2HAaZH8lr71sw8xXNAFpkf6XdK9Pc65x59V40yLFPUwvSvjXpQqJJx1SxAEe9msZyZTPox3rut1joiBxArzQS2FaaiMo4+Vn3Wc9Yl4EuugymNK41mqC1jkXIp8zxF8GZ/M+2jeOaXjIRoibAJEH9oXl26aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVOco8NS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVOco8NS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744321F000E9;
	Wed, 20 May 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779292919;
	bh=6CdZUk6yi0q83RDabLP5VF9tKzIJRpu9uIWSDNoHwU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVOco8NSmbHos1ygE8/JuqOralXZiOgpa0TUEasQB0cevwd7DiksON66jupixqVa6
	 W6ejMkSwGgFyDoZ5G+eLESC0GLXCiT18zWt05PBfLZi82KUISn56CAZrabQjKuMJAi
	 kYqA6Oex8aO4ov1Sg2JhEFtVt22UrEjzyBzyAtyIs7YE5NX+X98GYuu0pj4TeFp1MB
	 P9syb0cdNRIBnehF0WRjfHBG3VZmZVhnP6uOHsPkQrPH30nzWSu8f4aJqAyexKnFMg
	 OEt4TkMtViVCRuXz/v921wIFmoc8mJFnx3Oa7LHtnpg4LqrQiioD/QsWsGmdsIJGY9
	 psAJZCTjjVDRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 09/20] unwind_user/sframe: Add support for outermost
 frame indication
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jens Remus" <jremus@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520154004.3845823-10-jremus@linux.ibm.com>
References: <20260520154004.3845823-10-jremus@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 16:01:59 +0000
Message-Id: <20260520160159.744321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The size calculation for SFrame FRE evaluates to just the header s=
ize, incorrectly omitting the size of the datawords because it uses the mut=
ated `dataword_count` variable.
--

commit a8be8d2031245c57fdb06e0cafc371dc3614077c
Author: Jens Remus <jremus@linux.ibm.com>

unwind_user/sframe: Add support for outermost frame indication

This commit adds support for the SFrame outermost frame indication. It
allows an FRE without any offsets to represent an undefined return
address.

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index a38f50a363633..f723c1a32f906 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c

[ ... ]

> @@ -260,6 +271,7 @@ static __always_inline int __read_fre(struct sframe_s=
ection *sec,
>  	if (dataword_count)
>  		return -EINVAL;
> =20
> +done:
>  	fre->size	=3D addr_size + 1 + (dataword_count * dataword_size);

[Severity: High]
This is a pre-existing issue, but does this calculation correctly size the =
FRE?

In __read_fre(), dataword_count is progressively decremented as offsets are
parsed, and it is guaranteed to be 0 at this point due to the check right
above the done label:

    if (dataword_count)
        return -EINVAL;

done:
    fre->size =3D addr_size + 1 + (dataword_count * dataword_size);

Because dataword_count is 0, fre->size evaluates to just the header size,
completely omitting the size of the datawords.

When __find_fre() executes fre_addr +=3D fre->size, it advances the pointer=
 by
this truncated amount. This would cause subsequent iterations to read
misaligned data and potentially break stack unwinding.

I see this was fixed later in the series in commit 9c045164b82cb
("unwind_user/sframe: Separate reading of FRE from reading of FRE data word=
s"),
but noting it here for completeness.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520154004.3845=
823-1-jremus@linux.ibm.com?part=3D9
