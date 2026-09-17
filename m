Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64233B961
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605031; cv=pass; b=Hf63IeXqbE9J/CrP5ZgNYsBFcZY2I6yiABqQi4/+5VSjdMy4UfMznwF4tE/uFeCFOVzcKuKfVVnTyxKeE3Fh1YJixVh6jQZfSoIMtGMLOiFb5ZRjn8txkLESSBOgRJCdzradot9dUfVZZ0bDa2HNHz9BDRLxXITH/Bk+1BNPZGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605031; c=relaxed/simple;
	bh=tlmyzNUENvNb4Oylh+WHiAZUPw2m3n5RaX0zH+LuxaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjmwY2WYpYUT2GhLDtQi4z7+AFXjPGRvKbJ8syqF2eAaibSEq6OHmF0aFIcecOsiApwkY/UQcOEUGWRjYssNBNFMm5XkpTRmVY2GG4XpPePiwRIS8iPUnmlCohawX/Q+2b2xjNKYTnUPPYCuEzkgtQbs+6GBxvLgA1lR1KaR3QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwNRNE+f; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwNRNE+f"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50db3so140372a12.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789605028; cv=none;
        d=google.com; s=arc-20260327;
        b=MyVn0F0USrvkGzEf5h4Vc2ev6J2izuTf0s+rE5iy7dbcDMX/pWvXU6OYeNk+AVgpuE
         QRfx/bdqiA388MYy7O/rcdnALAlzO6WTby0+pOf7p3GIBkEN4BwtEiJNV1uJv9zSqyFL
         /SV/DCepom/6Mk2bakThcbQT81IFJGKfpEAFyj6bNyDpk41IxD92Km2mNfR2/AbdB+Os
         smkEe3JkAk0YH67x/K7L+atAHpUmLg7XeRFucjGSjHA9xO/Qok3yOq5p9OiTioOSQdn8
         rU1U1T7g0Ze2p/21936DL1o/VWgUHyPiSw8o5LgbOujjro9ATX/EvTTa+bBTFb2XHL5d
         xQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nH+1D62/vONjE3NQ4kwcRmw4ufbdwDd91huhFb0U00k=;
        fh=aodU7cGRFuovoHwg2EUkhM33ix6umCudA7I9EEUsIlI=;
        b=GfiKW6bq/inIdi7er0jS48GhkiSrxxR6u1bfXBZtVo078aeOx08HNg5CsxmDLvHVhv
         z1xv/eUTohJl3HSgN55o2rkNM75Y993jnGLYUtVw+fCtP5lQJi2AMa8e0RrMAxkH58Ls
         zNTwrKkeHTCwvuDrriWUy3ppyKLruUqrMu6H1RxE6Y/XLT+Ja7Fdmq/N2G1MSwlNlNT7
         oU/Bu9/35+sR1iFpcOoXoIukpfG8ES1fG5Y0c3V3q7LQWqQ90QStXVQDDzzSgChvLaBg
         kCJuKpNCw1ooGE+kgfKA76uUWwOq+OqjM0Vn1IDGlzGoq2MAJpRIpVSHH7+obrURNEIq
         +G4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605028; x=1790209828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nH+1D62/vONjE3NQ4kwcRmw4ufbdwDd91huhFb0U00k=;
        b=dwNRNE+fXffgvGxa4RqXa4lLlnsOyFtKkGuNZN7SK5BWz/gxdFJtu/bWmcKESOzV/X
         BYDbDiqxh5nzYYUUCYcwzpicQrH/wGnXmFDnc/K1xfXdZudmru+juKLpZqi1ZtxIwOj6
         dYoshePDwaaUcNMnslK+VbXfvSVp9+NJ7iarRj7V4Oq1vZWYd3yKbLzKSnZqYe8vmT6C
         lGBnE3bNgEe/nPzgAFcxteSPLHw4STStdxgu6oFrRQPQ02jhIjO8rYMPDv4LSkWsY/SU
         cRPVW6ZgQCh657YuDvvw1LqR5fPCH2YrYU5/zif2vlamY9K2SQDLt+WNANFpmeRGbgmh
         gPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605028; x=1790209828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nH+1D62/vONjE3NQ4kwcRmw4ufbdwDd91huhFb0U00k=;
        b=Z4lfm72s5ZEP//jA3lDI21/KnQaLlMrcCXmOovodcMMFhWlvSOfj6qGDJI2NUGR7VX
         a+ZNdcGjWkD50OYE7755msjexWd8EIazN+TfU4mDQuvOUHfzCgqUryxvV5cfrhKfrfeh
         dC1WPBZ9Rfrox0yJavaGI9b4qRxqY34lEvYJnvj3sDFnSojm4s4IErUQfG5aiqeC3Jc9
         a3qi8YbyrOIZ2130K8JxcKOZly8+MQRLWDnjFRhm3aTM5ez8r1aqZYbJS8/amVmBzoBO
         Vopu418XjaaeDganLjCKhST/2hOPnfruOkkYVJ2uItG8kShfS1ve6GSwHCB1B8XIDfFO
         jhgg==
