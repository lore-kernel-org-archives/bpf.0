Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE9175A86
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785707659; cv=none; b=q/6d/yFiTpO88sv0QEgFemjNWkWv2PCoVI+AwIdPNeZNDQ6kHAc87iFWIBoyn0La3bpG6R3YbFvShY1XId3eGYMknARaqBM3OXi1VstxCSAg2hahS272hARhXMuIRzvKYvfCDD30rrobG4PvC3QHt5bz805cem6p48dTLiLjdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785707659; c=relaxed/simple;
	bh=d7C/V70OSIGNDmWeVd9D+nvcsX/Dlfk/PN4jqW+PyQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opu1VRkKwPLIBGcSl1EiiJ7R6axW4lhB9WJnCIcAeuLutBqrw4yP/0dofNTfnvf4JdZLZxFf1fsuDMXHYWGorI26SkaglA0DjVEHXrVLxsYRz0oIxUaLTKz0QJ0v10yzCrRZmB08m13P3KKerjioSuHnUuD+4FEe1HpZ5i7DHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEi8kA+m; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEi8kA+m"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cab973140bso33087045ad.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 14:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785707657; x=1786312457; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xdnWYGfEDJHX04SFTSMCs2+AiR77wDG19oQKh+3mOBE=;
        b=sEi8kA+m/hM4ACrj6Uj5EP2chFnuED+qNeLMJ7db/N+IsoBubdq9m1t/gu3S2yNHfo
         Nyt7cdhC8oxzAfu0aaGS+TYztzvo5iX62/8vJFQB4C+UisPxNtSDfpbr0qoGRKQeqe1g
         ihMhitkgaZmIaMk12KoivbL01gSFT7QM1ns9A4FXERgANHuD7tf5L7NfF2YBmSIInjNR
         KPEyi4mhwI+8MvTgfg4qTwzo/z0RWfojVPPokV+AXpyZVTddrQeFI7x/Z7Ubd3ATjnIw
         jUEw5Ei+jjrt5o1H6iKDH9/Xr8/E4MJ2ARavbA8qUb9sVmyhxBIrlloNdjiNEGKzdKVL
         i2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785707657; x=1786312457;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xdnWYGfEDJHX04SFTSMCs2+AiR77wDG19oQKh+3mOBE=;
        b=DcwInze8KO4oZVoKfCjjUUAocmV9ycMb01/JlP0fzqI/JZn+urSdbz4ODQwvxR+Zag
         LfxbzWPvqtHCUYrt7zUoHUejU6/UjcB2XR7Oimh9ZaWfrSXhj2sPpHzyemCqrKjxqmM7
         cgeM6NBmF8xnZpRDWeWpt0AcFkVrpLsG6xqr6OEGmK4DYbUIk/Bbjjm6pUoaAKsfy7GU
         JdiYAJRUVoWoF2uRTjaMW5BYULDIvvslHbQL/wsbWM/MUUq66iY93NDhzYa2qc9vVg6g
         OMPLf6izmgDnkZB3CRg96NmuIelzbUVXZJhYIzgkBA1CemPRbwnXrfjCnkx0vRiITrPC
         7HBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqylDz6OHa6iV7AVTrSUWGu7G6Q8k20Ph3ByykBZPS52YFHW5Upp8Wk3wE0o1/2WZuMcDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJMYrPzQenf5lYTDOnnnpqUeVIea18MwAEhv7OJlRl8wqZ2EE
	y2JJaPIjEOINYTinzLv108TyAhqWJSXGSOh+HhdCls3WDh5iRXyK9mjGUbsyWw==
X-Gm-Gg: AR+sD127DkvC9JUtaGS/3lNlkm3GMIVQ4YljXltw1khl4XlxYaLdpqZjNnXxdU4bAK7
	6QvQSyS8ce38sZ2qU2jpGZgndiWUIQ1zSIofw+qAqMbh9dr4Xm+wDZ1aYkhcZUfQrsL/b+MjqhU
	wFI0U/fGwREt7PPgcn0xdMLuESuI2m6/RPyPCdyCgPOjyVjxP/+ScwlF3gH6i/pwgjlJT+yfW+b
	6fdSeDAXp29ioq5+/WDl534IDcAKuO/OLPoupjxAZR5twPyNika6HErZnGUQlPG809sp1xiY22t
	qWUZleqYS/KUZ9RpgKzAquvyfC0tyionJ0NTcT03SCsCMxOPXNSF89AQpdlikBZ0co8+/XHsGoV
	h2QmeZY/wi9/bCk98FddT4NQW3103AoXmZyJuIGHYqaGw+MNPzvcDyxxCQU5qDtN2UM+/qRo1yh
	Amc5lzn2HSclimCChcRYmptx4WuKLAfV7DvRJg219wJEjFnGkoRr/sx+7qKfVMnU2Yql67lsvvL
	s4Pr7n+U2CKRAeV
X-Received: by 2002:a17:903:1968:b0:2ca:ce91:f027 with SMTP id d9443c01a7336-2d0523c7c20mr72411055ad.36.1785707657005;
        Sun, 02 Aug 2026 14:54:17 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae18934sm28701515ad.11.2026.08.02.14.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:54:16 -0700 (PDT)
Message-ID: <adaaec551f6623758ddc1e31dc5ccab0afdd90ec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Test stack depth stats
 without BTF subprog names
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 02 Aug 2026 14:54:13 -0700
In-Reply-To: <20260801230400.850271-4-memxor@gmail.com>
References: <20260801230400.850271-1-memxor@gmail.com>
	 <20260801230400.850271-4-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-02 at 01:03 +0200, Kumar Kartikeya Dwivedi wrote:

...

> @@ -1559,7 +1560,9 @@ static void do_test_single(struct bpf_test *test, b=
ool unpriv,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test->errstr_unpriv : test->=
errstr;
> =C2=A0
> =C2=A0	opts.expected_attach_type =3D test->expected_attach_type;
> -	if (expected_ret =3D=3D VERBOSE_ACCEPT)
> +	if (test->log_level)
> +		opts.log_level =3D test->log_level;
> +	else if (expected_ret =3D=3D VERBOSE_ACCEPT)
> =C2=A0		opts.log_level =3D 2;

I did this:

          else if (expected_ret =3D=3D VERBOSE_ACCEPT)
  -               opts.log_level =3D 2;
  +               opts.log_level =3D 2 | 4;

And all test_verifier tests passed.
There is no need to a new option.

> =C2=A0	else if (verbose)
> =C2=A0		opts.log_level =3D verif_log_level | 4; /* force stats */

...
