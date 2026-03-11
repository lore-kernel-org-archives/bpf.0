Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB21E8320
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244977; cv=pass; b=UHDRWujI4c71y1SFspgmzgWh6ISaMfT51LdP1VpzBl9V/BEzLvogUi3zwKS+1CTfWXQnRW0Jc76eTRihvIiYj/iKDHj/38jJABASlwlFlR0jlRGKzQOBxvdm6l73PzrXGpv5GCVTL6X1b29jHJByJSzuj4yWrZp/xXN9JS657jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244977; c=relaxed/simple;
	bh=TTGYknl5DMVw66RIprGNex8QxI0DcgJDnPePFyUvgSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bz8MMEdUTCHrEZasja3IdGem+CTJBcSKNogPw4u0zE5EYQz2d5fuwvhdLTYuq52NqLmbMyGBLy/3V4QgDRDFSxB0YaFHY7WhwC1HZnge4vmO2fUbhLTmIVdnXtTAIPp6UsU8nbEO334puwTSC60vrgeJgraiOwZl3VzbNtRFzEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJk+dXwK; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJk+dXwK"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b943b75dc42so877174266b.3
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 09:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773244975; cv=none;
        d=google.com; s=arc-20240605;
        b=k71PdkYSmHZNHTwx3rZzQLtlL1ucR2I0mMT/faKK+fVb2f57MCXKmTbocVXkRLril2
         WX7Yv6tZY7556FdXNj2IRdo7uPK6zmZu3suuwruDOJhtYOaQmTTXDrjJMnQ7INC05Ks0
         w51yQyJey1iyiEB2KQJKdVN5KE9afm+nOZgPYVO+o/GWQpCiLNtB4zCnRoWmBFH9nmuG
         i/qIuOLdNqs/1DWKEDK5IBDOwyrrGvh5tDTmoJJG2IobQlttF/AsStlmWq0De+mIM8cy
         fwnvIpeu88GE4nw5BG2AkzOlFVYQEednJmfELcqCm/5gQExJdOLxM2cz+Pots2MwPeCg
         kz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UAvqaxfPguwjQoaqkzApmgLeUnEZxmw7DGBlz6NQr7k=;
        fh=j/zE8PWHuDEx7y5CIbaDYgRuJvk3iT+O+oymPIfh6/s=;
        b=SLNoKx8PaP5kePI7Ds51KNM8qr9QcrYQbdka1+mJAncJxjykYTjIlt+3aF72h7ORTa
         V3WLmlb+SICgQqcZPpNTaLIOii85lTg/DitOAd0yZ+DoyIptq2xi8+xskL94iXDFMZhV
         b721ngJHUzSUBkkAvlZY7L+MvgzhsosP5blXVBjE2K9tet+3JyDBRTQeyfHyuqU2QdWs
         rNNXO39Y0UJHV2sJVES6bUSIdTwo2o1rnHS/3WAyX8cbjza7G/WS9pK5keBLUS7g4lvA
         pzKhTNBM5q5Ffw9E6eiV8EjmXc+9iJd3JtH5H6MY6ZRIQgYchcqk+ylkzG4O1SL9PJGm
         2ZSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773244975; x=1773849775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAvqaxfPguwjQoaqkzApmgLeUnEZxmw7DGBlz6NQr7k=;
        b=LJk+dXwKiSRqYB3vp3XTUpL3w4DjOP8FKD7KSueVKx32s0QGkdrjvOzKzdifW8MzQj
         fm4XkR4VWvL+OoMavnMC57XhN4BslwTwtkFaX52Sl585gC9ar/vjLeFWtOA13DYF41+5
         1Ns+z7hRCbOGC2ppcA9SmcArrddyG5BQ8nIAzYgppJUeeGNELm0txLOTp3zAslyu4iLV
         YIwpvZBe5/0DIe4lMbIKzs2YFhI/1RBBbKRtzX/1rcIM24izQRs5KbnsClaTfqrgUPwk
         buKTkI//n859RgJeaW2oUV5Z07kWMCMVYGOgzBLThPwrPhQM/Ut1EVvZL0dv6DiiM5UX
         t/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244975; x=1773849775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAvqaxfPguwjQoaqkzApmgLeUnEZxmw7DGBlz6NQr7k=;
        b=J1LQrlCNs2iNSEAhThP8WfdHXK9x/Nr/MZivpiiDVSRMLKHPDHAQUN4TndP+VSVZ+R
         5hQkYP/UwOB6xN9SbaXy2Z/nEYUdDLUWJhBZgiKLEZNArLprt9I/TniEk69o/UzXJUaR
         BHpi8IEQ9LVYOiwha409/PSigohZv/2mxa2rM7kUa86LI+C8sMYnZu1KdWoRqpB7T3Wr
         OQWBftCb1yJGSagtfczKMoxtbRYjNZd5f8wDsXpftMjJA3VWXwMeSqcj6SheuZ8EDJUa
         sB7i8XEA6MihD0eKEo7b8DfPSQJvoY+O3XMIkYOv8WIddyY/NQAIaQ65oijMFiX7D1CE
         6Flw==