X-Forwarded-Encrypted: i=1; AKwUvBzsgJCyNWvk5mQk3tJnKxxA+UFv1QFWZcBI1Smyt18+gq54lw8nCsbDAiDtmhIJoLF4qgI=@vger.kernel.org
X-Gm-Message-State: AFuF++nA5QcZD4mRVt6BeLS3hduuwSHY6xLQbqwb0YuktPPBTAtWwh8p
	tdMvbY6/CXOclX+Y0kGG6udsUrOmmB1BFC4QsulUqQXI+mJh6QKocepFhVEoHh06IGeKaxOXCjc
	ly5U0ImMxOLhJs12ikr5pKez6nYZ9YL4=
X-Gm-Gg: AYBFou0Mz9Cb/0ciVVsNx7GaQOYv3c7ngt3d/F/xn9egX9pCnrVW3jrfp6kyJUIKNp8
	q+gLMoWQq9yP9NNFDDWd1li/Y7EkF/Crp0tX+DUuRyT2dPd7DHMA/q0/IdCmdL5DgI5rSNGYwh9
	Mezs8CjULCccOqJtRSAd2W9zBnBtkb0Mf5S7TnEB6sJky3CLgr4S5/Fvg7+qZSC7oF5+4ch6u0b
	wTIuUhUQgQCIb5xLOtzZ9g9dfJdKcojbYnoqmmEGpBr6F6JNKwtlY//4cSLgOa4oUVD7SCL84RR
	e9MlKH+Azc7khIXdapTzwBMhUcjc6+msVvTAMypZpJUqiscqDnZIejZQOFiphoovoXItTNsseky
	b9TWrdIrlAZpu3K4Fgd3o2oo/EIKOon5TsYPwnT4Mcg==
X-Received: by 2002:a05:6a21:3315:b0:3d0:9590:7148 with SMTP id
 adf61e73a8af0-3dd5f5d86a1mr12651151637.17.1789605027369; Wed, 16 Sep 2026
 17:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-4-vineet.gupta@linux.dev> <DLDKI0ZXYI7H.1XQZZE2RCU7IF@gmail.com>
 <4ab75099-0e95-4fee-81da-6f4198e3e6a0@linux.dev> <CAADnVQ+N9tzBJ0Bbvp8_8QvR+QcCP4ej5CgV_kRHt=iw4BANSQ@mail.gmail.com>
 <202c45e2-58ba-4ad5-a234-c90703031f91@linux.dev>
In-Reply-To: <202c45e2-58ba-4ad5-a234-c90703031f91@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Sep 2026 17:30:16 -0700
X-Gm-Features: AcwNN1XLUhSaujLVZNDBYUznBk2B1PEMW-Z99HXDCfKhyI83tPo-EfJkONx0oj4
Message-ID: <CAADnVQ+Si9Au8J_j2nt+ZzFq6WPaz8hpmh0n=_dFysZmSOeipA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 03/13] bpf: track low-32 scalar equality
 across zero-extending movs
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 5:08=E2=80=AFPM Vineet Gupta <vineet.gupta@linux.de=
v> wrote:
>
> It ended up with full testsuite run parity - after 4 incremental patches.
> But the pattern of all those patches was adding some predicate /
> special-casing to reg->add_const
>
> hunk 1
>
> -       if (src_reg->add_const)
> +       if (src_reg->add_const && src_reg->delta)

why? It should not.
My point is that zero is not special.
It should be handled within the current framework.
All these extra hunks are not correct.
ADD_CONST_32 logic should work for delta =3D=3D 0 just like
it works for delta =3D=3D 1.