X-Forwarded-Encrypted: i=1; AJvYcCUSzDP2B+Rk7v6I7wYZ3DYnvuPv3+ZFtoEn4rjZe4v/H2XJgyOniZ8FDZq6n7yEWJck4KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNUW1zBR4pA38SEPTR+mhLARgfetxU3hoM89O8Uk1U+dv3OK2
	DdFyUPpDCBiv6/MzbDHiTIYCO6dTSfP3ey3MDn/t89UjyQUCH6zNybRjNT+bGZOHB3LGKoHM3qX
	3FzYL451sd4uW0ldhnaZZPVXh6wsgNdE=
X-Gm-Gg: ATEYQzzQUTJceet5oRfTGMmT7cKHdDTaZusABkpiI6R0aa0qjjRsnZEZVldZEG7hnuI
	FqY5cFnSiQchopAhZ9uEDSUXKmXNjrN6QL/3H+gUF3yvqzAWHPq6dsYMUXO0WMHUqXiDnRnCBTa
	6h+QsTuN2Nzyw4yhGsa+TZM8bNAEeoc9oywK9gUNmb84DR4GgpWKZ/YT7BTEl1zMMf5j6q1xJ3B
	tI65KQZ91Q7v2MbD7YWPi+ACyI1FUyGZqrz8/qjz6J6QHl0P0IgPtv/iJbCqCtcA9ZA9+JxexLq
	HDHNJWkccvGCzJ/YXOgqQdM9OngnVQchuDIe+RALefMaUPuWtKd0Q/qVGXZqi/OqMca2ygmVhj8
	NetdSvMKqLBWx9cJe1voJDfcCJw==
X-Received: by 2002:a17:906:fd87:b0:b96:eb58:92bd with SMTP id
 a640c23a62f3a-b972e5aea9dmr196747766b.49.1773244974508; Wed, 11 Mar 2026
 09:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303131453.328674-1-hbathini@linux.ibm.com>
 <CAADnVQKuARvSirPjnTcSifLPunCiKC4Nenq0Mr61GpzbW5WxWg@mail.gmail.com> <bbf6a46c-37e9-4d8d-968e-a99bb12dcc14@linux.ibm.com>
In-Reply-To: <bbf6a46c-37e9-4d8d-968e-a99bb12dcc14@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Mar 2026 09:02:41 -0700
X-Gm-Features: AaiRm50_VeFbt_qfNvj0SBCBDMtHqyGYVr_6h5_paNycvlXuoc5cm8NuE_iIB6Y
Message-ID: <CAADnVQ+4N4WWLxan_qibZ7HmONJyMZaP=RF+a9tMSPoz=0LqkQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: improve test coverage for kfunc call
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Eduard <eddyz87@gmail.com>, Vineet Gupta <vineet.gupta@linux.dev>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:10=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
> >
> >> +
> >> +       /* Check zero-extension */
> >> +       if (val !=3D (unsigned long)a)
> >> +               return 1;
> >> +       /* Check no sign-extension */
> >> +       if (val < 0)
> >> +               return 2;
> >> +
> >> +       val =3D b;
> >> +       if (val !=3D (unsigned long)b)
> >> +               return 3;
> >> +       if (val < 0)
> >> +               return 4;
> >> +
> >> +       val =3D c;
> >> +       if (val !=3D (unsigned long)c)
> >> +               return 5;
> >> +       if (val < 0)
> >> +               return 6;
> >> +
> >> +       return 0;
> >> +}
> >
> > Overall this looks very useful.
> > I would expand with another test where a,b,c are s8,s16,s32.
>
> Slightly different approach but kfunc_call_test4/bpf_kfunc_call_test4
> cover signed arguments already?

Ahh. Then may be tweak it to adopt similar fine grained
error reporting as your bpf_kfunc_call_test5()
or go other way around an collapse all errors the way test4 is doing it.
